Received: from eggs.gnu.org ([2001:4830:134:3::10]:47757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1g00NM-0001Zk-DI
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 04:19:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1g00NH-0000vA-8V
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 04:19:52 -0400
Received: from mail.ispras.ru ([83.149.199.45]:56112)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1g00NG-0000v1-SM
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 04:19:47 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Wed, 12 Sep 2018 11:19:45 +0300
Message-ID: <20180912081945.3228.19776.stgit@pasha-VirtualBox>
In-Reply-To: <20180912081747.3228.21861.stgit@pasha-VirtualBox>
References: <20180912081747.3228.21861.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v6 20/25] replay: wake up vCPU when replaying
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
index f31a70a..b12a02f 100644
--- a/cpus.c
+++ b/cpus.c
@@ -576,18 +576,29 @@ void qemu_start_warp_timer(void)
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
index c1646b0..3130e45 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -144,6 +144,9 @@ void replay_shutdown_request(ShutdownCause cause);
     Returns 0 in PLAY mode if checkpoint was not found.
     Returns 1 in all other cases. */
 bool replay_checkpoint(ReplayCheckpoint checkpoint);
+/*! Used to determine that checkpoint is pending.
+    Does not proceed to the next event in the log. */
+bool replay_has_checkpoint(void);
 
 /* Asynchronous events queue */
 
diff --git a/replay/replay.c b/replay/replay.c
index a106211..2145686 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -241,6 +241,18 @@ out:
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
