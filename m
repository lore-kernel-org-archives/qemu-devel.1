Received: from eggs.gnu.org ([2001:4830:134:3::10]:56217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXJCz-0007yp-07
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:06:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXJCw-00027b-Bg
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:06:48 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42177)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gXJCw-0001oV-1D
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:06:46 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 13 Dec 2018 00:04:39 -0500
Message-Id: <20181213050453.9677-60-cota@braap.org>
In-Reply-To: <20181213050453.9677-1-cota@braap.org>
References: <20181213050453.9677-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 59/73] accel/tcg: convert to
 cpu_interrupt_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/cpu-exec.c      | 15 ++++++++-------
 accel/tcg/tcg-all.c       | 12 +++++++++---
 accel/tcg/translate-all.c |  2 +-
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index b4f46134d3..d7331d3370 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -428,7 +428,7 @@ static inline bool cpu_handle_halt_locked(CPUState *cpu)
 
     if (cpu_halted(cpu)) {
 #if defined(TARGET_I386) && !defined(CONFIG_USER_ONLY)
-        if ((cpu->interrupt_request & CPU_INTERRUPT_POLL)
+        if ((cpu_interrupt_request(cpu) & CPU_INTERRUPT_POLL)
             && replay_interrupt()) {
             X86CPU *x86_cpu = X86_CPU(cpu);
 
@@ -541,16 +541,17 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
      */
     atomic_mb_set(&cpu->icount_decr.u16.high, 0);
 
-    if (unlikely(atomic_read(&cpu->interrupt_request))) {
+    if (unlikely(cpu_interrupt_request(cpu))) {
         int interrupt_request;
+
         qemu_mutex_lock_iothread();
-        interrupt_request = cpu->interrupt_request;
+        interrupt_request = cpu_interrupt_request(cpu);
         if (unlikely(cpu->singlestep_enabled & SSTEP_NOIRQ)) {
             /* Mask out external interrupts for this step. */
             interrupt_request &= ~CPU_INTERRUPT_SSTEP_MASK;
         }
         if (interrupt_request & CPU_INTERRUPT_DEBUG) {
-            cpu->interrupt_request &= ~CPU_INTERRUPT_DEBUG;
+            cpu_reset_interrupt(cpu, CPU_INTERRUPT_DEBUG);
             cpu->exception_index = EXCP_DEBUG;
             qemu_mutex_unlock_iothread();
             return true;
@@ -559,7 +560,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
             /* Do nothing */
         } else if (interrupt_request & CPU_INTERRUPT_HALT) {
             replay_interrupt();
-            cpu->interrupt_request &= ~CPU_INTERRUPT_HALT;
+            cpu_reset_interrupt(cpu, CPU_INTERRUPT_HALT);
             cpu_halted_set(cpu, 1);
             cpu->exception_index = EXCP_HLT;
             qemu_mutex_unlock_iothread();
@@ -596,10 +597,10 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
             }
             /* The target hook may have updated the 'cpu->interrupt_request';
              * reload the 'interrupt_request' value */
-            interrupt_request = cpu->interrupt_request;
+            interrupt_request = cpu_interrupt_request(cpu);
         }
         if (interrupt_request & CPU_INTERRUPT_EXITTB) {
-            cpu->interrupt_request &= ~CPU_INTERRUPT_EXITTB;
+            cpu_reset_interrupt(cpu, CPU_INTERRUPT_EXITTB);
             /* ensure that no TB jump will be modified as
                the program flow was changed */
             *last_tb = NULL;
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 3d25bdcc17..4e2fe70350 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -39,10 +39,16 @@ unsigned long tcg_tb_size;
 static void tcg_handle_interrupt(CPUState *cpu, int mask)
 {
     int old_mask;
-    g_assert(qemu_mutex_iothread_locked());
 
-    old_mask = cpu->interrupt_request;
-    cpu->interrupt_request |= mask;
+    if (!cpu_mutex_locked(cpu)) {
+        cpu_mutex_lock(cpu);
+        old_mask = cpu_interrupt_request(cpu);
+        cpu_interrupt_request_or(cpu, mask);
+        cpu_mutex_unlock(cpu);
+    } else {
+        old_mask = cpu_interrupt_request(cpu);
+        cpu_interrupt_request_or(cpu, mask);
+    }
 
     /*
      * If called from iothread context, wake the target cpu in
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 639f0b2728..e67654370b 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -2344,7 +2344,7 @@ void dump_opcount_info(FILE *f, fprintf_function cpu_fprintf)
 void cpu_interrupt(CPUState *cpu, int mask)
 {
     g_assert(qemu_mutex_iothread_locked());
-    cpu->interrupt_request |= mask;
+    cpu_interrupt_request_or(cpu, mask);
     atomic_set(&cpu->icount_decr.u16.high, -1);
 }
 
-- 
2.17.1
