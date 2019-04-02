Received: from eggs.gnu.org ([209.51.188.92]:32848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hBIw8-0007ie-DC
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:54:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hBIw1-00044r-SX
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:54:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hBIvz-00041a-Tq
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:54:37 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 78E94C0B615A
	for <qemu-devel@nongnu.org>; Tue,  2 Apr 2019 12:54:33 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue,  2 Apr 2019 13:54:16 +0100
Message-Id: <20190402125417.21573-3-berrange@redhat.com>
In-Reply-To: <20190402125417.21573-1-berrange@redhat.com>
References: <20190402125417.21573-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/3] filemon: ensure watch IDs are unique to
 QFileMonitor scope
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Bandan Das <bsd@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The watch IDs are mistakenly only unique within the scope of the
directory being monitored. This is not useful for clients which are
monitoring multiple directories. They require watch IDs to be unique
globally within the QFileMonitor scope.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Tested-by: Bandan Das <bsd@redhat.com>
Reviewed-by: Bandan Das <bsd@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 tests/test-util-filemonitor.c | 116 +++++++++++++++++++++++++++++++---
 util/filemonitor-inotify.c    |   5 +-
 2 files changed, 110 insertions(+), 11 deletions(-)

diff --git a/tests/test-util-filemonitor.c b/tests/test-util-filemonitor.=
c
index ea3715a8f4..71a7cf5de0 100644
--- a/tests/test-util-filemonitor.c
+++ b/tests/test-util-filemonitor.c
@@ -35,6 +35,8 @@ enum {
     QFILE_MONITOR_TEST_OP_RENAME,
     QFILE_MONITOR_TEST_OP_TOUCH,
     QFILE_MONITOR_TEST_OP_UNLINK,
+    QFILE_MONITOR_TEST_OP_MKDIR,
+    QFILE_MONITOR_TEST_OP_RMDIR,
 };
=20
 typedef struct {
@@ -298,6 +300,54 @@ test_file_monitor_events(void)
           .eventid =3D QFILE_MONITOR_EVENT_DELETED },
