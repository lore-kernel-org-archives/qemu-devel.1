Received: from eggs.gnu.org ([2001:4830:134:3::10]:51307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cS8qA-00029x-T0
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 15:52:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cS8q9-0001sw-4A
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 15:52:50 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 13 Jan 2017 21:52:30 +0100
Message-Id: <20170113205237.30386-3-mreitz@redhat.com>
In-Reply-To: <20170113205237.30386-1-mreitz@redhat.com>
References: <20170113205237.30386-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v6 2/9] block: Change
 bdrv_get_encrypted_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

Instead of returning a pointer to the filename, g_strdup() it. This will
become necessary once we do not have BlockDriverState.filename anymore.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h |  2 +-
 block.c               | 17 ++++++++++-------
 monitor.c             |  5 ++++-
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 7bcbd05338..3425e9fa79 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -432,7 +432,7 @@ void bdrv_round_to_clusters(BlockDriverState *bs,
                             int64_t *cluster_offset,
                             unsigned int *cluster_bytes);
 
-const char *bdrv_get_encrypted_filename(BlockDriverState *bs);
+char *bdrv_get_encrypted_filename(BlockDriverState *bs);
 void bdrv_get_backing_filename(BlockDriverState *bs,
                                char *filename, int filename_size);
 char *bdrv_get_full_backing_filename(BlockDriverState *bs, Error **errp);
diff --git a/block.c b/block.c
index c63fc1b2da..95015251d5 100644
--- a/block.c
+++ b/block.c
@@ -2858,10 +2858,12 @@ void bdrv_add_key(BlockDriverState *bs, const char *key, Error **errp)
         }
     } else {
         if (bdrv_key_required(bs)) {
+            char *enc_filename = bdrv_get_encrypted_filename(bs);
             error_set(errp, ERROR_CLASS_DEVICE_ENCRYPTED,
                       "'%s' (%s) is encrypted",
                       bdrv_get_device_or_node_name(bs),
-                      bdrv_get_encrypted_filename(bs));
+                      enc_filename ?: "");
+            g_free(enc_filename);
         }
     }
 }
@@ -3111,14 +3113,15 @@ bool bdrv_can_write_zeroes_with_unmap(BlockDriverState *bs)
     return false;
 }
 
-const char *bdrv_get_encrypted_filename(BlockDriverState *bs)
+char *bdrv_get_encrypted_filename(BlockDriverState *bs)
 {
-    if (bs->backing && bs->backing->bs->encrypted)
-        return bs->backing_file;
-    else if (bs->encrypted)
-        return bs->filename;
-    else
+    if (bs->backing && bs->backing->bs->encrypted) {
+        return g_strdup(bs->backing_file);
+    } else if (bs->encrypted) {
+        return g_strdup(bs->filename);
+    } else {
         return NULL;
+    }
 }
 
 void bdrv_get_backing_filename(BlockDriverState *bs,
diff --git a/monitor.c b/monitor.c
index 0841d436b0..bb3000a2df 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4056,10 +4056,13 @@ int monitor_read_bdrv_key_start(Monitor *mon, BlockDriverState *bs,
                                 BlockCompletionFunc *completion_cb,
                                 void *opaque)
 {
+    char *enc_filename;
     int err;
 
+    enc_filename = bdrv_get_encrypted_filename(bs);
     monitor_printf(mon, "%s (%s) is encrypted.\n", bdrv_get_device_name(bs),
-                   bdrv_get_encrypted_filename(bs));
+                   enc_filename ?: "");
+    g_free(enc_filename);
 
     mon->password_completion_cb = completion_cb;
     mon->password_opaque = opaque;
-- 
2.11.0
