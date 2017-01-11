Received: from eggs.gnu.org ([2001:4830:134:3::10]:40957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cRMjV-0001Hm-IH
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:30:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cRMjU-0006Yi-80
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:30:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cRMjT-0006YY-VM
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:30:44 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 284F35277D
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 17:30:44 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 11 Jan 2017 18:29:49 +0100
Message-Id: <20170111172956.11255-34-marcandre.lureau@redhat.com>
In-Reply-To: <20170111172956.11255-1-marcandre.lureau@redhat.com>
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 33/40] char: move file chardev in its own file
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

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 chardev/char-file.c   | 116 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
 chardev/char.c        | 106 --------------------------------------------=
-
 chardev/Makefile.objs |   1 +
 3 files changed, 117 insertions(+), 106 deletions(-)
 create mode 100644 chardev/char-file.c

diff --git a/chardev/char-file.c b/chardev/char-file.c
new file mode 100644
index 0000000000..8be564c7df
--- /dev/null
+++ b/chardev/char-file.c
@@ -0,0 +1,116 @@
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu-common.h"
+#include "sysemu/char.h"
+
+#ifdef _WIN32
+#include "char-win.h"
+#else
+#include "char-fd.h"
+#endif
+
+static void qmp_chardev_open_file(Chardev *chr,
+                                  ChardevBackend *backend,
+                                  bool *be_opened,
+                                  Error **errp)
+{
+    ChardevFile *file =3D backend->u.file.data;
+#ifdef _WIN32
+    HANDLE out;
+    DWORD accessmode;
+    DWORD flags;
+
+    if (file->has_in) {
+        error_setg(errp, "input file not supported");
+        return;
+    }
+
+    if (file->has_append && file->append) {
+        /* Append to file if it already exists. */
+        accessmode =3D FILE_GENERIC_WRITE & ~FILE_WRITE_DATA;
+        flags =3D OPEN_ALWAYS;
+    } else {
+        /* Truncate file if it already exists. */
+        accessmode =3D GENERIC_WRITE;
+        flags =3D CREATE_ALWAYS;
+    }
+
+    out =3D CreateFile(file->out, accessmode, FILE_SHARE_READ, NULL, fla=
gs,
+                     FILE_ATTRIBUTE_NORMAL, NULL);
+    if (out =3D=3D INVALID_HANDLE_VALUE) {
+        error_setg(errp, "open %s failed", file->out);
+        return;
+    }
+
+    qemu_chr_open_win_file(chr, out);
+#else
+    int flags, in =3D -1, out;
+
+    flags =3D O_WRONLY | O_CREAT | O_BINARY;
+    if (file->has_append && file->append) {
+        flags |=3D O_APPEND;
+    } else {
+        flags |=3D O_TRUNC;
+    }
+
+    out =3D qmp_chardev_open_file_source(file->out, flags, errp);
+    if (out < 0) {
+        return;
+    }
+
+    if (file->has_in) {
+        flags =3D O_RDONLY;
+        in =3D qmp_chardev_open_file_source(file->in, flags, errp);
+        if (in < 0) {
+            qemu_close(out);
+            return;
+        }
+    }
+
+    qemu_chr_open_fd(chr, in, out);
+#endif
+}
+
+static void qemu_chr_parse_file_out(QemuOpts *opts, ChardevBackend *back=
end,
+                                    Error **errp)
+{
+    const char *path =3D qemu_opt_get(opts, "path");
+    ChardevFile *file;
+
+    backend->type =3D CHARDEV_BACKEND_KIND_FILE;
+    if (path =3D=3D NULL) {
+        error_setg(errp, "chardev: file: no filename given");
+        return;
+    }
+    file =3D backend->u.file.data =3D g_new0(ChardevFile, 1);
+    qemu_chr_parse_common(opts, qapi_ChardevFile_base(file));
+    file->out =3D g_strdup(path);
+
+    file->has_append =3D true;
+    file->append =3D qemu_opt_get_bool(opts, "append", false);
+}
+
+static void char_file_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc =3D CHARDEV_CLASS(oc);
+
+    cc->parse =3D qemu_chr_parse_file_out;
+    cc->open =3D qmp_chardev_open_file;
+}
+
+static const TypeInfo char_file_type_info =3D {
+    .name =3D TYPE_CHARDEV_FILE,
+#ifdef _WIN32
+    .parent =3D TYPE_CHARDEV_WIN,
+#else
+    .parent =3D TYPE_CHARDEV_FD,
+#endif
+    .class_init =3D char_file_class_init,
+};
+
+static void register_types(void)
+{
+    type_register_static(&char_file_type_info);
+}
+
+type_init(register_types);
diff --git a/chardev/char.c b/chardev/char.c
index 2eb148714c..abf6ad820c 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -1687,26 +1687,6 @@ void qemu_chr_parse_common(QemuOpts *opts, Chardev=
Common *backend)
     backend->logappend =3D qemu_opt_get_bool(opts, "logappend", false);
 }
