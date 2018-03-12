Received: from eggs.gnu.org ([2001:4830:134:3::10]:44705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1evSIc-0008KY-DC
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:35:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1evSIZ-0005SS-8j
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:35:54 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:37678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <x1917x@gmail.com>) id 1evSIZ-0005SB-2X
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:35:51 -0400
Received: by mail-pl0-x243.google.com with SMTP id w12-v6so9830422plp.4
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 11:35:50 -0700 (PDT)
From: Alexey Gerasimenko <x1917x@gmail.com>
Date: Tue, 13 Mar 2018 04:34:05 +1000
Message-Id: <b3ead8688cf6c45db259239586b1957050c5546b.1520867956.git.x1917x@gmail.com>
In-Reply-To: <cover.1520867740.git.x1917x@gmail.com>
References: <cover.1520867740.git.x1917x@gmail.com>
In-Reply-To: <cover.1520867740.git.x1917x@gmail.com>
References: <cover.1520867740.git.x1917x@gmail.com>
Subject: [Qemu-devel] [RFC PATCH 20/30] xen/pt: determine the legacy/PCIe
 mode for a passed through device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xen-devel@lists.xenproject.org
Cc: Alexey Gerasimenko <x1917x@gmail.com>, qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>

Even if we have some real PCIe device being passed through to a guest,
there are situations when we cannot use its PCIe features, primarily
allowing to access extended (>256) config space.

Basically, we can allow reading PCIe extended config space only if both
the device and emulated system are PCIe-capable. So it's a combination
of checks:
- PCI Express capability presence
- pci_is_express(device)
- pci_bus_is_express(device bus)

The AND-product of these checks is stored to pcie_enabled_dev flag
in XenPCIPassthroughState for later use in functions like
xen_pt_pci_config_access_check.

This way we get consistent behavior when the same PCIe device being passed
through to either i440 domain or Q35 one.

Signed-off-by: Alexey Gerasimenko <x1917x@gmail.com>
---
 hw/xen/xen_pt.c | 28 ++++++++++++++++++++++++++--
 hw/xen/xen_pt.h |  1 +
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index 9b7a960de1..a902a9b685 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -687,6 +687,21 @@ static const MemoryListener xen_pt_io_listener = {
     .priority = 10,
 };
 
+static inline bool xen_pt_dev_is_pcie_mode(PCIDevice *d)
+{
+    XenPCIPassthroughState *s = XEN_PT_DEVICE(d);
+    PCIBus *bus = pci_get_bus(d);
+
+    if (bus != NULL) {
+        if (pci_is_express(d) && pci_bus_is_express(bus) &&
+            xen_host_pci_find_next_cap(&s->real_device, 0, PCI_CAP_ID_EXP)) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
 static void
 xen_igd_passthrough_isa_bridge_create(XenPCIPassthroughState *s,
                                       XenHostPCIDevice *dev)
@@ -794,8 +809,17 @@ static void xen_pt_realize(PCIDevice *d, Error **errp)
                    s->real_device.dev, s->real_device.func);
     }
 
-    /* Initialize virtualized PCI configuration (Extended 256 Bytes) */
-    memset(d->config, 0, PCI_CONFIG_SPACE_SIZE);
+    s->pcie_enabled_dev = xen_pt_dev_is_pcie_mode(d);
+    if (s->pcie_enabled_dev) {
+        XEN_PT_LOG(d, "Host device %04x:%02x:%02x.%d passed thru "
+                   "in PCIe mode\n", s->real_device.domain,
+                    s->real_device.bus, s->real_device.dev,
+                    s->real_device.func);
+    }
+
+    /* Initialize virtualized PCI configuration space (256/4K bytes) */
+    memset(d->config, 0, pci_is_express(d) ? PCIE_CONFIG_SPACE_SIZE
+                                           : PCI_CONFIG_SPACE_SIZE);
 
     s->memory_listener = xen_pt_memory_listener;
     s->io_listener = xen_pt_io_listener;
diff --git a/hw/xen/xen_pt.h b/hw/xen/xen_pt.h
index aa39a9aa5f..1204acbdce 100644
--- a/hw/xen/xen_pt.h
+++ b/hw/xen/xen_pt.h
@@ -212,6 +212,7 @@ struct XenPCIPassthroughState {
 
     PCIHostDeviceAddress hostaddr;
     bool is_virtfn;
+    bool pcie_enabled_dev;
     bool permissive;
     bool permissive_warned;
     XenHostPCIDevice real_device;
-- 
2.11.0
