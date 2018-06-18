Received: from eggs.gnu.org ([2001:4830:134:3::10]:43874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fUwqo-0001tv-Md
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:17:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fUwqn-00051z-Dx
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:17:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57716 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fUwqn-00051Z-7v
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:17:53 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BBCD4402178A
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 16:17:52 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 18 Jun 2018 18:17:12 +0200
Message-Id: <20180618161729.334-10-marcandre.lureau@redhat.com>
In-Reply-To: <20180618161729.334-1-marcandre.lureau@redhat.com>
References: <20180618161729.334-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 09/26] HACK: vhost-user-backend: allow to
 specify binary to execute
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kraxel@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

An executable with its arguments may be given as 'cmd' property, ex:
-object vhost-user-backend,id=3Dvui,cmd=3D"./vhost-user-input
/dev/input..". The executable is then spawn and, by convention, the
vhost-user socket is passed as fd=3D3. It may be considered a security
breach to allow creating processes that may execute arbitrary
executables, so this may be restricted to some known executables (via
signature etc) or directory.

To make the patch more acceptable, the command argument would have to
be passed via an array (probably via -object json: syntax), instead of
using g_shell_parse_argv().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 backends/vhost-user.c | 83 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 73 insertions(+), 10 deletions(-)

diff --git a/backends/vhost-user.c b/backends/vhost-user.c
index db97037306..32d3ec0e8b 100644
--- a/backends/vhost-user.c
+++ b/backends/vhost-user.c
@@ -154,26 +154,87 @@ vhost_user_backend_complete(UserCreatable *uc, Erro=
r **errp)
 {
     VhostUserBackend *b =3D VHOST_USER_BACKEND(uc);
     Chardev *chr;
+    char **argv =3D NULL;
=20
-    if (!b->chr_name) {
-        error_setg(errp, "You must specificy 'chardev'.");
+    if (!!b->chr_name + !!b->cmd !=3D 1) {
+        error_setg(errp, "You may specificy only one of 'chardev' or 'cm=
d'.");
         return;
     }
=20
-    chr =3D qemu_chr_find(b->chr_name);
-    if (chr =3D=3D NULL) {
-        error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
-                  "Chardev '%s' not found", b->chr_name);
-        return;
-    }
+    if (b->chr_name) {
+        chr =3D qemu_chr_find(b->chr_name);
+        if (chr =3D=3D NULL) {
+            error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
+                      "Chardev '%s' not found", b->chr_name);
+            return;
+        }
=20
-    if (!qemu_chr_fe_init(&b->chr, chr, errp)) {
-        return;
+        if (!qemu_chr_fe_init(&b->chr, chr, errp)) {
+            return;
+        }
+    } else {
+        QIOChannelCommand *child;
+        GError *err;
+        int sv[2];
+
+        if (!g_shell_parse_argv(b->cmd, NULL, &argv, &err)) {
+            error_setg(errp, "Fail to parse command: %s", err->message);
+            g_error_free(err);
+            return;
+        }
+
+        if (socketpair(PF_UNIX, SOCK_STREAM, 0, sv) =3D=3D -1) {
+            error_setg_errno(errp, errno, "socketpair() failed");
+            goto end;
+        }
+
+        chr =3D CHARDEV(object_new(TYPE_CHARDEV_SOCKET));
+        if (!chr || qemu_chr_add_client(chr, sv[0]) =3D=3D -1) {
+            error_setg(errp, "Failed to make socket chardev");
+            object_unref(OBJECT(chr));
+            goto end;
+        }
+
+        if (!qemu_chr_fe_init(&b->chr, chr, errp)) {
+            goto end;
+        }
+
+        child =3D qio_channel_command_new_spawn_with_pre_exec(
+            (const char * const *)argv, O_RDONLY | O_WRONLY,
+            pre_exec_cb, sv, errp);
+        if (!child) {
+            goto end;
+        }
+        b->child =3D QIO_CHANNEL(child);
+
+        close(sv[1]);
     }
=20
     b->completed =3D true;
     /* could vhost_dev_init() happen here, so early vhost-user message
      * can be exchanged */
+end:
+    g_strfreev(argv);
+}
+
+static char *get_cmd(Object *obj, Error **errp)
+{
+    VhostUserBackend *b =3D VHOST_USER_BACKEND(obj);
+
+    return g_strdup(b->cmd);
+}
+
+static void set_cmd(Object *obj, const char *str, Error **errp)
+{
+    VhostUserBackend *b =3D VHOST_USER_BACKEND(obj);
+
+    if (b->child) {
+        error_setg(errp, "cannot change property value");
+        return;
+    }
+
+    g_free(b->cmd);
+    b->cmd =3D g_strdup(str);
 }
=20
 static void set_chardev(Object *obj, const char *value, Error **errp)
@@ -202,6 +263,7 @@ static char *get_chardev(Object *obj, Error **errp)
=20
 static void vhost_user_backend_init(Object *obj)
 {
+    object_property_add_str(obj, "cmd", get_cmd, set_cmd, NULL);
     object_property_add_str(obj, "chardev", get_chardev, set_chardev, NU=
LL);
 }
=20
@@ -210,6 +272,7 @@ static void vhost_user_backend_finalize(Object *obj)
     VhostUserBackend *b =3D VHOST_USER_BACKEND(obj);
=20
     g_free(b->dev.vqs);
+    g_free(b->cmd);
     g_free(b->chr_name);
=20
     vhost_user_cleanup(&b->vhost_user);
--=20
2.18.0.rc1
