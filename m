Received: from eggs.gnu.org ([2001:4830:134:3::10]:41004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eduMX-0002m7-PV
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:55:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eduMU-0000fN-Nn
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:55:25 -0500
Received: from mail.ispras.ru ([83.149.199.45]:57462)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eduMU-0000f3-AX
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:55:22 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 23 Jan 2018 11:55:22 +0300
Message-ID: <20180123085522.3419.52302.stgit@pasha-VirtualBox>
In-Reply-To: <20180123085319.3419.97865.stgit@pasha-VirtualBox>
References: <20180123085319.3419.97865.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH v5 22/24] replay: don't process async
 events when warping the clock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, pbonzini@redhat.com, alex.bennee@linaro.org

Virtual clock is warped from iothread and vcpu thread. When the hardware
events associated with warp checkpoint, then interrupt delivering may be
non-deterministic if checkpoint is processed in different threads in record
and replay.
This patch disables event processing for clock warp checkpoint and leaves
all hardware events to other checkpoints (e.g., virtual clock).

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

--

v4: added assert for replay_save_events function
---
 replay/replay-events.c |    1 +
 replay/replay.c        |    7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/replay/replay-events.c b/replay/replay-events.c
index a941efb..18d769f 100644
--- a/replay/replay-events.c
+++ b/replay/replay-events.c
@@ -204,6 +204,7 @@ static void replay_save_event(Event *event, int checkpoint)
 /* Called with replay mutex locked */
 void replay_save_events(int checkpoint)
 {
+    assert(checkpoint != CHECKPOINT_CLOCK_WARP_START);
     while (!QTAILQ_EMPTY(&events_list)) {
         Event *event = QTAILQ_FIRST(&events_list);
         replay_save_event(event, checkpoint);
diff --git a/replay/replay.c b/replay/replay.c
index c676dd4..e3794fc 100644
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
