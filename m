Received: from eggs.gnu.org ([209.51.188.92]:50280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gpCDd-0005ib-S6
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:17:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gpCDc-000360-L1
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:17:25 -0500
Received: from mail.ispras.ru ([83.149.199.45]:52430)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gpCDc-00035j-9n
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:17:24 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Thu, 31 Jan 2019 16:17:26 +0300
Message-ID: <20190131131726.23264.26630.stgit@pasha-VirtualBox>
In-Reply-To: <20190131131520.23264.75724.stgit@pasha-VirtualBox>
References: <20190131131520.23264.75724.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v11 22/25] util/qemu-timer: refactor deadline
 calculation for external timers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, artem.k.pisarenko@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, mreitz@redhat.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, thomas.dullien@googlemail.com, pbonzini@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

icount-based record/replay uses qemu_clock_deadline_ns_all to measure
the period until vCPU may be interrupted.
This function takes in account the virtual timers, because they belong
to the virtual devices that may generate interrupt request or affect
the virtual machine state.
However, there are a subset of virtual timers, that are marked with
'external' flag. These do not change the virtual machine state and
only based on virtual clock. Calculating the deadling using the external
timers breaks the determinism, because they do not belong to the replayed
part of the virtual machine.
This patch fixes the deadline calculation for this case.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 cpus.c                    |    9 ++++-----
 include/qemu/timer.h      |    7 +++----
 qtest.c                   |    2 +-
 tests/ptimer-test-stubs.c |    2 +-
 tests/ptimer-test.c       |    4 ++--
 util/qemu-timer.c         |   41 +++++++++++++++++++++++++++++++++--------
 6 files changed, 44 insertions(+), 21 deletions(-)

diff --git a/cpus.c b/cpus.c
index 6ef0992..fb656ce 100644
--- a/cpus.c
+++ b/cpus.c
@@ -550,7 +550,7 @@ void qtest_clock_warp(int64_t dest)
     assert(qtest_enabled());
     aio_context = qemu_get_aio_context();
     while (clock < dest) {
-        int64_t deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL);
+        int64_t deadline = virtual_clock_deadline_ns();
         int64_t warp = qemu_soonest_timeout(dest - clock, deadline);
 
         seqlock_write_lock(&timers_state.vm_clock_seqlock,
@@ -610,7 +610,7 @@ void qemu_start_warp_timer(void)
 
     /* We want to use the earliest deadline from ALL vm_clocks */
     clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL_RT);
