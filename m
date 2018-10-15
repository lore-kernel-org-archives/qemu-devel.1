Received: from eggs.gnu.org ([2001:4830:134:3::10]:45176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gC3SH-0005Eo-3U
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 10:02:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gC3S9-0007lU-JL
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 10:02:44 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:34373)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <artem.k.pisarenko@gmail.com>)
	id 1gC3S9-0007dt-3z
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 10:02:37 -0400
Received: by mail-lj1-x242.google.com with SMTP id j17-v6so17617163lja.1
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 07:02:36 -0700 (PDT)
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Mon, 15 Oct 2018 20:01:52 +0600
Message-Id: <b7025b175d34e8221f810fde879ee0727e8c18e0.1539611776.git.artem.k.pisarenko@gmail.com>
In-Reply-To: <CANzW0mspdyqtC9XY0LP5t1+nD16C2tSTpOz1LPOMuQ3rXeyAFQ@mail.gmail.com>
References: <CANzW0mspdyqtC9XY0LP5t1+nD16C2tSTpOz1LPOMuQ3rXeyAFQ@mail.gmail.com>
Subject: [Qemu-devel] [PATCH v2] Restores record/replay behavior related to
 special virtual clock processing for timers used in external subsystems.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>, Artem Pisarenko <artem.k.pisarenko@gmail.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, Gerd Hoffmann <kraxel@redhat.com>

Adds EXTERNAL attribute definition to qemu timers subsystem and assigns it to virtual clock timers, used in slirp (ICMP IPv6) and ui (key queue).
Virtual clock processing in rr mode reimplemented using this attribute.

Fixes: 87f4fe7653baf55b5c2f2753fe6003f473c07342
Fixes: 775a412bf83f6bc0c5c02091ee06cf649b34c593
Fixes: 9888091404a702d7ec79d51b088d994b9fc121bd
Signed-off-by: Artem Pisarenko <artem.k.pisarenko@gmail.com>
---

Notes:
    v2: fixes race condition and reimplements synchronization between checkpointing and timers processing in qemu-timer.c
    
    qemu-timer.c:
    It has one more difference from original behavior, which I'm not sure about.
    If there are no timers will be processed for virtual clock (i.e. timer list is empty), then checkpointing will be skipped, although it looks fine for me. Is such scenario ever possible?

 include/qemu/timer.h | 10 ++++--
 slirp/ip6_icmp.c     |  4 ++-
 ui/input.c           |  5 +--
 util/qemu-timer.c    | 88 ++++++++++++++++++++++++++++++++++++++++------------
 4 files changed, 82 insertions(+), 25 deletions(-)

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 031e3a1..53bfba5 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -65,11 +65,17 @@ typedef enum {
  * instead each attribute in bit set accessed with QEMU_TIMER_ATTR(id) macro,
  * where 'id' is a unique part of attribute identifier.
  *
- * No attributes defined currently.
+ * The following attributes are available:
+ *
+ * QEMU_TIMER_ATTR(EXTERNAL): drives external subsystem
+ *
+ * Timers with this attribute do not recorded in rr mode, therefore it could be
+ * used for the subsystems that operate outside the guest core. Applicable only
+ * with virtual clock type.
  */
 
 typedef enum {
-    /* none */
+    QEMU_TIMER_ATTRBIT_EXTERNAL,
 } QEMUTimerAttrBit;
 
 #define QEMU_TIMER_ATTR(id) (1 << QEMU_TIMER_ATTRBIT_ ## id)
diff --git a/slirp/ip6_icmp.c b/slirp/ip6_icmp.c
index ee333d0..7c08433 100644
--- a/slirp/ip6_icmp.c
+++ b/slirp/ip6_icmp.c
@@ -27,7 +27,9 @@ void icmp6_init(Slirp *slirp)
         return;
     }
 
-    slirp->ra_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL, ra_timer_handler, slirp);
+    slirp->ra_timer = timer_new_a(QEMU_CLOCK_VIRTUAL, SCALE_MS,
+                                  QEMU_TIMER_ATTR(EXTERNAL),
+                                  ra_timer_handler, slirp);
     timer_mod(slirp->ra_timer,
               qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + NDP_Interval);
 }
