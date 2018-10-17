Received: from eggs.gnu.org ([2001:4830:134:3::10]:50681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gCh9J-00075R-Ms
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:25:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gCh9I-0008Jc-Oa
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:25:49 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:41688)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <artem.k.pisarenko@gmail.com>)
	id 1gCh9I-0008Ic-Ed
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:25:48 -0400
Received: by mail-lj1-x242.google.com with SMTP id u21-v6so23469859lja.8
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 01:25:48 -0700 (PDT)
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Wed, 17 Oct 2018 14:24:21 +0600
Message-Id: <549dbf4ebfa4c82051d01a264c27f88929fc277b.1539764043.git.artem.k.pisarenko@gmail.com>
In-Reply-To: <cover.1539764043.git.artem.k.pisarenko@gmail.com>
References: <cover.1539764043.git.artem.k.pisarenko@gmail.com>
In-Reply-To: <cover.1539764043.git.artem.k.pisarenko@gmail.com>
References: <cover.1539764043.git.artem.k.pisarenko@gmail.com>
Subject: [Qemu-devel] [PATCH v2 4/4] Optimize record/replay checkpointing
 for all clocks it applies to
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>, Artem Pisarenko <artem.k.pisarenko@gmail.com>

Removes redundant checkpoints in replay log when there are no expired timers in timers list, associated with corresponding clock (i.e. no rr events associated with current clock value).
This also improves performance in rr mode.

Signed-off-by: Artem Pisarenko <artem.k.pisarenko@gmail.com>
---
 include/qemu/timer.h |  2 +-
 util/qemu-timer.c    | 62 +++++++++++++++++++++++++---------------------------
 2 files changed, 31 insertions(+), 33 deletions(-)

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 8e3f236..bd627dc 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -70,7 +70,7 @@ typedef enum {
  * QEMU_TIMER_ATTR_EXTERNAL: drives external subsystem
  *
  * Timers with this attribute do not recorded in rr mode, therefore it could be
- * used for the subsystems that operate outside the guest core. Applicable only
+ * used for the subsystems that operate outside the guest core. Relevant only
  * with virtual clock type.
  */
 
diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index e9a0f00..7315ca1 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -495,6 +495,7 @@ bool timerlist_run_timers(QEMUTimerList *timer_list)
     QEMUTimerCB *cb;
     void *opaque;
     bool need_replay_checkpoint = false;
+    ReplayCheckpoint replay_checkpoint_id;
 
     if (!atomic_read(&timer_list->active_timers)) {
         return false;
@@ -505,43 +506,40 @@ bool timerlist_run_timers(QEMUTimerList *timer_list)
         goto out;
     }
 
-    switch (timer_list->clock->type) {
-    case QEMU_CLOCK_REALTIME:
-        break;
-    default:
-    case QEMU_CLOCK_VIRTUAL:
-        if (replay_mode != REPLAY_MODE_NONE) {
-            /* Checkpoint for virtual clock is redundant in cases where
-             * it's being triggered with only non-EXTERNAL timers, because
-             * these timers don't change guest state directly.
-             * Since it has conditional dependence on specific timers, it is
-             * subject to race conditions and requires special handling.
-             * See below.
-             */
+    if (replay_mode != REPLAY_MODE_NONE) {
+        /* Postpone actual checkpointing to timer list processing
+         * to properly check if we actually need it.
+         */
+        switch (timer_list->clock->type) {
+        case QEMU_CLOCK_VIRTUAL:
             need_replay_checkpoint = true;
+            replay_checkpoint_id = CHECKPOINT_CLOCK_VIRTUAL;
+            break;
+        case QEMU_CLOCK_HOST:
+            need_replay_checkpoint = true;
+            replay_checkpoint_id = CHECKPOINT_CLOCK_HOST;
+            break;
+        case QEMU_CLOCK_VIRTUAL_RT:
+            need_replay_checkpoint = true;
+            replay_checkpoint_id = CHECKPOINT_CLOCK_VIRTUAL_RT;
+            break;
+        default:
+            break;
         }
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
     }
 
     /*
-     * Extract expired timers from active timers list and and process them.
+     * Extract expired timers from active timers list and and process them,
+     * taking into account checkpointing required in rr mode.
      *
-     * In rr mode we need "filtered" checkpointing for virtual clock.
-     * Checkpoint must be replayed before any non-EXTERNAL timer has been
-     * processed and only one time (virtual clock value stays same). But these
-     * timers may appear in the timers list while it being processed, so this
-     * must be checked until we finally decide that "no timers left - we are
-     * done".
+     * Checkpoint must be replayed before any timer has been processed
+     * and only one time. But new timers may appear in the timers list while
+     * it's being processed, so this must be checked until we finally decide
+     * that "no timers left - we are done" (to avoid skipping checkpoint due to
+     * possible races).
+     * Also checkpoint for virtual clock is redundant in cases where it's being
+     * triggered with only non-EXTERNAL timers, because these timers don't
+     * change guest state directly.
      */
     current_time = qemu_clock_get_ns(timer_list->clock->type);
     qemu_mutex_lock(&timer_list->active_timers_lock);
@@ -557,7 +555,7 @@ bool timerlist_run_timers(QEMUTimerList *timer_list)
             /* once we got here, checkpoint clock only once */
             need_replay_checkpoint = false;
             qemu_mutex_unlock(&timer_list->active_timers_lock);
-            if (!replay_checkpoint(CHECKPOINT_CLOCK_VIRTUAL)) {
+            if (!replay_checkpoint(replay_checkpoint_id)) {
                 goto out;
             }
             qemu_mutex_lock(&timer_list->active_timers_lock);
-- 
2.7.4
