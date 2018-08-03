Received: from eggs.gnu.org ([2001:4830:134:3::10]:40230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fle0c-0008CN-BY
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:37:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fle0Z-0001Um-9d
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:37:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41672 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fle0Z-0001UG-5C
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:36:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AD06D7A7EF
	for <qemu-devel@nongnu.org>; Fri,  3 Aug 2018 17:36:58 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  3 Aug 2018 19:36:13 +0200
Message-Id: <20180803173614.12358-10-marcandre.lureau@redhat.com>
In-Reply-To: <20180803173614.12358-1-marcandre.lureau@redhat.com>
References: <20180803173614.12358-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 09/10] build-sys: add gio-2.0 check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

GIO is required for the -display app backend.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 configure | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/configure b/configure
index 8a1371c55c..9f91752289 100755
--- a/configure
+++ b/configure
@@ -3483,6 +3483,14 @@ for i in $glib_modules; do
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
@@ -6344,6 +6352,11 @@ if test "$gtk" =3D "yes" ; then
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
2.18.0.547.g1d89318c48
