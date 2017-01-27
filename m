Received: from eggs.gnu.org ([2001:4830:134:3::10]:33678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6r6-0005D1-5j
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6r4-00048Z-46
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:20 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35913)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cX6r3-000482-QJ
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:18 -0500
Received: by mail-wm0-x241.google.com with SMTP id r126so58371969wmr.3
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 05:46:17 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Jan 2017 14:45:33 +0100
Message-Id: <1485524749-118532-26-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
References: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 25/41] char: use a const CharDriver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

No need to allocate & copy fields, let's use static const struct instead.

Add an alias field to the CharDriver structure to cover the cases where
we previously registered a driver twice under two names.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 backends/baum.c       |   8 ++-
 backends/msmouse.c    |   7 ++-
 backends/testdev.c    |   7 ++-
 include/sysemu/char.h |  20 +++---
 qemu-char.c           | 169 +++++++++++++++++++++++++++++++-------------------
 spice-qemu-char.c     |  16 +++--
 ui/console.c          |  10 ++-
 7 files changed, 151 insertions(+), 86 deletions(-)

diff --git a/backends/baum.c b/backends/baum.c
index b045ef4..2e404a1 100644
--- a/backends/baum.c
+++ b/backends/baum.c
@@ -671,8 +671,12 @@ fail_handle:
 
 static void register_types(void)
 {
-    register_char_driver("braille", CHARDEV_BACKEND_KIND_BRAILLE, NULL,
-                         chr_baum_init);
+    static const CharDriver driver = {
+        .kind = CHARDEV_BACKEND_KIND_BRAILLE,
+        .create = chr_baum_init,
+    };
+
+    register_char_driver(&driver);
 }
 
 type_init(register_types);
diff --git a/backends/msmouse.c b/backends/msmouse.c
index 733ca80..2490b2c 100644
--- a/backends/msmouse.c
+++ b/backends/msmouse.c
@@ -179,8 +179,11 @@ static CharDriverState *qemu_chr_open_msmouse(const char *id,
 
 static void register_types(void)
 {
-    register_char_driver("msmouse", CHARDEV_BACKEND_KIND_MSMOUSE, NULL,
-                         qemu_chr_open_msmouse);
+    static const CharDriver driver = {
+        .kind = CHARDEV_BACKEND_KIND_MSMOUSE,
+        .create = qemu_chr_open_msmouse,
+    };
+    register_char_driver(&driver);
 }
 
 type_init(register_types);
diff --git a/backends/testdev.c b/backends/testdev.c
index 60156e3..cd25094 100644
--- a/backends/testdev.c
+++ b/backends/testdev.c
@@ -130,8 +130,11 @@ static CharDriverState *chr_testdev_init(const char *id,
 
 static void register_types(void)
 {
-    register_char_driver("testdev", CHARDEV_BACKEND_KIND_TESTDEV, NULL,
-                         chr_testdev_init);
+    static const CharDriver driver = {
+        .kind = CHARDEV_BACKEND_KIND_TESTDEV,
+        .create = chr_testdev_init,
+    };
+    register_char_driver(&driver);
 }
 
 type_init(register_types);
diff --git a/include/sysemu/char.h b/include/sysemu/char.h
index b6e3618..fee2c34 100644
--- a/include/sysemu/char.h
+++ b/include/sysemu/char.h
@@ -475,15 +475,17 @@ void qemu_chr_set_feature(CharDriverState *chr,
                           CharDriverFeature feature);
 QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename);
 
-typedef void CharDriverParse(QemuOpts *opts, ChardevBackend *backend,
-                             Error **errp);
-typedef CharDriverState *CharDriverCreate(const char *id,
-                                          ChardevBackend *backend,
-                                          ChardevReturn *ret, bool *be_opened,
-                                          Error **errp);
-
-void register_char_driver(const char *name, ChardevBackendKind kind,
-                          CharDriverParse *parse, CharDriverCreate *create);
+typedef struct CharDriver {
+    ChardevBackendKind kind;
+    const char *alias;
+    void (*parse)(QemuOpts *opts, ChardevBackend *backend, Error **errp);
+    CharDriverState *(*create)(const char *id,
+                               ChardevBackend *backend,
+                               ChardevReturn *ret, bool *be_opened,
+                               Error **errp);
+} CharDriver;
+
+void register_char_driver(const CharDriver *driver);
 
 extern int term_escape_char;
 
diff --git a/qemu-char.c b/qemu-char.c
index d8da167..51558a7 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -4101,27 +4101,12 @@ static void qemu_chr_parse_udp(QemuOpts *opts, ChardevBackend *backend,
     }
 }
 