diff --git a/ui/input.c b/ui/input.c
index 51b1019..6279187 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -448,8 +448,9 @@ void qemu_input_event_send_key_delay(uint32_t delay_ms)
     }
 
     if (!kbd_timer) {
-        kbd_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL, qemu_input_queue_process,
-                                 &kbd_queue);
+        kbd_timer = timer_new_a(QEMU_CLOCK_VIRTUAL, SCALE_MS,
+                                QEMU_TIMER_ATTR(EXTERNAL),
+                                qemu_input_queue_process, &kbd_queue);
     }
     if (queue_count < queue_limit) {
         qemu_input_queue_delay(&kbd_queue, kbd_timer,
diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 29d8e39..9aa861d 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -490,6 +490,8 @@ bool timerlist_run_timers(QEMUTimerList *timer_list)
     bool progress = false;
     QEMUTimerCB *cb;
     void *opaque;
+    bool need_replay_checkpoint = false;
+    bool nonexternal_expired_pending;
 
     if (!atomic_read(&timer_list->active_timers)) {
         return false;
@@ -505,8 +507,15 @@ bool timerlist_run_timers(QEMUTimerList *timer_list)
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
@@ -522,26 +531,65 @@ bool timerlist_run_timers(QEMUTimerList *timer_list)
     }
 
     current_time = qemu_clock_get_ns(timer_list->clock->type);
-    for(;;) {
-        qemu_mutex_lock(&timer_list->active_timers_lock);
-        ts = timer_list->active_timers;
-        if (!timer_expired_ns(ts, current_time)) {
+    nonexternal_expired_pending = false;
+
+    /*
+     * Inner loop performs extracting and processing expired timers.
+     *
+     * Outer loop is relevant only to rr mode and required for proper
+     * checkpointing.
+     * Checkpoint must be replayed before any non-EXTERNAL timer has been
+     * processed and only one time (virtual clock value stays same). But these
+     * timers may appear in the timers list while it being processed, so this
+     * must be checked until we finally decide that "no timers left - we are
+     * done".
+     */
+    do {
+        if (need_replay_checkpoint && nonexternal_expired_pending) {
+            /* once we got here, checkpoint clock only once and allow cycle
+             * to finish after all left timers have been processed
+             */
+            need_replay_checkpoint = false;
+            if (!replay_checkpoint(CHECKPOINT_CLOCK_VIRTUAL)) {
+                goto out;
+            }
+        }
+        for (;;) {
+            /* check for next expired timer to process */
+            qemu_mutex_lock(&timer_list->active_timers_lock);
+            ts = timer_list->active_timers;
+            if (!timer_expired_ns(ts, current_time)) {
+                /* No expired timers left, so exit from all loops.
+                 * (If rr checkpoint was needed, it either already handled,
+                 *  or may be skipped due to empty timer list.) */
+                need_replay_checkpoint = false;
+                qemu_mutex_unlock(&timer_list->active_timers_lock);
+                break;
+            }
+            if (need_replay_checkpoint
+                    && !(ts->attributes & QEMU_TIMER_ATTR(EXTERNAL))) {
+                /* Condition for rr checkpoint detected.
+                 * Mark it and proceed with timers only after checkpoint
+                 * had been handled.
+                 */
+                nonexternal_expired_pending = true;
+                qemu_mutex_unlock(&timer_list->active_timers_lock);
+                break;
+            }
+
+            /* remove timer from the list before calling the callback */
+            timer_list->active_timers = ts->next;
+            ts->next = NULL;
+            ts->expire_time = -1;
+            cb = ts->cb;
+            opaque = ts->opaque;
             qemu_mutex_unlock(&timer_list->active_timers_lock);
-            break;
+
+            /* run the callback (the timer list can be modified) */
+            cb(opaque);
+            progress = true;
         }
-
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
-    }
+    } while (need_replay_checkpoint);
 
 out:
     qemu_event_set(&timer_list->timers_done_ev);
-- 
2.7.4
