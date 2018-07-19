Received: from eggs.gnu.org ([208.118.235.92]:52333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1fg8b3-00057C-9f
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 09:05:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1fg8V9-0006Aa-8p
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:58:53 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:57293 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.markovic@rt-rk.com>)
	id 1fg8V8-00069N-JN
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:57:47 -0400
From: Stefan Markovic <stefan.markovic@rt-rk.com>
Date: Thu, 19 Jul 2018 14:54:49 +0200
Message-Id: <1532004912-13899-18-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v3 17/40] target/mips: Implement emulation of
 nanoMIPS EXTW instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: James Hogan <james.hogan@mips.com>

Implement emulation of nanoMIPS EXTW instruction, which is similar to
the MIPS r6 ALIGN instruction, except that it counts the other way and
in bits instead of bytes. We therefore generalise gen_align() into
gen_align_bits() (which counts in bits instead of bytes and optimises
when bits = size of the word), and implement gen_align() and a new
gen_ext() based on that. Since we need to know the word size to check
for when the number of bits == the word size, the opc argument is
replaced with a wordsz argument (either 32 or 64).

Signed-off-by: James Hogan <james.hogan@mips.com>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 53 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 3cff488..29d1f19 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -4723,8 +4723,8 @@ static void gen_lsa(DisasContext *ctx, int opc, int rd, int rs, int rt,
     return;
 }
 
-static void gen_align(DisasContext *ctx, int opc, int rd, int rs, int rt,
-                      int bp)
+static void gen_align_bits(DisasContext *ctx, int wordsz, int rd, int rs,
+                           int rt, int bits)
 {
     TCGv t0;
     if (rd == 0) {
@@ -4732,35 +4732,40 @@ static void gen_align(DisasContext *ctx, int opc, int rd, int rs, int rt,
         return;
     }
     t0 = tcg_temp_new();
-    gen_load_gpr(t0, rt);
-    if (bp == 0) {
-        switch (opc) {
-        case OPC_ALIGN:
+    if (bits == 0 || bits == wordsz) {
+        if (bits == 0) {
+            gen_load_gpr(t0, rt);
+        } else {
+            gen_load_gpr(t0, rs);
+        }
+        switch (wordsz) {
+        case 32:
             tcg_gen_ext32s_tl(cpu_gpr[rd], t0);
             break;
 #if defined(TARGET_MIPS64)
-        case OPC_DALIGN:
+        case 64:
             tcg_gen_mov_tl(cpu_gpr[rd], t0);
             break;
 #endif
         }
     } else {
         TCGv t1 = tcg_temp_new();
+        gen_load_gpr(t0, rt);
         gen_load_gpr(t1, rs);
-        switch (opc) {
-        case OPC_ALIGN:
+        switch (wordsz) {
+        case 32:
             {
                 TCGv_i64 t2 = tcg_temp_new_i64();
                 tcg_gen_concat_tl_i64(t2, t1, t0);
-                tcg_gen_shri_i64(t2, t2, 8 * (4 - bp));
+                tcg_gen_shri_i64(t2, t2, 32 - bits);
                 gen_move_low32(cpu_gpr[rd], t2);
                 tcg_temp_free_i64(t2);
             }
             break;
 #if defined(TARGET_MIPS64)
-        case OPC_DALIGN:
-            tcg_gen_shli_tl(t0, t0, 8 * bp);
-            tcg_gen_shri_tl(t1, t1, 8 * (8 - bp));
+        case 64:
+            tcg_gen_shli_tl(t0, t0, bits);
+            tcg_gen_shri_tl(t1, t1, 64 - bits);
             tcg_gen_or_tl(cpu_gpr[rd], t1, t0);
             break;
 #endif
@@ -4771,6 +4776,18 @@ static void gen_align(DisasContext *ctx, int opc, int rd, int rs, int rt,
     tcg_temp_free(t0);
 }
 
+static void gen_align(DisasContext *ctx, int wordsz, int rd, int rs, int rt,
+                      int bp)
+{
+    gen_align_bits(ctx, wordsz, rd, rs, rt, bp * 8);
+}
+
+static void gen_ext(DisasContext *ctx, int wordsz, int rd, int rs, int rt,
+                    int shift)
+{
+    gen_align_bits(ctx, wordsz, rd, rs, rt, wordsz - shift);
+}
+
 static void gen_bitswap(DisasContext *ctx, int opc, int rd, int rt)
 {
     TCGv t0;
@@ -14233,8 +14250,7 @@ static void decode_micromips32_opc(CPUMIPSState *env, DisasContext *ctx)
             break;
         case ALIGN:
             check_insn(ctx, ISA_MIPS32R6);
-            gen_align(ctx, OPC_ALIGN, rd, rs, rt,
-                      extract32(ctx->opcode, 9, 2));
+            gen_align(ctx, 32, rd, rs, rt, extract32(ctx->opcode, 9, 2));
             break;
         case EXT:
             gen_bitops(ctx, OPC_EXT, rt, rs, rr, rd);
@@ -17363,6 +17379,9 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                 gen_lsa(ctx, OPC_LSA, rd, rs, rt,
                         extract32(ctx->opcode, 9, 2) - 1);
                 break;
+            case NM_EXTW:
+                gen_ext(ctx, 32, rd, rs, rt, extract32(ctx->opcode, 6, 5));
+                break;
             case NM_POOL32AXF:
                 gen_pool32axf_nanomips_insn(env, ctx);
                 break;
@@ -20258,7 +20277,7 @@ static void decode_opc_special3_r6(CPUMIPSState *env, DisasContext *ctx)
             switch (op2) {
             case OPC_ALIGN:
             case OPC_ALIGN_END:
-                gen_align(ctx, OPC_ALIGN, rd, rs, rt, sa & 3);
+                gen_align(ctx, 32, rd, rs, rt, sa & 3);
                 break;
             case OPC_BITSWAP:
                 gen_bitswap(ctx, op2, rd, rt);
@@ -20284,7 +20303,7 @@ static void decode_opc_special3_r6(CPUMIPSState *env, DisasContext *ctx)
             switch (op2) {
             case OPC_DALIGN:
             case OPC_DALIGN_END:
-                gen_align(ctx, OPC_DALIGN, rd, rs, rt, sa & 7);
+                gen_align(ctx, 64, rd, rs, rt, sa & 7);
                 break;
             case OPC_DBITSWAP:
                 gen_bitswap(ctx, op2, rd, rt);
-- 
2.7.4
