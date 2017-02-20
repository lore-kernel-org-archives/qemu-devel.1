Received: from eggs.gnu.org ([2001:4830:134:3::10]:49324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cflJ7-0003QT-Hw
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 05:35:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cflJ2-000146-LY
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 05:35:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52477
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cflJ2-00013V-GF
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 05:34:56 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1KAXomT065207
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 05:34:53 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28pgs4kvgc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 05:34:53 -0500
Received: from localhost
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Mon, 20 Feb 2017 20:34:50 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Mon, 20 Feb 2017 15:42:00 +0530
In-Reply-To: <1487585521-19445-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1487585521-19445-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1487585521-19445-10-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 09/10] target/ppc: add ov32 flag in divide
 operations
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

Add helper_div_compute_ov() in the int_helper for updating the overflow
flags.

For Divide Word:
SO, OV, and OV32 bits reflects overflow of the 32-bit result

For Divide DoubleWord:
SO, OV, and OV32 bits reflects overflow of the 64-bit result

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target/ppc/int_helper.c | 49 ++++++++++++++++---------------------------------
 target/ppc/translate.c  |  6 ++++--
 2 files changed, 20 insertions(+), 35 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index dd0a892..34b54e1 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -28,6 +28,18 @@
 /*****************************************************************************/
 /* Fixed point operations helpers */
 
+static inline void helper_div_compute_ov(CPUPPCState *env, uint32_t oe,
+                                         int overflow)
+{
+    if (oe) {
+        if (unlikely(overflow)) {
+            env->so = env->ov = env->ov32 = 1;
+        } else {
+            env->ov = env->ov32 = 0;
+        }
+    }
+}
+
 target_ulong helper_divweu(CPUPPCState *env, target_ulong ra, target_ulong rb,
                            uint32_t oe)
 {
@@ -48,14 +60,7 @@ target_ulong helper_divweu(CPUPPCState *env, target_ulong ra, target_ulong rb,
         rt = 0; /* Undefined */
     }
 
-    if (oe) {
-        if (unlikely(overflow)) {
-            env->so = env->ov = 1;
-        } else {
-            env->ov = 0;
-        }
-    }
-
+    helper_div_compute_ov(env, oe, overflow);
     return (target_ulong)rt;
 }
 
@@ -80,14 +85,7 @@ target_ulong helper_divwe(CPUPPCState *env, target_ulong ra, target_ulong rb,
         rt = 0; /* Undefined */
     }
 
-    if (oe) {
-        if (unlikely(overflow)) {
-            env->so = env->ov = 1;
-        } else {
-            env->ov = 0;
-        }
-    }
-
+    helper_div_compute_ov(env, oe, overflow);
     return (target_ulong)rt;
 }
 
@@ -104,14 +102,7 @@ uint64_t helper_divdeu(CPUPPCState *env, uint64_t ra, uint64_t rb, uint32_t oe)
         rt = 0; /* Undefined */
     }
 
-    if (oe) {
-        if (unlikely(overflow)) {
-            env->so = env->ov = 1;
-        } else {
-            env->ov = 0;
-        }
-    }
-
+    helper_div_compute_ov(env, oe, overflow);
     return rt;
 }
 
@@ -126,15 +117,7 @@ uint64_t helper_divde(CPUPPCState *env, uint64_t rau, uint64_t rbu, uint32_t oe)
         rt = 0; /* Undefined */
     }
 
-    if (oe) {
-
-        if (unlikely(overflow)) {
-            env->so = env->ov = 1;
-        } else {
-            env->ov = 0;
-        }
-    }
-
+    helper_div_compute_ov(env, oe, overflow);
     return rt;
 }
 
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 69ec0b2..ee44205 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1022,6 +1022,7 @@ static inline void gen_op_arith_divw(DisasContext *ctx, TCGv ret, TCGv arg1,
     }
     if (compute_ov) {
         tcg_gen_extu_i32_tl(cpu_ov, t2);
+        tcg_gen_extu_i32_tl(cpu_ov32, t2);
         tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
     }
     tcg_temp_free_i32(t0);
@@ -1093,6 +1094,7 @@ static inline void gen_op_arith_divd(DisasContext *ctx, TCGv ret, TCGv arg1,
     }
     if (compute_ov) {
         tcg_gen_mov_tl(cpu_ov, t2);
+        tcg_gen_mov_tl(cpu_ov32, t2);
         tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
     }
     tcg_temp_free_i64(t0);
@@ -1111,10 +1113,10 @@ static void glue(gen_, name)(DisasContext *ctx)
                       cpu_gpr[rA(ctx->opcode)], cpu_gpr[rB(ctx->opcode)],     \
                       sign, compute_ov);                                      \
 }
-/* divwu  divwu.  divwuo  divwuo.   */
+/* divdu  divdu.  divduo  divduo.   */
 GEN_INT_ARITH_DIVD(divdu, 0x0E, 0, 0);
 GEN_INT_ARITH_DIVD(divduo, 0x1E, 0, 1);
-/* divw  divw.  divwo  divwo.   */
+/* divd  divd.  divdo  divdo.   */
 GEN_INT_ARITH_DIVD(divd, 0x0F, 1, 0);
 GEN_INT_ARITH_DIVD(divdo, 0x1F, 1, 1);
 
-- 
2.7.4
