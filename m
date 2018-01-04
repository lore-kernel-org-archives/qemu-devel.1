Received: from eggs.gnu.org ([2001:4830:134:3::10]:36510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eX81z-0006WH-FN
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:06:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eX81t-00019z-CY
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:06:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eX81t-00017a-63
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:06:05 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 658ADAE451
	for <qemu-devel@nongnu.org>; Thu,  4 Jan 2018 16:06:04 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  4 Jan 2018 17:05:06 +0100
Message-Id: <20180104160523.22995-2-marcandre.lureau@redhat.com>
In-Reply-To: <20180104160523.22995-1-marcandre.lureau@redhat.com>
References: <20180104160523.22995-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 01/18] build-sys: fix qemu-ga -pthread
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
Cc: pbonzini@redhat.com, famz@redhat.com, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

When linking qemu-ga under some configuration (when gthread-2.0.pc
doesn't have -pthread, as happening atm with meson build), you may
have this linking issue:

/usr/bin/ld: libqemuutil.a(qemu-thread-posix.o): undefined reference to s=
ymbol 'pthread_setname_np@@GLIBC_2.12'
/usr/lib64/libpthread.so.0: error adding symbols: DSO missing from comman=
d line

Make sure qemu-ga links with the pthread library, by adding correct
flags to libs_qga.

This is really a QEMU bug, because it's QEMU code that's using pthread
functions, and so we must explicitly link against pthreads. The bug
was just masked by the fact that often some pkg-config or another for
one of our dependencies will add -pthread to the link line anyway.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 configure | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure b/configure
index 100309c33f..de1f939a28 100755
--- a/configure
+++ b/configure
@@ -3445,6 +3445,7 @@ else
       done
       if test "$found" =3D "no"; then
         LIBS=3D"$pthread_lib $LIBS"
+        libs_qga=3D"$pthread_lib $libs_qga"
       fi
       PTHREAD_LIB=3D"$pthread_lib"
       break
--=20
2.15.1.355.g36791d7216
