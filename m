Received: from eggs.gnu.org ([2001:4830:134:3::10]:37497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ebDao-0005Ew-SP
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 17:51:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ebDan-0004Se-IH
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 17:51:02 -0500
From: John Snow <jsnow@redhat.com>
Date: Mon, 15 Jan 2018 17:50:47 -0500
Message-Id: <20180115225047.28607-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2] file-posix: specify expected filetypes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>

I don't think there's a legitimate reason to open directories as if
they were files. This prevents QEMU from opening and attempting to probe
a directory inode, which can break in exciting ways. One of those ways
is lseek on ext4/xfs, which will return 0x7fffffffffffffff as the file
size instead of EISDIR. This can coax QEMU into responding with a
confusing "file too big" instead of "Hey, that's not a file".

See: https://bugs.launchpad.net/qemu/+bug/1739304/
Signed-off-by: John Snow <jsnow@redhat.com>
---

v2: Is something like this what you had in mind, Kevin?
    I couldn't make the hdev/cdrom checks more specific
    as I'm not sure which environments expect which, but
    if you know I can tighten it.

 block/file-posix.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 36ee89e940..fe06cdb8f8 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -417,7 +417,8 @@ static QemuOptsList raw_runtime_opts = {
 };
 
 static int raw_open_common(BlockDriverState *bs, QDict *options,
-                           int bdrv_flags, int open_flags, Error **errp)
+                           int bdrv_flags, int open_flags,
+                           bool device, Error **errp)
 {
     BDRVRawState *s = bs->opaque;
     QemuOpts *opts;
@@ -556,10 +557,30 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
         error_setg_errno(errp, errno, "Could not stat file");
         goto fail;
     }
-    if (S_ISREG(st.st_mode)) {
-        s->discard_zeroes = true;
-        s->has_fallocate = true;
+
+    if (!device) {
+        if (S_ISBLK(st.st_mode)) {
+            warn_report("Opening a block device as file using 'file'"
+                        "driver is deprecated");
+        } else if (S_ISCHR(st.st_mode)) {
+            warn_report("Opening a character device as file using the 'file'"
+                        "driver is deprecated");
+        } else if (!S_ISREG(st.st_mode)) {
+            error_setg(errp, "A regular file was expected by the 'file' driver,"
+                       "but something else was given");
+            goto fail;
+        } else {
+            s->discard_zeroes = true;
+            s->has_fallocate = true;
+        }
+    } else {
+        if (!(S_ISCHR(st.st_mode) || S_ISBLK(st.st_mode))) {
+            error_setg(errp, "host_device/host_cdrom driver expects either"
+                       "a character or block device");
+            goto fail;
+        }
     }
+
     if (S_ISBLK(st.st_mode)) {
 #ifdef BLKDISCARDZEROES
         unsigned int arg;
@@ -589,7 +610,6 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
         s->needs_alignment = true;
     }
 #endif
-
 #ifdef CONFIG_XFS
     if (platform_test_xfs_fd(s->fd)) {
         s->is_xfs = true;
@@ -611,7 +631,7 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
     BDRVRawState *s = bs->opaque;
 
     s->type = FTYPE_FILE;
-    return raw_open_common(bs, options, flags, 0, errp);
+    return raw_open_common(bs, options, flags, 0, false, errp);
 }
 
 typedef enum {
@@ -2575,7 +2595,7 @@ hdev_open_Mac_error:
 
     s->type = FTYPE_FILE;
 
-    ret = raw_open_common(bs, options, flags, 0, &local_err);
+    ret = raw_open_common(bs, options, flags, 0, true, &local_err);
     if (ret < 0) {
         error_propagate(errp, local_err);
 #if defined(__APPLE__) && defined(__MACH__)
@@ -2802,7 +2822,7 @@ static int cdrom_open(BlockDriverState *bs, QDict *options, int flags,
     s->type = FTYPE_CD;
 
     /* open will not fail even if no CD is inserted, so add O_NONBLOCK */
-    return raw_open_common(bs, options, flags, O_NONBLOCK, errp);
+    return raw_open_common(bs, options, flags, O_NONBLOCK, true, errp);
 }
 
 static int cdrom_probe_device(const char *filename)
@@ -2915,7 +2935,7 @@ static int cdrom_open(BlockDriverState *bs, QDict *options, int flags,
 
     s->type = FTYPE_CD;
 
-    ret = raw_open_common(bs, options, flags, 0, &local_err);
+    ret = raw_open_common(bs, options, flags, 0, true, &local_err);
     if (ret) {
         error_propagate(errp, local_err);
         return ret;
-- 
2.14.3
