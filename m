Received: from eggs.gnu.org ([2001:4830:134:3::10]:45840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYbCh-0000eD-Ea
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:22:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYbCf-000171-Ja
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:22:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cYbCf-00016u-6S
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:22:45 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 31 Jan 2017 20:21:00 +0400
Message-Id: <20170131162122.29408-20-marcandre.lureau@redhat.com>
In-Reply-To: <20170131162122.29408-1-marcandre.lureau@redhat.com>
References: <20170131162122.29408-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 19/41] char: remove class kind field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The class kind is necessary to lookup the chardev name in
qmp_chardev_add() after calling qemu_chr_new_from_opts() and to set
the appropriate ChardevBackend (mainly to free the right
fields).

qemu_chr_new_from_opts() can be changed to use a non-qmp function
using the chardev class typename. Introduce qemu_chardev_add() to be
called from qemu_chr_new_from_opts() and remove the class chardev kind
field. Set the backend->type in the parse callback (when non-common
fields are added).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/sysemu/char.h |  1 -
 backends/baum.c       |  1 -
 backends/msmouse.c    |  1 -
 backends/testdev.c    |  1 -
 qemu-char.c           | 99 +++++++++++++++++++++++++--------------------=
------
 spice-qemu-char.c     |  4 +--
 ui/console.c          |  2 +-
 ui/gtk.c              |  1 -
 8 files changed, 51 insertions(+), 59 deletions(-)

