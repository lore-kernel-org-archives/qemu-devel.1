Received: from eggs.gnu.org ([209.51.188.92]:34633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hIWVj-0000qN-3C
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 06:49:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hIWHn-00067T-Ad
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 06:34:57 -0400
Received: from forwardcorp1j.mail.yandex.net ([2a02:6b8:0:1619::183]:35896)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hIWHm-00064Q-El
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 06:34:55 -0400
From: Yury Kotov <yury-kotov@yandex-team.ru>
Date: Mon, 22 Apr 2019 13:34:20 +0300
Message-Id: <20190422103420.15686-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] migration: Add error_desc for file channel
 errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>, yc-core@yandex-team.ru

Currently, there is no information about error if outgoing migration was =
failed
because of file channel errors.
Example (QMP session):
-> { "execute": "migrate", "arguments": { "uri": "exec:head -c 1" }}
<- { "return": {} }
...
-> { "execute": "query-migrate" }
<- { "return": { "status": "failed" }} // There is not error's descriptio=
n

And even in the QEMU's output there is nothing.

This patch
1) Adds errp for the most of QEMUFileOps
2) Adds qemu_file_get_error_obj/qemu_file_set_error_obj
3) And finally using of qemu_file_get_error_obj in migration.c

And now, the status for the mentioned fail will be:
-> { "execute": "query-migrate" }
<- { "return": { "status": "failed",
                 "error-desc": "Unable to write to command: Broken pipe" =
}}

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
---
 migration/migration.c         | 10 ++++--
 migration/qemu-file-channel.c | 30 +++++++++--------
 migration/qemu-file.c         | 63 ++++++++++++++++++++++++++++-------
 migration/qemu-file.h         | 15 ++++++---
 migration/savevm.c            |  6 ++--
 5 files changed, 88 insertions(+), 36 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 609e0df5d0..7bcdc4613b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2949,6 +2949,7 @@ static MigThrError migration_detect_error(Migration=
State *s)
 {
     int ret;
     int state =3D s->state;
+    Error *local_error =3D NULL;
=20
     if (state =3D=3D MIGRATION_STATUS_CANCELLING ||
         state =3D=3D MIGRATION_STATUS_CANCELLED) {
@@ -2957,13 +2958,18 @@ static MigThrError migration_detect_error(Migrati=
onState *s)
     }
=20
     /* Try to detect any file errors */
-    ret =3D qemu_file_get_error(s->to_dst_file);
-
+    ret =3D qemu_file_get_error_obj(s->to_dst_file, &local_error);
     if (!ret) {
         /* Everything is fine */
+        assert(!local_error);
         return MIG_THR_ERR_NONE;
     }
=20
+    if (local_error) {
+        migrate_set_error(s, local_error);
+        error_free(local_error);
+    }
+
     if (state =3D=3D MIGRATION_STATUS_POSTCOPY_ACTIVE && ret =3D=3D -EIO=
) {
         /*
          * For postcopy, we allow the network to be down for a
diff --git a/migration/qemu-file-channel.c b/migration/qemu-file-channel.=
c
index 8e639eb496..c382ea2d78 100644
--- a/migration/qemu-file-channel.c
+++ b/migration/qemu-file-channel.c
@@ -33,7 +33,8 @@
 static ssize_t channel_writev_buffer(void *opaque,
                                      struct iovec *iov,
                                      int iovcnt,
-                                     int64_t pos)
+                                     int64_t pos,
+                                     Error **errp)
 {
     QIOChannel *ioc =3D QIO_CHANNEL(opaque);
     ssize_t done =3D 0;
@@ -47,7 +48,7 @@ static ssize_t channel_writev_buffer(void *opaque,
=20
     while (nlocal_iov > 0) {
         ssize_t len;
-        len =3D qio_channel_writev(ioc, local_iov, nlocal_iov, NULL);
+        len =3D qio_channel_writev(ioc, local_iov, nlocal_iov, errp);
         if (len =3D=3D QIO_CHANNEL_ERR_BLOCK) {
             if (qemu_in_coroutine()) {
                 qio_channel_yield(ioc, G_IO_OUT);
@@ -57,7 +58,6 @@ static ssize_t channel_writev_buffer(void *opaque,
             continue;
         }
         if (len < 0) {
-            /* XXX handle Error objects */
             done =3D -EIO;
             goto cleanup;
         }
@@ -75,13 +75,14 @@ static ssize_t channel_writev_buffer(void *opaque,
 static ssize_t channel_get_buffer(void *opaque,
                                   uint8_t *buf,
                                   int64_t pos,
-                                  size_t size)
+                                  size_t size,
+                                  Error **errp)
 {
     QIOChannel *ioc =3D QIO_CHANNEL(opaque);
     ssize_t ret;
=20
     do {
-        ret =3D qio_channel_read(ioc, (char *)buf, size, NULL);
+        ret =3D qio_channel_read(ioc, (char *)buf, size, errp);
         if (ret < 0) {
             if (ret =3D=3D QIO_CHANNEL_ERR_BLOCK) {
                 if (qemu_in_coroutine()) {
@@ -90,7 +91,6 @@ static ssize_t channel_get_buffer(void *opaque,
                     qio_channel_wait(ioc, G_IO_IN);
                 }
             } else {
-                /* XXX handle Error * object */
                 return -EIO;
             }
         }
@@ -100,18 +100,20 @@ static ssize_t channel_get_buffer(void *opaque,
 }
=20
=20
-static int channel_close(void *opaque)
+static int channel_close(void *opaque, Error **errp)
 {
+    int ret;
     QIOChannel *ioc =3D QIO_CHANNEL(opaque);
-    qio_channel_close(ioc, NULL);
+    ret =3D qio_channel_close(ioc, errp);
     object_unref(OBJECT(ioc));
-    return 0;
+    return ret;
 }
=20
=20
 static int channel_shutdown(void *opaque,
                             bool rd,
-                            bool wr)
+                            bool wr,
+                            Error **errp)
 {
     QIOChannel *ioc =3D QIO_CHANNEL(opaque);
=20
@@ -125,8 +127,7 @@ static int channel_shutdown(void *opaque,
         } else {
             mode =3D QIO_CHANNEL_SHUTDOWN_WRITE;
         }
-        if (qio_channel_shutdown(ioc, mode, NULL) < 0) {
-            /* XXX handler Error * object */
+        if (qio_channel_shutdown(ioc, mode, errp) < 0) {
             return -EIO;
         }
     }
@@ -135,11 +136,12 @@ static int channel_shutdown(void *opaque,
=20
=20
 static int channel_set_blocking(void *opaque,
-                                bool enabled)
+                                bool enabled,
+                                Error **errp)
 {
     QIOChannel *ioc =3D QIO_CHANNEL(opaque);
=20
-    if (qio_channel_set_blocking(ioc, enabled, NULL) < 0) {
+    if (qio_channel_set_blocking(ioc, enabled, errp) < 0) {
         return -1;
     }
     return 0;
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 977b9ae07c..c52160e08b 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -29,6 +29,7 @@
 #include "migration.h"
 #include "qemu-file.h"
 #include "trace.h"
+#include "qapi/error.h"
=20
 #define IO_BUF_SIZE 32768
 #define MAX_IOV_SIZE MIN(IOV_MAX, 64)
@@ -52,6 +53,7 @@ struct QEMUFile {
     unsigned int iovcnt;
=20
     int last_error;
+    Error *last_error_obj;
 };
=20
 /*
@@ -63,7 +65,7 @@ int qemu_file_shutdown(QEMUFile *f)
     if (!f->ops->shut_down) {
         return -ENOSYS;
     }
-    return f->ops->shut_down(f->opaque, true, true);
+    return f->ops->shut_down(f->opaque, true, true, NULL);
 }
=20
 /*
@@ -108,24 +110,55 @@ void qemu_file_set_hooks(QEMUFile *f, const QEMUFil=
eHooks *hooks)
 }
=20
 /*
- * Get last error for stream f
+ * Get last error for stream f with optional Error*
  *
  * Return negative error value if there has been an error on previous
  * operations, return 0 if no error happened.
+ * Optional, it returns Error* in errp, but it may be NULL even if retur=
n value
+ * is not 0.
  *
  */
-int qemu_file_get_error(QEMUFile *f)
+int qemu_file_get_error_obj(QEMUFile *f, Error **errp)
 {
+    if (errp) {
+        *errp =3D f->last_error_obj ? error_copy(f->last_error_obj) : NU=
LL;
+    }
     return f->last_error;
 }
=20
-void qemu_file_set_error(QEMUFile *f, int ret)
+/*
+ * Set the last error for stream f with optional Error*
+ */
+void qemu_file_set_error_obj(QEMUFile *f, int ret, Error *err)
 {
-    if (f->last_error =3D=3D 0) {
+    if (f->last_error =3D=3D 0 && ret) {
         f->last_error =3D ret;
+        error_propagate(&f->last_error_obj, err);
+    } else if (err) {
+        error_report_err(err);
     }
 }
=20
+/*
+ * Get last error for stream f
+ *
+ * Return negative error value if there has been an error on previous
+ * operations, return 0 if no error happened.
+ *
+ */
+int qemu_file_get_error(QEMUFile *f)
+{
+    return qemu_file_get_error_obj(f, NULL);
+}
+
+/*
+ * Set the last error for stream f
+ */
+void qemu_file_set_error(QEMUFile *f, int ret)
+{
+    qemu_file_set_error_obj(f, ret, NULL);
+}
+
 bool qemu_file_is_writable(QEMUFile *f)
 {
     return f->ops->writev_buffer;
@@ -177,6 +210,7 @@ void qemu_fflush(QEMUFile *f)
 {
     ssize_t ret =3D 0;
     ssize_t expect =3D 0;
+    Error *local_error =3D NULL;
=20
     if (!qemu_file_is_writable(f)) {
         return;
@@ -184,7 +218,8 @@ void qemu_fflush(QEMUFile *f)
=20
     if (f->iovcnt > 0) {
         expect =3D iov_size(f->iov, f->iovcnt);
-        ret =3D f->ops->writev_buffer(f->opaque, f->iov, f->iovcnt, f->p=
os);
+        ret =3D f->ops->writev_buffer(f->opaque, f->iov, f->iovcnt, f->p=
os,
+                                    &local_error);
=20
         qemu_iovec_release_ram(f);
     }
@@ -196,7 +231,7 @@ void qemu_fflush(QEMUFile *f)
      * data set we requested, so sanity check that.
      */
     if (ret !=3D expect) {
-        qemu_file_set_error(f, ret < 0 ? ret : -EIO);
+        qemu_file_set_error_obj(f, ret < 0 ? ret : -EIO, local_error);
     }
     f->buf_index =3D 0;
     f->iovcnt =3D 0;
@@ -284,6 +319,7 @@ static ssize_t qemu_fill_buffer(QEMUFile *f)
 {
     int len;
     int pending;
+    Error *local_error =3D NULL;
=20
     assert(!qemu_file_is_writable(f));
=20
@@ -295,14 +331,16 @@ static ssize_t qemu_fill_buffer(QEMUFile *f)
     f->buf_size =3D pending;
=20
     len =3D f->ops->get_buffer(f->opaque, f->buf + pending, f->pos,
-                        IO_BUF_SIZE - pending);
+                             IO_BUF_SIZE - pending, &local_error);
     if (len > 0) {
         f->buf_size +=3D len;
         f->pos +=3D len;
     } else if (len =3D=3D 0) {
-        qemu_file_set_error(f, -EIO);
+        qemu_file_set_error_obj(f, -EIO, local_error);
     } else if (len !=3D -EAGAIN) {
-        qemu_file_set_error(f, len);
+        qemu_file_set_error_obj(f, len, local_error);
+    } else {
+        error_free(local_error);
     }
=20
     return len;
@@ -328,7 +366,7 @@ int qemu_fclose(QEMUFile *f)
     ret =3D qemu_file_get_error(f);
=20
     if (f->ops->close) {
-        int ret2 =3D f->ops->close(f->opaque);
+        int ret2 =3D f->ops->close(f->opaque, NULL);
         if (ret >=3D 0) {
             ret =3D ret2;
         }
@@ -339,6 +377,7 @@ int qemu_fclose(QEMUFile *f)
     if (f->last_error) {
         ret =3D f->last_error;
     }
+    error_free(f->last_error_obj);
     g_free(f);
     trace_qemu_file_fclose();
     return ret;
@@ -784,6 +823,6 @@ void qemu_put_counted_string(QEMUFile *f, const char =
*str)
 void qemu_file_set_blocking(QEMUFile *f, bool block)
 {
     if (f->ops->set_blocking) {
-        f->ops->set_blocking(f->opaque, block);
+        f->ops->set_blocking(f->opaque, block, NULL);
     }
 }
diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index 13baf896bd..eb886db65f 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -32,7 +32,8 @@
  * bytes actually read should be returned.
  */
 typedef ssize_t (QEMUFileGetBufferFunc)(void *opaque, uint8_t *buf,
-                                        int64_t pos, size_t size);
+                                        int64_t pos, size_t size,
+                                        Error **errp);
=20
 /* Close a file
  *
@@ -41,7 +42,7 @@ typedef ssize_t (QEMUFileGetBufferFunc)(void *opaque, u=
int8_t *buf,
  * The meaning of return value on success depends on the specific back-e=
nd being
  * used.
  */
-typedef int (QEMUFileCloseFunc)(void *opaque);
+typedef int (QEMUFileCloseFunc)(void *opaque, Error **errp);
=20
 /* Called to return the OS file descriptor associated to the QEMUFile.
  */
@@ -49,14 +50,15 @@ typedef int (QEMUFileGetFD)(void *opaque);
=20
 /* Called to change the blocking mode of the file
  */
-typedef int (QEMUFileSetBlocking)(void *opaque, bool enabled);
+typedef int (QEMUFileSetBlocking)(void *opaque, bool enabled, Error **er=
rp);
=20
 /*
  * This function writes an iovec to file. The handler must write all
  * of the data or return a negative errno value.
  */
 typedef ssize_t (QEMUFileWritevBufferFunc)(void *opaque, struct iovec *i=
ov,
-                                           int iovcnt, int64_t pos);
+                                           int iovcnt, int64_t pos,
+                                           Error **errp);
=20
 /*
  * This function provides hooks around different
@@ -97,7 +99,8 @@ typedef QEMUFile *(QEMURetPathFunc)(void *opaque);
  * Existing blocking reads/writes must be woken
  * Returns 0 on success, -err on error
  */
-typedef int (QEMUFileShutdownFunc)(void *opaque, bool rd, bool wr);
+typedef int (QEMUFileShutdownFunc)(void *opaque, bool rd, bool wr,
+                                   Error **errp);
=20
 typedef struct QEMUFileOps {
     QEMUFileGetBufferFunc *get_buffer;
@@ -149,6 +152,8 @@ void qemu_update_position(QEMUFile *f, size_t size);
 void qemu_file_reset_rate_limit(QEMUFile *f);
 void qemu_file_set_rate_limit(QEMUFile *f, int64_t new_rate);
 int64_t qemu_file_get_rate_limit(QEMUFile *f);
+int qemu_file_get_error_obj(QEMUFile *f, Error **errp);
+void qemu_file_set_error_obj(QEMUFile *f, int ret, Error *err);
 void qemu_file_set_error(QEMUFile *f, int ret);
 int qemu_file_shutdown(QEMUFile *f);
 QEMUFile *qemu_file_get_return_path(QEMUFile *f);
diff --git a/migration/savevm.c b/migration/savevm.c
index 34bcad3807..a619af744d 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -124,7 +124,7 @@ static struct mig_cmd_args {
 /* savevm/loadvm support */
=20
 static ssize_t block_writev_buffer(void *opaque, struct iovec *iov, int =
iovcnt,
-                                   int64_t pos)
+                                   int64_t pos, Error **errp)
 {
     int ret;
     QEMUIOVector qiov;
@@ -139,12 +139,12 @@ static ssize_t block_writev_buffer(void *opaque, st=
ruct iovec *iov, int iovcnt,
 }
=20
 static ssize_t block_get_buffer(void *opaque, uint8_t *buf, int64_t pos,
-                                size_t size)
+                                size_t size, Error **errp)
 {
     return bdrv_load_vmstate(opaque, buf, pos, size);
 }
=20
-static int bdrv_fclose(void *opaque)
+static int bdrv_fclose(void *opaque, Error **errp)
 {
     return bdrv_flush(opaque);
 }
--=20
2.21.0
