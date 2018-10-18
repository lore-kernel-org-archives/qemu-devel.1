Received: from eggs.gnu.org ([2001:4830:134:3::10]:47965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEy8-000765-P6
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEy5-0006Ab-EF
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:31 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35971)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gDEy1-00066Y-Qs
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:27 -0400
Received: by mail-wm1-x344.google.com with SMTP id a8-v6so1626269wmf.1
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 13:32:22 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Oct 2018 22:31:31 +0200
Message-Id: <1539894735-14232-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 04/48] qemu-timer: avoid checkpoints for virtual
 clock timers in external subsystems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Artem Pisarenko <artem.k.pisarenko@gmail.com>

From: Artem Pisarenko <artem.k.pisarenko@gmail.com>

Adds EXTERNAL attribute definition to qemu timers subsystem and assigns
it to virtual clock timers, used in slirp (ICMP IPv6) and ui (key queue).
Virtual clock processing in rr mode can use this attribute instead of a
separate clock type.

Fixes: 87f4fe7653baf55b5c2f2753fe6003f473c07342
Fixes: 775a412bf83f6bc0c5c02091ee06cf649b34c593
Fixes: 9888091404a702d7ec79d51b088d994b9fc121bd
Signed-off-by: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Message-Id: <e771f96ab94e86b54b9a783c974f2af3009fe5d1.1539764043.git.artem.k.pisarenko@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/timer.h | 10 +++++++++-
 slirp/ip6_icmp.c     |  4 +++-
 ui/input.c           |  5 +++--
 util/qemu-timer.c    | 50 +++++++++++++++++++++++++++++++++++++++++++-------
 4 files changed, 58 insertions(+), 11 deletions(-)

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 8ff1092..9f37c92 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -60,9 +60,17 @@ typedef enum {
  * Each attribute corresponds to one bit. Attributes modify the processing
  * of timers when they fire.
  *
- * No attributes defined currently.
+ * The following attributes are available:
+ *
+ * QEMU_TIMER_ATTR_EXTERNAL: drives external subsystem
+ *
+ * Timers with this attribute do not recorded in rr mode, therefore it could be
+ * used for the subsystems that operate outside the guest core. Applicable only
+ * with virtual clock type.
  */
 
+#define QEMU_TIMER_ATTR_EXTERNAL BIT(0)
+
 typedef struct QEMUTimerList QEMUTimerList;
 
 struct QEMUTimerListGroup {
diff --git a/slirp/ip6_icmp.c b/slirp/ip6_icmp.c
index ee333d0..cd1e0b9 100644
--- a/slirp/ip6_icmp.c
+++ b/slirp/ip6_icmp.c
@@ -27,7 +27,9 @@ void icmp6_init(Slirp *slirp)
         return;
     }
 
-    slirp->ra_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL, ra_timer_handler, slirp);
+    slirp->ra_timer = timer_new_full(NULL, QEMU_CLOCK_VIRTUAL,
+                                     SCALE_MS, QEMU_TIMER_ATTR_EXTERNAL,
+                                     ra_timer_handler, slirp);
     timer_mod(slirp->ra_timer,
               qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + NDP_Interval);
 }
diff --git a/ui/input.c b/ui/input.c
index 51b1019..7c9a410 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -448,8 +448,9 @@ void qemu_input_event_send_key_delay(uint32_t delay_ms)
     }
 
     if (!kbd_timer) {
-        kbd_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL, qemu_input_queue_process,
-                                 &kbd_queue);
+        kbd_timer = timer_new_full(NULL, QEMU_CLOCK_VIRTUAL,
+                                   SCALE_MS, QEMU_TIMER_ATTR_EXTERNAL,
+                                   qemu_input_queue_process, &kbd_queue);
     }
     if (queue_count < queue_limit) {
         qemu_input_queue_delay(&kbd_queue, kbd_timer,
diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 04527a3..1cc1b2f 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -489,6 +489,7 @@ bool timerlist_run_timers(QEMUTimerList *timer_list)
     bool progress = false;
     QEMUTimerCB *cb;
     void *opaque;
+    bool need_replay_checkpoint = false;
 
     if (!atomic_read(&timer_list->active_timers)) {
         return false;
@@ -504,8 +505,15 @@ bool timerlist_run_timers(QEMUTimerList *timer_list)
         break;
     default:
     case QEMU_CLOCK_VIRTUAL:
-        if (!replay_checkpoint(CHECKPOINT_CLOCK_VIRTUAL)) {
-            goto out;
+        if (replay_mode != REPLAY_MODE_NONE) {
+            /* Checkpoint for virtual clock is redundant in cases where
+             * it's being triggered with only non-EXTERNAL timers, because
+             * these timers don't change guest state directly.
+             * Since it has conditional dependence on specific timers, it is
+             * subject to race conditions and requires special handling.
+             * See below.
+             */
+            need_replay_checkpoint = true;
         }
         break;
     case QEMU_CLOCK_HOST:
@@ -520,14 +528,39 @@ bool timerlist_run_timers(QEMUTimerList *timer_list)
         break;
     }
 
+    /*
+     * Extract expired timers from active timers list and and process them.
+     *
+     * In rr mode we need "filtered" checkpointing for virtual clock.  The
+     * checkpoint must be recorded/replayed before processing any non-EXTERNAL timer,
+     * and that must only be done once since the clock value stays the same. Because
+     * non-EXTERNAL timers may appear in the timers list while it being processed,
+     * the checkpoint can be issued at a time until no timers are left and we are
+     * done".
+     */
     current_time = qemu_clock_get_ns(timer_list->clock->type);
-    for(;;) {
-        qemu_mutex_lock(&timer_list->active_timers_lock);
-        ts = timer_list->active_timers;
+    qemu_mutex_lock(&timer_list->active_timers_lock);
+    while ((ts = timer_list->active_timers)) {
         if (!timer_expired_ns(ts, current_time)) {
-            qemu_mutex_unlock(&timer_list->active_timers_lock);
+            /* No expired timers left.  The checkpoint can be skipped
+             * if no timers fired or they were all external.
+             */
             break;
         }
+        if (need_replay_checkpoint
+                && !(ts->attributes & QEMU_TIMER_ATTR_EXTERNAL)) {
+            /* once we got here, checkpoint clock only once */
+            need_replay_checkpoint = false;
+            qemu_mutex_unlock(&timer_list->active_timers_lock);
+            if (!replay_checkpoint(CHECKPOINT_CLOCK_VIRTUAL)) {
+                goto out;
+            }
+            qemu_mutex_lock(&timer_list->active_timers_lock);
+            /* The lock was released; start over again in case the list was
+             * modified.
+             */
+            continue;
+        }
 
         /* remove timer from the list before calling the callback */
         timer_list->active_timers = ts->next;
@@ -535,12 +568,15 @@ bool timerlist_run_timers(QEMUTimerList *timer_list)
         ts->expire_time = -1;
         cb = ts->cb;
         opaque = ts->opaque;
-        qemu_mutex_unlock(&timer_list->active_timers_lock);
 
         /* run the callback (the timer list can be modified) */
+        qemu_mutex_unlock(&timer_list->active_timers_lock);
         cb(opaque);
+        qemu_mutex_lock(&timer_list->active_timers_lock);
+
         progress = true;
     }
+    qemu_mutex_unlock(&timer_list->active_timers_lock);
 
 out:
     qemu_event_set(&timer_list->timers_done_ev);
-- 
1.8.3.1
