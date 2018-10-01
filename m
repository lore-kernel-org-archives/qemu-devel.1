Received: from eggs.gnu.org ([2001:4830:134:3::10]:57610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g71r8-0002QR-9e
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 13:19:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g71r6-0007Be-Nb
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 13:19:38 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  1 Oct 2018 19:18:48 +0200
Message-Id: <20181001171901.11004-11-kwolf@redhat.com>
In-Reply-To: <20181001171901.11004-1-kwolf@redhat.com>
References: <20181001171901.11004-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 10/23] block: Allow changing 'detect-zeroes' on
 reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Alberto Garcia <berto@igalia.com>

'detect-zeroes' is one of the basic BlockdevOptions available for all
drivers, but it's not handled by bdrv_reopen_prepare(), so any attempt
to change it results in an error:

   (qemu) qemu-io virtio0 "reopen -o detect-zeroes=on"
   Cannot change the option 'detect-zeroes'

Since there's no reason why we shouldn't allow changing it and the
implementation is simple let's just do it.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h |  1 +
 block.c               | 64 ++++++++++++++++++++++++++++++++-------------------
 2 files changed, 41 insertions(+), 24 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 4edc1e8afa..b189cf422e 100644
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
diff --git a/block.c b/block.c
index 7fb267bd1f..7710b399a3 100644
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
@@ -3188,6 +3195,14 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
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
@@ -3338,6 +3353,7 @@ void bdrv_reopen_commit(BDRVReopenState *reopen_state)
     bs->options            = reopen_state->options;
     bs->open_flags         = reopen_state->flags;
     bs->read_only = !(reopen_state->flags & BDRV_O_RDWR);
+    bs->detect_zeroes      = reopen_state->detect_zeroes;
 
     /* Remove child references from bs->options and bs->explicit_options.
      * Child options were already removed in bdrv_reopen_queue_child() */
-- 
2.13.6
