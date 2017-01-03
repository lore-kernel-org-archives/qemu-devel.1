Received: from eggs.gnu.org ([2001:4830:134:3::10]:39140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cOUcc-0005Lh-DP
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 14:19:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cOUcZ-00089v-A0
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 14:19:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cOUcZ-00087f-4U
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 14:19:43 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  3 Jan 2017 20:19:33 +0100
Message-Id: <20170103191933.19416-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] win32: use glib gpoll if glib >= 2.50
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sw@weilnetz.de, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

A fix has been committed in upstream glib commit
210a9796f78eb90f76f1bd6a304e9fea05e97617.
(See also related bug https://bugzilla.gnome.org/show_bug.cgi?id=3D764415=
)

It is desirable to use the glib version instead of qemu copy, since it
provides more debugging facilities (G_MAIN_POLL_DEBUG etc), and
hopefully has a better maintainance. Hopefully, we can drop the qemu
copy in a few years.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/glib-compat.h | 2 +-
 util/oslib-win32.c    | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/glib-compat.h b/include/glib-compat.h
index acf254d2a0..0cd24ffbe9 100644
--- a/include/glib-compat.h
+++ b/include/glib-compat.h
@@ -39,7 +39,7 @@ static inline gint64 qemu_g_get_monotonic_time(void)
 #define g_get_monotonic_time() qemu_g_get_monotonic_time()
 #endif
=20
-#ifdef _WIN32
+#if defined(_WIN32) && !GLIB_CHECK_VERSION(2, 50, 0)
 /*
  * g_poll has a problem on Windows when using
  * timeouts < 10ms, so use wrapper.
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index d09863cc9d..0b1890fd33 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -327,6 +327,7 @@ char *qemu_get_exec_dir(void)
     return g_strdup(exec_dir);
 }
=20
+#if !GLIB_CHECK_VERSION(2, 50, 0)
 /*
  * The original implementation of g_poll from glib has a problem on Wind=
ows
  * when using timeouts < 10 ms.
@@ -530,6 +531,7 @@ gint g_poll(GPollFD *fds, guint nfds, gint timeout)
=20
     return retval;
 }
+#endif
=20
 int getpagesize(void)
 {
--=20
2.11.0
