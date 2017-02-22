Received: from eggs.gnu.org ([2001:4830:134:3::10]:56995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgVMN-0000P8-Fq
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 06:45:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgVMJ-0003bw-2B
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 06:45:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cgVMI-0003bg-PQ
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 06:45:22 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1MBi44J027429
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 06:45:21 -0500
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28s5ksa4xj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 06:45:20 -0500
Received: from localhost
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Wed, 22 Feb 2017 17:15:17 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Wed, 22 Feb 2017 17:14:37 +0530
In-Reply-To: <1487763883-4877-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1487763883-4877-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1487763883-4877-5-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 04/10] target/ppc: update ca32 in arithmetic
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
 target/ppc/translate.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index c9f6768..9165450 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -816,6 +816,23 @@ static inline void gen_op_arith_compute_ov(DisasContext *ctx, TCGv arg0,
     tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
 }
 
+static inline void gen_op_arith_compute_ca32(DisasContext *ctx,
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
+    tcg_gen_extract_tl(cpu_ca32, t0, 32, 1);
+    tcg_temp_free(t0);
+}
+
 /* Common add function */
 static inline void gen_op_arith_add(DisasContext *ctx, TCGv ret, TCGv arg1,
                                     TCGv arg2, bool add_ca, bool compute_ca,
@@ -842,6 +859,9 @@ static inline void gen_op_arith_add(DisasContext *ctx, TCGv ret, TCGv arg1,
             tcg_temp_free(t1);
             tcg_gen_shri_tl(cpu_ca, cpu_ca, 32);   /* extract bit 32 */
             tcg_gen_andi_tl(cpu_ca, cpu_ca, 1);
+            if (is_isa300(ctx)) {
+                tcg_gen_mov_tl(cpu_ca32, cpu_ca);
+            }
         } else {
             TCGv zero = tcg_const_tl(0);
             if (add_ca) {
@@ -850,6 +870,7 @@ static inline void gen_op_arith_add(DisasContext *ctx, TCGv ret, TCGv arg1,
             } else {
                 tcg_gen_add2_tl(t0, cpu_ca, arg1, zero, arg2, zero);
             }
+            gen_op_arith_compute_ca32(ctx, t0, arg1, arg2, 0);
             tcg_temp_free(zero);
         }
     } else {
-- 
2.7.4
