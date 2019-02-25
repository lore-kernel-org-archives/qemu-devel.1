Received: from eggs.gnu.org ([209.51.188.92]:52444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1gyIrR-0000TP-HF
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:12:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1gyIrQ-0003GD-FO
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:12:09 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:53607 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mateja.marjanovic@rt-rk.com>)
	id 1gyIrQ-0002cf-7t
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:12:08 -0500
From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Date: Mon, 25 Feb 2019 17:10:36 +0100
Message-Id: <1551111037-23411-3-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1551111037-23411-1-git-send-email-mateja.marjanovic@rt-rk.com>
References: <1551111037-23411-1-git-send-email-mateja.marjanovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 2/3] target/mips: Add emulation of MMI
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
---
 target/mips/translate.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index a3a5f9b..117a29c 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -24416,6 +24416,44 @@ static void gen_mmi_pcpyh(DisasContext *ctx)
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
+    } else if ((rt == 0) && (rs == 0)) {
+        tcg_gen_movi_i64(cpu_gpr[rt], 0);
+        tcg_gen_movi_i64(cpu_mmr[rt], 0);
+    } else if (rt == 0) {
+        tcg_gen_movi_i64(cpu_gpr[rd], 0);
+        tcg_gen_mov_i64(cpu_mmr[rd], cpu_gpr[rs]);
+    } else if (rs == 0) {
+        tcg_gen_mov_i64(cpu_gpr[rd], cpu_gpr[rt]);
+        tcg_gen_movi_i64(cpu_mmr[rd], 0);
+    } else {
+        tcg_gen_mov_i64(cpu_gpr[rd], cpu_gpr[rt]);
+        tcg_gen_mov_i64(cpu_mmr[rd], cpu_gpr[rs]);
+    }
+}
+
 #endif
 
 
@@ -27430,7 +27468,6 @@ static void decode_mmi2(CPUMIPSState *env, DisasContext *ctx)
     case MMI_OPC_2_PINTH:     /* TODO: MMI_OPC_2_PINTH */
     case MMI_OPC_2_PMULTW:    /* TODO: MMI_OPC_2_PMULTW */
     case MMI_OPC_2_PDIVW:     /* TODO: MMI_OPC_2_PDIVW */
-    case MMI_OPC_2_PCPYLD:    /* TODO: MMI_OPC_2_PCPYLD */
     case MMI_OPC_2_PMADDH:    /* TODO: MMI_OPC_2_PMADDH */
     case MMI_OPC_2_PHMADH:    /* TODO: MMI_OPC_2_PHMADH */
     case MMI_OPC_2_PAND:      /* TODO: MMI_OPC_2_PAND */
@@ -27445,6 +27482,9 @@ static void decode_mmi2(CPUMIPSState *env, DisasContext *ctx)
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
