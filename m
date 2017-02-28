Received: from eggs.gnu.org ([2001:4830:134:3::10]:42977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cifRU-0005IL-2T
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:55:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cifRT-0006kD-3O
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:55:40 -0500
From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Date: Tue, 28 Feb 2017 13:55:33 +0300
Message-ID: <20170228105532.1284.71515.stgit@PASHA-ISP>
In-Reply-To: <20170228105521.1284.11059.stgit@PASHA-ISP>
References: <20170228105521.1284.11059.stgit@PASHA-ISP>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 2/3] blkreplay: create temporary overlay for
 underlaying devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, dovgaluk@ispras.ru, qemu-block@nongnu.org, mreitz@redhat.com

This patch allows using '-snapshot' behavior in record/replay mode.
blkreplay layer creates temporary overlays on top of underlaying
disk images. It is needed, because creating an overlay over blkreplay
breaks the determinism.
This patch creates similar temporary overlay (when it is needed)
under the blkreplay driver. Therefore all block operations are controlled
by blkreplay.

v2: removed useless ref/unref (as suggested by Kevin Wolf)

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 block/blkreplay.c |   65 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 stubs/replay.c    |    1 +
 vl.c              |    2 +-
 3 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/block/blkreplay.c b/block/blkreplay.c
index ddcf344..de91def 100644
--- a/block/blkreplay.c
+++ b/block/blkreplay.c
@@ -14,12 +14,69 @@
 #include "block/block_int.h"
 #include "sysemu/replay.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qstring.h"
 
 typedef struct Request {
     Coroutine *co;
     QEMUBH *bh;
 } Request;
 
+static BlockDriverState *blkreplay_append_snapshot(BlockDriverState *bs,
+                                                   Error **errp)
+{
+    int ret;
+    BlockDriverState *bs_snapshot;
+    int64_t total_size;
+    QemuOpts *opts = NULL;
+    char tmp_filename[PATH_MAX + 1];
+    QDict *snapshot_options = qdict_new();
+
+    /* Prepare options QDict for the overlay file */
+    qdict_put(snapshot_options, "file.driver", qstring_from_str("file"));
+    qdict_put(snapshot_options, "driver", qstring_from_str("qcow2"));
+
+    /* Create temporary file */
+    ret = get_tmp_filename(tmp_filename, PATH_MAX + 1);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "Could not get temporary filename");
+        goto out;
+    }
+    qdict_put(snapshot_options, "file.filename",
+              qstring_from_str(tmp_filename));
+
+    /* Get the required size from the image */
+    total_size = bdrv_getlength(bs);
+    if (total_size < 0) {
+        error_setg_errno(errp, -total_size, "Could not get image size");
+        goto out;
+    }
+
+    opts = qemu_opts_create(bdrv_qcow2.create_opts, NULL, 0, &error_abort);
+    qemu_opt_set_number(opts, BLOCK_OPT_SIZE, total_size, &error_abort);
+    ret = bdrv_create(&bdrv_qcow2, tmp_filename, opts, errp);
+    qemu_opts_del(opts);
+    if (ret < 0) {
+        error_prepend(errp, "Could not create temporary overlay '%s': ",
+                      tmp_filename);
+        goto out;
+    }
+
+    bs_snapshot = bdrv_open(NULL, NULL, snapshot_options,
+                            BDRV_O_RDWR | BDRV_O_TEMPORARY, errp);
+    snapshot_options = NULL;
+    if (!bs_snapshot) {
+        goto out;
+    }
+
+    bdrv_append(bs_snapshot, bs);
+
+    return bs_snapshot;
+
+out:
+    QDECREF(snapshot_options);
+    return NULL;
+}
+
 static int blkreplay_open(BlockDriverState *bs, QDict *options, int flags,
                           Error **errp)
 {
@@ -35,6 +92,14 @@ static int blkreplay_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail;
     }
 
+    /* Add temporary snapshot to preserve the image */
+    if (!replay_snapshot
+        && !blkreplay_append_snapshot(bs->file->bs, &local_err)) {
+        ret = -EINVAL;
+        error_propagate(errp, local_err);
+        goto fail;
+    }
+
     ret = 0;
 fail:
     if (ret < 0) {
diff --git a/stubs/replay.c b/stubs/replay.c
index 9c8aa48..9991ee5 100644
--- a/stubs/replay.c
+++ b/stubs/replay.c
@@ -3,6 +3,7 @@
 #include "sysemu/sysemu.h"
 
 ReplayMode replay_mode;
+char *replay_snapshot;
 
 int64_t replay_save_clock(unsigned int kind, int64_t clock)
 {
diff --git a/vl.c b/vl.c
index e10a27b..876a55a 100644
--- a/vl.c
+++ b/vl.c
@@ -4450,7 +4450,7 @@ int main(int argc, char **argv, char **envp)
     }
 
     /* open the virtual block devices */
-    if (snapshot || replay_mode != REPLAY_MODE_NONE) {
+    if (snapshot) {
         qemu_opts_foreach(qemu_find_opts("drive"), drive_enable_snapshot,
                           NULL, NULL);
     }