-    deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL);
+    deadline = virtual_clock_deadline_ns();
     if (deadline < 0) {
         static bool notified;
         if (!icount_sleep && !notified) {
@@ -1355,7 +1355,7 @@ static int64_t tcg_get_icount_limit(void)
     int64_t deadline;
 
     if (replay_mode != REPLAY_MODE_PLAY) {
-        deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL);
+        deadline = virtual_clock_deadline_ns();
 
         /* Maintain prior (possibly buggy) behaviour where if no deadline
          * was set (as there is no QEMU_CLOCK_VIRTUAL timer) or it is more than
@@ -1376,8 +1376,7 @@ static void handle_icount_deadline(void)
 {
     assert(qemu_in_vcpu_thread());
     if (use_icount) {
-        int64_t deadline =
-            qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL);
+        int64_t deadline = virtual_clock_deadline_ns();
 
         if (deadline == 0) {
             /* Wake up other AioContexts.  */
diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index a86330c..cfc7745 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -176,16 +176,15 @@ bool qemu_clock_expired(QEMUClockType type);
 bool qemu_clock_use_for_deadline(QEMUClockType type);
 
 /**
- * qemu_clock_deadline_ns_all:
- * @type: the clock type
+ * virtual_clock_deadline_ns:
  *
  * Calculate the deadline across all timer lists associated
- * with a clock (as opposed to just the default one)
+ * with virtual clock (excluding external timers)
  * in nanoseconds, or -1 if no timer is set to expire.
  *
  * Returns: time until expiry in nanoseconds or -1
  */
-int64_t qemu_clock_deadline_ns_all(QEMUClockType type);
+int64_t virtual_clock_deadline_ns(void);
 
 /**
  * qemu_clock_get_main_loop_timerlist:
diff --git a/qtest.c b/qtest.c
index 60988c8..341190e 100644
--- a/qtest.c
+++ b/qtest.c
@@ -655,7 +655,7 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
             int ret = qemu_strtoi64(words[1], NULL, 0, &ns);
             g_assert(ret == 0);
         } else {
-            ns = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL);
+            ns = virtual_clock_deadline_ns();
         }
         qtest_clock_warp(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + ns);
         qtest_send_prefix(chr);
diff --git a/tests/ptimer-test-stubs.c b/tests/ptimer-test-stubs.c
index 54b3fd2..31b09c8 100644
--- a/tests/ptimer-test-stubs.c
+++ b/tests/ptimer-test-stubs.c
@@ -88,7 +88,7 @@ int64_t qemu_clock_get_ns(QEMUClockType type)
     return ptimer_test_time_ns;
 }
 
-int64_t qemu_clock_deadline_ns_all(QEMUClockType type)
+int64_t virtual_clock_deadline_ns(void)
 {
     QEMUTimerList *timer_list = main_loop_tlg.tl[type];
     QEMUTimer *t = timer_list->active_timers.next;
diff --git a/tests/ptimer-test.c b/tests/ptimer-test.c
index b30aad0..338a4e0 100644
--- a/tests/ptimer-test.c
+++ b/tests/ptimer-test.c
@@ -50,13 +50,13 @@ static void ptimer_test_set_qemu_time_ns(int64_t ns)
 
 static void qemu_clock_step(uint64_t ns)
 {
-    int64_t deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL);
+    int64_t deadline = virtual_clock_deadline_ns();
     int64_t advanced_time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + ns;
 
     while (deadline != -1 && deadline <= advanced_time) {
         ptimer_test_set_qemu_time_ns(deadline);
         ptimer_test_expire_qemu_timers(deadline, QEMU_CLOCK_VIRTUAL);
-        deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL);
+        deadline = virtual_clock_deadline_ns();
     }
 
     ptimer_test_set_qemu_time_ns(advanced_time);
diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 1cc1b2f..88fbf04 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -236,6 +236,7 @@ int64_t timerlist_deadline_ns(QEMUTimerList *timer_list)
         qemu_mutex_unlock(&timer_list->active_timers_lock);
         return -1;
     }
+
     expire_time = timer_list->active_timers->expire_time;
     qemu_mutex_unlock(&timer_list->active_timers_lock);
 
@@ -248,19 +249,43 @@ int64_t timerlist_deadline_ns(QEMUTimerList *timer_list)
     return delta;
 }
 
-/* Calculate the soonest deadline across all timerlists attached
- * to the clock. This is used for the icount timeout so we
- * ignore whether or not the clock should be used in deadline
- * calculations.
+/*
+ * Calculate the soonest deadline across all timerlists attached
+ * to the virtual clock (excluding the external timers that do not affect
+ * the replayed guest state.
  */
-int64_t qemu_clock_deadline_ns_all(QEMUClockType type)
+int64_t virtual_clock_deadline_ns(void)
 {
     int64_t deadline = -1;
+    int64_t delta;
+    int64_t expire_time;
+    QEMUTimer *ts;
     QEMUTimerList *timer_list;
-    QEMUClock *clock = qemu_clock_ptr(type);
+    QEMUClock *clock = qemu_clock_ptr(QEMU_CLOCK_VIRTUAL);
+
+    if (!clock->enabled) {
+        return -1;
+    }
+
     QLIST_FOREACH(timer_list, &clock->timerlists, list) {
-        deadline = qemu_soonest_timeout(deadline,
-                                        timerlist_deadline_ns(timer_list));
+        qemu_mutex_lock(&timer_list->active_timers_lock);
+        ts = timer_list->active_timers;
+        /* Skip all external timers */
+        while (ts && (ts->attributes & QEMU_TIMER_ATTR_EXTERNAL)) {
+            ts = ts->next;
+        }
+        if (!ts) {
+            qemu_mutex_unlock(&timer_list->active_timers_lock);
+            continue;
+        }
+        expire_time = ts->expire_time;
+        qemu_mutex_unlock(&timer_list->active_timers_lock);
+
+        delta = expire_time - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        if (delta <= 0) {
+            delta = 0;
+        }
+        deadline = qemu_soonest_timeout(deadline, delta);
     }
     return deadline;
 }
