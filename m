Received: from eggs.gnu.org ([2001:4830:134:3::10]:50030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgTGX-0000zn-PQ
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 04:31:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgTGS-0006dH-5H
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 04:31:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56134
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cgTGS-0006cu-0E
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 04:31:12 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1M9SsDs090349
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 04:31:11 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28rm7u7mw4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 04:31:10 -0500
Received: from localhost
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Wed, 22 Feb 2017 19:31:07 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Wed, 22 Feb 2017 14:59:45 +0530
In-Reply-To: <1487755788-16415-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1487755788-16415-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1487755788-16415-9-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 08/11] target/ppc: update ov/ov32 for nego
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

For 64-bit mode if the register RA contains 0x8000_0000_0000_0000, OV
and OV32 are set to 1.

For 32-bit mode if the register RA contains 0x8000_0000, OV and OV32 are
set to 1.

Use the tcg-ops for negation (neg_tl) and drop gen_op_arith_neg() as
nego was the last user.

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target/ppc/translate.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index eecdfe9..2a9f508 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1473,14 +1473,6 @@ static void gen_subfic(DisasContext *ctx)
 }
 
 /* neg neg. nego nego. */
-static inline void gen_op_arith_neg(DisasContext *ctx, bool compute_ov)
-{
-    TCGv zero = tcg_const_tl(0);
-    gen_op_arith_subf(ctx, cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)],
-                      zero, 0, 0, compute_ov, Rc(ctx->opcode));
-    tcg_temp_free(zero);
-}
-
 static void gen_neg(DisasContext *ctx)
 {
     tcg_gen_neg_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)]);
@@ -1491,7 +1483,23 @@ static void gen_neg(DisasContext *ctx)
 
 static void gen_nego(DisasContext *ctx)
 {
-    gen_op_arith_neg(ctx, 1);
+    TCGv t0 = tcg_temp_new();
+    TCGv zero = tcg_const_tl(0);
+
+    if (NARROW_MODE(ctx)) {
+        tcg_gen_xori_tl(t0, cpu_gpr[rA(ctx->opcode)], INT32_MIN);
+    } else {
+        tcg_gen_xori_tl(t0, cpu_gpr[rA(ctx->opcode)], (target_ulong)INT64_MIN);
+    }
+
+    tcg_gen_setcond_tl(TCG_COND_EQ, cpu_ov, t0, zero);
+    tcg_gen_mov_tl(cpu_ov32, cpu_ov);
+    tcg_gen_neg_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)]);
+    if (unlikely(Rc(ctx->opcode))) {
+        gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
+    }
+    tcg_temp_free(t0);
+    tcg_temp_free(zero);
 }
 
 /***                            Integer logical                            ***/
-- 
2.7.4
