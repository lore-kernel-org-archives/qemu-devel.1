Received: from eggs.gnu.org ([2001:4830:134:3::10]:53430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cwW1t-0002RX-2G
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 11:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cwW1s-0007Wi-4a
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 11:42:29 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:35735)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cwW1r-0007WU-UC
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 11:42:28 -0400
Received: by mail-wm0-x232.google.com with SMTP id w64so1698364wma.0
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 08:42:27 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  7 Apr 2017 16:42:18 +0100
Message-Id: <20170407154221.26918-10-alex.bennee@linaro.org>
In-Reply-To: <20170407154221.26918-1-alex.bennee@linaro.org>
References: <20170407154221.26918-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 09/12] cpus: introduce cpu_update_icount
 helper
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

By holding off updates to timer_state.qemu_icount we can run into
trouble when the non-vCPU thread needs to know the time. This helper
ensures we atomically update timers_state.qemu_icount based on what
has been currently executed.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 cpus.c               | 23 +++++++++++++++++++++--
 include/qemu/timer.h |  1 +
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/cpus.c b/cpus.c
index 88eabdc19f..3854f17c35 100644
--- a/cpus.c
+++ b/cpus.c
@@ -232,12 +232,31 @@ static int64_t cpu_get_icount_executed(CPUState *cpu)
     return cpu->icount_budget - (cpu->icount_decr.u16.low + cpu->icount_extra);
 }
 
+/*
+ * Update the global shared timer_state.qemu_icount to take into
+ * account executed instructions. This is done by the TCG vCPU
+ * thread so the main-loop can see time has moved forward.
+ */
+void cpu_update_icount(CPUState *cpu)
+{
+    int64_t executed = cpu_get_icount_executed(cpu);
+    cpu->icount_budget -= executed;
+
+#ifdef CONFIG_ATOMIC64
+    atomic_set__nocheck(&timers_state.qemu_icount,
+                        atomic_read__nocheck(&timers_state.qemu_icount) +
+                        executed);
+#else /* FIXME: we need 64bit atomics to do this safely */
+    timers_state.qemu_icount += executed;
+#endif
+}
+
 int64_t cpu_get_icount_raw(void)
 {
     int64_t icount;
     CPUState *cpu = current_cpu;
 
-    icount = timers_state.qemu_icount;
+    icount = atomic_read(&timers_state.qemu_icount);
     if (cpu && cpu->running) {
         if (!cpu->can_do_io) {
             fprintf(stderr, "Bad icount read\n");
@@ -1220,7 +1239,7 @@ static void process_icount_data(CPUState *cpu)
 {
     if (use_icount) {
         /* Account for executed instructions */
-        timers_state.qemu_icount += cpu_get_icount_executed(cpu);
+        cpu_update_icount(cpu);
 
         /* Reset the counters */
         cpu->icount_decr.u16.low = 0;
diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index e1742f2f3d..8a1eb74839 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -869,6 +869,7 @@ int64_t cpu_get_icount_raw(void);
 int64_t cpu_get_icount(void);
 int64_t cpu_get_clock(void);
 int64_t cpu_icount_to_ns(int64_t icount);
+void    cpu_update_icount(CPUState *cpu);
 
 /*******************************************/
 /* host CPU ticks (if available) */
-- 
2.11.0
