Received: from eggs.gnu.org ([2001:4830:134:3::10]:60110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ftvl9-00082n-H1
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 10:11:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ftvl6-0006z7-CL
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 10:11:19 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Sun, 26 Aug 2018 17:09:39 +0300
Message-Id: <2827c309182950530885b95f0582677b8d99d347.1535291602.git.berto@igalia.com>
In-Reply-To: <cover.1535291602.git.berto@igalia.com>
References: <cover.1535291602.git.berto@igalia.com>
In-Reply-To: <cover.1535291602.git.berto@igalia.com>
References: <cover.1535291602.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 8/9] block: Allow changing 'detect-zeroes' on
 reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

'detect-zeroes' is one of the basic BlockdevOptions available for all
drivers, but it's silently ignored by bdrv_reopen_prepare/commit(), so
the user cannot change it and doesn't get an error explaining that it
can't be changed.

This should update the detect-zeroes setting, but does nothing:

   (qemu) qemu-io virtio0 "reopen -o detect-zeroes=on"

This should return an error but also does nothing:

   (qemu) qemu-io virtio0 "reopen -o discard=off,detect-zeroes=unmap"

Since there's no reason why we shouldn't allow changing it and the
implementation is simple let's just do it.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block.c               | 63 +++++++++++++++++++++++++++++++--------------------
 include/block/block.h |  1 +
 2 files changed, 40 insertions(+), 24 deletions(-)

diff --git a/block.c b/block.c
index 21f1eb9cd1..9aed5c19f4 100644
--- a/block.c
+++ b/block.c
@@ -764,6 +764,30 @@ static void bdrv_join_options(BlockDriverState *bs, QDict *options,
     }
 }
 
+static BlockdevDetectZeroesOptions bdrv_parse_detect_zeroes(QemuOpts *opts,
+                                                            int open_flags,
+                                                            Error **errp)
+{
+    Error *local_err = NULL;
+    const char *value = qemu_opt_get(opts, "detect-zeroes");
+    BlockdevDetectZeroesOptions detect_zeroes =
+        qapi_enum_parse(&BlockdevDetectZeroesOptions_lookup, value,
+                        BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return detect_zeroes;
+    }
+
+    if (detect_zeroes == BLOCKDEV_DETECT_ZEROES_OPTIONS_UNMAP &&
+        !(open_flags & BDRV_O_UNMAP))
+    {
+        error_setg(errp, "setting detect-zeroes to unmap is not allowed "
+                   "without setting discard operation to unmap");
+    }
+
+    return detect_zeroes;
+}
+
 /**
  * Set open flags for a given discard mode
  *
@@ -1328,7 +1352,6 @@ static int bdrv_open_common(BlockDriverState *bs, BlockBackend *file,
     const char *driver_name = NULL;
     const char *node_name = NULL;
     const char *discard;
-    const char *detect_zeroes;
     QemuOpts *opts;
     BlockDriver *drv;
     Error *local_err = NULL;
@@ -1417,29 +1440,12 @@ static int bdrv_open_common(BlockDriverState *bs, BlockBackend *file,
         }
     }
 
-    detect_zeroes = qemu_opt_get(opts, "detect-zeroes");
-    if (detect_zeroes) {
-        BlockdevDetectZeroesOptions value =
-            qapi_enum_parse(&BlockdevDetectZeroesOptions_lookup,
-                            detect_zeroes,
-                            BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF,
-                            &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
-            ret = -EINVAL;
-            goto fail_opts;
-        }
-
-        if (value == BLOCKDEV_DETECT_ZEROES_OPTIONS_UNMAP &&
-            !(bs->open_flags & BDRV_O_UNMAP))
-        {
-            error_setg(errp, "setting detect-zeroes to unmap is not allowed "
-                             "without setting discard operation to unmap");
-            ret = -EINVAL;
-            goto fail_opts;
-        }
-
-        bs->detect_zeroes = value;
+    bs->detect_zeroes =
+        bdrv_parse_detect_zeroes(opts, bs->open_flags, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        ret = -EINVAL;
+        goto fail_opts;
     }
 
     if (filename != NULL) {
@@ -3187,6 +3193,14 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
         }
     }
 
+    reopen_state->detect_zeroes =
+        bdrv_parse_detect_zeroes(opts, reopen_state->flags, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        ret = -EINVAL;
+        goto error;
+    }
+
     /* node-name and driver must be unchanged. Put them back into the QDict, so
      * that they are checked at the end of this function. */
     value = qemu_opt_get(opts, "node-name");
@@ -3344,6 +3358,7 @@ void bdrv_reopen_commit(BDRVReopenState *reopen_state)
     bs->options            = reopen_state->options;
     bs->open_flags         = reopen_state->flags;
     bs->read_only = !(reopen_state->flags & BDRV_O_RDWR);
+    bs->detect_zeroes      = reopen_state->detect_zeroes;
 
     /* Remove child references from bs->options and bs->explicit_options */
     QLIST_FOREACH(child, &bs->children, next) {
diff --git a/include/block/block.h b/include/block/block.h
index 4e0871aaf9..f71fa5a1c4 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -184,6 +184,7 @@ typedef QSIMPLEQ_HEAD(BlockReopenQueue, BlockReopenQueueEntry) BlockReopenQueue;
 typedef struct BDRVReopenState {
     BlockDriverState *bs;
     int flags;
+    BlockdevDetectZeroesOptions detect_zeroes;
     uint64_t perm, shared_perm;
     QDict *options;
     QDict *explicit_options;
-- 
2.11.0
