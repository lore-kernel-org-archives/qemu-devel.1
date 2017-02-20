Received: from eggs.gnu.org ([2001:4830:134:3::10]:44364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cfkz8-0001Rs-GV
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 05:14:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cfkz5-0003Cu-DV
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 05:14:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cfkz5-0003CQ-3M
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 05:14:19 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1KA9rYZ001559
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 05:14:17 -0500
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28qw8wb259-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 05:14:16 -0500
Received: from localhost
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Mon, 20 Feb 2017 20:14:14 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Mon, 20 Feb 2017 15:41:53 +0530
In-Reply-To: <1487585521-19445-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1487585521-19445-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1487585521-19445-3-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 02/10] target/ppc: Update ca32 in arithmetic
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
 target/ppc/translate.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 498b095..2a2d071 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -816,6 +816,36 @@ static inline void gen_op_arith_compute_ov(DisasContext *ctx, TCGv arg0,
     tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
 }
 
+static inline void gen_op_arith_compute_ca32(DisasContext *ctx, TCGv arg0,
+                                             TCGv arg1, bool add_ca, int sub)
+{
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+    TCGv inv0 = tcg_temp_new();
+
+    tcg_gen_extract_tl(t0, arg0, 0, 32);
+    tcg_gen_extract_tl(t1, arg1, 0, 32);
+    if (sub) {
+        tcg_gen_not_tl(inv0, t0);
+        if (add_ca) {
+            tcg_gen_add_tl(t1, t1, cpu_ca32);
+        } else {
+            tcg_gen_addi_tl(t1, t1, 1);
+        }
+        tcg_gen_add_tl(t0, t1, inv0);
+        tcg_gen_extract_tl(cpu_ca32, t0, 32, 1);
+    } else {
+        tcg_gen_add_tl(t0, t0, t1);
+        if (add_ca) {
+            tcg_gen_add_tl(t0, t0, cpu_ca32);
+        }
+        tcg_gen_extract_tl(cpu_ca32, t0, 32, 1);
+    }
+    tcg_temp_free(t0);
+    tcg_temp_free(t1);
+}
+
+
 /* Common add function */
 static inline void gen_op_arith_add(DisasContext *ctx, TCGv ret, TCGv arg1,
                                     TCGv arg2, bool add_ca, bool compute_ca,
@@ -842,6 +872,7 @@ static inline void gen_op_arith_add(DisasContext *ctx, TCGv ret, TCGv arg1,
             tcg_temp_free(t1);
             tcg_gen_shri_tl(cpu_ca, cpu_ca, 32);   /* extract bit 32 */
             tcg_gen_andi_tl(cpu_ca, cpu_ca, 1);
+            tcg_gen_mov_tl(cpu_ca32, cpu_ca);
         } else {
             TCGv zero = tcg_const_tl(0);
             if (add_ca) {
@@ -850,6 +881,7 @@ static inline void gen_op_arith_add(DisasContext *ctx, TCGv ret, TCGv arg1,
             } else {
                 tcg_gen_add2_tl(t0, cpu_ca, arg1, zero, arg2, zero);
             }
+            gen_op_arith_compute_ca32(ctx, arg1, arg2, add_ca, 0);
             tcg_temp_free(zero);
         }
     } else {
-- 
2.7.4
