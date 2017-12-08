Received: from eggs.gnu.org ([2001:4830:134:3::10]:47577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eNGK8-00011d-Mx
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:56:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eNGK7-0001mU-PY
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:56:08 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:42112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eNGK7-0001mK-FS
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:56:07 -0500
Received: by mail-wr0-x244.google.com with SMTP id s66so10421640wrc.9
	for <qemu-devel@nongnu.org>; Fri, 08 Dec 2017 02:56:07 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  8 Dec 2017 11:55:51 +0100
Message-Id: <20171208105553.12249-4-pbonzini@redhat.com>
In-Reply-To: <20171208105553.12249-1-pbonzini@redhat.com>
References: <20171208105553.12249-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 3/5] qemu-timer: convert to use lock guards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G . Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/qemu-timer.c | 84 +++++++++++++++++++++++++++----------------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 82d56507a2..7a99e0e336 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -192,14 +192,11 @@ bool timerlist_expired(QEMUTimerList *timer_list)
         return false;
     }
 
-    qemu_mutex_lock(&timer_list->active_timers_lock);
+    QEMU_LOCK_GUARD(QemuMutex, timers_guard, &timer_list->active_timers_lock);
     if (!timer_list->active_timers) {
-        qemu_mutex_unlock(&timer_list->active_timers_lock);
         return false;
     }
     expire_time = timer_list->active_timers->expire_time;
-    qemu_mutex_unlock(&timer_list->active_timers_lock);
-
     return expire_time <= qemu_clock_get_ns(timer_list->clock->type);
 }
 
@@ -231,13 +228,13 @@ int64_t timerlist_deadline_ns(QEMUTimerList *timer_list)
      * value but ->notify_cb() is called when the deadline changes.  Therefore
      * the caller should notice the change and there is no race condition.
      */
-    qemu_mutex_lock(&timer_list->active_timers_lock);
-    if (!timer_list->active_timers) {
-        qemu_mutex_unlock(&timer_list->active_timers_lock);
-        return -1;
+    QEMU_WITH_LOCK(QemuMutex, timers_guard,
+                         &timer_list->active_timers_lock) {
+        if (!timer_list->active_timers) {
+            return -1;
+        }
+        expire_time = timer_list->active_timers->expire_time;
     }
-    expire_time = timer_list->active_timers->expire_time;
-    qemu_mutex_unlock(&timer_list->active_timers_lock);
 
     delta = expire_time - qemu_clock_get_ns(timer_list->clock->type);
 
@@ -410,9 +407,8 @@ void timer_del(QEMUTimer *ts)
     QEMUTimerList *timer_list = ts->timer_list;
 
     if (timer_list) {
-        qemu_mutex_lock(&timer_list->active_timers_lock);
+        QEMU_LOCK_GUARD(QemuMutex, timers_guard, &timer_list->active_timers_lock);
         timer_del_locked(timer_list, ts);
-        qemu_mutex_unlock(&timer_list->active_timers_lock);
     }
 }
 
@@ -423,10 +419,11 @@ void timer_mod_ns(QEMUTimer *ts, int64_t expire_time)
     QEMUTimerList *timer_list = ts->timer_list;
     bool rearm;
 
-    qemu_mutex_lock(&timer_list->active_timers_lock);
-    timer_del_locked(timer_list, ts);
-    rearm = timer_mod_ns_locked(timer_list, ts, expire_time);
-    qemu_mutex_unlock(&timer_list->active_timers_lock);
+    QEMU_WITH_LOCK(QemuMutex, timers_guard,
+                         &timer_list->active_timers_lock) {
+        timer_del_locked(timer_list, ts);
+        rearm = timer_mod_ns_locked(timer_list, ts, expire_time);
+    }
 
     if (rearm) {
         timerlist_rearm(timer_list);
@@ -441,16 +438,17 @@ void timer_mod_anticipate_ns(QEMUTimer *ts, int64_t expire_time)
     QEMUTimerList *timer_list = ts->timer_list;
     bool rearm;
 
-    qemu_mutex_lock(&timer_list->active_timers_lock);
-    if (ts->expire_time == -1 || ts->expire_time > expire_time) {
-        if (ts->expire_time != -1) {
-            timer_del_locked(timer_list, ts);
+    QEMU_WITH_LOCK(QemuMutex, timers_guard,
+                         &timer_list->active_timers_lock) {
+        if (ts->expire_time == -1 || ts->expire_time > expire_time) {
+            if (ts->expire_time != -1) {
+                timer_del_locked(timer_list, ts);
+            }
+            rearm = timer_mod_ns_locked(timer_list, ts, expire_time);
+        } else {
+            rearm = false;
         }
-        rearm = timer_mod_ns_locked(timer_list, ts, expire_time);
-    } else {
-        rearm = false;
     }
-    qemu_mutex_unlock(&timer_list->active_timers_lock);
 
     if (rearm) {
         timerlist_rearm(timer_list);
@@ -516,25 +514,27 @@ bool timerlist_run_timers(QEMUTimerList *timer_list)
     }
 
     current_time = qemu_clock_get_ns(timer_list->clock->type);
-    for(;;) {
-        qemu_mutex_lock(&timer_list->active_timers_lock);
-        ts = timer_list->active_timers;
-        if (!timer_expired_ns(ts, current_time)) {
-            qemu_mutex_unlock(&timer_list->active_timers_lock);
-            break;
-        }
+    QEMU_WITH_LOCK(QemuMutex, timers_guard,
+                         &timer_list->active_timers_lock) {
+        for(;;) {
+            ts = timer_list->active_timers;
+            if (!timer_expired_ns(ts, current_time)) {
+                break;
+            }
 
-        /* remove timer from the list before calling the callback */
-        timer_list->active_timers = ts->next;
-        ts->next = NULL;
-        ts->expire_time = -1;
-        cb = ts->cb;
-        opaque = ts->opaque;
-        qemu_mutex_unlock(&timer_list->active_timers_lock);
-
-        /* run the callback (the timer list can be modified) */
-        cb(opaque);
-        progress = true;
+            /* remove timer from the list before calling the callback */
+            timer_list->active_timers = ts->next;
+            ts->next = NULL;
+            ts->expire_time = -1;
+            cb = ts->cb;
+            opaque = ts->opaque;
+
+            /* run the callback (the timer list can be modified) */
+            qemu_lock_guard_unlock(&timers_guard);
+            cb(opaque);
+            progress = true;
+            qemu_lock_guard_lock(&timers_guard);
+        }
     }
 
 out:
-- 
2.14.3
