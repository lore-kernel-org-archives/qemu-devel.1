Received: from eggs.gnu.org ([2001:4830:134:3::10]:49598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fGI7P-0005md-6G
	for qemu-devel@nongnu.org; Wed, 09 May 2018 01:58:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fGI7O-0000xI-AC
	for qemu-devel@nongnu.org; Wed, 09 May 2018 01:58:27 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed,  9 May 2018 13:57:59 +0800
Message-Id: <20180509055802.28423-3-famz@redhat.com>
In-Reply-To: <20180509055802.28423-1-famz@redhat.com>
References: <20180509055802.28423-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 2/5] vmdk: Refactor vmdk_create_extent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

The extracted vmdk_init_extent takes a BlockBackend object and
initializes the format metadata. It is the common part between "qemu-img
create" and "blockdev-create".

Add a "BlockBackend *pbb" parameter to vmdk_create_extent, to return the
opened BB to the caller in the next patch.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/vmdk.c | 71 +++++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 44 insertions(+), 27 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index 84f8bbe480..083942f806 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1714,35 +1714,17 @@ static int coroutine_fn vmdk_co_pwrite_zeroes(BlockDriverState *bs,
     return ret;
 }
 
-static int vmdk_create_extent(const char *filename, int64_t filesize,
-                              bool flat, bool compress, bool zeroed_grain,
-                              QemuOpts *opts, Error **errp)
+static int vmdk_init_extent(BlockBackend *blk,
+                            int64_t filesize, bool flat,
+                            bool compress, bool zeroed_grain,
+                            Error **errp)
 {
     int ret, i;
-    BlockBackend *blk = NULL;
     VMDK4Header header;
-    Error *local_err = NULL;
     uint32_t tmp, magic, grains, gd_sectors, gt_size, gt_count;
     uint32_t *gd_buf = NULL;
     int gd_buf_size;
 
-    ret = bdrv_create_file(filename, opts, &local_err);
-    if (ret < 0) {
-        error_propagate(errp, local_err);
-        goto exit;
-    }
-
-    blk = blk_new_open(filename, NULL, NULL,
-                       BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCOL,
-                       &local_err);
-    if (blk == NULL) {
-        error_propagate(errp, local_err);
-        ret = -EIO;
-        goto exit;
-    }
-
-    blk_set_allow_write_beyond_eof(blk, true);
-
     if (flat) {
         ret = blk_truncate(blk, filesize, PREALLOC_MODE_OFF, errp);
         goto exit;
@@ -1836,18 +1818,53 @@ static int vmdk_create_extent(const char *filename, int64_t filesize,
                      gd_buf, gd_buf_size, 0);
     if (ret < 0) {
         error_setg(errp, QERR_IO_ERROR);
-        goto exit;
     }
 
     ret = 0;
 exit:
-    if (blk) {
-        blk_unref(blk);
-    }
     g_free(gd_buf);
     return ret;
 }
 
+static int vmdk_create_extent(const char *filename, int64_t filesize,
+                              bool flat, bool compress, bool zeroed_grain,
+                              BlockBackend **pbb,
+                              QemuOpts *opts, Error **errp)
+{
+    int ret;
+    BlockBackend *blk = NULL;
+    Error *local_err = NULL;
+
+    ret = bdrv_create_file(filename, opts, &local_err);
+    if (ret < 0) {
+        error_propagate(errp, local_err);
+        goto exit;
+    }
+
+    blk = blk_new_open(filename, NULL, NULL,
+                       BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCOL,
+                       &local_err);
+    if (blk == NULL) {
+        error_propagate(errp, local_err);
+        ret = -EIO;
+        goto exit;
+    }
+
+    blk_set_allow_write_beyond_eof(blk, true);
+
+    ret = vmdk_init_extent(blk, filesize, flat, compress, zeroed_grain, errp);
+exit:
+    if (blk) {
+        if (pbb) {
+            *pbb = blk;
+        } else {
+            blk_unref(blk);
+            blk = NULL;
+        }
+    }
+    return ret;
+}
+
 static int filename_decompose(const char *filename, char *path, char *prefix,
                               char *postfix, size_t buf_len, Error **errp)
 {
@@ -2067,7 +2084,7 @@ static int coroutine_fn vmdk_co_create_opts(const char *filename, QemuOpts *opts
         snprintf(ext_filename, PATH_MAX, "%s%s", path, desc_filename);
 
         if (vmdk_create_extent(ext_filename, size,
-                               flat, compress, zeroed_grain, opts, errp)) {
+                               flat, compress, zeroed_grain, NULL, opts, errp)) {
             ret = -EINVAL;
             goto exit;
         }
-- 
2.14.3
