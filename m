Received: from eggs.gnu.org ([2001:4830:134:3::10]:55033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gYnzy-0002Ju-CU
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 03:11:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gYnzv-0007Wp-Vc
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 03:11:34 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:35956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gYnzv-0007Tc-J9
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 03:11:31 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Mon, 17 Dec 2018 10:10:36 +0200
Message-Id: <20181217081047.2039-13-yuval.shaia@oracle.com>
In-Reply-To: <20181217081047.2039-1-yuval.shaia@oracle.com>
References: <20181217081047.2039-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v7 12/23] vmxnet3: Move some definitions to
 header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com, cohuck@redhat.com

pvrdma setup requires vmxnet3 device on PCI function 0 and PVRDMA device
on PCI function 1.
pvrdma device needs to access vmxnet3 device object for several reasons:
1. Make sure PCI function 0 is vmxnet3.
2. To monitor vmxnet3 device state.
3. To configure node_guid accoring to vmxnet3 device's MAC address.

To be able to access vmxnet3 device the definition of VMXNET3State is
moved to a new header file.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Dmitry Fleytman <dmitry.fleytman@gmail.com>
---
 hw/net/vmxnet3.c      | 116 +-----------------------------------
 hw/net/vmxnet3_defs.h | 133 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 134 insertions(+), 115 deletions(-)
 create mode 100644 hw/net/vmxnet3_defs.h

diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 3648630386..54746a4030 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -18,7 +18,6 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
-#include "net/net.h"
 #include "net/tap.h"
 #include "net/checksum.h"
 #include "sysemu/sysemu.h"
@@ -29,6 +28,7 @@
 #include "migration/register.h"
 
 #include "vmxnet3.h"
+#include "vmxnet3_defs.h"
 #include "vmxnet_debug.h"
 #include "vmware_utils.h"
 #include "net_tx_pkt.h"
@@ -131,23 +131,11 @@ typedef struct VMXNET3Class {
     DeviceRealize parent_dc_realize;
 } VMXNET3Class;
 
-#define TYPE_VMXNET3 "vmxnet3"
-#define VMXNET3(obj) OBJECT_CHECK(VMXNET3State, (obj), TYPE_VMXNET3)
-
 #define VMXNET3_DEVICE_CLASS(klass) \
     OBJECT_CLASS_CHECK(VMXNET3Class, (klass), TYPE_VMXNET3)
 #define VMXNET3_DEVICE_GET_CLASS(obj) \
     OBJECT_GET_CLASS(VMXNET3Class, (obj), TYPE_VMXNET3)
 
-/* Cyclic ring abstraction */
-typedef struct {
-    hwaddr pa;
-    uint32_t size;
-    uint32_t cell_size;
-    uint32_t next;
-    uint8_t gen;
-} Vmxnet3Ring;
-
 static inline void vmxnet3_ring_init(PCIDevice *d,
 				     Vmxnet3Ring *ring,
                                      hwaddr pa,
@@ -245,108 +233,6 @@ vmxnet3_dump_rx_descr(struct Vmxnet3_RxDesc *descr)
               descr->rsvd, descr->dtype, descr->ext1, descr->btype);
 }
 
