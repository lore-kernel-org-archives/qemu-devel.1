Received: from eggs.gnu.org ([2001:4830:134:3::10]:36671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dgv9M-0002nC-Vx
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 11:50:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dgv9K-0004zh-N7
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 11:50:01 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:38713)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dgv9K-0004z7-Fx
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 11:49:58 -0400
Received: by mail-lf0-x243.google.com with SMTP id y15so5151788lfd.5
	for <qemu-devel@nongnu.org>; Sun, 13 Aug 2017 08:49:58 -0700 (PDT)
From: Aleksandr Bezzubikov <zuban32s@gmail.com>
Date: Sun, 13 Aug 2017 18:49:46 +0300
Message-Id: <1502639388-12580-3-git-send-email-zuban32s@gmail.com>
In-Reply-To: <1502639388-12580-1-git-send-email-zuban32s@gmail.com>
References: <1502639388-12580-1-git-send-email-zuban32s@gmail.com>
Subject: [Qemu-devel] [PATCH v6 2/4] hw/pci: introduce bridge-only
 vendor-specific capability to provide some hints to firmware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcel@redhat.com, mst@redhat.com, lersek@redhat.com, seabios@seabios.org, Aleksandr Bezzubikov <zuban32s@gmail.com>

On PCI init PCI bridges may need some extra info about bus number,
IO, memory and prefetchable memory to reserve. QEMU can provide this
with a special vendor-specific PCI capability.

Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
---
 hw/pci/pci_bridge.c         | 46 +++++++++++++++++++++++++++++++++++++++++++++
 include/hw/pci/pci_bridge.h | 25 ++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
index 720119b..17feae5 100644
--- a/hw/pci/pci_bridge.c
+++ b/hw/pci/pci_bridge.c
@@ -408,6 +408,52 @@ void pci_bridge_map_irq(PCIBridge *br, const char* bus_name,
     br->bus_name = bus_name;
 }
 
+
+int pci_bridge_qemu_reserve_cap_init(PCIDevice *dev, int cap_offset,
+                                     uint32_t bus_reserve, uint64_t io_reserve,
+                                     uint32_t mem_non_pref_reserve,
+                                     uint32_t mem_pref_32_reserve,
+                                     uint64_t mem_pref_64_reserve,
+                                     Error **errp)
+{
+    if (mem_pref_32_reserve != (uint32_t)-1 &&
+        mem_pref_64_reserve != (uint64_t)-1) {
+        error_setg(errp,
+                   "PCI resource reserve cap: PREF32 and PREF64 conflict");
+        return -EINVAL;
+    }
+
+    if (bus_reserve == (uint32_t)-1 &&
+        io_reserve == (uint64_t)-1 &&
+        mem_non_pref_reserve == (uint32_t)-1 &&
+        mem_pref_32_reserve == (uint32_t)-1 &&
+        mem_pref_64_reserve == (uint64_t)-1) {
+        return 0;
+    }
+
+    size_t cap_len = sizeof(PCIBridgeQemuCap);
+    PCIBridgeQemuCap cap = {
+            .len = cap_len,
+            .type = REDHAT_PCI_CAP_RESOURCE_RESERVE,
+            .bus_res = bus_reserve,
+            .io = io_reserve,
+            .mem = mem_non_pref_reserve,
+            .mem_pref_32 = mem_pref_32_reserve,
+            .mem_pref_64 = mem_pref_64_reserve
+    };
+
+    int offset = pci_add_capability(dev, PCI_CAP_ID_VNDR,
+                                    cap_offset, cap_len, errp);
+    if (offset < 0) {
+        return offset;
+    }
+
+    memcpy(dev->config + offset + PCI_CAP_FLAGS,
+           (char *)&cap + PCI_CAP_FLAGS,
+           cap_len - PCI_CAP_FLAGS);
+    return 0;
+}
+
 static const TypeInfo pci_bridge_type_info = {
     .name = TYPE_PCI_BRIDGE,
     .parent = TYPE_PCI_DEVICE,
diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
index ff7cbaa..1acadc2 100644
--- a/include/hw/pci/pci_bridge.h
+++ b/include/hw/pci/pci_bridge.h
@@ -67,4 +67,29 @@ void pci_bridge_map_irq(PCIBridge *br, const char* bus_name,
 #define  PCI_BRIDGE_CTL_DISCARD_STATUS	0x400	/* Discard timer status */
 #define  PCI_BRIDGE_CTL_DISCARD_SERR	0x800	/* Discard timer SERR# enable */
 
+typedef struct PCIBridgeQemuCap {
+    uint8_t id;     /* Standard PCI capability header field */
+    uint8_t next;   /* Standard PCI capability header field */
+    uint8_t len;    /* Standard PCI vendor-specific capability header field */
+    uint8_t type;   /* Red Hat vendor-specific capability type.
+                       Types are defined with REDHAT_PCI_CAP_ prefix */
+
+    uint32_t bus_res;   /* Minimum number of buses to reserve */
+    uint64_t io;        /* IO space to reserve */
+    uint32_t mem;       /* Non-prefetchable memory to reserve */
+    /* At most one of the following two fields may be set to a value
+     * different from -1 */
+    uint32_t mem_pref_32; /* Prefetchable memory to reserve (32-bit MMIO) */
+    uint64_t mem_pref_64; /* Prefetchable memory to reserve (64-bit MMIO) */
+} PCIBridgeQemuCap;
+
+#define REDHAT_PCI_CAP_RESOURCE_RESERVE 1
+
+int pci_bridge_qemu_reserve_cap_init(PCIDevice *dev, int cap_offset,
+                              uint32_t bus_reserve, uint64_t io_reserve,
+                              uint32_t mem_non_pref_reserve,
+                              uint32_t mem_pref_32_reserve,
+                              uint64_t mem_pref_64_reserve,
+                              Error **errp);
+
 #endif /* QEMU_PCI_BRIDGE_H */
-- 
2.7.4
