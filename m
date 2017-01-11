Received: from eggs.gnu.org ([2001:4830:134:3::10]:40657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cRMj9-0000xE-Q1
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:30:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cRMj7-0006Oa-70
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:30:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cRMj6-0006O9-T7
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:30:21 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0D82061BA0
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 17:30:21 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 11 Jan 2017 18:29:32 +0100
Message-Id: <20170111172956.11255-17-marcandre.lureau@redhat.com>
In-Reply-To: <20170111172956.11255-1-marcandre.lureau@redhat.com>
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 16/40] char: get rid of CharDriver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

qemu_chr_new_from_opts() is modified to not need CharDriver backend[]
array, but uses instead objectified qmp_query_chardev_backends() and
char_get_class(). The alias field is moved outside in a ChardevAlias[],
similar to QDevAlias for devices.

"kind" and "parse" are moved to ChardevClass ("kind" is to be removed
next)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/sysemu/char.h |  12 +--
 backends/baum.c       |   6 +-
 backends/msmouse.c    |   6 +-
 backends/testdev.c    |   6 +-
 qemu-char.c           | 275 +++++++++++++++++++++-----------------------=
------
 spice-qemu-char.c     |  15 +--
 ui/console.c          |  10 +-
 ui/gtk.c              |  10 +-
 8 files changed, 128 insertions(+), 212 deletions(-)

diff --git a/include/sysemu/char.h b/include/sysemu/char.h
index 5e5594f305..2a3b887b8a 100644
--- a/include/sysemu/char.h
+++ b/include/sysemu/char.h
@@ -88,8 +88,6 @@ typedef struct CharBackend {
     int fe_open;
 } CharBackend;
