Received: from eggs.gnu.org ([2001:4830:134:3::10]:60831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1ciDOE-0006b5-5W
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 23:58:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1ciDOA-0002Me-82
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 23:58:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1ciDO9-0002Lu-UL
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 23:58:22 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1R4tIlM116407
	for <qemu-devel@nongnu.org>; Sun, 26 Feb 2017 23:58:20 -0500
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28u6xn5ber-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 26 Feb 2017 23:58:20 -0500
Received: from localhost
	by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Mon, 27 Feb 2017 10:28:17 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Mon, 27 Feb 2017 10:27:58 +0530
In-Reply-To: <1488171481-21699-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1488171481-21699-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1488171481-21699-6-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v6 5/8] target/ppc: use tcg ops for neg
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

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 target/ppc/translate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 16f422f..d4d9941 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1483,7 +1483,10 @@ static inline void gen_op_arith_neg(DisasContext *ctx, bool compute_ov)
 
 static void gen_neg(DisasContext *ctx)
 {
-    gen_op_arith_neg(ctx, 0);
+    tcg_gen_neg_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)]);
+    if (unlikely(Rc(ctx->opcode))) {
+        gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
+    }
 }
 
 static void gen_nego(DisasContext *ctx)
-- 
2.7.4