-/* Device state and helper functions */
-#define VMXNET3_RX_RINGS_PER_QUEUE (2)
-
-typedef struct {
-    Vmxnet3Ring tx_ring;
-    Vmxnet3Ring comp_ring;
-
-    uint8_t intr_idx;
-    hwaddr tx_stats_pa;
-    struct UPT1_TxStats txq_stats;
-} Vmxnet3TxqDescr;
-
-typedef struct {
-    Vmxnet3Ring rx_ring[VMXNET3_RX_RINGS_PER_QUEUE];
-    Vmxnet3Ring comp_ring;
-    uint8_t intr_idx;
-    hwaddr rx_stats_pa;
-    struct UPT1_RxStats rxq_stats;
-} Vmxnet3RxqDescr;
-
-typedef struct {
-    bool is_masked;
-    bool is_pending;
-    bool is_asserted;
-} Vmxnet3IntState;
-
-typedef struct {
-        PCIDevice parent_obj;
-        NICState *nic;
-        NICConf conf;
-        MemoryRegion bar0;
-        MemoryRegion bar1;
-        MemoryRegion msix_bar;
-
-        Vmxnet3RxqDescr rxq_descr[VMXNET3_DEVICE_MAX_RX_QUEUES];
-        Vmxnet3TxqDescr txq_descr[VMXNET3_DEVICE_MAX_TX_QUEUES];
-
-        /* Whether MSI-X support was installed successfully */
-        bool msix_used;
-        hwaddr drv_shmem;
-        hwaddr temp_shared_guest_driver_memory;
-
-        uint8_t txq_num;
-
-        /* This boolean tells whether RX packet being indicated has to */
-        /* be split into head and body chunks from different RX rings  */
-        bool rx_packets_compound;
-
-        bool rx_vlan_stripping;
-        bool lro_supported;
-
-        uint8_t rxq_num;
-
-        /* Network MTU */
-        uint32_t mtu;
-
-        /* Maximum number of fragments for indicated TX packets */
-        uint32_t max_tx_frags;
-
-        /* Maximum number of fragments for indicated RX packets */
-        uint16_t max_rx_frags;
-
-        /* Index for events interrupt */
-        uint8_t event_int_idx;
-
-        /* Whether automatic interrupts masking enabled */
-        bool auto_int_masking;
-
-        bool peer_has_vhdr;
-
-        /* TX packets to QEMU interface */
-        struct NetTxPkt *tx_pkt;
-        uint32_t offload_mode;
-        uint32_t cso_or_gso_size;
-        uint16_t tci;
-        bool needs_vlan;
-
-        struct NetRxPkt *rx_pkt;
-
-        bool tx_sop;
-        bool skip_current_tx_pkt;
-
-        uint32_t device_active;
-        uint32_t last_command;
-
-        uint32_t link_status_and_speed;
-
-        Vmxnet3IntState interrupt_states[VMXNET3_MAX_INTRS];
-
-        uint32_t temp_mac;   /* To store the low part first */
-
-        MACAddr perm_mac;
-        uint32_t vlan_table[VMXNET3_VFT_SIZE];
-        uint32_t rx_mode;
-        MACAddr *mcast_list;
-        uint32_t mcast_list_len;
-        uint32_t mcast_list_buff_size; /* needed for live migration. */
-
-        /* Compatibility flags for migration */
-        uint32_t compat_flags;
-} VMXNET3State;
-
 /* Interrupt management */
 
 /*
diff --git a/hw/net/vmxnet3_defs.h b/hw/net/vmxnet3_defs.h
new file mode 100644
index 0000000000..6c19d29b12
--- /dev/null
+++ b/hw/net/vmxnet3_defs.h
@@ -0,0 +1,133 @@
+/*
+ * QEMU VMWARE VMXNET3 paravirtual NIC
+ *
+ * Copyright (c) 2012 Ravello Systems LTD (http://ravellosystems.com)
+ *
+ * Developed by Daynix Computing LTD (http://www.daynix.com)
+ *
+ * Authors:
+ * Dmitry Fleytman <dmitry@daynix.com>
+ * Tamir Shomer <tamirs@daynix.com>
+ * Yan Vugenfirer <yan@daynix.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "net/net.h"
+#include "hw/net/vmxnet3.h"
+
+#define TYPE_VMXNET3 "vmxnet3"
+#define VMXNET3(obj) OBJECT_CHECK(VMXNET3State, (obj), TYPE_VMXNET3)
+
+/* Device state and helper functions */
+#define VMXNET3_RX_RINGS_PER_QUEUE (2)
+
+/* Cyclic ring abstraction */
+typedef struct {
+    hwaddr pa;
+    uint32_t size;
+    uint32_t cell_size;
+    uint32_t next;
+    uint8_t gen;
+} Vmxnet3Ring;
+
+typedef struct {
+    Vmxnet3Ring tx_ring;
+    Vmxnet3Ring comp_ring;
+
+    uint8_t intr_idx;
+    hwaddr tx_stats_pa;
+    struct UPT1_TxStats txq_stats;
+} Vmxnet3TxqDescr;
+
+typedef struct {
+    Vmxnet3Ring rx_ring[VMXNET3_RX_RINGS_PER_QUEUE];
+    Vmxnet3Ring comp_ring;
+    uint8_t intr_idx;
+    hwaddr rx_stats_pa;
+    struct UPT1_RxStats rxq_stats;
+} Vmxnet3RxqDescr;
+
+typedef struct {
+    bool is_masked;
+    bool is_pending;
+    bool is_asserted;
+} Vmxnet3IntState;
+
+typedef struct {
+        PCIDevice parent_obj;
+        NICState *nic;
+        NICConf conf;
+        MemoryRegion bar0;
+        MemoryRegion bar1;
+        MemoryRegion msix_bar;
+
+        Vmxnet3RxqDescr rxq_descr[VMXNET3_DEVICE_MAX_RX_QUEUES];
+        Vmxnet3TxqDescr txq_descr[VMXNET3_DEVICE_MAX_TX_QUEUES];
+
+        /* Whether MSI-X support was installed successfully */
+        bool msix_used;
+        hwaddr drv_shmem;
+        hwaddr temp_shared_guest_driver_memory;
+
+        uint8_t txq_num;
+
+        /* This boolean tells whether RX packet being indicated has to */
+        /* be split into head and body chunks from different RX rings  */
+        bool rx_packets_compound;
+
+        bool rx_vlan_stripping;
+        bool lro_supported;
+
+        uint8_t rxq_num;
+
+        /* Network MTU */
+        uint32_t mtu;
+
+        /* Maximum number of fragments for indicated TX packets */
+        uint32_t max_tx_frags;
+
+        /* Maximum number of fragments for indicated RX packets */
+        uint16_t max_rx_frags;
+
+        /* Index for events interrupt */
+        uint8_t event_int_idx;
+
+        /* Whether automatic interrupts masking enabled */
+        bool auto_int_masking;
+
+        bool peer_has_vhdr;
+
+        /* TX packets to QEMU interface */
+        struct NetTxPkt *tx_pkt;
+        uint32_t offload_mode;
+        uint32_t cso_or_gso_size;
+        uint16_t tci;
+        bool needs_vlan;
+
+        struct NetRxPkt *rx_pkt;
+
+        bool tx_sop;
+        bool skip_current_tx_pkt;
+
+        uint32_t device_active;
+        uint32_t last_command;
+
+        uint32_t link_status_and_speed;
+
+        Vmxnet3IntState interrupt_states[VMXNET3_MAX_INTRS];
+
+        uint32_t temp_mac;   /* To store the low part first */
+
+        MACAddr perm_mac;
+        uint32_t vlan_table[VMXNET3_VFT_SIZE];
+        uint32_t rx_mode;
+        MACAddr *mcast_list;
+        uint32_t mcast_list_len;
+        uint32_t mcast_list_buff_size; /* needed for live migration. */
+
+        /* Compatibility flags for migration */
+        uint32_t compat_flags;
+} VMXNET3State;
-- 
2.17.2
