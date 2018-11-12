Received: from eggs.gnu.org ([2001:4830:134:3::10]:59677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gMFfD-0000FO-9m
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:06:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gMFfC-0006lY-C1
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:06:15 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 12 Nov 2018 18:05:50 +0100
Message-Id: <20181112170603.23986-2-kwolf@redhat.com>
In-Reply-To: <20181112170603.23986-1-kwolf@redhat.com>
References: <20181112170603.23986-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/14] file-posix: Use error API properly
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

From: Fam Zheng <famz@redhat.com>

Use error_report for situations that affect user operation (i.e.  we're
actually returning error), and warn_report/warn_report_err when some
less critical error happened but the user operation can still carry on.

For raw_normalize_devicepath, add Error parameter to propagate to
its callers.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 0c1b81ce4b..074f0ce2b3 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -205,7 +205,7 @@ static int cdrom_reopen(BlockDriverState *bs);
 #endif
=20
 #if defined(__NetBSD__)
-static int raw_normalize_devicepath(const char **filename)
+static int raw_normalize_devicepath(const char **filename, Error **errp)
 {
     static char namebuf[PATH_MAX];
     const char *dp, *fname;
@@ -214,8 +214,7 @@ static int raw_normalize_devicepath(const char **file=
name)
     fname =3D *filename;
     dp =3D strrchr(fname, '/');
     if (lstat(fname, &sb) < 0) {
-        fprintf(stderr, "%s: stat failed: %s\n",
-            fname, strerror(errno));
+        error_setg_errno(errp, errno, "%s: stat failed", fname);
         return -errno;
     }
=20
@@ -229,14 +228,13 @@ static int raw_normalize_devicepath(const char **fi=
lename)
         snprintf(namebuf, PATH_MAX, "%.*s/r%s",
             (int)(dp - fname), fname, dp + 1);
     }
-    fprintf(stderr, "%s is a block device", fname);
     *filename =3D namebuf;
-    fprintf(stderr, ", using %s\n", *filename);
+    warn_report("%s is a block device, using %s", fname, *filename);
=20
     return 0;
 }
 #else
-static int raw_normalize_devicepath(const char **filename)
+static int raw_normalize_devicepath(const char **filename, Error **errp)
 {
     return 0;
 }
@@ -461,9 +459,8 @@ static int raw_open_common(BlockDriverState *bs, QDic=
t *options,
=20
     filename =3D qemu_opt_get(opts, "filename");
=20
-    ret =3D raw_normalize_devicepath(&filename);
+    ret =3D raw_normalize_devicepath(&filename, errp);
     if (ret !=3D 0) {
-        error_setg_errno(errp, -ret, "Could not normalize device path");
         goto fail;
     }
=20
@@ -492,11 +489,10 @@ static int raw_open_common(BlockDriverState *bs, QD=
ict *options,
     case ON_OFF_AUTO_ON:
         s->use_lock =3D true;
         if (!qemu_has_ofd_lock()) {
-            fprintf(stderr,
-                    "File lock requested but OFD locking syscall is "
-                    "unavailable, falling back to POSIX file locks.\n"
-                    "Due to the implementation, locks can be lost "
-                    "unexpectedly.\n");
+            warn_report("File lock requested but OFD locking syscall is =
"
+                        "unavailable, falling back to POSIX file locks")=
;
+            error_printf("Due to the implementation, locks can be lost "
+                         "unexpectedly.\n");
         }
         break;
     case ON_OFF_AUTO_OFF:
@@ -818,7 +814,7 @@ static int raw_handle_perm_lock(BlockDriverState *bs,
             /* Theoretically the above call only unlocks bytes and it ca=
nnot
              * fail. Something weird happened, report it.
              */
-            error_report_err(local_err);
+            warn_report_err(local_err);
         }
         break;
     case RAW_PL_COMMIT:
@@ -828,7 +824,7 @@ static int raw_handle_perm_lock(BlockDriverState *bs,
             /* Theoretically the above call only unlocks bytes and it ca=
nnot
              * fail. Something weird happened, report it.
              */
-            error_report_err(local_err);
+            warn_report_err(local_err);
         }
         break;
     }
@@ -905,10 +901,8 @@ static int raw_reopen_prepare(BDRVReopenState *state=
,
     /* If we cannot use fcntl, or fcntl failed, fall back to qemu_open()=
 */
     if (rs->fd =3D=3D -1) {
         const char *normalized_filename =3D state->bs->filename;
-        ret =3D raw_normalize_devicepath(&normalized_filename);
-        if (ret < 0) {
-            error_setg_errno(errp, -ret, "Could not normalize device pat=
h");
-        } else {
+        ret =3D raw_normalize_devicepath(&normalized_filename, errp);
+        if (ret >=3D 0) {
             assert(!(rs->open_flags & O_CREAT));
             rs->fd =3D qemu_open(normalized_filename, rs->open_flags);
             if (rs->fd =3D=3D -1) {
@@ -1788,7 +1782,7 @@ static int aio_worker(void *arg)
         ret =3D handle_aiocb_truncate(aiocb);
         break;
     default:
-        fprintf(stderr, "invalid aio request (0x%x)\n", aiocb->aio_type)=
;
+        error_report("invalid aio request (0x%x)", aiocb->aio_type);
         ret =3D -EINVAL;
         break;
     }
@@ -2276,7 +2270,7 @@ out_unlock:
          * not mean the whole creation operation has failed.  So
          * report it the user for their convenience, but do not report
          * it to the caller. */
-        error_report_err(local_err);
+        warn_report_err(local_err);
     }
=20
 out_close:
@@ -3141,9 +3135,8 @@ static int coroutine_fn hdev_co_create_opts(const c=
har *filename, QemuOpts *opts
=20
     (void)has_prefix;
=20
-    ret =3D raw_normalize_devicepath(&filename);
+    ret =3D raw_normalize_devicepath(&filename, errp);
     if (ret < 0) {
-        error_setg_errno(errp, -ret, "Could not normalize device path");
         return ret;
     }
=20
--=20
2.19.1