diff --git a/include/sysemu/char.h b/include/sysemu/char.h
index b4303e7b22..31229deaca 100644
--- a/include/sysemu/char.h
+++ b/include/sysemu/char.h
@@ -474,7 +474,6 @@ typedef struct ChardevClass {
     ObjectClass parent_class;
=20
     bool internal; /* TODO: eventually use TYPE_USER_CREATABLE */
-    ChardevBackendKind kind;
     void (*parse)(QemuOpts *opts, ChardevBackend *backend, Error **errp)=
;
=20
     void (*open)(Chardev *chr, ChardevBackend *backend,
diff --git a/backends/baum.c b/backends/baum.c
index 5316c8da0a..2eddcae119 100644
--- a/backends/baum.c
+++ b/backends/baum.c
@@ -656,7 +656,6 @@ static void char_braille_class_init(ObjectClass *oc, =
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
index b68d4a9059..15f4a853bc 100644
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
@@ -1708,7 +1707,6 @@ static void char_pty_class_init(ObjectClass *oc, vo=
id *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
-    cc->kind =3D CHARDEV_BACKEND_KIND_PTY;
     cc->open =3D char_pty_open;
     cc->chr_write =3D char_pty_chr_write;
     cc->chr_update_read_handler =3D pty_chr_update_read_handler;
@@ -2455,7 +2453,6 @@ static void char_console_class_init(ObjectClass *oc=
, void *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
-    cc->kind =3D CHARDEV_BACKEND_KIND_CONSOLE;
     cc->open =3D qemu_chr_open_win_con;
 }
=20
@@ -3808,6 +3805,7 @@ static void qemu_chr_parse_file_out(QemuOpts *opts,=
 ChardevBackend *backend,
     const char *path =3D qemu_opt_get(opts, "path");
     ChardevFile *file;
=20
+    backend->type =3D CHARDEV_BACKEND_KIND_FILE;
     if (path =3D=3D NULL) {
         error_setg(errp, "chardev: file: no filename given");
         return;
@@ -3825,6 +3823,7 @@ static void qemu_chr_parse_stdio(QemuOpts *opts, Ch=
ardevBackend *backend,
 {
     ChardevStdio *stdio;
=20
+    backend->type =3D CHARDEV_BACKEND_KIND_STDIO;
     stdio =3D backend->u.stdio.data =3D g_new0(ChardevStdio, 1);
     qemu_chr_parse_common(opts, qapi_ChardevStdio_base(stdio));
     stdio->has_signal =3D true;
@@ -3835,7 +3834,6 @@ static void char_stdio_class_init(ObjectClass *oc, =
void *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
-    cc->kind =3D CHARDEV_BACKEND_KIND_STDIO;
     cc->parse =3D qemu_chr_parse_stdio;
     cc->open =3D qemu_chr_open_stdio;
 #ifdef _WIN32
@@ -3864,6 +3862,7 @@ static void qemu_chr_parse_serial(QemuOpts *opts, C=
hardevBackend *backend,
     const char *device =3D qemu_opt_get(opts, "path");
     ChardevHostdev *serial;
=20
+    backend->type =3D CHARDEV_BACKEND_KIND_SERIAL;
     if (device =3D=3D NULL) {
         error_setg(errp, "chardev: serial/tty: no device path given");
         return;
@@ -3881,6 +3880,7 @@ static void qemu_chr_parse_parallel(QemuOpts *opts,=
 ChardevBackend *backend,
     const char *device =3D qemu_opt_get(opts, "path");
     ChardevHostdev *parallel;
=20
+    backend->type =3D CHARDEV_BACKEND_KIND_PARALLEL;
     if (device =3D=3D NULL) {
         error_setg(errp, "chardev: parallel: no device path given");
         return;
@@ -3897,6 +3897,7 @@ static void qemu_chr_parse_pipe(QemuOpts *opts, Cha=
rdevBackend *backend,
     const char *device =3D qemu_opt_get(opts, "path");
     ChardevHostdev *dev;
=20
+    backend->type =3D CHARDEV_BACKEND_KIND_PIPE;
     if (device =3D=3D NULL) {
         error_setg(errp, "chardev: pipe: no device path given");
         return;
@@ -3910,7 +3911,6 @@ static void char_pipe_class_init(ObjectClass *oc, v=
oid *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
-    cc->kind =3D CHARDEV_BACKEND_KIND_PIPE;
     cc->parse =3D qemu_chr_parse_pipe;
     cc->open =3D qemu_chr_open_pipe;
 }
@@ -3931,6 +3931,7 @@ static void qemu_chr_parse_ringbuf(QemuOpts *opts, =
ChardevBackend *backend,
     int val;
     ChardevRingbuf *ringbuf;
=20
+    backend->type =3D CHARDEV_BACKEND_KIND_RINGBUF;
     ringbuf =3D backend->u.ringbuf.data =3D g_new0(ChardevRingbuf, 1);
     qemu_chr_parse_common(opts, qapi_ChardevRingbuf_base(ringbuf));
=20
@@ -3945,7 +3946,6 @@ static void char_ringbuf_class_init(ObjectClass *oc=
, void *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
-    cc->kind =3D CHARDEV_BACKEND_KIND_RINGBUF;
     cc->parse =3D qemu_chr_parse_ringbuf;
     cc->open =3D qemu_chr_open_ringbuf;
     cc->chr_write =3D ringbuf_chr_write;
@@ -3960,17 +3960,9 @@ static const TypeInfo char_ringbuf_type_info =3D {
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
@@ -3979,6 +3971,7 @@ static void qemu_chr_parse_mux(QemuOpts *opts, Char=
devBackend *backend,
     const char *chardev =3D qemu_opt_get(opts, "chardev");
     ChardevMux *mux;
=20
+    backend->type =3D CHARDEV_BACKEND_KIND_MUX;
     if (chardev =3D=3D NULL) {
         error_setg(errp, "chardev: mux: no chardev given");
         return;
@@ -3992,7 +3985,6 @@ static void char_mux_class_init(ObjectClass *oc, vo=
id *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
-    cc->kind =3D CHARDEV_BACKEND_KIND_MUX;
     cc->parse =3D qemu_chr_parse_mux;
     cc->open =3D qemu_chr_open_mux;
     cc->chr_write =3D mux_chr_write;
@@ -4023,6 +4015,7 @@ static void qemu_chr_parse_socket(QemuOpts *opts, C=
hardevBackend *backend,
     SocketAddress *addr;
     ChardevSocket *sock;
=20
+    backend->type =3D CHARDEV_BACKEND_KIND_SOCKET;
     if (!path) {
         if (!host) {
             error_setg(errp, "chardev: socket: no host given");
@@ -4088,6 +4081,7 @@ static void qemu_chr_parse_udp(QemuOpts *opts, Char=
devBackend *backend,
     SocketAddress *addr;
     ChardevUdp *udp;
=20
+    backend->type =3D CHARDEV_BACKEND_KIND_UDP;
     if (host =3D=3D NULL || strlen(host) =3D=3D 0) {
         host =3D "localhost";
     }
@@ -4164,6 +4158,26 @@ static const ChardevClass *char_get_class(const ch=
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
@@ -4222,8 +4236,7 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
     const ChardevClass *cc;
     Chardev *chr;
     int i;
-    ChardevReturn *ret =3D NULL;
-    ChardevBackend *backend;
+    ChardevBackend *backend =3D NULL;
     const char *name =3D qemu_opt_get(opts, "backend");
     const char *id =3D qemu_opts_id(opts);
     char *bid =3D NULL;
@@ -4231,7 +4244,7 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
     if (name =3D=3D NULL) {
         error_setg(errp, "chardev: \"%s\" missing backend",
                    qemu_opts_id(opts));
-        goto err;
+        return NULL;
     }
=20
     if (is_help_option(name)) {
@@ -4246,7 +4259,7 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
=20
     if (id =3D=3D NULL) {
         error_setg(errp, "chardev: no id specified");
-        goto err;
+        return NULL;
     }
=20
     for (i =3D 0; i < ARRAY_SIZE(chardev_alias_table); i++) {
@@ -4258,22 +4271,22 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
=20
     cc =3D char_get_class(name, errp);
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
@@ -4281,37 +4294,33 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
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
@@ -4700,7 +4709,6 @@ static void char_parallel_class_init(ObjectClass *o=
c, void *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
-    cc->kind =3D CHARDEV_BACKEND_KIND_PARALLEL;
     cc->parse =3D qemu_chr_parse_parallel;
     cc->open =3D qmp_chardev_open_parallel;
 #if defined(__linux__)
@@ -4743,7 +4751,6 @@ static void char_file_class_init(ObjectClass *oc, v=
oid *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
-    cc->kind =3D CHARDEV_BACKEND_KIND_FILE;
     cc->parse =3D qemu_chr_parse_file_out;
     cc->open =3D qmp_chardev_open_file;
 }
@@ -4764,7 +4771,6 @@ static void char_serial_class_init(ObjectClass *oc,=
 void *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
-    cc->kind =3D CHARDEV_BACKEND_KIND_SERIAL;
     cc->parse =3D qemu_chr_parse_serial;
     cc->open =3D qmp_chardev_open_serial;
 #ifndef _WIN32
@@ -4922,7 +4928,6 @@ static void char_socket_class_init(ObjectClass *oc,=
 void *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
-    cc->kind =3D CHARDEV_BACKEND_KIND_SOCKET;
     cc->parse =3D qemu_chr_parse_socket;
     cc->open =3D qmp_chardev_open_socket;
     cc->chr_wait_connected =3D tcp_chr_wait_connected;
@@ -4974,7 +4979,6 @@ static void char_udp_class_init(ObjectClass *oc, vo=
id *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
-    cc->kind =3D CHARDEV_BACKEND_KIND_UDP;
     cc->parse =3D qemu_chr_parse_udp;
     cc->open =3D qmp_chardev_open_udp;
     cc->chr_write =3D udp_chr_write;
@@ -5037,18 +5041,12 @@ ChardevReturn *qmp_chardev_add(const char *id, Ch=
ardevBackend *backend,
     ChardevReturn *ret;
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
     if (!cc) {
         return NULL;
     }
=20
-    chr =3D qemu_chardev_new(id, object_class_get_name(OBJECT_CLASS(cc))=
,
+    chr =3D qemu_chardev_add(id, object_class_get_name(OBJECT_CLASS(cc))=
,
                            backend, errp);
     if (!chr) {
         return NULL;
@@ -5060,7 +5058,6 @@ ChardevReturn *qmp_chardev_add(const char *id, Char=
devBackend *backend,
         ret->has_pty =3D true;
     }
=20
-    QTAILQ_INSERT_TAIL(&chardevs, chr, next);
     return ret;
 }
=20
diff --git a/spice-qemu-char.c b/spice-qemu-char.c
index 17305830ab..adfa55b55c 100644
--- a/spice-qemu-char.c
+++ b/spice-qemu-char.c
@@ -338,6 +338,7 @@ static void qemu_chr_parse_spice_vmc(QemuOpts *opts, =
ChardevBackend *backend,
         error_setg(errp, "chardev: spice channel: no name given");
         return;
     }
+    backend->type =3D CHARDEV_BACKEND_KIND_SPICEVMC;
     spicevmc =3D backend->u.spicevmc.data =3D g_new0(ChardevSpiceChannel=
, 1);
     qemu_chr_parse_common(opts, qapi_ChardevSpiceChannel_base(spicevmc))=
;
     spicevmc->type =3D g_strdup(name);
@@ -353,6 +354,7 @@ static void qemu_chr_parse_spice_port(QemuOpts *opts,=
 ChardevBackend *backend,
         error_setg(errp, "chardev: spice port: no name given");
         return;
     }
+    backend->type =3D CHARDEV_BACKEND_KIND_SPICEPORT;
     spiceport =3D backend->u.spiceport.data =3D g_new0(ChardevSpicePort,=
 1);
     qemu_chr_parse_common(opts, qapi_ChardevSpicePort_base(spiceport));
     spiceport->fqdn =3D g_strdup(name);
@@ -380,7 +382,6 @@ static void char_spicevmc_class_init(ObjectClass *oc,=
 void *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
-    cc->kind =3D CHARDEV_BACKEND_KIND_SPICEVMC;
     cc->parse =3D qemu_chr_parse_spice_vmc;
     cc->open =3D qemu_chr_open_spice_vmc;
     cc->chr_set_fe_open =3D spice_vmc_set_fe_open;
@@ -396,7 +397,6 @@ static void char_spiceport_class_init(ObjectClass *oc=
, void *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
-    cc->kind =3D CHARDEV_BACKEND_KIND_SPICEPORT;
     cc->parse =3D qemu_chr_parse_spice_port;
     cc->open =3D qemu_chr_open_spice_port;
     cc->chr_set_fe_open =3D spice_port_set_fe_open;
diff --git a/ui/console.c b/ui/console.c
index 84fcbd86fd..8c93f2a1e8 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -2148,6 +2148,7 @@ void qemu_chr_parse_vc(QemuOpts *opts, ChardevBacke=
nd *backend, Error **errp)
     int val;
     ChardevVC *vc;
=20
+    backend->type =3D CHARDEV_BACKEND_KIND_VC;
     vc =3D backend->u.vc.data =3D g_new0(ChardevVC, 1);
     qemu_chr_parse_common(opts, qapi_ChardevVC_base(vc));
=20
@@ -2187,7 +2188,6 @@ static void char_vc_class_init(ObjectClass *oc, voi=
d *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
-    cc->kind =3D CHARDEV_BACKEND_KIND_VC;
     cc->parse =3D qemu_chr_parse_vc;
     cc->open =3D vc_chr_open;
     cc->chr_write =3D vc_chr_write;
diff --git a/ui/gtk.c b/ui/gtk.c
index f4542e3b86..4984bf3bd9 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1737,7 +1737,6 @@ static void char_gd_vc_class_init(ObjectClass *oc, =
void *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
-    cc->kind =3D CHARDEV_BACKEND_KIND_VC;
     cc->parse =3D qemu_chr_parse_vc;
     cc->open =3D gd_vc_open;
     cc->chr_write =3D gd_vc_chr_write;
--=20
2.11.0.295.gd7dffce1c.dirty
