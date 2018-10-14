Received: from eggs.gnu.org ([2001:4830:134:3::10]:56791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gBhpb-0000Ow-Ln
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 10:57:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gBhpR-0003WN-RE
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 10:57:18 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:39983)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <artem.k.pisarenko@gmail.com>)
	id 1gBhpO-0003Pg-5t
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 10:57:12 -0400
Received: by mail-lj1-x241.google.com with SMTP id r83-v6so15208788ljr.7
	for <qemu-devel@nongnu.org>; Sun, 14 Oct 2018 07:57:08 -0700 (PDT)
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Sun, 14 Oct 2018 20:55:09 +0600
Message-Id: <f203d1b772f7e4087f8e64f5f23ae313835413d4.1539528213.git.artem.k.pisarenko@gmail.com>
In-Reply-To: <cover.1539528213.git.artem.k.pisarenko@gmail.com>
References: <cover.1539528213.git.artem.k.pisarenko@gmail.com>
In-Reply-To: <cover.1539528213.git.artem.k.pisarenko@gmail.com>
References: <cover.1539528213.git.artem.k.pisarenko@gmail.com>
Subject: [Qemu-devel] [PATCH 3/3] Restores record/replay behavior related to
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
 include/qemu/timer.h | 10 ++++++--
 slirp/ip6_icmp.c     |  4 +++-
 ui/input.c           |  5 ++--
 util/qemu-timer.c    | 67 ++++++++++++++++++++++++++++++++++++----------------
 4 files changed, 60 insertions(+), 26 deletions(-)

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
index 29d8e39..8c6d1cb 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -490,6 +490,7 @@ bool timerlist_run_timers(QEMUTimerList *timer_list)
     bool progress = false;
     QEMUTimerCB *cb;
     void *opaque;
+    bool need_replay_checkpoint = false;
 
     if (!atomic_read(&timer_list->active_timers)) {
         return false;
@@ -500,28 +501,52 @@ bool timerlist_run_timers(QEMUTimerList *timer_list)
         goto out;
     }
 
-    switch (timer_list->clock->type) {
-    case QEMU_CLOCK_REALTIME:
-        break;
-    default:
-    case QEMU_CLOCK_VIRTUAL:
-        if (!replay_checkpoint(CHECKPOINT_CLOCK_VIRTUAL)) {
-            goto out;
-        }
-        break;
-    case QEMU_CLOCK_HOST:
-        if (!replay_checkpoint(CHECKPOINT_CLOCK_HOST)) {
-            goto out;
-        }
-        break;
-    case QEMU_CLOCK_VIRTUAL_RT:
-        if (!replay_checkpoint(CHECKPOINT_CLOCK_VIRTUAL_RT)) {
-            goto out;
-        }
-        break;
-    }
-
     current_time = qemu_clock_get_ns(timer_list->clock->type);
+
+    if (replay_mode != REPLAY_MODE_NONE) {
+        switch (timer_list->clock->type) {
+        case QEMU_CLOCK_REALTIME:
+            break;
+        default:
+        case QEMU_CLOCK_VIRTUAL:
+            /* Check whether there are pending timers used for external
+             * subsystems, before doing replay checkpoint. If there are only
+             * such timers, then checkpoint will be redundant, because these
+             * timers don't change guest state directly.
+             * Procedure optimized to finish traversing timer list quickly,
+             * because it's a rare condition.
+             */
+            qemu_mutex_lock(&timer_list->active_timers_lock);
+            ts = timer_list->active_timers;
+            while (timer_expired_ns(ts, current_time)) {
+                if (!(ts->attributes & QEMU_TIMER_ATTR(EXTERNAL))) {
+                    need_replay_checkpoint = true;
+                    break;
+                }
+                ts = ts->next;
+            }
+            qemu_mutex_unlock(&timer_list->active_timers_lock);
+            if (!need_replay_checkpoint) {
+                break;
+            }
+
+            if (!replay_checkpoint(CHECKPOINT_CLOCK_VIRTUAL)) {
+                goto out;
+            }
+            break;
+        case QEMU_CLOCK_HOST:
+            if (!replay_checkpoint(CHECKPOINT_CLOCK_HOST)) {
+                goto out;
+            }
+            break;
+        case QEMU_CLOCK_VIRTUAL_RT:
+            if (!replay_checkpoint(CHECKPOINT_CLOCK_VIRTUAL_RT)) {
+                goto out;
+            }
+            break;
+        }
+    }
+
     for(;;) {
         qemu_mutex_lock(&timer_list->active_timers_lock);
         ts = timer_list->active_timers;
-- 
2.7.4
