Received: from eggs.gnu.org ([2001:4830:134:3::10]:41333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgzVn-0005UI-Iy
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:57:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgzVj-0001lb-ID
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:57:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48008)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cgzVj-0001km-8P
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:57:07 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1NJtM1Z054466
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 14:57:06 -0500
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28sku9nh9g-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 14:57:05 -0500
Received: from localhost
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 24 Feb 2017 01:27:03 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Fri, 24 Feb 2017 01:26:34 +0530
In-Reply-To: <1487879800-12352-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1487879800-12352-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1487879800-12352-10-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4 09/15] target/ppc: update ca32 in arithmetic
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
 target/ppc/translate.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index c98e708..143b595 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -877,7 +877,11 @@ static inline void gen_op_arith_compute_ca32(DisasContext *ctx, TCGv ca32,
     }
 
     t0 = tcg_temp_new();
-    tcg_gen_xor_tl(t0, arg0, arg1);
+    if (sub) {
+        tcg_gen_eqv_tl(t0, arg0, arg1);
+    } else {
+        tcg_gen_xor_tl(t0, arg0, arg1);
+    }
     tcg_gen_xor_tl(t0, t0, res);
     tcg_gen_extract_tl(ca32, t0, 32, 1);
     tcg_temp_free(t0);
@@ -1418,6 +1422,7 @@ static inline void gen_op_arith_subf(DisasContext *ctx, TCGv ret, TCGv arg1,
 {
     TCGv t0 = ret;
     TCGv ca = tcg_temp_new();
+    TCGv ca32 = tcg_temp_new();
 
     if (compute_ca || compute_ov) {
         t0 = tcg_temp_new();
@@ -1446,17 +1451,22 @@ static inline void gen_op_arith_subf(DisasContext *ctx, TCGv ret, TCGv arg1,
             tcg_gen_xor_tl(ca, t0, t1);         /* bits changes w/ carry */
             tcg_temp_free(t1);
             tcg_gen_extract_tl(ca, ca, 32, 1);    /* extract bit 32 */
+            if (is_isa300(ctx)) {
+                tcg_gen_mov_tl(ca32, ca);
+            }
         } else if (add_ca) {
             TCGv zero, inv1 = tcg_temp_new();
             tcg_gen_not_tl(inv1, arg1);
             zero = tcg_const_tl(0);
             tcg_gen_add2_tl(t0, ca, arg2, zero, ca, zero);
             tcg_gen_add2_tl(t0, ca, t0, ca, inv1, zero);
+            gen_op_arith_compute_ca32(ctx, ca32, t0, inv1, arg2, 0);
             tcg_temp_free(zero);
             tcg_temp_free(inv1);
         } else {
             tcg_gen_setcond_tl(TCG_COND_GEU, ca, arg2, arg1);
             tcg_gen_sub_tl(t0, arg2, arg1);
+            gen_op_arith_compute_ca32(ctx, ca32, t0, arg1, arg2, 1);
         }
     } else if (add_ca) {
         /* Since we're ignoring carry-out, we can simplify the
@@ -1472,7 +1482,7 @@ static inline void gen_op_arith_subf(DisasContext *ctx, TCGv ret, TCGv arg1,
         gen_op_arith_compute_ov(ctx, t0, arg1, arg2, 1);
     }
     if (compute_ca) {
-        gen_op_update_ca_legacy(ca);
+        gen_op_update_ca(ctx, ca, ca32);
     }
     if (unlikely(compute_rc0)) {
         gen_set_Rc0(ctx, t0);
-- 
2.7.4
