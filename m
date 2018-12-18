Received: from eggs.gnu.org ([2001:4830:134:3::10]:40645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOR8-0000KI-CY
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOR5-0004xz-51
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:02 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:41670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gZOR4-0004R1-90
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:58 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 19 Dec 2018 00:04:21 +0100
Message-Id: <20181218230442.27887-44-samuel.thibault@ens-lyon.org>
In-Reply-To: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
References: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 43/64] glib-compat: add g_spawn_async_with_fds()
 fallback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
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
2.19.2
