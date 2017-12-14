Received: from eggs.gnu.org ([2001:4830:134:3::10]:55638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePX3L-0000mC-Ru
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:12:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePX3H-0007gv-Q6
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:12:11 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 14 Dec 2017 18:09:46 +0100
Message-Id: <20171214171004.25058-29-cohuck@redhat.com>
In-Reply-To: <20171214171004.25058-1-cohuck@redhat.com>
References: <20171214171004.25058-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 28/46] s390x/pci: search for subregion inside
 the BARs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Pierre Morel <pmorel@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Pierre Morel <pmorel@linux.vnet.ibm.com>

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
Message-Id: <1512046530-17773-8-git-send-email-pmorel@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-pci-inst.c | 44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 4b3be7af83..be449210d9 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -349,12 +349,31 @@ static int zpci_endian_swap(uint64_t *ptr, uint8_t len)
     return 0;
 }
 
+static MemoryRegion *s390_get_subregion(MemoryRegion *mr, uint64_t offset,
+                                        uint8_t len)
+{
+    MemoryRegion *subregion;
+    uint64_t subregion_size;
+
+    QTAILQ_FOREACH(subregion, &mr->subregions, subregions_link) {
+        subregion_size = int128_get64(subregion->size);
+        if ((offset >= subregion->addr) &&
+            (offset + len) <= (subregion->addr + subregion_size)) {
+            mr = subregion;
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
@@ -446,30 +465,14 @@ int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
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
@@ -733,6 +736,9 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
     }
 
     mr = pbdev->pdev->io_regions[pcias].memory;
+    mr = s390_get_subregion(mr, offset, len);
+    offset -= mr->addr;
+
     if (!memory_region_access_valid(mr, offset, len, true)) {
         s390_program_interrupt(env, PGM_OPERAND, 6, ra);
         return 0;
-- 
2.13.6
