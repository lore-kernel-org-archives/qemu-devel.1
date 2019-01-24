Received: from eggs.gnu.org ([209.51.188.92]:40334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmTwh-0004FZ-Rs
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 20:36:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmTwh-0005b7-38
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 20:36:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gmTwd-0005Kk-Fl
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 20:36:42 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Thu, 24 Jan 2019 02:36:25 +0100
Message-Id: <20190124013625.27239-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH] ui/egl: Silent '__HAIKU__ undefined'
 warnings on OpenBSD 6.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Brad Smith <brad@comstyle.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

OpenBSD display various warnings about the use of an undefined __HAIKU__:

    CC      ui/egl-context.o
  In file included from /usr/X11R6/include/epoxy/egl_generated.h:10:0,
                   from /usr/X11R6/include/epoxy/egl.h:46,
                   from include/ui/egl-helpers.h:5,
                   from include/ui/egl-context.h:5,
                   from ui/egl-context.c:3:
  /usr/X11R6/include/EGL/eglplatform.h:128:7: warning: "__HAIKU__" is not=
 defined [-Wundef]
   #elif __HAIKU__
         ^
  CC      ui/egl-helpers.o
/usr/X11R6/include/EGL/eglplatform.h:128:7: warning: "__HAIKU__" is not d=
efined [-Wundef]
  CC      ui/egl-headless.o
/usr/X11R6/include/EGL/eglplatform.h:128:7: warning: "__HAIKU__" is not d=
efined [-Wundef]

This is due to a old <epoxy/egl_generated.h>:

     70 #if defined(_WIN32) || defined(__VC32__) && !defined(__CYGWIN__) =
&& !defined(__SCITECH_SNAP__) /* Win32 and WinCE */
        ...
    108 #elif defined(__unix__) || defined(__APPLE__)
    128 #elif __HAIKU__
    134 #else
    135 #error "Platform not recognized"
    136 #endif

Kludge this by adding a check to ./configure: if this warning occurs,
define __HAIKU__ from the CFLAGS.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
This is ugly, hopefully someone can come with a clever idea :)

 configure | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/configure b/configure
index 8f312ac3e2..7c7eee44da 100755
--- a/configure
+++ b/configure
@@ -4036,6 +4036,17 @@ EOF
   if compile_prog "" "" ; then
     opengl_dmabuf=3Dyes
   fi
+  cat > $TMPC << EOF
+#include <epoxy/egl.h>
+int main(void) { return 0; }
+EOF
+  if test "$targetos" =3D "OpenBSD" ; then
+    if ! compile_prog "-Wundef -Werror" "" ; then
+      if compile_prog "-Wundef -Werror -D__HAIKU__=3D0" "" ; then
+        QEMU_CFLAGS=3D"$QEMU_CFLAGS -D__HAIKU__=3D0"
+      fi
+    fi
+  fi
 fi
=20
 ##########################################
--=20
2.20.1
