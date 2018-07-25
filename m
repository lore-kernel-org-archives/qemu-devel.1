Received: from eggs.gnu.org ([2001:4830:134:3::10]:39619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fiIie-0003BM-Am
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:16:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fiIib-0006Rh-94
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:16:40 -0400
Received: from mail.ispras.ru ([83.149.199.45]:36854)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fiIia-0006Qy-W7
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:16:37 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Wed, 25 Jul 2018 15:16:38 +0300
Message-ID: <20180725121638.12867.27848.stgit@pasha-VirtualBox>
In-Reply-To: <20180725121311.12867.21729.stgit@pasha-VirtualBox>
References: <20180725121311.12867.21729.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v5 19/24] replay: allow loading any snapshots
 before recording
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

This patch enables using -loadvm in recording mode to allow starting
the execution recording from any of the available snapshots.
It also fixes loading of the record/replay state, therefore snapshots
created in replay mode may also be used for starting the new recording.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 replay/replay-snapshot.c |   17 ++++++++++++-----
 vl.c                     |    7 ++++---
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
index 2ab85cf..16bacc9 100644
--- a/replay/replay-snapshot.c
+++ b/replay/replay-snapshot.c
@@ -33,11 +33,18 @@ static int replay_pre_save(void *opaque)
 static int replay_post_load(void *opaque, int version_id)
 {
     ReplayState *state = opaque;
-    fseek(replay_file, state->file_offset, SEEK_SET);
-    qemu_clock_set_last(QEMU_CLOCK_HOST, state->host_clock_last);
-    /* If this was a vmstate, saved in recording mode,
-       we need to initialize replay data fields. */
-    replay_fetch_data_kind();
+    if (replay_mode == REPLAY_MODE_PLAY) {
+        fseek(replay_file, state->file_offset, SEEK_SET);
+        qemu_clock_set_last(QEMU_CLOCK_HOST, state->host_clock_last);
+        /* If this was a vmstate, saved in recording mode,
+           we need to initialize replay data fields. */
+        replay_fetch_data_kind();
+    } else if (replay_mode == REPLAY_MODE_RECORD) {
+        /* This is only useful for loading the initial state.
+           Therefore reset all the counters. */
+        state->instructions_count = 0;
+        state->block_request_id = 0;
+    }
 
     return 0;
 }
diff --git a/vl.c b/vl.c
index e86d295..59b018d 100644
--- a/vl.c
+++ b/vl.c
@@ -4616,15 +4616,16 @@ int main(int argc, char **argv, char **envp)
     replay_checkpoint(CHECKPOINT_RESET);
     qemu_system_reset(SHUTDOWN_CAUSE_NONE);
     register_global_state();
-    if (replay_mode != REPLAY_MODE_NONE) {
-        replay_vmstate_init();
-    } else if (loadvm) {
+    if (loadvm) {
         Error *local_err = NULL;
         if (load_snapshot(loadvm, &local_err) < 0) {
             error_report_err(local_err);
             autostart = 0;
         }
     }
+    if (replay_mode != REPLAY_MODE_NONE) {
+        replay_vmstate_init();
+    }
 
     qdev_prop_check_globals();
     if (vmstate_dump_file) {
