Received: from eggs.gnu.org ([209.51.188.92]:32856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hBIw9-0007jE-OK
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:54:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hBIw4-00046R-5V
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:54:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hBIw1-00043o-SO
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:54:38 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 58E6DF74C2
	for <qemu-devel@nongnu.org>; Tue,  2 Apr 2019 12:54:35 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue,  2 Apr 2019 13:54:17 +0100
Message-Id: <20190402125417.21573-4-berrange@redhat.com>
In-Reply-To: <20190402125417.21573-1-berrange@redhat.com>
References: <20190402125417.21573-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/3] filemon: fix watch IDs to avoid potential
 wraparound issues
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

Watch IDs are allocated from incrementing a int counter against
the QFileMonitor object. In very long life QEMU processes with
a huge amount of USB MTP activity creating & deleting directories
it is just about conceivable that the int counter can wrap
around. This would result in incorrect behaviour of the file
monitor watch APIs due to clashing watch IDs.

Instead of trying to detect this situation, this patch changes
the way watch IDs are allocated. It is turned into an int64_t
variable where the high 32 bits are set from the underlying
inotify "int" ID. This gives an ID that is guaranteed unique
for the directory as a whole, and we can rely on the kernel
to enforce this. QFileMonitor then sets the low 32 bits from
a per-directory counter.

The USB MTP device only sets watches on the directory as a
whole, not files within, so there is no risk of guest
triggered wrap around on the low 32 bits.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 authz/listfile.c              |   2 +-
 hw/usb/dev-mtp.c              |  10 +--
 include/authz/listfile.h      |   2 +-
 include/qemu/filemonitor.h    |  16 ++---
 tests/test-util-filemonitor.c | 130 +++++++++++++++++++---------------
 util/filemonitor-inotify.c    |  25 +++----
 util/filemonitor-stub.c       |   4 +-
 util/trace-events             |   6 +-
 8 files changed, 105 insertions(+), 90 deletions(-)

diff --git a/authz/listfile.c b/authz/listfile.c
index d4579767e7..bc2b58ef6d 100644
--- a/authz/listfile.c
+++ b/authz/listfile.c
@@ -93,7 +93,7 @@ qauthz_list_file_load(QAuthZListFile *fauthz, Error **e=
rrp)
=20
=20
 static void
