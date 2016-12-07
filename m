Received: from eggs.gnu.org ([2001:4830:134:3::10]:52591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cEgum-0005CO-Je
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:26:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cEguh-0001x6-V5
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:26:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48636
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cEguh-0001wu-Px
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:25:55 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB7IKLdm028523
	for <qemu-devel@nongnu.org>; Wed, 7 Dec 2016 13:25:55 -0500
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
	by mx0b-001b2d01.pphosted.com with ESMTP id 276m0bcsuf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Dec 2016 13:25:54 -0500
Received: from localhost
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Wed, 7 Dec 2016 23:55:50 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Wed,  7 Dec 2016 23:55:01 +0530
In-Reply-To: <1481135102-20011-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1481135102-20011-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1481135102-20011-9-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 8/9] target-ppc: implement xscpsgnqp
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com

xscpsgnqp: VSX Scalar Copy Sign Quad-Precision

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 target-ppc/translate/vsx-impl.inc.c | 12 +++++++++++-
 target-ppc/translate/vsx-ops.inc.c  |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/target-ppc/translate/vsx-impl.inc.c b/target-ppc/translate/vsx-impl.inc.c
index 01b95df..8321134 100644
--- a/target-ppc/translate/vsx-impl.inc.c
+++ b/target-ppc/translate/vsx-impl.inc.c
@@ -642,9 +642,10 @@ VSX_SCALAR_MOVE(xscpsgndp, OP_CPSGN, SGN_MASK_DP)
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
@@ -666,6 +667,14 @@ static void glue(gen_, name)(DisasContext *ctx)                   \
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
@@ -677,6 +686,7 @@ static void glue(gen_, name)(DisasContext *ctx)                   \
 VSX_SCALAR_MOVE_QP(xsabsqp, OP_ABS, SGN_MASK_DP)
 VSX_SCALAR_MOVE_QP(xsnabsqp, OP_NABS, SGN_MASK_DP)
 VSX_SCALAR_MOVE_QP(xsnegqp, OP_NEG, SGN_MASK_DP)
+VSX_SCALAR_MOVE_QP(xscpsgnqp, OP_CPSGN, SGN_MASK_DP)
 
 #define VSX_VECTOR_MOVE(name, op, sgn_mask)                      \
 static void glue(gen_, name)(DisasContext * ctx)                 \
diff --git a/target-ppc/translate/vsx-ops.inc.c b/target-ppc/translate/vsx-ops.inc.c
index d798edb..42e83d2 100644
--- a/target-ppc/translate/vsx-ops.inc.c
+++ b/target-ppc/translate/vsx-ops.inc.c
@@ -107,6 +107,7 @@ GEN_XX3FORM(xscpsgndp, 0x00, 0x16, PPC2_VSX),
 GEN_VSX_XFORM_300_EO(xsabsqp, 0x04, 0x19, 0x00, 0x00000001),
 GEN_VSX_XFORM_300_EO(xsnabsqp, 0x04, 0x19, 0x08, 0x00000001),
 GEN_VSX_XFORM_300_EO(xsnegqp, 0x04, 0x19, 0x10, 0x00000001),
+GEN_VSX_XFORM_300(xscpsgnqp, 0x04, 0x03, 0x00000001),
 
 GEN_XX2FORM(xvabsdp, 0x12, 0x1D, PPC2_VSX),
 GEN_XX2FORM(xvnabsdp, 0x12, 0x1E, PPC2_VSX),
-- 
2.7.4
