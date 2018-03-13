Received: from eggs.gnu.org ([2001:4830:134:3::10]:58806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsir-0006Uh-5b
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsiq-0004Fd-5E
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:45 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:40150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evsip-0004Et-Ur
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:44 -0400
Received: by mail-wm0-x244.google.com with SMTP id t6so882099wmt.5
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:48:43 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:47:16 +0100
Message-Id: <20180313224719.4954-67-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 66/69] replay: don't process async events when
 warping the clock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

Virtual clock is warped from iothread and vcpu thread. When the hardware
events associated with warp checkpoint, then interrupt delivering may be
non-deterministic if checkpoint is processed in different threads in record
and replay.
This patch disables event processing for clock warp checkpoint and leaves
all hardware events to other checkpoints (e.g., virtual clock).

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Message-Id: <20180227095316.1060.4134.stgit@pasha-VirtualBox>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 replay/replay-events.c | 1 +
 replay/replay.c        | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/replay/replay-events.c b/replay/replay-events.c
index 54dd9d2606..3d5fc8a479 100644
--- a/replay/replay-events.c
+++ b/replay/replay-events.c
@@ -205,6 +205,7 @@ static void replay_save_event(Event *event, int checkpoint)
 void replay_save_events(int checkpoint)
 {
     g_assert(replay_mutex_locked());
+    g_assert(checkpoint != CHECKPOINT_CLOCK_WARP_START);
     while (!QTAILQ_EMPTY(&events_list)) {
         Event *event = QTAILQ_FIRST(&events_list);
         replay_save_event(event, checkpoint);
diff --git a/replay/replay.c b/replay/replay.c
index eae8daf18a..8228261401 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -211,7 +211,12 @@ bool replay_checkpoint(ReplayCheckpoint checkpoint)
     } else if (replay_mode == REPLAY_MODE_RECORD) {
         g_assert(replay_mutex_locked());
         replay_put_event(EVENT_CHECKPOINT + checkpoint);
-        replay_save_events(checkpoint);
+        /* This checkpoint belongs to several threads.
+           Processing events from different threads is
+           non-deterministic */
+        if (checkpoint != CHECKPOINT_CLOCK_WARP_START) {
+            replay_save_events(checkpoint);
+        }
         res = true;
     }
 out:
-- 
2.14.3
