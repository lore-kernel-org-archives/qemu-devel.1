Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F0CC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:22:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B69F82082F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B69F82082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzyTB-00075P-PZ
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 03:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1hzy8j-0005qg-Jq
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:01:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hzy8f-0003XG-3p
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:01:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42926)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hzy8d-0003Q6-05
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:01:03 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 28747195DB85;
 Tue, 20 Aug 2019 07:00:59 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-20.ams2.redhat.com
 [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 242CB7E005;
 Tue, 20 Aug 2019 07:00:57 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 08:59:42 +0200
Message-Id: <1566284395-30287-24-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
References: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Tue, 20 Aug 2019 07:00:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 23/36] util/qemu-timer: refactor deadline
 calculation for external timers
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
This patch fixes the deadline calculation for this case by adding
new parameter for skipping the external timers when it is needed.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

--

v2 changes:
 - added new parameter for timer attribute mask
Message-Id: <156404426682.18669.17014100602930969222.stgit@pasha-Precision-3630-Tower>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpus.c                    | 17 ++++++++++++-----
 include/qemu/timer.h      |  8 ++++++--
 qtest.c                   |  3 ++-
 tests/ptimer-test-stubs.c |  4 ++--
 tests/ptimer-test.c       |  6 ++++--
 util/qemu-timer.c         | 30 +++++++++++++++++++++++++++---
 6 files changed, 53 insertions(+), 15 deletions(-)

diff --git a/cpus.c b/cpus.c
index 927a00a..a7120ff 100644
--- a/cpus.c
+++ b/cpus.c
@@ -553,7 +553,8 @@ void qtest_clock_warp(int64_t dest)
     assert(qtest_enabled());
     aio_context = qemu_get_aio_context();
     while (clock < dest) {
-        int64_t deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL);
+        int64_t deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
+                                                      QEMU_TIMER_ATTR_ALL);
         int64_t warp = qemu_soonest_timeout(dest - clock, deadline);
 
         seqlock_write_lock(&timers_state.vm_clock_seqlock,
@@ -613,7 +614,8 @@ void qemu_start_warp_timer(void)
 
     /* We want to use the earliest deadline from ALL vm_clocks */
     clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL_RT);
