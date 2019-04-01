Received: from eggs.gnu.org ([209.51.188.92]:56918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hAuC3-0003VN-PT
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 06:29:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hAuC2-0005vn-1Y
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 06:29:31 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hAuC1-0005vQ-LT
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 06:29:29 -0400
Received: by mail-pg1-x543.google.com with SMTP id q1so4527598pgv.13
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 03:29:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  1 Apr 2019 17:29:09 +0700
Message-Id: <20190401102911.8685-5-richard.henderson@linaro.org>
In-Reply-To: <20190401102911.8685-1-richard.henderson@linaro.org>
References: <20190401102911.8685-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.1 4/6] target/s390x: Remove ilen
 parameter from tcg_s390_program_interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@redhat.com, cohuck@redhat.com, qemu-s390x@nongnu.org

Since we begin the operation with an unwind, we have the proper
value of ilen immediately available.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg_s390x.h   | 4 ++--
 target/s390x/excp_helper.c | 8 ++++----
 target/s390x/interrupt.c   | 2 +-
 target/s390x/tcg-stub.c    | 4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/s390x/tcg_s390x.h b/target/s390x/tcg_s390x.h
index ab2c4ba703..931ca5196c 100644
--- a/target/s390x/tcg_s390x.h
+++ b/target/s390x/tcg_s390x.h
@@ -14,8 +14,8 @@
 #define TCG_S390X_H
 
 void tcg_s390_tod_updated(CPUState *cs, run_on_cpu_data opaque);
-void QEMU_NORETURN tcg_s390_program_interrupt(CPUS390XState *env, uint32_t code,
-                                              int ilen, uintptr_t ra);
+void QEMU_NORETURN tcg_s390_program_interrupt(CPUS390XState *env,
+                                              uint32_t code, uintptr_t ra);
 void QEMU_NORETURN tcg_s390_data_exception(CPUS390XState *env, uint32_t dxc,
                                            uintptr_t ra);
 
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index f84bfb1284..c30872ef4f 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -33,15 +33,15 @@
 #include "hw/s390x/s390_flic.h"
 #endif
 
-void QEMU_NORETURN tcg_s390_program_interrupt(CPUS390XState *env, uint32_t code,
-                                              int ilen, uintptr_t ra)
+void QEMU_NORETURN tcg_s390_program_interrupt(CPUS390XState *env,
+                                              uint32_t code, uintptr_t ra)
 {
     CPUState *cs = CPU(s390_env_get_cpu(env));
 
     cpu_restore_state(cs, ra, true);
     qemu_log_mask(CPU_LOG_INT, "program interrupt at %#" PRIx64 "\n",
                   env->psw.addr);
-    trigger_pgm_exception(env, code, ilen);
+    trigger_pgm_exception(env, code, ILEN_UNWIND);
     cpu_loop_exit(cs);
 }
 
@@ -59,7 +59,7 @@ void QEMU_NORETURN tcg_s390_data_exception(CPUS390XState *env, uint32_t dxc,
     if (env->cregs[0] & CR0_AFP) {
         env->fpc = deposit32(env->fpc, 8, 8, dxc);
     }
-    tcg_s390_program_interrupt(env, PGM_DATA, ILEN_AUTO, ra);
+    tcg_s390_program_interrupt(env, PGM_DATA, ra);
 }
 
 void HELPER(data_exception)(CPUS390XState *env, uint32_t dxc)
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index 901cd713de..e24a757368 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -41,7 +41,7 @@ void s390_program_interrupt(CPUS390XState *env, uint32_t code, int ilen,
     if (kvm_enabled()) {
         kvm_s390_program_interrupt(cpu, code);
     } else if (tcg_enabled()) {
-        tcg_s390_program_interrupt(env, code, ilen, ra);
+        tcg_s390_program_interrupt(env, code, ra);
     } else {
         g_assert_not_reached();
     }
diff --git a/target/s390x/tcg-stub.c b/target/s390x/tcg-stub.c
index 32adb7276a..d22c898802 100644
--- a/target/s390x/tcg-stub.c
+++ b/target/s390x/tcg-stub.c
@@ -18,8 +18,8 @@
 void tcg_s390_tod_updated(CPUState *cs, run_on_cpu_data opaque)
 {
 }
-void QEMU_NORETURN tcg_s390_program_interrupt(CPUS390XState *env, uint32_t code,
-                                              int ilen, uintptr_t ra)
+void QEMU_NORETURN tcg_s390_program_interrupt(CPUS390XState *env,
+                                              uint32_t code, uintptr_t ra)
 {
     g_assert_not_reached();
 }
-- 
2.17.1
