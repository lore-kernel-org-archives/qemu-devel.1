Received: from eggs.gnu.org ([2001:4830:134:3::10]:44228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cfkyl-00013K-Ag
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 05:14:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cfkyi-0002wV-71
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 05:13:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46323
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cfkyi-0002wH-19
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 05:13:56 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1KA9oLY056676
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 05:13:55 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28qv45wtgt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 05:13:54 -0500
Received: from localhost
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Mon, 20 Feb 2017 20:13:51 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Mon, 20 Feb 2017 15:41:54 +0530
In-Reply-To: <1487585521-19445-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1487585521-19445-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1487585521-19445-4-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 03/10] target/ppc: move subf logic block
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
 target/ppc/translate.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 2a2d071..77045be 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1389,17 +1389,19 @@ static inline void gen_op_arith_subf(DisasContext *ctx, TCGv ret, TCGv arg1,
             tcg_temp_free(t1);
             tcg_gen_shri_tl(cpu_ca, cpu_ca, 32);    /* extract bit 32 */
             tcg_gen_andi_tl(cpu_ca, cpu_ca, 1);
-        } else if (add_ca) {
-            TCGv zero, inv1 = tcg_temp_new();
-            tcg_gen_not_tl(inv1, arg1);
-            zero = tcg_const_tl(0);
-            tcg_gen_add2_tl(t0, cpu_ca, arg2, zero, cpu_ca, zero);
-            tcg_gen_add2_tl(t0, cpu_ca, t0, cpu_ca, inv1, zero);
-            tcg_temp_free(zero);
-            tcg_temp_free(inv1);
         } else {
-            tcg_gen_setcond_tl(TCG_COND_GEU, cpu_ca, arg2, arg1);
-            tcg_gen_sub_tl(t0, arg2, arg1);
+            if (add_ca) {
+                TCGv zero, inv1 = tcg_temp_new();
+                tcg_gen_not_tl(inv1, arg1);
+                zero = tcg_const_tl(0);
+                tcg_gen_add2_tl(t0, cpu_ca, arg2, zero, cpu_ca, zero);
+                tcg_gen_add2_tl(t0, cpu_ca, t0, cpu_ca, inv1, zero);
+                tcg_temp_free(zero);
+                tcg_temp_free(inv1);
+            } else {
+                tcg_gen_setcond_tl(TCG_COND_GEU, cpu_ca, arg2, arg1);
+                tcg_gen_sub_tl(t0, arg2, arg1);
+            }
         }
     } else if (add_ca) {
         /* Since we're ignoring carry-out, we can simplify the
-- 
2.7.4
