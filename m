Received: from eggs.gnu.org ([2001:4830:134:3::10]:53122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fTUVM-0000j6-Um
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 11:49:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fTUVI-0003nA-0v
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 11:49:44 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 14 Jun 2018 18:49:00 +0300
Message-Id: <2de7c60c63a3824a46150b5b43f898887099a43e.1528991017.git.berto@igalia.com>
In-Reply-To: <cover.1528991017.git.berto@igalia.com>
References: <cover.1528991017.git.berto@igalia.com>
In-Reply-To: <cover.1528991017.git.berto@igalia.com>
References: <cover.1528991017.git.berto@igalia.com>
Subject: [Qemu-devel] [RFC PATCH 03/10] block: Allow changing
 'detect-zeroes' on reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alberto Garcia <berto@igalia.com>

'detect-zeroes' is one of the basic BlockdevOptions available for all
drivers, but it's silently ignored by bdrv_reopen_prepare/commit(), so
the user cannot change it and doesn't get an error explaining that it
can't be changed.

Since there's no reason why we shouldn't allow changing it and the
implementation is trivial, let's just do it.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block.c               | 54 ++++++++++++++++++++++++++++++++++++---------------
 include/block/block.h |  1 +
 2 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/block.c b/block.c
index e470db7e5e..4c186e54b6 100644
--- a/block.c
+++ b/block.c
@@ -759,6 +759,29 @@ static void bdrv_join_options(BlockDriverState *bs, QDict *options,
     }
 }
 
+static BlockdevDetectZeroesOptions bdrv_parse_detect_zeroes(const char *value,
+                                                            int open_flags,
+                                                            Error **errp)
+{
+    Error *local_err = NULL;
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
@@ -1390,27 +1413,14 @@ static int bdrv_open_common(BlockDriverState *bs, BlockBackend *file,
 
     detect_zeroes = qemu_opt_get(opts, "detect-zeroes");
     if (detect_zeroes) {
-        BlockdevDetectZeroesOptions value =
-            qapi_enum_parse(&BlockdevDetectZeroesOptions_lookup,
-                            detect_zeroes,
-                            BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF,
-                            &local_err);
+        bs->detect_zeroes = bdrv_parse_detect_zeroes(detect_zeroes,
+                                                     bs->open_flags,
+                                                     &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
             ret = -EINVAL;
             goto fail_opts;
         }
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
     }
 
     if (filename != NULL) {
@@ -3148,6 +3158,17 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
         }
     }
 
+    value = qemu_opt_get(opts, "detect-zeroes");
+    if (value) {
+        reopen_state->detect_zeroes =
+            bdrv_parse_detect_zeroes(value, reopen_state->flags, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            ret = -EINVAL;
+            goto error;
+        }
+    }
+
     /* node-name and driver must be unchanged. Put them back into the QDict, so
      * that they are checked at the end of this function. */
     value = qemu_opt_get(opts, "node-name");
@@ -3278,6 +3299,7 @@ void bdrv_reopen_commit(BDRVReopenState *reopen_state)
     bs->explicit_options   = reopen_state->explicit_options;
     bs->open_flags         = reopen_state->flags;
     bs->read_only = !(reopen_state->flags & BDRV_O_RDWR);
+    bs->detect_zeroes      = reopen_state->detect_zeroes;
 
     bdrv_refresh_limits(bs, NULL);
 
diff --git a/include/block/block.h b/include/block/block.h
index e677080c4e..1e78587331 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -159,6 +159,7 @@ typedef QSIMPLEQ_HEAD(BlockReopenQueue, BlockReopenQueueEntry) BlockReopenQueue;
 typedef struct BDRVReopenState {
     BlockDriverState *bs;
     int flags;
+    BlockdevDetectZeroesOptions detect_zeroes;
     uint64_t perm, shared_perm;
     QDict *options;
     QDict *explicit_options;
-- 
2.11.0
