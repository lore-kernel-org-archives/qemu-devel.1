Received: from eggs.gnu.org ([2001:4830:134:3::10]:51213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs1qA-0000mW-G7
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 04:16:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs1q7-0001PB-C1
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 04:16:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57410 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fs1q7-0001Oe-4D
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 04:16:35 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Aug 2018 10:16:30 +0200
Message-Id: <20180821081631.19160-4-kraxel@redhat.com>
In-Reply-To: <20180821081631.19160-1-kraxel@redhat.com>
References: <20180821081631.19160-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/4] hw/display/vga-isa-mm: Convert away from
 old_mmio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

Convert the vga-isa-mm device away from the old_mmio
MemoryRegion accessors.

This device is only used by the MIPS 'jazz' boards
"magnum" and "pica61".

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Tested-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Message-id: 20180802155147.1863-2-peter.maydell@linaro.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/vga-isa-mm.c | 60 +++++++++++--------------------------------=
------
 1 file changed, 13 insertions(+), 47 deletions(-)

diff --git a/hw/display/vga-isa-mm.c b/hw/display/vga-isa-mm.c
index 232216cad0..215e649719 100644
--- a/hw/display/vga-isa-mm.c
+++ b/hw/display/vga-isa-mm.c
@@ -36,64 +36,30 @@ typedef struct ISAVGAMMState {
 } ISAVGAMMState;
=20
 /* Memory mapped interface */
-static uint32_t vga_mm_readb (void *opaque, hwaddr addr)
+static uint64_t vga_mm_read(void *opaque, hwaddr addr, unsigned size)
 {
     ISAVGAMMState *s =3D opaque;
=20
-    return vga_ioport_read(&s->vga, addr >> s->it_shift) & 0xff;
+    return vga_ioport_read(&s->vga, addr >> s->it_shift) &
+        MAKE_64BIT_MASK(0, size * 8);
 }
=20
-static void vga_mm_writeb (void *opaque,
-                           hwaddr addr, uint32_t value)
+static void vga_mm_write(void *opaque, hwaddr addr, uint64_t value,
+                         unsigned size)
 {
     ISAVGAMMState *s =3D opaque;
=20
-    vga_ioport_write(&s->vga, addr >> s->it_shift, value & 0xff);
-}
-
-static uint32_t vga_mm_readw (void *opaque, hwaddr addr)
-{
-    ISAVGAMMState *s =3D opaque;
-
-    return vga_ioport_read(&s->vga, addr >> s->it_shift) & 0xffff;
-}
-
-static void vga_mm_writew (void *opaque,
-                           hwaddr addr, uint32_t value)
-{
-    ISAVGAMMState *s =3D opaque;
-
-    vga_ioport_write(&s->vga, addr >> s->it_shift, value & 0xffff);
-}
-
-static uint32_t vga_mm_readl (void *opaque, hwaddr addr)
-{
-    ISAVGAMMState *s =3D opaque;
-
-    return vga_ioport_read(&s->vga, addr >> s->it_shift);
-}
-
-static void vga_mm_writel (void *opaque,
-                           hwaddr addr, uint32_t value)
-{
-    ISAVGAMMState *s =3D opaque;
-
-    vga_ioport_write(&s->vga, addr >> s->it_shift, value);
+    vga_ioport_write(&s->vga, addr >> s->it_shift,
+                     value & MAKE_64BIT_MASK(0, size * 8));
 }
=20
 static const MemoryRegionOps vga_mm_ctrl_ops =3D {
-    .old_mmio =3D {
-        .read =3D {
-            vga_mm_readb,
-            vga_mm_readw,
-            vga_mm_readl,
-        },
-        .write =3D {
-            vga_mm_writeb,
-            vga_mm_writew,
-            vga_mm_writel,
-        },
-    },
+    .read =3D vga_mm_read,
+    .write =3D vga_mm_write,
+    .valid.min_access_size =3D 1,
+    .valid.max_access_size =3D 4,
+    .impl.min_access_size =3D 1,
+    .impl.max_access_size =3D 4,
     .endianness =3D DEVICE_NATIVE_ENDIAN,
 };
=20
--=20
2.9.3
