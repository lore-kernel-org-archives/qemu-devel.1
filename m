Received: from eggs.gnu.org ([2001:4830:134:3::10]:35404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1ch8ic-0005c6-UY
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 00:47:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1ch8ia-0005jM-BZ
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 00:47:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33987
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1ch8ia-0005if-4B
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 00:47:00 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1O5hXDN111054
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 00:46:59 -0500
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28tewxg3n9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 00:46:58 -0500
Received: from localhost
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 24 Feb 2017 11:16:54 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Fri, 24 Feb 2017 11:16:41 +0530
In-Reply-To: <1487915204-23189-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1487915204-23189-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1487915204-23189-6-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v5 5/8] target/ppc: use tcg ops for neg
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
