Received: from eggs.gnu.org ([2001:4830:134:3::10]:39932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKZ-0002tZ-6l
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKU-000707-RH
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:27 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  3 Jul 2018 15:57:53 +1000
Message-Id: <20180703055804.13449-25-david@gibson.dropbear.id.au>
In-Reply-To: <20180703055804.13449-1-david@gibson.dropbear.id.au>
References: <20180703055804.13449-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 24/35] fpu_helper.c: fix setting FPSCR[FI] bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, John Arbuckle <programmingkidx@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

From: John Arbuckle <programmingkidx@gmail.com>

The FPSCR[FI] bit indicates if the last floating point instruction had a result that was rounded. Each consecutive floating point instruction is suppose to set this bit to the correct value. What currently happens is this bit is not set as often as it should be. I have verified that this is the behavior of a real PowerPC 950. This patch fixes that problem by deciding to set this bit after each floating point instruction.

https://www.pdfdrive.net/powerpc-microprocessor-family-the-programming-environments-for-32-e3087633.html
Page 63 in table 2-4 is where the description of this bit can be found.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/fpu_helper.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 7714bfe0f9..8675d931b6 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -274,6 +274,7 @@ static inline void float_inexact_excp(CPUPPCState *env)
 {
     CPUState *cs = CPU(ppc_env_get_cpu(env));
 
+    env->fpscr |= 1 << FPSCR_FI;
     env->fpscr |= 1 << FPSCR_XX;
     /* Update the floating-point exception summary */
     env->fpscr |= FP_FX;
@@ -533,6 +534,7 @@ static void do_float_check_status(CPUPPCState *env, uintptr_t raddr)
 {
     CPUState *cs = CPU(ppc_env_get_cpu(env));
     int status = get_float_exception_flags(&env->fp_status);
+    bool inexact_happened = false;
 
     if (status & float_flag_divbyzero) {
         float_zero_divide_excp(env, raddr);
@@ -542,6 +544,12 @@ static void do_float_check_status(CPUPPCState *env, uintptr_t raddr)
         float_underflow_excp(env);
     } else if (status & float_flag_inexact) {
         float_inexact_excp(env);
+        inexact_happened = true;
+    }
+
+    /* if the inexact flag was not set */
+    if (inexact_happened == false) {
+        env->fpscr &= ~(1 << FPSCR_FI); /* clear the FPSCR[FI] bit */
     }
 
     if (cs->exception_index == POWERPC_EXCP_PROGRAM &&
-- 
2.17.1
