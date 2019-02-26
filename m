Received: from eggs.gnu.org ([209.51.188.92]:57120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1gyblv-0007Cm-PZ
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 07:23:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1gyblu-00073P-Qq
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 07:23:43 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:43347 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mateja.marjanovic@rt-rk.com>)
	id 1gyblu-0006wj-FD
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 07:23:42 -0500
From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Date: Tue, 26 Feb 2019 13:23:13 +0100
Message-Id: <1551183797-13570-3-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1551183797-13570-1-git-send-email-mateja.marjanovic@rt-rk.com>
References: <1551183797-13570-1-git-send-email-mateja.marjanovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v2 2/6] target/mips: Add emulation of MMI
 instruction PCPYH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com

From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>

Add emulation of MMI instruction PCPYH. The emulation is implemented
using TCG front end operations directly to achieve better performance.

Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
---
 target/mips/translate.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 332ff79..0d648b6 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -24348,6 +24348,68 @@ static void decode_opc_special(CPUMIPSState *env, DisasContext *ctx)
  *                    PEXTUB
  */
 
+/*
+ *  PCPYH rd, rt
+ *
+ *    Parallel Copy Halfword
+ *
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+---------+---------+---------+---------+-----------+
+ *  |    MMI    |0 0 0 0 0|   rt    |   rd    |  PCPYH  |    MMI3   |
+ *  +-----------+---------+---------+---------+---------+-----------+
+ */
+static void gen_mmi_pcpyh(DisasContext *ctx)
+{
+    uint32_t pd, rt, rd;
+    uint32_t opcode;
+
+    opcode = ctx->opcode;
+
+    pd = extract32(opcode, 21, 5);
+    rt = extract32(opcode, 16, 5);
+    rd = extract32(opcode, 11, 5);
+
+    if (unlikely(pd != 0)) {
+        generate_exception_end(ctx, EXCP_RI);
+    } else if (rd == 0) {
+        /* nop */
+    } else if (rt == 0) {
+        tcg_gen_movi_i64(cpu_gpr[rd], 0);
+        tcg_gen_movi_i64(cpu_mmr[rd], 0);
+    } else {
+        TCGv_i64 t0 = tcg_temp_new();
+        TCGv_i64 t1 = tcg_temp_new();
+        uint64_t mask = (1ULL << 16) - 1;
+
+        tcg_gen_andi_i64(t0, cpu_gpr[rt], mask);
+        tcg_gen_movi_i64(t1, 0);
+        tcg_gen_or_i64(t1, t0, t1);
+        tcg_gen_shli_i64(t0, t0, 16);
+        tcg_gen_or_i64(t1, t0, t1);
+        tcg_gen_shli_i64(t0, t0, 16);
+        tcg_gen_or_i64(t1, t0, t1);
+        tcg_gen_shli_i64(t0, t0, 16);
+        tcg_gen_or_i64(t1, t0, t1);
+
+        tcg_gen_mov_i64(cpu_gpr[rd], t1);
+
+        tcg_gen_andi_i64(t0, cpu_mmr[rt], mask);
+        tcg_gen_movi_i64(t1, 0);
+        tcg_gen_or_i64(t1, t0, t1);
+        tcg_gen_shli_i64(t0, t0, 16);
+        tcg_gen_or_i64(t1, t0, t1);
+        tcg_gen_shli_i64(t0, t0, 16);
+        tcg_gen_or_i64(t1, t0, t1);
+        tcg_gen_shli_i64(t0, t0, 16);
+        tcg_gen_or_i64(t1, t0, t1);
+
+        tcg_gen_mov_i64(cpu_mmr[rd], t1);
+
+        tcg_temp_free(t0);
+        tcg_temp_free(t1);
+    }
+}
+
 #endif
 
 
@@ -27400,10 +27462,12 @@ static void decode_mmi3(CPUMIPSState *env, DisasContext *ctx)
     case MMI_OPC_3_POR:        /* TODO: MMI_OPC_3_POR */
     case MMI_OPC_3_PNOR:       /* TODO: MMI_OPC_3_PNOR */
     case MMI_OPC_3_PEXCH:      /* TODO: MMI_OPC_3_PEXCH */
-    case MMI_OPC_3_PCPYH:      /* TODO: MMI_OPC_3_PCPYH */
     case MMI_OPC_3_PEXCW:      /* TODO: MMI_OPC_3_PEXCW */
         generate_exception_end(ctx, EXCP_RI); /* TODO: MMI_OPC_CLASS_MMI3 */
         break;
+    case MMI_OPC_3_PCPYH:
+        gen_mmi_pcpyh(ctx);
+        break;
     default:
         MIPS_INVAL("TX79 MMI class MMI3");
         generate_exception_end(ctx, EXCP_RI);
-- 
2.7.4
