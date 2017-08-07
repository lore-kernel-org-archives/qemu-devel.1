Received: from eggs.gnu.org ([2001:4830:134:3::10]:49308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJJ-0007fB-Iq
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJ4-000477-5I
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:13 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:24 +0200
Message-Id: <1502117160-24655-21-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 20/56] block: Make ImageInfo sizes unsigned
 in QAPI/QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, dgilbert@redhat.com, quintela@redhat.com, berrange@redhat.com, qemu-block@nongnu.org

Sizes should use QAPI type 'size' (uint64_t).  ImageInfo members
@virtual-size, @actual-size, @cluster-size are 'int' (int64_t).
bdrv_query_image_info() gets their values from bdrv_getlength(),
bdrv_get_allocated_file_size(), bdrv_get_info(), all signed.  It
ensures the former two are non-negative, but doesn't bother with
cluster-size.  vmdk_get_extent_info() initializes virtual-size and
cluster-size from signed #sectors * BDRV_SECTOR_SIZE without checking
for overflow.  Perhaps we should be more careful with sizes
overflowing into signs, but that's not something I can tackle now.

Change these ImageInfo members to 'size'.

query-named-block-nodes and query-block would now report image sizes
above 2^63-1 correctly instead of their (negative) two's complement,
if such values were possible (they aren't; the block layer uses
int64_t internally).

So would HMP's "info block", except for the ones it formats with
get_human_readable_size(), which is still signed.  To be fixed next.

Same for "qemu-img info".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/qapi.c         | 15 ++++++++++-----
 qapi/block-core.json |  5 +++--
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/block/qapi.c b/block/qapi.c
index 5f1a71f..1c6123c 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -235,7 +235,7 @@ void bdrv_query_image_info(BlockDriverState *bs,
                            ImageInfo **p_info,
                            Error **errp)
 {
-    int64_t size;
+    int64_t size, allocated_size;
     const char *backing_filename;
     BlockDriverInfo bdi;
     int ret;
@@ -251,12 +251,16 @@ void bdrv_query_image_info(BlockDriverState *bs,
         goto out;
     }
 
+    allocated_size = bdrv_get_allocated_file_size(bs);
+
     info = g_new0(ImageInfo, 1);
     info->filename        = g_strdup(bs->filename);
     info->format          = g_strdup(bdrv_get_format_name(bs));
     info->virtual_size    = size;
-    info->actual_size     = bdrv_get_allocated_file_size(bs);
-    info->has_actual_size = info->actual_size >= 0;
+    if (allocated_size >= 0) {
+        info->actual_size = allocated_size;
+        info->has_actual_size = true;
+    }
     if (bdrv_is_encrypted(bs)) {
         info->encrypted = true;
         info->has_encrypted = true;
@@ -727,6 +731,7 @@ void bdrv_image_info_dump(fprintf_function func_fprintf, void *f,
                           ImageInfo *info)
 {
     char size_buf[128], dsize_buf[128];
+
     if (!info->has_actual_size) {
         snprintf(dsize_buf, sizeof(dsize_buf), "unavailable");
     } else {
@@ -737,7 +742,7 @@ void bdrv_image_info_dump(fprintf_function func_fprintf, void *f,
     func_fprintf(f,
                  "image: %s\n"
                  "file format: %s\n"
-                 "virtual size: %s (%" PRId64 " bytes)\n"
+                 "virtual size: %s (%" PRIu64 " bytes)\n"
                  "disk size: %s\n",
                  info->filename, info->format, size_buf,
                  info->virtual_size,
@@ -748,7 +753,7 @@ void bdrv_image_info_dump(fprintf_function func_fprintf, void *f,
     }
 
     if (info->has_cluster_size) {
-        func_fprintf(f, "cluster_size: %" PRId64 "\n",
+        func_fprintf(f, "cluster_size: %" PRIu64 "\n",
                        info->cluster_size);
     }
 
diff --git a/qapi/block-core.json b/qapi/block-core.json
index ecfeecd..02e12f7 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -156,8 +156,9 @@
 ##
 { 'struct': 'ImageInfo',
   'data': {'filename': 'str', 'format': 'str', '*dirty-flag': 'bool',
-           '*actual-size': 'int', 'virtual-size': 'int',
-           '*cluster-size': 'int', '*encrypted': 'bool', '*compressed': 'bool',
+           '*actual-size': 'size', 'virtual-size': 'size',
+           '*cluster-size': 'size',
+           '*encrypted': 'bool', '*compressed': 'bool',
            '*backing-filename': 'str', '*full-backing-filename': 'str',
            '*backing-filename-format': 'str', '*snapshots': ['SnapshotInfo'],
            '*backing-image': 'ImageInfo',
-- 
2.7.5
