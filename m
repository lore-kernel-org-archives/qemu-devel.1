Received: from eggs.gnu.org ([2001:4830:134:3::10]:53953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gD7FE-0006kG-9I
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 08:17:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gD7FA-0000z9-Gt
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 08:17:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gD7FA-0000wv-7a
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 08:17:36 -0400
References: <cover.1539860473.git.artem.k.pisarenko@gmail.com>
	<ecc524bb47e169394f9bed88c979fdc8d990111a.1539861171.git.artem.k.pisarenko@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ede122b1-f98b-b094-f106-119d25243382@redhat.com>
Date: Thu, 18 Oct 2018 14:17:31 +0200
MIME-Version: 1.0
In-Reply-To: <ecc524bb47e169394f9bed88c979fdc8d990111a.1539861171.git.artem.k.pisarenko@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] Optimize record/replay checkpointing
 for all clocks it applies to
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artem Pisarenko <artem.k.pisarenko@gmail.com>, qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

On 18/10/2018 13:16, Artem Pisarenko wrote:
> Removes redundant checkpoints in replay log when there are no expired timers in timers list, associated with corresponding clock (i.e. no rr events associated with current clock value).
> This also improves performance in rr mode.
> 
> Signed-off-by: Artem Pisarenko <artem.k.pisarenko@gmail.com>
> ---
> 
> Oops, forgot to commit this fix
> 
>     v3:
>     - fixed compiler warning caused non-debug build to fail

We can also move the switch statement to a separate function, it
simplifies the code:

diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 8a2ad3bce2..3a64ce33d3 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -482,6 +482,26 @@ bool timer_expired(QEMUTimer *timer_head, int64_t
current_time)
     return timer_expired_ns(timer_head, current_time * timer_head->scale);
 }

+static bool timer_checkpoint(QEMUClockType clock)
+{
+    if (replay_mode != REPLAY_MODE_NONE) {
+        switch (clock) {
+        case QEMU_CLOCK_VIRTUAL:
+            return replay_checkpoint(CHECKPOINT_CLOCK_VIRTUAL);
+        case QEMU_CLOCK_HOST:
+            return replay_checkpoint(CHECKPOINT_CLOCK_HOST);
+        case QEMU_CLOCK_VIRTUAL_RT:
+            return replay_checkpoint(CHECKPOINT_CLOCK_VIRTUAL_RT);
+        default:
+            /* QEMU_CLOCK_REALTIME is external to the emulation and does
+             * not need checkpointing.
+             */
+            break;
+        }
+    }
+    return true;
+}
+
 bool timerlist_run_timers(QEMUTimerList *timer_list)
 {
     QEMUTimer *ts;
@@ -489,8 +509,7 @@ bool timerlist_run_timers(QEMUTimerList *timer_list)
     bool progress = false;
     QEMUTimerCB *cb;
     void *opaque;
-    bool need_replay_checkpoint = false;
-    ReplayCheckpoint replay_checkpoint_id;
+    bool need_replay_checkpoint = true;

     if (!atomic_read(&timer_list->active_timers)) {
         return false;
@@ -501,28 +520,6 @@ bool timerlist_run_timers(QEMUTimerList *timer_list)
         goto out;
     }

-    if (replay_mode != REPLAY_MODE_NONE) {
-        /* Postpone actual checkpointing to timer list processing
-         * to properly check if we actually need it.
-         */
-        switch (timer_list->clock->type) {
-        case QEMU_CLOCK_VIRTUAL:
-            need_replay_checkpoint = true;
-            replay_checkpoint_id = CHECKPOINT_CLOCK_VIRTUAL;
-            break;
-        case QEMU_CLOCK_HOST:
-            need_replay_checkpoint = true;
-            replay_checkpoint_id = CHECKPOINT_CLOCK_HOST;
-            break;
-        case QEMU_CLOCK_VIRTUAL_RT:
-            need_replay_checkpoint = true;
-            replay_checkpoint_id = CHECKPOINT_CLOCK_VIRTUAL_RT;
-            break;
-        default:
-            break;
-        }
-    }
-
     /*
      * Extract expired timers from active timers list and and process them,
      * taking into account checkpointing required in rr mode.
@@ -545,11 +542,11 @@ bool timerlist_run_timers(QEMUTimerList *timer_list)
             break;
         }
         if (need_replay_checkpoint
                 && !(ts->attributes & QEMU_TIMER_ATTR_EXTERNAL)) {
             /* once we got here, checkpoint clock only once */
             need_replay_checkpoint = false;
             qemu_mutex_unlock(&timer_list->active_timers_lock);
-            if (!replay_checkpoint(replay_checkpoint_id)) {
+            if (!timer_checkpoint(timer_list->clock->type)) {
                 goto out;
             }
             qemu_mutex_lock(&timer_list->active_timers_lock);


No need to do anything on your part.

Paolo
