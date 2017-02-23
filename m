Received: from eggs.gnu.org ([2001:4830:134:3::10]:41405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgzVo-0005ZE-Ri
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:57:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgzVl-0001nI-2F
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:57:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54421)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cgzVk-0001m4-O0
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:57:08 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1NJs1NE061764
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 14:57:07 -0500
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28t5wb181e-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 14:57:07 -0500
Received: from localhost
	by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 24 Feb 2017 01:27:04 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Fri, 24 Feb 2017 01:26:35 +0530
In-Reply-To: <1487879800-12352-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1487879800-12352-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1487879800-12352-11-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4 10/15] target/ppc: add
 gen_op_update_ov_isa300()
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

Introduce routine to update OV and OV32 in case it is POWER9 and above.

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target/ppc/translate.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 143b595..ea0a356 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -833,6 +833,31 @@ static inline void gen_op_update_ov_legacy(TCGv ov)
     tcg_temp_free(zero);
 }
 
+static inline void gen_op_update_ov_isa300(TCGv ov, TCGv ov32)
+{
+    TCGv t1 = tcg_temp_new();
+    TCGv t2 = tcg_temp_new();
+    tcg_gen_movi_tl(t1, XER_OV | XER_OV32);
+    tcg_gen_andc_tl(cpu_xer, cpu_xer, t1);
+    tcg_gen_shli_tl(t1, ov, XER_OV_BIT);
+    tcg_gen_shli_tl(t2, ov, XER_SO_BIT);
+    tcg_gen_or_tl(t1, t1, t2);
+    tcg_gen_shli_tl(t2, ov32, XER_OV32_BIT);
+    tcg_gen_or_tl(t1, t1, t2);
+    tcg_gen_or_tl(cpu_xer, cpu_xer, t1);
+    tcg_temp_free(t1);
+    tcg_temp_free(t2);
+}
+
+static inline void gen_op_update_ov(DisasContext *ctx, TCGv ov, TCGv ov32)
+{
+    if (is_isa300(ctx)) {
+        gen_op_update_ov_isa300(ov, ov32);
+    } else {
+        gen_op_update_ov_legacy(ov);
+    }
+}
+
 /* Sub functions with one operand and one immediate */
 #define GEN_UPDATE_OV(name, const_val)          \
 static void glue(gen_op_, name)(void)           \
-- 
2.7.4
