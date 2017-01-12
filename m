Received: from eggs.gnu.org ([2001:4830:134:3::10]:47125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUkH-0003H7-JA
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:04:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUkF-0006qh-Rw
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:04:05 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:03:15 +1100
Message-Id: <20170112020327.24882-56-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 55/67] target-ppc: Use correct precision for
 FPRF setting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, Bharata B Rao <bharata@linux.vnet.ibm.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Bharata B Rao <bharata@linux.vnet.ibm.com>

Use correct FP precision when setting FPRF in FP conversion helpers
instead of always assuming float64 precision.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/fpu_helper.c | 4 ++--
 target/ppc/internal.h   | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index f4103f5..01b335f 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -109,6 +109,7 @@ void helper_compute_fprf_##tp(CPUPPCState *env, tp arg)        \
 }
 
 COMPUTE_FPRF(float16)
+COMPUTE_FPRF(float32)
 COMPUTE_FPRF(float64)
 
 /* Floating-point invalid operations exception */
@@ -2652,8 +2653,7 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                \
             xt.tfld = ttp##_snan_to_qnan(xt.tfld);                 \
         }                                                          \
         if (sfprf) {                                               \
-            helper_compute_fprf_float64(env, ttp##_to_float64(xt.tfld, \
-                                &env->fp_status));                 \
+            helper_compute_fprf_##ttp(env, xt.tfld);               \
         }                                                          \
     }                                                              \
                                                                    \
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 1e27209..187f024 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -244,4 +244,5 @@ static inline void putVSR(int n, ppc_vsr_t *vsr, CPUPPCState *env)
 }
 
 void helper_compute_fprf_float16(CPUPPCState *env, float16 arg);
+void helper_compute_fprf_float32(CPUPPCState *env, float32 arg);
 #endif /* PPC_INTERNAL_H */
-- 
2.9.3