-qauthz_list_file_event(int wd G_GNUC_UNUSED,
+qauthz_list_file_event(int64_t wd G_GNUC_UNUSED,
                        QFileMonitorEvent ev G_GNUC_UNUSED,
                        const char *name G_GNUC_UNUSED,
                        void *opaque)
diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 4dc1317e2e..ebf210fbf8 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -170,7 +170,7 @@ struct MTPObject {
     char         *path;
     struct stat  stat;
     /* file monitor watch id */
-    int          watchid;
+    int64_t      watchid;
     MTPObject    *parent;
     uint32_t     nchildren;
     QLIST_HEAD(, MTPObject) children;
@@ -498,7 +498,7 @@ static MTPObject *usb_mtp_object_lookup_name(MTPObjec=
t *parent,
     return NULL;
 }
=20
-static MTPObject *usb_mtp_object_lookup_id(MTPState *s, int id)
+static MTPObject *usb_mtp_object_lookup_id(MTPState *s, int64_t id)
 {
     MTPObject *iter;
=20
@@ -511,7 +511,7 @@ static MTPObject *usb_mtp_object_lookup_id(MTPState *=
s, int id)
     return NULL;
 }
=20
-static void file_monitor_event(int id,
+static void file_monitor_event(int64_t id,
                                QFileMonitorEvent ev,
                                const char *name,
                                void *opaque)
@@ -625,8 +625,8 @@ static void usb_mtp_object_readdir(MTPState *s, MTPOb=
ject *o)
     }
=20
     if (s->file_monitor) {
-        int id =3D qemu_file_monitor_add_watch(s->file_monitor, o->path,=
 NULL,
-                                             file_monitor_event, s, &err=
);
+        int64_t id =3D qemu_file_monitor_add_watch(s->file_monitor, o->p=
ath, NULL,
+                                                 file_monitor_event, s, =
&err);
         if (id =3D=3D -1) {
             error_report("usb-mtp: failed to add watch for %s: %s", o->p=
ath,
                          error_get_pretty(err));
diff --git a/include/authz/listfile.h b/include/authz/listfile.h
index ebbd5a4288..0d618c903c 100644
--- a/include/authz/listfile.h
+++ b/include/authz/listfile.h
@@ -92,7 +92,7 @@ struct QAuthZListFile {
     char *filename;
     bool refresh;
     QFileMonitor *file_monitor;
-    int file_watch;
+    int64_t file_watch;
 };
=20
=20
diff --git a/include/qemu/filemonitor.h b/include/qemu/filemonitor.h
index cd031832ed..64267d09b2 100644
--- a/include/qemu/filemonitor.h
+++ b/include/qemu/filemonitor.h
@@ -52,7 +52,7 @@ typedef enum {
  * empty.
  *
  */
-typedef void (*QFileMonitorHandler)(int id,
+typedef void (*QFileMonitorHandler)(int64_t id,
                                     QFileMonitorEvent event,
                                     const char *filename,
                                     void *opaque);
@@ -103,12 +103,12 @@ void qemu_file_monitor_free(QFileMonitor *mon);
  *
  * Returns: a positive integer watch ID, or -1 on error
  */
-int qemu_file_monitor_add_watch(QFileMonitor *mon,
-                                const char *dirpath,
-                                const char *filename,
-                                QFileMonitorHandler cb,
-                                void *opaque,
-                                Error **errp);
+int64_t qemu_file_monitor_add_watch(QFileMonitor *mon,
+                                    const char *dirpath,
+                                    const char *filename,
+                                    QFileMonitorHandler cb,
+                                    void *opaque,
+                                    Error **errp);
=20
 /**
  * qemu_file_monitor_remove_watch:
@@ -123,6 +123,6 @@ int qemu_file_monitor_add_watch(QFileMonitor *mon,
  */
 void qemu_file_monitor_remove_watch(QFileMonitor *mon,
                                     const char *dirpath,
-                                    int id);
+                                    int64_t id);
=20
 #endif /* QEMU_FILE_MONITOR_H */
diff --git a/tests/test-util-filemonitor.c b/tests/test-util-filemonitor.=
c
index 71a7cf5de0..46e781c022 100644
--- a/tests/test-util-filemonitor.c
+++ b/tests/test-util-filemonitor.c
@@ -43,12 +43,12 @@ typedef struct {
     int type;
     const char *filesrc;
     const char *filedst;
-    int watchid;
+    int64_t *watchid;
     int eventid;
 } QFileMonitorTestOp;
=20
 typedef struct {
-    int id;
+    int64_t id;
     QFileMonitorEvent event;
     char *filename;
 } QFileMonitorTestRecord;
@@ -90,7 +90,7 @@ qemu_file_monitor_test_event_loop(void *opaque G_GNUC_U=
NUSED)
  * an ordered list of all events that it receives
  */
 static void
-qemu_file_monitor_test_handler(int id,
+qemu_file_monitor_test_handler(int64_t id,
                                QFileMonitorEvent event,
                                const char *filename,
                                void *opaque)
@@ -156,7 +156,7 @@ qemu_file_monitor_test_next_record(QFileMonitorTestDa=
ta *data)
  */
 static bool
 qemu_file_monitor_test_expect(QFileMonitorTestData *data,
-                              int id,
+                              int64_t id,
                               QFileMonitorEvent event,
                               const char *filename)
 {
@@ -166,13 +166,14 @@ qemu_file_monitor_test_expect(QFileMonitorTestData =
*data,
     rec =3D qemu_file_monitor_test_next_record(data);
=20
     if (!rec) {
-        g_printerr("Missing event watch id %d event %d file %s\n",
+        g_printerr("Missing event watch id %" PRIx64 " event %d file %s\=
n",
                    id, event, filename);
         return false;
     }
=20
     if (id !=3D rec->id) {
-        g_printerr("Expected watch id %d but got %d\n", id, rec->id);
+        g_printerr("Expected watch id %" PRIx64 " but got %" PRIx64 "\n"=
,
+                   id, rec->id);
         goto cleanup;
     }
=20
@@ -198,170 +199,176 @@ qemu_file_monitor_test_expect(QFileMonitorTestDat=
a *data,
 static void
 test_file_monitor_events(void)
 {
+    int64_t watch0 =3D 0;
+    int64_t watch1 =3D 0;
+    int64_t watch2 =3D 0;
+    int64_t watch3 =3D 0;
+    int64_t watch4 =3D 0;
+    int64_t watch5 =3D 0;
     QFileMonitorTestOp ops[] =3D {
         { .type =3D QFILE_MONITOR_TEST_OP_ADD_WATCH,
-          .filesrc =3D NULL, .watchid =3D 0 },
+          .filesrc =3D NULL, .watchid =3D &watch0 },
         { .type =3D QFILE_MONITOR_TEST_OP_ADD_WATCH,
-          .filesrc =3D "one.txt", .watchid =3D 1 },
+          .filesrc =3D "one.txt", .watchid =3D &watch1 },
         { .type =3D QFILE_MONITOR_TEST_OP_ADD_WATCH,
-          .filesrc =3D "two.txt", .watchid =3D 2 },
+          .filesrc =3D "two.txt", .watchid =3D &watch2 },
=20
=20
         { .type =3D QFILE_MONITOR_TEST_OP_CREATE,
           .filesrc =3D "one.txt", },
         { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
-          .filesrc =3D "one.txt", .watchid =3D 0,
+          .filesrc =3D "one.txt", .watchid =3D &watch0,
           .eventid =3D QFILE_MONITOR_EVENT_CREATED },
         { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
-          .filesrc =3D "one.txt", .watchid =3D 1,
+          .filesrc =3D "one.txt", .watchid =3D &watch1,
           .eventid =3D QFILE_MONITOR_EVENT_CREATED },
=20
=20
         { .type =3D QFILE_MONITOR_TEST_OP_CREATE,
           .filesrc =3D "two.txt", },
         { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
-          .filesrc =3D "two.txt", .watchid =3D 0,
+          .filesrc =3D "two.txt", .watchid =3D &watch0,
           .eventid =3D QFILE_MONITOR_EVENT_CREATED },
         { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
-          .filesrc =3D "two.txt", .watchid =3D 2,
+          .filesrc =3D "two.txt", .watchid =3D &watch2,
           .eventid =3D QFILE_MONITOR_EVENT_CREATED },
=20
=20
         { .type =3D QFILE_MONITOR_TEST_OP_CREATE,
           .filesrc =3D "three.txt", },
         { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
-          .filesrc =3D "three.txt", .watchid =3D 0,
+          .filesrc =3D "three.txt", .watchid =3D &watch0,
           .eventid =3D QFILE_MONITOR_EVENT_CREATED },
=20
=20
         { .type =3D QFILE_MONITOR_TEST_OP_UNLINK,
           .filesrc =3D "three.txt", },
         { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
-          .filesrc =3D "three.txt", .watchid =3D 0,
+          .filesrc =3D "three.txt", .watchid =3D &watch0,
           .eventid =3D QFILE_MONITOR_EVENT_DELETED },
=20
=20
         { .type =3D QFILE_MONITOR_TEST_OP_RENAME,
           .filesrc =3D "one.txt", .filedst =3D "two.txt" },
         { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
-          .filesrc =3D "one.txt", .watchid =3D 0,
+          .filesrc =3D "one.txt", .watchid =3D &watch0,
           .eventid =3D QFILE_MONITOR_EVENT_DELETED },
         { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
-          .filesrc =3D "one.txt", .watchid =3D 1,
+          .filesrc =3D "one.txt", .watchid =3D &watch1,
           .eventid =3D QFILE_MONITOR_EVENT_DELETED },
         { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
-          .filesrc =3D "two.txt", .watchid =3D 0,
+          .filesrc =3D "two.txt", .watchid =3D &watch0,
           .eventid =3D QFILE_MONITOR_EVENT_CREATED },
         { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
-          .filesrc =3D "two.txt", .watchid =3D 2,
+          .filesrc =3D "two.txt", .watchid =3D &watch2,
           .eventid =3D QFILE_MONITOR_EVENT_CREATED },
=20
=20
         { .type =3D QFILE_MONITOR_TEST_OP_APPEND,
           .filesrc =3D "two.txt", },
         { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
-          .filesrc =3D "two.txt", .watchid =3D 0,
+          .filesrc =3D "two.txt", .watchid =3D &watch0,
           .eventid =3D QFILE_MONITOR_EVENT_MODIFIED },
         { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
-          .filesrc =3D "two.txt", .watchid =3D 2,
+          .filesrc =3D "two.txt", .watchid =3D &watch2,
           .eventid =3D QFILE_MONITOR_EVENT_MODIFIED },
=20
=20
         { .type =3D QFILE_MONITOR_TEST_OP_TOUCH,
           .filesrc =3D "two.txt", },
         { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
-          .filesrc =3D "two.txt", .watchid =3D 0,
+          .filesrc =3D "two.txt", .watchid =3D &watch0,
           .eventid =3D QFILE_MONITOR_EVENT_ATTRIBUTES },
         { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
-          .filesrc =3D "two.txt", .watchid =3D 2,
+          .filesrc =3D "two.txt", .watchid =3D &watch2,
           .eventid =3D QFILE_MONITOR_EVENT_ATTRIBUTES },
=20
=20
         { .type =3D QFILE_MONITOR_TEST_OP_DEL_WATCH,
-          .filesrc =3D "one.txt", .watchid =3D 1 },
+          .filesrc =3D "one.txt", .watchid =3D &watch1 },
         { .type =3D QFILE_MONITOR_TEST_OP_ADD_WATCH,
-          .filesrc =3D "one.txt", .watchid =3D 3 },
+          .filesrc =3D "one.txt", .watchid =3D &watch3 },
         { .type =3D QFILE_MONITOR_TEST_OP_CREATE,
           .filesrc =3D "one.txt", },
         { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
-          .filesrc =3D "one.txt", .watchid =3D 0,
+          .filesrc =3D "one.txt", .watchid =3D &watch0,
           .eventid =3D QFILE_MONITOR_EVENT_CREATED },
         { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
-          .filesrc =3D "one.txt", .watchid =3D 3,
+          .filesrc =3D "one.txt", .watchid =3D &watch3,
           .eventid =3D QFILE_MONITOR_EVENT_CREATED },
=20
=20
         { .type =3D QFILE_MONITOR_TEST_OP_DEL_WATCH,
-          .filesrc =3D "one.txt", .watchid =3D 3 },
+          .filesrc =3D "one.txt", .watchid =3D &watch3 },
         { .type =3D QFILE_MONITOR_TEST_OP_UNLINK,
           .filesrc =3D "one.txt", },
         { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
-          .filesrc =3D "one.txt", .watchid =3D 0,
+          .filesrc =3D "one.txt", .watchid =3D &watch0,
           .eventid =3D QFILE_MONITOR_EVENT_DELETED },
=20
=20
         { .type =3D QFILE_MONITOR_TEST_OP_MKDIR,
           .filesrc =3D "fish", },
         { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
-          .filesrc =3D "fish", .watchid =3D 0,
+          .filesrc =3D "fish", .watchid =3D &watch0,
           .eventid =3D QFILE_MONITOR_EVENT_CREATED },
=20
=20
         { .type =3D QFILE_MONITOR_TEST_OP_ADD_WATCH,
-          .filesrc =3D "fish/", .watchid =3D 4 },
+          .filesrc =3D "fish/", .watchid =3D &watch4 },
         { .type =3D QFILE_MONITOR_TEST_OP_ADD_WATCH,
-          .filesrc =3D "fish/one.txt", .watchid =3D 5 },
+          .filesrc =3D "fish/one.txt", .watchid =3D &watch5 },
         { .type =3D QFILE_MONITOR_TEST_OP_CREATE,
           .filesrc =3D "fish/one.txt", },
         { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
-          .filesrc =3D "one.txt", .watchid =3D 4,
+          .filesrc =3D "one.txt", .watchid =3D &watch4,
           .eventid =3D QFILE_MONITOR_EVENT_CREATED },
         { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
-          .filesrc =3D "one.txt", .watchid =3D 5,
+          .filesrc =3D "one.txt", .watchid =3D &watch5,
           .eventid =3D QFILE_MONITOR_EVENT_CREATED },
=20
=20
         { .type =3D QFILE_MONITOR_TEST_OP_DEL_WATCH,
-          .filesrc =3D "fish/one.txt", .watchid =3D 5 },
+          .filesrc =3D "fish/one.txt", .watchid =3D &watch5 },
         { .type =3D QFILE_MONITOR_TEST_OP_RENAME,
           .filesrc =3D "fish/one.txt", .filedst =3D "two.txt", },
         { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
-          .filesrc =3D "one.txt", .watchid =3D 4,
+          .filesrc =3D "one.txt", .watchid =3D &watch4,
           .eventid =3D QFILE_MONITOR_EVENT_DELETED },
         { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
-          .filesrc =3D "two.txt", .watchid =3D 0,
+          .filesrc =3D "two.txt", .watchid =3D &watch0,
           .eventid =3D QFILE_MONITOR_EVENT_CREATED },
         { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
-          .filesrc =3D "two.txt", .watchid =3D 2,
+          .filesrc =3D "two.txt", .watchid =3D &watch2,
           .eventid =3D QFILE_MONITOR_EVENT_CREATED },
=20
=20
         { .type =3D QFILE_MONITOR_TEST_OP_RMDIR,
           .filesrc =3D "fish", },
         { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
-          .filesrc =3D "", .watchid =3D 4,
+          .filesrc =3D "", .watchid =3D &watch4,
           .eventid =3D QFILE_MONITOR_EVENT_IGNORED },
         { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
-          .filesrc =3D "fish", .watchid =3D 0,
+          .filesrc =3D "fish", .watchid =3D &watch0,
           .eventid =3D QFILE_MONITOR_EVENT_DELETED },
         { .type =3D QFILE_MONITOR_TEST_OP_DEL_WATCH,
-          .filesrc =3D "fish", .watchid =3D 4 },
+          .filesrc =3D "fish", .watchid =3D &watch4 },
=20
=20
         { .type =3D QFILE_MONITOR_TEST_OP_UNLINK,
           .filesrc =3D "two.txt", },
         { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
-          .filesrc =3D "two.txt", .watchid =3D 0,
+          .filesrc =3D "two.txt", .watchid =3D &watch0,
           .eventid =3D QFILE_MONITOR_EVENT_DELETED },
         { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
-          .filesrc =3D "two.txt", .watchid =3D 2,
+          .filesrc =3D "two.txt", .watchid =3D &watch2,
           .eventid =3D QFILE_MONITOR_EVENT_DELETED },
=20
=20
         { .type =3D QFILE_MONITOR_TEST_OP_DEL_WATCH,
-          .filesrc =3D "two.txt", .watchid =3D 2 },
+          .filesrc =3D "two.txt", .watchid =3D &watch2 },
         { .type =3D QFILE_MONITOR_TEST_OP_DEL_WATCH,
-          .filesrc =3D NULL, .watchid =3D 0 },
+          .filesrc =3D NULL, .watchid =3D &watch0 },
     };
     Error *local_err =3D NULL;
     GError *gerr =3D NULL;
