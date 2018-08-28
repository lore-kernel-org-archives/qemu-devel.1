Received: from eggs.gnu.org ([2001:4830:134:3::10]:51814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=771b48d5d=jancraig@amazon.com>)
	id 1fude1-0005KI-PJ
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 09:02:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=771b48d5d=jancraig@amazon.com>)
	id 1fuddw-0004IK-JA
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 09:02:53 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:44595)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=771b48d5d=jancraig@amazon.com>)
	id 1fuddw-0004HF-Aw
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 09:02:48 -0400
From: Craig Janeczek <jancraig@amazon.com>
Date: Tue, 28 Aug 2018 09:00:40 -0400
Message-Id: <20180828130041.26445-8-jancraig@amazon.com>
In-Reply-To: <20180828130041.26445-1-jancraig@amazon.com>
References: <20180828130041.26445-1-jancraig@amazon.com>
Subject: [Qemu-devel] [PATCH v3 7/8] target/mips: Add MXU instructions Q8MUL
 and Q8MULSU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amarkovic@wavecomp.com, aurelien@aurel32.net, Craig Janeczek <jancraig@amazon.com>

Adds support for emulating the Q8MUL and Q8MULSU instructions.

Signed-off-by: Craig Janeczek <jancraig@amazon.com>
---
 v1
    - initial patch
 v2
    - changed bitfield usage to extract32
 v3
    - Split gen_mxu function into command specific gen_mxu_<ins> functions

 target/mips/translate.c | 86 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 7c17867d30..a28ea124c2 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -4041,6 +4041,88 @@ static void gen_mxu_d16mac(DisasContext *ctx, uint32_t opc)
     tcg_temp_free(t3);
 }
 
+/* Q8MUL XRa, XRb, XRc, XRd - Parallel unsigned 8 bit pattern multiply */
+/* Q8MULSU XRa, XRb, XRc, XRd - Parallel signed 8 bit pattern multiply */
+static void gen_mxu_q8mul(DisasContext *ctx, uint32_t opc)
+{
+    TCGv t0, t1, t2, t3, t4, t5, t6, t7;
+    uint32_t xra, xrb, xrc, xrd, sel;
+
+    t0 = tcg_temp_new();
+    t1 = tcg_temp_new();
+    t2 = tcg_temp_new();
+    t3 = tcg_temp_new();
+    t4 = tcg_temp_new();
+    t5 = tcg_temp_new();
+    t6 = tcg_temp_new();
+    t7 = tcg_temp_new();
+
+    xra = extract32(ctx->opcode, 6, 4);
+    xrb = extract32(ctx->opcode, 10, 4);
+    xrc = extract32(ctx->opcode, 14, 4);
+    xrd = extract32(ctx->opcode, 18, 4);
+    sel = extract32(ctx->opcode, 22, 4);
+
+    gen_load_mxu_gpr(t3, xrb);
+    gen_load_mxu_gpr(t7, xrc);
+
+    if (sel == 0x2) {
+        /* Q8MULSU */
+        tcg_gen_ext8s_tl(t0, t3);
+        tcg_gen_shri_tl(t3, t3, 8);
+        tcg_gen_ext8s_tl(t1, t3);
+        tcg_gen_shri_tl(t3, t3, 8);
+        tcg_gen_ext8s_tl(t2, t3);
+        tcg_gen_shri_tl(t3, t3, 8);
+        tcg_gen_ext8s_tl(t3, t3);
+    } else {
+        /* Q8MUL */
+        tcg_gen_ext8u_tl(t0, t3);
+        tcg_gen_shri_tl(t3, t3, 8);
+        tcg_gen_ext8u_tl(t1, t3);
+        tcg_gen_shri_tl(t3, t3, 8);
+        tcg_gen_ext8u_tl(t2, t3);
+        tcg_gen_shri_tl(t3, t3, 8);
+        tcg_gen_ext8u_tl(t3, t3);
+    }
+
+    tcg_gen_ext8u_tl(t4, t7);
+    tcg_gen_shri_tl(t7, t7, 8);
+    tcg_gen_ext8u_tl(t5, t7);
+    tcg_gen_shri_tl(t7, t7, 8);
+    tcg_gen_ext8u_tl(t6, t7);
+    tcg_gen_shri_tl(t7, t7, 8);
+    tcg_gen_ext8u_tl(t7, t7);
+
+    tcg_gen_mul_tl(t0, t0, t4);
+    tcg_gen_mul_tl(t1, t1, t5);
+    tcg_gen_mul_tl(t2, t2, t6);
+    tcg_gen_mul_tl(t3, t3, t7);
+
+    tcg_gen_andi_tl(t0, t0, 0xFFFF);
+    tcg_gen_andi_tl(t1, t1, 0xFFFF);
+    tcg_gen_andi_tl(t2, t2, 0xFFFF);
+    tcg_gen_andi_tl(t3, t3, 0xFFFF);
+
+    tcg_gen_shli_tl(t1, t1, 16);
+    tcg_gen_shli_tl(t3, t3, 16);
+
+    tcg_gen_or_tl(t0, t0, t1);
+    tcg_gen_or_tl(t1, t2, t3);
+
+    gen_store_mxu_gpr(t0, xrd);
+    gen_store_mxu_gpr(t1, xra);
+
+    tcg_temp_free(t0);
+    tcg_temp_free(t1);
+    tcg_temp_free(t2);
+    tcg_temp_free(t3);
+    tcg_temp_free(t4);
+    tcg_temp_free(t5);
+    tcg_temp_free(t6);
+    tcg_temp_free(t7);
+}
+
 /* Godson integer instructions */
 static void gen_loongson_integer(DisasContext *ctx, uint32_t opc,
                                  int rd, int rs, int rt)
@@ -18158,6 +18240,10 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
         gen_mxu_d16mac(ctx, op1);
         break;
 
+    case OPC_MXU_Q8MUL:
+        gen_mxu_q8mul(ctx, op1);
+        break;
+
     case OPC_CLO:
     case OPC_CLZ:
         check_insn(ctx, ISA_MIPS32);
-- 
2.18.0
