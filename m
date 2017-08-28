Received: from eggs.gnu.org ([2001:4830:134:3::10]:55407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dmF2n-00083r-VH
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 04:05:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dmF2j-00068Z-OS
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 04:05:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36750
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1dmF2j-00068A-Ia
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 04:05:09 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7S83tWf093617
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 04:05:09 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cmb2r264e-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 04:05:08 -0400
Received: from localhost
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 18:05:05 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v7S8525O41746626
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 18:05:02 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v7S84qjx025899
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 18:04:53 +1000
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 10:04:45 +0200
In-Reply-To: <1503907487-2764-1-git-send-email-zyimin@linux.vnet.ibm.com>
References: <1503907487-2764-1-git-send-email-zyimin@linux.vnet.ibm.com>
Message-Id: <1503907487-2764-3-git-send-email-zyimin@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 2/4] s390x/pci: remove idx from msix msg data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, cohuck@redhat.com, agraf@suse.de, richard.henderson@linaro.org, zyimin@linux.vnet.ibm.com

PCIDevcie pointer has been a parameter of kvm_arch_fixup_msi_route().
So we don't need to store zpci idx in msix message data to find out the
specific zpci device. Instead, we could use pci device id to find its
corresponding zpci device.

Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
---
 hw/s390x/s390-pci-bus.c  | 16 +++++-----------
 hw/s390x/s390-pci-bus.h  |  2 ++
 hw/s390x/s390-pci-inst.c | 24 ------------------------
 target/s390x/kvm.c       |  7 +++++--
 4 files changed, 12 insertions(+), 37 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 61cfd2138f..9e1f7ff5c5 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -209,8 +209,8 @@ static S390PCIBusDevice *s390_pci_find_dev_by_uid(S390pciState *s, uint16_t uid)
     return NULL;
 }
 
-static S390PCIBusDevice *s390_pci_find_dev_by_target(S390pciState *s,
-                                                     const char *target)
+S390PCIBusDevice *s390_pci_find_dev_by_target(S390pciState *s,
+                                              const char *target)
 {
     S390PCIBusDevice *pbdev;
 
@@ -475,19 +475,13 @@ static void s390_msi_ctrl_write(void *opaque, hwaddr addr, uint64_t data,
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
index 67af2c12ff..820c7fa52b 100644
--- a/hw/s390x/s390-pci-bus.h
+++ b/hw/s390x/s390-pci-bus.h
@@ -330,6 +330,8 @@ void s390_pci_generate_error_event(uint16_t pec, uint32_t fh, uint32_t fid,
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
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 1c68c36663..e348bfb7cc 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2503,10 +2503,13 @@ int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
                              uint64_t address, uint32_t data, PCIDevice *dev)
 {
     S390PCIBusDevice *pbdev;
-    uint32_t idx = data >> ZPCI_MSI_VEC_BITS;
     uint32_t vec = data & ZPCI_MSI_VEC_MASK;
 
-    pbdev = s390_pci_find_dev_by_idx(s390_get_phb(), idx);
+    if (!dev) {
+        return -ENODEV;
+    }
+
+    pbdev = s390_pci_find_dev_by_target(s390_get_phb(), DEVICE(dev)->id);
     if (!pbdev) {
         DPRINTF("add_msi_route no dev\n");
         return -ENODEV;
-- 
2.11.0 (Apple Git-81)
