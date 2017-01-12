Received: from eggs.gnu.org ([2001:4830:134:3::10]:46312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUk1-0002xN-B9
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUjz-0006Wd-9Z
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:49 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:02:42 +1100
Message-Id: <20170112020327.24882-23-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 22/67] target-ppc: implement xsabsqp/xsnabsqp
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

xsabsqp:  VSX Scalar Absolute Quad-Precision
xsnabsqp: VSX Scalar Negative Absolute Quad-Precision

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate/vsx-impl.inc.c | 35 +++++++++++++++++++++++++++++++++++
 target/ppc/translate/vsx-ops.inc.c  |  5 +++++
 2 files changed, 40 insertions(+)

diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 2fbdbd2..808ee48 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -609,6 +609,41 @@ VSX_SCALAR_MOVE(xsnabsdp, OP_NABS, SGN_MASK_DP)
 VSX_SCALAR_MOVE(xsnegdp, OP_NEG, SGN_MASK_DP)
 VSX_SCALAR_MOVE(xscpsgndp, OP_CPSGN, SGN_MASK_DP)
 
+#define VSX_SCALAR_MOVE_QP(name, op, sgn_mask)                    \
+static void glue(gen_, name)(DisasContext *ctx)                   \
+{                                                                 \
+    int xt = rD(ctx->opcode) + 32;                                \
+    int xb = rB(ctx->opcode) + 32;                                \
+    TCGv_i64 xbh, xbl, sgm;                                       \
+                                                                  \
+    if (unlikely(!ctx->vsx_enabled)) {                            \
+        gen_exception(ctx, POWERPC_EXCP_VSXU);                    \
+        return;                                                   \
+    }                                                             \
+    xbh = tcg_temp_new_i64();                                     \
+    xbl = tcg_temp_new_i64();                                     \
+    sgm = tcg_temp_new_i64();                                     \
+    tcg_gen_mov_i64(xbh, cpu_vsrh(xb));                           \
+    tcg_gen_mov_i64(xbl, cpu_vsrl(xb));                           \
+    tcg_gen_movi_i64(sgm, sgn_mask);                              \
+    switch (op) {                                                 \
+    case OP_ABS:                                                  \
+        tcg_gen_andc_i64(xbh, xbh, sgm);                          \
+        break;                                                    \
+    case OP_NABS:                                                 \
+        tcg_gen_or_i64(xbh, xbh, sgm);                            \
+        break;                                                    \
+    }                                                             \
+    tcg_gen_mov_i64(cpu_vsrh(xt), xbh);                           \
+    tcg_gen_mov_i64(cpu_vsrl(xt), xbl);                           \
+    tcg_temp_free_i64(xbl);                                       \
+    tcg_temp_free_i64(xbh);                                       \
+    tcg_temp_free_i64(sgm);                                       \
+}
+
+VSX_SCALAR_MOVE_QP(xsabsqp, OP_ABS, SGN_MASK_DP)
+VSX_SCALAR_MOVE_QP(xsnabsqp, OP_NABS, SGN_MASK_DP)
+
 #define VSX_VECTOR_MOVE(name, op, sgn_mask)                      \
 static void glue(gen_, name)(DisasContext * ctx)                 \
     {                                                            \
diff --git a/target/ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vsx-ops.inc.c
index 8a1cbe0..daf6a56 100644
--- a/target/ppc/translate/vsx-ops.inc.c
+++ b/target/ppc/translate/vsx-ops.inc.c
@@ -88,12 +88,17 @@ GEN_HANDLER2_E(name, #name, 0x3C, opc2|0x03, opc3|0x0C, 0, PPC_NONE, PPC2_VSX)
 #define GEN_VSX_XFORM_300(name, opc2, opc3, inval) \
 GEN_HANDLER_E(name, 0x3F, opc2, opc3, inval, PPC_NONE, PPC2_ISA300)
 
+#define GEN_VSX_XFORM_300_EO(name, opc2, opc3, opc4, inval)             \
+GEN_HANDLER_E_2(name, 0x3F, opc2, opc3, opc4, inval, PPC_NONE, PPC2_ISA300)
 
 GEN_XX2FORM(xsabsdp, 0x12, 0x15, PPC2_VSX),
 GEN_XX2FORM(xsnabsdp, 0x12, 0x16, PPC2_VSX),
 GEN_XX2FORM(xsnegdp, 0x12, 0x17, PPC2_VSX),
 GEN_XX3FORM(xscpsgndp, 0x00, 0x16, PPC2_VSX),
 
+GEN_VSX_XFORM_300_EO(xsabsqp, 0x04, 0x19, 0x00, 0x00000001),
+GEN_VSX_XFORM_300_EO(xsnabsqp, 0x04, 0x19, 0x08, 0x00000001),
+
 GEN_XX2FORM(xvabsdp, 0x12, 0x1D, PPC2_VSX),
 GEN_XX2FORM(xvnabsdp, 0x12, 0x1E, PPC2_VSX),
 GEN_XX2FORM(xvnegdp, 0x12, 0x1F, PPC2_VSX),
-- 
2.9.3
