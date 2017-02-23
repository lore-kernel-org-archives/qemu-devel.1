Received: from eggs.gnu.org ([2001:4830:134:3::10]:41254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgzVl-0005Mx-S6
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:57:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgzVk-0001mh-HP
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:57:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51898
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cgzVk-0001lx-BS
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:57:08 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1NJrkFK077237
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 14:57:07 -0500
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28t4yqbq64-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 14:57:07 -0500
Received: from localhost
	by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 24 Feb 2017 01:27:04 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Fri, 24 Feb 2017 01:26:36 +0530
In-Reply-To: <1487879800-12352-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1487879800-12352-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1487879800-12352-12-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4 11/15] target/ppc: update OV/OV32 for mull[d,
 w] insns
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

For Multiply Word:
SO, OV, and OV32 bits reflects overflow of the 32-bit result

For Multiply DoubleWord:
SO, OV, and OV32 bits reflects overflow of the 64-bit result

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target/ppc/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index ea0a356..e1105e8 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1365,7 +1365,7 @@ static void gen_mullwo(DisasContext *ctx)
     tcg_gen_sari_i32(t0, t0, 31);
     tcg_gen_setcond_i32(TCG_COND_NE, t0, t0, t1);
     tcg_gen_extu_i32_tl(ov, t0);
-    gen_op_update_ov_legacy(ov);
+    gen_op_update_ov(ctx, ov, ov);
     tcg_temp_free(ov);
 
     tcg_temp_free_i32(t0);
@@ -1428,7 +1428,7 @@ static void gen_mulldo(DisasContext *ctx)
 
     tcg_gen_sari_i64(t0, t0, 63);
     tcg_gen_setcond_i64(TCG_COND_NE, ov, t0, t1);
-    gen_op_update_ov_legacy(ov);
+    gen_op_update_ov(ctx, ov, ov);
     tcg_temp_free(ov);
 
     tcg_temp_free_i64(t0);
-- 
2.7.4
