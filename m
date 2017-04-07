Received: from eggs.gnu.org ([2001:4830:134:3::10]:53417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cwW1s-0002QW-2f
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 11:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cwW1r-0007WI-53
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 11:42:28 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:33697)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cwW1q-0007Vz-VG
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 11:42:27 -0400
Received: by mail-wr0-x22a.google.com with SMTP id g19so68078056wrb.0
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 08:42:26 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  7 Apr 2017 16:42:16 +0100
Message-Id: <20170407154221.26918-8-alex.bennee@linaro.org>
In-Reply-To: <20170407154221.26918-1-alex.bennee@linaro.org>
References: <20170407154221.26918-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 07/12] cpus: move icount preparation out of
 tcg_exec_cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dovgaluk@ispras.ru, rth@twiddle.net, pbonzini@redhat.com
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

As icount is only supported for single-threaded execution due to the
requirement for determinism let's remove it from the common
tcg_exec_cpu path.

Also remove the additional fiddling which shouldn't be required as the
icount counters should all be rectified as you enter the loop.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - only clear u16.low
  - drop BQL assert
---
 cpus.c | 67 ++++++++++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 45 insertions(+), 22 deletions(-)

diff --git a/cpus.c b/cpus.c
index 18b1746770..d9cb9407a2 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1179,47 +1179,64 @@ static void handle_icount_deadline(void)
     }
 }
 
-static int tcg_cpu_exec(CPUState *cpu)
+static void prepare_icount_for_run(CPUState *cpu)
 {
-    int ret;
-#ifdef CONFIG_PROFILER
-    int64_t ti;
-#endif
-
-#ifdef CONFIG_PROFILER
-    ti = profile_getclock();
-#endif
     if (use_icount) {
         int64_t count;
         int decr;
-        timers_state.qemu_icount -= (cpu->icount_decr.u16.low
-                                    + cpu->icount_extra);
-        cpu->icount_decr.u16.low = 0;
-        cpu->icount_extra = 0;
+
+        /* These should always be cleared by process_icount_data after
+         * each vCPU execution. However u16.high can be raised
+         * asynchronously by cpu_exit/cpu_interrupt/tcg_handle_interrupt
+         */
+        g_assert(cpu->icount_decr.u16.low == 0);
+        g_assert(cpu->icount_extra == 0);
+
+
         count = tcg_get_icount_limit();
+
         timers_state.qemu_icount += count;
         decr = (count > 0xffff) ? 0xffff : count;
         count -= decr;
         cpu->icount_decr.u16.low = decr;
         cpu->icount_extra = count;
     }
-    qemu_mutex_unlock_iothread();
-    cpu_exec_start(cpu);
-    ret = cpu_exec(cpu);
-    cpu_exec_end(cpu);
-    qemu_mutex_lock_iothread();
-#ifdef CONFIG_PROFILER
-    tcg_time += profile_getclock() - ti;
-#endif
+}
+
+static void process_icount_data(CPUState *cpu)
+{
     if (use_icount) {
         /* Fold pending instructions back into the
            instruction counter, and clear the interrupt flag.  */
         timers_state.qemu_icount -= (cpu->icount_decr.u16.low
                         + cpu->icount_extra);
-        cpu->icount_decr.u32 = 0;
+
+        /* Reset the counters */
+        cpu->icount_decr.u16.low = 0;
         cpu->icount_extra = 0;
         replay_account_executed_instructions();
     }
+}
+
+
+static int tcg_cpu_exec(CPUState *cpu)
+{
+    int ret;
+#ifdef CONFIG_PROFILER
+    int64_t ti;
+#endif
+
+#ifdef CONFIG_PROFILER
+    ti = profile_getclock();
+#endif
+    qemu_mutex_unlock_iothread();
+    cpu_exec_start(cpu);
+    ret = cpu_exec(cpu);
+    cpu_exec_end(cpu);
+    qemu_mutex_lock_iothread();
+#ifdef CONFIG_PROFILER
+    tcg_time += profile_getclock() - ti;
+#endif
     return ret;
 }
 
@@ -1306,7 +1323,13 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
 
             if (cpu_can_run(cpu)) {
                 int r;
+
+                prepare_icount_for_run(cpu);
+
                 r = tcg_cpu_exec(cpu);
+
+                process_icount_data(cpu);
+
                 if (r == EXCP_DEBUG) {
                     cpu_handle_guest_debug(cpu);
                     break;
-- 
2.11.0
