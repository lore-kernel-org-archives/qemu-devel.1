Received: from eggs.gnu.org ([2001:4830:134:3::10]:42409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cP6By-0000SC-SO
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 06:26:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cP6Bx-0006RC-QX
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 06:26:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cP6Bx-0006QB-Gs
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 06:26:45 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v05BO2kk016705
	for <qemu-devel@nongnu.org>; Thu, 5 Jan 2017 06:26:44 -0500
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27sk0kem1d-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 05 Jan 2017 06:26:44 -0500
Received: from localhost
	by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 5 Jan 2017 16:56:40 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Thu,  5 Jan 2017 16:56:13 +0530
In-Reply-To: <1483615579-17618-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1483615579-17618-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1483615579-17618-9-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 08/14] target-ppc: Use correct precision for
 FPRF setting
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

From: Bharata B Rao <bharata@linux.vnet.ibm.com>

Use correct FP precision when setting FPRF in FP conversion helpers
instead of always assuming float64 precision.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target-ppc/fpu_helper.c | 4 ++--
 target-ppc/internal.h   | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/target-ppc/fpu_helper.c b/target-ppc/fpu_helper.c
index aacfd12..05b2926 100644
--- a/target-ppc/fpu_helper.c
+++ b/target-ppc/fpu_helper.c
@@ -109,6 +109,7 @@ void helper_compute_fprf_##tp(CPUPPCState *env, tp arg)        \
 }
 
 COMPUTE_FPRF(float16)
+COMPUTE_FPRF(float32)
 COMPUTE_FPRF(float64)
 COMPUTE_FPRF(float128)
 
@@ -2688,8 +2689,7 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                \
             xt.tfld = ttp##_snan_to_qnan(xt.tfld);                 \
         }                                                          \
         if (sfprf) {                                               \
-            helper_compute_fprf_float64(env, ttp##_to_float64(xt.tfld, \
-                                &env->fp_status));                 \
+            helper_compute_fprf_##ttp(env, xt.tfld);               \
         }                                                          \
     }                                                              \
                                                                    \
diff --git a/target-ppc/internal.h b/target-ppc/internal.h
index 16fc117..8dcc679 100644
--- a/target-ppc/internal.h
+++ b/target-ppc/internal.h
@@ -246,4 +246,5 @@ static inline void putVSR(int n, ppc_vsr_t *vsr, CPUPPCState *env)
 
 void helper_compute_fprf_float128(CPUPPCState *env, float128 arg);
 void helper_compute_fprf_float16(CPUPPCState *env, float16 arg);
+void helper_compute_fprf_float32(CPUPPCState *env, float32 arg);
 #endif /* PPC_INTERNAL_H */
-- 
2.7.4
