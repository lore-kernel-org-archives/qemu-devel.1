Received: from eggs.gnu.org ([2001:4830:134:3::10]:56840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1d6CKa-0003LB-MT
	for qemu-devel@nongnu.org; Thu, 04 May 2017 04:41:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1d6CKX-0006Is-IG
	for qemu-devel@nongnu.org; Thu, 04 May 2017 04:41:48 -0400
Received: from mail.ispras.ru ([83.149.199.45]:42266)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1d6CKX-0006IJ-3o
	for qemu-devel@nongnu.org; Thu, 04 May 2017 04:41:45 -0400
From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Date: Thu, 04 May 2017 11:41:48 +0300
Message-ID: <20170504084148.7488.77468.stgit@PASHA-ISP>
In-Reply-To: <20170504084135.7488.24715.stgit@PASHA-ISP>
References: <20170504084135.7488.24715.stgit@PASHA-ISP>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v9 02/10] blkreplay: create temporary overlay
 for underlaying devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, mst@redhat.com, jasowang@redhat.com, quintela@redhat.com, dovgaluk@ispras.ru, kraxel@redhat.com, pbonzini@redhat.com

This patch allows using '-snapshot' behavior in record/replay mode.
blkreplay layer creates temporary overlays on top of underlaying
disk images. It is needed, because creating an overlay over blkreplay
breaks the determinism.
This patch creates similar temporary overlay (when it is needed)
under the blkreplay driver. Therefore all block operations are controlled
by blkreplay.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 block/blkreplay.c |   65 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 stubs/replay.c    |    1 +
 vl.c              |    2 +-
 3 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/block/blkreplay.c b/block/blkreplay.c
index d13a98d691..a9bab72bfc 100644
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
+    bdrv_append(bs_snapshot, bs, errp);
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
index 9c8aa48c9c..9991ee5120 100644
--- a/stubs/replay.c
+++ b/stubs/replay.c
@@ -3,6 +3,7 @@
 #include "sysemu/sysemu.h"
 
 ReplayMode replay_mode;
+char *replay_snapshot;
 
 int64_t replay_save_clock(unsigned int kind, int64_t clock)
 {
diff --git a/vl.c b/vl.c
index f46e070e0d..eafb3ff7a4 100644
--- a/vl.c
+++ b/vl.c
@@ -4492,7 +4492,7 @@ int main(int argc, char **argv, char **envp)
         qapi_free_BlockdevOptions(bdo->bdo);
         g_free(bdo);
     }
-    if (snapshot || replay_mode != REPLAY_MODE_NONE) {
+    if (snapshot) {
         qemu_opts_foreach(qemu_find_opts("drive"), drive_enable_snapshot,
                           NULL, NULL);
     }
