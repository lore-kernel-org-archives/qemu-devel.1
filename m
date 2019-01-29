Received: from [209.51.188.92] (port=50648 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goUv1-0000t6-Ux
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:03:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goUtW-0003lN-5x
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:01:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:29093)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1goUtU-0003jY-51
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:01:46 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue, 29 Jan 2019 16:00:27 +0100
Message-Id: <20190129150029.29829-4-philmd@redhat.com>
In-Reply-To: <20190129150029.29829-1-philmd@redhat.com>
References: <20190129150029.29829-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 3/5] hw/display/milkymist-tmu2: Explicit the
 dependency to both X11 / OpenGL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Michael Walle <michael@walle.cc>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Brad Smith <brad@comstyle.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

The TMU device requires both X11 and OpenGL.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 default-configs/lm32-softmmu.mak | 2 +-
 hw/display/Makefile.objs         | 4 ++--
 hw/lm32/milkymist-hw.h           | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/default-configs/lm32-softmmu.mak b/default-configs/lm32-soft=
mmu.mak
index 4889348a10..4049b23562 100644
--- a/default-configs/lm32-softmmu.mak
+++ b/default-configs/lm32-softmmu.mak
@@ -2,7 +2,7 @@
=20
 CONFIG_LM32=3Dy
 CONFIG_MILKYMIST=3Dy
-CONFIG_MILKYMIST_TMU2=3D$(CONFIG_OPENGL)
+CONFIG_MILKYMIST_TMU2=3D$(call land,$(CONFIG_X11),$(CONFIG_OPENGL))
 CONFIG_FRAMEBUFFER=3Dy
 CONFIG_PTIMER=3Dy
 CONFIG_PFLASH_CFI01=3Dy
diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index 5b770817c7..7c4ae9a0fd 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -29,8 +29,8 @@ obj-$(CONFIG_MILKYMIST) +=3D milkymist-vgafb.o
 common-obj-$(CONFIG_ZAURUS) +=3D tc6393xb.o
=20
 obj-$(CONFIG_MILKYMIST_TMU2) +=3D milkymist-tmu2.o
-milkymist-tmu2.o-cflags :=3D $(X11_CFLAGS)
-milkymist-tmu2.o-libs :=3D $(X11_LIBS)
+milkymist-tmu2.o-cflags :=3D $(X11_CFLAGS) $(OPENGL_CFLAGS)
+milkymist-tmu2.o-libs :=3D $(X11_LIBS) $(OPENGL_LIBS)
=20
 obj-$(CONFIG_OMAP) +=3D omap_dss.o
 obj-$(CONFIG_OMAP) +=3D omap_lcdc.o
diff --git a/hw/lm32/milkymist-hw.h b/hw/lm32/milkymist-hw.h
index d3be0cfb3a..32c344ef9f 100644
--- a/hw/lm32/milkymist-hw.h
+++ b/hw/lm32/milkymist-hw.h
@@ -88,7 +88,7 @@ static inline DeviceState *milkymist_pfpu_create(hwaddr=
 base,
     return dev;
 }
=20
-#ifdef CONFIG_OPENGL
+#if defined(CONFIG_X11) && defined(CONFIG_OPENGL)
 #include <X11/Xlib.h>
 #include <epoxy/gl.h>
 #include <epoxy/glx.h>
@@ -103,7 +103,7 @@ static const int glx_fbconfig_attr[] =3D {
 static inline DeviceState *milkymist_tmu2_create(hwaddr base,
         qemu_irq irq)
 {
-#ifdef CONFIG_OPENGL
+#if defined(CONFIG_X11) && defined(CONFIG_OPENGL)
     DeviceState *dev;
     Display *d;
     GLXFBConfig *configs;
--=20
2.20.1
