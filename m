Received: from eggs.gnu.org ([2001:4830:134:3::10]:49960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgTGS-0000uY-Vb
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 04:31:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgTGS-0006dC-59
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 04:31:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52915
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cgTGS-0006ct-01
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 04:31:12 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1M9Spkk070340
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 04:31:11 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28s6qeb8dm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 04:31:10 -0500
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Wed, 22 Feb 2017 19:31:03 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Wed, 22 Feb 2017 14:59:42 +0530
In-Reply-To: <1487755788-16415-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1487755788-16415-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1487755788-16415-6-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 05/11] target/ppc: update ca32 in arithmetic
 substract
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
---
 target/ppc/translate.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index b589d09..184d10f 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -827,7 +827,15 @@ static inline void gen_op_arith_compute_ca32(DisasContext *ctx,
     }
 
     t0 = tcg_temp_new();
-    tcg_gen_xor_tl(t0, arg0, arg1);
+    if (!add_ca && sub) {
+        /* Invert arg0 before xor as in the !add_ca case,
+         * we do not get inverse of arg0
+         */
+        tcg_gen_not_tl(t0, arg0);
+        tcg_gen_xor_tl(t0, t0, arg1);
+    } else {
+        tcg_gen_xor_tl(t0, arg0, arg1);
+    }
     tcg_gen_xor_tl(t0, t0, res);
     tcg_gen_extract_tl(cpu_ca32, t0, 32, 1);
     tcg_temp_free(t0);
@@ -1382,11 +1390,13 @@ static inline void gen_op_arith_subf(DisasContext *ctx, TCGv ret, TCGv arg1,
             zero = tcg_const_tl(0);
             tcg_gen_add2_tl(t0, cpu_ca, arg2, zero, cpu_ca, zero);
             tcg_gen_add2_tl(t0, cpu_ca, t0, cpu_ca, inv1, zero);
+            gen_op_arith_compute_ca32(ctx, t0, inv1, arg2, add_ca, 1);
             tcg_temp_free(zero);
             tcg_temp_free(inv1);
         } else {
             tcg_gen_setcond_tl(TCG_COND_GEU, cpu_ca, arg2, arg1);
             tcg_gen_sub_tl(t0, arg2, arg1);
+            gen_op_arith_compute_ca32(ctx, t0, arg1, arg2, add_ca, 1);
         }
     } else if (add_ca) {
         /* Since we're ignoring carry-out, we can simplify the
-- 
2.7.4
