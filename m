Received: from eggs.gnu.org ([2001:4830:134:3::10]:43562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGZLo-0004q1-Kj
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:45:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGZLm-0004JK-9A
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:45:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cGZLm-0004HO-1A
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:45:38 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E945B33C174
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 22:45:36 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Dec 2016 01:43:03 +0300
Message-Id: <20161212224325.20790-33-marcandre.lureau@redhat.com>
In-Reply-To: <20161212224325.20790-1-marcandre.lureau@redhat.com>
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 32/54] char: remove class kind field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The class kind is only necessary to lookup the chardev name in
qmp_chardev_add() after calling qemu_chr_new_from_opts(). However,
qemu_chr_new_from_opts() can be changed to use a non-qmp function using
the chardev class typename. Introduce qemu_chardev_add() to be called
from qemu_chr_new_from_opts() and remove the class chardev kind field.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 backends/baum.c       |  1 -
 backends/msmouse.c    |  1 -
 backends/testdev.c    |  1 -
 qemu-char.c           | 96 ++++++++++++++++++++++-----------------------=
------
 spice-qemu-char.c     |  2 --
 ui/console.c          |  1 -
 ui/gtk.c              |  1 -
 include/sysemu/char.h |  1 -
 8 files changed, 42 insertions(+), 62 deletions(-)

