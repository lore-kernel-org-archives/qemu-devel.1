Received: from eggs.gnu.org ([2001:4830:134:3::10]:33176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fXEBv-0005kS-SI
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 19:13:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fXEBu-0002Fp-R7
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 19:13:07 -0400
From: John Arbuckle <programmingkidx@gmail.com>
Date: Sun, 24 Jun 2018 19:12:48 -0400
Message-Id: <20180624231248.6827-1-programmingkidx@gmail.com>
Subject: [Qemu-devel] [PATCH] fpu_helper.c: fix setting FPSCR[FI] bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: david@gibson.dropbear.id.au, agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: John Arbuckle <programmingkidx@gmail.com>

The FPSCR[FI] bit indicates if the last floating point instruction had a result that was rounded. Each consecutive floating point instruction is suppose to set this bit to the correct value. What currently happens is this bit is not set as often as it should be. I have verified that this is the behavior of a real PowerPC 950. This patch fixes that problem by deciding to set this bit after each floating point instruction.

https://www.pdfdrive.net/powerpc-microprocessor-family-the-programming-environments-for-32-e3087633.html
Page 63 in table 2-4 is where the description of this bit can be found.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
 target/ppc/fpu_helper.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index d31a933cbb..9c841864c8 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -274,6 +274,7 @@ static inline void float_inexact_excp(CPUPPCState *env)
 {
     CPUState *cs = CPU(ppc_env_get_cpu(env));
 
+    env->fpscr |= 1 << FPSCR_FI;
     env->fpscr |= 1 << FPSCR_XX;
     /* Update the floating-point exception summary */
     env->fpscr |= FP_FX;
@@ -505,6 +506,7 @@ static void do_float_check_status(CPUPPCState *env, uintptr_t raddr)
 {
     CPUState *cs = CPU(ppc_env_get_cpu(env));
     int status = get_float_exception_flags(&env->fp_status);
+    bool inexact_happened = false;
 
     if (status & float_flag_divbyzero) {
         float_zero_divide_excp(env, raddr);
@@ -514,6 +516,12 @@ static void do_float_check_status(CPUPPCState *env, uintptr_t raddr)
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
2.14.3 (Apple Git-98)
