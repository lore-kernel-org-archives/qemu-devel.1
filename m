Received: from eggs.gnu.org ([209.51.188.92]:60542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gx5eQ-0006yC-8x
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 02:53:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gx5eN-0001ar-S0
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 02:53:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gx5eM-0001Mo-Up
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 02:53:39 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4FE7EC057F2F
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 07:53:30 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 22 Feb 2019 08:53:23 +0100
Message-Id: <20190222075326.9850-13-kraxel@redhat.com>
In-Reply-To: <20190222075326.9850-1-kraxel@redhat.com>
References: <20190222075326.9850-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 12/15] build-sys: add gio-2.0 check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

GIO is required for the "-display spice-app" backend.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Tested-by: Victor Toso <victortoso@redhat.com>
Message-id: 20190221110703.5775-9-marcandre.lureau@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 configure | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/configure b/configure
index a61682c3c727..05d72f1c565b 100755
--- a/configure
+++ b/configure
@@ -3503,6 +3503,14 @@ for i in $glib_modules; do
     fi
 done
=20
+if $pkg_config --atleast-version=3D$glib_req_ver gio-2.0; then
+    gio=3Dyes
+    gio_cflags=3D$($pkg_config --cflags gio-2.0)
+    gio_libs=3D$($pkg_config --libs gio-2.0)
+else
+    gio=3Dno
+fi
+
 # Sanity check that the current size_t matches the
 # size that glib thinks it should be. This catches
 # problems on multi-arch where people try to build
@@ -6520,6 +6528,11 @@ if test "$gtk" =3D "yes" ; then
     echo "CONFIG_GTK_GL=3Dy" >> $config_host_mak
   fi
 fi
+if test "$gio" =3D "yes" ; then
+    echo "CONFIG_GIO=3Dy" >> $config_host_mak
+    echo "GIO_CFLAGS=3D$gio_cflags" >> $config_host_mak
+    echo "GIO_LIBS=3D$gio_libs" >> $config_host_mak
+fi
 echo "CONFIG_TLS_PRIORITY=3D\"$tls_priority\"" >> $config_host_mak
 if test "$gnutls" =3D "yes" ; then
   echo "CONFIG_GNUTLS=3Dy" >> $config_host_mak
--=20
2.9.3
