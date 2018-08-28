Received: from eggs.gnu.org ([2001:4830:134:3::10]:52548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=771b48d5d=jancraig@amazon.com>)
	id 1fudfc-0006d9-8N
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 09:04:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=771b48d5d=jancraig@amazon.com>)
	id 1fudfW-0006Sn-MP
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 09:04:32 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:25109)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=771b48d5d=jancraig@amazon.com>)
	id 1fudfW-0006Ql-C2
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 09:04:26 -0400
From: Craig Janeczek <jancraig@amazon.com>
Date: Tue, 28 Aug 2018 09:00:38 -0400
Message-Id: <20180828130041.26445-6-jancraig@amazon.com>
In-Reply-To: <20180828130041.26445-1-jancraig@amazon.com>
References: <20180828130041.26445-1-jancraig@amazon.com>
Subject: [Qemu-devel] [PATCH v3 5/8] target/mips: Add MXU instruction D16MUL
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

Adds support for emulating the D16MUL instruction.

Signed-off-by: Craig Janeczek <jancraig@amazon.com>
---
 v1
    - initial patch
 v2
    - changed bitfield usage to extract32
    - used sextract_tl instructions instead of shift and ext
 v3
    - Split gen_mxu function into command specific gen_mxu_<ins> functions

 target/mips/translate.c | 55 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 024e48baf6..f693e45203 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -3916,6 +3916,57 @@ static void gen_mxu_s8ldd(DisasContext *ctx, uint32_t opc)
     tcg_temp_free(t1);
 }
 
+/* D16MUL XRa, XRb, XRc, XRd, OPTN2 - Signed 16 bit pattern multiplication */
+static void gen_mxu_d16mul(DisasContext *ctx, uint32_t opc)
+{
+    TCGv t0, t1, t2, t3;
+    uint32_t xra, xrb, xrc, xrd, optn2;
+
+    t0 = tcg_temp_new();
+    t1 = tcg_temp_new();
+    t2 = tcg_temp_new();
+    t3 = tcg_temp_new();
+
+    xra = extract32(ctx->opcode, 6, 4);
+    xrb = extract32(ctx->opcode, 10, 4);
+    xrc = extract32(ctx->opcode, 14, 4);
+    xrd = extract32(ctx->opcode, 18, 4);
+    optn2 = extract32(ctx->opcode, 22, 2);
+
+    gen_load_mxu_gpr(t1, xrb);
+    tcg_gen_sextract_tl(t0, t1, 0, 16);
+    tcg_gen_sextract_tl(t1, t1, 16, 16);
+    gen_load_mxu_gpr(t3, xrc);
+    tcg_gen_sextract_tl(t2, t3, 0, 16);
+    tcg_gen_sextract_tl(t3, t3, 16, 16);
+
+    switch (optn2) {
+    case 0: /* XRB.H*XRC.H == lop, XRB.L*XRC.L == rop */
+        tcg_gen_mul_tl(t3, t1, t3);
+        tcg_gen_mul_tl(t2, t0, t2);
+        break;
+    case 1: /* XRB.L*XRC.H == lop, XRB.L*XRC.L == rop */
+        tcg_gen_mul_tl(t3, t0, t3);
+        tcg_gen_mul_tl(t2, t0, t2);
+        break;
+    case 2: /* XRB.H*XRC.H == lop, XRB.H*XRC.L == rop */
+        tcg_gen_mul_tl(t3, t1, t3);
+        tcg_gen_mul_tl(t2, t1, t2);
+        break;
+    case 3: /* XRB.L*XRC.H == lop, XRB.H*XRC.L == rop */
+        tcg_gen_mul_tl(t3, t0, t3);
+        tcg_gen_mul_tl(t2, t1, t2);
+        break;
+    }
+    gen_store_mxu_gpr(t3, xra);
+    gen_store_mxu_gpr(t2, xrd);
+
+    tcg_temp_free(t0);
+    tcg_temp_free(t1);
+    tcg_temp_free(t2);
+    tcg_temp_free(t3);
+}
+
 /* Godson integer instructions */
 static void gen_loongson_integer(DisasContext *ctx, uint32_t opc,
                                  int rd, int rs, int rt)
@@ -18025,6 +18076,10 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
         gen_mxu_s8ldd(ctx, op1);
         break;
 
+    case OPC_MXU_D16MUL:
+        gen_mxu_d16mul(ctx, op1);
+        break;
+
     case OPC_CLO:
     case OPC_CLZ:
         check_insn(ctx, ISA_MIPS32);
-- 
2.18.0