=20
-typedef struct CharDriver CharDriver;
-
 struct Chardev {
     Object parent_obj;
=20
@@ -476,6 +474,8 @@ typedef struct ChardevClass {
     ObjectClass parent_class;
=20
     bool internal; /* TODO: eventually use TYPE_USER_CREATABLE */
+    ChardevBackendKind kind;
+    void (*parse)(QemuOpts *opts, ChardevBackend *backend, Error **errp)=
;
=20
     void (*open)(Chardev *chr, ChardevBackend *backend,
                  bool *be_opened, Error **errp);
@@ -495,17 +495,9 @@ typedef struct ChardevClass {
     void (*chr_set_fe_open)(Chardev *chr, int fe_open);
 } ChardevClass;
=20
-struct CharDriver {
-    ChardevBackendKind kind;
-    const char *alias;
-    void (*parse)(QemuOpts *opts, ChardevBackend *backend, Error **errp)=
;
-};
-
 Chardev *qemu_chardev_new(const char *id, const char *typename,
                           ChardevBackend *backend, Error **errp);
=20
-void register_char_driver(const CharDriver *driver);
-
 extern int term_escape_char;
=20
 /* console.c */
diff --git a/backends/baum.c b/backends/baum.c
index 39c9365024..5316c8da0a 100644
--- a/backends/baum.c
+++ b/backends/baum.c
@@ -656,6 +656,7 @@ static void char_braille_class_init(ObjectClass *oc, =
void *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
+    cc->kind =3D CHARDEV_BACKEND_KIND_BRAILLE;
     cc->open =3D baum_chr_open;
     cc->chr_write =3D baum_chr_write;
     cc->chr_accept_input =3D baum_chr_accept_input;
@@ -671,11 +672,6 @@ static const TypeInfo char_braille_type_info =3D {
=20
 static void register_types(void)
 {
-    static const CharDriver driver =3D {
-        .kind =3D CHARDEV_BACKEND_KIND_BRAILLE,
-    };
-
-    register_char_driver(&driver);
     type_register_static(&char_braille_type_info);
 }
=20
diff --git a/backends/msmouse.c b/backends/msmouse.c
index 55c344f0e1..28689b3e29 100644
--- a/backends/msmouse.c
+++ b/backends/msmouse.c
@@ -169,6 +169,7 @@ static void char_msmouse_class_init(ObjectClass *oc, =
void *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
+    cc->kind =3D CHARDEV_BACKEND_KIND_MSMOUSE;
     cc->open =3D msmouse_chr_open;
     cc->chr_write =3D msmouse_chr_write;
     cc->chr_accept_input =3D msmouse_chr_accept_input;
@@ -184,11 +185,6 @@ static const TypeInfo char_msmouse_type_info =3D {
=20
 static void register_types(void)
 {
-    static const CharDriver driver =3D {
-        .kind =3D CHARDEV_BACKEND_KIND_MSMOUSE,
-    };
-
-    register_char_driver(&driver);
     type_register_static(&char_msmouse_type_info);
 }
=20
diff --git a/backends/testdev.c b/backends/testdev.c
index ea15143713..243454aaa3 100644
--- a/backends/testdev.c
+++ b/backends/testdev.c
@@ -111,6 +111,7 @@ static void char_testdev_class_init(ObjectClass *oc, =
void *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
+    cc->kind =3D CHARDEV_BACKEND_KIND_TESTDEV;
     cc->chr_write =3D testdev_chr_write;
 }
=20
@@ -123,11 +124,6 @@ static const TypeInfo char_testdev_type_info =3D {
=20
 static void register_types(void)
 {
-    static const CharDriver driver =3D {
-        .kind =3D CHARDEV_BACKEND_KIND_TESTDEV,
-    };
-
-    register_char_driver(&driver);
     type_register_static(&char_testdev_type_info);
 }
=20
diff --git a/qemu-char.c b/qemu-char.c
index b6415ee333..c003223e48 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -560,16 +560,13 @@ static void null_chr_open(Chardev *chr,
     *be_opened =3D false;
 }
=20
-static const CharDriver null_driver =3D {
-    .kind =3D CHARDEV_BACKEND_KIND_NULL,
-};
-
 static void char_null_class_init(ObjectClass *oc, void *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
     cc->open =3D null_chr_open;
     cc->chr_write =3D null_chr_write;
+    cc->kind =3D CHARDEV_BACKEND_KIND_NULL;
 }
=20
 static const TypeInfo char_null_type_info =3D {
@@ -1707,14 +1704,11 @@ static void char_pty_open(Chardev *chr,
     *be_opened =3D false;
 }
=20
-static const CharDriver pty_driver =3D {
-    .kind =3D CHARDEV_BACKEND_KIND_PTY,
-};
-
 static void char_pty_class_init(ObjectClass *oc, void *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
+    cc->kind =3D CHARDEV_BACKEND_KIND_PTY;
     cc->open =3D char_pty_open;
     cc->chr_write =3D char_pty_chr_write;
     cc->chr_update_read_handler =3D pty_chr_update_read_handler;
@@ -2457,14 +2451,11 @@ static void qemu_chr_open_win_con(Chardev *chr,
     qemu_chr_open_win_file(chr, GetStdHandle(STD_OUTPUT_HANDLE));
 }
=20
-static const CharDriver console_driver =3D {
-    .kind =3D CHARDEV_BACKEND_KIND_CONSOLE,
-};
-
 static void char_console_class_init(ObjectClass *oc, void *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
+    cc->kind =3D CHARDEV_BACKEND_KIND_CONSOLE;
     cc->open =3D qemu_chr_open_win_con;
 }
=20
@@ -3839,15 +3830,12 @@ static void qemu_chr_parse_stdio(QemuOpts *opts, =
ChardevBackend *backend,
     stdio->signal =3D qemu_opt_get_bool(opts, "signal", true);
 }
=20
-static const CharDriver stdio_driver =3D {
-    .kind =3D CHARDEV_BACKEND_KIND_STDIO,
-    .parse =3D qemu_chr_parse_stdio,
-};
-
 static void char_stdio_class_init(ObjectClass *oc, void *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
+    cc->kind =3D CHARDEV_BACKEND_KIND_STDIO;
+    cc->parse =3D qemu_chr_parse_stdio;
     cc->open =3D qemu_chr_open_stdio;
 #ifdef _WIN32
     cc->chr_write =3D win_stdio_write;
@@ -3917,15 +3905,12 @@ static void qemu_chr_parse_pipe(QemuOpts *opts, C=
hardevBackend *backend,
     dev->device =3D g_strdup(device);
 }
=20
-static const CharDriver pipe_driver =3D {
-    .kind =3D CHARDEV_BACKEND_KIND_PIPE,
-    .parse =3D qemu_chr_parse_pipe,
-};
-
 static void char_pipe_class_init(ObjectClass *oc, void *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
+    cc->kind =3D CHARDEV_BACKEND_KIND_PIPE;
+    cc->parse =3D qemu_chr_parse_pipe;
     cc->open =3D qemu_chr_open_pipe;
 }
=20
@@ -3955,15 +3940,12 @@ static void qemu_chr_parse_ringbuf(QemuOpts *opts=
, ChardevBackend *backend,
     }
 }
=20
-static const CharDriver ringbuf_driver =3D {
-    .kind =3D CHARDEV_BACKEND_KIND_RINGBUF,
-    .parse =3D qemu_chr_parse_ringbuf,
-};
-
 static void char_ringbuf_class_init(ObjectClass *oc, void *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
+    cc->kind =3D CHARDEV_BACKEND_KIND_RINGBUF;
+    cc->parse =3D qemu_chr_parse_ringbuf;
     cc->open =3D qemu_chr_open_ringbuf;
     cc->chr_write =3D ringbuf_chr_write;
 }
@@ -3977,14 +3959,17 @@ static const TypeInfo char_ringbuf_type_info =3D =
{
 };
=20
 /* Bug-compatibility: */
-static const CharDriver memory_driver =3D {
-    .kind =3D CHARDEV_BACKEND_KIND_MEMORY,
-    .parse =3D qemu_chr_parse_ringbuf,
-};
+static void char_memory_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc =3D CHARDEV_CLASS(oc);
+
+    cc->kind =3D CHARDEV_BACKEND_KIND_MEMORY;
+}
=20
 static const TypeInfo char_memory_type_info =3D {
     .name =3D TYPE_CHARDEV_MEMORY,
     .parent =3D TYPE_CHARDEV_RINGBUF,
+    .class_init =3D char_memory_class_init,
 };
=20
 static void qemu_chr_parse_mux(QemuOpts *opts, ChardevBackend *backend,
@@ -4002,15 +3987,12 @@ static void qemu_chr_parse_mux(QemuOpts *opts, Ch=
ardevBackend *backend,
     mux->chardev =3D g_strdup(chardev);
 }
=20
-static const CharDriver mux_driver =3D {
-    .kind =3D CHARDEV_BACKEND_KIND_MUX,
-    .parse =3D qemu_chr_parse_mux,
-};
-
 static void char_mux_class_init(ObjectClass *oc, void *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
+    cc->kind =3D CHARDEV_BACKEND_KIND_MUX;
+    cc->parse =3D qemu_chr_parse_mux;
     cc->open =3D qemu_chr_open_mux;
     cc->chr_write =3D mux_chr_write;
     cc->chr_accept_input =3D mux_chr_accept_input;
@@ -4152,18 +4134,52 @@ static void qemu_chr_parse_udp(QemuOpts *opts, Ch=
ardevBackend *backend,
     }
 }
=20
-static const CharDriver *backends[CHARDEV_BACKEND_KIND__MAX];
-
-void register_char_driver(const CharDriver *driver)
+static const ChardevClass *char_get_class(const char *driver, Error **er=
rp)
 {
-    backends[driver->kind] =3D driver;
+    ObjectClass *oc;
+    const ChardevClass *cc;
+    char *typename =3D g_strdup_printf("chardev-%s", driver);
+
+    oc =3D object_class_by_name(typename);
+    g_free(typename);
+
+    if (!object_class_dynamic_cast(oc, TYPE_CHARDEV)) {
+        error_setg(errp, "'%s' is not a valid char driver name", driver)=
;
+        return NULL;
+    }
+
+    if (object_class_is_abstract(oc)) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "driver",
+                   "abstract device type");
+        return NULL;
+    }
+
+    cc =3D CHARDEV_CLASS(oc);
+    if (cc->internal) {
+        error_setg(errp, "'%s' is not a valid char driver name", driver)=
;
+        return NULL;
+    }
+
+    return cc;
 }
=20
+static const struct ChardevAlias {
+    const char *typename;
+    const char *alias;
+} chardev_alias_table[] =3D {
+#ifdef HAVE_CHARDEV_PARPORT
+    { "parallel", "parport" },
+#endif
+#ifdef HAVE_CHARDEV_SERIAL
+    { "serial", "tty" },
+#endif
+};
+
 Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
                                 Error **errp)
 {
     Error *local_err =3D NULL;
-    const CharDriver *cd =3D NULL;
+    const ChardevClass *cc;
     Chardev *chr;
     int i;
     ChardevReturn *ret =3D NULL;
@@ -4180,16 +4196,13 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
=20
     if (is_help_option(name)) {
         GString *str =3D g_string_new("");
-        for (i =3D 0; i < ARRAY_SIZE(backends); i++) {
-            cd =3D backends[i];
-            if (cd) {
-                g_string_append_printf(str, "\n%s", ChardevBackendKind_l=
ookup[cd->kind]);
-                if (cd->alias) {
-                    g_string_append_printf(str, "\n%s", cd->alias);
-                }
-            }
+        ChardevBackendInfoList *l, *il =3D qmp_query_chardev_backends(NU=
LL);
+
+        for (l =3D il; l !=3D NULL; l =3D l->next) {
+            g_string_append_printf(str, "\n%s", l->value->name);
         }
=20
+        qapi_free_ChardevBackendInfoList(l);
         error_report("Available chardev backend types: %s", str->str);
         g_string_free(str, true);
         exit(0);
@@ -4200,18 +4213,15 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
         goto err;
     }
=20
-    for (i =3D 0; i < ARRAY_SIZE(backends); i++) {
-        cd =3D backends[i];
-        if (!cd) {
-            continue;
-        }
-        if (g_strcmp0(ChardevBackendKind_lookup[cd->kind], name) =3D=3D =
0 ||
-            g_strcmp0(cd->alias, name) =3D=3D 0) {
+    for (i =3D 0; i < ARRAY_SIZE(chardev_alias_table); i++) {
+        if (g_strcmp0(chardev_alias_table[i].alias, name) =3D=3D 0) {
+            name =3D chardev_alias_table[i].typename;
             break;
         }
     }
-    if (i =3D=3D ARRAY_SIZE(backends)) {
-        error_setg(errp, "chardev: backend \"%s\" not found", name);
+
+    cc =3D char_get_class(name, errp);
+    if (cc =3D=3D NULL) {
         goto err;
     }
=20
@@ -4222,17 +4232,17 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
     }
=20
     chr =3D NULL;
-    backend->type =3D cd->kind;
-    if (cd->parse) {
-        cd->parse(opts, backend, &local_err);
+    backend->type =3D cc->kind;
+    if (cc->parse) {
+        cc->parse(opts, backend, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
             goto qapi_out;
         }
     } else {
-        ChardevCommon *cc =3D g_new0(ChardevCommon, 1);
-        qemu_chr_parse_common(opts, cc);
-        backend->u.null.data =3D cc; /* Any ChardevCommon member would w=
ork */
+        ChardevCommon *ccom =3D g_new0(ChardevCommon, 1);
+        qemu_chr_parse_common(opts, ccom);
+        backend->u.null.data =3D ccom; /* Any ChardevCommon member would=
 work */
     }
=20
     ret =3D qmp_chardev_add(bid ? bid : id, backend, errp);
@@ -4407,21 +4417,23 @@ qmp_prepend_backend(ChardevBackendInfoList *list,=
 const char *name)
 ChardevBackendInfoList *qmp_query_chardev_backends(Error **errp)
 {
     ChardevBackendInfoList *backend_list =3D NULL;
-    const CharDriver *c;
+    GSList *l, *list =3D object_class_get_list(TYPE_CHARDEV, false);
     int i;
=20
-    for (i =3D 0; i < ARRAY_SIZE(backends); i++) {
-        c =3D backends[i];
-        if (!c) {
+    for (l =3D list; l; l =3D l->next) {
+        ObjectClass *klass =3D l->data;
+        assert(g_str_has_prefix(object_class_get_name(klass), "chardev-"=
));
+        if (CHARDEV_CLASS(klass)->internal) {
             continue;
         }
-
         backend_list =3D qmp_prepend_backend(backend_list,
-                                           ChardevBackendKind_lookup[c->=
kind]);
-        if (c->alias) {
-            backend_list =3D qmp_prepend_backend(backend_list, c->alias)=
;
-        }
+                                           object_class_get_name(klass) =
+ 8);
+    }
+    for (i =3D 0; i < ARRAY_SIZE(chardev_alias_table); i++) {
+        backend_list =3D qmp_prepend_backend(backend_list,
+                                           chardev_alias_table[i].alias)=
;
     }
+    g_slist_free(l);
=20
     return backend_list;
 }
@@ -4661,16 +4673,12 @@ static void qmp_chardev_open_parallel(Chardev *ch=
r,
     qemu_chr_open_pp_fd(chr, fd, be_opened, errp);
 }
=20
-static const CharDriver parallel_driver =3D {
-    .kind =3D CHARDEV_BACKEND_KIND_PARALLEL,
-    .alias =3D "parport",
-    .parse =3D qemu_chr_parse_parallel,
-};
-
 static void char_parallel_class_init(ObjectClass *oc, void *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
+    cc->kind =3D CHARDEV_BACKEND_KIND_PARALLEL;
+    cc->parse =3D qemu_chr_parse_parallel;
     cc->open =3D qmp_chardev_open_parallel;
 #if defined(__linux__)
     cc->chr_write =3D null_chr_write;
@@ -4708,15 +4716,12 @@ static const TypeInfo char_parallel_type_info =3D=
 {
=20
 #endif /* WIN32 */
=20
-static const CharDriver file_driver =3D {
-    .kind =3D CHARDEV_BACKEND_KIND_FILE,
-    .parse =3D qemu_chr_parse_file_out,
-};
-
 static void char_file_class_init(ObjectClass *oc, void *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
+    cc->kind =3D CHARDEV_BACKEND_KIND_FILE;
+    cc->parse =3D qemu_chr_parse_file_out;
     cc->open =3D qmp_chardev_open_file;
 }
=20
@@ -4732,16 +4737,12 @@ static const TypeInfo char_file_type_info =3D {
=20
 #ifdef HAVE_CHARDEV_SERIAL
=20
-static const CharDriver serial_driver =3D {
-    .kind =3D CHARDEV_BACKEND_KIND_SERIAL,
-    .alias =3D "tty",
-    .parse =3D qemu_chr_parse_serial,
-};
-
 static void char_serial_class_init(ObjectClass *oc, void *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
+    cc->kind =3D CHARDEV_BACKEND_KIND_SERIAL;
+    cc->parse =3D qemu_chr_parse_serial;
     cc->open =3D qmp_chardev_open_serial;
 #ifndef _WIN32
     cc->chr_ioctl =3D tty_serial_ioctl;
@@ -4894,15 +4895,12 @@ error:
     }
 }
=20
-static const CharDriver socket_driver =3D {
-    .kind =3D CHARDEV_BACKEND_KIND_SOCKET,
-    .parse =3D qemu_chr_parse_socket,
-};
-
 static void char_socket_class_init(ObjectClass *oc, void *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
+    cc->kind =3D CHARDEV_BACKEND_KIND_SOCKET;
+    cc->parse =3D qemu_chr_parse_socket;
     cc->open =3D qmp_chardev_open_socket;
     cc->chr_wait_connected =3D tcp_chr_wait_connected;
     cc->chr_write =3D tcp_chr_write;
@@ -4949,15 +4947,12 @@ static void qmp_chardev_open_udp(Chardev *chr,
     *be_opened =3D false;
 }
=20
-static const CharDriver udp_driver =3D {
-    .kind =3D CHARDEV_BACKEND_KIND_UDP,
-    .parse =3D qemu_chr_parse_udp,
-};
-
 static void char_udp_class_init(ObjectClass *oc, void *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
+    cc->kind =3D CHARDEV_BACKEND_KIND_UDP;
+    cc->parse =3D qemu_chr_parse_udp;
     cc->open =3D qmp_chardev_open_udp;
     cc->chr_write =3D udp_chr_write;
     cc->chr_update_read_handler =3D udp_chr_update_read_handler;
@@ -4983,35 +4978,6 @@ void qemu_chr_set_feature(Chardev *chr,
     return set_bit(feature, chr->features);
 }
=20
-static const ChardevClass *char_get_class(const char *driver, Error **er=
rp)
-{
-    ObjectClass *oc;
-    const ChardevClass *cc;
-    char *typename =3D g_strdup_printf("chardev-%s", driver);
-
-    oc =3D object_class_by_name(typename);
-    g_free(typename);
-
-    if (!object_class_dynamic_cast(oc, TYPE_CHARDEV)) {
-        error_setg(errp, "'%s' is not a valid char driver name", driver)=
;
-        return NULL;
-    }
-
-    if (object_class_is_abstract(oc)) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "driver",
-                   "abstract device type");
-        return NULL;
-    }
-
-    cc =3D CHARDEV_CLASS(oc);
-    if (cc->internal) {
-        error_setg(errp, "'%s' is not a valid char driver name", driver)=
;
-        return NULL;
-    }
-
-    return cc;
-}
-
 Chardev *qemu_chardev_new(const char *id, const char *typename,
                           ChardevBackend *backend, Error **errp)
 {
@@ -5107,45 +5073,34 @@ void qemu_chr_cleanup(void)
=20
 static void register_types(void)
 {
-    static const struct {
-        const CharDriver *driver;
-        const TypeInfo *type;
-    } chardevs[] =3D {
-        { &null_driver, &char_null_type_info },
-        { &socket_driver, &char_socket_type_info },
-        { &udp_driver, &char_udp_type_info },
-        { &ringbuf_driver, &char_ringbuf_type_info },
-        { &file_driver, &char_file_type_info },
-        { &stdio_driver, &char_stdio_type_info },
+    type_register_static(&char_type_info);
+#ifndef _WIN32
+    type_register_static(&char_fd_type_info);
+#else
+    type_register_static(&char_win_type_info);
+    type_register_static(&char_win_stdio_type_info);
+#endif
+    type_register_static(&char_null_type_info);
+    type_register_static(&char_socket_type_info);
+    type_register_static(&char_udp_type_info);
+    type_register_static(&char_ringbuf_type_info);
+    type_register_static(&char_file_type_info);
+    type_register_static(&char_stdio_type_info);
 #ifdef HAVE_CHARDEV_SERIAL
-        { &serial_driver, &char_serial_type_info },
+    type_register_static(&char_serial_type_info);
 #endif
 #ifdef HAVE_CHARDEV_PARPORT
-        { &parallel_driver, &char_parallel_type_info },
+    type_register_static(&char_parallel_type_info);
 #endif
 #ifdef HAVE_CHARDEV_PTY
-        { &pty_driver, &char_pty_type_info },
+    type_register_static(&char_pty_type_info);
 #endif
 #ifdef _WIN32
-        { &console_driver, &char_console_type_info },
+    type_register_static(&char_console_type_info);
 #endif
-        { &pipe_driver, &char_pipe_type_info },
-        { &mux_driver, &char_mux_type_info },
-        { &memory_driver, &char_memory_type_info }
-    };
-    int i;
-
-    type_register_static(&char_type_info);
-#ifndef _WIN32
-    type_register_static(&char_fd_type_info);
-#else
-    type_register_static(&char_win_type_info);
-    type_register_static(&char_win_stdio_type_info);
-#endif
-    for (i =3D 0; i < ARRAY_SIZE(chardevs); i++) {
-        type_register_static(chardevs[i].type);
-        register_char_driver(chardevs[i].driver);
-    }
+    type_register_static(&char_pipe_type_info);
+    type_register_static(&char_mux_type_info);
+    type_register_static(&char_memory_type_info);
=20
     /* this must be done after machine init, since we register FEs with =
muxes
      * as part of realize functions like serial_isa_realizefn when -nogr=
aphic
diff --git a/spice-qemu-char.c b/spice-qemu-char.c
index 3902202a35..17305830ab 100644
--- a/spice-qemu-char.c
+++ b/spice-qemu-char.c
@@ -380,6 +380,8 @@ static void char_spicevmc_class_init(ObjectClass *oc,=
 void *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
+    cc->kind =3D CHARDEV_BACKEND_KIND_SPICEVMC;
+    cc->parse =3D qemu_chr_parse_spice_vmc;
     cc->open =3D qemu_chr_open_spice_vmc;
     cc->chr_set_fe_open =3D spice_vmc_set_fe_open;
 }
@@ -394,6 +396,8 @@ static void char_spiceport_class_init(ObjectClass *oc=
, void *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
+    cc->kind =3D CHARDEV_BACKEND_KIND_SPICEPORT;
+    cc->parse =3D qemu_chr_parse_spice_port;
     cc->open =3D qemu_chr_open_spice_port;
     cc->chr_set_fe_open =3D spice_port_set_fe_open;
 }
@@ -406,17 +410,6 @@ static const TypeInfo char_spiceport_type_info =3D {
=20
 static void register_types(void)
 {
-    static const CharDriver vmc_driver =3D {
-        .kind =3D CHARDEV_BACKEND_KIND_SPICEVMC,
-        .parse =3D qemu_chr_parse_spice_vmc,
-    };
-    static const CharDriver port_driver =3D {
-        .kind =3D CHARDEV_BACKEND_KIND_SPICEPORT,
-        .parse =3D qemu_chr_parse_spice_port,
-    };
-    register_char_driver(&vmc_driver);
-    register_char_driver(&port_driver);
-
     type_register_static(&char_spice_type_info);
     type_register_static(&char_spicevmc_type_info);
     type_register_static(&char_spiceport_type_info);
diff --git a/ui/console.c b/ui/console.c
index fe03a666f7..84fcbd86fd 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -2059,8 +2059,6 @@ static void text_console_do_init(Chardev *chr, Disp=
layState *ds)
     qemu_chr_be_generic_open(chr);
 }
=20
-static const CharDriver vc_driver;
-
 static void vc_chr_open(Chardev *chr,
                         ChardevBackend *backend,
                         bool *be_opened,
@@ -2189,6 +2187,8 @@ static void char_vc_class_init(ObjectClass *oc, voi=
d *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
+    cc->kind =3D CHARDEV_BACKEND_KIND_VC;
+    cc->parse =3D qemu_chr_parse_vc;
     cc->open =3D vc_chr_open;
     cc->chr_write =3D vc_chr_write;
     cc->chr_set_echo =3D vc_chr_set_echo;
@@ -2206,15 +2206,9 @@ void qemu_console_early_init(void)
     /* set the default vc driver */
     if (!object_class_by_name(TYPE_CHARDEV_VC)) {
         type_register(&char_vc_type_info);
-        register_char_driver(&vc_driver);
     }
 }
=20
-static const CharDriver vc_driver =3D {
-    .kind =3D CHARDEV_BACKEND_KIND_VC,
-    .parse =3D qemu_chr_parse_vc,
-};
-
 static void register_types(void)
 {
     type_register_static(&qemu_console_info);
diff --git a/ui/gtk.c b/ui/gtk.c
index bdd831c268..f4542e3b86 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1715,8 +1715,6 @@ static void gd_vc_chr_set_echo(Chardev *chr, bool e=
cho)
=20
 static int nb_vcs;
 static Chardev *vcs[MAX_VCS];
-static const CharDriver gd_vc_driver;
-
 static void gd_vc_open(Chardev *chr,
                        ChardevBackend *backend,
                        bool *be_opened,
@@ -1739,6 +1737,8 @@ static void char_gd_vc_class_init(ObjectClass *oc, =
void *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
+    cc->kind =3D CHARDEV_BACKEND_KIND_VC;
+    cc->parse =3D qemu_chr_parse_vc;
     cc->open =3D gd_vc_open;
     cc->chr_write =3D gd_vc_chr_write;
     cc->chr_set_echo =3D gd_vc_chr_set_echo;
@@ -1751,11 +1751,6 @@ static const TypeInfo char_gd_vc_type_info =3D {
     .class_init =3D char_gd_vc_class_init,
 };
=20
-static const CharDriver gd_vc_driver =3D {
-    .kind =3D CHARDEV_BACKEND_KIND_VC,
-    .parse =3D qemu_chr_parse_vc,
-};
-
 static gboolean gd_vc_in(VteTerminal *terminal, gchar *text, guint size,
                          gpointer user_data)
 {
@@ -2353,6 +2348,5 @@ void early_gtk_display_init(int opengl)
=20
 #if defined(CONFIG_VTE)
     type_register(&char_gd_vc_type_info);
-    register_char_driver(&gd_vc_driver);
 #endif
 }
--=20
2.11.0
