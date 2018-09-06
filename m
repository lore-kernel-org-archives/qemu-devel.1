Received: from eggs.gnu.org ([2001:4830:134:3::10]:52031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fxqjM-0005jn-Bb
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 05:37:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fxqjK-0003lc-3o
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 05:37:40 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu,  6 Sep 2018 12:37:09 +0300
Message-Id: <70655489911f1b2335aa4ae715e153fbb57a37b1.1536226505.git.berto@igalia.com>
In-Reply-To: <cover.1536226505.git.berto@igalia.com>
References: <cover.1536226505.git.berto@igalia.com>
In-Reply-To: <cover.1536226505.git.berto@igalia.com>
References: <cover.1536226505.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v3 09/10] block: Allow changing 'detect-zeroes'
 on reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

'detect-zeroes' is one of the basic BlockdevOptions available for all
drivers, but it's not handled by bdrv_reopen_prepare(), so any attempt
to change it results in an error:

   (qemu) qemu-io virtio0 "reopen -o detect-zeroes=on"
   Cannot change the option 'detect-zeroes'

Since there's no reason why we shouldn't allow changing it and the
implementation is simple let's just do it.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block.c               | 64 ++++++++++++++++++++++++++++++++-------------------
 include/block/block.h |  1 +
 2 files changed, 41 insertions(+), 24 deletions(-)

diff --git a/block.c b/block.c
index bd8467bed8..808411ebf3 100644
--- a/block.c
+++ b/block.c
@@ -764,6 +764,31 @@ static void bdrv_join_options(BlockDriverState *bs, QDict *options,
     }
 }
 
+static BlockdevDetectZeroesOptions bdrv_parse_detect_zeroes(QemuOpts *opts,
+                                                            int open_flags,
+                                                            Error **errp)
+{
+    Error *local_err = NULL;
+    char *value = qemu_opt_get_del(opts, "detect-zeroes");
+    BlockdevDetectZeroesOptions detect_zeroes =
+        qapi_enum_parse(&BlockdevDetectZeroesOptions_lookup, value,
+                        BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF, &local_err);
+    g_free(value);
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
@@ -1328,7 +1353,6 @@ static int bdrv_open_common(BlockDriverState *bs, BlockBackend *file,
     const char *driver_name = NULL;
     const char *node_name = NULL;
     const char *discard;
-    const char *detect_zeroes;
     QemuOpts *opts;
     BlockDriver *drv;
     Error *local_err = NULL;
@@ -1417,29 +1441,12 @@ static int bdrv_open_common(BlockDriverState *bs, BlockBackend *file,
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
@@ -3187,6 +3194,14 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
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
     /* All other options (including node-name and driver) must be unchanged.
      * Put them back into the QDict, so that they are checked at the end
      * of this function. */
@@ -3337,6 +3352,7 @@ void bdrv_reopen_commit(BDRVReopenState *reopen_state)
     bs->options            = reopen_state->options;
     bs->open_flags         = reopen_state->flags;
     bs->read_only = !(reopen_state->flags & BDRV_O_RDWR);
+    bs->detect_zeroes      = reopen_state->detect_zeroes;
 
     /* Remove child references from bs->options and bs->explicit_options.
      * Child options were already removed in bdrv_reopen_queue_child() */
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
