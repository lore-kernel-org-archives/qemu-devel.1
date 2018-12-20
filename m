Received: from eggs.gnu.org ([2001:4830:134:3::10]:36614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gZzLc-0007mK-BP
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 09:30:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gZz8Q-00015K-OH
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 09:17:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gZz8Q-00014i-IW
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 09:17:10 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1981D3C2CDB
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 14:17:09 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 20 Dec 2018 18:15:50 +0400
Message-Id: <20181220141553.24098-10-marcandre.lureau@redhat.com>
In-Reply-To: <20181220141553.24098-1-marcandre.lureau@redhat.com>
References: <20181220141553.24098-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 09/12] build-sys: add gio-2.0 check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kraxel@redhat.com

GIO is required for the -display app backend.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 configure | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/configure b/configure
index b0927b882a..dd0bcc2a10 100755
--- a/configure
+++ b/configure
@@ -3518,6 +3518,14 @@ for i in $glib_modules; do
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
@@ -6472,6 +6480,11 @@ if test "$gtk" =3D "yes" ; then
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
2.20.1.2.gb21ebb671b
