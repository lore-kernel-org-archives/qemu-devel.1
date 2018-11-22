Received: from eggs.gnu.org ([2001:4830:134:3::10]:50729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPmjG-0005as-Ui
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 06:01:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPmjE-0003lO-Hg
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 06:01:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:7018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gPmjE-0003kI-CJ
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 06:01:00 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Nov 2018 15:00:37 +0400
Message-Id: <20181122110039.15972-3-marcandre.lureau@redhat.com>
In-Reply-To: <20181122110039.15972-1-marcandre.lureau@redhat.com>
References: <20181122110039.15972-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 2/4] build-sys: move windows defines in
 osdep.h header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Stefan Weil <sw@weilnetz.de>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, samuel.thibault@ens-lyon.org, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

This removes some clutter in compilation logging, and allows some
easier tweaking per compilation unit/CFLAGS overriding.

Note that we can't move those define in os-win32.h, since they must be
set before the first system headers are included.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qemu/osdep.h | 17 +++++++++++++++++
 configure            |  3 ---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 3bf48bcdec..7b6e5db9d0 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -74,13 +74,30 @@ typedef __float128 _Float128;
 extern int daemon(int, int);
 #endif
=20
+#ifdef _WIN32
+/* as defined in sdkddkver.h */
+#ifndef WINVER
+#define WINVER 0x0501 /* XP */
+#endif
+/* reduces the number of implicitly included headers */
+#ifndef WIN32_LEAN_AND_MEAN
+#define WIN32_LEAN_AND_MEAN
+#endif
+#endif
+
 #include <stdarg.h>
 #include <stddef.h>
 #include <stdbool.h>
 #include <stdint.h>
 #include <sys/types.h>
 #include <stdlib.h>
+
+/* enable C99/POSIX format strings (needs mingw32-runtime 3.15 or later)=
 */
+#ifdef __MINGW32__
+#define __USE_MINGW_ANSI_STDIO 1
+#endif
 #include <stdio.h>
+
 #include <string.h>
 #include <strings.h>
 #include <inttypes.h>
diff --git a/configure b/configure
index 0a3c6a72c3..8c292ef994 100755
--- a/configure
+++ b/configure
@@ -905,9 +905,6 @@ fi
 if test "$mingw32" =3D "yes" ; then
   EXESUF=3D".exe"
   DSOSUF=3D".dll"
-  QEMU_CFLAGS=3D"-DWIN32_LEAN_AND_MEAN -DWINVER=3D0x501 $QEMU_CFLAGS"
-  # enable C99/POSIX format strings (needs mingw32-runtime 3.15 or later=
)
-  QEMU_CFLAGS=3D"-D__USE_MINGW_ANSI_STDIO=3D1 $QEMU_CFLAGS"
   # MinGW needs -mthreads for TLS and macro _MT.
   QEMU_CFLAGS=3D"-mthreads $QEMU_CFLAGS"
   LIBS=3D"-lwinmm -lws2_32 -liphlpapi $LIBS"
--=20
2.20.0.rc1
