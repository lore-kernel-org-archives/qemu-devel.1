Received: from eggs.gnu.org ([2001:4830:134:3::10]:41545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gI6U8-0006e1-Fe
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 02:29:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gI6U5-0007Po-CG
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 02:29:39 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu,  1 Nov 2018 14:29:09 +0800
Message-Id: <20181101062909.18833-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3] file-posix: Use error API properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, armbru@redhat.com

Use error_report for situations that affect user operation (i.e.  we're
actually returning error), and warn_report/warn_report_err when some
less critical error happened but the user operation can still carry on.

For raw_normalize_devicepath, add Error parameter to propagate to
its callers.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>

---

v3: Use error_setg_errno. [Eric]

v2: Add Error ** to raw_normalize_devicepath. [Markus]
    Use error_printf for splitting multi-sentence message. [Markus]
---
 block/file-posix.c | 39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 2da3a76355..e5606655b6 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -205,7 +205,7 @@ static int cdrom_reopen(BlockDriverState *bs);
 #endif
 
 #if defined(__NetBSD__)
-static int raw_normalize_devicepath(const char **filename)
+static int raw_normalize_devicepath(const char **filename, Error **errp)
 {
     static char namebuf[PATH_MAX];
     const char *dp, *fname;
@@ -214,8 +214,7 @@ static int raw_normalize_devicepath(const char **filename)
     fname = *filename;
     dp = strrchr(fname, '/');
     if (lstat(fname, &sb) < 0) {
-        fprintf(stderr, "%s: stat failed: %s\n",
-            fname, strerror(errno));
+        error_setg_errno(errp, errno, "%s: stat failed", fname);
         return -errno;
     }
 
@@ -229,14 +228,13 @@ static int raw_normalize_devicepath(const char **filename)
         snprintf(namebuf, PATH_MAX, "%.*s/r%s",
             (int)(dp - fname), fname, dp + 1);
     }
-    fprintf(stderr, "%s is a block device", fname);
     *filename = namebuf;
-    fprintf(stderr, ", using %s\n", *filename);
+    warn_report("%s is a block device, using %s", fname, *filename);
 
     return 0;
 }
 #else
-static int raw_normalize_devicepath(const char **filename)
+static int raw_normalize_devicepath(const char **filename, Error **errp)
 {
     return 0;
 }
@@ -461,9 +459,8 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
 
     filename = qemu_opt_get(opts, "filename");
 
-    ret = raw_normalize_devicepath(&filename);
+    ret = raw_normalize_devicepath(&filename, errp);
     if (ret != 0) {
-        error_setg_errno(errp, -ret, "Could not normalize device path");
         goto fail;
     }
 
@@ -492,11 +489,10 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
     case ON_OFF_AUTO_ON:
         s->use_lock = true;
         if (!qemu_has_ofd_lock()) {
-            fprintf(stderr,
-                    "File lock requested but OFD locking syscall is "
-                    "unavailable, falling back to POSIX file locks.\n"
-                    "Due to the implementation, locks can be lost "
-                    "unexpectedly.\n");
+            warn_report("File lock requested but OFD locking syscall is "
+                        "unavailable, falling back to POSIX file locks");
+            error_printf("Due to the implementation, locks can be lost "
+                         "unexpectedly.\n");
         }
         break;
     case ON_OFF_AUTO_OFF:
@@ -805,7 +801,7 @@ static int raw_handle_perm_lock(BlockDriverState *bs,
             /* Theoretically the above call only unlocks bytes and it cannot
              * fail. Something weird happened, report it.
              */
-            error_report_err(local_err);
+            warn_report_err(local_err);
         }
         break;
     case RAW_PL_COMMIT:
@@ -815,7 +811,7 @@ static int raw_handle_perm_lock(BlockDriverState *bs,
             /* Theoretically the above call only unlocks bytes and it cannot
              * fail. Something weird happened, report it.
              */
-            error_report_err(local_err);
+            warn_report_err(local_err);
         }
         break;
     }
@@ -892,10 +888,8 @@ static int raw_reopen_prepare(BDRVReopenState *state,
     /* If we cannot use fcntl, or fcntl failed, fall back to qemu_open() */
     if (rs->fd == -1) {
         const char *normalized_filename = state->bs->filename;
-        ret = raw_normalize_devicepath(&normalized_filename);
-        if (ret < 0) {
-            error_setg_errno(errp, -ret, "Could not normalize device path");
-        } else {
+        ret = raw_normalize_devicepath(&normalized_filename, errp);
+        if (ret >= 0) {
             assert(!(rs->open_flags & O_CREAT));
             rs->fd = qemu_open(normalized_filename, rs->open_flags);
             if (rs->fd == -1) {
@@ -1775,7 +1769,7 @@ static int aio_worker(void *arg)
         ret = handle_aiocb_truncate(aiocb);
         break;
     default:
-        fprintf(stderr, "invalid aio request (0x%x)\n", aiocb->aio_type);
+        error_report("invalid aio request (0x%x)", aiocb->aio_type);
         ret = -EINVAL;
         break;
     }
@@ -2263,7 +2257,7 @@ out_unlock:
          * not mean the whole creation operation has failed.  So
          * report it the user for their convenience, but do not report
          * it to the caller. */
-        error_report_err(local_err);
+        warn_report_err(local_err);
     }
 
 out_close:
@@ -3128,9 +3122,8 @@ static int coroutine_fn hdev_co_create_opts(const char *filename, QemuOpts *opts
 
     (void)has_prefix;
 
-    ret = raw_normalize_devicepath(&filename);
+    ret = raw_normalize_devicepath(&filename, errp);
     if (ret < 0) {
-        error_setg_errno(errp, -ret, "Could not normalize device path");
         return ret;
     }
 
-- 
2.17.2