=20
-
-static void qemu_chr_parse_file_out(QemuOpts *opts, ChardevBackend *back=
end,
-                                    Error **errp)
-{
-    const char *path =3D qemu_opt_get(opts, "path");
-    ChardevFile *file;
-
-    backend->type =3D CHARDEV_BACKEND_KIND_FILE;
-    if (path =3D=3D NULL) {
-        error_setg(errp, "chardev: file: no filename given");
-        return;
-    }
-    file =3D backend->u.file.data =3D g_new0(ChardevFile, 1);
-    qemu_chr_parse_common(opts, qapi_ChardevFile_base(file));
-    file->out =3D g_strdup(path);
-
-    file->has_append =3D true;
-    file->append =3D qemu_opt_get_bool(opts, "append", false);
-}
-
 static void qemu_chr_parse_stdio(QemuOpts *opts, ChardevBackend *backend=
,
                                  Error **errp)
 {
@@ -2238,41 +2218,6 @@ QemuOptsList qemu_chardev_opts =3D {
=20
 #ifdef _WIN32
=20
-static void qmp_chardev_open_file(Chardev *chr,
-                                  ChardevBackend *backend,
-                                  bool *be_opened,
-                                  Error **errp)
-{
-    ChardevFile *file =3D backend->u.file.data;
-    HANDLE out;
-    DWORD accessmode;
-    DWORD flags;
-
-    if (file->has_in) {
-        error_setg(errp, "input file not supported");
-        return;
-    }
-
-    if (file->has_append && file->append) {
-        /* Append to file if it already exists. */
-        accessmode =3D FILE_GENERIC_WRITE & ~FILE_WRITE_DATA;
-        flags =3D OPEN_ALWAYS;
-    } else {
-        /* Truncate file if it already exists. */
-        accessmode =3D GENERIC_WRITE;
-        flags =3D CREATE_ALWAYS;
-    }
-
-    out =3D CreateFile(file->out, accessmode, FILE_SHARE_READ, NULL, fla=
gs,
-                     FILE_ATTRIBUTE_NORMAL, NULL);
-    if (out =3D=3D INVALID_HANDLE_VALUE) {
-        error_setg(errp, "open %s failed", file->out);
-        return;
-    }
-
-    qemu_chr_open_win_file(chr, out);
-}
-
 static void qmp_chardev_open_serial(Chardev *chr,
                                     ChardevBackend *backend,
                                     bool *be_opened,
@@ -2285,38 +2230,6 @@ static void qmp_chardev_open_serial(Chardev *chr,
=20
 #else /* WIN32 */
=20
-static void qmp_chardev_open_file(Chardev *chr,
-                                  ChardevBackend *backend,
-                                  bool *be_opened,
-                                  Error **errp)
-{
-    ChardevFile *file =3D backend->u.file.data;
-    int flags, in =3D -1, out;
-
-    flags =3D O_WRONLY | O_CREAT | O_BINARY;
-    if (file->has_append && file->append) {
-        flags |=3D O_APPEND;
-    } else {
-        flags |=3D O_TRUNC;
-    }
-
-    out =3D qmp_chardev_open_file_source(file->out, flags, errp);
-    if (out < 0) {
-        return;
-    }
-
-    if (file->has_in) {
-        flags =3D O_RDONLY;
-        in =3D qmp_chardev_open_file_source(file->in, flags, errp);
-        if (in < 0) {
-            qemu_close(out);
-            return;
-        }
-    }
-
-    qemu_chr_open_fd(chr, in, out);
-}
-
 #ifdef HAVE_CHARDEV_SERIAL
 static void qmp_chardev_open_serial(Chardev *chr,
                                     ChardevBackend *backend,
@@ -2393,24 +2306,6 @@ static const TypeInfo char_parallel_type_info =3D =
{
=20
 #endif /* WIN32 */
=20
-static void char_file_class_init(ObjectClass *oc, void *data)
-{
-    ChardevClass *cc =3D CHARDEV_CLASS(oc);
-
-    cc->parse =3D qemu_chr_parse_file_out;
-    cc->open =3D qmp_chardev_open_file;
-}
-
-static const TypeInfo char_file_type_info =3D {
-    .name =3D TYPE_CHARDEV_FILE,
-#ifdef _WIN32
-    .parent =3D TYPE_CHARDEV_WIN,
-#else
-    .parent =3D TYPE_CHARDEV_FD,
-#endif
-    .class_init =3D char_file_class_init,
-};
-
 #ifdef HAVE_CHARDEV_SERIAL
=20
 static void char_serial_class_init(ObjectClass *oc, void *data)
@@ -2536,7 +2431,6 @@ void qemu_chr_cleanup(void)
 static void register_types(void)
 {
     type_register_static(&char_type_info);
-    type_register_static(&char_file_type_info);
     type_register_static(&char_stdio_type_info);
 #ifdef HAVE_CHARDEV_SERIAL
     type_register_static(&char_serial_type_info);
diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
index dddef029e7..0051a7a819 100644
--- a/chardev/Makefile.objs
+++ b/chardev/Makefile.objs
@@ -1,5 +1,6 @@
 chardev-obj-y +=3D char.o
 chardev-obj-$(CONFIG_POSIX) +=3D char-fd.o
+chardev-obj-y +=3D char-file.o
 chardev-obj-y +=3D char-io.o
 chardev-obj-y +=3D char-mux.o
 chardev-obj-y +=3D char-null.o
--=20
2.11.0
