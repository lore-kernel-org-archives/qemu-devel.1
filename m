Received: from eggs.gnu.org ([2001:4830:134:3::10]:37974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eFOKl-0001lX-CQ
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 12:52:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eFOKh-0003FC-Vb
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 12:52:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53138
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1eFOKh-0003E3-O3
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 12:52:11 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAGHnQJX117518
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 12:52:10 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2e9de96txm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 12:52:10 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Thu, 16 Nov 2017 17:52:08 -0000
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Thu, 16 Nov 2017 18:51:55 +0100
In-Reply-To: <1510854715-7081-1-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1510854715-7081-1-git-send-email-pmorel@linux.vnet.ibm.com>
Message-Id: <1510854715-7081-8-git-send-email-pmorel@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 7/7] s390x/pci: search for subregion inside
 the BARs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cohuck@redhat.com, agraf@suse.de, borntraeger@de.ibm.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com

When dispatching memory access to PCI BAR region, we must
look for possible subregions, used by the PCI device to map
different memory areas inside the same PCI BAR.

Since the data offset we received is calculated starting at the
region start address we need to adjust the offset for the subregion.

The data offset inside the subregion is calculated by substracting
the subregion's starting address from the data offset in the region.

The access to the MSIX region is now handled in a generic way,
we do not need the specific trap_msix() function anymore.

Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
---
 hw/s390x/s390-pci-inst.c | 44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index eef3b89..33d08c6 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -345,12 +345,31 @@ static int zpci_endian_swap(uint64_t *ptr, uint8_t len)
     return 0;
 }
 
+static MemoryRegion *s390_get_subregion(MemoryRegion *mr, uint64_t offset,
+                                        uint8_t len)
+{
+    MemoryRegion *other;
+    uint64_t subregion_size;
+
+    QTAILQ_FOREACH(other, &mr->subregions, subregions_link) {
+        subregion_size = int128_get64(other->size);
+        if ((offset >= other->addr) &&
+            (offset + len) <= (other->addr + subregion_size)) {
+            mr = other;
+            break;
+        }
+    }
+    return mr;
+}
+
 static MemTxResult zpci_read_bar(S390PCIBusDevice *pbdev, uint8_t pcias,
                                  uint64_t offset, uint64_t *data, uint8_t len)
 {
     MemoryRegion *mr;
 
     mr = pbdev->pdev->io_regions[pcias].memory;
+    mr = s390_get_subregion(mr, offset, len);
+    offset -= mr->addr;
     return memory_region_dispatch_read(mr, offset, data, len,
                                        MEMTXATTRS_UNSPECIFIED);
 }
@@ -442,30 +461,14 @@ int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
     return 0;
 }
 
-static int trap_msix(S390PCIBusDevice *pbdev, uint64_t offset, uint8_t pcias)
-{
-    if (pbdev->msix.available && pbdev->msix.table_bar == pcias &&
-        offset >= pbdev->msix.table_offset &&
-        offset < (pbdev->msix.table_offset +
-                  pbdev->msix.entries * PCI_MSIX_ENTRY_SIZE)) {
-        return 1;
-    } else {
-        return 0;
-    }
-}
-
 static MemTxResult zpci_write_bar(S390PCIBusDevice *pbdev, uint8_t pcias,
                                   uint64_t offset, uint64_t data, uint8_t len)
 {
     MemoryRegion *mr;
 
-    if (trap_msix(pbdev, offset, pcias)) {
-        offset = offset - pbdev->msix.table_offset;
-        mr = &pbdev->pdev->msix_table_mmio;
-    } else {
-        mr = pbdev->pdev->io_regions[pcias].memory;
-    }
-
+    mr = pbdev->pdev->io_regions[pcias].memory;
+    mr = s390_get_subregion(mr, offset, len);
+    offset -= mr->addr;
     return memory_region_dispatch_write(mr, offset, data, len,
                                         MEMTXATTRS_UNSPECIFIED);
 }
@@ -725,6 +728,9 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
     }
 
     mr = pbdev->pdev->io_regions[pcias].memory;
+    mr = s390_get_subregion(mr, offset, len);
+    offset -= mr->addr;
+
     if (!memory_region_access_valid(mr, offset, len, true)) {
         program_interrupt(env, PGM_OPERAND, 6);
         return 0;
-- 
2.7.4
