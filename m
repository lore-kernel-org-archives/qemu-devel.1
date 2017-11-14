Received: from eggs.gnu.org ([2001:4830:134:3::10]:40927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eEWQA-0000UI-Ir
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 03:18:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eEWQ7-0006we-BZ
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 03:18:14 -0500
Received: from mail.ispras.ru ([83.149.199.45]:52790)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eEWQ6-0006w8-UZ
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 03:18:11 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 14 Nov 2017 11:18:18 +0300
Message-ID: <20171114081818.27640.33165.stgit@pasha-VirtualBox>
In-Reply-To: <20171114081630.27640.53933.stgit@pasha-VirtualBox>
References: <20171114081630.27640.53933.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH v2 19/26] cpu-exec: reset exit flag before
 calling cpu_exec_nocache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, pbonzini@redhat.com, alex.bennee@linaro.org

This patch resets icount_decr.u32.high before calling cpu_exec_nocache
when exception is pending. Exception is caused by the first instruction
in the block and it cannot be executed without resetting the flag.

This patch also moves this check to the beginning of cpu_handle_exception
function to process pending exceptions in one function call.

Signed-off-by: Maria Klimushenkova <maria.klimushenkova@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

--

v2: reorganized the exception processing code (as suggested by Paolo Bonzini)

---
 accel/tcg/cpu-exec.c |   95 ++++++++++++++++++++++++++++----------------------
 1 file changed, 54 insertions(+), 41 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 0473055..f3de96f 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -470,48 +470,51 @@ static inline void cpu_handle_debug_exception(CPUState *cpu)
 
 static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
 {
-    if (cpu->exception_index >= 0) {
-        if (cpu->exception_index >= EXCP_INTERRUPT) {
-            /* exit request from the cpu execution loop */
-            *ret = cpu->exception_index;
-            if (*ret == EXCP_DEBUG) {
-                cpu_handle_debug_exception(cpu);
-            }
-            cpu->exception_index = -1;
-            return true;
-        } else {
+    if (cpu->exception_index < 0) {
+#ifndef CONFIG_USER_ONLY
+        if (replay_has_exception()
+               && cpu->icount_decr.u16.low + cpu->icount_extra == 0) {
+            /* try to cause an exception pending in the log */
+            cpu_exec_nocache(cpu, 1, tb_find(cpu, NULL, 0, curr_cflags()), true);
+        }
+#endif
+        if (cpu->exception_index < 0) {
+            return false;
+        }
+    }
+
+    if (cpu->exception_index >= EXCP_INTERRUPT) {
+        /* exit request from the cpu execution loop */
+        *ret = cpu->exception_index;
+        if (*ret == EXCP_DEBUG) {
+            cpu_handle_debug_exception(cpu);
+        }
+        cpu->exception_index = -1;
+        return true;
+    } else {
 #if defined(CONFIG_USER_ONLY)
-            /* if user mode only, we simulate a fake exception
-               which will be handled outside the cpu execution
-               loop */
+        /* if user mode only, we simulate a fake exception
+           which will be handled outside the cpu execution
+           loop */
 #if defined(TARGET_I386)
+        CPUClass *cc = CPU_GET_CLASS(cpu);
+        cc->do_interrupt(cpu);
+#endif
+        *ret = cpu->exception_index;
+        cpu->exception_index = -1;
+        return true;
+#else
+        if (replay_exception()) {
             CPUClass *cc = CPU_GET_CLASS(cpu);
+            qemu_mutex_lock_iothread();
             cc->do_interrupt(cpu);
-#endif
-            *ret = cpu->exception_index;
+            qemu_mutex_unlock_iothread();
             cpu->exception_index = -1;
+        } else if (!replay_has_interrupt()) {
+            /* give a chance to iothread in replay mode */
+            *ret = EXCP_INTERRUPT;
             return true;
-#else
-            if (replay_exception()) {
-                CPUClass *cc = CPU_GET_CLASS(cpu);
-                qemu_mutex_lock_iothread();
-                cc->do_interrupt(cpu);
-                qemu_mutex_unlock_iothread();
-                cpu->exception_index = -1;
-            } else if (!replay_has_interrupt()) {
-                /* give a chance to iothread in replay mode */
-                *ret = EXCP_INTERRUPT;
-                return true;
-            }
-#endif
         }
-#ifndef CONFIG_USER_ONLY
-    } else if (replay_has_exception()
-               && cpu->icount_decr.u16.low + cpu->icount_extra == 0) {
-        /* try to cause an exception pending in the log */
-        cpu_exec_nocache(cpu, 1, tb_find(cpu, NULL, 0, curr_cflags()), true);
-        *ret = -1;
-        return true;
 #endif
     }
 
@@ -522,6 +525,19 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
                                         TranslationBlock **last_tb)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
+    int32_t insns_left;
+
+    /* Clear the interrupt flag now since we're processing
+     * cpu->interrupt_request and cpu->exit_request.
+     */
+    insns_left = atomic_read(&cpu->icount_decr.u32);
+    atomic_set(&cpu->icount_decr.u16.high, 0);
+    if (unlikely(insns_left < 0)) {
+        /* Ensure the zeroing of icount_decr comes before the next read
+         * of cpu->exit_request or cpu->interrupt_request.
+         */
+        smp_mb();
+    }
 
     if (unlikely(atomic_read(&cpu->interrupt_request))) {
         int interrupt_request;
@@ -620,17 +636,14 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
 
     *last_tb = NULL;
     insns_left = atomic_read(&cpu->icount_decr.u32);
-    atomic_set(&cpu->icount_decr.u16.high, 0);
     if (insns_left < 0) {
         /* Something asked us to stop executing chained TBs; just
          * continue round the main loop. Whatever requested the exit
          * will also have set something else (eg exit_request or
-         * interrupt_request) which we will handle next time around
-         * the loop.  But we need to ensure the zeroing of icount_decr
-         * comes before the next read of cpu->exit_request
-         * or cpu->interrupt_request.
+         * interrupt_request) which will be handled by
+         * cpu_handle_interrupt.  cpu_handle_interrupt will also
+         * clear cpu->icount_decr.u16.high.
          */
-        smp_mb();
         return;
     }
 
