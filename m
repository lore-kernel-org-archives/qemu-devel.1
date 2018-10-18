Received: from eggs.gnu.org ([2001:4830:134:3::10]:48100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyJ-0007JN-D1
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyF-0006Jv-J4
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:43 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gDEyD-0006Bd-Pr
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:39 -0400
Received: by mail-wr1-x443.google.com with SMTP id y16so35119741wrw.3
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 13:32:31 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Oct 2018 22:31:39 +0200
Message-Id: <1539894735-14232-13-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 12/48] replay: don't process events at virtual
 clock checkpoint
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

As QEMU becomes more multi-threaded and non-synchronized, checkpoints
move from thread to thread. And the event queue that processed at checkpoints
should belong to the same thread in both record and replay executions.
This patch disables asynchronous event processing at virtual clock
checkpoint, because it may be invoked in different threads at record and
replay. This patch is temporary fix until the checkpoints are completely
refactored.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Message-Id: <20181018063345.7433.11678.stgit@pasha-VirtualBox>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 replay/replay-events.c | 1 +
 replay/replay.c        | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/replay/replay-events.c b/replay/replay-events.c
index 0964a82..d9a2d49 100644
--- a/replay/replay-events.c
+++ b/replay/replay-events.c
@@ -190,6 +190,7 @@ void replay_save_events(int checkpoint)
 {
     g_assert(replay_mutex_locked());
     g_assert(checkpoint != CHECKPOINT_CLOCK_WARP_START);
+    g_assert(checkpoint != CHECKPOINT_CLOCK_VIRTUAL);
     while (!QTAILQ_EMPTY(&events_list)) {
         Event *event = QTAILQ_FIRST(&events_list);
         replay_save_event(event, checkpoint);
diff --git a/replay/replay.c b/replay/replay.c
index 379b51a..8b172b2 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -214,7 +214,14 @@ bool replay_checkpoint(ReplayCheckpoint checkpoint)
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
-- 
1.8.3.1
