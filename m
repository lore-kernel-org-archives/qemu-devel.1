Received: from eggs.gnu.org ([209.51.188.92]:34760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gwmCW-00029C-5a
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:07:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gwmCV-0006yo-Hf
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:07:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gwmCV-0006wH-As
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:07:35 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E78995944D
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 11:07:31 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 Feb 2019 12:07:00 +0100
Message-Id: <20190221110703.5775-9-marcandre.lureau@redhat.com>
In-Reply-To: <20190221110703.5775-1-marcandre.lureau@redhat.com>
References: <20190221110703.5775-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 08/11] build-sys: add gio-2.0 check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com

GIO is required for the "-display spice-app" backend.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Tested-by: Victor Toso <victortoso@redhat.com>
---
 configure | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/configure b/configure
index a61682c3c7..05d72f1c56 100755
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
2.21.0.rc1
