Received: from eggs.gnu.org ([2001:4830:134:3::10]:58511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuQL-0007uK-TC
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:37:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuQC-0000mw-Ke
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:37:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gMuQ6-0000jq-5V
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:37:22 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 14 Nov 2018 16:36:04 +0400
Message-Id: <20181114123643.24091-3-marcandre.lureau@redhat.com>
In-Reply-To: <20181114123643.24091-1-marcandre.lureau@redhat.com>
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 02/41] glib-compat: add
 g_spawn_async_with_fds() fallback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: samuel.thibault@ens-lyon.org, rjones@redhat.com, stefanha@redhat.com, renzo@cs.unibo.it, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/glib-compat.h | 56 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/include/glib-compat.h b/include/glib-compat.h
index fdf95a255d..8a078c5288 100644
--- a/include/glib-compat.h
+++ b/include/glib-compat.h
@@ -83,6 +83,62 @@ static inline gboolean g_strv_contains_qemu(const gcha=
r *const *strv,
 }
 #define g_strv_contains(a, b) g_strv_contains_qemu(a, b)
=20
+#if !GLIB_CHECK_VERSION(2, 58, 0)
+typedef struct QemuGSpawnFds {
+    GSpawnChildSetupFunc child_setup;
+    gpointer user_data;
+    gint stdin_fd;
+    gint stdout_fd;
+    gint stderr_fd;
+} QemuGSpawnFds;
+
+static inline void
+qemu_gspawn_fds_setup(gpointer user_data)
+{
+    QemuGSpawnFds *q =3D (QemuGSpawnFds *)user_data;
+
+    dup2(q->stdin_fd, 0);
+    dup2(q->stdout_fd, 1);
+    dup2(q->stderr_fd, 2);
+    q->child_setup(q->user_data);
+}
+#endif
+
+static inline gboolean
+g_spawn_async_with_fds_qemu(const gchar *working_directory,
+                            gchar **argv,
+                            gchar **envp,
+                            GSpawnFlags flags,
+                            GSpawnChildSetupFunc child_setup,
+                            gpointer user_data,
+                            GPid *child_pid,
+                            gint stdin_fd,
+                            gint stdout_fd,
+                            gint stderr_fd,
+                            GError **error)
+{
+#if GLIB_CHECK_VERSION(2, 58, 0)
+    return g_spawn_async_with_fds(working_directory, argv, envp, flags,
+                                  child_setup, user_data,
+                                  child_pid, stdin_fd, stdout_fd, stderr=
_fd,
+                                  error);
+#else
+    QemuGSpawnFds setup =3D {
+        .child_setup =3D child_setup,
+        .user_data =3D user_data,
+        .stdin_fd =3D stdin_fd,
+        .stdout_fd =3D stdout_fd,
+        .stderr_fd =3D stderr_fd,
+    };
+
+    return g_spawn_async(working_directory, argv, envp, flags,
+                         qemu_gspawn_fds_setup, &setup,
+                         child_pid, error);
+#endif
+}
+
+#define g_spawn_async_with_fds(wd, argv, env, f, c, d, p, ifd, ofd, efd,=
 err) \
+    g_spawn_async_with_fds_qemu(wd, argv, env, f, c, d, p, ifd, ofd, efd=
, err)
=20
 #if defined(_WIN32) && !GLIB_CHECK_VERSION(2, 50, 0)
 /*
--=20
2.19.1.708.g4ede3d42df
