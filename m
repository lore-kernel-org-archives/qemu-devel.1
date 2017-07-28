Received: from eggs.gnu.org ([2001:4830:134:3::10]:59294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dbEpY-0004AM-Lr
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:38:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dbEpX-0002QK-F5
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:38:04 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:33692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dbEpX-0002Pb-5S
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:38:03 -0400
Received: by mail-lf0-x241.google.com with SMTP id 65so7022429lfa.0
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 16:38:02 -0700 (PDT)
From: Aleksandr Bezzubikov <zuban32s@gmail.com>
Date: Sat, 29 Jul 2017 02:37:51 +0300
Message-Id: <1501285073-2215-4-git-send-email-zuban32s@gmail.com>
In-Reply-To: <1501285073-2215-1-git-send-email-zuban32s@gmail.com>
References: <1501285073-2215-1-git-send-email-zuban32s@gmail.com>
Subject: [Qemu-devel] [PATCH v3 3/5] hw/pci: introduce bridge-only
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
Cc: marcel@redhat.com, mst@redhat.com, kevin@koconnor.net, lersek@redhat.com, seabios@seabios.org, kraxel@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, Aleksandr Bezzubikov <zuban32s@gmail.com>

On PCI init PCI bridges may need some
extra info about bus number to reserve, IO, memory and
prefetchable memory limits. QEMU can provide this
with a special vendor-specific PCI capability.

Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
---
 hw/pci/pci_bridge.c         | 37 +++++++++++++++++++++++++++++++++++++
 include/hw/pci/pci_bridge.h | 28 ++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
index 720119b..e9f12d6 100644
--- a/hw/pci/pci_bridge.c
+++ b/hw/pci/pci_bridge.c
@@ -408,6 +408,43 @@ void pci_bridge_map_irq(PCIBridge *br, const char* bus_name,
     br->bus_name = bus_name;
 }
 
+
+int pci_bridge_qemu_cap_init(PCIDevice *dev, int cap_offset,
+                              uint8_t bus_reserve, uint32_t io_reserve,
+                              uint16_t non_pref_reserve, uint64_t pref_reserve,
+                              Error **errp)
+{
+    size_t cap_len = sizeof(PCIBridgeQemuCap);
+    PCIBridgeQemuCap cap = {
+            .len = cap_len,
+            .type = REDHAT_PCI_CAP_QEMU,
+            .bus_res = bus_reserve,
+            .non_pref_16 = non_pref_reserve
+    };
+
+    if ((uint8_t)io_reserve == io_reserve) {
+        cap.io_8 = io_reserve;
+    } else {
+        cap.io_32 = io_reserve;
+    }
+    if ((uint16_t)pref_reserve == pref_reserve) {
+        cap.pref_32 = pref_reserve;
+    } else {
+        cap.pref_64 = pref_reserve;
+    }
+
+    int offset = pci_add_capability(dev, PCI_CAP_ID_VNDR,
+                                    cap_offset, cap_len, errp);
+    if (offset < 0) {
+        return offset;
+    }
+
+    memcpy(dev->config + offset + PCI_CAP_FLAGS,
+            (char *)&cap + PCI_CAP_FLAGS,
+            cap_len - PCI_CAP_FLAGS);
+    return 0;
+}
+
 static const TypeInfo pci_bridge_type_info = {
     .name = TYPE_PCI_BRIDGE,
     .parent = TYPE_PCI_DEVICE,
diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
index ff7cbaa..e9b7cf4 100644
--- a/include/hw/pci/pci_bridge.h
+++ b/include/hw/pci/pci_bridge.h
@@ -67,4 +67,32 @@ void pci_bridge_map_irq(PCIBridge *br, const char* bus_name,
 #define  PCI_BRIDGE_CTL_DISCARD_STATUS	0x400	/* Discard timer status */
 #define  PCI_BRIDGE_CTL_DISCARD_SERR	0x800	/* Discard timer SERR# enable */
 
+typedef struct PCIBridgeQemuCap {
+    uint8_t id;     /* Standard PCI capability header field */
+    uint8_t next;   /* Standard PCI capability header field */
+    uint8_t len;    /* Standard PCI vendor-specific capability header field */
+    uint8_t type;   /* Red Hat vendor-specific capability type.
+                       Types are defined with REDHAT_PCI_CAP_ prefix */
+
+    uint16_t non_pref_16;   /* Non-prefetchable memory limit */
+    uint8_t bus_res;        /* Minimum number of buses to reserve */
+    uint8_t io_8;           /* IO space limit in case of 8-bit value */
+    uint32_t io_32;         /* IO space limit in case of 32-bit value
+                               This 2 values are mutually exclusive,
+                               i.e. they can't be  >0 both*/
+    uint32_t pref_32;       /* Prefetchable memory limit
+                               in case of 32-bit value */
+    uint64_t pref_64;       /* Prefetchable memory limit
+                               in case of 64-bit value
+                               This 2 values are mutually exclusive (just as
+                               IO limit), i.e. they can't be  >0 both */
+} PCIBridgeQemuCap;
+
+#define REDHAT_PCI_CAP_QEMU     1
+
+int pci_bridge_qemu_cap_init(PCIDevice *dev, int cap_offset,
+                              uint8_t bus_reserve, uint32_t io_reserve,
+                              uint16_t mem_reserve, uint64_t pref_reserve,
+                              Error **errp);
+
 #endif /* QEMU_PCI_BRIDGE_H */
-- 
2.7.4
