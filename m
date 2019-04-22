Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42770C10F11
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 11:37:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03A882075A
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 11:37:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A882075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35995 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIXFr-0006Ck-7l
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 07:36:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@gmail.com>) id 1hIX15-0001C9-Tk
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 07:21:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@gmail.com>) id 1hIX14-0002UY-7v
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 07:21:43 -0400
Received: from mail.ispras.ru ([83.149.199.45]:47338)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@gmail.com>) id 1hIX12-0002TT-5p
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 07:21:40 -0400
Received: from [127.0.1.1] (unknown [85.142.117.226])
	by mail.ispras.ru (Postfix) with ESMTPSA id A289A5400A9;
	Mon, 22 Apr 2019 14:21:38 +0300 (MSK)
From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 22 Apr 2019 14:21:38 +0300
Message-ID:
 <155593209847.21079.6576936958039534505.stgit@pasha-Precision-3630-Tower>
In-Reply-To: <155593197705.21079.8238359471765771689.stgit@pasha-Precision-3630-Tower>
References: <155593197705.21079.8238359471765771689.stgit@pasha-Precision-3630-Tower>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 83.149.199.45
Subject: [Qemu-devel] [PATCH for-4.1 21/24] util/qemu-timer: refactor
 deadline calculation for external timers
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com,
	pavel.dovgaluk@ispras.ru, pbonzini@redhat.com,
	crosthwaite.peter@gmail.com, ciro.santilli@gmail.com,
	jasowang@redhat.com, quintela@redhat.com, armbru@redhat.com,
	mreitz@redhat.com, alex.bennee@linaro.org,
	maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com,
	boost.lists@gmail.com, thomas.dullien@googlemail.com,
	dovgaluk@ispras.ru, artem.k.pisarenko@gmail.com,
	dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190422112138.bHKNb2gBrPComg7Ur3lCbbrgL3c6zckUAlIJpa9KMis@z>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

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

--

v15 changes:
 - fixed misprint in the test
---
 cpus.c                    |    9 ++++-----
 include/qemu/timer.h      |    7 +++----
 qtest.c                   |    2 +-
 tests/ptimer-test-stubs.c |    4 ++--
 tests/ptimer-test.c       |    4 ++--
 util/qemu-timer.c         |   41 +++++++++++++++++++++++++++++++++--------
 6 files changed, 45 insertions(+), 22 deletions(-)

diff --git a/cpus.c b/cpus.c
index ba4849861d..2cad26f96c 100644
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
@@ -1356,7 +1356,7 @@ static int64_t tcg_get_icount_limit(void)
     int64_t deadline;
 
     if (replay_mode != REPLAY_MODE_PLAY) {
-        deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL);
+        deadline = virtual_clock_deadline_ns();
 
         /* Maintain prior (possibly buggy) behaviour where if no deadline
          * was set (as there is no QEMU_CLOCK_VIRTUAL timer) or it is more than
@@ -1377,8 +1377,7 @@ static void handle_icount_deadline(void)
 {
     assert(qemu_in_vcpu_thread());
     if (use_icount) {
-        int64_t deadline =
-            qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL);
+        int64_t deadline = virtual_clock_deadline_ns();
 
         if (deadline == 0) {
             /* Wake up other AioContexts.  */
diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index a86330c987..cfc77450f2 100644
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
index 527141785f..8000ee0714 100644
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
index 54b3fd26f6..49acfed76f 100644
--- a/tests/ptimer-test-stubs.c
+++ b/tests/ptimer-test-stubs.c
@@ -88,9 +88,9 @@ int64_t qemu_clock_get_ns(QEMUClockType type)
     return ptimer_test_time_ns;
 }
 
-int64_t qemu_clock_deadline_ns_all(QEMUClockType type)
+int64_t virtual_clock_deadline_ns(void)
 {
-    QEMUTimerList *timer_list = main_loop_tlg.tl[type];
+    QEMUTimerList *timer_list = main_loop_tlg.tl[QEMU_CLOCK_VIRTUAL];
     QEMUTimer *t = timer_list->active_timers.next;
     int64_t deadline = -1;
 
diff --git a/tests/ptimer-test.c b/tests/ptimer-test.c
index b30aad0737..338a4e0c10 100644
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
index 1cc1b2f2c3..88fbf04469 100644
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


