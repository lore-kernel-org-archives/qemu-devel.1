Received: from eggs.gnu.org ([2001:4830:134:3::10]:38197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsjX-0003rs-Dw
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:05:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsjU-0007xT-Py
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:05:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cTsjU-0007w0-Hy
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:05:08 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B6F8E2E8A9E
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 16:05:08 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 18 Jan 2017 20:03:30 +0400
Message-Id: <20170118160332.13390-24-marcandre.lureau@redhat.com>
In-Reply-To: <20170118160332.13390-1-marcandre.lureau@redhat.com>
References: <20170118160332.13390-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 23/25] console: make screendump async
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kraxel@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Make screendump async to provide correct screendumps.

HMP doesn't have async support, so it has to remain sync to avoid
potential races.

Fixes:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1230527

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi-schema.json     |  5 +++-
 include/ui/console.h |  1 +
 hmp.c                |  2 +-
 ui/console.c         | 68 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
 4 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index 2e7c96c122..2af8661357 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -4686,6 +4686,9 @@
 #
 # Returns: Nothing on success
 #
+# Note: the operation can be cancelled and the file not written if the
+# client disconnects before completion.
+#
 # Since: 0.14.0
 #
 # Example:
@@ -4695,7 +4698,7 @@
 # <- { "return": {} }
 #
 ##
-{ 'command': 'screendump', 'data': {'filename': 'str'} }
+{ 'command': 'screendump', 'data': {'filename': 'str'}, 'async': true }
=20
=20
 ##
diff --git a/include/ui/console.h b/include/ui/console.h
index e2d4f0df0d..4199e7008a 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -75,6 +75,7 @@ struct MouseTransformInfo {
 };
=20
 void hmp_mouse_set(Monitor *mon, const QDict *qdict);
+void hmp_screendump_sync(const char *filename, Error **errp);
=20
 /* keysym is a unicode code except for special keys (see QEMU_KEY_xxx
    constants) */
diff --git a/hmp.c b/hmp.c
index 8522efea26..6586247a31 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1917,7 +1917,7 @@ void hmp_screendump(Monitor *mon, const QDict *qdic=
t)
     const char *filename =3D qdict_get_str(qdict, "filename");
     Error *err =3D NULL;
=20
-    qmp_screendump(filename, &err);
+    hmp_screendump_sync(filename, &err);
     hmp_handle_error(mon, &err);
 }
=20
diff --git a/ui/console.c b/ui/console.c
index 46ad6abd94..199296525c 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -114,6 +114,12 @@ typedef enum {
     TEXT_CONSOLE_FIXED_SIZE
 } console_type_t;
=20
+struct qmp_screendump {
+    gchar *filename;
+    QmpReturn *ret;
+    QLIST_ENTRY(qmp_screendump) link;
+};
+
 struct QemuConsole {
     Object parent;
=20
@@ -163,6 +169,8 @@ struct QemuConsole {
     QEMUFIFO out_fifo;
     uint8_t out_fifo_buf[16];
     QEMUTimer *kbd_timer;
+
+    QLIST_HEAD(, qmp_screendump) qmp_screendumps;
 };
=20
 struct DisplayState {
@@ -188,6 +196,8 @@ static void dpy_refresh(DisplayState *s);
 static DisplayState *get_alloc_displaystate(void);
 static void text_console_update_cursor_timer(void);
 static void text_console_update_cursor(void *opaque);
+static void ppm_save(const char *filename, DisplaySurface *ds,
+                     Error **errp);
=20
 static void gui_update(void *opaque)
 {
@@ -254,8 +264,39 @@ static void gui_setup_refresh(DisplayState *ds)
     ds->have_text =3D have_text;
 }
=20
+static void qmp_screendump_finish(QemuConsole *con, const char *filename=
,
+                                  QmpReturn *ret)
+{
+    Error *err =3D NULL;
+    DisplaySurface *surface;
+
+    if (qmp_return_is_cancelled(ret)) {
+        return;
+    }
+
+    surface =3D qemu_console_surface(con);
+
+    /* FIXME: async save with coroutine? it would have to copy or lock
+     * the surface. */
+    ppm_save(filename, surface, &err);
+
+    if (err) {
+        qmp_return_error(ret, err);
+    } else {
+        qmp_screendump_return(ret);
+    }
+}
+
 void graphic_hw_update_done(QemuConsole *con)
 {
+    struct qmp_screendump *dump, *next;
+
+    QLIST_FOREACH_SAFE(dump, &con->qmp_screendumps, link, next) {
+        qmp_screendump_finish(con, dump->filename, dump->ret);
+        g_free(dump->filename);
+        QLIST_REMOVE(dump, link);
+        g_free(dump);
+    }
 }
=20
 bool graphic_hw_update(QemuConsole *con)
@@ -356,7 +397,8 @@ write_err:
     goto out;
 }
=20
-void qmp_screendump(const char *filename, Error **errp)
+/* this sync screendump may produce outdated dumps: use qmp instead */
+void hmp_screendump_sync(const char *filename, Error **errp)
 {
     QemuConsole *con =3D qemu_console_lookup_by_index(0);
     DisplaySurface *surface;
@@ -371,6 +413,29 @@ void qmp_screendump(const char *filename, Error **er=
rp)
     ppm_save(filename, surface, errp);
 }
=20
+void qmp_screendump(const char *filename, QmpReturn *qret)
+{
+    QemuConsole *con =3D qemu_console_lookup_by_index(0);
+    bool async;
+    Error *err =3D NULL;
+
+    if (con =3D=3D NULL) {
+        error_setg(&err, "There is no QemuConsole I can screendump from.=
");
+        qmp_return_error(qret, err);
+        return;
+    }
+
+    async =3D graphic_hw_update(con);
+    if (async) {
+        struct qmp_screendump *dump =3D g_new(struct qmp_screendump, 1);
+        dump->filename =3D g_strdup(filename);
+        dump->ret =3D qret;
+        QLIST_INSERT_HEAD(&con->qmp_screendumps, dump, link);
+    } else {
+        qmp_screendump_finish(con, filename, qret);
+    }
+}
+
 void graphic_hw_text_update(QemuConsole *con, console_ch_t *chardata)
 {
     if (!con) {
@@ -1248,6 +1313,7 @@ static QemuConsole *new_console(DisplayState *ds, c=
onsole_type_t console_type,
     obj =3D object_new(TYPE_QEMU_CONSOLE);
     s =3D QEMU_CONSOLE(obj);
     s->head =3D head;
+    QLIST_INIT(&s->qmp_screendumps);
     object_property_add_link(obj, "device", TYPE_DEVICE,
                              (Object **)&s->device,
                              object_property_allow_set_link,
--=20
2.11.0.295.gd7dffce1c
