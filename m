Received: from eggs.gnu.org ([2001:4830:134:3::10]:46638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eN703-0006mc-TO
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 19:58:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eN700-0007Ze-48
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 19:58:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eN6zz-0007YQ-UE
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 19:58:44 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 05E6183F43
	for <qemu-devel@nongnu.org>; Fri,  8 Dec 2017 00:58:43 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  8 Dec 2017 01:58:17 +0100
Message-Id: <20171208005825.14587-5-marcandre.lureau@redhat.com>
In-Reply-To: <20171208005825.14587-1-marcandre.lureau@redhat.com>
References: <20171208005825.14587-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 04/12] build-sys: add AddressSanitizer when
 --enable-debug if possible
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Enable ASAN by default if the compiler supports it.

If necessary, we could consider a seperate configure option, although
I like the idea to have it enabled by default with --enable-debug, so
other people more actively fix errors/warnings, and having less
configure options in general.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 configure | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configure b/configure
index 2b8c71f522..52d9fd71e5 100755
--- a/configure
+++ b/configure
@@ -5129,6 +5129,11 @@ elif test "$fortify_source" =3D "yes" ; then
   CFLAGS=3D"-O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 $CFLAGS"
 elif test "$debug" =3D "no"; then
   CFLAGS=3D"-O2 $CFLAGS"
+elif test "$debug" =3D "yes"; then
+    write_c_skeleton;
+    if compile_prog "-fsanitize=3Daddress" ""; then
+        CFLAGS=3D"-fsanitize=3Daddress $CFLAGS"
+    fi
 fi
=20
 ##########################################
--=20
2.15.1.355.g36791d7216
