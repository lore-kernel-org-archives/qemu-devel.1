Received: from eggs.gnu.org ([2001:4830:134:3::10]:33951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ezLlK-0005oj-84
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 08:25:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ezLlI-0002O6-Jd
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 08:25:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60664 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ezLlI-0002Nf-Et
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 08:25:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1EC54722CA
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 12:25:36 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 23 Mar 2018 13:25:17 +0100
Message-Id: <20180323122520.11270-5-kraxel@redhat.com>
In-Reply-To: <20180323122520.11270-1-kraxel@redhat.com>
References: <20180323122520.11270-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/7] hw/display: add ramfb-testdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, =?UTF-8?q?L=C3=A1szl=C3=B3=20=C3=89rsek?= <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Standalone device using ramfb.  Intended for testing only.  Offers
optional logging of vga port access, for debugging purposes.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/ramfb-testdev.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/display/Makefile.objs   |  1 +
 2 files changed, 97 insertions(+)
 create mode 100644 hw/display/ramfb-testdev.c

diff --git a/hw/display/ramfb-testdev.c b/hw/display/ramfb-testdev.c
new file mode 100644
index 0000000000..1e65cf4957
--- /dev/null
+++ b/hw/display/ramfb-testdev.c
@@ -0,0 +1,96 @@
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
+    bool vgalog;
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
+    if (ramfb->vgalog) {
+        isa_register_portio_list(ISA_DEVICE(dev), &ramfb->vga_port_list,
+                                 0x3b0, vga_portio_list, NULL, "log-vga");
+    }
+}
+
+static Property ramfb_properties[] = {
+    DEFINE_PROP_BOOL("vgalog", struct ISARAMFBState, vgalog, false),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void ramfb_class_initfn(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
+    dc->realize = ramfb_realizefn;
+    dc->props = ramfb_properties;
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
index fae17fd5ea..07d2f48782 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -1,4 +1,5 @@
 common-obj-y += ramfb.o
+common-obj-$(CONFIG_VGA_ISA) += ramfb-testdev.o
 
 common-obj-$(CONFIG_ADS7846) += ads7846.o
 common-obj-$(CONFIG_VGA_CIRRUS) += cirrus_vga.o
-- 
2.9.3