-typedef struct CharDriver {
-    const char *name;
-    ChardevBackendKind kind;
-    CharDriverParse *parse;
-    CharDriverCreate *create;
-} CharDriver;
-
 static GSList *backends;
 
-void register_char_driver(const char *name, ChardevBackendKind kind,
-                          CharDriverParse *parse, CharDriverCreate *create)
+void register_char_driver(const CharDriver *driver)
 {
-    CharDriver *s;
-
-    s = g_malloc0(sizeof(*s));
-    s->name = g_strdup(name);
-    s->kind = kind;
-    s->parse = parse;
-    s->create = create;
-
-    backends = g_slist_append(backends, s);
+    /* casting away const */
+    backends = g_slist_append(backends, (void *)driver);
 }
 
 CharDriverState *qemu_chr_new_from_opts(QemuOpts *opts,
@@ -4133,22 +4118,26 @@ CharDriverState *qemu_chr_new_from_opts(QemuOpts *opts,
     GSList *i;
     ChardevReturn *ret = NULL;
     ChardevBackend *backend;
+    const char *name = qemu_opt_get(opts, "backend");
     const char *id = qemu_opts_id(opts);
     char *bid = NULL;
 
-    if (qemu_opt_get(opts, "backend") == NULL) {
+    if (name == NULL) {
         error_setg(errp, "chardev: \"%s\" missing backend",
                    qemu_opts_id(opts));
         goto err;
     }
 
-    if (is_help_option(qemu_opt_get(opts, "backend"))) {
+    if (is_help_option(name)) {
         fprintf(stderr, "Available chardev backend types:\n");
         for (i = backends; i; i = i->next) {
             cd = i->data;
-            fprintf(stderr, "%s\n", cd->name);
+            fprintf(stderr, "%s\n", ChardevBackendKind_lookup[cd->kind]);
+            if (cd->alias) {
+                fprintf(stderr, "%s\n", cd->alias);
+            }
         }
-        exit(!is_help_option(qemu_opt_get(opts, "backend")));
+        exit(0);
     }
 
     if (id == NULL) {
@@ -4159,13 +4148,13 @@ CharDriverState *qemu_chr_new_from_opts(QemuOpts *opts,
     for (i = backends; i; i = i->next) {
         cd = i->data;
 
-        if (strcmp(cd->name, qemu_opt_get(opts, "backend")) == 0) {
+        if (g_strcmp0(ChardevBackendKind_lookup[cd->kind], name) == 0 ||
+            g_strcmp0(cd->alias, name) == 0) {
             break;
         }
     }
     if (i == NULL) {
-        error_setg(errp, "chardev: backend \"%s\" not found",
-                   qemu_opt_get(opts, "backend"));
+        error_setg(errp, "chardev: backend \"%s\" not found", name);
         goto err;
     }
 
@@ -4368,20 +4357,29 @@ ChardevInfoList *qmp_query_chardev(Error **errp)
     return chr_list;
 }
 
+static ChardevBackendInfoList *
+qmp_prepend_backend(ChardevBackendInfoList *list, const char *name)
+{
+    ChardevBackendInfoList *info = g_malloc0(sizeof(*info));
+    info->value = g_malloc0(sizeof(*info->value));
+    info->value->name = g_strdup(name);
+    info->next = list;
+    return info;
+}
+
 ChardevBackendInfoList *qmp_query_chardev_backends(Error **errp)
 {
     ChardevBackendInfoList *backend_list = NULL;
-    CharDriver *c = NULL;
-    GSList *i = NULL;
+    CharDriver *c;
+    GSList *i;
 
     for (i = backends; i; i = i->next) {
-        ChardevBackendInfoList *info = g_malloc0(sizeof(*info));
         c = i->data;
-        info->value = g_malloc0(sizeof(*info->value));
-        info->value->name = g_strdup(c->name);
-
-        info->next = backend_list;
-        backend_list = info;
+        backend_list = qmp_prepend_backend(backend_list,
+                                           ChardevBackendKind_lookup[c->kind]);
+        if (c->alias) {
+            backend_list = qmp_prepend_backend(backend_list, c->alias);
+        }
     }
 
     return backend_list;
@@ -4914,45 +4912,88 @@ void qemu_chr_cleanup(void)
 
 static void register_types(void)
 {
-    register_char_driver("null", CHARDEV_BACKEND_KIND_NULL, NULL,
-                         qemu_chr_open_null);
-    register_char_driver("socket", CHARDEV_BACKEND_KIND_SOCKET,
-                         qemu_chr_parse_socket, qmp_chardev_open_socket);
-    register_char_driver("udp", CHARDEV_BACKEND_KIND_UDP, qemu_chr_parse_udp,
-                         qmp_chardev_open_udp);
-    register_char_driver("ringbuf", CHARDEV_BACKEND_KIND_RINGBUF,
-                         qemu_chr_parse_ringbuf, qemu_chr_open_ringbuf);
-    register_char_driver("file", CHARDEV_BACKEND_KIND_FILE,
-                         qemu_chr_parse_file_out, qmp_chardev_open_file);
-    register_char_driver("stdio", CHARDEV_BACKEND_KIND_STDIO,
-                         qemu_chr_parse_stdio, qemu_chr_open_stdio);
+    int i;
+    static const CharDriver drivers[] = {
+        {
+            .kind = CHARDEV_BACKEND_KIND_NULL,
+            .create = qemu_chr_open_null,
+        },
+        {
+            .kind = CHARDEV_BACKEND_KIND_SOCKET,
+            .parse = qemu_chr_parse_socket,
+            .create = qmp_chardev_open_socket,
+        },
+        {
+            .kind = CHARDEV_BACKEND_KIND_UDP,
+            .parse = qemu_chr_parse_udp,
+            .create = qmp_chardev_open_udp,
+        },
+        {
+            .kind = CHARDEV_BACKEND_KIND_RINGBUF,
+            .parse = qemu_chr_parse_ringbuf,
+            .create = qemu_chr_open_ringbuf,
+        },
+        {
+            .kind = CHARDEV_BACKEND_KIND_FILE,
+            .parse = qemu_chr_parse_file_out,
+            .create = qmp_chardev_open_file,
+        },
+        {
+            .kind = CHARDEV_BACKEND_KIND_STDIO,
+            .parse = qemu_chr_parse_stdio,
+            .create = qemu_chr_open_stdio,
+        },
 #if defined HAVE_CHARDEV_SERIAL
-    register_char_driver("serial", CHARDEV_BACKEND_KIND_SERIAL,
-                         qemu_chr_parse_serial, qmp_chardev_open_serial);
-    register_char_driver("tty", CHARDEV_BACKEND_KIND_SERIAL,
-                         qemu_chr_parse_serial, qmp_chardev_open_serial);
+        {
+            .kind = CHARDEV_BACKEND_KIND_SERIAL,
+            .alias = "tty",
+            .parse = qemu_chr_parse_serial,
+            .create = qmp_chardev_open_serial,
+        },
 #endif
 #ifdef HAVE_CHARDEV_PARPORT
-    register_char_driver("parallel", CHARDEV_BACKEND_KIND_PARALLEL,
-                         qemu_chr_parse_parallel, qmp_chardev_open_parallel);
-    register_char_driver("parport", CHARDEV_BACKEND_KIND_PARALLEL,
-                         qemu_chr_parse_parallel, qmp_chardev_open_parallel);
+        {
+            .kind = CHARDEV_BACKEND_KIND_PARALLEL,
+            .alias = "parport",
+            .parse = qemu_chr_parse_parallel,
+            .create = qmp_chardev_open_parallel,
+        },
 #endif
 #ifdef HAVE_CHARDEV_PTY
-    register_char_driver("pty", CHARDEV_BACKEND_KIND_PTY, NULL,
-                         qemu_chr_open_pty);
+        {
+            .kind = CHARDEV_BACKEND_KIND_PTY,
+            .create = qemu_chr_open_pty,
+        },
 #endif
 #ifdef _WIN32
-    register_char_driver("console", CHARDEV_BACKEND_KIND_CONSOLE, NULL,
-                         qemu_chr_open_win_con);
+        {
+            .kind = CHARDEV_BACKEND_KIND_CONSOLE,
+            .create = qemu_chr_open_win_con,
+        },
 #endif
-    register_char_driver("pipe", CHARDEV_BACKEND_KIND_PIPE,
-                         qemu_chr_parse_pipe, qemu_chr_open_pipe);
-    register_char_driver("mux", CHARDEV_BACKEND_KIND_MUX, qemu_chr_parse_mux,
-                         qemu_chr_open_mux);
-    /* Bug-compatibility: */
-    register_char_driver("memory", CHARDEV_BACKEND_KIND_MEMORY,
-                         qemu_chr_parse_ringbuf, qemu_chr_open_ringbuf);
+        {
+            .kind = CHARDEV_BACKEND_KIND_PIPE,
+            .parse = qemu_chr_parse_pipe,
+            .create = qemu_chr_open_pipe,
+        },
+        {
+            .kind = CHARDEV_BACKEND_KIND_MUX,
+            .parse = qemu_chr_parse_mux,
+            .create = qemu_chr_open_mux,
+        },
+        /* Bug-compatibility: */
+        {
+            .kind = CHARDEV_BACKEND_KIND_MEMORY,
+            .parse = qemu_chr_parse_ringbuf,
+            .create = qemu_chr_open_ringbuf,
+        },
+    };
+
+
+    for (i = 0; i < ARRAY_SIZE(drivers); i++) {
+        register_char_driver(&drivers[i]);
+    }
+
     /* this must be done after machine init, since we register FEs with muxes
      * as part of realize functions like serial_isa_realizefn when -nographic
      * is specified
diff --git a/spice-qemu-char.c b/spice-qemu-char.c
index 276c4ae..30db420 100644
--- a/spice-qemu-char.c
+++ b/spice-qemu-char.c
@@ -389,10 +389,18 @@ static void qemu_chr_parse_spice_port(QemuOpts *opts, ChardevBackend *backend,
 
 static void register_types(void)
 {
-    register_char_driver("spicevmc", CHARDEV_BACKEND_KIND_SPICEVMC,
-                         qemu_chr_parse_spice_vmc, qemu_chr_open_spice_vmc);
-    register_char_driver("spiceport", CHARDEV_BACKEND_KIND_SPICEPORT,
-                         qemu_chr_parse_spice_port, qemu_chr_open_spice_port);
+    static const CharDriver vmc_driver = {
+        .kind = CHARDEV_BACKEND_KIND_SPICEVMC,
+        .parse = qemu_chr_parse_spice_vmc,
+        .create = qemu_chr_open_spice_vmc,
+    };
+    static const CharDriver port_driver = {
+        .kind = CHARDEV_BACKEND_KIND_SPICEPORT,
+        .parse = qemu_chr_parse_spice_port,
+        .create = qemu_chr_open_spice_port,
+    };
+    register_char_driver(&vmc_driver);
+    register_char_driver(&port_driver);
 }
 
 type_init(register_types);
diff --git a/ui/console.c b/ui/console.c
index b9575f2..e4bb22f 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -2191,12 +2191,16 @@ static const TypeInfo qemu_console_info = {
     .class_size = sizeof(QemuConsoleClass),
 };
 
-
 static void register_types(void)
 {
+    static const CharDriver vc_driver = {
+        .kind = CHARDEV_BACKEND_KIND_VC,
+        .parse = qemu_chr_parse_vc,
+        .create = vc_init,
+    };
+
     type_register_static(&qemu_console_info);
-    register_char_driver("vc", CHARDEV_BACKEND_KIND_VC, qemu_chr_parse_vc,
-                         vc_init);
+    register_char_driver(&vc_driver);
 }
 
 type_init(register_types);
-- 
1.8.3.1