@@ -374,6 +381,7 @@ test_file_monitor_events(void)
     char *pathsrc =3D NULL;
     char *pathdst =3D NULL;
     QFileMonitorTestData data;
+    GHashTable *ids =3D g_hash_table_new(g_int64_hash, g_int64_equal);
=20
     qemu_mutex_init(&data.lock);
     data.records =3D NULL;
@@ -414,7 +422,6 @@ test_file_monitor_events(void)
     for (i =3D 0; i < G_N_ELEMENTS(ops); i++) {
         const QFileMonitorTestOp *op =3D &(ops[i]);
         int fd;
-        int watchid;
         struct utimbuf ubuf;
         char *watchdir;
         const char *watchfile;
@@ -427,8 +434,8 @@ test_file_monitor_events(void)
         switch (op->type) {
         case QFILE_MONITOR_TEST_OP_ADD_WATCH:
             if (debug) {
-                g_printerr("Add watch %s %s %d\n",
-                           dir, op->filesrc, op->watchid);
+                g_printerr("Add watch %s %s\n",
+                           dir, op->filesrc);
             }
             if (op->filesrc && strchr(op->filesrc, '/')) {
                 watchdir =3D g_strdup_printf("%s/%s", dir, op->filesrc);
@@ -442,7 +449,7 @@ test_file_monitor_events(void)
                 watchdir =3D g_strdup(dir);
                 watchfile =3D op->filesrc;
             }
-            watchid =3D
+            *op->watchid =3D
                 qemu_file_monitor_add_watch(mon,
                                             watchdir,
                                             watchfile,
@@ -450,20 +457,23 @@ test_file_monitor_events(void)
                                             &data,
                                             &local_err);
             g_free(watchdir);
-            if (watchid < 0) {
+            if (*op->watchid < 0) {
                 g_printerr("Unable to add watch %s",
                            error_get_pretty(local_err));
                 goto cleanup;
             }
-            if (watchid !=3D op->watchid) {
-                g_printerr("Unexpected watch ID %d, wanted %d\n",
-                           watchid, op->watchid);
+            if (debug) {
+                g_printerr("Watch ID %" PRIx64 "\n", *op->watchid);
+            }
+            if (g_hash_table_contains(ids, op->watchid)) {
+                g_printerr("Watch ID %" PRIx64 "already exists", *op->wa=
tchid);
                 goto cleanup;
             }
+            g_hash_table_add(ids, op->watchid);
             break;
         case QFILE_MONITOR_TEST_OP_DEL_WATCH:
             if (debug) {
-                g_printerr("Del watch %s %d\n", dir, op->watchid);
+                g_printerr("Del watch %s %" PRIx64 "\n", dir, *op->watch=
id);
             }
             if (op->filesrc && strchr(op->filesrc, '/')) {
                 watchdir =3D g_strdup_printf("%s/%s", dir, op->filesrc);
@@ -472,18 +482,19 @@ test_file_monitor_events(void)
             } else {
                 watchdir =3D g_strdup(dir);
             }
+            g_hash_table_remove(ids, op->watchid);
             qemu_file_monitor_remove_watch(mon,
                                            watchdir,
-                                           op->watchid);
+                                           *op->watchid);
             g_free(watchdir);
             break;
         case QFILE_MONITOR_TEST_OP_EVENT:
             if (debug) {
-                g_printerr("Event id=3D%d event=3D%d file=3D%s\n",
-                           op->watchid, op->eventid, op->filesrc);
+                g_printerr("Event id=3D%" PRIx64 " event=3D%d file=3D%s\=
n",
+                           *op->watchid, op->eventid, op->filesrc);
             }
             if (!qemu_file_monitor_test_expect(
-                    &data, op->watchid, op->eventid, op->filesrc))
+                    &data, *op->watchid, op->eventid, op->filesrc))
                 goto cleanup;
             break;
         case QFILE_MONITOR_TEST_OP_CREATE:
@@ -596,6 +607,8 @@ test_file_monitor_events(void)
         pathsrc =3D pathdst =3D NULL;
     }
