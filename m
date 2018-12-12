Received: from eggs.gnu.org ([2001:4830:134:3::10]:52321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6Ma-0000rR-Hp
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6MX-0000EP-9X
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:52 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:42667)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gX6MW-00006K-Ue
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:49 -0500
Received: by mail-wr1-x430.google.com with SMTP id q18so18082005wrx.9
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 07:23:40 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Dec 2018 16:22:40 +0100
Message-Id: <1544628195-37728-20-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
References: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 19/54] build-sys: move windows defines in
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

This removes some clutter in compilation logging, and allows some
easier tweaking per compilation unit/CFLAGS overriding.

Note that we can't move those define in os-win32.h, since they must be
set before the first system headers are included.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20181122110039.15972-3-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure            |  3 ---
 include/qemu/osdep.h | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 0a3c6a7..8c292ef 100755
--- a/configure
+++ b/configure
@@ -905,9 +905,6 @@ fi
 if test "$mingw32" = "yes" ; then
   EXESUF=".exe"
   DSOSUF=".dll"
-  QEMU_CFLAGS="-DWIN32_LEAN_AND_MEAN -DWINVER=0x501 $QEMU_CFLAGS"
-  # enable C99/POSIX format strings (needs mingw32-runtime 3.15 or later)
-  QEMU_CFLAGS="-D__USE_MINGW_ANSI_STDIO=1 $QEMU_CFLAGS"
   # MinGW needs -mthreads for TLS and macro _MT.
   QEMU_CFLAGS="-mthreads $QEMU_CFLAGS"
   LIBS="-lwinmm -lws2_32 -liphlpapi $LIBS"
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 3bf48bc..7b6e5db 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -74,13 +74,30 @@ typedef __float128 _Float128;
 extern int daemon(int, int);
 #endif
 
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
+/* enable C99/POSIX format strings (needs mingw32-runtime 3.15 or later) */
+#ifdef __MINGW32__
+#define __USE_MINGW_ANSI_STDIO 1
+#endif
 #include <stdio.h>
+
 #include <string.h>
 #include <strings.h>
 #include <inttypes.h>
-- 
1.8.3.1
