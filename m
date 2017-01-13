Received: from eggs.gnu.org ([2001:4830:134:3::10]:51338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cS8qE-0002Cs-4l
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 15:52:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cS8qB-0001xd-Un
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 15:52:54 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 13 Jan 2017 21:52:31 +0100
Message-Id: <20170113205237.30386-4-mreitz@redhat.com>
In-Reply-To: <20170113205237.30386-1-mreitz@redhat.com>
References: <20170113205237.30386-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v6 3/9] block: Avoid BlockDriverState.filename
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

In places which directly pass a filename to the OS, we should not use
the filename field at all but exact_filename instead (although the
former currently equals the latter if that is set).

In raw_open_common(), we do not need to access BDS.filename because we
already have a local variable pointing to the filename.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c            | 5 +++--
 block/file-posix.c | 6 +++---
 block/file-win32.c | 4 ++--
 block/gluster.c    | 3 ++-
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/block.c b/block.c
index 95015251d5..9943d8eff6 100644
--- a/block.c
+++ b/block.c
@@ -1146,8 +1146,9 @@ static int bdrv_open_common(BlockDriverState *bs, BdrvChild *file,
     if (ret < 0) {
         if (local_err) {
             error_propagate(errp, local_err);
-        } else if (bs->filename[0]) {
-            error_setg_errno(errp, -ret, "Could not open '%s'", bs->filename);
+        } else if (bs->exact_filename[0]) {
+            error_setg_errno(errp, -ret, "Could not open '%s'",
+                             bs->exact_filename);
         } else {
             error_setg_errno(errp, -ret, "Could not open image");
         }
diff --git a/block/file-posix.c b/block/file-posix.c
index 28b47d977b..2e3acd622d 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -590,7 +590,7 @@ static int raw_reopen_prepare(BDRVReopenState *state,
 
     /* If we cannot use fcntl, or fcntl failed, fall back to qemu_open() */
     if (rs->fd == -1) {
-        const char *normalized_filename = state->bs->filename;
+        const char *normalized_filename = state->bs->exact_filename;
         ret = raw_normalize_devicepath(&normalized_filename);
         if (ret < 0) {
             error_setg_errno(errp, -ret, "Could not normalize device path");
@@ -2075,7 +2075,7 @@ static bool hdev_is_sg(BlockDriverState *bs)
     int sg_version;
     int ret;
 
-    if (stat(bs->filename, &st) < 0 || !S_ISCHR(st.st_mode)) {
+    if (stat(bs->exact_filename, &st) < 0 || !S_ISCHR(st.st_mode)) {
         return false;
     }
 
@@ -2510,7 +2510,7 @@ static int cdrom_reopen(BlockDriverState *bs)
      */
     if (s->fd >= 0)
         qemu_close(s->fd);
-    fd = qemu_open(bs->filename, s->open_flags, 0644);
+    fd = qemu_open(bs->exact_filename, s->open_flags, 0644);
     if (fd < 0) {
         s->fd = -1;
         return -EIO;
diff --git a/block/file-win32.c b/block/file-win32.c
index 800fabdd72..040c71830e 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -457,7 +457,7 @@ static void raw_close(BlockDriverState *bs)
 
     CloseHandle(s->hfile);
     if (bs->open_flags & BDRV_O_TEMPORARY) {
-        unlink(bs->filename);
+        unlink(bs->exact_filename);
     }
 }
 
@@ -525,7 +525,7 @@ static int64_t raw_get_allocated_file_size(BlockDriverState *bs)
                                               DWORD * high);
     get_compressed_t get_compressed;
     struct _stati64 st;
-    const char *filename = bs->filename;
+    const char *filename = bs->exact_filename;
     /* WinNT support GetCompressedFileSize to determine allocate size */
     get_compressed =
         (get_compressed_t) GetProcAddress(GetModuleHandle("kernel32"),
diff --git a/block/gluster.c b/block/gluster.c
index ded13fb5fb..f6c2484c11 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -878,7 +878,8 @@ static int qemu_gluster_reopen_prepare(BDRVReopenState *state,
     gconf->has_debug = true;
     gconf->logfile = g_strdup(s->logfile);
     gconf->has_logfile = true;
-    reop_s->glfs = qemu_gluster_init(gconf, state->bs->filename, NULL, errp);
+    reop_s->glfs = qemu_gluster_init(gconf, state->bs->exact_filename, NULL,
+                                     errp);
     if (reop_s->glfs == NULL) {
         ret = -errno;
         goto exit;
-- 
2.11.0
