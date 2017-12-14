Received: from eggs.gnu.org ([2001:4830:134:3::10]:55633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePX3L-0000ls-G5
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:12:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePX3F-0007fO-Fm
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:12:11 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 14 Dec 2017 18:09:45 +0100
Message-Id: <20171214171004.25058-28-cohuck@redhat.com>
In-Reply-To: <20171214171004.25058-1-cohuck@redhat.com>
References: <20171214171004.25058-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 27/46] s390x/pci: move the memory region write
 from pcistg
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

Let's move the memory region write from pcistg into a dedicated
function.
This allows us to prepare a later patch searching for subregions
inside of the memory region.

Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1512046530-17773-7-git-send-email-pmorel@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-pci-inst.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index f0247e0ba7..4b3be7af83 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -458,12 +458,27 @@ static int trap_msix(S390PCIBusDevice *pbdev, uint64_t offset, uint8_t pcias)
     }
 }
 
+static MemTxResult zpci_write_bar(S390PCIBusDevice *pbdev, uint8_t pcias,
+                                  uint64_t offset, uint64_t data, uint8_t len)
+{
+    MemoryRegion *mr;
+
+    if (trap_msix(pbdev, offset, pcias)) {
+        offset = offset - pbdev->msix.table_offset;
+        mr = &pbdev->pdev->msix_table_mmio;
+    } else {
+        mr = pbdev->pdev->io_regions[pcias].memory;
+    }
+
+    return memory_region_dispatch_write(mr, offset, data, len,
+                                        MEMTXATTRS_UNSPECIFIED);
+}
+
 int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
 {
     CPUS390XState *env = &cpu->env;
     uint64_t offset, data;
     S390PCIBusDevice *pbdev;
-    MemoryRegion *mr;
     MemTxResult result;
     uint8_t len;
     uint32_t fh;
@@ -523,15 +538,7 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
             return 0;
         }
 
-        if (trap_msix(pbdev, offset, pcias)) {
-            offset = offset - pbdev->msix.table_offset;
-            mr = &pbdev->pdev->msix_table_mmio;
-        } else {
-            mr = pbdev->pdev->io_regions[pcias].memory;
-        }
-
-        result = memory_region_dispatch_write(mr, offset, data, len,
-                                     MEMTXATTRS_UNSPECIFIED);
+        result = zpci_write_bar(pbdev, pcias, offset, data, len);
         if (result != MEMTX_OK) {
             s390_program_interrupt(env, PGM_OPERAND, 4, ra);
             return 0;
-- 
2.13.6
