Received: from eggs.gnu.org ([2001:4830:134:3::10]:47961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEy8-00075x-OK
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEy3-00069O-G2
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:31 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46267)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gDEy1-00067D-H3
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:25 -0400
Received: by mail-wr1-x444.google.com with SMTP id n11-v6so35030281wru.13
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 13:32:24 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Oct 2018 22:31:32 +0200
Message-Id: <1539894735-14232-6-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 05/48] qemu-timer: optimize record/replay
 checkpointing for all clocks
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

Removes redundant checkpoints in replay log when there are no expired
timers in timers list, associated with corresponding clock (i.e. no rr
events associated with current clock value).  This also improves
performance in rr mode.

Signed-off-by: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Message-Id: <549dbf4ebfa4c82051d01a264c27f88929fc277b.1539764043.git.artem.k.pisarenko@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/timer.h |  2 +-
 util/qemu-timer.c    | 67 +++++++++++++++++++++++-----------------------------
 2 files changed, 31 insertions(+), 38 deletions(-)

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 9f37c92..9c668c8 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -65,7 +65,7 @@ typedef enum {
  * QEMU_TIMER_ATTR_EXTERNAL: drives external subsystem
  *
  * Timers with this attribute do not recorded in rr mode, therefore it could be
- * used for the subsystems that operate outside the guest core. Applicable only
+ * used for the subsystems that operate outside the guest core. Relevant only
  * with virtual clock type.
  */
 
diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 1cc1b2f..8d3a806 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -482,6 +482,25 @@ bool timer_expired(QEMUTimer *timer_head, int64_t current_time)
     return timer_expired_ns(timer_head, current_time * timer_head->scale);
 }
 
+static bool timer_checkpoint(QEMUClockType clock)
+{
+    assert(replay_mode != REPLAY_MODE_NONE);
+    switch (clock) {
+    case QEMU_CLOCK_VIRTUAL:
+        return replay_checkpoint(CHECKPOINT_CLOCK_VIRTUAL);
+    case QEMU_CLOCK_HOST:
+        return replay_checkpoint(CHECKPOINT_CLOCK_HOST);
+    case QEMU_CLOCK_VIRTUAL_RT:
+        return replay_checkpoint(CHECKPOINT_CLOCK_VIRTUAL_RT);
+    default:
+        /* QEMU_CLOCK_REALTIME is external to the emulation and does
+         * not need checkpointing.
+         */
+        break;
+    }
+    return true;
+}
+
 bool timerlist_run_timers(QEMUTimerList *timer_list)
 {
     QEMUTimer *ts;
@@ -489,7 +508,7 @@ bool timerlist_run_timers(QEMUTimerList *timer_list)
     bool progress = false;
     QEMUTimerCB *cb;
     void *opaque;
-    bool need_replay_checkpoint = false;
+    bool need_replay_checkpoint = (replay_mode != REPLAY_MODE_NONE);
 
     if (!atomic_read(&timer_list->active_timers)) {
         return false;
@@ -500,43 +519,17 @@ bool timerlist_run_timers(QEMUTimerList *timer_list)
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
-            need_replay_checkpoint = true;
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
     /*
-     * Extract expired timers from active timers list and and process them.
+     * Extract expired timers from active timers list and and process them,
+     * taking into account checkpointing required in rr mode.
      *
-     * In rr mode we need "filtered" checkpointing for virtual clock.  The
-     * checkpoint must be recorded/replayed before processing any non-EXTERNAL timer,
-     * and that must only be done once since the clock value stays the same. Because
-     * non-EXTERNAL timers may appear in the timers list while it being processed,
-     * the checkpoint can be issued at a time until no timers are left and we are
-     * done".
+     * The checkpoint must be recorded/replayed before processing any non-EXTERNAL
+     * timer (external timers are those that don't affect guest state directly;
+     * usually they are QEMU_CLOCK_REALTIME, which doesn't checkpoint at all,
+     * but there are exceptions).  Checkpointing, furthermore, must only be done once
+     * since the clock value stays the same. Because non-EXTERNAL timers may appear
+     * in the timers list while it being processed, the checkpoint can be issued at
+     * a time until no timers are left and we are done".
      */
     current_time = qemu_clock_get_ns(timer_list->clock->type);
     qemu_mutex_lock(&timer_list->active_timers_lock);
@@ -552,7 +545,7 @@ bool timerlist_run_timers(QEMUTimerList *timer_list)
             /* once we got here, checkpoint clock only once */
             need_replay_checkpoint = false;
             qemu_mutex_unlock(&timer_list->active_timers_lock);
-            if (!replay_checkpoint(CHECKPOINT_CLOCK_VIRTUAL)) {
+            if (!timer_checkpoint(timer_list->clock->type)) {
                 goto out;
             }
             qemu_mutex_lock(&timer_list->active_timers_lock);
-- 
1.8.3.1
