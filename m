Received: from eggs.gnu.org ([209.51.188.92]:49759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtQ95-0002n0-9m
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:58:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtQ8n-0001sh-BY
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:58:01 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:46873)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtQ8l-0001h3-RT
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:57:52 -0500
Received: by mail-pf1-x443.google.com with SMTP id g6so673081pfh.13
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 20:57:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Feb 2019 20:57:12 -0800
Message-Id: <20190212045721.28041-16-richard.henderson@linaro.org>
In-Reply-To: <20190212045721.28041-1-richard.henderson@linaro.org>
References: <20190212045721.28041-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 15/24] target/hppa: Convert fp indexed memory
 insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Sven Schnelle <svens@stackframe.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c  | 93 ----------------------------------------
 target/hppa/insns.decode | 21 +++++++++
 2 files changed, 21 insertions(+), 93 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 4ce65bcc61..4ecd522e51 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -855,15 +855,6 @@ static void gen_goto_tb(DisasContext *ctx, int which,
     }
 }
 
-/* PA has a habit of taking the LSB of a field and using that as the sign,
-   with the rest of the field becoming the least significant bits.  */
-static target_sreg low_sextract(uint32_t val, int pos, int len)
-{
-    target_ureg x = -(target_ureg)extract32(val, pos, 1);
-    x = (x << (len - 1)) | extract32(val, pos + 1, len - 1);
-    return x;
-}
-
 static unsigned assemble_rt64(uint32_t insn)
 {
     unsigned r1 = extract32(insn, 6, 1);
@@ -2981,84 +2972,6 @@ static bool trans_ldo(DisasContext *ctx, arg_ldo *a)
     return true;
 }
 
-static bool trans_copr_w(DisasContext *ctx, uint32_t insn)
-{
-    unsigned t0 = extract32(insn, 0, 5);
-    unsigned m = extract32(insn, 5, 1);
-    unsigned t1 = extract32(insn, 6, 1);
-    unsigned ext3 = extract32(insn, 7, 3);
-    /* unsigned cc = extract32(insn, 10, 2); */
-    unsigned i = extract32(insn, 12, 1);
-    unsigned ua = extract32(insn, 13, 1);
-    unsigned sp = extract32(insn, 14, 2);
-    unsigned rx = extract32(insn, 16, 5);
-    unsigned rb = extract32(insn, 21, 5);
-    unsigned rt = t1 * 32 + t0;
-    int modify = (m ? (ua ? -1 : 1) : 0);
-    int disp, scale;
-
-    if (i == 0) {
-        scale = (ua ? 2 : 0);
-        disp = 0;
-        modify = m;
-    } else {
-        disp = low_sextract(rx, 0, 5);
-        scale = 0;
-        rx = 0;
-        modify = (m ? (ua ? -1 : 1) : 0);
-    }
-
-    switch (ext3) {
-    case 0: /* FLDW */
-        do_floadw(ctx, rt, rb, rx, scale, disp, sp, modify);
-        break;
-    case 4: /* FSTW */
-        do_fstorew(ctx, rt, rb, rx, scale, disp, sp, modify);
-        break;
-    default:
-        return gen_illegal(ctx);
-    }
-    return true;
-}
-
-static bool trans_copr_dw(DisasContext *ctx, uint32_t insn)
-{
-    unsigned rt = extract32(insn, 0, 5);
-    unsigned m = extract32(insn, 5, 1);
-    unsigned ext4 = extract32(insn, 6, 4);
-    /* unsigned cc = extract32(insn, 10, 2); */
-    unsigned i = extract32(insn, 12, 1);
-    unsigned ua = extract32(insn, 13, 1);
-    unsigned sp = extract32(insn, 14, 2);
-    unsigned rx = extract32(insn, 16, 5);
-    unsigned rb = extract32(insn, 21, 5);
-    int modify = (m ? (ua ? -1 : 1) : 0);
-    int disp, scale;
-
-    if (i == 0) {
-        scale = (ua ? 3 : 0);
-        disp = 0;
-        modify = m;
-    } else {
-        disp = low_sextract(rx, 0, 5);
-        scale = 0;
-        rx = 0;
-        modify = (m ? (ua ? -1 : 1) : 0);
-    }
-
-    switch (ext4) {
-    case 0: /* FLDD */
-        do_floadd(ctx, rt, rb, rx, scale, disp, sp, modify);
-        break;
-    case 8: /* FSTD */
-        do_fstored(ctx, rt, rb, rx, scale, disp, sp, modify);
-        break;
-    default:
-        return gen_illegal(ctx);
-    }
-    return true;
-}
-
 static bool do_cmpb(DisasContext *ctx, unsigned r, TCGv_reg in1,
                     unsigned c, unsigned f, unsigned n, int disp)
 {
@@ -4211,12 +4124,6 @@ static void translate_one(DisasContext *ctx, uint32_t insn)
 
     opc = extract32(insn, 26, 6);
     switch (opc) {
-    case 0x09:
-        trans_copr_w(ctx, insn);
-        return;
-    case 0x0B:
-        trans_copr_dw(ctx, insn);
-        return;
     case 0x0C:
         translate_table(ctx, insn, table_float_0c);
         return;
diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 40b23823d0..25ac09d9d6 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -38,6 +38,7 @@
 %sm_imm         16:10 !function=expand_sm_imm
 
 %rm64           1:1 16:5
+%rt64           6:1 0:5
 
 %im5_0          0:s1 1:4
 %im5_16         16:s1 17:4
@@ -195,6 +196,26 @@ lda             000011 ..... ..... .. . 0 -- 0110      ......   @ldstx size=2
 sta             000011 ..... ..... .. . 1 -- 1110      ......   @stim5 size=2
 stby            000011 b:5 r:5 sp:2 a:1 1 -- 1100 m:1   .....   disp=%im5_0
 
+@fldstwx        ...... b:5 x:5   sp:2 scale:1 ....... m:1 ..... \
+                &ldst t=%rt64 disp=0 size=2
+@fldstwi        ...... b:5 ..... sp:2 .       ....... .   ..... \
+                &ldst t=%rt64 disp=%im5_16 m=%ma_to_m x=0 scale=0 size=2
+
+fldw            001001 ..... ..... .. . 0 -- 000 . . .....      @fldstwx
+fldw            001001 ..... ..... .. . 1 -- 000 . . .....      @fldstwi
+fstw            001001 ..... ..... .. . 0 -- 100 . . .....      @fldstwx
+fstw            001001 ..... ..... .. . 1 -- 100 . . .....      @fldstwi
+
+@fldstdx        ...... b:5 x:5   sp:2 scale:1 ....... m:1 t:5 \
+                &ldst disp=0 size=3
+@fldstdi        ...... b:5 ..... sp:2 .       ....... .   t:5 \
+                &ldst disp=%im5_16 m=%ma_to_m x=0 scale=0 size=3
+
+fldd            001011 ..... ..... .. . 0 -- 000 0 . .....      @fldstdx
+fldd            001011 ..... ..... .. . 1 -- 000 0 . .....      @fldstdi
+fstd            001011 ..... ..... .. . 0 -- 100 0 . .....      @fldstdx
+fstd            001011 ..... ..... .. . 1 -- 100 0 . .....      @fldstdi
+
 ####
 # Offset Mem
 ####
-- 
2.17.2
