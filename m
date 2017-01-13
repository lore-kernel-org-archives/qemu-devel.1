Received: from eggs.gnu.org ([2001:4830:134:3::10]:51371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cS8qH-0002GM-E1
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 15:52:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cS8qF-00023A-TN
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 15:52:57 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 13 Jan 2017 21:52:33 +0100
Message-Id: <20170113205237.30386-6-mreitz@redhat.com>
In-Reply-To: <20170113205237.30386-1-mreitz@redhat.com>
References: <20170113205237.30386-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v6 5/9] block: Add bdrv_filename()
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

Split the part which actually refreshes the BlockDriverState.filename
field off of bdrv_refresh_filename() into a more generic function
bdrv_filename(), which first calls bdrv_refresh_filename() and then
stores a qemu-usable filename in the given buffer instead of
BlockDriverState.filename.

Since bdrv_refresh_filename() therefore no longer refreshes that field,
all of the existing calls to that function have to be replaced by calls
to bdrv_filename() "manually" refreshing the BDS filename field (this is
only temporary).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block.h |  1 +
 block.c               | 50 +++++++++++++++++++++++++++++++++++++++++---------
 block/replication.c   |  2 +-
 blockdev.c            |  3 ++-
 4 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 3425e9fa79..8abc3da69f 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -252,6 +252,7 @@ BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
     const char *backing_file);
 int bdrv_get_backing_file_depth(BlockDriverState *bs);
 void bdrv_refresh_filename(BlockDriverState *bs);
+char *bdrv_filename(BlockDriverState *bs, char *dest, size_t sz);
 int bdrv_truncate(BlockDriverState *bs, int64_t offset);
 int64_t bdrv_nb_sectors(BlockDriverState *bs);
 int64_t bdrv_getlength(BlockDriverState *bs);
diff --git a/block.c b/block.c
index 19f8a84d03..a631d94702 100644
--- a/block.c
+++ b/block.c
@@ -1731,7 +1731,8 @@ static BlockDriverState *bdrv_append_temp_snapshot(BlockDriverState *bs,
     bdrv_append(bs_snapshot, bs);
 
     bs_snapshot->backing_overridden = true;
-    bdrv_refresh_filename(bs_snapshot);
+    bdrv_filename(bs_snapshot, bs_snapshot->filename,
+                  sizeof(bs_snapshot->filename));
 
     g_free(tmp_filename);
     return bs_snapshot;
@@ -1923,7 +1924,7 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
         }
     }
 
-    bdrv_refresh_filename(bs);
+    bdrv_filename(bs, bs->filename, sizeof(bs->filename));
 
     /* Check if any unknown options were used */
     if (options && (qdict_size(options) != 0)) {
@@ -4101,9 +4102,6 @@ static bool append_significant_runtime_options(QDict *d, BlockDriverState *bs)
  *  - full_open_options: Options which, when given when opening a block device
  *                       (without a filename), result in a BDS (mostly)
  *                       equalling the given one
- *  - filename: If exact_filename is set, it is copied here. Otherwise,
- *              full_open_options is converted to a JSON object, prefixed with
- *              "json:" (for use through the JSON pseudo protocol) and put here.
  */
 void bdrv_refresh_filename(BlockDriverState *bs)
 {
@@ -4120,7 +4118,8 @@ void bdrv_refresh_filename(BlockDriverState *bs)
     /* This BDS's file name may depend on any of its children's file names, so
      * refresh those first */
     QLIST_FOREACH(child, &bs->children, next) {
-        bdrv_refresh_filename(child->bs);
+        bdrv_filename(child->bs, child->bs->filename,
+                      sizeof(child->bs->filename));
 
         if (child->role == &child_backing && child->bs->backing_overridden) {
             bs->backing_overridden = true;
@@ -4184,15 +4183,48 @@ void bdrv_refresh_filename(BlockDriverState *bs)
             strcpy(bs->exact_filename, bs->file->bs->exact_filename);
         }
     }
+}
+
+/* First refreshes exact_filename and full_open_options by calling
+ * bdrv_refresh_filename(). Then, if exact_filename is set, it is copied into
+ * the target buffer. Otherwise, full_open_options is converted to a JSON
+ * object, prefixed with "json:" (for use through the JSON pseudo protocol) and
+ * put there.
+ *
+ * If @dest is not NULL, the filename will be truncated to @sz - 1 bytes and
+ * placed there. If @sz > 0, it will always be null-terminated.
+ *
+ * If @dest is NULL, @sz is ignored and a new buffer will be allocated which is
+ * large enough to hold the filename and the trailing '\0'. This buffer is then
+ * returned and has to be freed by the caller when it is no longer needed.
+ *
+ * Returns @dest if it is not NULL, and the newly allocated buffer otherwise.
+ */
+char *bdrv_filename(BlockDriverState *bs, char *dest, size_t sz)
+{
+    bdrv_refresh_filename(bs);
+
+    if (sz > INT_MAX) {
+        sz = INT_MAX;
+    }
 
     if (bs->exact_filename[0]) {
-        pstrcpy(bs->filename, sizeof(bs->filename), bs->exact_filename);
+        if (dest) {
+            pstrcpy(dest, sz, bs->exact_filename);
+        } else {
+            dest = g_strdup(bs->exact_filename);
+        }
     } else {
         QString *json = qobject_to_json(QOBJECT(bs->full_open_options));
-        snprintf(bs->filename, sizeof(bs->filename), "json:%s",
-                 qstring_get_str(json));
+        if (dest) {
+            snprintf(dest, sz, "json:%s", qstring_get_str(json));
+        } else {
+            dest = g_strdup_printf("json:%s", qstring_get_str(json));
+        }
         QDECREF(json);
     }
+
+    return dest;
 }
 
 char *bdrv_dirname(BlockDriverState *bs, Error **errp)
diff --git a/block/replication.c b/block/replication.c
index 729dd12499..4deff13645 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -586,7 +586,7 @@ static void replication_done(void *opaque, int ret)
         s->replication_state = BLOCK_REPLICATION_DONE;
 
         /* refresh top bs's filename */
-        bdrv_refresh_filename(bs);
+        bdrv_filename(bs, bs->filename, sizeof(bs->filename));
         s->active_disk = NULL;
         s->secondary_disk = NULL;
         s->hidden_disk = NULL;
diff --git a/blockdev.c b/blockdev.c
index 7889babd40..4128fee78f 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1797,7 +1797,8 @@ static void external_snapshot_commit(BlkActionState *common)
 
     if (image_was_existing) {
         state->new_bs->backing_overridden = true;
-        bdrv_refresh_filename(state->new_bs);
+        bdrv_filename(state->new_bs, state->new_bs->filename,
+                      sizeof(state->new_bs->filename));
     }
 }
 
-- 
2.11.0
