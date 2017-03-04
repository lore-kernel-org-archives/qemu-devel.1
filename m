Received: from eggs.gnu.org ([2001:4830:134:3::10]:41958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1ckAGY-0005Ya-0d
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 09:02:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1ckAGT-00043T-0U
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 09:02:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55685)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1ckAGS-000433-OQ
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 09:02:28 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v24DxLBu125296
	for <qemu-devel@nongnu.org>; Sat, 4 Mar 2017 09:02:27 -0500
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28yuxynxs3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 04 Mar 2017 09:02:27 -0500
Received: from localhost
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Sat, 4 Mar 2017 19:32:24 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Sat,  4 Mar 2017 19:32:09 +0530
In-Reply-To: <1488636129-19409-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1488636129-19409-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1488636129-19409-4-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 3/3] target/ppc: use helper for excp handling
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

Use the helper routine float[32,64]_maddsub_update_excp() in VSX_MADD
macro.

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target/ppc/fpu_helper.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 13bd6ce..c4dab15 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -773,6 +773,7 @@ static void NAME(CPUPPCState *env, TP arg1, TP arg2, TP arg3,           \
         }                                                               \
     }                                                                   \
 }
+FPU_MADDSUB_UPDATE(float32_maddsub_update_excp, float32)
 FPU_MADDSUB_UPDATE(float64_maddsub_update_excp, float64)
 
 #define FPU_FMADD(op, madd_flags)                                       \
@@ -2239,24 +2240,7 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                           \
         env->fp_status.float_exception_flags |= tstat.float_exception_flags;  \
                                                                               \
         if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {     \
-            if (tp##_is_signaling_nan(xa.fld, &tstat) ||                      \
-                tp##_is_signaling_nan(b->fld, &tstat) ||                      \
-                tp##_is_signaling_nan(c->fld, &tstat)) {                      \
-                float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, sfprf);    \
-                tstat.float_exception_flags &= ~float_flag_invalid;           \
-            }                                                                 \
-            if ((tp##_is_infinity(xa.fld) && tp##_is_zero(b->fld)) ||         \
-                (tp##_is_zero(xa.fld) && tp##_is_infinity(b->fld))) {         \
-                xt_out.fld = float64_to_##tp(float_invalid_op_excp(env,       \
-                    POWERPC_EXCP_FP_VXIMZ, sfprf), &env->fp_status);          \
-                tstat.float_exception_flags &= ~float_flag_invalid;           \
-            }                                                                 \
-            if ((tstat.float_exception_flags & float_flag_invalid) &&         \
-                ((tp##_is_infinity(xa.fld) ||                                 \
-                  tp##_is_infinity(b->fld)) &&                                \
-                  tp##_is_infinity(c->fld))) {                                \
-                float_invalid_op_excp(env, POWERPC_EXCP_FP_VXISI, sfprf);     \
-            }                                                                 \
+            tp##_maddsub_update_excp(env, xa.fld, b->fld, c->fld, maddflgs);  \
         }                                                                     \
                                                                               \
         if (r2sp) {                                                           \
-- 
2.7.4
