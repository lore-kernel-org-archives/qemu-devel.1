Received: from eggs.gnu.org ([209.51.188.92]:57094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1h0pIb-0003zA-SM
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:14:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1h0pIa-0007nU-T5
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:14:37 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:39147 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mateja.marjanovic@rt-rk.com>)
	id 1h0pIa-0006L2-Iv
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:14:36 -0500
From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Date: Mon,  4 Mar 2019 16:13:14 +0100
Message-Id: <1551712405-2530-3-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1551712405-2530-1-git-send-email-mateja.marjanovic@rt-rk.com>
References: <1551712405-2530-1-git-send-email-mateja.marjanovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v3 02/13] target/mips: Add emulation of MMI
 instruction PCPYLD
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

Add emulation of MMI instruction PCPYLD. The emulation is implemented
using TCG front end operations directly to achieve better performance.

Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
---
 target/mips/translate.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index c62787d..4756bbb 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -24410,6 +24410,45 @@ static void gen_mmi_pcpyh(DisasContext *ctx)
     }
 }
 
+/*
+ *  PCPYLD rd, rs, rt
+ *
+ *    Parallel Copy Lower Doubleword
+ *
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+---------+---------+---------+---------+-----------+
+ *  |    MMI    |   rs    |   rt    |   rd    | PCPYLD  |    MMI2   |
+ *  +-----------+---------+---------+---------+---------+-----------+
+ */
+static void gen_mmi_pcpyld(DisasContext *ctx)
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
+            tcg_gen_movi_i64(cpu_mmr[rd], 0);
+        } else {
+            tcg_gen_mov_i64(cpu_mmr[rd], cpu_gpr[rs]);
+        }
+        if (rt == 0) {
+            tcg_gen_movi_i64(cpu_gpr[rd], 0);
+        } else {
+            if (rd != rt) {
+                tcg_gen_mov_i64(cpu_gpr[rd], cpu_gpr[rt]);
+            }
+        }
+    }
+}
+
 #endif
 
 
@@ -27424,7 +27463,6 @@ static void decode_mmi2(CPUMIPSState *env, DisasContext *ctx)
     case MMI_OPC_2_PINTH:     /* TODO: MMI_OPC_2_PINTH */
     case MMI_OPC_2_PMULTW:    /* TODO: MMI_OPC_2_PMULTW */
     case MMI_OPC_2_PDIVW:     /* TODO: MMI_OPC_2_PDIVW */
-    case MMI_OPC_2_PCPYLD:    /* TODO: MMI_OPC_2_PCPYLD */
     case MMI_OPC_2_PMADDH:    /* TODO: MMI_OPC_2_PMADDH */
     case MMI_OPC_2_PHMADH:    /* TODO: MMI_OPC_2_PHMADH */
     case MMI_OPC_2_PAND:      /* TODO: MMI_OPC_2_PAND */
@@ -27439,6 +27477,9 @@ static void decode_mmi2(CPUMIPSState *env, DisasContext *ctx)
     case MMI_OPC_2_PROT3W:    /* TODO: MMI_OPC_2_PROT3W */
         generate_exception_end(ctx, EXCP_RI); /* TODO: MMI_OPC_CLASS_MMI2 */
         break;
+    case MMI_OPC_2_PCPYLD:
+        gen_mmi_pcpyld(ctx);
+        break;
     default:
         MIPS_INVAL("TX79 MMI class MMI2");
         generate_exception_end(ctx, EXCP_RI);
-- 
2.7.4
