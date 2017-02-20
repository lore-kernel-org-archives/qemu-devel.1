Received: from eggs.gnu.org ([2001:4830:134:3::10]:44651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cfl0L-0002y8-F3
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 05:15:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cfl0I-0003Vl-AA
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 05:15:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47023)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cfl0I-0003VE-0d
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 05:15:34 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1KAA3vb002492
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 05:15:33 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28qw8wb3nv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 05:15:32 -0500
Received: from localhost
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Mon, 20 Feb 2017 20:15:30 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Mon, 20 Feb 2017 15:41:58 +0530
In-Reply-To: <1487585521-19445-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1487585521-19445-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1487585521-19445-8-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 07/10] target/ppc: update ov/ov32 for nego
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
 target/ppc/translate.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 9fa3b5a..0168e1c 100644
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
@@ -1488,7 +1480,20 @@ static void gen_neg(DisasContext *ctx)
 
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
+    tcg_temp_free(t0);
+    tcg_temp_free(zero);
 }
 
 /***                            Integer logical                            ***/
-- 
2.7.4
