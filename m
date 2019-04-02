Received: from eggs.gnu.org ([209.51.188.92]:32817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hBIw1-0007d5-Qy
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:54:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hBIvx-00041S-Iz
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:54:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hBIvv-0003x4-Jl
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:54:32 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DE0C1811DC
	for <qemu-devel@nongnu.org>; Tue,  2 Apr 2019 12:54:30 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue,  2 Apr 2019 13:54:15 +0100
Message-Id: <20190402125417.21573-2-berrange@redhat.com>
In-Reply-To: <20190402125417.21573-1-berrange@redhat.com>
References: <20190402125417.21573-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/3] tests: refactor file monitor test to make
 it more understandable
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

The current file monitor unit tests are too clever for their own good
making it hard to understand the desired output.

Instead of trying to infer the expected events, explicitly list the
events we expect in the operation sequence.

Instead of dynamically building a matrix of tests, just have one giant
operation sequence that validates all scenarios in a single test.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 tests/test-util-filemonitor.c | 534 +++++++++++++---------------------
 1 file changed, 208 insertions(+), 326 deletions(-)

diff --git a/tests/test-util-filemonitor.c b/tests/test-util-filemonitor.=
c
index 5d95cea5ee..ea3715a8f4 100644
--- a/tests/test-util-filemonitor.c
+++ b/tests/test-util-filemonitor.c
@@ -26,6 +26,9 @@
 #include <utime.h>
