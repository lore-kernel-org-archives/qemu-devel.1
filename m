Received: from eggs.gnu.org ([2001:4830:134:3::10]:44642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1evSIT-0008A1-2E
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:35:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1evSIR-0005Nt-SJ
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:35:45 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:43623)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <x1917x@gmail.com>) id 1evSIR-0005Ms-K5
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:35:43 -0400
Received: by mail-pf0-x242.google.com with SMTP id j2so4723218pff.10
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 11:35:43 -0700 (PDT)
From: Alexey Gerasimenko <x1917x@gmail.com>
Date: Tue, 13 Mar 2018 04:34:03 +1000
Message-Id: <ed61d0ef5ff1326c045a585e49e492e5776a6d96.1520867956.git.x1917x@gmail.com>
In-Reply-To: <cover.1520867740.git.x1917x@gmail.com>
References: <cover.1520867740.git.x1917x@gmail.com>
In-Reply-To: <cover.1520867740.git.x1917x@gmail.com>
References: <cover.1520867740.git.x1917x@gmail.com>
Subject: [Qemu-devel] [RFC PATCH 18/30] xen/pt: XenHostPCIDevice: provide
 functions for PCI Capabilities and PCIe Extended Capabilities enumeration
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

This patch introduces 2 new functions,
- xen_host_pci_find_next_ext_cap (actually a reworked
  xen_host_pci_find_ext_cap_offset function which is unused)
- xen_host_pci_find_next_cap

These functions allow to search for PCI/PCIe capabilities in a uniform
way. Both functions allow to search either a specific capability or any
encountered next (by specifying CAP_ID_ANY as a capability ID) -- this may
be useful when we merely need to traverse the capability list one-by-one.
In both functions the 'pos' argument allows to continue searching from
last position (0 means to start from beginning).

In order not to probe PCIe Extended Capabilities existence every time,
xen_host_pci_find_next_ext_cap makes use of the new 'has_pcie_ext_caps'
field in XenHostPCIDevice structure which is filled only once (in
xen_host_pci_device_get).

Signed-off-by: Alexey Gerasimenko <x1917x@gmail.com>
---
 hw/xen/xen-host-pci-device.c | 95 +++++++++++++++++++++++++++++++++++++-------
 hw/xen/xen-host-pci-device.h |  5 ++-
 2 files changed, 85 insertions(+), 15 deletions(-)

diff --git a/hw/xen/xen-host-pci-device.c b/hw/xen/xen-host-pci-device.c
index eed8cc88e3..9d76b199af 100644
--- a/hw/xen/xen-host-pci-device.c
+++ b/hw/xen/xen-host-pci-device.c
@@ -14,6 +14,7 @@
 
 #define XEN_HOST_PCI_MAX_EXT_CAP \
     ((PCIE_CONFIG_SPACE_SIZE - PCI_CONFIG_SPACE_SIZE) / (PCI_CAP_SIZEOF + 4))
+#define XEN_HOST_PCI_CAP_MAX 48
 
 #ifdef XEN_HOST_PCI_DEVICE_DEBUG
 #  define XEN_HOST_PCI_LOG(f, a...) fprintf(stderr, "%s: " f, __func__, ##a)
@@ -199,6 +200,19 @@ static bool xen_host_pci_dev_is_virtfn(XenHostPCIDevice *d)
     return !stat(path, &buf);
 }
 
+static bool xen_host_pci_dev_has_pcie_ext_caps(XenHostPCIDevice *d)
+{
+    uint32_t header;
+
+    if (xen_host_pci_get_long(d, PCI_CONFIG_SPACE_SIZE, &header))
+        return false;
+
+    if (header == 0 || header == ~0U)
+        return false;
+
+    return true;
+}
+
 static void xen_host_pci_config_open(XenHostPCIDevice *d, Error **errp)
 {
     char path[PATH_MAX];
@@ -297,37 +311,89 @@ int xen_host_pci_set_block(XenHostPCIDevice *d, int pos, uint8_t *buf, int len)
     return xen_host_pci_config_write(d, pos, buf, len);
 }
 
