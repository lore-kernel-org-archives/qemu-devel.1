Received: from eggs.gnu.org ([2001:4830:134:3::10]:40419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKi-0006hz-Mw
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKh-0000PX-EJ
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:08 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:35403)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFjKf-0000Db-0J
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:06 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 13:20:55 -0400
Message-Id: <20181025172057.20414-47-cota@braap.org>
In-Reply-To: <20181025172057.20414-1-cota@braap.org>
References: <20181025172057.20414-1-cota@braap.org>
Subject: [Qemu-devel] [RFC 46/48] plugin: add plugin-chan PCI device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>

This will allow communication between guest and plugins.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 Makefile.target         |   2 +
 include/hw/pci/pci.h    |   2 +
 include/qemu/plugin.h   |   1 +
 hw/plugin/plugin-chan.c | 136 ++++++++++++++++++++++++++++++++++++++++
 plugin.c                |   4 ++
 5 files changed, 145 insertions(+)
 create mode 100644 hw/plugin/plugin-chan.c

diff --git a/Makefile.target b/Makefile.target
index 75637c285c..719699696d 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -156,6 +156,8 @@ else
 obj-y += hw/$(TARGET_BASE_ARCH)/
 endif
 
+obj-$(CONFIG_PLUGINS) += hw/plugin/plugin-chan.o
+
 GENERATED_FILES += hmp-commands.h hmp-commands-info.h
 
 endif # CONFIG_SOFTMMU
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index e6514bba23..6878d02254 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -86,6 +86,8 @@ extern bool pci_available;
 #define PCI_DEVICE_ID_VIRTIO_9P          0x1009
 #define PCI_DEVICE_ID_VIRTIO_VSOCK       0x1012
 
+#define PCI_DEVICE_ID_QEMU_PLUGIN_CHAN   0x10f0
+
 #define PCI_VENDOR_ID_REDHAT             0x1b36
 #define PCI_DEVICE_ID_REDHAT_BRIDGE      0x0001
 #define PCI_DEVICE_ID_REDHAT_SERIAL      0x0002
diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index c19071bdbe..f3c18d1032 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -196,6 +196,7 @@ void qemu_plugin_atexit_cb(void);
 void qemu_plugin_add_dyn_cb_arr(struct qemu_plugin_dyn_cb_arr *arr);
 int64_t plugin_get_clock(void);
 void plugin_lockstep_cb(void);
+void plugin_chan_xmit(uint32_t cmd, const void *data, size_t size);
 
 #else /* !CONFIG_PLUGINS */
 
diff --git a/hw/plugin/plugin-chan.c b/hw/plugin/plugin-chan.c
new file mode 100644
index 0000000000..c0749ce089
--- /dev/null
+++ b/hw/plugin/plugin-chan.c
@@ -0,0 +1,136 @@
+#include "qemu/osdep.h"
+#include "hw/pci/pci.h"
+#include "qemu/plugin.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+
+#define PLUGIN_CHAN_CFG_BAR    0
+#define PLUGIN_CHAN_CMD_BAR    1
+#define PLUGIN_CHAN_DATA_BAR   2
+
+struct plugin_chan_cfg {
+    uint32_t data_max_len;
+};
+
+struct plugin_chan {
+    PCIDevice dev;
+    MemoryRegion cfg_region;
+    MemoryRegion cmd_region;
+    MemoryRegion data_region;
+    void *data;
+    size_t data_size;
+    struct plugin_chan_cfg cfg;
+};
+
+static uint64_t chan_cfg_read(void *obj, hwaddr addr, unsigned size)
+{
+    struct plugin_chan *s = obj;
+
+    g_assert(size == 4);
+    switch (addr) {
+    case 0:
+        return s->cfg.data_max_len;
+        break;
+    }
+    g_assert_not_reached();
+    return 0;
+}
+
+static void chan_cmd_write(void *obj, hwaddr addr, uint64_t val, unsigned size)
+{
+    struct plugin_chan *s = obj;
+
+    g_assert(size == 4);
+    switch (addr) {
+    case 0:
+        plugin_chan_xmit(val, s->data_size ? s->data : NULL, s->data_size);
+        break;
+    case 4:
+        s->data_size = val;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static const MemoryRegionOps chan_cfg_ops = {
+    .read = chan_cfg_read,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static const MemoryRegionOps chan_cmd_ops = {
+    .write = chan_cmd_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void plugin_chan_realize(PCIDevice *pci_dev, Error **errp)
+{
+    struct plugin_chan *s = DO_UPCAST(struct plugin_chan, dev, pci_dev);
+    Error *err = NULL;
+
+    s->cfg.data_max_len = 4096;
+
+    pci_set_word(s->dev.config + PCI_COMMAND,
+                 PCI_COMMAND_IO | PCI_COMMAND_MEMORY);
+
+    /* data */
+    memory_region_init_ram(&s->data_region, OBJECT(s), "plugin_chan.data",
+                           pow2ceil(s->cfg.data_max_len), &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    pci_register_bar(&s->dev, PLUGIN_CHAN_DATA_BAR,
+                     PCI_BASE_ADDRESS_SPACE_MEMORY, &s->data_region);
+    s->data = qemu_map_ram_ptr(s->data_region.ram_block, 0);
+
+    /* config */
+    memory_region_init_io(&s->cfg_region, OBJECT(s), &chan_cfg_ops, s,
+                          "plugin_chan.cfg", sizeof(struct plugin_chan_cfg));
+    pci_register_bar(&s->dev, PLUGIN_CHAN_CFG_BAR,
+                     PCI_BASE_ADDRESS_SPACE_MEMORY, &s->cfg_region);
+
+    /* cmd */
+    memory_region_init_io(&s->cmd_region, OBJECT(s), &chan_cmd_ops, s,
+                          "plugin_chan.cmd", 8);
+    pci_register_bar(&s->dev, PLUGIN_CHAN_CMD_BAR,
+                     PCI_BASE_ADDRESS_SPACE_MEMORY, &s->cmd_region);
+}
+
+static void plugin_chan_class_init(ObjectClass *class, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(class);
+    PCIDeviceClass *p = PCI_DEVICE_CLASS(class);
+
+    p->realize = plugin_chan_realize;
+    p->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
+    p->device_id = PCI_DEVICE_ID_QEMU_PLUGIN_CHAN;
+    p->class_id = PCI_CLASS_MEMORY_RAM;
+    dc->desc = "Plugin communication channel between guest and host";
+}
+
+static TypeInfo plugin_chan_info = {
+    .name = "qemu-plugin-chan",
+    .parent = TYPE_PCI_DEVICE,
+    .instance_size = sizeof(struct plugin_chan),
+    .class_init = plugin_chan_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { }
+    },
+};
+
+static void plugin_chan_register_types(void)
+{
+    type_register_static(&plugin_chan_info);
+}
+
+type_init(plugin_chan_register_types)
diff --git a/plugin.c b/plugin.c
index 117f303249..2bbc14e2f3 100644
--- a/plugin.c
+++ b/plugin.c
@@ -1078,6 +1078,10 @@ void plugin_lockstep_cb(void)
     plugin_cb__simple(QEMU_PLUGIN_EV_LOCKSTEP);
 }
 
+void plugin_chan_xmit(uint32_t cmd, const void *data, size_t size)
+{
+}
+
 static void __attribute__((__constructor__)) plugin_init(void)
 {
     int i;
-- 
2.17.1