=20
 enum {
+    QFILE_MONITOR_TEST_OP_ADD_WATCH,
+    QFILE_MONITOR_TEST_OP_DEL_WATCH,
+    QFILE_MONITOR_TEST_OP_EVENT,
     QFILE_MONITOR_TEST_OP_CREATE,
     QFILE_MONITOR_TEST_OP_APPEND,
     QFILE_MONITOR_TEST_OP_TRUNC,
@@ -38,20 +41,10 @@ typedef struct {
     int type;
     const char *filesrc;
     const char *filedst;
+    int watchid;
+    int eventid;
 } QFileMonitorTestOp;
=20
-typedef struct {
-    const char *file;
-} QFileMonitorTestWatch;
-
-typedef struct {
-    gsize nwatches;
-    const QFileMonitorTestWatch *watches;
-
-    gsize nops;
-    const QFileMonitorTestOp *ops;
-} QFileMonitorTestPlan;
-
 typedef struct {
     int id;
     QFileMonitorEvent event;
@@ -67,6 +60,7 @@ typedef struct {
 static QemuMutex evlock;
 static bool evstopping;
 static bool evrunning;
+static bool debug;
=20
 /*
  * Main function for a background thread that is
@@ -200,9 +194,125 @@ qemu_file_monitor_test_expect(QFileMonitorTestData =
*data,
=20
=20
 static void
-test_file_monitor_events(const void *opaque)
+test_file_monitor_events(void)
 {
-    const QFileMonitorTestPlan *plan =3D opaque;
+    QFileMonitorTestOp ops[] =3D {
+        { .type =3D QFILE_MONITOR_TEST_OP_ADD_WATCH,
+          .filesrc =3D NULL, .watchid =3D 0 },
+        { .type =3D QFILE_MONITOR_TEST_OP_ADD_WATCH,
+          .filesrc =3D "one.txt", .watchid =3D 1 },
+        { .type =3D QFILE_MONITOR_TEST_OP_ADD_WATCH,
+          .filesrc =3D "two.txt", .watchid =3D 2 },
+
+
+        { .type =3D QFILE_MONITOR_TEST_OP_CREATE,
+          .filesrc =3D "one.txt", },
+        { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
+          .filesrc =3D "one.txt", .watchid =3D 0,
+          .eventid =3D QFILE_MONITOR_EVENT_CREATED },
+        { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
+          .filesrc =3D "one.txt", .watchid =3D 1,
+          .eventid =3D QFILE_MONITOR_EVENT_CREATED },
+
+
+        { .type =3D QFILE_MONITOR_TEST_OP_CREATE,
+          .filesrc =3D "two.txt", },
+        { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
+          .filesrc =3D "two.txt", .watchid =3D 0,
+          .eventid =3D QFILE_MONITOR_EVENT_CREATED },
+        { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
+          .filesrc =3D "two.txt", .watchid =3D 2,
+          .eventid =3D QFILE_MONITOR_EVENT_CREATED },
+
+
+        { .type =3D QFILE_MONITOR_TEST_OP_CREATE,
+          .filesrc =3D "three.txt", },
+        { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
+          .filesrc =3D "three.txt", .watchid =3D 0,
+          .eventid =3D QFILE_MONITOR_EVENT_CREATED },
+
+
+        { .type =3D QFILE_MONITOR_TEST_OP_UNLINK,
+          .filesrc =3D "three.txt", },
+        { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
+          .filesrc =3D "three.txt", .watchid =3D 0,
+          .eventid =3D QFILE_MONITOR_EVENT_DELETED },
+
+
+        { .type =3D QFILE_MONITOR_TEST_OP_RENAME,
+          .filesrc =3D "one.txt", .filedst =3D "two.txt" },
+        { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
+          .filesrc =3D "one.txt", .watchid =3D 0,
+          .eventid =3D QFILE_MONITOR_EVENT_DELETED },
+        { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
+          .filesrc =3D "one.txt", .watchid =3D 1,
+          .eventid =3D QFILE_MONITOR_EVENT_DELETED },
+        { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
+          .filesrc =3D "two.txt", .watchid =3D 0,
+          .eventid =3D QFILE_MONITOR_EVENT_CREATED },
+        { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
+          .filesrc =3D "two.txt", .watchid =3D 2,
+          .eventid =3D QFILE_MONITOR_EVENT_CREATED },
+
+
+        { .type =3D QFILE_MONITOR_TEST_OP_APPEND,
+          .filesrc =3D "two.txt", },
+        { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
+          .filesrc =3D "two.txt", .watchid =3D 0,
+          .eventid =3D QFILE_MONITOR_EVENT_MODIFIED },
+        { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
+          .filesrc =3D "two.txt", .watchid =3D 2,
+          .eventid =3D QFILE_MONITOR_EVENT_MODIFIED },
+
+
+        { .type =3D QFILE_MONITOR_TEST_OP_TOUCH,
+          .filesrc =3D "two.txt", },
+        { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
+          .filesrc =3D "two.txt", .watchid =3D 0,
+          .eventid =3D QFILE_MONITOR_EVENT_ATTRIBUTES },
+        { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
+          .filesrc =3D "two.txt", .watchid =3D 2,
+          .eventid =3D QFILE_MONITOR_EVENT_ATTRIBUTES },
+
+
+        { .type =3D QFILE_MONITOR_TEST_OP_DEL_WATCH,
+          .filesrc =3D "one.txt", .watchid =3D 1 },
+        { .type =3D QFILE_MONITOR_TEST_OP_ADD_WATCH,
+          .filesrc =3D "one.txt", .watchid =3D 3 },
+        { .type =3D QFILE_MONITOR_TEST_OP_CREATE,
+          .filesrc =3D "one.txt", },
+        { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
+          .filesrc =3D "one.txt", .watchid =3D 0,
+          .eventid =3D QFILE_MONITOR_EVENT_CREATED },
+        { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
+          .filesrc =3D "one.txt", .watchid =3D 3,
+          .eventid =3D QFILE_MONITOR_EVENT_CREATED },
+
+
+        { .type =3D QFILE_MONITOR_TEST_OP_DEL_WATCH,
+          .filesrc =3D "one.txt", .watchid =3D 3 },
+        { .type =3D QFILE_MONITOR_TEST_OP_UNLINK,
+          .filesrc =3D "one.txt", },
+        { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
+          .filesrc =3D "one.txt", .watchid =3D 0,
+          .eventid =3D QFILE_MONITOR_EVENT_DELETED },
+
+
+        { .type =3D QFILE_MONITOR_TEST_OP_UNLINK,
+          .filesrc =3D "two.txt", },
+        { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
+          .filesrc =3D "two.txt", .watchid =3D 0,
+          .eventid =3D QFILE_MONITOR_EVENT_DELETED },
+        { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
+          .filesrc =3D "two.txt", .watchid =3D 2,
+          .eventid =3D QFILE_MONITOR_EVENT_DELETED },
+
+
+        { .type =3D QFILE_MONITOR_TEST_OP_DEL_WATCH,
+          .filesrc =3D "two.txt", .watchid =3D 2 },
+        { .type =3D QFILE_MONITOR_TEST_OP_DEL_WATCH,
+          .filesrc =3D NULL, .watchid =3D 0 },
+    };
     Error *local_err =3D NULL;
     GError *gerr =3D NULL;
     QFileMonitor *mon =3D qemu_file_monitor_new(&local_err);
@@ -210,7 +320,7 @@ test_file_monitor_events(const void *opaque)
     GTimer *timer;
     gchar *dir =3D NULL;
     int err =3D -1;
-    gsize i, j;
+    gsize i;
     char *pathsrc =3D NULL;
     char *pathdst =3D NULL;
     QFileMonitorTestData data;
@@ -248,33 +358,13 @@ test_file_monitor_events(const void *opaque)
     }
=20
     /*
-     * First register all the directory / file watches
-     * we're interested in seeing events against
+     * Run through the operation sequence validating events
+     * as we go
      */
-    for (i =3D 0; i < plan->nwatches; i++) {
-        int watchid;
-        watchid =3D qemu_file_monitor_add_watch(mon,
-                                              dir,
-                                              plan->watches[i].file,
-                                              qemu_file_monitor_test_han=
dler,
-                                              &data,
-                                              &local_err);
-        if (watchid < 0) {
-            g_printerr("Unable to add watch %s",
-                       error_get_pretty(local_err));
-            goto cleanup;
-        }
-    }
-
-
-    /*
-     * Now invoke all the file operations (create,
-     * delete, rename, chmod, etc). These operations
-     * will trigger the various file monitor events
-     */
-    for (i =3D 0; i < plan->nops; i++) {
-        const QFileMonitorTestOp *op =3D &(plan->ops[i]);
+    for (i =3D 0; i < G_N_ELEMENTS(ops); i++) {
+        const QFileMonitorTestOp *op =3D &(ops[i]);
         int fd;
+        int watchid;
         struct utimbuf ubuf;
=20
         pathsrc =3D g_strdup_printf("%s/%s", dir, op->filesrc);
@@ -283,7 +373,50 @@ test_file_monitor_events(const void *opaque)
         }
=20
         switch (op->type) {
+        case QFILE_MONITOR_TEST_OP_ADD_WATCH:
+            if (debug) {
+                g_printerr("Add watch %s %s %d\n",
+                           dir, op->filesrc, op->watchid);
+            }
+            watchid =3D
+                qemu_file_monitor_add_watch(mon,
+                                            dir,
+                                            op->filesrc,
+                                            qemu_file_monitor_test_handl=
er,
+                                            &data,
+                                            &local_err);
+            if (watchid < 0) {
+                g_printerr("Unable to add watch %s",
+                           error_get_pretty(local_err));
+                goto cleanup;
+            }
+            if (watchid !=3D op->watchid) {
+                g_printerr("Unexpected watch ID %d, wanted %d\n",
+                           watchid, op->watchid);
+                goto cleanup;
+            }
+            break;
+        case QFILE_MONITOR_TEST_OP_DEL_WATCH:
+            if (debug) {
+                g_printerr("Del watch %s %d\n", dir, op->watchid);
+            }
+            qemu_file_monitor_remove_watch(mon,
+                                           dir,
+                                           op->watchid);
+            break;
+        case QFILE_MONITOR_TEST_OP_EVENT:
+            if (debug) {
+                g_printerr("Event id=3D%d event=3D%d file=3D%s\n",
+                           op->watchid, op->eventid, op->filesrc);
+            }
+            if (!qemu_file_monitor_test_expect(
+                    &data, op->watchid, op->eventid, op->filesrc))
+                goto cleanup;
+            break;
         case QFILE_MONITOR_TEST_OP_CREATE:
+            if (debug) {
+                g_printerr("Create %s\n", pathsrc);
+            }
             fd =3D open(pathsrc, O_WRONLY | O_CREAT, 0700);
             if (fd < 0) {
                 g_printerr("Unable to create %s: %s",
@@ -294,6 +427,9 @@ test_file_monitor_events(const void *opaque)
             break;
=20
         case QFILE_MONITOR_TEST_OP_APPEND:
+            if (debug) {
+                g_printerr("Append %s\n", pathsrc);
+            }
             fd =3D open(pathsrc, O_WRONLY | O_APPEND, 0700);
             if (fd < 0) {
                 g_printerr("Unable to open %s: %s",
@@ -311,6 +447,9 @@ test_file_monitor_events(const void *opaque)
             break;
=20
         case QFILE_MONITOR_TEST_OP_TRUNC:
+            if (debug) {
+                g_printerr("Truncate %s\n", pathsrc);
+            }
             if (truncate(pathsrc, 4) < 0) {
                 g_printerr("Unable to truncate %s: %s",
                            pathsrc, strerror(errno));
@@ -319,6 +458,9 @@ test_file_monitor_events(const void *opaque)
             break;
=20
         case QFILE_MONITOR_TEST_OP_RENAME:
+            if (debug) {
+                g_printerr("Rename %s -> %s\n", pathsrc, pathdst);
+            }
             if (rename(pathsrc, pathdst) < 0) {
                 g_printerr("Unable to rename %s to %s: %s",
                            pathsrc, pathdst, strerror(errno));
@@ -327,6 +469,9 @@ test_file_monitor_events(const void *opaque)
             break;
=20
         case QFILE_MONITOR_TEST_OP_UNLINK:
+            if (debug) {
+                g_printerr("Unlink %s\n", pathsrc);
+            }
             if (unlink(pathsrc) < 0) {
                 g_printerr("Unable to unlink %s: %s",
                            pathsrc, strerror(errno));
@@ -335,6 +480,9 @@ test_file_monitor_events(const void *opaque)
             break;
=20
         case QFILE_MONITOR_TEST_OP_TOUCH:
+            if (debug) {
+                g_printerr("Touch %s\n", pathsrc);
+            }
             ubuf.actime =3D 1024;
             ubuf.modtime =3D 1025;
             if (utime(pathsrc, &ubuf) < 0) {
@@ -353,92 +501,6 @@ test_file_monitor_events(const void *opaque)
         pathsrc =3D pathdst =3D NULL;
     }
=20
-
-    /*
-     * Finally validate that we have received all the events
-     * we expect to see for the combination of watches and
-     * file operations
-     */
-    for (i =3D 0; i < plan->nops; i++) {
-        const QFileMonitorTestOp *op =3D &(plan->ops[i]);
-
-        switch (op->type) {
-        case QFILE_MONITOR_TEST_OP_CREATE:
-            for (j =3D 0; j < plan->nwatches; j++) {
-                if (plan->watches[j].file &&
-                    !g_str_equal(plan->watches[j].file, op->filesrc))
-                    continue;
-
-                if (!qemu_file_monitor_test_expect(
-                        &data, j, QFILE_MONITOR_EVENT_CREATED, op->files=
rc))
-                    goto cleanup;
-            }
-            break;
-
-        case QFILE_MONITOR_TEST_OP_APPEND:
-        case QFILE_MONITOR_TEST_OP_TRUNC:
-            for (j =3D 0; j < plan->nwatches; j++) {
-                if (plan->watches[j].file &&
-                    !g_str_equal(plan->watches[j].file, op->filesrc))
-                    continue;
-
-                if (!qemu_file_monitor_test_expect(
-                        &data, j, QFILE_MONITOR_EVENT_MODIFIED, op->file=
src))
-                    goto cleanup;
-            }
-            break;
-
-        case QFILE_MONITOR_TEST_OP_RENAME:
-            for (j =3D 0; j < plan->nwatches; j++) {
-                if (plan->watches[j].file &&
-                    !g_str_equal(plan->watches[j].file, op->filesrc))
-                    continue;
-
-                if (!qemu_file_monitor_test_expect(
-                        &data, j, QFILE_MONITOR_EVENT_DELETED, op->files=
rc))
-                    goto cleanup;
-            }
-
-            for (j =3D 0; j < plan->nwatches; j++) {
-                if (plan->watches[j].file &&
-                    !g_str_equal(plan->watches[j].file, op->filedst))
-                    continue;
-
-                if (!qemu_file_monitor_test_expect(
-                        &data, j, QFILE_MONITOR_EVENT_CREATED, op->filed=
st))
-                    goto cleanup;
-            }
-            break;
-
-        case QFILE_MONITOR_TEST_OP_TOUCH:
-            for (j =3D 0; j < plan->nwatches; j++) {
-                if (plan->watches[j].file &&
-                    !g_str_equal(plan->watches[j].file, op->filesrc))
-                    continue;
-
-                if (!qemu_file_monitor_test_expect(
-                        &data, j, QFILE_MONITOR_EVENT_ATTRIBUTES, op->fi=
lesrc))
-                    goto cleanup;
-            }
-            break;
-
-        case QFILE_MONITOR_TEST_OP_UNLINK:
-            for (j =3D 0; j < plan->nwatches; j++) {
-                if (plan->watches[j].file &&
-                    !g_str_equal(plan->watches[j].file, op->filesrc))
-                    continue;
-
-                if (!qemu_file_monitor_test_expect(
-                        &data, j, QFILE_MONITOR_EVENT_DELETED, op->files=
rc))
-                    goto cleanup;
-            }
-            break;
-
-        default:
-            g_assert_not_reached();
-        }
-    }
-
     err =3D 0;
=20
  cleanup:
@@ -460,171 +522,36 @@ test_file_monitor_events(const void *opaque)
     }
     g_timer_destroy(timer);
=20
-    for (i =3D 0; i < plan->nops; i++) {
-        const QFileMonitorTestOp *op =3D &(plan->ops[i]);
-        pathsrc =3D g_strdup_printf("%s/%s", dir, op->filesrc);
-        unlink(pathsrc);
-        g_free(pathsrc);
-        if (op->filedst) {
-            pathdst =3D g_strdup_printf("%s/%s", dir, op->filedst);
-            unlink(pathdst);
-            g_free(pathdst);
-        }
-    }
-
     qemu_file_monitor_free(mon);
     g_list_foreach(data.records,
                    (GFunc)qemu_file_monitor_test_record_free, NULL);
     g_list_free(data.records);
     qemu_mutex_destroy(&data.lock);
     if (dir) {
-        rmdir(dir);
+        for (i =3D 0; i < G_N_ELEMENTS(ops); i++) {
+            const QFileMonitorTestOp *op =3D &(ops[i]);
+            char *path =3D g_strdup_printf("%s/%s",
+                                         dir, op->filesrc);
+            unlink(path);
+            g_free(path);
+            if (op->filedst) {
+                path =3D g_strdup_printf("%s/%s",
+                                       dir, op->filedst);
+                unlink(path);
+                g_free(path);
+            }
+        }
+        if (rmdir(dir) < 0) {
+            g_printerr("Failed to remove %s: %s\n",
+                       dir, strerror(errno));
+            abort();
+        }
     }
     g_free(dir);
     g_assert(err =3D=3D 0);
 }
=20
=20
-/*
- * Set of structs which define which file name patterns
- * we're trying to watch against. NULL, means all files
- * in the directory
- */
-static const QFileMonitorTestWatch watches_any[] =3D {
-    { NULL },
-};
-
-static const QFileMonitorTestWatch watches_one[] =3D {
-    { "one.txt" },
-};
-
-static const QFileMonitorTestWatch watches_two[] =3D {
-    { "two.txt" },
-};
-
-static const QFileMonitorTestWatch watches_many[] =3D {
-    { NULL },
-    { "one.txt" },
-    { "two.txt" },
-};
-
-
-/*
- * Various sets of file operations we're going to
- * trigger and validate events for
- */
-static const QFileMonitorTestOp ops_create_one[] =3D {
-    { .type =3D QFILE_MONITOR_TEST_OP_CREATE,
-      .filesrc =3D "one.txt", }
-};
-
-static const QFileMonitorTestOp ops_delete_one[] =3D {
-    { .type =3D QFILE_MONITOR_TEST_OP_CREATE,
-      .filesrc =3D "one.txt", },
-    { .type =3D QFILE_MONITOR_TEST_OP_UNLINK,
-      .filesrc =3D "one.txt", }
-};
-
-static const QFileMonitorTestOp ops_create_many[] =3D {
-    { .type =3D QFILE_MONITOR_TEST_OP_CREATE,
-      .filesrc =3D "one.txt", },
-    { .type =3D QFILE_MONITOR_TEST_OP_CREATE,
-      .filesrc =3D "two.txt", },
-    { .type =3D QFILE_MONITOR_TEST_OP_CREATE,
-      .filesrc =3D "three.txt", }
-};
-
-static const QFileMonitorTestOp ops_rename_one[] =3D {
-    { .type =3D QFILE_MONITOR_TEST_OP_CREATE,
-      .filesrc =3D "one.txt", },
-    { .type =3D QFILE_MONITOR_TEST_OP_RENAME,
-      .filesrc =3D "one.txt", .filedst =3D "two.txt" }
-};
-
-static const QFileMonitorTestOp ops_rename_many[] =3D {
-    { .type =3D QFILE_MONITOR_TEST_OP_CREATE,
-      .filesrc =3D "one.txt", },
-    { .type =3D QFILE_MONITOR_TEST_OP_CREATE,
-      .filesrc =3D "two.txt", },
-    { .type =3D QFILE_MONITOR_TEST_OP_RENAME,
-      .filesrc =3D "one.txt", .filedst =3D "two.txt" }
-};
-
-static const QFileMonitorTestOp ops_append_one[] =3D {
-    { .type =3D QFILE_MONITOR_TEST_OP_CREATE,
-      .filesrc =3D "one.txt", },
-    { .type =3D QFILE_MONITOR_TEST_OP_APPEND,
-      .filesrc =3D "one.txt", },
-};
-
-static const QFileMonitorTestOp ops_trunc_one[] =3D {
-    { .type =3D QFILE_MONITOR_TEST_OP_CREATE,
-      .filesrc =3D "one.txt", },
-    { .type =3D QFILE_MONITOR_TEST_OP_TRUNC,
-      .filesrc =3D "one.txt", },
-};
-
-static const QFileMonitorTestOp ops_touch_one[] =3D {
-    { .type =3D QFILE_MONITOR_TEST_OP_CREATE,
-      .filesrc =3D "one.txt", },
-    { .type =3D QFILE_MONITOR_TEST_OP_TOUCH,
-      .filesrc =3D "one.txt", },
-};
-
-
-/*
- * No we define data sets for the combinatorial
- * expansion of file watches and operation sets
- */
-#define PLAN_DATA(o, w) \
-    static const QFileMonitorTestPlan plan_ ## o ## _ ## w =3D { \
-        .nops =3D G_N_ELEMENTS(ops_ ##o), \
-        .ops =3D ops_ ##o, \
-        .nwatches =3D G_N_ELEMENTS(watches_ ##w), \
-        .watches =3D watches_ ## w, \
-    }
-
-PLAN_DATA(create_one, any);
-PLAN_DATA(create_one, one);
-PLAN_DATA(create_one, two);
-PLAN_DATA(create_one, many);
-
-PLAN_DATA(delete_one, any);
-PLAN_DATA(delete_one, one);
-PLAN_DATA(delete_one, two);
-PLAN_DATA(delete_one, many);
-
-PLAN_DATA(create_many, any);
-PLAN_DATA(create_many, one);
-PLAN_DATA(create_many, two);
-PLAN_DATA(create_many, many);
-
-PLAN_DATA(rename_one, any);
-PLAN_DATA(rename_one, one);
-PLAN_DATA(rename_one, two);
-PLAN_DATA(rename_one, many);
-
-PLAN_DATA(rename_many, any);
-PLAN_DATA(rename_many, one);
-PLAN_DATA(rename_many, two);
-PLAN_DATA(rename_many, many);
-
-PLAN_DATA(append_one, any);
-PLAN_DATA(append_one, one);
-PLAN_DATA(append_one, two);
-PLAN_DATA(append_one, many);
-
-PLAN_DATA(trunc_one, any);
-PLAN_DATA(trunc_one, one);
-PLAN_DATA(trunc_one, two);
-PLAN_DATA(trunc_one, many);
-
-PLAN_DATA(touch_one, any);
-PLAN_DATA(touch_one, one);
-PLAN_DATA(touch_one, two);
-PLAN_DATA(touch_one, many);
-
-
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -633,53 +560,8 @@ int main(int argc, char **argv)
=20
     qemu_mutex_init(&evlock);
=20
-    /*
-     * Register test cases for the combinatorial
-     * expansion of file watches and operation sets
-     */
-    #define PLAN_REGISTER(o, w)                                         =
\
-        g_test_add_data_func("/util/filemonitor/" # o "/" # w,          =
\
-                             &plan_ ## o ## _ ## w, test_file_monitor_ev=
ents)
-
-    PLAN_REGISTER(create_one, any);
-    PLAN_REGISTER(create_one, one);
-    PLAN_REGISTER(create_one, two);
-    PLAN_REGISTER(create_one, many);
-
-    PLAN_REGISTER(delete_one, any);
-    PLAN_REGISTER(delete_one, one);
-    PLAN_REGISTER(delete_one, two);
-    PLAN_REGISTER(delete_one, many);
-
-    PLAN_REGISTER(create_many, any);
-    PLAN_REGISTER(create_many, one);
-    PLAN_REGISTER(create_many, two);
-    PLAN_REGISTER(create_many, many);
-
-    PLAN_REGISTER(rename_one, any);
-    PLAN_REGISTER(rename_one, one);
-    PLAN_REGISTER(rename_one, two);
-    PLAN_REGISTER(rename_one, many);
-
-    PLAN_REGISTER(rename_many, any);
-    PLAN_REGISTER(rename_many, one);
-    PLAN_REGISTER(rename_many, two);
-    PLAN_REGISTER(rename_many, many);
-
-    PLAN_REGISTER(append_one, any);
-    PLAN_REGISTER(append_one, one);
-    PLAN_REGISTER(append_one, two);
-    PLAN_REGISTER(append_one, many);
-
-    PLAN_REGISTER(trunc_one, any);
-    PLAN_REGISTER(trunc_one, one);
-    PLAN_REGISTER(trunc_one, two);
-    PLAN_REGISTER(trunc_one, many);
-
-    PLAN_REGISTER(touch_one, any);
-    PLAN_REGISTER(touch_one, one);
-    PLAN_REGISTER(touch_one, two);
-    PLAN_REGISTER(touch_one, many);
+    debug =3D getenv("FILEMONITOR_DEBUG") !=3D NULL;
+    g_test_add_func("/util/filemonitor", test_file_monitor_events);
=20
     return g_test_run();
 }
--=20
2.20.1
