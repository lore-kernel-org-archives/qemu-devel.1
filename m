Received: from eggs.gnu.org ([2001:4830:134:3::10]:55574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1fZBKd-0003Xn-Qp
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 04:34:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1fZBKa-0001LE-K9
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 04:34:11 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:36894)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1fZBKa-0001Jk-Ae
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 04:34:08 -0400
Received: by mail-wr0-f180.google.com with SMTP id k6-v6so10853569wrp.4
	for <qemu-devel@nongnu.org>; Sat, 30 Jun 2018 01:34:08 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
Date: Sat, 30 Jun 2018 10:33:54 +0200
Message-Id: <20180630083357.23489-2-huth@tuxfamily.org>
In-Reply-To: <20180630083357.23489-1-huth@tuxfamily.org>
References: <20180630083357.23489-1-huth@tuxfamily.org>
Subject: [Qemu-devel] [PATCH v1 1/4] m68k: Add NeXTcube framebuffer device
 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Bryce Lanham <blanham@gmail.com>, Natalia Portillo <claunia@claunia.com>

The NeXTcube uses a linear framebuffer with 4 greyscale colors and
a fixed resolution of 1120 * 832.
This code has been taken from Bryce Lanham's GSoC 2011 NeXT branch at

 https://github.com/blanham/qemu-NeXT/blob/next-cube/hw/next-fb.c

and altered to fit the latest interface of the current QEMU (e.g.
the device has been "qdev"-ified etc.).

Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 default-configs/m68k-softmmu.mak |   2 +
 hw/display/Makefile.objs         |   1 +
 hw/display/next-fb.c             | 152 +++++++++++++++++++++++++++++++
 include/hw/m68k/next-cube.h      |   8 ++
 4 files changed, 163 insertions(+)
 create mode 100644 hw/display/next-fb.c
 create mode 100644 include/hw/m68k/next-cube.h

diff --git a/default-configs/m68k-softmmu.mak b/default-configs/m68k-softmmu.mak
index 60f7cdfbf2..d3248a6506 100644
--- a/default-configs/m68k-softmmu.mak
+++ b/default-configs/m68k-softmmu.mak
@@ -2,3 +2,5 @@
 
 CONFIG_COLDFIRE=y
 CONFIG_PTIMER=y
+CONFIG_NEXTCUBE=y
+CONFIG_FRAMEBUFFER=y
diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index fb8408c6d0..c91a660ad2 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -34,6 +34,7 @@ obj-$(CONFIG_RASPI) += bcm2835_fb.o
 obj-$(CONFIG_SM501) += sm501.o
 obj-$(CONFIG_TCX) += tcx.o
 obj-$(CONFIG_CG3) += cg3.o
+obj-$(CONFIG_NEXTCUBE) += next-fb.o
 
 obj-$(CONFIG_VGA) += vga.o
 
