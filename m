Received: from eggs.gnu.org ([2001:4830:134:3::10]:41218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgzVl-0005LV-5k
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:57:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgzVj-0001lk-SK
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:57:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60110
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cgzVj-0001l5-L3
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:57:07 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1NJtNoI044104
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 14:57:07 -0500
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28t3cwqyfc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 14:57:06 -0500
Received: from localhost
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 24 Feb 2017 01:27:03 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Fri, 24 Feb 2017 01:26:33 +0530
In-Reply-To: <1487879800-12352-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1487879800-12352-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1487879800-12352-9-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4 08/15] target/ppc: update ca32 in arithmetic
 add
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

Adds routine to compute ca32 - gen_op_arith_compute_ca32

For 64-bit mode use the compute ca32 routine. While for 32-bit mode, CA
and CA32 will have same value.

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target/ppc/translate.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 5be1bb9..c98e708 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -799,6 +799,28 @@ static inline void gen_op_update_ca_legacy(TCGv ca)
     tcg_temp_free(t0);
 }
 
+static inline void gen_op_update_ca_isa300(TCGv ca, TCGv ca32)
+{
+    TCGv t0 = tcg_temp_new();
+
+    tcg_gen_movi_tl(t0, XER_CA | XER_CA32);
+    tcg_gen_andc_tl(cpu_xer, cpu_xer, t0);
+    tcg_gen_shli_tl(t0, ca, XER_CA_BIT);
+    tcg_gen_or_tl(cpu_xer, cpu_xer, t0);
+    tcg_gen_shli_tl(t0, ca32, XER_CA32_BIT);
+    tcg_gen_or_tl(cpu_xer, cpu_xer, t0);
+    tcg_temp_free(t0);
+}
+
+static inline void gen_op_update_ca(DisasContext *ctx, TCGv ca, TCGv ca32)
+{
+    if (is_isa300(ctx)) {
+        gen_op_update_ca_isa300(ca, ca32);
+    } else {
+        gen_op_update_ca_legacy(ca);
+    }
+}
+
 static inline void gen_op_update_ov_legacy(TCGv ov)
 {
     TCGv t1 = tcg_temp_new();
@@ -844,6 +866,23 @@ static inline void gen_op_arith_compute_ov(DisasContext *ctx, TCGv arg0,
     tcg_temp_free(ov);
 }
 
+static inline void gen_op_arith_compute_ca32(DisasContext *ctx, TCGv ca32,
+                                             TCGv res, TCGv arg0, TCGv arg1,
+                                             int sub)
+{
+    TCGv t0;
+
+    if (!is_isa300(ctx)) {
+        return;
+    }
+
+    t0 = tcg_temp_new();
+    tcg_gen_xor_tl(t0, arg0, arg1);
+    tcg_gen_xor_tl(t0, t0, res);
+    tcg_gen_extract_tl(ca32, t0, 32, 1);
+    tcg_temp_free(t0);
+}
+
 /* Common add function */
 static inline void gen_op_arith_add(DisasContext *ctx, TCGv ret, TCGv arg1,
                                     TCGv arg2, bool add_ca, bool compute_ca,
@@ -851,6 +890,7 @@ static inline void gen_op_arith_add(DisasContext *ctx, TCGv ret, TCGv arg1,
 {
     TCGv t0 = ret;
     TCGv ca = tcg_temp_new();
+    TCGv ca32 = tcg_temp_new();
 
     if (compute_ca || compute_ov) {
         t0 = tcg_temp_new();
@@ -874,6 +914,9 @@ static inline void gen_op_arith_add(DisasContext *ctx, TCGv ret, TCGv arg1,
             tcg_gen_xor_tl(ca, t0, t1);        /* bits changed w/ carry */
             tcg_temp_free(t1);
             tcg_gen_extract_tl(ca, ca, 32, 1);
+            if (is_isa300(ctx)) {
+                tcg_gen_mov_tl(ca32, ca);
+            }
         } else {
             TCGv zero = tcg_const_tl(0);
             if (add_ca) {
@@ -882,6 +925,7 @@ static inline void gen_op_arith_add(DisasContext *ctx, TCGv ret, TCGv arg1,
             } else {
                 tcg_gen_add2_tl(t0, ca, arg1, zero, arg2, zero);
             }
+            gen_op_arith_compute_ca32(ctx, ca32, t0, arg1, arg2, 0);
             tcg_temp_free(zero);
         }
     } else {
@@ -895,7 +939,7 @@ static inline void gen_op_arith_add(DisasContext *ctx, TCGv ret, TCGv arg1,
         gen_op_arith_compute_ov(ctx, t0, arg1, arg2, 0);
     }
     if (compute_ca) {
-        gen_op_update_ca_legacy(ca);
+        gen_op_update_ca(ctx, ca, ca32);
     }
     if (unlikely(compute_rc0)) {
         gen_set_Rc0(ctx, t0);
@@ -906,6 +950,7 @@ static inline void gen_op_arith_add(DisasContext *ctx, TCGv ret, TCGv arg1,
         tcg_temp_free(t0);
     }
     tcg_temp_free(ca);
+    tcg_temp_free(ca32);
 }
 /* Add functions with two operands */
 #define GEN_INT_ARITH_ADD(name, opc3, add_ca, compute_ca, compute_ov)         \
-- 
2.7.4
