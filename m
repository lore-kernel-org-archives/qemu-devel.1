Received: from eggs.gnu.org ([2001:4830:134:3::10]:37758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eX83j-00081H-I2
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:08:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eX83i-0004Tu-R2
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:07:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:11766)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eX83i-0004Su-Kd
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:07:58 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D60BCC051664
	for <qemu-devel@nongnu.org>; Thu,  4 Jan 2018 16:07:57 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  4 Jan 2018 17:05:12 +0100
Message-Id: <20180104160523.22995-8-marcandre.lureau@redhat.com>
In-Reply-To: <20180104160523.22995-1-marcandre.lureau@redhat.com>
References: <20180104160523.22995-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 07/18] build-sys: add some sanitizers when
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
Cc: pbonzini@redhat.com, famz@redhat.com, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Enable ASAN/UBSan by default if the compiler supports it.

Typical slowdown introduced by AddressSanitizer is 2x.
UBSan shouldn't have much impact on runtime cost.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 configure | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configure b/configure
index 3953859314..de1477c93a 100755
--- a/configure
+++ b/configure
@@ -5161,6 +5161,13 @@ if test "$gcov" =3D "yes" ; then
 elif test "$fortify_source" =3D "yes" ; then
   CFLAGS=3D"-O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 $CFLAGS"
 elif test "$debug" =3D "yes"; then
+  write_c_skeleton;
+  if compile_prog "-fsanitize=3Daddress" ""; then
+      CFLAGS=3D"-fsanitize=3Daddress $CFLAGS"
+  fi
+  if compile_prog "-fsanitize=3Dundefined" ""; then
+      CFLAGS=3D"-fsanitize=3Dundefined $CFLAGS"
+  fi
   if compile_prog "-Og" ""; then
       CFLAGS=3D"-Og $CFLAGS"
   elif compile_prog "-O1" ""; then
--=20
2.15.1.355.g36791d7216
