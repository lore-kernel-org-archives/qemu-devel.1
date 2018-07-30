Received: from eggs.gnu.org ([2001:4830:134:3::10]:36273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fkAuQ-0005p6-95
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:20:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fkAuP-0006vt-5b
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:20:34 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:58126 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fkAuO-0006vX-Pd
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:20:33 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 30 Jul 2018 18:11:58 +0200
Message-Id: <1532967169-22265-26-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v5 25/76] target/mips: Add emulation of
 nanoMIPS 16-bit save and restore instructions
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

From: Matthew Fortune <matthew.fortune@mips.com>

Add emulation of SAVE16 and RESTORE.JRC16 instructions. Routines
gen_save(), gen_restore(), and gen_adjust_sp() are provided for this
purpose.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 2ea90f0..e1cc299 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -16520,6 +16520,65 @@ static inline int decode_gpr_gpr4_zero(int r)
 #define NANOMIPS_EXTRACT_RS5(op) (op & 0x1f)
 
 
+static void gen_adjust_sp(DisasContext *ctx, int u)
+{
+    TCGv tsp = tcg_temp_new();
+    gen_base_offset_addr(ctx, tsp, 29, u);
+    gen_store_gpr(tsp, 29);
+    tcg_temp_free(tsp);
+}
+
+static void gen_save(DisasContext *ctx, uint8_t rt, uint8_t count,
+                     uint8_t gp, uint16_t u)
+{
+    int counter = 0;
+    TCGv va = tcg_temp_new();
+    TCGv t0 = tcg_temp_new();
+
+    while (counter != count) {
+        bool use_gp = gp && (counter == count - 1);
+        int this_rt = use_gp ? 28 : (rt & 0x10) | ((rt + counter) & 0x1f);
+        int this_offset = -((counter + 1) << 2);
+        gen_base_offset_addr(ctx, va, 29, this_offset);
+        gen_load_gpr(t0, this_rt);
+        tcg_gen_qemu_st_tl(t0, va, ctx->mem_idx,
+                           (MO_TEUL | ctx->default_tcg_memop_mask));
+        counter++;
+    }
+
+    /* adjust stack pointer */
+    gen_adjust_sp(ctx, -u);
+
+    tcg_temp_free(t0);
+    tcg_temp_free(va);
+}
+
+static void gen_restore(DisasContext *ctx, uint8_t rt, uint8_t count,
+                        uint8_t gp, uint16_t u)
+{
+    int counter = 0;
+    TCGv va = tcg_temp_new();
+    TCGv t0 = tcg_temp_new();
+
+    while (counter != count) {
+        bool use_gp = gp && (counter == count - 1);
+        int this_rt = use_gp ? 28 : (rt & 0x10) | ((rt + counter) & 0x1f);
+        int this_offset = u - ((counter + 1) << 2);
+        gen_base_offset_addr(ctx, va, 29, this_offset);
+        tcg_gen_qemu_ld_tl(t0, va, ctx->mem_idx, MO_TESL |
+                        ctx->default_tcg_memop_mask);
+        tcg_gen_ext32s_tl(t0, t0);
+        gen_store_gpr(t0, this_rt);
+        counter++;
+    }
+
+    /* adjust stack pointer */
+    gen_adjust_sp(ctx, u);
+
+    tcg_temp_free(t0);
+    tcg_temp_free(va);
+}
+
 static void gen_pool16c_nanomips_insn(DisasContext *ctx)
 {
     int rt = decode_gpr_gpr3(NANOMIPS_EXTRACT_RD(ctx->opcode));
@@ -16835,6 +16894,21 @@ static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
     case NM_P16_SR:
+        {
+            int count = extract32(ctx->opcode, 0, 4);
+            int u = extract32(ctx->opcode, 4, 4) << 4;
+
+            rt = 30 + extract32(ctx->opcode, 9, 1);
+            switch (extract32(ctx->opcode, 8, 1)) {
+            case NM_SAVE16:
+                gen_save(ctx, rt, count, 0, u);
+                break;
+            case NM_RESTORE_JRC16:
+                gen_restore(ctx, rt, count, 0, u);
+                gen_compute_branch(ctx, OPC_JR, 2, 31, 0, 0, 0);
+                break;
+            }
+        }
         break;
     case NM_MOVEP:
         break;
-- 
2.7.4
