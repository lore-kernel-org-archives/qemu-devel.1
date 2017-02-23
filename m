Received: from eggs.gnu.org ([2001:4830:134:3::10]:41250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgzVl-0005Mo-Pz
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:57:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgzVk-0001mN-C0
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:57:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38431
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cgzVk-0001lh-4e
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:57:08 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1NJrbRJ157217
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 14:57:07 -0500
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28t1a1xxrp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 14:57:07 -0500
Received: from localhost
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 24 Feb 2017 01:27:04 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Fri, 24 Feb 2017 01:26:37 +0530
In-Reply-To: <1487879800-12352-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1487879800-12352-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1487879800-12352-13-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4 12/15] target/ppc: update OV/OV32 for divide
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

Add helper_update_ov_isa300() in the int_helper for updating the
overflow flags.

For Divide Word:
SO, OV, and OV32 bits reflects overflow of the 32-bit result

For Divide DoubleWord:
SO, OV, and OV32 bits reflects overflow of the 64-bit result

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target/ppc/int_helper.c | 17 +++++++++++++++++
 target/ppc/translate.c  |  8 ++++----
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index b0c3c2b..8cedce6 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -36,6 +36,23 @@ static inline void helper_update_ov_legacy(CPUPPCState *env, int ov)
     }
 }
 
+static inline void helper_update_ov_isa300(CPUPPCState *env, int ov, int ov32)
+{
+    env->xer = env->xer & ~(XER_OV | XER_OV32);
+    if (ov) {
+        env->xer |= XER_SO | XER_OV | XER_OV32;
+    }
+}
+
+static inline void helper_update_ov(CPUPPCState *env, int ov)
+{
+    if (is_isa300(env)) {
+        helper_update_ov_isa300(env, ov, ov);
+    } else {
+        helper_update_ov_legacy(env, ov);
+    }
+}
+
 static inline void helper_update_ca(CPUPPCState *env, int ca)
 {
     env->xer = env->xer & ~(XER_CA);
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index e1105e8..f7d37b0 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1100,7 +1100,7 @@ static inline void gen_op_arith_divw(DisasContext *ctx, TCGv ret, TCGv arg1,
     if (compute_ov) {
         TCGv ov = tcg_temp_new();
         tcg_gen_extu_i32_tl(ov, t2);
-        gen_op_update_ov_legacy(ov);
+        gen_op_update_ov(ctx, ov, ov);
         tcg_temp_free(ov);
     }
     tcg_temp_free_i32(t0);
@@ -1171,7 +1171,7 @@ static inline void gen_op_arith_divd(DisasContext *ctx, TCGv ret, TCGv arg1,
         tcg_gen_divu_i64(ret, t0, t1);
     }
     if (compute_ov) {
-        gen_op_update_ov_legacy(t2);
+        gen_op_update_ov(ctx, t2, t2);
     }
     tcg_temp_free_i64(t0);
     tcg_temp_free_i64(t1);
@@ -1189,10 +1189,10 @@ static void glue(gen_, name)(DisasContext *ctx)
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