diff --git a/backends/baum.c b/backends/baum.c
index e4c4c53486..64dbeb1a5f 100644
--- a/backends/baum.c
+++ b/backends/baum.c
@@ -671,7 +671,6 @@ static void char_braille_class_init(ObjectClass *oc, =
void *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
-    cc->kind =3D CHARDEV_BACKEND_KIND_BRAILLE;
     cc->open =3D baum_chr_open;
     cc->chr_write =3D baum_chr_write;
     cc->chr_accept_input =3D baum_chr_accept_input;
diff --git a/backends/msmouse.c b/backends/msmouse.c
index 28689b3e29..d2c3162f1e 100644
--- a/backends/msmouse.c
+++ b/backends/msmouse.c
@@ -169,7 +169,6 @@ static void char_msmouse_class_init(ObjectClass *oc, =
void *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
-    cc->kind =3D CHARDEV_BACKEND_KIND_MSMOUSE;
     cc->open =3D msmouse_chr_open;
     cc->chr_write =3D msmouse_chr_write;
     cc->chr_accept_input =3D msmouse_chr_accept_input;
diff --git a/backends/testdev.c b/backends/testdev.c
index 243454aaa3..7df9248a13 100644
--- a/backends/testdev.c
+++ b/backends/testdev.c
@@ -111,7 +111,6 @@ static void char_testdev_class_init(ObjectClass *oc, =
void *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
-    cc->kind =3D CHARDEV_BACKEND_KIND_TESTDEV;
     cc->chr_write =3D testdev_chr_write;
 }
=20
diff --git a/qemu-char.c b/qemu-char.c
index 9a4028059e..4708b85c2e 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -566,7 +566,6 @@ static void char_null_class_init(ObjectClass *oc, voi=
d *data)
=20
     cc->open =3D null_chr_open;
     cc->chr_write =3D null_chr_write;
-    cc->kind =3D CHARDEV_BACKEND_KIND_NULL;
 }
=20
 static const TypeInfo char_null_type_info =3D {
@@ -1703,7 +1702,6 @@ static void char_pty_class_init(ObjectClass *oc, vo=
id *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
-    cc->kind =3D CHARDEV_BACKEND_KIND_PTY;
     cc->open =3D char_pty_open;
     cc->chr_write =3D char_pty_chr_write;
     cc->chr_update_read_handler =3D pty_chr_update_read_handler;
@@ -2453,7 +2451,6 @@ static void char_console_class_init(ObjectClass *oc=
, void *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
-    cc->kind =3D CHARDEV_BACKEND_KIND_CONSOLE;
     cc->open =3D qemu_chr_open_win_con;
 }
=20
@@ -3832,7 +3829,6 @@ static void char_stdio_class_init(ObjectClass *oc, =
void *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
-    cc->kind =3D CHARDEV_BACKEND_KIND_STDIO;
     cc->parse =3D qemu_chr_parse_stdio;
     cc->open =3D qemu_chr_open_stdio;
 #ifdef _WIN32
@@ -3907,7 +3903,6 @@ static void char_pipe_class_init(ObjectClass *oc, v=
oid *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
-    cc->kind =3D CHARDEV_BACKEND_KIND_PIPE;
     cc->parse =3D qemu_chr_parse_pipe;
     cc->open =3D qemu_chr_open_pipe;
 }
@@ -3942,7 +3937,6 @@ static void char_ringbuf_class_init(ObjectClass *oc=
, void *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
-    cc->kind =3D CHARDEV_BACKEND_KIND_RINGBUF;
     cc->parse =3D qemu_chr_parse_ringbuf;
     cc->open =3D qemu_chr_open_ringbuf;
     cc->chr_write =3D ringbuf_chr_write;
@@ -3957,17 +3951,9 @@ static const TypeInfo char_ringbuf_type_info =3D {
 };
=20
 /* Bug-compatibility: */
-static void char_memory_class_init(ObjectClass *oc, void *data)
-{
-    ChardevClass *cc =3D CHARDEV_CLASS(oc);
-
-    cc->kind =3D CHARDEV_BACKEND_KIND_MEMORY;
-}
-
 static const TypeInfo char_memory_type_info =3D {
     .name =3D TYPE_CHARDEV_MEMORY,
     .parent =3D TYPE_CHARDEV_RINGBUF,
-    .class_init =3D char_memory_class_init,
 };
=20
 static void qemu_chr_parse_mux(QemuOpts *opts, ChardevBackend *backend,
@@ -3989,7 +3975,6 @@ static void char_mux_class_init(ObjectClass *oc, vo=
id *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
-    cc->kind =3D CHARDEV_BACKEND_KIND_MUX;
     cc->parse =3D qemu_chr_parse_mux;
     cc->open =3D qemu_chr_open_mux;
     cc->chr_write =3D mux_chr_write;
@@ -4161,6 +4146,26 @@ static const ChardevClass *char_get_class(const ch=
ar *driver, Error **errp)
     return cc;
 }
=20
+static Chardev *qemu_chardev_add(const char *id, const char *typename,
+                                 ChardevBackend *backend, Error **errp)
+{
+    Chardev *chr;
+
+    chr =3D qemu_chr_find(id);
+    if (chr) {
+        error_setg(errp, "Chardev '%s' already exists", id);
+        return NULL;
+    }
+
+    chr =3D qemu_chardev_new(id, typename, backend, errp);
+    if (!chr) {
+        return NULL;
+    }
+
+    QTAILQ_INSERT_TAIL(&chardevs, chr, next);
+    return chr;
+}
+
 static const struct ChardevAlias {
     const char *typename;
     const char *alias;
@@ -4180,8 +4185,7 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
     const ChardevClass *cc;
     Chardev *chr;
     int i;
-    ChardevReturn *ret =3D NULL;
-    ChardevBackend *backend;
+    ChardevBackend *backend =3D NULL;
     const char *id =3D qemu_opts_id(opts);
     const char *bname =3D qemu_opt_get(opts, "backend");
     char *bid =3D NULL;
@@ -4189,7 +4193,7 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
     if (bname =3D=3D NULL) {
         error_setg(errp, "chardev: \"%s\" missing backend",
                    qemu_opts_id(opts));
-        goto err;
+        return NULL;
     }
=20
     if (is_help_option(bname)) {
@@ -4208,7 +4212,7 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
=20
     if (id =3D=3D NULL) {
         error_setg(errp, "chardev: no id specified");
-        goto err;
+        return NULL;
     }
=20
     for (i =3D 0; i < ARRAY_SIZE(chardev_alias_table); i++) {
@@ -4220,22 +4224,22 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
=20
     cc =3D char_get_class(bname, errp);
     if (cc =3D=3D NULL) {
-        goto err;
+        return NULL;
     }
=20
     backend =3D g_new0(ChardevBackend, 1);
+    backend->type =3D CHARDEV_BACKEND_KIND_NULL;
=20
     if (qemu_opt_get_bool(opts, "mux", 0)) {
         bid =3D g_strdup_printf("%s-base", id);
     }
=20
     chr =3D NULL;
-    backend->type =3D cc->kind;
     if (cc->parse) {
         cc->parse(opts, backend, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
-            goto qapi_out;
+            goto out;
         }
     } else {
         ChardevCommon *ccom =3D g_new0(ChardevCommon, 1);
@@ -4243,37 +4247,33 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
         backend->u.null.data =3D ccom; /* Any ChardevCommon member would=
 work */
     }
=20
-    ret =3D qmp_chardev_add(bid ? bid : id, backend, errp);
-    if (!ret) {
-        goto qapi_out;
+    chr =3D qemu_chardev_add(bid ? bid : id,
+                           object_class_get_name(OBJECT_CLASS(cc)),
+                           backend, errp);
+    if (chr =3D=3D NULL) {
+        goto out;
     }
=20
     if (bid) {
+        Chardev *mux;
         qapi_free_ChardevBackend(backend);
-        qapi_free_ChardevReturn(ret);
         backend =3D g_new0(ChardevBackend, 1);
-        backend->u.mux.data =3D g_new0(ChardevMux, 1);
         backend->type =3D CHARDEV_BACKEND_KIND_MUX;
+        backend->u.mux.data =3D g_new0(ChardevMux, 1);
         backend->u.mux.data->chardev =3D g_strdup(bid);
-        ret =3D qmp_chardev_add(id, backend, errp);
-        if (!ret) {
-            chr =3D qemu_chr_find(bid);
+        mux =3D qemu_chardev_add(id, TYPE_CHARDEV_MUX, backend, errp);
+        if (mux =3D=3D NULL) {
             qemu_chr_delete(chr);
             chr =3D NULL;
-            goto qapi_out;
+            goto out;
         }
+        chr =3D mux;
     }
=20
-    chr =3D qemu_chr_find(id);
-
-qapi_out:
+out:
     qapi_free_ChardevBackend(backend);
-    qapi_free_ChardevReturn(ret);
     g_free(bid);
     return chr;
-
-err:
-    return NULL;
 }
=20
 Chardev *qemu_chr_new_noreplay(const char *label, const char *filename)
@@ -4678,7 +4678,6 @@ static void char_parallel_class_init(ObjectClass *o=
c, void *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
-    cc->kind =3D CHARDEV_BACKEND_KIND_PARALLEL;
     cc->parse =3D qemu_chr_parse_parallel;
     cc->open =3D qmp_chardev_open_parallel;
 #if defined(__linux__)
@@ -4721,7 +4720,6 @@ static void char_file_class_init(ObjectClass *oc, v=
oid *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
-    cc->kind =3D CHARDEV_BACKEND_KIND_FILE;
     cc->parse =3D qemu_chr_parse_file_out;
     cc->open =3D qmp_chardev_open_file;
 }
@@ -4742,7 +4740,6 @@ static void char_serial_class_init(ObjectClass *oc,=
 void *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
-    cc->kind =3D CHARDEV_BACKEND_KIND_SERIAL;
     cc->parse =3D qemu_chr_parse_serial;
     cc->open =3D qmp_chardev_open_serial;
 #ifndef _WIN32
@@ -4903,7 +4900,6 @@ static void char_socket_class_init(ObjectClass *oc,=
 void *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
-    cc->kind =3D CHARDEV_BACKEND_KIND_SOCKET;
     cc->parse =3D qemu_chr_parse_socket;
     cc->open =3D qmp_chardev_open_socket;
     cc->chr_wait_connected =3D tcp_chr_wait_connected;
@@ -4957,7 +4953,6 @@ static void char_udp_class_init(ObjectClass *oc, vo=
id *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
-    cc->kind =3D CHARDEV_BACKEND_KIND_UDP;
     cc->parse =3D qemu_chr_parse_udp;
     cc->open =3D qmp_chardev_open_udp;
     cc->chr_write =3D udp_chr_write;
@@ -5016,24 +5011,18 @@ Chardev *qemu_chardev_new(const char *id, const c=
har *typename,
 ChardevReturn *qmp_chardev_add(const char *id, ChardevBackend *backend,
                                Error **errp)
 {
-    const ChardevClass *cc;
     ChardevReturn *ret;
+    const ChardevClass *cc;
     Chardev *chr;
=20
-    chr =3D qemu_chr_find(id);
-    if (chr) {
-        error_setg(errp, "Chardev '%s' already exists", id);
-        return NULL;
-    }
-
     cc =3D char_get_class(ChardevBackendKind_lookup[backend->type], errp=
);
-    if (!cc) {
+    if (cc =3D=3D NULL) {
         return NULL;
     }
=20
-    chr =3D qemu_chardev_new(id, object_class_get_name(OBJECT_CLASS(cc))=
,
+    chr =3D qemu_chardev_add(id, object_class_get_name(OBJECT_CLASS(cc))=
,
                            backend, errp);
-    if (!chr) {
+    if (chr =3D=3D NULL) {
         return NULL;
     }
=20
@@ -5043,7 +5032,6 @@ ChardevReturn *qmp_chardev_add(const char *id, Char=
devBackend *backend,
         ret->has_pty =3D true;
     }
=20
-    QTAILQ_INSERT_TAIL(&chardevs, chr, next);
     return ret;
 }
=20
diff --git a/spice-qemu-char.c b/spice-qemu-char.c
index 298a951681..dbc81ba4f6 100644
--- a/spice-qemu-char.c
+++ b/spice-qemu-char.c
@@ -379,7 +379,6 @@ static void char_spicevmc_class_init(ObjectClass *oc,=
 void *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
-    cc->kind =3D CHARDEV_BACKEND_KIND_SPICEVMC;
     cc->parse =3D qemu_chr_parse_spice_vmc;
     cc->open =3D qemu_chr_open_spice_vmc;
     cc->chr_set_fe_open =3D spice_vmc_set_fe_open;
@@ -395,7 +394,6 @@ static void char_spiceport_class_init(ObjectClass *oc=
, void *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
-    cc->kind =3D CHARDEV_BACKEND_KIND_SPICEPORT;
     cc->parse =3D qemu_chr_parse_spice_port;
     cc->open =3D qemu_chr_open_spice_port;
     cc->chr_set_fe_open =3D spice_port_set_fe_open;
diff --git a/ui/console.c b/ui/console.c
index 712fa1aec1..1b66868a08 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -2176,7 +2176,6 @@ static void char_vc_class_init(ObjectClass *oc, voi=
d *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
-    cc->kind =3D CHARDEV_BACKEND_KIND_VC;
     cc->parse =3D qemu_chr_parse_vc;
     cc->open =3D vc_open;
     cc->chr_write =3D vc_chr_write;
diff --git a/ui/gtk.c b/ui/gtk.c
index aa3412d09c..8aa8edbf40 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1727,7 +1727,6 @@ static void char_gd_vc_class_init(ObjectClass *oc, =
void *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
-    cc->kind =3D CHARDEV_BACKEND_KIND_VC;
     cc->parse =3D qemu_chr_parse_vc;
     cc->open =3D gd_vc_open;
     cc->chr_write =3D gd_vc_chr_write;
diff --git a/include/sysemu/char.h b/include/sysemu/char.h
index 203e8e84e3..297add973c 100644
--- a/include/sysemu/char.h
+++ b/include/sysemu/char.h
@@ -472,7 +472,6 @@ typedef struct ChardevClass {
     ObjectClass parent_class;
=20
     bool internal; /* TODO: eventually use TYPE_USER_CREATABLE */
-    ChardevBackendKind kind;
     void (*parse)(QemuOpts *opts, ChardevBackend *backend, Error **errp)=
;
=20
     void (*open)(Chardev *chr, ChardevBackend *backend,
--=20
2.11.0
