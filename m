Received: from eggs.gnu.org ([2001:4830:134:3::10]:46183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUjy-0002u8-In
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUjw-0006TR-PI
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:46 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:02:45 +1100
Message-Id: <20170112020327.24882-26-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 25/67] target-ppc: implement xscpsgnqp
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
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

xscpsgnqp: VSX Scalar Copy Sign Quad-Precision

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate/vsx-impl.inc.c | 12 +++++++++++-
 target/ppc/translate/vsx-ops.inc.c  |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index e74e16e..90d26a2 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -612,9 +612,10 @@ VSX_SCALAR_MOVE(xscpsgndp, OP_CPSGN, SGN_MASK_DP)
 #define VSX_SCALAR_MOVE_QP(name, op, sgn_mask)                    \
 static void glue(gen_, name)(DisasContext *ctx)                   \
 {                                                                 \
+    int xa;                                                       \
     int xt = rD(ctx->opcode) + 32;                                \
     int xb = rB(ctx->opcode) + 32;                                \
-    TCGv_i64 xbh, xbl, sgm;                                       \
+    TCGv_i64 xah, xbh, xbl, sgm;                                  \
                                                                   \
     if (unlikely(!ctx->vsx_enabled)) {                            \
         gen_exception(ctx, POWERPC_EXCP_VSXU);                    \
@@ -636,6 +637,14 @@ static void glue(gen_, name)(DisasContext *ctx)                   \
     case OP_NEG:                                                  \
         tcg_gen_xor_i64(xbh, xbh, sgm);                           \
         break;                                                    \
+    case OP_CPSGN:                                                \
+        xah = tcg_temp_new_i64();                                 \
+        xa = rA(ctx->opcode) + 32;                                \
+        tcg_gen_and_i64(xah, cpu_vsrh(xa), sgm);                  \
+        tcg_gen_andc_i64(xbh, xbh, sgm);                          \
+        tcg_gen_or_i64(xbh, xbh, xah);                            \
+        tcg_temp_free_i64(xah);                                   \
+        break;                                                    \
     }                                                             \
     tcg_gen_mov_i64(cpu_vsrh(xt), xbh);                           \
     tcg_gen_mov_i64(cpu_vsrl(xt), xbl);                           \
@@ -647,6 +656,7 @@ static void glue(gen_, name)(DisasContext *ctx)                   \
 VSX_SCALAR_MOVE_QP(xsabsqp, OP_ABS, SGN_MASK_DP)
 VSX_SCALAR_MOVE_QP(xsnabsqp, OP_NABS, SGN_MASK_DP)
 VSX_SCALAR_MOVE_QP(xsnegqp, OP_NEG, SGN_MASK_DP)
+VSX_SCALAR_MOVE_QP(xscpsgnqp, OP_CPSGN, SGN_MASK_DP)
 
 #define VSX_VECTOR_MOVE(name, op, sgn_mask)                      \
 static void glue(gen_, name)(DisasContext * ctx)                 \
diff --git a/target/ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vsx-ops.inc.c
index f7132b4..68fa171 100644
--- a/target/ppc/translate/vsx-ops.inc.c
+++ b/target/ppc/translate/vsx-ops.inc.c
@@ -99,6 +99,7 @@ GEN_XX3FORM(xscpsgndp, 0x00, 0x16, PPC2_VSX),
 GEN_VSX_XFORM_300_EO(xsabsqp, 0x04, 0x19, 0x00, 0x00000001),
 GEN_VSX_XFORM_300_EO(xsnabsqp, 0x04, 0x19, 0x08, 0x00000001),
 GEN_VSX_XFORM_300_EO(xsnegqp, 0x04, 0x19, 0x10, 0x00000001),
+GEN_VSX_XFORM_300(xscpsgnqp, 0x04, 0x03, 0x00000001),
 
 GEN_XX2FORM(xvabsdp, 0x12, 0x1D, PPC2_VSX),
 GEN_XX2FORM(xvnabsdp, 0x12, 0x1E, PPC2_VSX),
-- 
2.9.3
