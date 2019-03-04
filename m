Received: from eggs.gnu.org ([209.51.188.92]:57185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1h0pIe-000411-LG
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:14:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1h0pIc-0007rc-R1
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:14:40 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:39725 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mateja.marjanovic@rt-rk.com>)
	id 1h0pIc-0007o8-9I
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:14:38 -0500
From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Date: Mon,  4 Mar 2019 16:13:19 +0100
Message-Id: <1551712405-2530-8-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1551712405-2530-1-git-send-email-mateja.marjanovic@rt-rk.com>
References: <1551712405-2530-1-git-send-email-mateja.marjanovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v3 07/13] target/mips: Add emulation of MMI
 instruction PEXEW
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

Add emulation of MMI instruction PEXEW. The emulation is implemented
using TCG front end operations directly to achieve better performance.

Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
---
 target/mips/translate.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 01efcde..f55a0db 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -24721,6 +24721,67 @@ static void gen_mmi_pexeh(DisasContext *ctx)
     }
 }
 
+/*
+ *  PEXEW rd, rt
+ *
+ *  Parallel Exchange Even Word
+ *
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+---------+---------+---------+---------+-----------+
+ *  |    MMI    |0 0 0 0 0|   rt    |   rd    |  PEXEW  |    MMI2   |
+ *  +-----------+---------+---------+---------+---------+-----------+
+ */
+
+static void gen_mmi_pexew(DisasContext *ctx)
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
+        TCGv_i64 t2 = tcg_temp_new();
+        uint64_t mask0 = (1ULL << 32) - 1;
+        uint64_t mask1 = mask0 << 32;
+
+        tcg_gen_movi_i64(t1, 0);
+        tcg_gen_andi_i64(t0, cpu_gpr[rt], mask1);
+        tcg_gen_or_i64(t1, t0, t1);
+        tcg_gen_andi_i64(t0, cpu_mmr[rt], mask0);
+        tcg_gen_shri_i64(t0, t0, 64);
+        tcg_gen_or_i64(t1, t0, t1);
+        tcg_gen_mov_i64(t2, t1);
+
+        tcg_gen_mov_i64(cpu_gpr[rd], t2);
+
+        tcg_gen_movi_i64(t1, 0);
+        tcg_gen_andi_i64(t0, cpu_gpr[rt], mask0);
+        tcg_gen_shli_i64(t0, t0, 64);
+        tcg_gen_or_i64(t1, t0, t1);
+        tcg_gen_andi_i64(t0, cpu_mmr[rt], mask1);
+        tcg_gen_or_i64(t1, t0, t1);
+
+        tcg_gen_mov_i64(cpu_mmr[rd], t1);
+
+        tcg_temp_free(t0);
+        tcg_temp_free(t1);
+        tcg_temp_free(t2);
+    }
+}
+
 #endif
 
 
@@ -27744,7 +27805,6 @@ static void decode_mmi2(CPUMIPSState *env, DisasContext *ctx)
     case MMI_OPC_2_PREVH:     /* TODO: MMI_OPC_2_PREVH */
     case MMI_OPC_2_PMULTH:    /* TODO: MMI_OPC_2_PMULTH */
     case MMI_OPC_2_PDIVBW:    /* TODO: MMI_OPC_2_PDIVBW */
-    case MMI_OPC_2_PEXEW:     /* TODO: MMI_OPC_2_PEXEW */
     case MMI_OPC_2_PROT3W:    /* TODO: MMI_OPC_2_PROT3W */
         generate_exception_end(ctx, EXCP_RI); /* TODO: MMI_OPC_CLASS_MMI2 */
         break;
@@ -27754,6 +27814,9 @@ static void decode_mmi2(CPUMIPSState *env, DisasContext *ctx)
     case MMI_OPC_2_PEXEH:
         gen_mmi_pexeh(ctx);
         break;
+    case MMI_OPC_2_PEXEW:
+        gen_mmi_pexew(ctx);
+        break;
     default:
         MIPS_INVAL("TX79 MMI class MMI2");
         generate_exception_end(ctx, EXCP_RI);
-- 
2.7.4
