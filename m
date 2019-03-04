Received: from eggs.gnu.org ([209.51.188.92]:57169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1h0pIe-00040j-93
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:14:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1h0pIc-0007qs-Kk
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:14:40 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:39731 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mateja.marjanovic@rt-rk.com>)
	id 1h0pIc-0007oF-5P
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:14:38 -0500
From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Date: Mon,  4 Mar 2019 16:13:20 +0100
Message-Id: <1551712405-2530-9-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1551712405-2530-1-git-send-email-mateja.marjanovic@rt-rk.com>
References: <1551712405-2530-1-git-send-email-mateja.marjanovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v3 08/13] target/mips: Add emulation of MMI
 instruction PEXTLB
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

Add emulation of MMI instruction PEXTLB. The emulation is implemented
using TCG front end operations directly to achieve better performance.

Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
---
 target/mips/translate.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 95 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index f55a0db..e84262f 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -24782,6 +24782,98 @@ static void gen_mmi_pexew(DisasContext *ctx)
     }
 }
 
+/*
+ *  PEXTLB rd, rs, rt
+ *
+ *  Parallel Extend Lower from Byte
+ *
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+---------+---------+---------+---------+-----------+
+ *  |    MMI    |    rs   |   rt    |   rd    | PEXTLB  |    MMI0   |
+ *  +-----------+---------+---------+---------+---------+-----------+
+ */
+
+static void gen_mmi_pextlb(DisasContext *ctx)
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
+        TCGv_i64 t0 = tcg_temp_new();
+        TCGv_i64 t1 = tcg_temp_new();
+        uint64_t mask = ((1ULL << 8) - 1) << 56;
+
+        tcg_gen_movi_i64(t1, 0);
+        tcg_gen_andi_i64(t0, cpu_gpr[rs], mask);
+        tcg_gen_or_i64(t1, t0, t1);
+        tcg_gen_andi_i64(t0, cpu_gpr[rt], mask);
+        tcg_gen_shri_i64(t0, t0, 8);
+        tcg_gen_or_i64(t1, t0, t1);
+        mask >>= 8;
+        tcg_gen_andi_i64(t0, cpu_gpr[rs], mask);
+        tcg_gen_or_i64(t1, t0, t1);
+        tcg_gen_andi_i64(t0, cpu_gpr[rt], mask);
+        tcg_gen_shri_i64(t0, t0, 8);
+        tcg_gen_or_i64(t1, t0, t1);
+        mask >>= 8;
+        tcg_gen_movi_i64(t1, 0);
+        tcg_gen_andi_i64(t0, cpu_gpr[rs], mask);
+        tcg_gen_or_i64(t1, t0, t1);
+        tcg_gen_andi_i64(t0, cpu_gpr[rt], mask);
+        tcg_gen_shri_i64(t0, t0, 8);
+        tcg_gen_or_i64(t1, t0, t1);
+        mask >>= 8;
+        tcg_gen_andi_i64(t0, cpu_gpr[rs], mask);
+        tcg_gen_or_i64(t1, t0, t1);
+        tcg_gen_andi_i64(t0, cpu_gpr[rt], mask);
+        tcg_gen_shri_i64(t0, t0, 8);
+        tcg_gen_or_i64(t1, t0, t1);
+
+        tcg_gen_mov_i64(cpu_mmr[rd], t1);
+
+        mask >>= 8;
+        tcg_gen_movi_i64(t1, 0);
+        tcg_gen_movi_i64(t1, 0);
+        tcg_gen_andi_i64(t0, cpu_gpr[rs], mask);
+        tcg_gen_or_i64(t1, t0, t1);
+        tcg_gen_andi_i64(t0, cpu_gpr[rt], mask);
+        tcg_gen_shri_i64(t0, t0, 8);
+        tcg_gen_or_i64(t1, t0, t1);
+        mask >>= 8;
+        tcg_gen_andi_i64(t0, cpu_gpr[rs], mask);
+        tcg_gen_or_i64(t1, t0, t1);
+        tcg_gen_andi_i64(t0, cpu_gpr[rt], mask);
+        tcg_gen_shri_i64(t0, t0, 8);
+        tcg_gen_or_i64(t1, t0, t1);
+        mask >>= 8;
+        tcg_gen_movi_i64(t1, 0);
+        tcg_gen_andi_i64(t0, cpu_gpr[rs], mask);
+        tcg_gen_or_i64(t1, t0, t1);
+        tcg_gen_andi_i64(t0, cpu_gpr[rt], mask);
+        tcg_gen_shri_i64(t0, t0, 8);
+        tcg_gen_or_i64(t1, t0, t1);
+        mask >>= 8;
+        tcg_gen_andi_i64(t0, cpu_gpr[rs], mask);
+        tcg_gen_or_i64(t1, t0, t1);
+        tcg_gen_andi_i64(t0, cpu_gpr[rt], mask);
+        tcg_gen_shri_i64(t0, t0, 8);
+        tcg_gen_or_i64(t1, t0, t1);
+
+        tcg_gen_mov_i64(cpu_gpr[rd], t1);
+
+        tcg_temp_free(t0);
+        tcg_temp_free(t1);
+    }
+}
+
 #endif
 
 
@@ -27737,12 +27829,14 @@ static void decode_mmi0(CPUMIPSState *env, DisasContext *ctx)
     case MMI_OPC_0_PPACH:     /* TODO: MMI_OPC_0_PPACH */
     case MMI_OPC_0_PADDSB:    /* TODO: MMI_OPC_0_PADDSB */
     case MMI_OPC_0_PSUBSB:    /* TODO: MMI_OPC_0_PSUBSB */
-    case MMI_OPC_0_PEXTLB:    /* TODO: MMI_OPC_0_PEXTLB */
     case MMI_OPC_0_PPACB:     /* TODO: MMI_OPC_0_PPACB */
     case MMI_OPC_0_PEXT5:     /* TODO: MMI_OPC_0_PEXT5 */
     case MMI_OPC_0_PPAC5:     /* TODO: MMI_OPC_0_PPAC5 */
         generate_exception_end(ctx, EXCP_RI); /* TODO: MMI_OPC_CLASS_MMI0 */
         break;
+   case MMI_OPC_0_PEXTLB:
+        gen_mmi_pextlb(ctx);
+        break;
     default:
         MIPS_INVAL("TX79 MMI class MMI0");
         generate_exception_end(ctx, EXCP_RI);
-- 
2.7.4
