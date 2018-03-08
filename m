Received: from eggs.gnu.org ([2001:4830:134:3::10]:41441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1etrIa-0001DW-Ad
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 03:53:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1etrIX-0008F8-9r
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 03:53:16 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50902 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1etrIX-0008Ep-5F
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 03:53:13 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  8 Mar 2018 09:53:01 +0100
Message-Id: <20180308085301.8875-3-kraxel@redhat.com>
In-Reply-To: <20180308085301.8875-1-kraxel@redhat.com>
References: <20180308085301.8875-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/2] modules: workaround buggy glib builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>

https://bugzilla.gnome.org/show_bug.cgi?id=3D794123

Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 configure | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configure b/configure
index eb612532aa..34e4bb419e 100755
--- a/configure
+++ b/configure
@@ -3366,6 +3366,10 @@ for i in $glib_modules; do
     if $pkg_config --atleast-version=3D$glib_req_ver $i; then
         glib_cflags=3D$($pkg_config --cflags $i)
         glib_libs=3D$($pkg_config --libs $i)
+        if test "$i" =3D "gmodule-export-2.0"; then
+            # make sure we link with --export-dynamic
+            glib_libs=3D"-Wl,--export-dynamic ${glib_libs//-Wl,--export-=
dynamic/}"
+        fi
         QEMU_CFLAGS=3D"$glib_cflags $QEMU_CFLAGS"
         LIBS=3D"$glib_libs $LIBS"
         libs_qga=3D"$glib_libs $libs_qga"
--=20
2.9.3
