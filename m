Received: from eggs.gnu.org ([209.51.188.92]:57076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1gyblu-0007Bv-FT
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 07:23:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1gyblr-00071s-EM
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 07:23:42 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:43454 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mateja.marjanovic@rt-rk.com>)
	id 1gybln-0006wt-ML
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 07:23:37 -0500
From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Date: Tue, 26 Feb 2019 13:23:15 +0100
Message-Id: <1551183797-13570-5-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1551183797-13570-1-git-send-email-mateja.marjanovic@rt-rk.com>
References: <1551183797-13570-1-git-send-email-mateja.marjanovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v2 4/6] target/mips: Add emulation of MMI
 instruction PCPYUD
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

Add emulation of MMI instruction PCPYUD. The emulation is implemented
using TCG front end operations directly to achieve better performance.

Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
---
 target/mips/translate.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 7c26a43..dd90178 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -24449,6 +24449,45 @@ static void gen_mmi_pcpyld(DisasContext *ctx)
     }
 }
 
+/*
+ *  PCPYUD rd, rs, rt
+ *
+ *    Parallel Copy Upper Doubleword
+ *
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+---------+---------+---------+---------+-----------+
+ *  |    MMI    |   rs    |   rt    |   rd    | PCPYUD  |    MMI3   |
+ *  +-----------+---------+---------+---------+---------+-----------+
+ */
+static void gen_mmi_pcpyud(DisasContext *ctx)
+{
+    uint32_t rs, rt, rd;
+    uint32_t opcode;
+
+    opcode = ctx->opcode;
+
+    rs = extract32(opcode, 21, 5);
+    rt = extract32(opcode, 16, 5);
+    rd = extract32(opcode, 11, 5);
+
+    if (rd == 0) {
+        /* nop */
+    } else {
+        if (rs == 0) {
+            tcg_gen_movi_i64(cpu_gpr[rd], 0);
+        } else {
+            tcg_gen_mov_i64(cpu_gpr[rd], cpu_mmr[rs]);
+        }
+        if (rt == 0) {
+            tcg_gen_movi_i64(cpu_mmr[rd], 0);
+        } else {
+            if (rd != rt) {
+                tcg_gen_mov_i64(cpu_mmr[rd], cpu_mmr[rt]);
+            }
+        }
+    }
+}
+
 #endif
 
 
@@ -27499,7 +27538,6 @@ static void decode_mmi3(CPUMIPSState *env, DisasContext *ctx)
     case MMI_OPC_3_PINTEH:     /* TODO: MMI_OPC_3_PINTEH */
     case MMI_OPC_3_PMULTUW:    /* TODO: MMI_OPC_3_PMULTUW */
     case MMI_OPC_3_PDIVUW:     /* TODO: MMI_OPC_3_PDIVUW */
-    case MMI_OPC_3_PCPYUD:     /* TODO: MMI_OPC_3_PCPYUD */
     case MMI_OPC_3_POR:        /* TODO: MMI_OPC_3_POR */
     case MMI_OPC_3_PNOR:       /* TODO: MMI_OPC_3_PNOR */
     case MMI_OPC_3_PEXCH:      /* TODO: MMI_OPC_3_PEXCH */
@@ -27509,6 +27547,9 @@ static void decode_mmi3(CPUMIPSState *env, DisasContext *ctx)
     case MMI_OPC_3_PCPYH:
         gen_mmi_pcpyh(ctx);
         break;
+    case MMI_OPC_3_PCPYUD:
+        gen_mmi_pcpyud(ctx);
+        break;
     default:
         MIPS_INVAL("TX79 MMI class MMI3");
         generate_exception_end(ctx, EXCP_RI);
-- 
2.7.4
