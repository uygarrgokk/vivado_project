`timescale 1ns / 1ps

module Memory_tb;

    reg [7:0] address;
    reg [7:0] data_in;
    reg wr;
    reg cs;
    reg clock;
    wire [7:0] data_out;

    // RAM modülünü bağla
    Memory uut (
        .address(address),
        .data(data_in),
        .wr(wr),
        .cs(cs),
        .clock(clock),
        .o(data_out)
    );

    // Saat sinyali üret (her 5 ns’de bir değişsin = 10 ns clock periodu)
    always #5 clock = ~clock;

    initial begin
        // Başlangıç değerleri
        address = 8'd0;
        data_in = 8'd0;
        wr = 0;
        cs = 1;
        clock = 0;

        // Biraz bekle (10 ns)
        #10;

        // 1) RAM'den okuma denemesi
        cs = 0; wr = 0; address = 8'd5; // 5. adresin içeriğini oku
        #10;
        $display("Read from address 5: %h", data_out);

        // 2) RAM'e yazma işlemi
        wr = 1; data_in = 8'hAB; address = 8'd10;
        #10;
        wr = 0; // Yazmayı bitir

        // 3) Aynı adresten okuma
        #10;
        address = 8'd10;
        #10;
        $display("Read from address 10 after write: %h", data_out);

        // 4) Bitir
        #20;
        $finish;
    end

endmodule