diff --git a/hw/display/next-fb.c b/hw/display/next-fb.c
new file mode 100644
index 0000000000..f4248405df
--- /dev/null
+++ b/hw/display/next-fb.c
@@ -0,0 +1,152 @@
+/*
+ * NeXT Cube/Station Framebuffer Emulation
+ *
+ * Copyright (c) 2011 Bryce Lanham
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+#include "qemu/osdep.h"
+#include "hw/hw.h"
+#include "hw/boards.h"
+#include "hw/loader.h"
+#include "hw/display/framebuffer.h"
+#include "ui/console.h"
+#define BITS 8
+#include "ui/pixel_ops.h"
+#include "hw/m68k/next-cube.h"
+
+#define TYPE_NEXTFB "next-fb"
+#define NEXTFB(obj) OBJECT_CHECK(NeXTFbState, (obj), TYPE_NEXTFB)
+
+struct NeXTFbState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion fb_mr;
+    MemoryRegionSection fbsection;
+    QemuConsole *con;
+
+    uint32_t pitch;
+    uint32_t cols;
+    uint32_t rows;
+    int invalidate;
+};
+typedef struct NeXTFbState NeXTFbState;
+
+static void nextfb_draw_line(void *opaque, uint8_t *d, const uint8_t *s,
+                             int width, int pitch)
+{
+    NeXTFbState *nfbstate = NEXTFB(opaque);
+    uint32_t pal[4] = { 0xFFFFFFFF, 0xFFAAAAAA, 0xFF555555, 0xFF000000 };
+    uint32_t *buf = (uint32_t *)d;
+    int i = 0;
+
+    for (i = 0; i < nfbstate->cols / 4; i++) {
+        int j = i * 4;
+        uint8_t src = s[i];
+        buf[j + 3] = pal[src & 0x3];
+        src >>= 2;
+        buf[j + 2] = pal[src & 0x3];
+        src >>= 2;
+        buf[j + 1] = pal[src & 0x3];
+        src >>= 2;
+        buf[j + 0] = pal[src & 0x3];
+    }
+}
+
+static void nextfb_update(void *opaque)
+{
+    NeXTFbState *s = NEXTFB(opaque);
+    int dest_width = 4;
+    int src_width;
+    int first = 0;
+    int last  = 0;
+    DisplaySurface *surface = qemu_console_surface(s->con);
+
+    src_width = s->cols / 4 + 8;
+    dest_width = s->cols * 4;
+
+    if (s->invalidate) {
+        framebuffer_update_memory_section(&s->fbsection, &s->fb_mr, 0,
+                                          s->cols, src_width);
+        s->invalidate = 0;
+    }
+
+    framebuffer_update_display(surface, &s->fbsection, 1120, 832,
+                               src_width, dest_width, 0, 1, nextfb_draw_line,
+                               s, &first, &last);
+
+    dpy_gfx_update(s->con, 0, 0, 1120, 832);
+}
+
+static void nextfb_invalidate(void *opaque)
+{
+    NeXTFbState *s = NEXTFB(opaque);
+    s->invalidate = 1;
+}
+
+static const GraphicHwOps nextfb_ops = {
+    .invalidate  = nextfb_invalidate,
+    .gfx_update  = nextfb_update,
+};
+
+static void nextfb_realize(DeviceState *dev, Error **errp)
+{
+    NeXTFbState *s = NEXTFB(dev);
+
+    memory_region_allocate_system_memory(&s->fb_mr, NULL, "next.video",
+                                         0x1CB100);
+    memory_region_add_subregion(get_system_memory(), 0xB000000, &s->fb_mr);
+
+    s->invalidate = 1;
+    s->cols = 1120;
+    s->rows = 832;
+
+    s->con = graphic_console_init(dev, 0, &nextfb_ops, s);
+    qemu_console_resize(s->con, s->cols, s->rows);
+}
+
+static void nextfb_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
+    dc->realize = nextfb_realize;
+}
+
+static const TypeInfo nextfb_info = {
+    .name          = TYPE_NEXTFB,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(NeXTFbState),
+    .class_init    = nextfb_class_init,
+};
+
+static void nextfb_register_types(void)
+{
+    type_register_static(&nextfb_info);
+}
+
+type_init(nextfb_register_types)
+
+void nextfb_init(void)
+{
+    DeviceState *dev;
+
+    dev = qdev_create(NULL, TYPE_NEXTFB);
+    qdev_init_nofail(dev);
+}
diff --git a/include/hw/m68k/next-cube.h b/include/hw/m68k/next-cube.h
new file mode 100644
index 0000000000..cf07243bda
--- /dev/null
+++ b/include/hw/m68k/next-cube.h
@@ -0,0 +1,8 @@
+
+#ifndef NEXT_CUBE_H
+#define NEXT_CUBE_H
+
+/* next-fb.c */
+void nextfb_init(void);
+
+#endif /* NEXT_CUBE_H */
-- 
2.17.1
