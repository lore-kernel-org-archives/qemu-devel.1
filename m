Received: from eggs.gnu.org ([2001:4830:134:3::10]:50660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gCh9I-00074M-FI
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:25:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gCh9H-0008If-EI
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:25:48 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:36383)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <artem.k.pisarenko@gmail.com>)
	id 1gCh9G-0008Hs-Vo
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:25:47 -0400
Received: by mail-lj1-x241.google.com with SMTP id p89-v6so23508342ljb.3
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 01:25:46 -0700 (PDT)
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Wed, 17 Oct 2018 14:24:20 +0600
Message-Id: <e771f96ab94e86b54b9a783c974f2af3009fe5d1.1539764043.git.artem.k.pisarenko@gmail.com>
In-Reply-To: <cover.1539764043.git.artem.k.pisarenko@gmail.com>
References: <cover.1539764043.git.artem.k.pisarenko@gmail.com>
In-Reply-To: <cover.1539764043.git.artem.k.pisarenko@gmail.com>
References: <cover.1539764043.git.artem.k.pisarenko@gmail.com>
Subject: [Qemu-devel] [PATCH v2 3/4] Restores record/replay behavior related
 to special virtual clock processing for timers used in external subsystems.
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

 include/qemu/timer.h | 12 +++++++++---
 slirp/ip6_icmp.c     |  4 +++-
 ui/input.c           |  5 +++--
 util/qemu-timer.c    | 50 +++++++++++++++++++++++++++++++++++++++++++-------
 4 files changed, 58 insertions(+), 13 deletions(-)

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index e225ad4..8e3f236 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -65,14 +65,20 @@ typedef enum {
  * instead each attribute in bit set accessed with QEMU_TIMER_ATTR_<id> macro,
  * where <id> is a unique part of attribute identifier.
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
 
 typedef enum {
-    QEMU_TIMER_ATTRBIT__NONE
+    QEMU_TIMER_ATTRBIT_EXTERNAL,
 } QEMUTimerAttrBit;
 
-#define QEMU_TIMER_ATTR__NONE (1 << QEMU_TIMER_ATTRBIT__NONE)
+#define QEMU_TIMER_ATTR_EXTERNAL (1 << QEMU_TIMER_ATTRBIT_EXTERNAL)
 
 typedef struct QEMUTimerList QEMUTimerList;
 
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
index 2046b68..e9a0f00 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -494,6 +494,7 @@ bool timerlist_run_timers(QEMUTimerList *timer_list)
     bool progress = false;
     QEMUTimerCB *cb;
     void *opaque;
+    bool need_replay_checkpoint = false;
 
     if (!atomic_read(&timer_list->active_timers)) {
         return false;
@@ -509,8 +510,15 @@ bool timerlist_run_timers(QEMUTimerList *timer_list)
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
@@ -525,13 +533,38 @@ bool timerlist_run_timers(QEMUTimerList *timer_list)
         break;
     }
 
+    /*
+     * Extract expired timers from active timers list and and process them.
+     *
+     * In rr mode we need "filtered" checkpointing for virtual clock.
+     * Checkpoint must be replayed before any non-EXTERNAL timer has been
+     * processed and only one time (virtual clock value stays same). But these
+     * timers may appear in the timers list while it being processed, so this
+     * must be checked until we finally decide that "no timers left - we are
+     * done".
+     */
     current_time = qemu_clock_get_ns(timer_list->clock->type);
-    for(;;) {
-        qemu_mutex_lock(&timer_list->active_timers_lock);
-        ts = timer_list->active_timers;
+    qemu_mutex_lock(&timer_list->active_timers_lock);
+    while ((ts = timer_list->active_timers)) {
         if (!timer_expired_ns(ts, current_time)) {
+            /* No expired timers left.
+             * (If rr checkpoint was needed, it either already handled,
+             *  or may be skipped.) */
+            break;
+        }
+        if (need_replay_checkpoint
+                && !(ts->attributes & QEMU_TIMER_ATTR_EXTERNAL)) {
+            /* once we got here, checkpoint clock only once */
+            need_replay_checkpoint = false;
             qemu_mutex_unlock(&timer_list->active_timers_lock);
-            break;
+            if (!replay_checkpoint(CHECKPOINT_CLOCK_VIRTUAL)) {
+                goto out;
+            }
+            qemu_mutex_lock(&timer_list->active_timers_lock);
+            /* it's better to start over again,
+             * just in case if timer list was modified
+             */
+            continue;
         }
 
         /* remove timer from the list before calling the callback */
@@ -540,12 +573,15 @@ bool timerlist_run_timers(QEMUTimerList *timer_list)
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
2.7.4
