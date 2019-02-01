Received: from eggs.gnu.org ([209.51.188.92]:60633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gpXz0-0002Vq-Pn
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 07:31:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gpXyv-0004jD-4T
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 07:31:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gpXyt-0004ex-PA
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 07:31:41 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  1 Feb 2019 13:30:57 +0100
Message-Id: <20190201123100.27419-3-kraxel@redhat.com>
In-Reply-To: <20190201123100.27419-1-kraxel@redhat.com>
References: <20190201123100.27419-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/5] configure: LM32 Milkymist Texture Mapping
 Unit (tmu2) also depends of X11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Michael Walle <michael@walle.cc>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Commit 5f9b1e35060b8 remove the dependency between OpenGL and X11.
However the milkymist-tmu2 device do require X11.
When using SDL, the configure script sets need_x11=3Dyes, so the X11
flags are populated to the makefiles.
When building without SDL, X11 is not pulled and populated, leading
to a link failure:

    LINK    lm32-softmmu/qemu-system-lm32
  hw/lm32/milkymist.o: In function `milkymist_tmu2_create':
  hw/lm32/milkymist-hw.h:114: undefined reference to `XOpenDisplay'
  hw/lm32/milkymist-hw.h:140: undefined reference to `XFree'
  hw/lm32/milkymist-hw.h:141: undefined reference to `XCloseDisplay'
  hw/lm32/milkymist-hw.h:130: undefined reference to `XCloseDisplay'
  ../hw/display/milkymist-tmu2.o: In function `tmu2_glx_init':
  hw/display/milkymist-tmu2.c:112: undefined reference to `XOpenDisplay'
  hw/display/milkymist-tmu2.c:123: undefined reference to `XFree'
  collect2: error: ld returned 1 exit status
  gmake[1]: *** [Makefile:199: qemu-system-lm32] Error 1

Enforce the X11 dependency when the LM32 target is built.
This will allow us to build QEMU without SDL.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20190130120005.23123-3-philmd@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 configure | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/configure b/configure
index b18281c61f..c7024d6662 100755
--- a/configure
+++ b/configure
@@ -4047,6 +4047,16 @@ EOF
   fi
 fi
=20
+if test "$opengl" =3D "yes" -a "$have_x11" =3D "yes"; then
+  for target in $target_list; do
+    case $target in
+      lm32-softmmu) # milkymist-tmu2 requires X11 and OpenGL
+        need_x11=3Dyes
+      ;;
+    esac
+  done
+fi
+
 ##########################################
 # libxml2 probe
 if test "$libxml2" !=3D "no" ; then
--=20
2.9.3
