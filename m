Received: from eggs.gnu.org ([2001:4830:134:3::10]:51735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFfOM-00046L-AB
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 07:05:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFfOG-0006Vr-9i
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 07:05:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eFfOF-0006Uw-W9
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 07:05:00 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 332358763A
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 12:04:59 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 17 Nov 2017 13:04:54 +0100
Message-Id: <20171117120454.13507-5-kraxel@redhat.com>
In-Reply-To: <20171117120454.13507-1-kraxel@redhat.com>
References: <20171117120454.13507-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 4/4] add ramfb-testdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?L=C3=A1szl=C3=B3=20=C3=89rsek?= <lersek@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

---
 hw/display/ramfb-testdev.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/display/Makefile.objs   |  1 +
 2 files changed, 88 insertions(+)
 create mode 100644 hw/display/ramfb-testdev.c

diff --git a/hw/display/ramfb-testdev.c b/hw/display/ramfb-testdev.c
new file mode 100644
index 0000000000..1310ac1288
--- /dev/null
+++ b/hw/display/ramfb-testdev.c
@@ -0,0 +1,87 @@
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/loader.h"
+#include "hw/isa/isa.h"
+#include "hw/display/ramfb.h"
+#include "ui/console.h"
+#include "sysemu/sysemu.h"
+
+#define TYPE_RAMFB "ramfb-testdev"
+#define RAMFB(obj) OBJECT_CHECK(ISARAMFBState, (obj), TYPE_RAMFB)
+
+typedef struct ISARAMFBState {
+    ISADevice parent_obj;
+    QemuConsole *con;
+    RAMFBState *state;
+    PortioList vga_port_list;
+} ISARAMFBState;
+
+/* log vga port activity, for trouble-shooting purposes */
+static uint32_t vga_log_read(void *opaque, uint32_t addr)
+{
+    fprintf(stderr, "%s: port 0x%x\n", __func__, addr);
+    return -1;
+}
+
+static void vga_log_write(void *opaque, uint32_t addr, uint32_t val)
+{
+    fprintf(stderr, "%s: port 0x%x, value 0x%x\n", __func__, addr, val);
+}
+
+static const MemoryRegionPortio vga_portio_list[] = {
+    { 0x04,  2, 1, .read = vga_log_read, .write = vga_log_write }, /* 3b4 */
+    { 0x0a,  1, 1, .read = vga_log_read, .write = vga_log_write }, /* 3ba */
+    { 0x10, 16, 1, .read = vga_log_read, .write = vga_log_write }, /* 3c0 */
+    { 0x24,  2, 1, .read = vga_log_read, .write = vga_log_write }, /* 3d4 */
+    { 0x2a,  1, 1, .read = vga_log_read, .write = vga_log_write }, /* 3da */
+    PORTIO_END_OF_LIST(),
+};
+
+static void display_update_wrapper(void *dev)
+{
+    ISARAMFBState *ramfb = RAMFB(dev);
+
+    if (0 /* native driver active */) {
+        /* non-test device would run native display update here */;
+    } else {
+        ramfb_display_update(ramfb->con, ramfb->state);
+    }
+}
+
+static const GraphicHwOps wrapper_ops = {
+    .gfx_update = display_update_wrapper,
+};
+
+static void ramfb_realizefn(DeviceState *dev, Error **errp)
+{
+    ISARAMFBState *ramfb = RAMFB(dev);
+
+    ramfb->con = graphic_console_init(dev, 0, &wrapper_ops, dev);
+    ramfb->state = ramfb_setup(errp);
+
+    isa_register_portio_list(ISA_DEVICE(dev), &ramfb->vga_port_list,
+                             0x3b0, vga_portio_list, NULL, "vga");
+}
+
+static void ramfb_class_initfn(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
+    dc->realize = ramfb_realizefn;
+    dc->desc = "ram framebuffer test device";
+}
+
+static const TypeInfo ramfb_info = {
+    .name          = TYPE_RAMFB,
+    .parent        = TYPE_ISA_DEVICE,
+    .instance_size = sizeof(ISARAMFBState),
+    .class_init    = ramfb_class_initfn,
+};
+
+static void ramfb_register_types(void)
+{
+    type_register_static(&ramfb_info);
+}
+
+type_init(ramfb_register_types)
diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index 646012478f..2c9a2e2ef6 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -1,4 +1,5 @@
 common-obj-y += ramfb.o
+common-obj-$(CONFIG_VGA_ISA) += ramfb-testdev.o
 
 common-obj-$(CONFIG_ADS7846) += ads7846.o
 common-obj-$(CONFIG_VGA_CIRRUS) += cirrus_vga.o
-- 
2.9.3