-    deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL);
+    deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
+                                          ~QEMU_TIMER_ATTR_EXTERNAL);
     if (deadline < 0) {
         static bool notified;
         if (!icount_sleep && !notified) {
@@ -1349,7 +1351,12 @@ static int64_t tcg_get_icount_limit(void)
     int64_t deadline;
 
     if (replay_mode != REPLAY_MODE_PLAY) {
-        deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL);
+        /*
+         * Include all the timers, because they may need an attention.
+         * Too long CPU execution may create unnecessary delay in UI.
+         */
+        deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
+                                              QEMU_TIMER_ATTR_ALL);
 
         /* Maintain prior (possibly buggy) behaviour where if no deadline
          * was set (as there is no QEMU_CLOCK_VIRTUAL timer) or it is more than
@@ -1370,8 +1377,8 @@ static void handle_icount_deadline(void)
 {
     assert(qemu_in_vcpu_thread());
     if (use_icount) {
-        int64_t deadline =
-            qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL);
+        int64_t deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
+                                                      QEMU_TIMER_ATTR_ALL);
 
         if (deadline == 0) {
             /* Wake up other AioContexts.  */
diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 5bcab93..85bc6eb 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -62,13 +62,15 @@ typedef enum {
  * The following attributes are available:
  *
  * QEMU_TIMER_ATTR_EXTERNAL: drives external subsystem
+ * QEMU_TIMER_ATTR_ALL: mask for all existing attributes
  *
  * Timers with this attribute do not recorded in rr mode, therefore it could be
  * used for the subsystems that operate outside the guest core. Applicable only
  * with virtual clock type.
  */
 
-#define QEMU_TIMER_ATTR_EXTERNAL BIT(0)
+#define QEMU_TIMER_ATTR_EXTERNAL ((int)BIT(0))
+#define QEMU_TIMER_ATTR_ALL      0xffffffff
 
 typedef struct QEMUTimerList QEMUTimerList;
 
@@ -177,6 +179,8 @@ bool qemu_clock_use_for_deadline(QEMUClockType type);
 /**
  * qemu_clock_deadline_ns_all:
  * @type: the clock type
+ * @attr_mask: mask for the timer attributes that are included
+ *             in deadline calculation
  *
  * Calculate the deadline across all timer lists associated
  * with a clock (as opposed to just the default one)
@@ -184,7 +188,7 @@ bool qemu_clock_use_for_deadline(QEMUClockType type);
  *
  * Returns: time until expiry in nanoseconds or -1
  */
-int64_t qemu_clock_deadline_ns_all(QEMUClockType type);
+int64_t qemu_clock_deadline_ns_all(QEMUClockType type, int attr_mask);
 
 /**
  * qemu_clock_get_main_loop_timerlist:
diff --git a/qtest.c b/qtest.c
index 15e27e9..4e20856 100644
--- a/qtest.c
+++ b/qtest.c
@@ -655,7 +655,8 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
             int ret = qemu_strtoi64(words[1], NULL, 0, &ns);
             g_assert(ret == 0);
         } else {
-            ns = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL);
+            ns = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
+                                            QEMU_TIMER_ATTR_ALL);
         }
         qtest_clock_warp(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + ns);
         qtest_send_prefix(chr);
diff --git a/tests/ptimer-test-stubs.c b/tests/ptimer-test-stubs.c
index 54b3fd2..ed393d9 100644
--- a/tests/ptimer-test-stubs.c
+++ b/tests/ptimer-test-stubs.c
@@ -88,9 +88,9 @@ int64_t qemu_clock_get_ns(QEMUClockType type)
     return ptimer_test_time_ns;
 }
 
-int64_t qemu_clock_deadline_ns_all(QEMUClockType type)
+int64_t qemu_clock_deadline_ns_all(QEMUClockType type, int attr_mask)
 {
-    QEMUTimerList *timer_list = main_loop_tlg.tl[type];
+    QEMUTimerList *timer_list = main_loop_tlg.tl[QEMU_CLOCK_VIRTUAL];
     QEMUTimer *t = timer_list->active_timers.next;
     int64_t deadline = -1;
 
diff --git a/tests/ptimer-test.c b/tests/ptimer-test.c
index b30aad0..5b20e91 100644
--- a/tests/ptimer-test.c
+++ b/tests/ptimer-test.c
@@ -50,13 +50,15 @@ static void ptimer_test_set_qemu_time_ns(int64_t ns)
 
 static void qemu_clock_step(uint64_t ns)
 {
-    int64_t deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL);
+    int64_t deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
+                                                  QEMU_TIMER_ATTR_ALL);
     int64_t advanced_time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + ns;
 
     while (deadline != -1 && deadline <= advanced_time) {
         ptimer_test_set_qemu_time_ns(deadline);
         ptimer_test_expire_qemu_timers(deadline, QEMU_CLOCK_VIRTUAL);
-        deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL);
+        deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
+                                              QEMU_TIMER_ATTR_ALL);
     }
 
     ptimer_test_set_qemu_time_ns(advanced_time);
diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index b73041d..dcaaac7 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -248,14 +248,38 @@ int64_t timerlist_deadline_ns(QEMUTimerList *timer_list)
  * ignore whether or not the clock should be used in deadline
  * calculations.
  */
-int64_t qemu_clock_deadline_ns_all(QEMUClockType type)
+int64_t qemu_clock_deadline_ns_all(QEMUClockType type, int attr_mask)
 {
     int64_t deadline = -1;
+    int64_t delta;
+    int64_t expire_time;
+    QEMUTimer *ts;
     QEMUTimerList *timer_list;
     QEMUClock *clock = qemu_clock_ptr(type);
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
+        while (ts && (ts->attributes & ~attr_mask)) {
+            ts = ts->next;
+        }
+        if (!ts) {
+            qemu_mutex_unlock(&timer_list->active_timers_lock);
+            continue;
+        }
+        expire_time = ts->expire_time;
+        qemu_mutex_unlock(&timer_list->active_timers_lock);
+
+        delta = expire_time - qemu_clock_get_ns(type);
+        if (delta <= 0) {
+            delta = 0;
+        }
+        deadline = qemu_soonest_timeout(deadline, delta);
     }
     return deadline;
 }
-- 
1.8.3.1



