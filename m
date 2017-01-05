Received: from eggs.gnu.org ([2001:4830:134:3::10]:53527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cPBIO-0007H6-DB
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:53:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cPBIL-0002iV-8l
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:53:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cPBIL-0002i8-01
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:53:41 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1F06C63E01
	for <qemu-devel@nongnu.org>; Thu,  5 Jan 2017 16:53:41 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  5 Jan 2017 17:53:14 +0100
Message-Id: <20170105165329.17227-6-marcandre.lureau@redhat.com>
In-Reply-To: <20170105165329.17227-1-marcandre.lureau@redhat.com>
References: <20170105165329.17227-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 05/20] char: use a const CharDriver
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

No need to allocate & copy fields, let's use static const struct
instead.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/sysemu/char.h |  19 +++----
 backends/baum.c       |   8 ++-
 backends/msmouse.c    |   7 ++-
 backends/testdev.c    |   7 ++-
 qemu-char.c           | 141 +++++++++++++++++++++++++++++++-------------=
------
 spice-qemu-char.c     |  16 ++++--
 ui/console.c          |  10 ++--
 7 files changed, 134 insertions(+), 74 deletions(-)

diff --git a/include/sysemu/char.h b/include/sysemu/char.h
index b6e361860a..c05a896578 100644
--- a/include/sysemu/char.h
+++ b/include/sysemu/char.h
@@ -475,15 +475,16 @@ void qemu_chr_set_feature(CharDriverState *chr,
                           CharDriverFeature feature);
 QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename)=
;
=20
-typedef void CharDriverParse(QemuOpts *opts, ChardevBackend *backend,
-                             Error **errp);
-typedef CharDriverState *CharDriverCreate(const char *id,
-                                          ChardevBackend *backend,
-                                          ChardevReturn *ret, bool *be_o=
pened,
-                                          Error **errp);
-
-void register_char_driver(const char *name, ChardevBackendKind kind,
-                          CharDriverParse *parse, CharDriverCreate *crea=
te);
+typedef struct CharDriver {
+    ChardevBackendKind kind;
+    void (*parse)(QemuOpts *opts, ChardevBackend *backend, Error **errp)=
;
+    CharDriverState *(*create)(const char *id,
+                               ChardevBackend *backend,
+                               ChardevReturn *ret, bool *be_opened,
+                               Error **errp);
+} CharDriver;
+
+void register_char_driver(const CharDriver *driver);
=20
 extern int term_escape_char;
=20
diff --git a/backends/baum.c b/backends/baum.c
index b045ef49c5..2e404a11cc 100644
--- a/backends/baum.c
+++ b/backends/baum.c
@@ -671,8 +671,12 @@ fail_handle:
=20
 static void register_types(void)
 {
-    register_char_driver("braille", CHARDEV_BACKEND_KIND_BRAILLE, NULL,
-                         chr_baum_init);
+    static const CharDriver driver =3D {
+        .kind =3D CHARDEV_BACKEND_KIND_BRAILLE,
+        .create =3D chr_baum_init,
+    };
+
+    register_char_driver(&driver);
 }
=20
 type_init(register_types);
