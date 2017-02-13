Received: from eggs.gnu.org ([2001:4830:134:3::10]:53561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cdFSJ-0005Dq-Jp
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 07:10:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cdFSI-0002WY-1J
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 07:10:07 -0500
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:35632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cdFSH-0002W4-Qq
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 07:10:05 -0500
Received: by mail-wm0-x233.google.com with SMTP id v186so156314816wmd.0
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 04:10:05 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 13 Feb 2017 12:09:59 +0000
Message-Id: <20170213121017.12907-7-alex.bennee@linaro.org>
In-Reply-To: <20170213121017.12907-1-alex.bennee@linaro.org>
References: <20170213121017.12907-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v12 06/24] tcg: add kick timer for
 single-threaded vCPU emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, rth@twiddle.net
Cc: mttcg@listserver.greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, mark.burton@greensocs.com, pbonzini@redhat.com, jan.kiszka@siemens.com, serge.fdrv@gmail.com, bamvor.zhangjian@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Currently we rely on the side effect of the main loop grabbing the
iothread_mutex to give any long running basic block chains a kick to
ensure the next vCPU is scheduled. As this code is being re-factored and
rationalised we now do it explicitly here.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Pranith Kumar <bobby.prani@gmail.com>

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
index ab18725e8a..6a15f9dc47 100644
--- a/cpus.c
+++ b/cpus.c
@@ -768,6 +768,53 @@ void configure_icount(QemuOpts *opts, Error **errp)
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
@@ -1021,9 +1068,12 @@ static void qemu_wait_io_event_common(CPUState *cpu)
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
@@ -1223,6 +1273,15 @@ static void deal_with_unplugged_cpus(void)
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
@@ -1249,6 +1308,8 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
         }
     }
 
+    start_tcg_kick_timer();
+
     /* process any pending work */
     atomic_mb_set(&exit_request, 1);
 
-- 
2.11.0
