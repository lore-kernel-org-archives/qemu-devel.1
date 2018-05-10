Received: from eggs.gnu.org ([2001:4830:134:3::10]:40967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fGlBV-0003kh-Dt
	for qemu-devel@nongnu.org; Thu, 10 May 2018 09:00:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fGlBU-0004ui-LT
	for qemu-devel@nongnu.org; Thu, 10 May 2018 09:00:37 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41560)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fGlBU-0004sX-DB
	for qemu-devel@nongnu.org; Thu, 10 May 2018 09:00:36 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 May 2018 14:00:24 +0100
Message-Id: <20180510130024.31678-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] tcg: Optionally log FPU state in TCG -d cpu
 logging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

Usually the logging of the CPU state produced by -d cpu is sufficient
to diagnose problems, but sometimes you want to see the state of
the floating point registers as well. We don't want to enable that
by default as it adds a lot of extra data to the log; instead,
allow it to be optionally enabled via -d fpu.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I've found this helpful while tracking down fp-emulation related bugs.

 include/qemu/log.h   | 1 +
 accel/tcg/cpu-exec.c | 9 ++++++---
 util/log.c           | 2 ++
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/qemu/log.h b/include/qemu/log.h
index ff92a8b86a..b097a6cae1 100644
--- a/include/qemu/log.h
+++ b/include/qemu/log.h
@@ -44,6 +44,7 @@ static inline bool qemu_log_separate(void)
 #define CPU_LOG_PAGE       (1 << 14)
 /* LOG_TRACE (1 << 15) is defined in log-for-trace.h */
 #define CPU_LOG_TB_OP_IND  (1 << 16)
+#define CPU_LOG_TB_FPU     (1 << 17)
 
 /* Lock output for a series of related logs.  Since this is not needed
  * for a single qemu_log / qemu_log_mask / qemu_log_mask_and_addr, we
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 81153e7a13..0b154cc678 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -156,11 +156,14 @@ static inline tcg_target_ulong cpu_tb_exec(CPUState *cpu, TranslationBlock *itb)
     if (qemu_loglevel_mask(CPU_LOG_TB_CPU)
         && qemu_log_in_addr_range(itb->pc)) {
         qemu_log_lock();
+        int flags = 0;
+        if (qemu_loglevel_mask(CPU_LOG_TB_FPU)) {
+            flags |= CPU_DUMP_FPU;
+        }
 #if defined(TARGET_I386)
-        log_cpu_state(cpu, CPU_DUMP_CCOP);
-#else
-        log_cpu_state(cpu, 0);
+        flags |= CPU_DUMP_CCOP;
 #endif
+        log_cpu_state(cpu, flags);
         qemu_log_unlock();
     }
 #endif /* DEBUG_DISAS */
diff --git a/util/log.c b/util/log.c
index 96f30dd21a..c0dbbd4700 100644
--- a/util/log.c
+++ b/util/log.c
@@ -256,6 +256,8 @@ const QEMULogItem qemu_log_items[] = {
       "show trace before each executed TB (lots of logs)" },
     { CPU_LOG_TB_CPU, "cpu",
       "show CPU registers before entering a TB (lots of logs)" },
+    { CPU_LOG_TB_FPU, "fpu",
+      "include FPU registers in the 'cpu' logging" },
     { CPU_LOG_MMU, "mmu",
       "log MMU-related activities" },
     { CPU_LOG_PCALL, "pcall",
-- 
2.17.0