diff --git a/backends/msmouse.c b/backends/msmouse.c
index 733ca80f48..2490b2c073 100644
--- a/backends/msmouse.c
+++ b/backends/msmouse.c
@@ -179,8 +179,11 @@ static CharDriverState *qemu_chr_open_msmouse(const =
char *id,
=20
 static void register_types(void)
 {
-    register_char_driver("msmouse", CHARDEV_BACKEND_KIND_MSMOUSE, NULL,
-                         qemu_chr_open_msmouse);
+    static const CharDriver driver =3D {
+        .kind =3D CHARDEV_BACKEND_KIND_MSMOUSE,
+        .create =3D qemu_chr_open_msmouse,
+    };
+    register_char_driver(&driver);
 }
=20
 type_init(register_types);
diff --git a/backends/testdev.c b/backends/testdev.c
index 60156e320e..cd25094f86 100644
--- a/backends/testdev.c
+++ b/backends/testdev.c
@@ -130,8 +130,11 @@ static CharDriverState *chr_testdev_init(const char =
*id,
=20
 static void register_types(void)
 {
-    register_char_driver("testdev", CHARDEV_BACKEND_KIND_TESTDEV, NULL,
-                         chr_testdev_init);
+    static const CharDriver driver =3D {
+        .kind =3D CHARDEV_BACKEND_KIND_TESTDEV,
+        .create =3D chr_testdev_init,
+    };
+    register_char_driver(&driver);
 }
=20
 type_init(register_types);
diff --git a/qemu-char.c b/qemu-char.c
index 2c9940cea4..14ab28766c 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -4094,27 +4094,12 @@ static void qemu_chr_parse_udp(QemuOpts *opts, Ch=
ardevBackend *backend,
     }
 }
=20
-typedef struct CharDriver {
-    const char *name;
-    ChardevBackendKind kind;
-    CharDriverParse *parse;
-    CharDriverCreate *create;
-} CharDriver;
-
 static GSList *backends;
=20
-void register_char_driver(const char *name, ChardevBackendKind kind,
-                          CharDriverParse *parse, CharDriverCreate *crea=
te)
+void register_char_driver(const CharDriver *driver)
 {
-    CharDriver *s;
-
-    s =3D g_malloc0(sizeof(*s));
-    s->name =3D g_strdup(name);
-    s->kind =3D kind;
-    s->parse =3D parse;
-    s->create =3D create;
-
-    backends =3D g_slist_append(backends, s);
+    /* casting away const */
+    backends =3D g_slist_append(backends, (void *)driver);
 }
=20
 CharDriverState *qemu_chr_new_from_opts(QemuOpts *opts,
@@ -4139,7 +4124,7 @@ CharDriverState *qemu_chr_new_from_opts(QemuOpts *o=
pts,
         fprintf(stderr, "Available chardev backend types:\n");
         for (i =3D backends; i; i =3D i->next) {
             cd =3D i->data;
-            fprintf(stderr, "%s\n", cd->name);
+            fprintf(stderr, "%s\n", ChardevBackendKind_lookup[cd->kind])=
;
         }
         exit(!is_help_option(qemu_opt_get(opts, "backend")));
     }
@@ -4152,7 +4137,8 @@ CharDriverState *qemu_chr_new_from_opts(QemuOpts *o=
pts,
     for (i =3D backends; i; i =3D i->next) {
         cd =3D i->data;
=20
-        if (strcmp(cd->name, qemu_opt_get(opts, "backend")) =3D=3D 0) {
+        if (strcmp(ChardevBackendKind_lookup[cd->kind],
+                   qemu_opt_get(opts, "backend")) =3D=3D 0) {
             break;
         }
     }
@@ -4371,7 +4357,7 @@ ChardevBackendInfoList *qmp_query_chardev_backends(=
Error **errp)
         ChardevBackendInfoList *info =3D g_malloc0(sizeof(*info));
         c =3D i->data;
         info->value =3D g_malloc0(sizeof(*info->value));
-        info->value->name =3D g_strdup(c->name);
+        info->value->name =3D g_strdup(ChardevBackendKind_lookup[c->kind=
]);
=20
         info->next =3D backend_list;
         backend_list =3D info;
@@ -4907,45 +4893,96 @@ void qemu_chr_cleanup(void)
=20
 static void register_types(void)
 {
-    register_char_driver("null", CHARDEV_BACKEND_KIND_NULL, NULL,
-                         qemu_chr_open_null);
-    register_char_driver("socket", CHARDEV_BACKEND_KIND_SOCKET,
-                         qemu_chr_parse_socket, qmp_chardev_open_socket)=
;
-    register_char_driver("udp", CHARDEV_BACKEND_KIND_UDP, qemu_chr_parse=
_udp,
-                         qmp_chardev_open_udp);
-    register_char_driver("ringbuf", CHARDEV_BACKEND_KIND_RINGBUF,
-                         qemu_chr_parse_ringbuf, qemu_chr_open_ringbuf);
-    register_char_driver("file", CHARDEV_BACKEND_KIND_FILE,
-                         qemu_chr_parse_file_out, qmp_chardev_open_file)=
;
-    register_char_driver("stdio", CHARDEV_BACKEND_KIND_STDIO,
-                         qemu_chr_parse_stdio, qemu_chr_open_stdio);
+    int i;
+    static const CharDriver drivers[] =3D {
+        {
+            .kind =3D CHARDEV_BACKEND_KIND_NULL,
+            .create =3D qemu_chr_open_null,
+        },
+        {
+            .kind =3D CHARDEV_BACKEND_KIND_SOCKET,
+            .parse =3D qemu_chr_parse_socket,
+            .create =3D qmp_chardev_open_socket,
+        },
+        {
+            .kind =3D CHARDEV_BACKEND_KIND_UDP,
+            .parse =3D qemu_chr_parse_udp,
+            .create =3D qmp_chardev_open_udp,
+        },
+        {
+            .kind =3D CHARDEV_BACKEND_KIND_RINGBUF,
+            .parse =3D qemu_chr_parse_ringbuf,
+            .create =3D qemu_chr_open_ringbuf,
+        },
+        {
+            .kind =3D CHARDEV_BACKEND_KIND_FILE,
+            .parse =3D qemu_chr_parse_file_out,
+            .create =3D qmp_chardev_open_file,
+        },
+        {
+            .kind =3D CHARDEV_BACKEND_KIND_STDIO,
+            .parse =3D qemu_chr_parse_stdio,
+            .create =3D qemu_chr_open_stdio,
+        },
 #if defined HAVE_CHARDEV_SERIAL
-    register_char_driver("serial", CHARDEV_BACKEND_KIND_SERIAL,
-                         qemu_chr_parse_serial, qmp_chardev_open_serial)=
;
-    register_char_driver("tty", CHARDEV_BACKEND_KIND_SERIAL,
-                         qemu_chr_parse_serial, qmp_chardev_open_serial)=
;
+        {
+            .kind =3D CHARDEV_BACKEND_KIND_SERIAL,
+            .parse =3D qemu_chr_parse_serial,
+            .create =3D qmp_chardev_open_serial,
+        },
+        {
+            .kind =3D CHARDEV_BACKEND_KIND_SERIAL,
+            .parse =3D qemu_chr_parse_serial,
+            .create =3D qmp_chardev_open_serial,
+        },
 #endif
 #ifdef HAVE_CHARDEV_PARPORT
-    register_char_driver("parallel", CHARDEV_BACKEND_KIND_PARALLEL,
-                         qemu_chr_parse_parallel, qmp_chardev_open_paral=
lel);
-    register_char_driver("parport", CHARDEV_BACKEND_KIND_PARALLEL,
-                         qemu_chr_parse_parallel, qmp_chardev_open_paral=
lel);
+        {
+            .kind =3D CHARDEV_BACKEND_KIND_PARALLEL,
+            .parse =3D qemu_chr_parse_parallel,
+            .create =3D qmp_chardev_open_parallel,
+        },
+        {
+            .kind =3D CHARDEV_BACKEND_KIND_PARALLEL,
+            .parse =3D qemu_chr_parse_parallel,
+            .create =3D qmp_chardev_open_parallel,
+        },
 #endif
 #ifdef HAVE_CHARDEV_PTY
-    register_char_driver("pty", CHARDEV_BACKEND_KIND_PTY, NULL,
-                         qemu_chr_open_pty);
+        {
+            .kind =3D CHARDEV_BACKEND_KIND_PTY,
+            .create =3D qemu_chr_open_pty,
+        },
 #endif
 #ifdef _WIN32
-    register_char_driver("console", CHARDEV_BACKEND_KIND_CONSOLE, NULL,
-                         qemu_chr_open_win_con);
+        {
+            .kind =3D CHARDEV_BACKEND_KIND_CONSOLE,
+            .create =3D qemu_chr_open_win_con,
+        },
 #endif
-    register_char_driver("pipe", CHARDEV_BACKEND_KIND_PIPE,
-                         qemu_chr_parse_pipe, qemu_chr_open_pipe);
-    register_char_driver("mux", CHARDEV_BACKEND_KIND_MUX, qemu_chr_parse=
_mux,
-                         qemu_chr_open_mux);
-    /* Bug-compatibility: */
-    register_char_driver("memory", CHARDEV_BACKEND_KIND_MEMORY,
-                         qemu_chr_parse_ringbuf, qemu_chr_open_ringbuf);
+        {
+            .kind =3D CHARDEV_BACKEND_KIND_PIPE,
+            .parse =3D qemu_chr_parse_pipe,
+            .create =3D qemu_chr_open_pipe,
+        },
+        {
+            .kind =3D CHARDEV_BACKEND_KIND_MUX,
+            .parse =3D qemu_chr_parse_mux,
+            .create =3D qemu_chr_open_mux,
+        },
+        /* Bug-compatibility: */
+        {
+            .kind =3D CHARDEV_BACKEND_KIND_MEMORY,
+            .parse =3D qemu_chr_parse_ringbuf,
+            .create =3D qemu_chr_open_ringbuf,
+        },
+    };
+
+
+    for (i =3D 0; i < ARRAY_SIZE(drivers); i++) {
+        register_char_driver(&drivers[i]);
+    }
+
     /* this must be done after machine init, since we register FEs with =
muxes
      * as part of realize functions like serial_isa_realizefn when -nogr=
aphic
      * is specified
diff --git a/spice-qemu-char.c b/spice-qemu-char.c
index 276c4aef68..30db420e2f 100644
--- a/spice-qemu-char.c
+++ b/spice-qemu-char.c
@@ -389,10 +389,18 @@ static void qemu_chr_parse_spice_port(QemuOpts *opt=
s, ChardevBackend *backend,
=20
 static void register_types(void)
 {
-    register_char_driver("spicevmc", CHARDEV_BACKEND_KIND_SPICEVMC,
-                         qemu_chr_parse_spice_vmc, qemu_chr_open_spice_v=
mc);
-    register_char_driver("spiceport", CHARDEV_BACKEND_KIND_SPICEPORT,
-                         qemu_chr_parse_spice_port, qemu_chr_open_spice_=
port);
+    static const CharDriver vmc_driver =3D {
+        .kind =3D CHARDEV_BACKEND_KIND_SPICEVMC,
+        .parse =3D qemu_chr_parse_spice_vmc,
+        .create =3D qemu_chr_open_spice_vmc,
+    };
+    static const CharDriver port_driver =3D {
+        .kind =3D CHARDEV_BACKEND_KIND_SPICEPORT,
+        .parse =3D qemu_chr_parse_spice_port,
+        .create =3D qemu_chr_open_spice_port,
+    };
+    register_char_driver(&vmc_driver);
+    register_char_driver(&port_driver);
 }
=20
 type_init(register_types);
diff --git a/ui/console.c b/ui/console.c
index b9575f2ee5..e4bb22fe87 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -2191,12 +2191,16 @@ static const TypeInfo qemu_console_info =3D {
     .class_size =3D sizeof(QemuConsoleClass),
 };
=20
-
 static void register_types(void)
 {
+    static const CharDriver vc_driver =3D {
+        .kind =3D CHARDEV_BACKEND_KIND_VC,
+        .parse =3D qemu_chr_parse_vc,
+        .create =3D vc_init,
+    };
+
     type_register_static(&qemu_console_info);
-    register_char_driver("vc", CHARDEV_BACKEND_KIND_VC, qemu_chr_parse_v=
c,
-                         vc_init);
+    register_char_driver(&vc_driver);
 }
=20
 type_init(register_types);
--=20
2.11.0
