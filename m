Received: from eggs.gnu.org ([2001:4830:134:3::10]:47275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVzqF-0000fO-QN
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:04:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVzqC-00006E-IN
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:04:51 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Tue, 24 Jan 2017 12:39:28 +0300
Message-Id: <c93dcbebde0e1f42d1a59622b01f15a1dab20c35.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 24/31] win32: use glib gpoll if glib >= 2.50
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

A fix has been committed in upstream glib commit
210a9796f78eb90f76f1bd6a304e9fea05e97617.
(See also related bug https://bugzilla.gnome.org/show_bug.cgi?id=3D764415=
)

It is desirable to use the glib version instead of qemu copy, since it
provides more debugging facilities (G_MAIN_POLL_DEBUG etc), and
hopefully has a better maintainance. Hopefully, we can drop the qemu
copy in a few years.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 include/glib-compat.h | 2 +-
 util/oslib-win32.c    | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/glib-compat.h b/include/glib-compat.h
index acf254d..0cd24ff 100644
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
index d09863c..0b1890f 100644
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
2.1.4
