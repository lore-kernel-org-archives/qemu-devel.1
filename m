Received: from eggs.gnu.org ([2001:4830:134:3::10]:48794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cX3wJ-0003Ke-Uw
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:39:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cX3wI-0003Vd-R7
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:39:32 -0500
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:37600)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cX3wI-0003VL-La
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:39:30 -0500
Received: by mail-wm0-x22b.google.com with SMTP id c206so130178294wme.0
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 02:39:30 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 27 Jan 2017 10:39:03 +0000
Message-Id: <20170127103922.19658-7-alex.bennee@linaro.org>
In-Reply-To: <20170127103922.19658-1-alex.bennee@linaro.org>
References: <20170127103922.19658-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v8 06/25] tcg: add kick timer for
 single-threaded vCPU emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mttcg@listserver.greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com
Cc: mark.burton@greensocs.com, pbonzini@redhat.com, jan.kiszka@siemens.com, serge.fdrv@gmail.com, rth@twiddle.net, peter.maydell@linaro.org, claudio.fontana@huawei.com, bamvor.zhangjian@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Currently we rely on the side effect of the main loop grabbing the
iothread_mutex to give any long running basic block chains a kick to
ensure the next vCPU is scheduled. As this code is being re-factored and
rationalised we now do it explicitly here.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
v2
  - re-base fixes
  - get_ticks_per_sec() -> NANOSECONDS_PER_SEC
v3
  - add define for TCG_KICK_FREQ
  - fix checkpatch warning
v4
  - wrap next calc in inline qemu_tcg_next_kick() instead of macro
v5
  - move all kick code into own section
  - use global for timer
  - add helper functions to start/stop timer
  - stop timer when all cores paused
v7
  - checkpatch > 80 char fix
---
 cpus.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/cpus.c b/cpus.c
index 76b6e04332..a98925105c 100644
--- a/cpus.c
+++ b/cpus.c
@@ -767,6 +767,53 @@ void configure_icount(QemuOpts *opts, Error **errp)
 }
 
 /***********************************************************/
+/* TCG vCPU kick timer
+ *
+ * The kick timer is responsible for moving single threaded vCPU
+ * emulation on to the next vCPU. If more than one vCPU is running a
+ * timer event with force a cpu->exit so the next vCPU can get
+ * scheduled.
+ *
+ * The timer is removed if all vCPUs are idle and restarted again once
+ * idleness is complete.
+ */
+
+static QEMUTimer *tcg_kick_vcpu_timer;
+
+static void qemu_cpu_kick_no_halt(void);
+
+#define TCG_KICK_PERIOD (NANOSECONDS_PER_SECOND / 10)
+
+static inline int64_t qemu_tcg_next_kick(void)
+{
+    return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + TCG_KICK_PERIOD;
+}
+
+static void kick_tcg_thread(void *opaque)
+{
+    timer_mod(tcg_kick_vcpu_timer, qemu_tcg_next_kick());
+    qemu_cpu_kick_no_halt();
+}
+
+static void start_tcg_kick_timer(void)
+{
+    if (!tcg_kick_vcpu_timer && CPU_NEXT(first_cpu)) {
+        tcg_kick_vcpu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                           kick_tcg_thread, NULL);
+        timer_mod(tcg_kick_vcpu_timer, qemu_tcg_next_kick());
+    }
+}
+
+static void stop_tcg_kick_timer(void)
+{
+    if (tcg_kick_vcpu_timer) {
+        timer_del(tcg_kick_vcpu_timer);
+        tcg_kick_vcpu_timer = NULL;
+    }
+}
+
+
+/***********************************************************/
 void hw_error(const char *fmt, ...)
 {
     va_list ap;
@@ -1020,9 +1067,12 @@ static void qemu_wait_io_event_common(CPUState *cpu)
 static void qemu_tcg_wait_io_event(CPUState *cpu)
 {
     while (all_cpu_threads_idle()) {
+        stop_tcg_kick_timer();
         qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
     }
 
+    start_tcg_kick_timer();
+
     while (iothread_requesting_mutex) {
         qemu_cond_wait(&qemu_io_proceeded_cond, &qemu_global_mutex);
     }
@@ -1222,6 +1272,15 @@ static void deal_with_unplugged_cpus(void)
     }
 }
 
+/* Single-threaded TCG
+ *
+ * In the single-threaded case each vCPU is simulated in turn. If
+ * there is more than a single vCPU we create a simple timer to kick
+ * the vCPU and ensure we don't get stuck in a tight loop in one vCPU.
+ * This is done explicitly rather than relying on side-effects
+ * elsewhere.
+ */
+
 static void *qemu_tcg_cpu_thread_fn(void *arg)
 {
     CPUState *cpu = arg;
@@ -1248,6 +1307,8 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
         }
     }
 
+    start_tcg_kick_timer();
+
     /* process any pending work */
     atomic_mb_set(&exit_request, 1);
 
-- 
2.11.0
