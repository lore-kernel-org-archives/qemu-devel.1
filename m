Received: from eggs.gnu.org ([2001:4830:134:3::10]:44340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duJxN-00029v-CJ
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:57:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duJxJ-0007Ps-5A
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:57:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1duJxI-0007PN-SA
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:56:57 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 19 Sep 2017 16:56:01 +0200
Message-Id: <20170919145636.9389-4-cohuck@redhat.com>
In-Reply-To: <20170919145636.9389-1-cohuck@redhat.com>
References: <20170919145636.9389-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 03/38] s390x/pci: remove idx from msix msg data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>

PCIDevice pointer has been a parameter of kvm_arch_fixup_msi_route().
So we don't need to store zpci idx in msix message data to find out the
specific zpci device. Instead, we could use pci device id to find its
corresponding zpci device.

Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Message-Id: <1504606380-49341-2-git-send-email-zyimin@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-pci-bus.c  | 16 +++++-----------
 hw/s390x/s390-pci-bus.h  |  2 ++
 hw/s390x/s390-pci-inst.c | 24 ------------------------
 hw/s390x/s390-pci-stub.c |  3 ++-
 target/s390x/kvm.c       | 10 +++++++---
 5 files changed, 16 insertions(+), 39 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 0a31a4ae88..bd8a3e1e1c 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -199,8 +199,8 @@ static S390PCIBusDevice *s390_pci_find_dev_by_uid(S390pciState *s, uint16_t uid)
     return NULL;
 }
 
-static S390PCIBusDevice *s390_pci_find_dev_by_target(S390pciState *s,
-                                                     const char *target)
+S390PCIBusDevice *s390_pci_find_dev_by_target(S390pciState *s,
+                                              const char *target)
 {
     S390PCIBusDevice *pbdev;
 
@@ -465,19 +465,13 @@ static void s390_msi_ctrl_write(void *opaque, hwaddr addr, uint64_t data,
                                 unsigned int size)
 {
     S390PCIBusDevice *pbdev = opaque;
-    uint32_t idx = data >> ZPCI_MSI_VEC_BITS;
     uint32_t vec = data & ZPCI_MSI_VEC_MASK;
     uint64_t ind_bit;
     uint32_t sum_bit;
-    uint32_t e = 0;
 
-    DPRINTF("write_msix data 0x%" PRIx64 " idx %d vec 0x%x\n", data, idx, vec);
-
-    if (!pbdev) {
-        e |= (vec << ERR_EVENT_MVN_OFFSET);
-        s390_pci_generate_error_event(ERR_EVENT_NOMSI, idx, 0, addr, e);
-        return;
-    }
+    assert(pbdev);
+    DPRINTF("write_msix data 0x%" PRIx64 " idx %d vec 0x%x\n", data,
+            pbdev->idx, vec);
 
     if (pbdev->state != ZPCI_FS_ENABLED) {
         return;
diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
index bd636abc28..560bd82a0f 100644
--- a/hw/s390x/s390-pci-bus.h
+++ b/hw/s390x/s390-pci-bus.h
@@ -322,6 +322,8 @@ void s390_pci_generate_error_event(uint16_t pec, uint32_t fh, uint32_t fid,
 S390PCIBusDevice *s390_pci_find_dev_by_idx(S390pciState *s, uint32_t idx);
 S390PCIBusDevice *s390_pci_find_dev_by_fh(S390pciState *s, uint32_t fh);
 S390PCIBusDevice *s390_pci_find_dev_by_fid(S390pciState *s, uint32_t fid);
+S390PCIBusDevice *s390_pci_find_dev_by_target(S390pciState *s,
+                                              const char *target);
 S390PCIBusDevice *s390_pci_find_next_avail_dev(S390pciState *s,
                                                S390PCIBusDevice *pbdev);
 
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index eba9ffb5f2..8e088f3dc9 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -413,29 +413,6 @@ int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
     return 0;
 }
 
-static void update_msix_table_msg_data(S390PCIBusDevice *pbdev, uint64_t offset,
-                                       uint64_t *data, uint8_t len)
-{
-    uint32_t val;
-    uint8_t *msg_data;
-
-    if (offset % PCI_MSIX_ENTRY_SIZE != 8) {
-        return;
-    }
-
-    if (len != 4) {
-        DPRINTF("access msix table msg data but len is %d\n", len);
-        return;
-    }
-
-    msg_data = (uint8_t *)data - offset % PCI_MSIX_ENTRY_SIZE +
-               PCI_MSIX_ENTRY_VECTOR_CTRL;
-    val = pci_get_long(msg_data) |
-        ((pbdev->fh & FH_MASK_INDEX) << ZPCI_MSI_VEC_BITS);
-    pci_set_long(msg_data, val);
-    DPRINTF("update msix msg_data to 0x%" PRIx64 "\n", *data);
-}
-
 static int trap_msix(S390PCIBusDevice *pbdev, uint64_t offset, uint8_t pcias)
 {
     if (pbdev->msix.available && pbdev->msix.table_bar == pcias &&
@@ -508,7 +485,6 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
         if (trap_msix(pbdev, offset, pcias)) {
             offset = offset - pbdev->msix.table_offset;
             mr = &pbdev->pdev->msix_table_mmio;
-            update_msix_table_msg_data(pbdev, offset, &data, len);
         } else {
             mr = pbdev->pdev->io_regions[pcias].memory;
         }
diff --git a/hw/s390x/s390-pci-stub.c b/hw/s390x/s390-pci-stub.c
index 7a642d376c..ad4c5a7719 100644
--- a/hw/s390x/s390-pci-stub.c
+++ b/hw/s390x/s390-pci-stub.c
@@ -70,7 +70,8 @@ S390pciState *s390_get_phb(void)
     return NULL;
 }
 
-S390PCIBusDevice *s390_pci_find_dev_by_idx(S390pciState *s, uint32_t idx)
+S390PCIBusDevice *s390_pci_find_dev_by_target(S390pciState *s,
+                                              const char *target)
 {
     return NULL;
 }
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index d07763ff2c..7478edeb70 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2423,12 +2423,16 @@ int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
                              uint64_t address, uint32_t data, PCIDevice *dev)
 {
     S390PCIBusDevice *pbdev;
-    uint32_t idx = data >> ZPCI_MSI_VEC_BITS;
     uint32_t vec = data & ZPCI_MSI_VEC_MASK;
 
-    pbdev = s390_pci_find_dev_by_idx(s390_get_phb(), idx);
+    if (!dev) {
+        DPRINTF("add_msi_route no pci device\n");
+        return -ENODEV;
+    }
+
+    pbdev = s390_pci_find_dev_by_target(s390_get_phb(), DEVICE(dev)->id);
     if (!pbdev) {
-        DPRINTF("add_msi_route no dev\n");
+        DPRINTF("add_msi_route no zpci device\n");
         return -ENODEV;
     }
 
-- 
2.13.5
