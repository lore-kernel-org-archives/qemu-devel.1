Received: from eggs.gnu.org ([2001:4830:134:3::10]:39656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fiIiq-0003IV-0U
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:16:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fiIim-0006uI-W6
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:16:51 -0400
Received: from mail.ispras.ru ([83.149.199.45]:36894)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fiIim-0006sO-Is
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:16:48 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Wed, 25 Jul 2018 15:16:49 +0300
Message-ID: <20180725121649.12867.55853.stgit@pasha-VirtualBox>
In-Reply-To: <20180725121311.12867.21729.stgit@pasha-VirtualBox>
References: <20180725121311.12867.21729.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v5 21/24] replay: wake up vCPU when replaying
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, thomas.dullien@googlemail.com, pbonzini@redhat.com, mreitz@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

In record/replay icount mode vCPU thread and iothread synchronize
the execution using the checkpoints.
vCPU thread processes the virtual timers and iothread processes all others.
When iothread wants to wake up sleeping vCPU thread, it sends dummy queued
work. Therefore it could be the following sequence of the events in
record mode:
 - IO: sending dummy work
 - IO: processing timers
 - CPU: wakeup
 - CPU: clearing dummy work
 - CPU: processing virtual timers

But due to the races in replay mode the sequence may change:
 - IO: sending dummy work
 - CPU: wakeup
 - CPU: clearing dummy work
 - CPU: sleeping again because nothing to do
 - IO: Processing timers
 - CPU: zzzz

In this case vCPU will not wake up, because dummy work is not to be set up
again.

This patch tries to wake up the vCPU when it sleeps and the icount warp
checkpoint isn't met. It means that vCPU has something to do, because
there are no other reasons of non-matching warp checkpoint.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

--

v5: improve checking that vCPU is still sleeping
---
 cpus.c                  |   31 +++++++++++++++++++++----------
 include/sysemu/replay.h |    3 +++
 replay/replay.c         |   12 ++++++++++++
 3 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/cpus.c b/cpus.c
index 181ce33..38bd521 100644
--- a/cpus.c
+++ b/cpus.c
@@ -539,18 +539,29 @@ void qemu_start_warp_timer(void)
         return;
     }
 
-    /* warp clock deterministically in record/replay mode */
-    if (!replay_checkpoint(CHECKPOINT_CLOCK_WARP_START)) {
-        return;
-    }
+    if (replay_mode != REPLAY_MODE_PLAY) {
+        if (!all_cpu_threads_idle()) {
+            return;
+        }
 
-    if (!all_cpu_threads_idle()) {
-        return;
-    }
+        if (qtest_enabled()) {
+            /* When testing, qtest commands advance icount.  */
+            return;
+        }
 
-    if (qtest_enabled()) {
-        /* When testing, qtest commands advance icount.  */
-        return;
+        replay_checkpoint(CHECKPOINT_CLOCK_WARP_START);
+    } else {
+        /* warp clock deterministically in record/replay mode */
+        if (!replay_checkpoint(CHECKPOINT_CLOCK_WARP_START)) {
+            /* vCPU is sleeping and warp can't be started.
+               It is probably a race condition: notification sent
+               to vCPU was processed in advance and vCPU went to sleep.
+               Therefore we have to wake it up for doing someting. */
+            if (replay_has_checkpoint()) {
+                qemu_clock_notify(QEMU_CLOCK_VIRTUAL);
+            }
+            return;
+        }
     }
 
     /* We want to use the earliest deadline from ALL vm_clocks */
diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index a3113c1..8118b00 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -136,6 +136,9 @@ void replay_shutdown_request(ShutdownCause cause);
     Returns 0 in PLAY mode if checkpoint was not found.
     Returns 1 in all other cases. */
 bool replay_checkpoint(ReplayCheckpoint checkpoint);
+/*! Used to determine that checkpoint is pending.
+    Does not proceed to the next event in the log. */
+bool replay_has_checkpoint(void);
 
 /* Asynchronous events queue */
 
diff --git a/replay/replay.c b/replay/replay.c
index dcce902..6e82764 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -240,6 +240,18 @@ out:
     return res;
 }
 
+bool replay_has_checkpoint(void)
+{
+    bool res = false;
+    if (replay_mode == REPLAY_MODE_PLAY) {
+        g_assert(replay_mutex_locked());
+        replay_account_executed_instructions();
+        res = EVENT_CHECKPOINT <= replay_state.data_kind
+              && replay_state.data_kind <= EVENT_CHECKPOINT_LAST;
+    }
+    return res;
+}
+
 static void replay_enable(const char *fname, int mode)
 {
     const char *fmode = NULL;