=20
=20
+        { .type =3D QFILE_MONITOR_TEST_OP_MKDIR,
+          .filesrc =3D "fish", },
+        { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
+          .filesrc =3D "fish", .watchid =3D 0,
+          .eventid =3D QFILE_MONITOR_EVENT_CREATED },
+
+
+        { .type =3D QFILE_MONITOR_TEST_OP_ADD_WATCH,
+          .filesrc =3D "fish/", .watchid =3D 4 },
+        { .type =3D QFILE_MONITOR_TEST_OP_ADD_WATCH,
+          .filesrc =3D "fish/one.txt", .watchid =3D 5 },
+        { .type =3D QFILE_MONITOR_TEST_OP_CREATE,
+          .filesrc =3D "fish/one.txt", },
+        { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
+          .filesrc =3D "one.txt", .watchid =3D 4,
+          .eventid =3D QFILE_MONITOR_EVENT_CREATED },
+        { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
+          .filesrc =3D "one.txt", .watchid =3D 5,
+          .eventid =3D QFILE_MONITOR_EVENT_CREATED },
+
+
+        { .type =3D QFILE_MONITOR_TEST_OP_DEL_WATCH,
+          .filesrc =3D "fish/one.txt", .watchid =3D 5 },
+        { .type =3D QFILE_MONITOR_TEST_OP_RENAME,
+          .filesrc =3D "fish/one.txt", .filedst =3D "two.txt", },
+        { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
+          .filesrc =3D "one.txt", .watchid =3D 4,
+          .eventid =3D QFILE_MONITOR_EVENT_DELETED },
+        { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
+          .filesrc =3D "two.txt", .watchid =3D 0,
+          .eventid =3D QFILE_MONITOR_EVENT_CREATED },
+        { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
+          .filesrc =3D "two.txt", .watchid =3D 2,
+          .eventid =3D QFILE_MONITOR_EVENT_CREATED },
+
+
+        { .type =3D QFILE_MONITOR_TEST_OP_RMDIR,
+          .filesrc =3D "fish", },
+        { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
+          .filesrc =3D "", .watchid =3D 4,
+          .eventid =3D QFILE_MONITOR_EVENT_IGNORED },
+        { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
+          .filesrc =3D "fish", .watchid =3D 0,
+          .eventid =3D QFILE_MONITOR_EVENT_DELETED },
+        { .type =3D QFILE_MONITOR_TEST_OP_DEL_WATCH,
+          .filesrc =3D "fish", .watchid =3D 4 },
+
+
         { .type =3D QFILE_MONITOR_TEST_OP_UNLINK,
           .filesrc =3D "two.txt", },
         { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
@@ -366,6 +416,8 @@ test_file_monitor_events(void)
         int fd;
         int watchid;
         struct utimbuf ubuf;
+        char *watchdir;
+        const char *watchfile;
=20
         pathsrc =3D g_strdup_printf("%s/%s", dir, op->filesrc);
         if (op->filedst) {
@@ -378,13 +430,26 @@ test_file_monitor_events(void)
                 g_printerr("Add watch %s %s %d\n",
                            dir, op->filesrc, op->watchid);
             }
+            if (op->filesrc && strchr(op->filesrc, '/')) {
+                watchdir =3D g_strdup_printf("%s/%s", dir, op->filesrc);
+                watchfile =3D strrchr(watchdir, '/');
+                *(char *)watchfile =3D '\0';
+                watchfile++;
+                if (*watchfile =3D=3D '\0') {
+                    watchfile =3D NULL;
+                }
+            } else {
+                watchdir =3D g_strdup(dir);
+                watchfile =3D op->filesrc;
+            }
             watchid =3D
                 qemu_file_monitor_add_watch(mon,
-                                            dir,
-                                            op->filesrc,
+                                            watchdir,
+                                            watchfile,
                                             qemu_file_monitor_test_handl=
er,
                                             &data,
                                             &local_err);
+            g_free(watchdir);
             if (watchid < 0) {
                 g_printerr("Unable to add watch %s",
                            error_get_pretty(local_err));
@@ -400,9 +465,17 @@ test_file_monitor_events(void)
             if (debug) {
                 g_printerr("Del watch %s %d\n", dir, op->watchid);
             }
+            if (op->filesrc && strchr(op->filesrc, '/')) {
+                watchdir =3D g_strdup_printf("%s/%s", dir, op->filesrc);
+                watchfile =3D strrchr(watchdir, '/');
+                *(char *)watchfile =3D '\0';
+            } else {
+                watchdir =3D g_strdup(dir);
+            }
             qemu_file_monitor_remove_watch(mon,
-                                           dir,
+                                           watchdir,
                                            op->watchid);
+            g_free(watchdir);
             break;
         case QFILE_MONITOR_TEST_OP_EVENT:
             if (debug) {
@@ -492,6 +565,28 @@ test_file_monitor_events(void)
             }
             break;
=20
+        case QFILE_MONITOR_TEST_OP_MKDIR:
+            if (debug) {
+                g_printerr("Mkdir %s\n", pathsrc);
+            }
+            if (mkdir(pathsrc, 0700) < 0) {
+                g_printerr("Unable to mkdir %s: %s",
+                           pathsrc, strerror(errno));
+                goto cleanup;
+            }
+            break;
+
+        case QFILE_MONITOR_TEST_OP_RMDIR:
+            if (debug) {
+                g_printerr("Rmdir %s\n", pathsrc);
+            }
+            if (rmdir(pathsrc) < 0) {
+                g_printerr("Unable to rmdir %s: %s",
+                           pathsrc, strerror(errno));
+                goto cleanup;
+            }
+            break;
+
         default:
             g_assert_not_reached();
         }
@@ -532,13 +627,18 @@ test_file_monitor_events(void)
             const QFileMonitorTestOp *op =3D &(ops[i]);
             char *path =3D g_strdup_printf("%s/%s",
                                          dir, op->filesrc);
-            unlink(path);
-            g_free(path);
-            if (op->filedst) {
-                path =3D g_strdup_printf("%s/%s",
-                                       dir, op->filedst);
+            if (op->type =3D=3D QFILE_MONITOR_TEST_OP_MKDIR) {
+                rmdir(path);
+                g_free(path);
+            } else {
                 unlink(path);
                 g_free(path);
+                if (op->filedst) {
+                    path =3D g_strdup_printf("%s/%s",
+                                           dir, op->filedst);
+                    unlink(path);
+                    g_free(path);
+                }
             }
         }
         if (rmdir(dir) < 0) {
diff --git a/util/filemonitor-inotify.c b/util/filemonitor-inotify.c
index 3a72be037f..3eb29f860b 100644
--- a/util/filemonitor-inotify.c
+++ b/util/filemonitor-inotify.c
@@ -29,7 +29,7 @@
=20
 struct QFileMonitor {
     int fd;
-
+    int nextid; /* watch ID counter */
     QemuMutex lock; /* protects dirs & idmap */
     GHashTable *dirs; /* dirname =3D> QFileMonitorDir */
     GHashTable *idmap; /* inotify ID =3D> dirname */
@@ -47,7 +47,6 @@ typedef struct {
 typedef struct {
     char *path;
     int id; /* inotify ID */
-    int nextid; /* watch ID counter */
     GArray *watches; /* QFileMonitorWatch elements */
 } QFileMonitorDir;
=20
@@ -277,7 +276,7 @@ qemu_file_monitor_add_watch(QFileMonitor *mon,
         }
     }
=20
-    watch.id =3D dir->nextid++;
+    watch.id =3D mon->nextid++;
     watch.filename =3D g_strdup(filename);
     watch.cb =3D cb;
     watch.opaque =3D opaque;
--=20
2.20.1
