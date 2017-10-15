Received: from eggs.gnu.org ([2001:4830:134:3::10]:49363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e3ZX3-00035n-Lq
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:24:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e3ZX2-0007Cr-30
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:24:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1e3ZX1-0007CM-PZ
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:24:04 -0400
Date: Sun, 15 Oct 2017 06:24:00 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1508036858-13479-24-git-send-email-mst@redhat.com>
References: <1508036858-13479-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1508036858-13479-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 23/26] virtio-pci: Replace modern_as with direct
 access to modern_bar
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alexey Kardashevskiy <aik@ozlabs.ru>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

The modern bar is accessed now via yet another address space created just
for that purpose and it does not really need FlatView and dispatch tree
as it has a single memory region so it is just a waste of memory. Things
get even worse when there are dozens or hundreds of virtio-pci devices -
since these address spaces are global, changing any of them triggers
rebuilding all address spaces.

This replaces indirect accesses to the modern BAR with a simple lookup
and direct calls to memory_region_dispatch_read/write.

This is expected to save lots of memory at boot time after applying:
[Qemu-devel] [PULL 00/32] Misc changes for 2017-09-22

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-pci.h | 17 +++++++-----
 hw/virtio/virtio-pci.c | 75 +++++++++++++++++++++++++++++---------------------
 2 files changed, 54 insertions(+), 38 deletions(-)

diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 69f5959..12d3a90 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -155,15 +155,18 @@ typedef struct VirtIOPCIQueue {
 struct VirtIOPCIProxy {
     PCIDevice pci_dev;
     MemoryRegion bar;
-    VirtIOPCIRegion common;
-    VirtIOPCIRegion isr;
-    VirtIOPCIRegion device;
-    VirtIOPCIRegion notify;
-    VirtIOPCIRegion notify_pio;
+    union {
+        struct {
+            VirtIOPCIRegion common;
+            VirtIOPCIRegion isr;
+            VirtIOPCIRegion device;
+            VirtIOPCIRegion notify;
+            VirtIOPCIRegion notify_pio;
+        };
+        VirtIOPCIRegion regs[5];
+    };
     MemoryRegion modern_bar;
     MemoryRegion io_bar;
-    MemoryRegion modern_cfg;
-    AddressSpace modern_as;
     uint32_t legacy_io_bar_idx;
     uint32_t msix_bar_idx;
     uint32_t modern_io_bar_idx;
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 6c60aa0..e92837c 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -491,6 +491,24 @@ static const MemoryRegionOps virtio_pci_config_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
+static MemoryRegion *virtio_address_space_lookup(VirtIOPCIProxy *proxy,
+                                                 hwaddr *off, int len)
+{
+    int i;
+    VirtIOPCIRegion *reg;
+
+    for (i = 0; i < ARRAY_SIZE(proxy->regs); ++i) {
+        reg = &proxy->regs[i];
+        if (*off >= reg->offset &&
+            *off + len <= reg->offset + reg->size) {
+            *off -= reg->offset;
+            return &reg->mr;
+        }
+    }
+
+    return NULL;
+}
+
 /* Below are generic functions to do memcpy from/to an address space,
  * without byteswaps, with input validation.
  *
@@ -504,63 +522,72 @@ static const MemoryRegionOps virtio_pci_config_ops = {
  * Note: host pointer must be aligned.
  */
 static
-void virtio_address_space_write(AddressSpace *as, hwaddr addr,
+void virtio_address_space_write(VirtIOPCIProxy *proxy, hwaddr addr,
                                 const uint8_t *buf, int len)
 {
-    uint32_t val;
+    uint64_t val;
+    MemoryRegion *mr;
 
     /* address_space_* APIs assume an aligned address.
      * As address is under guest control, handle illegal values.
      */
     addr &= ~(len - 1);
 
+    mr = virtio_address_space_lookup(proxy, &addr, len);
+    if (!mr) {
+        return;
+    }
+
     /* Make sure caller aligned buf properly */
     assert(!(((uintptr_t)buf) & (len - 1)));
 
     switch (len) {
     case 1:
         val = pci_get_byte(buf);
-        address_space_stb(as, addr, val, MEMTXATTRS_UNSPECIFIED, NULL);
         break;
     case 2:
-        val = pci_get_word(buf);
-        address_space_stw_le(as, addr, val, MEMTXATTRS_UNSPECIFIED, NULL);
+        val = cpu_to_le16(pci_get_word(buf));
         break;
     case 4:
-        val = pci_get_long(buf);
-        address_space_stl_le(as, addr, val, MEMTXATTRS_UNSPECIFIED, NULL);
+        val = cpu_to_le32(pci_get_long(buf));
         break;
     default:
         /* As length is under guest control, handle illegal values. */
-        break;
+        return;
     }
+    memory_region_dispatch_write(mr, addr, val, len, MEMTXATTRS_UNSPECIFIED);
 }
 
 static void
-virtio_address_space_read(AddressSpace *as, hwaddr addr, uint8_t *buf, int len)
+virtio_address_space_read(VirtIOPCIProxy *proxy, hwaddr addr,
+                          uint8_t *buf, int len)
 {
-    uint32_t val;
+    uint64_t val;
+    MemoryRegion *mr;
 
     /* address_space_* APIs assume an aligned address.
      * As address is under guest control, handle illegal values.
      */
     addr &= ~(len - 1);
 
+    mr = virtio_address_space_lookup(proxy, &addr, len);
+    if (!mr) {
+        return;
+    }
+
     /* Make sure caller aligned buf properly */
     assert(!(((uintptr_t)buf) & (len - 1)));
 
+    memory_region_dispatch_read(mr, addr, &val, len, MEMTXATTRS_UNSPECIFIED);
     switch (len) {
     case 1:
-        val = address_space_ldub(as, addr, MEMTXATTRS_UNSPECIFIED, NULL);
         pci_set_byte(buf, val);
         break;
     case 2:
-        val = address_space_lduw_le(as, addr, MEMTXATTRS_UNSPECIFIED, NULL);
-        pci_set_word(buf, val);
+        pci_set_word(buf, le16_to_cpu(val));
         break;
     case 4:
-        val = address_space_ldl_le(as, addr, MEMTXATTRS_UNSPECIFIED, NULL);
-        pci_set_long(buf, val);
+        pci_set_long(buf, le32_to_cpu(val));
         break;
     default:
         /* As length is under guest control, handle illegal values. */
@@ -596,8 +623,7 @@ static void virtio_write_config(PCIDevice *pci_dev, uint32_t address,
 
         if (len == 1 || len == 2 || len == 4) {
             assert(len <= sizeof cfg->pci_cfg_data);
-            virtio_address_space_write(&proxy->modern_as, off,
-                                       cfg->pci_cfg_data, len);
+            virtio_address_space_write(proxy, off, cfg->pci_cfg_data, len);
         }
     }
 }
@@ -621,8 +647,7 @@ static uint32_t virtio_read_config(PCIDevice *pci_dev,
 
         if (len == 1 || len == 2 || len == 4) {
             assert(len <= sizeof cfg->pci_cfg_data);
-            virtio_address_space_read(&proxy->modern_as, off,
-                                      cfg->pci_cfg_data, len);
+            virtio_address_space_read(proxy, off, cfg->pci_cfg_data, len);
         }
     }
 
@@ -1729,15 +1754,6 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
                        /* PCI BAR regions must be powers of 2 */
                        pow2ceil(proxy->notify.offset + proxy->notify.size));
 
-    memory_region_init_alias(&proxy->modern_cfg,
-                             OBJECT(proxy),
-                             "virtio-pci-cfg",
-                             &proxy->modern_bar,
-                             0,
-                             memory_region_size(&proxy->modern_bar));
-
-    address_space_init(&proxy->modern_as, &proxy->modern_cfg, "virtio-pci-cfg-as");
-
     if (proxy->disable_legacy == ON_OFF_AUTO_AUTO) {
         proxy->disable_legacy = pcie_port ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
     }
@@ -1806,10 +1822,7 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
 
 static void virtio_pci_exit(PCIDevice *pci_dev)
 {
-    VirtIOPCIProxy *proxy = VIRTIO_PCI(pci_dev);
-
     msix_uninit_exclusive_bar(pci_dev);
-    address_space_destroy(&proxy->modern_as);
 }
 
 static void virtio_pci_reset(DeviceState *qdev)
-- 
MST
