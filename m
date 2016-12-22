Received: from eggs.gnu.org ([2001:4830:134:3::10]:37735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5DD-0007OS-Gf
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5DC-00079Y-2L
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cK5DB-00079D-SF
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:17 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1B886D7812
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 15:23:17 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-116-19.ams2.redhat.com
	[10.36.116.19])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id uBMFN1xN027210
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 10:23:16 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 22 Dec 2016 16:22:45 +0100
Message-Id: <20161222152300.32395-11-pbonzini@redhat.com>
In-Reply-To: <20161222152300.32395-1-pbonzini@redhat.com>
References: <20161222152300.32395-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 10/25] qemu-timer: check active_timers outside
 lock/event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This avoids taking the active_timers_lock or resetting/setting the
timers_done_ev if there are no active timers.  This removes a small
(2-3%) source of overhead for dataplane.  The list is then checked
again inside the lock, or a NULL pointer could be dereferenced.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-timer.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/qemu-timer.c b/qemu-timer.c
index 9299cdc..ff620ec 100644
--- a/qemu-timer.c
+++ b/qemu-timer.c
@@ -174,7 +174,7 @@ void qemu_clock_enable(QEMUClockType type, bool enabled)
 
 bool timerlist_has_timers(QEMUTimerList *timer_list)
 {
-    return !!timer_list->active_timers;
+    return !!atomic_read(&timer_list->active_timers);
 }
 
 bool qemu_clock_has_timers(QEMUClockType type)
@@ -187,6 +187,10 @@ bool timerlist_expired(QEMUTimerList *timer_list)
 {
     int64_t expire_time;
 
+    if (!atomic_read(&timer_list->active_timers)) {
+        return false;
+    }
+
     qemu_mutex_lock(&timer_list->active_timers_lock);
     if (!timer_list->active_timers) {
         qemu_mutex_unlock(&timer_list->active_timers_lock);
@@ -214,6 +218,10 @@ int64_t timerlist_deadline_ns(QEMUTimerList *timer_list)
     int64_t delta;
     int64_t expire_time;
 
+    if (!atomic_read(&timer_list->active_timers)) {
+        return -1;
+    }
+
     if (!timer_list->clock->enabled) {
         return -1;
     }
@@ -363,7 +371,7 @@ static void timer_del_locked(QEMUTimerList *timer_list, QEMUTimer *ts)
         if (!t)
             break;
         if (t == ts) {
-            *pt = t->next;
+            atomic_set(pt, t->next);
             break;
         }
         pt = &t->next;
@@ -386,7 +394,7 @@ static bool timer_mod_ns_locked(QEMUTimerList *timer_list,
     }
     ts->expire_time = MAX(expire_time, 0);
     ts->next = *pt;
-    *pt = ts;
+    atomic_set(pt, ts);
 
     return pt == &timer_list->active_timers;
 }
@@ -481,8 +489,12 @@ bool timerlist_run_timers(QEMUTimerList *timer_list)
     QEMUTimerCB *cb;
     void *opaque;
 
+    if (!atomic_read(&timer_list->active_timers)) {
+        return false;
+    }
+
     qemu_event_reset(&timer_list->timers_done_ev);
-    if (!timer_list->clock->enabled || !timer_list->active_timers) {
+    if (!timer_list->clock->enabled) {
         goto out;
     }
 
-- 
2.9.3
