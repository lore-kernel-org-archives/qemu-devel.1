Received: from eggs.gnu.org ([2001:4830:134:3::10]:47280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eZYCa-0001EG-VY
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 03:27:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eZYCW-00026k-UK
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 03:27:08 -0500
Received: from mail.ispras.ru ([83.149.199.45]:41942)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eZYCW-000261-Ln
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 03:27:04 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Thu, 11 Jan 2018 11:27:05 +0300
Message-ID: <20180111082705.27295.83775.stgit@pasha-VirtualBox>
In-Reply-To: <20180111082452.27295.85707.stgit@pasha-VirtualBox>
References: <20180111082452.27295.85707.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH v3 23/30] replay: avoid recursive call of
 checkpoints
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

This patch adds a flag which denies recursive call of replay_checkpoint
function. Checkpoints may be accompanied by the hardware events. When event
is processed, virtual device may invoke timer modification functions that
also invoke the checkpoint function. This leads to infinite loop.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 replay/replay.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/replay/replay.c b/replay/replay.c
index 585c5de..c9fd984 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -176,13 +176,24 @@ void replay_shutdown_request(ShutdownCause cause)
 bool replay_checkpoint(ReplayCheckpoint checkpoint)
 {
     bool res = false;
+    static bool in_checkpoint = false;
     assert(EVENT_CHECKPOINT + checkpoint <= EVENT_CHECKPOINT_LAST);
-    replay_save_instructions();
 
     if (!replay_file) {
         return true;
     }
 
+    if (in_checkpoint) {
+        /* If we are already in checkpoint, then there is no need
+           for additional synchronization.
+           Recursion occurs when HW event modifies timers.
+           Timer modification may invoke the checkpoint and
+           proceed to recursion. */
+        return true;
+    }
+    in_checkpoint = true;
+
+    replay_save_instructions();
 
     if (replay_mode == REPLAY_MODE_PLAY) {
         g_assert(replay_mutex_locked());
@@ -204,6 +215,7 @@ bool replay_checkpoint(ReplayCheckpoint checkpoint)
         res = true;
     }
 out:
+    in_checkpoint = false;
     return res;
 }
 
