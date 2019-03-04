Received: from eggs.gnu.org ([209.51.188.92]:57172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1h0pIe-00040k-9d
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:14:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1h0pIc-0007r7-O6
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:14:40 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:39727 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mateja.marjanovic@rt-rk.com>)
	id 1h0pIc-0007o9-7q
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:14:38 -0500
From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Date: Mon,  4 Mar 2019 16:13:21 +0100
Message-Id: <1551712405-2530-10-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1551712405-2530-1-git-send-email-mateja.marjanovic@rt-rk.com>
References: <1551712405-2530-1-git-send-email-mateja.marjanovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v3 09/13] target/mips: Add emulation of MMI
 instruction PEXTLH
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

Add emulation of MMI instruction PEXTLH. The emulation is implemented
using TCG front end operations directly to achieve better performance.

Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
---
 target/mips/translate.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index e84262f..5c2fc07 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -24874,6 +24874,72 @@ static void gen_mmi_pextlb(DisasContext *ctx)
     }
 }
 
+/*
+ *  PEXTLH rd, rs, rt
+ *
+ *  Parallel Extend Lower from Halfword
+ *
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+---------+---------+---------+---------+-----------+
+ *  |    MMI    |    rs   |   rt    |   rd    | PEXTLH  |    MMI0   |
+ *  +-----------+---------+---------+---------+---------+-----------+
+ */
+
+static void gen_mmi_pextlh(DisasContext *ctx)
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
+        uint64_t mask = ((1ULL << 16) - 1) << 48;
+
+        tcg_gen_movi_i64(t1, 0);
+        tcg_gen_andi_i64(t0, cpu_gpr[rs], mask);
+        tcg_gen_or_i64(t1, t0, t1);
+        tcg_gen_andi_i64(t0, cpu_gpr[rt], mask);
+        tcg_gen_shri_i64(t0, t0, 16);
+        tcg_gen_or_i64(t1, t0, t1);
+        mask >>= 16;
+        tcg_gen_andi_i64(t0, cpu_gpr[rs], mask);
+        tcg_gen_or_i64(t1, t0, t1);
+        tcg_gen_andi_i64(t0, cpu_gpr[rt], mask);
+        tcg_gen_shri_i64(t0, t0, 16);
+        tcg_gen_or_i64(t1, t0, t1);
+
+        tcg_gen_mov_i64(cpu_mmr[rd], t1);
+
+        mask >>= 16;
+        tcg_gen_movi_i64(t1, 0);
+        tcg_gen_andi_i64(t0, cpu_gpr[rs], mask);
+        tcg_gen_or_i64(t1, t0, t1);
+        tcg_gen_andi_i64(t0, cpu_gpr[rt], mask);
+        tcg_gen_shri_i64(t0, t0, 16);
+        tcg_gen_or_i64(t1, t0, t1);
+        mask >>= 16;
+        tcg_gen_andi_i64(t0, cpu_gpr[rs], mask);
+        tcg_gen_or_i64(t1, t0, t1);
+        tcg_gen_andi_i64(t0, cpu_gpr[rt], mask);
+        tcg_gen_shri_i64(t0, t0, 16);
+        tcg_gen_or_i64(t1, t0, t1);
+        mask >>= 16;
+
+        tcg_gen_mov_i64(cpu_gpr[rd], t1);
+
+        tcg_temp_free(t0);
+        tcg_temp_free(t1);
+    }
+}
+
 #endif
 
 
@@ -27825,7 +27891,6 @@ static void decode_mmi0(CPUMIPSState *env, DisasContext *ctx)
     case MMI_OPC_0_PPACW:     /* TODO: MMI_OPC_0_PPACW */
     case MMI_OPC_0_PADDSH:    /* TODO: MMI_OPC_0_PADDSH */
     case MMI_OPC_0_PSUBSH:    /* TODO: MMI_OPC_0_PSUBSH */
-    case MMI_OPC_0_PEXTLH:    /* TODO: MMI_OPC_0_PEXTLH */
     case MMI_OPC_0_PPACH:     /* TODO: MMI_OPC_0_PPACH */
     case MMI_OPC_0_PADDSB:    /* TODO: MMI_OPC_0_PADDSB */
     case MMI_OPC_0_PSUBSB:    /* TODO: MMI_OPC_0_PSUBSB */
@@ -27837,6 +27902,9 @@ static void decode_mmi0(CPUMIPSState *env, DisasContext *ctx)
    case MMI_OPC_0_PEXTLB:
         gen_mmi_pextlb(ctx);
         break;
+    case MMI_OPC_0_PEXTLH:
+        gen_mmi_pextlh(ctx);
+        break;
     default:
         MIPS_INVAL("TX79 MMI class MMI0");
         generate_exception_end(ctx, EXCP_RI);
-- 
2.7.4
