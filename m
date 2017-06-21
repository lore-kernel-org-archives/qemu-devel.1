Received: from eggs.gnu.org ([2001:4830:134:3::10]:33832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dNf6H-0007fl-8J
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:51:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dNf6G-0004wF-2A
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:51:13 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 21 Jun 2017 14:50:27 +0200
Message-Id: <20170621125047.30294-6-mreitz@redhat.com>
In-Reply-To: <20170621125047.30294-1-mreitz@redhat.com>
References: <20170621125047.30294-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v5 05/25] block: Make path_combine() return the
 path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>

Besides being safe for arbitrary path lengths, after some follow-up
patches all callers will want a freshly allocated buffer anyway.

In the meantime, path_combine_deprecated() is added which has the same
interface as path_combine() had before this patch. All callers to that
function will be converted in follow-up patches.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block.h |  4 +--
 block.c               | 85 ++++++++++++++++++++++++++++-----------------------
 block/vmdk.c          |  3 +-
 3 files changed, 49 insertions(+), 43 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 5bebff4..9f89fa7 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -501,9 +501,7 @@ void bdrv_get_full_backing_filename_from_filename(const char *backed,
 
 int path_has_protocol(const char *path);
 int path_is_absolute(const char *path);
-void path_combine(char *dest, int dest_size,
-                  const char *base_path,
-                  const char *filename);
+char *path_combine(const char *base_path, const char *filename);
 
 int bdrv_readv_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos);
 int bdrv_writev_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos);
diff --git a/block.c b/block.c
index fd10a16..80e4805 100644
--- a/block.c
+++ b/block.c
@@ -148,53 +148,62 @@ int path_is_absolute(const char *path)
 #endif
 }
 
-/* if filename is absolute, just copy it to dest. Otherwise, build a
+/* if filename is absolute, just return its duplicate. Otherwise, build a
    path to it by considering it is relative to base_path. URL are
    supported. */
-void path_combine(char *dest, int dest_size,
-                  const char *base_path,
-                  const char *filename)
+char *path_combine(const char *base_path, const char *filename)
 {
+    const char *protocol_stripped = NULL;
     const char *p, *p1;
+    char *result;
     int len;
 
-    if (dest_size <= 0)
-        return;
     if (path_is_absolute(filename)) {
-        pstrcpy(dest, dest_size, filename);
-    } else {
-        const char *protocol_stripped = NULL;
+        return g_strdup(filename);
+    }
 
-        if (path_has_protocol(base_path)) {
-            protocol_stripped = strchr(base_path, ':');
-            if (protocol_stripped) {
-                protocol_stripped++;
-            }
+    if (path_has_protocol(base_path)) {
+        protocol_stripped = strchr(base_path, ':');
+        if (protocol_stripped) {
+            protocol_stripped++;
         }
-        p = protocol_stripped ?: base_path;
+    }
+    p = protocol_stripped ?: base_path;
 
-        p1 = strrchr(base_path, '/');
+    p1 = strrchr(base_path, '/');
 #ifdef _WIN32
-        {
-            const char *p2;
-            p2 = strrchr(base_path, '\\');
-            if (!p1 || p2 > p1)
-                p1 = p2;
+    {
+        const char *p2;
+        p2 = strrchr(base_path, '\\');
+        if (!p1 || p2 > p1) {
+            p1 = p2;
         }
+    }
 #endif
-        if (p1)
-            p1++;
-        else
-            p1 = base_path;
-        if (p1 > p)
-            p = p1;
-        len = p - base_path;
-        if (len > dest_size - 1)
-            len = dest_size - 1;
-        memcpy(dest, base_path, len);
-        dest[len] = '\0';
-        pstrcat(dest, dest_size, filename);
+    if (p1) {
+        p1++;
+    } else {
+        p1 = base_path;
+    }
+    if (p1 > p) {
+        p = p1;
     }
+    len = p - base_path;
+
+    result = g_malloc(len + strlen(filename) + 1);
+    memcpy(result, base_path, len);
+    strcpy(result + len, filename);
+
+    return result;
+}
+
+static void path_combine_deprecated(char *dest, int dest_size,
+                                    const char *base_path,
+                                    const char *filename)
+{
+    char *combined = path_combine(base_path, filename);
+    pstrcpy(dest, dest_size, combined);
+    g_free(combined);
 }
 
 /*
@@ -291,7 +300,7 @@ void bdrv_get_full_backing_filename_from_filename(const char *backed,
         error_setg(errp, "Cannot use relative backing file names for '%s'",
                    backed);
     } else {
-        path_combine(dest, sz, backed, backing);
+        path_combine_deprecated(dest, sz, backed, backing);
     }
 }
 
@@ -3965,8 +3974,8 @@ BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
         } else {
             /* If not an absolute filename path, make it relative to the current
              * image's filename path */
-            path_combine(filename_tmp, PATH_MAX, curr_bs->filename,
-                         backing_file);
+            path_combine_deprecated(filename_tmp, PATH_MAX, curr_bs->filename,
+                                    backing_file);
 
             /* We are going to compare absolute pathnames */
             if (!realpath(filename_tmp, filename_full)) {
@@ -3975,8 +3984,8 @@ BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
 
             /* We need to make sure the backing filename we are comparing against
              * is relative to the current image filename (or absolute) */
-            path_combine(filename_tmp, PATH_MAX, curr_bs->filename,
-                         curr_bs->backing_file);
+            path_combine_deprecated(filename_tmp, PATH_MAX, curr_bs->filename,
+                                    curr_bs->backing_file);
 
             if (!realpath(filename_tmp, backing_file_full)) {
                 continue;
diff --git a/block/vmdk.c b/block/vmdk.c
index 55581b0..4389a69 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -846,8 +846,7 @@ static int vmdk_parse_extents(const char *desc, BlockDriverState *bs,
             return -EINVAL;
         }
 
-        extent_path = g_malloc0(PATH_MAX);
-        path_combine(extent_path, PATH_MAX, desc_file_path, fname);
+        extent_path = path_combine(desc_file_path, fname);
 
         ret = snprintf(extent_opt_prefix, 32, "extents.%d", s->num_extents);
         assert(ret < 32);
-- 
2.9.4
