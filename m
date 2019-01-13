Received: from eggs.gnu.org ([209.51.188.92]:33850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gil5D-0005H6-JS
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 14:06:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gil5C-0005Po-Nk
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 14:06:07 -0500
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:55532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gil5B-0005P8-Tc
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 14:06:06 -0500
Date: Sun, 13 Jan 2019 20:05:54 +0100
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <bdfb203a65eb6d4bcdce613e7ac00d831e38de60.1547403692.git.noring@nocrew.org>
References: <cover.1547403692.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1547403692.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH 5/9] target/mips: Support the R5900 LQ
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
 target/mips/translate.c | 46 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 8c350729bc..79505bb6c2 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -2626,6 +2626,17 @@ static inline void gen_store_gpr (TCGv t, int reg)
         tcg_gen_mov_tl(cpu_gpr[reg], t);
 }
 
+#if defined(TARGET_MIPS64)
+/* 128-bit multimedia register moves. */
+static inline void gen_store_mmr(TCGv_i64 hi, TCGv_i64 lo, int reg)
+{
+    if (reg != 0) {
+        tcg_gen_mov_i64(cpu_mmr[reg], hi);
+        tcg_gen_mov_i64(cpu_gpr[reg], lo);
+    }
+}
+#endif /* defined(TARGET_MIPS64) */
+
 /* Moves to/from shadow registers. */
 static inline void gen_load_srsgpr (int from, int to)
 {
@@ -27463,7 +27474,40 @@ static void decode_mmi(CPUMIPSState *env, DisasContext *ctx)
 
 static void gen_mmi_lq(CPUMIPSState *env, DisasContext *ctx)
 {
-    generate_exception_end(ctx, EXCP_RI);    /* TODO: MMI_OPC_LQ */
+#if !defined(TARGET_MIPS64)
+    generate_exception_end(ctx, EXCP_RI);
+#else
+    int base = extract32(ctx->opcode, 21, 5);
+    int rt = extract32(ctx->opcode, 16, 5);
+    int offset = sextract32(ctx->opcode, 0, 16);
+
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
+    tcg_gen_qemu_ld_i64(val0, addr, ctx->mem_idx, MO_UNALN | MO_64);
+    tcg_gen_addi_i64(addr, addr, 8);
+    tcg_gen_qemu_ld_i64(val1, addr, ctx->mem_idx, MO_UNALN | MO_64);
+
+#if defined(TARGET_WORDS_BIGENDIAN)
+    gen_store_mmr(val0, val1, rt);
+#else
+    gen_store_mmr(val1, val0, rt);
+#endif
+
+    tcg_temp_free_i64(val1);
+    tcg_temp_free_i64(val0);
+    tcg_temp_free_i64(addr);
+#endif /* defined(TARGET_MIPS64) */
 }
 
 static void gen_mmi_sq(DisasContext *ctx, int base, int rt, int offset)
-- 
2.19.2