=20
+    g_assert_cmpint(g_hash_table_size(ids), =3D=3D, 0);
+
     err =3D 0;
=20
  cleanup:
@@ -647,6 +660,7 @@ test_file_monitor_events(void)
             abort();
         }
     }
+    g_hash_table_unref(ids);
     g_free(dir);
     g_assert(err =3D=3D 0);
 }
diff --git a/util/filemonitor-inotify.c b/util/filemonitor-inotify.c
index 3eb29f860b..b5f4b93f3f 100644
--- a/util/filemonitor-inotify.c
+++ b/util/filemonitor-inotify.c
@@ -29,7 +29,6 @@
=20
 struct QFileMonitor {
     int fd;
-    int nextid; /* watch ID counter */
     QemuMutex lock; /* protects dirs & idmap */
     GHashTable *dirs; /* dirname =3D> QFileMonitorDir */
     GHashTable *idmap; /* inotify ID =3D> dirname */
@@ -37,7 +36,7 @@ struct QFileMonitor {
=20
=20
 typedef struct {
-    int id; /* watch ID */
+    int64_t id; /* watch ID */
     char *filename; /* optional filter */
     QFileMonitorHandler cb;
     void *opaque;
@@ -46,7 +45,8 @@ typedef struct {
=20
 typedef struct {
     char *path;
-    int id; /* inotify ID */
+    int inotify_id; /* inotify ID */
+    int next_file_id; /* file ID counter */
     GArray *watches; /* QFileMonitorWatch elements */
 } QFileMonitorDir;
=20
@@ -126,7 +126,8 @@ static void qemu_file_monitor_watch(void *arg)
             g_assert_not_reached();
         }
=20
-        trace_qemu_file_monitor_event(mon, dir->path, name, ev->mask, di=
r->id);
+        trace_qemu_file_monitor_event(mon, dir->path, name, ev->mask,
+                                      dir->inotify_id);
         for (i =3D 0; i < dir->watches->len; i++) {
             QFileMonitorWatch *watch =3D &g_array_index(dir->watches,
                                                       QFileMonitorWatch,
@@ -237,7 +238,7 @@ qemu_file_monitor_free(QFileMonitor *mon)
     g_idle_add((GSourceFunc)qemu_file_monitor_free_idle, mon);
 }
=20
-int
+int64_t
 qemu_file_monitor_add_watch(QFileMonitor *mon,
                             const char *dirpath,
                             const char *filename,
@@ -247,7 +248,7 @@ qemu_file_monitor_add_watch(QFileMonitor *mon,
 {
     QFileMonitorDir *dir;
     QFileMonitorWatch watch;
-    int ret =3D -1;
+    int64_t ret =3D -1;
=20
     qemu_mutex_lock(&mon->lock);
     dir =3D g_hash_table_lookup(mon->dirs, dirpath);
@@ -265,7 +266,7 @@ qemu_file_monitor_add_watch(QFileMonitor *mon,
=20
         dir =3D g_new0(QFileMonitorDir, 1);
         dir->path =3D g_strdup(dirpath);
-        dir->id =3D rv;
+        dir->inotify_id =3D rv;
         dir->watches =3D g_array_new(FALSE, TRUE, sizeof(QFileMonitorWat=
ch));
=20
         g_hash_table_insert(mon->dirs, dir->path, dir);
@@ -276,7 +277,7 @@ qemu_file_monitor_add_watch(QFileMonitor *mon,
         }
     }
=20
-    watch.id =3D mon->nextid++;
+    watch.id =3D (((int64_t)dir->inotify_id) << 32) | dir->next_file_id+=
+;
     watch.filename =3D g_strdup(filename);
     watch.cb =3D cb;
     watch.opaque =3D opaque;
@@ -297,7 +298,7 @@ qemu_file_monitor_add_watch(QFileMonitor *mon,
=20
 void qemu_file_monitor_remove_watch(QFileMonitor *mon,
                                     const char *dirpath,
-                                    int id)
+                                    int64_t id)
 {
     QFileMonitorDir *dir;
     gsize i;
@@ -322,10 +323,10 @@ void qemu_file_monitor_remove_watch(QFileMonitor *m=
on,
     }
=20
     if (dir->watches->len =3D=3D 0) {
-        inotify_rm_watch(mon->fd, dir->id);
-        trace_qemu_file_monitor_disable_watch(mon, dir->path, dir->id);
+        inotify_rm_watch(mon->fd, dir->inotify_id);
+        trace_qemu_file_monitor_disable_watch(mon, dir->path, dir->inoti=
fy_id);
=20
-        g_hash_table_remove(mon->idmap, GINT_TO_POINTER(dir->id));
+        g_hash_table_remove(mon->idmap, GINT_TO_POINTER(dir->inotify_id)=
);
         g_hash_table_remove(mon->dirs, dir->path);
=20
         if (g_hash_table_size(mon->dirs) =3D=3D 0) {
diff --git a/util/filemonitor-stub.c b/util/filemonitor-stub.c
index 48268b2bb6..2c0e97edd8 100644
--- a/util/filemonitor-stub.c
+++ b/util/filemonitor-stub.c
@@ -38,7 +38,7 @@ qemu_file_monitor_free(QFileMonitor *mon G_GNUC_UNUSED)
 }
=20
=20
-int
+int64_t
 qemu_file_monitor_add_watch(QFileMonitor *mon G_GNUC_UNUSED,
                             const char *dirpath G_GNUC_UNUSED,
                             const char *filename G_GNUC_UNUSED,
@@ -54,6 +54,6 @@ qemu_file_monitor_add_watch(QFileMonitor *mon G_GNUC_UN=
USED,
 void
 qemu_file_monitor_remove_watch(QFileMonitor *mon G_GNUC_UNUSED,
                                const char *dirpath G_GNUC_UNUSED,
-                               int id G_GNUC_UNUSED)
+                               int64_t id G_GNUC_UNUSED)
 {
 }
diff --git a/util/trace-events b/util/trace-events
index 56c27287be..9dbd237dad 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -22,13 +22,13 @@ buffer_move(const char *buf, size_t len, const char *=
from) "%s: %zd bytes from %
 buffer_free(const char *buf, size_t len) "%s: capacity %zd"
=20
 # filemonitor-inotify.c
-qemu_file_monitor_add_watch(void *mon, const char *dirpath, const char *=
filename, void *cb, void *opaque, int id) "File monitor %p add watch dir=3D=
'%s' file=3D'%s' cb=3D%p opaque=3D%p id=3D%u"
-qemu_file_monitor_remove_watch(void *mon, const char *dirpath, int id) "=
File monitor %p remove watch dir=3D'%s' id=3D%u"
+qemu_file_monitor_add_watch(void *mon, const char *dirpath, const char *=
filename, void *cb, void *opaque, int64_t id) "File monitor %p add watch =
dir=3D'%s' file=3D'%s' cb=3D%p opaque=3D%p id=3D%" PRId64
+qemu_file_monitor_remove_watch(void *mon, const char *dirpath, int64_t i=
d) "File monitor %p remove watch dir=3D'%s' id=3D%" PRId64
 qemu_file_monitor_new(void *mon, int fd) "File monitor %p created fd=3D%=
d"
 qemu_file_monitor_enable_watch(void *mon, const char *dirpath, int id) "=
File monitor %p enable watch dir=3D'%s' id=3D%u"
 qemu_file_monitor_disable_watch(void *mon, const char *dirpath, int id) =
"Fle monitor %p disable watch dir=3D'%s' id=3D%u"
 qemu_file_monitor_event(void *mon, const char *dirpath, const char *file=
name, int mask, unsigned int id) "File monitor %p event dir=3D'%s' file=3D=
'%s' mask=3D0x%x id=3D%u"
-qemu_file_monitor_dispatch(void *mon, const char *dirpath, const char *f=
ilename, int ev, void *cb, void *opaque, unsigned int id) "File monitor %=
p dispatch dir=3D'%s' file=3D'%s' ev=3D%d cb=3D%p opaque=3D%p id=3D%u"
+qemu_file_monitor_dispatch(void *mon, const char *dirpath, const char *f=
ilename, int ev, void *cb, void *opaque, int64_t id) "File monitor %p dis=
patch dir=3D'%s' file=3D'%s' ev=3D%d cb=3D%p opaque=3D%p id=3D%" PRId64
=20
 # qemu-coroutine.c
 qemu_aio_coroutine_enter(void *ctx, void *from, void *to, void *opaque) =
"ctx %p from %p to %p opaque %p"
--=20
2.20.1
