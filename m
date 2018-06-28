Received: from eggs.gnu.org ([2001:4830:134:3::10]:39846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYNDf-0004tf-Hw
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:03:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYNDe-0007dZ-85
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:03:39 -0400
Received: from mail-pf0-x235.google.com ([2607:f8b0:400e:c00::235]:35360)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fYNDe-0007dB-2M
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:03:38 -0400
Received: by mail-pf0-x235.google.com with SMTP id c22-v6so1891881pfi.2
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 20:03:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 27 Jun 2018 20:03:10 -0700
Message-Id: <20180628030330.15615-4-richard.henderson@linaro.org>
In-Reply-To: <20180628030330.15615-1-richard.henderson@linaro.org>
References: <20180628030330.15615-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 03/23] target/openrisc: Log interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: shorne@gmail.com

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/interrupt.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
index 3959671c59..25351d5de3 100644
--- a/target/openrisc/interrupt.c
+++ b/target/openrisc/interrupt.c
@@ -32,6 +32,7 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
 #ifndef CONFIG_USER_ONLY
     OpenRISCCPU *cpu = OPENRISC_CPU(cs);
     CPUOpenRISCState *env = &cpu->env;
+    int exception = cs->exception_index;
 
     env->epcr = env->pc;
     if (env->dflag) {
@@ -41,12 +42,12 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
     } else {
         env->sr &= ~SR_DSX;
     }
-    if (cs->exception_index == EXCP_SYSCALL) {
+    if (exception == EXCP_SYSCALL) {
         env->epcr += 4;
     }
     /* When we have an illegal instruction the error effective address
        shall be set to the illegal instruction address.  */
-    if (cs->exception_index == EXCP_ILLEGAL) {
+    if (exception == EXCP_ILLEGAL) {
         env->eear = env->pc;
     }
 
@@ -66,8 +67,27 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
     env->tlb->cpu_openrisc_map_address_code = &cpu_openrisc_get_phys_nommu;
     env->lock_addr = -1;
 
-    if (cs->exception_index > 0 && cs->exception_index < EXCP_NR) {
-        hwaddr vect_pc = cs->exception_index << 8;
+    if (exception > 0 && exception < EXCP_NR) {
+        static const char * const int_name[EXCP_NR] = {
+            [EXCP_RESET]    = "RESET",
+            [EXCP_BUSERR]   = "BUSERR (bus error)",
+            [EXCP_DPF]      = "DFP (data protection fault)",
+            [EXCP_IPF]      = "IPF (code protection fault)",
+            [EXCP_TICK]     = "TICK (timer interrupt)",
+            [EXCP_ALIGN]    = "ALIGN",
+            [EXCP_ILLEGAL]  = "ILLEGAL",
+            [EXCP_INT]      = "INT (device interrupt)",
+            [EXCP_DTLBMISS] = "DTLBMISS (data tlb miss)",
+            [EXCP_ITLBMISS] = "ITLBMISS (code tlb miss)",
+            [EXCP_RANGE]    = "RANGE",
+            [EXCP_SYSCALL]  = "SYSCALL",
+            [EXCP_FPE]      = "FPE",
+            [EXCP_TRAP]     = "TRAP",
+        };
+
+        qemu_log_mask(CPU_LOG_INT, "INT: %s\n", int_name[exception]);
+
+        hwaddr vect_pc = exception << 8;
         if (env->cpucfgr & CPUCFGR_EVBARP) {
             vect_pc |= env->evbar;
         }
@@ -76,7 +96,7 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
         }
         env->pc = vect_pc;
     } else {
-        cpu_abort(cs, "Unhandled exception 0x%x\n", cs->exception_index);
+        cpu_abort(cs, "Unhandled exception 0x%x\n", exception);
     }
 #endif
 
-- 
2.17.1
