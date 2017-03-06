Received: from eggs.gnu.org ([2001:4830:134:3::10]:47508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ckjwo-0005A9-Sr
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 23:08:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ckjwn-0003uV-Sf
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 23:08:34 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  6 Mar 2017 15:08:23 +1100
Message-Id: <20170306040823.28482-6-david@gibson.dropbear.id.au>
In-Reply-To: <20170306040823.28482-1-david@gibson.dropbear.id.au>
References: <20170306040823.28482-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 5/5] target/ppc: use helper for excp handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

Use the helper routine float[32,64]_maddsub_update_excp() in VSX_MADD
macro.

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
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
2.9.3
