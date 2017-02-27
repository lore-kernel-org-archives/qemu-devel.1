Received: from eggs.gnu.org ([2001:4830:134:3::10]:60771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1ciDOC-0006aw-Sw
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 23:58:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1ciDO9-0002Lq-AO
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 23:58:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44967
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1ciDO9-0002LM-5u
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 23:58:21 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1R4s45T065289
	for <qemu-devel@nongnu.org>; Sun, 26 Feb 2017 23:58:20 -0500
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28u8vt2m9v-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 26 Feb 2017 23:58:19 -0500
Received: from localhost
	by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Mon, 27 Feb 2017 10:28:16 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Mon, 27 Feb 2017 10:27:56 +0530
In-Reply-To: <1488171481-21699-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1488171481-21699-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1488171481-21699-4-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v6 3/8] target/ppc: update ca32 in arithmetic
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
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 target/ppc/translate.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index eba83ef..e083082 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -827,7 +827,11 @@ static inline void gen_op_arith_compute_ca32(DisasContext *ctx,
     }
 
     t0 = tcg_temp_new();
-    tcg_gen_xor_tl(t0, arg0, arg1);
+    if (sub) {
+        tcg_gen_eqv_tl(t0, arg0, arg1);
+    } else {
+        tcg_gen_xor_tl(t0, arg0, arg1);
+    }
     tcg_gen_xor_tl(t0, t0, res);
     tcg_gen_extract_tl(cpu_ca32, t0, 32, 1);
     tcg_temp_free(t0);
@@ -1378,17 +1382,22 @@ static inline void gen_op_arith_subf(DisasContext *ctx, TCGv ret, TCGv arg1,
             tcg_temp_free(t1);
             tcg_gen_shri_tl(cpu_ca, cpu_ca, 32);    /* extract bit 32 */
             tcg_gen_andi_tl(cpu_ca, cpu_ca, 1);
+            if (is_isa300(ctx)) {
+                tcg_gen_mov_tl(cpu_ca32, cpu_ca);
+            }
         } else if (add_ca) {
             TCGv zero, inv1 = tcg_temp_new();
             tcg_gen_not_tl(inv1, arg1);
             zero = tcg_const_tl(0);
             tcg_gen_add2_tl(t0, cpu_ca, arg2, zero, cpu_ca, zero);
             tcg_gen_add2_tl(t0, cpu_ca, t0, cpu_ca, inv1, zero);
+            gen_op_arith_compute_ca32(ctx, t0, inv1, arg2, 0);
             tcg_temp_free(zero);
             tcg_temp_free(inv1);
         } else {
             tcg_gen_setcond_tl(TCG_COND_GEU, cpu_ca, arg2, arg1);
             tcg_gen_sub_tl(t0, arg2, arg1);
+            gen_op_arith_compute_ca32(ctx, t0, arg1, arg2, 1);
         }
     } else if (add_ca) {
         /* Since we're ignoring carry-out, we can simplify the
-- 
2.7.4
