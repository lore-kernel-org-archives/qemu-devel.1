Received: from eggs.gnu.org ([2001:4830:134:3::10]:33960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fs6lV-0000qz-JA
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:32:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fs6lT-0006yq-A9
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:32:09 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:49356 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fs6lS-0006vP-LR
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:32:06 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 21 Aug 2018 15:31:23 +0200
Message-Id: <1534858316-12945-14-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534858316-12945-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534858316-12945-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v3 13/46] target/mips: Add emulation of nanoMIPS
 16-bit save and restore instructions
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

From: Stefan Markovic <smarkovic@wavecomp.com>

Add emulation of SAVE16 and RESTORE.JRC16 instructions. Routines
gen_save(), gen_restore(), and gen_adjust_sp() are provided to support
this feature.

This patch at the same time provides function gen_op_addr_addi(). This
function will be used in emulation of some other nanoMIPS instructions.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 75f2b64..cf3254b 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -1746,6 +1746,18 @@ static inline void gen_op_addr_add (DisasContext *ctx, TCGv ret, TCGv arg0, TCGv
 #endif
 }
 
+static inline void gen_op_addr_addi(DisasContext *ctx, TCGv ret, TCGv base,
+                                    target_long ofs)
+{
+    tcg_gen_addi_tl(ret, base, ofs);
+
+#if defined(TARGET_MIPS64)
+    if (ctx->hflags & MIPS_HFLAG_AWRAP) {
+        tcg_gen_ext32s_i64(ret, ret);
+    }
+#endif
+}
+
 /* Addresses computation (translation time) */
 static target_long addr_add(DisasContext *ctx, target_long base,
                             target_long offset)
@@ -16770,6 +16782,62 @@ static inline int decode_gpr_gpr4_zero(int r)
 #define NANOMIPS_EXTRACT_RS5(op) (op & 0x1f)
 
 
+static void gen_adjust_sp(DisasContext *ctx, int u)
+{
+    gen_op_addr_addi(ctx, cpu_gpr[29], cpu_gpr[29], u);
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
@@ -17087,6 +17155,21 @@ static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
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
+                gen_compute_branch_nm(ctx, OPC_JR, 2, 31, 0, 0);
+                break;
+            }
+        }
         break;
     case NM_MOVEP:
         break;
-- 
2.7.4
