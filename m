Received: from eggs.gnu.org ([2001:4830:134:3::10]:56755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fdeVj-0004fZ-OU
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 12:32:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fdeVi-00066Z-Ap
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 12:32:07 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 12 Jul 2018 18:31:49 +0200
Message-Id: <20180712163152.12521-5-kwolf@redhat.com>
In-Reply-To: <20180712163152.12521-1-kwolf@redhat.com>
References: <20180712163152.12521-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 4/7] file-posix: specify expected filetypes
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

From: John Snow <jsnow@redhat.com>

Adjust each caller of raw_open_common to specify if they are expecting
host and character devices or not. Tighten expectations of file types upon
open in the common code and refuse types that are not expected.

This has two effects:

(1) Character and block devices are now considered deprecated for the
    'file' driver, which expects only S_IFREG, and
(2) no file-posix driver (file, host_cdrom, or host_device) can open
    directories now.

I don't think there's a legitimate reason to open directories as if
they were files. This prevents QEMU from opening and attempting to probe
a directory inode, which can break in exciting ways. One of those ways
is lseek on ext4/xfs, which will return 0x7fffffffffffffff as the file
size instead of EISDIR. This can coax QEMU into responding with a
confusing "file too big" instead of "Hey, that's not a file".

See: https://bugs.launchpad.net/qemu/+bug/1739304/
Signed-off-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 39 +++++++++++++++++++++++++++++++--------
 qemu-doc.texi      |  6 ++++++
 2 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 28824aae65..60af4b3d51 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -438,7 +438,8 @@ static QemuOptsList raw_runtime_opts = {
 };
 
 static int raw_open_common(BlockDriverState *bs, QDict *options,
-                           int bdrv_flags, int open_flags, Error **errp)
+                           int bdrv_flags, int open_flags,
+                           bool device, Error **errp)
 {
     BDRVRawState *s = bs->opaque;
     QemuOpts *opts;
@@ -585,10 +586,32 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
         error_setg_errno(errp, errno, "Could not stat file");
         goto fail;
     }
-    if (S_ISREG(st.st_mode)) {
-        s->discard_zeroes = true;
-        s->has_fallocate = true;
+
+    if (!device) {
+        if (S_ISBLK(st.st_mode)) {
+            warn_report("Opening a block device as a file using the '%s' "
+                        "driver is deprecated", bs->drv->format_name);
+        } else if (S_ISCHR(st.st_mode)) {
+            warn_report("Opening a character device as a file using the '%s' "
+                        "driver is deprecated", bs->drv->format_name);
+        } else if (!S_ISREG(st.st_mode)) {
+            error_setg(errp, "A regular file was expected by the '%s' driver, "
+                       "but something else was given", bs->drv->format_name);
+            ret = -EINVAL;
+            goto fail;
+        } else {
+            s->discard_zeroes = true;
+            s->has_fallocate = true;
+        }
+    } else {
+        if (!(S_ISCHR(st.st_mode) || S_ISBLK(st.st_mode))) {
+            error_setg(errp, "'%s' driver expects either "
+                       "a character or block device", bs->drv->format_name);
+            ret = -EINVAL;
+            goto fail;
+        }
     }
+
     if (S_ISBLK(st.st_mode)) {
 #ifdef BLKDISCARDZEROES
         unsigned int arg;
@@ -641,7 +664,7 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
     BDRVRawState *s = bs->opaque;
 
     s->type = FTYPE_FILE;
-    return raw_open_common(bs, options, flags, 0, errp);
+    return raw_open_common(bs, options, flags, 0, false, errp);
 }
 
 typedef enum {
@@ -2939,7 +2962,7 @@ hdev_open_Mac_error:
 
     s->type = FTYPE_FILE;
 
-    ret = raw_open_common(bs, options, flags, 0, &local_err);
+    ret = raw_open_common(bs, options, flags, 0, true, &local_err);
     if (ret < 0) {
         error_propagate(errp, local_err);
 #if defined(__APPLE__) && defined(__MACH__)
@@ -3170,7 +3193,7 @@ static int cdrom_open(BlockDriverState *bs, QDict *options, int flags,
     s->type = FTYPE_CD;
 
     /* open will not fail even if no CD is inserted, so add O_NONBLOCK */
-    return raw_open_common(bs, options, flags, O_NONBLOCK, errp);
+    return raw_open_common(bs, options, flags, O_NONBLOCK, true, errp);
 }
 
 static int cdrom_probe_device(const char *filename)
@@ -3284,7 +3307,7 @@ static int cdrom_open(BlockDriverState *bs, QDict *options, int flags,
 
     s->type = FTYPE_CD;
 
-    ret = raw_open_common(bs, options, flags, 0, &local_err);
+    ret = raw_open_common(bs, options, flags, 0, true, &local_err);
     if (ret) {
         error_propagate(errp, local_err);
         return ret;
diff --git a/qemu-doc.texi b/qemu-doc.texi
index 0fbf8b108b..1047c407e7 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2969,6 +2969,12 @@ replacement since it is not needed anymore.
 The @option{-enable-hax} option has been replaced by @option{-accel hax}.
 Both options have been introduced in QEMU version 2.9.0.
 
+@subsection -drive file=json:@{...@{'driver':'file'@}@} (since 3.0)
+
+The 'file' driver for drives is no longer appropriate for character or host
+devices and will only accept regular files (S_IFREG). The correct driver
+for these file types is 'host_cdrom' or 'host_device' as appropriate.
+
 @section QEMU Machine Protocol (QMP) commands
 
 @subsection block-dirty-bitmap-add "autoload" parameter (since 2.12.0)
-- 
2.13.6
