Received: from eggs.gnu.org ([2001:4830:134:3::10]:42335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ePra5-0004F8-EW
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:07:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ePrZz-0000zF-HM
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:07:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ePrZz-0000xa-By
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:07:15 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 962782D1EEA
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 15:07:14 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 15 Dec 2017 16:06:47 +0100
Message-Id: <20171215150659.1811-2-marcandre.lureau@redhat.com>
In-Reply-To: <20171215150659.1811-1-marcandre.lureau@redhat.com>
References: <20171215150659.1811-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 01/13] build-sys: fix qemu-ga -pthread
 linking
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

When linking qemu-ga under some configuration (when gthread-2.0.pc
doesn't have -pthread, as happening atm with meson build), you may
have this linking issue:

/usr/bin/ld: libqemuutil.a(qemu-thread-posix.o): undefined reference to s=
ymbol 'pthread_setname_np@@GLIBC_2.12'
/usr/lib64/libpthread.so.0: error adding symbols: DSO missing from comman=
d line

Make sure qemu-ga links with the pthread library, by adding correct
flags to libs_qga.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 configure | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure b/configure
index 0c6e7572db..2b8c71f522 100755
--- a/configure
+++ b/configure
@@ -3436,6 +3436,7 @@ else
       done
       if test "$found" =3D "no"; then
         LIBS=3D"$pthread_lib $LIBS"
+        libs_qga=3D"$pthread_lib $libs_qga"
       fi
       PTHREAD_LIB=3D"$pthread_lib"
       break
--=20
2.15.1.355.g36791d7216
