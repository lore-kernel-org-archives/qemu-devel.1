Received: from eggs.gnu.org ([209.51.188.92]:34005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gil63-0005iD-Lr
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 14:07:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gil63-0005mU-0O
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 14:06:59 -0500
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:36056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gil62-0005kk-Pw
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 14:06:58 -0500
Date: Sun, 13 Jan 2019 20:06:51 +0100
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <68f0239c8a101f2dd3d86f110f79496db89fb440.1547403692.git.noring@nocrew.org>
References: <cover.1547403692.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1547403692.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH 6/9] target/mips: Support the R5900 SQ
 multimedia instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, "Maciej W. Rozycki" <macro@linux-mips.org>, qemu-devel@nongnu.org

Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
 target/mips/translate.c | 44 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 79505bb6c2..1c7c649d36 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -2628,6 +2628,17 @@ static inline void gen_store_gpr (TCGv t, int reg)
 
 #if defined(TARGET_MIPS64)
 /* 128-bit multimedia register moves. */
+static inline void gen_load_mmr(TCGv_i64 hi, TCGv_i64 lo, int reg)
+{
+    if (reg == 0) {
+        tcg_gen_movi_i64(hi, 0);
+        tcg_gen_movi_i64(lo, 0);
+    } else {
+        tcg_gen_mov_i64(hi, cpu_mmr[reg]);
+        tcg_gen_mov_i64(lo, cpu_gpr[reg]);
+    }
+}
+
 static inline void gen_store_mmr(TCGv_i64 hi, TCGv_i64 lo, int reg)
 {
     if (reg != 0) {
@@ -27512,7 +27523,36 @@ static void gen_mmi_lq(CPUMIPSState *env, DisasContext *ctx)
 
 static void gen_mmi_sq(DisasContext *ctx, int base, int rt, int offset)
 {
-    generate_exception_end(ctx, EXCP_RI);    /* TODO: MMI_OPC_SQ */
+#if !defined(TARGET_MIPS64)
+    generate_exception_end(ctx, EXCP_RI);
+#else
+    TCGv_i64 addr = tcg_temp_new_i64();
+    TCGv_i64 val0 = tcg_temp_new_i64();
+    TCGv_i64 val1 = tcg_temp_new_i64();
+
+    gen_base_offset_addr(ctx, addr, base, offset);
+
+    /*
+     * The least significant four bits of the effective address are
+     * masked to zero, effectively creating an aligned address. No
+     * address exceptions due to alignment are possible.
+     */
+    tcg_gen_andi_i64(addr, addr, ~0xFULL);
+
+#if defined(TARGET_WORDS_BIGENDIAN)
+    gen_load_mmr(val0, val1, rt);
+#else
+    gen_load_mmr(val1, val0, rt);
+#endif
+
+    tcg_gen_qemu_st_i64(val0, addr, ctx->mem_idx, MO_UNALN | MO_64);
+    tcg_gen_addi_i64(addr, addr, 8);
+    tcg_gen_qemu_st_i64(val1, addr, ctx->mem_idx, MO_UNALN | MO_64);
+
+    tcg_temp_free_i64(val1);
+    tcg_temp_free_i64(val0);
+    tcg_temp_free_i64(addr);
+#endif /* defined(TARGET_MIPS64) */
 }
 
 /*
@@ -27540,7 +27580,7 @@ static void decode_mmi_sq(CPUMIPSState *env, DisasContext *ctx)
 {
     int base = extract32(ctx->opcode, 21, 5);
     int rt = extract32(ctx->opcode, 16, 5);
-    int offset = extract32(ctx->opcode, 0, 16);
+    int offset = sextract32(ctx->opcode, 0, 16);
 
 #ifdef CONFIG_USER_ONLY
     uint32_t op1 = MASK_SPECIAL3(ctx->opcode);
-- 
2.19.2