-int xen_host_pci_find_ext_cap_offset(XenHostPCIDevice *d, uint32_t cap)
+int xen_host_pci_find_next_ext_cap(XenHostPCIDevice *d, int pos, uint32_t cap)
 {
     uint32_t header = 0;
     int max_cap = XEN_HOST_PCI_MAX_EXT_CAP;
-    int pos = PCI_CONFIG_SPACE_SIZE;
+
+    if (!d->has_pcie_ext_caps)
+        return 0;
+
+    if (!pos) {
+        pos = PCI_CONFIG_SPACE_SIZE;
+    } else {
+        if (xen_host_pci_get_long(d, pos, &header))
+            return 0;
+
+        pos = PCI_EXT_CAP_NEXT(header);
+    }
 
     do {
-        if (xen_host_pci_get_long(d, pos, &header)) {
+        if (!pos || pos < PCI_CONFIG_SPACE_SIZE)
+            break;
+
+        if (xen_host_pci_get_long(d, pos, &header))
             break;
-        }
         /*
          * If we have no capabilities, this is indicated by cap ID,
          * cap version and next pointer all being 0.
+         * Also check for all F's returned (which means PCIe ext conf space
+         * is unreadable for some reason)
          */
-        if (header == 0) {
+        if (header == 0 || header == ~0U)
             break;
-        }
 
-        if (PCI_EXT_CAP_ID(header) == cap) {
+        if (cap == CAP_ID_ANY)
+            return pos;
+        else if (PCI_EXT_CAP_ID(header) == cap)
             return pos;
-        }
 
         pos = PCI_EXT_CAP_NEXT(header);
-        if (pos < PCI_CONFIG_SPACE_SIZE) {
+    } while (--max_cap);
+
+    return 0;
+}
+
+int xen_host_pci_find_next_cap(XenHostPCIDevice *d, int pos, uint32_t cap)
+{
+    uint8_t id;
+    unsigned max_cap = XEN_HOST_PCI_CAP_MAX;
+    uint8_t status = 0;
+    uint8_t curpos;
+
+    if (xen_host_pci_get_byte(d, PCI_STATUS, &status))
+        return 0;
+
+    if ((status & PCI_STATUS_CAP_LIST) == 0)
+        return 0;
+
+    if (pos < PCI_CAPABILITY_LIST) {
+        curpos = PCI_CAPABILITY_LIST;
+    } else {
+        curpos = (uint8_t) pos;
+    }
+
+    while (max_cap--) {
+        if (xen_host_pci_get_byte(d, curpos, &curpos))
+            break;
+        if (!curpos)
             break;
-        }
 
-        max_cap--;
-    } while (max_cap > 0);
+        if (cap == CAP_ID_ANY)
+            return curpos;
 
-    return -1;
+        if (xen_host_pci_get_byte(d, curpos + PCI_CAP_LIST_ID, &id))
+            break;
+
+        if (id == 0xff)
+            break;
+        else if (id == cap)
+            return curpos;
+
+        curpos += PCI_CAP_LIST_NEXT;
+    }
+
+    return 0;
 }
 
 void xen_host_pci_device_get(XenHostPCIDevice *d, uint16_t domain,
@@ -377,7 +443,8 @@ void xen_host_pci_device_get(XenHostPCIDevice *d, uint16_t domain,
     }
     d->class_code = v;
 
-    d->is_virtfn = xen_host_pci_dev_is_virtfn(d);
+    d->is_virtfn         = xen_host_pci_dev_is_virtfn(d);
+    d->has_pcie_ext_caps = xen_host_pci_dev_has_pcie_ext_caps(d);
 
     return;
 
diff --git a/hw/xen/xen-host-pci-device.h b/hw/xen/xen-host-pci-device.h
index 4d8d34ecb0..37c5614a24 100644
--- a/hw/xen/xen-host-pci-device.h
+++ b/hw/xen/xen-host-pci-device.h
@@ -32,6 +32,7 @@ typedef struct XenHostPCIDevice {
     XenHostPCIIORegion rom;
 
     bool is_virtfn;
+    bool has_pcie_ext_caps;
 
     int config_fd;
 } XenHostPCIDevice;
@@ -53,6 +54,8 @@ int xen_host_pci_set_long(XenHostPCIDevice *d, int pos, uint32_t data);
 int xen_host_pci_set_block(XenHostPCIDevice *d, int pos, uint8_t *buf,
                            int len);
 
-int xen_host_pci_find_ext_cap_offset(XenHostPCIDevice *s, uint32_t cap);
+#define CAP_ID_ANY  (~0U)
+int xen_host_pci_find_next_cap(XenHostPCIDevice *s, int pos, uint32_t cap);
+int xen_host_pci_find_next_ext_cap(XenHostPCIDevice *d, int pos, uint32_t cap);
 
 #endif /* XEN_HOST_PCI_DEVICE_H */
-- 
2.11.0
