Received: from eggs.gnu.org ([209.51.188.92]:57178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1h0pIe-00040p-Ck
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:14:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1h0pIc-0007rM-Pp
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:14:40 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:39732 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mateja.marjanovic@rt-rk.com>)
	id 1h0pIc-0007oJ-8B
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:14:38 -0500
From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Date: Mon,  4 Mar 2019 16:13:23 +0100
Message-Id: <1551712405-2530-12-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1551712405-2530-1-git-send-email-mateja.marjanovic@rt-rk.com>
References: <1551712405-2530-1-git-send-email-mateja.marjanovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v3 11/13] target/mips: Add emulation of MMI
 instruction PEXTUB
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

Add emulation of MMI instruction PEXTUB. The emulation is implemented
using TCG front end operations directly to achieve better performance.

Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
---
 target/mips/translate.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 95 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index e08203f..1bd5ef2 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -24993,6 +24993,98 @@ static void gen_mmi_pextlw(DisasContext *ctx)
     }
 }
 
+/*
+ *  PEXTUB rd, rs, rt
+ *
+ *  Parallel Extend Upper from Byte
+ *
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+---------+---------+---------+---------+-----------+
+ *  |    MMI    |    rs   |   rt    |   rd    | PEXTUB  |    MMI1   |
+ *  +-----------+---------+---------+---------+---------+-----------+
+ */
+
+static void gen_mmi_pextub(DisasContext *ctx)
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
+        uint64_t mask = (1ULL << 8) - 1;
+
+        tcg_gen_movi_i64(t1, 0);
+        tcg_gen_andi_i64(t0, cpu_gpr[rt], mask);
+        tcg_gen_or_i64(t1, t0, t1);
+        tcg_gen_andi_i64(t0, cpu_gpr[rs], mask);
+        tcg_gen_shli_i64(t0, t0, 8);
+        tcg_gen_or_i64(t1, t0, t1);
+        mask <<= 8;
+        tcg_gen_andi_i64(t0, cpu_gpr[rt], mask);
+        tcg_gen_or_i64(t1, t0, t1);
+        tcg_gen_andi_i64(t0, cpu_gpr[rs], mask);
+        tcg_gen_shli_i64(t0, t0, 8);
+        tcg_gen_or_i64(t1, t0, t1);
+        mask <<= 8;
+        tcg_gen_movi_i64(t1, 0);
+        tcg_gen_andi_i64(t0, cpu_gpr[rt], mask);
+        tcg_gen_or_i64(t1, t0, t1);
+        tcg_gen_andi_i64(t0, cpu_gpr[rs], mask);
+        tcg_gen_shli_i64(t0, t0, 8);
+        tcg_gen_or_i64(t1, t0, t1);
+        mask <<= 8;
+        tcg_gen_andi_i64(t0, cpu_gpr[rt], mask);
+        tcg_gen_or_i64(t1, t0, t1);
+        tcg_gen_andi_i64(t0, cpu_gpr[rs], mask);
+        tcg_gen_shli_i64(t0, t0, 8);
+        tcg_gen_or_i64(t1, t0, t1);
+
+        tcg_gen_mov_i64(cpu_mmr[rd], t1);
+
+        mask <<= 8;
+        tcg_gen_movi_i64(t1, 0);
+        tcg_gen_movi_i64(t1, 0);
+        tcg_gen_andi_i64(t0, cpu_gpr[rt], mask);
+        tcg_gen_or_i64(t1, t0, t1);
+        tcg_gen_andi_i64(t0, cpu_gpr[rs], mask);
+        tcg_gen_shli_i64(t0, t0, 8);
+        tcg_gen_or_i64(t1, t0, t1);
+        mask <<= 8;
+        tcg_gen_andi_i64(t0, cpu_gpr[rt], mask);
+        tcg_gen_or_i64(t1, t0, t1);
+        tcg_gen_andi_i64(t0, cpu_gpr[rs], mask);
+        tcg_gen_shli_i64(t0, t0, 8);
+        tcg_gen_or_i64(t1, t0, t1);
+        mask <<= 8;
+        tcg_gen_movi_i64(t1, 0);
+        tcg_gen_andi_i64(t0, cpu_gpr[rt], mask);
+        tcg_gen_or_i64(t1, t0, t1);
+        tcg_gen_andi_i64(t0, cpu_gpr[rs], mask);
+        tcg_gen_shli_i64(t0, t0, 8);
+        tcg_gen_or_i64(t1, t0, t1);
+        mask <<= 8;
+        tcg_gen_andi_i64(t0, cpu_gpr[rt], mask);
+        tcg_gen_or_i64(t1, t0, t1);
+        tcg_gen_andi_i64(t0, cpu_gpr[rs], mask);
+        tcg_gen_shli_i64(t0, t0, 8);
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
 
 
@@ -27988,10 +28080,12 @@ static void decode_mmi1(CPUMIPSState *env, DisasContext *ctx)
     case MMI_OPC_1_PEXTUH:    /* TODO: MMI_OPC_1_PEXTUH */
     case MMI_OPC_1_PADDUB:    /* TODO: MMI_OPC_1_PADDUB */
     case MMI_OPC_1_PSUBUB:    /* TODO: MMI_OPC_1_PSUBUB */
-    case MMI_OPC_1_PEXTUB:    /* TODO: MMI_OPC_1_PEXTUB */
     case MMI_OPC_1_QFSRV:     /* TODO: MMI_OPC_1_QFSRV */
         generate_exception_end(ctx, EXCP_RI); /* TODO: MMI_OPC_CLASS_MMI1 */
         break;
+    case MMI_OPC_1_PEXTUB:
+        gen_mmi_pextub(ctx);
+        break;
     default:
         MIPS_INVAL("TX79 MMI class MMI1");
         generate_exception_end(ctx, EXCP_RI);
-- 
2.7.4
