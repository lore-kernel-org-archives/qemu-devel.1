Received: from eggs.gnu.org ([2001:4830:134:3::10]:41123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fdxpP-0003yJ-Uo
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:09:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fdxpO-0002Wy-MO
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:09:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40294 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fdxpO-0002Uu-GD
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:09:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 139817DAC8
	for <qemu-devel@nongnu.org>; Fri, 13 Jul 2018 13:09:42 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Jul 2018 15:08:57 +0200
Message-Id: <20180713130916.4153-11-marcandre.lureau@redhat.com>
In-Reply-To: <20180713130916.4153-1-marcandre.lureau@redhat.com>
References: <20180713130916.4153-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 10/29] HACK: vhost-user-backend: allow to
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
Cc: airlied@redhat.com, kraxel@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

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
 backends/vhost-user.c | 96 ++++++++++++++++++++++++++++++++++++++-----
 qemu-options.hx       | 12 ++++--
 2 files changed, 94 insertions(+), 14 deletions(-)

diff --git a/backends/vhost-user.c b/backends/vhost-user.c
index bf39c0751d..32d3ec0e8b 100644
--- a/backends/vhost-user.c
+++ b/backends/vhost-user.c
@@ -136,31 +136,105 @@ vhost_user_backend_stop(VhostUserBackend *b)
     b->started =3D false;
 }
=20
+static void
+pre_exec_cb(void *data)
+{
+    int *sv =3D data;
+    int maxfd =3D sysconf(_SC_OPEN_MAX);
+    int fd;
+
+    dup2(sv[1], 3);
+    for (fd =3D 4; fd < maxfd; fd++) {
+        close(fd);
+    }
+}
+
 static void
 vhost_user_backend_complete(UserCreatable *uc, Error **errp)
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
@@ -189,6 +263,7 @@ static char *get_chardev(Object *obj, Error **errp)
=20
 static void vhost_user_backend_init(Object *obj)
 {
+    object_property_add_str(obj, "cmd", get_cmd, set_cmd, NULL);
     object_property_add_str(obj, "chardev", get_chardev, set_chardev, NU=
LL);
 }
=20
@@ -197,6 +272,7 @@ static void vhost_user_backend_finalize(Object *obj)
     VhostUserBackend *b =3D VHOST_USER_BACKEND(obj);
=20
     g_free(b->dev.vqs);
+    g_free(b->cmd);
     g_free(b->chr_name);
=20
     vhost_user_cleanup(&b->vhost_user);
diff --git a/qemu-options.hx b/qemu-options.hx
index 413b97d5e9..9243a5f8ab 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4292,16 +4292,20 @@ secondary:
 If you want to know the detail of above command line, you can read
 the colo-compare git log.
=20
-@item -object vhost-user-backend,id=3Did=3D@var{id},chardev=3D@var{chard=
evid}
+@item -object vhost-user-backend,id=3Did=3D@var{id}[,chardev=3D@var{char=
devid},cmd=3D@var{cmd}]
=20
 Create a vhost-user-backend object that holds a connection to a
 vhost-user backend and can be referenced from virtio/vhost-user
 devices that support it.
=20
 The @var{id} parameter is a unique ID that will be used to reference
-this vhost-user backend from the @option{vhost-user} device. The
-@var{chardev} parameter is the unique ID of a character device backend
-that provides the connection to the vhost-user slave process. (Since 3.0=
)
+this vhost-user backend from the @option{vhost-user} device.
+
+You must specify either @var{chardev} or @var{cmd}. The @var{chardev}
+parameter is the unique ID of a character device backend that provides
+the connection to the vhost-user slave process.  The @var{cmd}
+parameter will simplify handling of the backend, by running the given
+command and establishing the connection. (Since 3.1)
=20
 @example
=20
--=20
2.18.0.129.ge3331758f1
