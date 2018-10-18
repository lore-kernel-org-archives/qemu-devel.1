Received: from eggs.gnu.org ([2001:4830:134:3::10]:48876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gD1sU-0002SG-2d
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 02:33:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gD1sQ-0002tF-1R
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 02:33:49 -0400
Received: from mail.ispras.ru ([83.149.199.45]:52082)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gD1sP-0002mt-ND
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 02:33:45 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Thu, 18 Oct 2018 09:33:45 +0300
Message-ID: <20181018063345.7433.11678.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] replay: don't process events at virtual clock
 checkpoint
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, artem.k.pisarenko@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, pavel.dovgaluk@ispras.ru

As QEMU becomes more multi-threaded and non-synchronized, checkpoints
move from thread to thread. And the event queue that processed at checkpoints
should belong to the same thread in both record and replay executions.
This patch disables asynchronous event processing at virtual clock
checkpoint, because it may be invoked in different threads at record and
replay. This patch is temporary fix until the checkpoints are completely
refactored.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 replay/replay-events.c |    1 +
 replay/replay.c        |    9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/replay/replay-events.c b/replay/replay-events.c
index 83a7d81..60e8c21 100644
--- a/replay/replay-events.c
+++ b/replay/replay-events.c
@@ -205,6 +205,7 @@ void replay_save_events(int checkpoint)
 {
     g_assert(replay_mutex_locked());
     g_assert(checkpoint != CHECKPOINT_CLOCK_WARP_START);
+    g_assert(checkpoint != CHECKPOINT_CLOCK_VIRTUAL);
     while (!QTAILQ_EMPTY(&events_list)) {
         Event *event = QTAILQ_FIRST(&events_list);
         replay_save_event(event, checkpoint);
diff --git a/replay/replay.c b/replay/replay.c
index 93d2573..fdf1778 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -231,7 +231,14 @@ bool replay_checkpoint(ReplayCheckpoint checkpoint)
         /* This checkpoint belongs to several threads.
            Processing events from different threads is
            non-deterministic */
-        if (checkpoint != CHECKPOINT_CLOCK_WARP_START) {
+        if (checkpoint != CHECKPOINT_CLOCK_WARP_START
+            /* FIXME: this is temporary fix, other checkpoints
+                      may also be invoked from the different threads someday.
+                      Asynchronous event processing should be refactored
+                      to create additional replay event kind which is
+                      nailed to the one of the threads and which processes
+                      the event queue. */
+            && checkpoint != CHECKPOINT_CLOCK_VIRTUAL) {
             replay_save_events(checkpoint);
         }
         res = true;
