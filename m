Received: from eggs.gnu.org ([2001:4830:134:3::10]:58800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsir-0006UY-0I
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsin-0004Do-Pt
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:45 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:40563)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evsin-0004DG-KI
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:41 -0400
Received: by mail-wr0-x244.google.com with SMTP id s12so14667wre.7
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:48:41 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:47:14 +0100
Message-Id: <20180313224719.4954-65-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 64/69] replay: avoid recursive call of
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
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

This patch adds a flag which denies recursive call of replay_checkpoint
function. Checkpoints may be accompanied by the hardware events. When event
is processed, virtual device may invoke timer modification functions that
also invoke the checkpoint function. This leads to infinite loop.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Message-Id: <20180227095305.1060.56463.stgit@pasha-VirtualBox>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 replay/replay.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/replay/replay.c b/replay/replay.c
index 90f98b7490..eae8daf18a 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -176,13 +176,24 @@ void replay_shutdown_request(ShutdownCause cause)
 bool replay_checkpoint(ReplayCheckpoint checkpoint)
 {
     bool res = false;
+    static bool in_checkpoint;
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
 
-- 
2.14.3
