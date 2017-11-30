Received: from eggs.gnu.org ([2001:4830:134:3::10]:53163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eKONY-0007tk-Tj
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 07:55:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eKONV-0003p1-KJ
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 07:55:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56286
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1eKONV-0003oM-Ei
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 07:55:45 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAUCsG7r034053
	for <qemu-devel@nongnu.org>; Thu, 30 Nov 2017 07:55:43 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ejh1a4uu1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 30 Nov 2017 07:55:43 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Thu, 30 Nov 2017 12:55:41 -0000
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Thu, 30 Nov 2017 13:55:29 +0100
In-Reply-To: <1512046530-17773-1-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1512046530-17773-1-git-send-email-pmorel@linux.vnet.ibm.com>
Message-Id: <1512046530-17773-7-git-send-email-pmorel@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4 6/7] s390x/pci: move the memory region write
 from pcistg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cohuck@redhat.com, agraf@suse.de, borntraeger@de.ibm.com, zyimin@linux.vnet.ibm.com, mst@redhat.com, thuth@redhat.com, pasic@linux.vnet.ibm.com

Let's move the memory region write from pcistg into a dedicated
function.
This allows us to prepare a later patch searching for subregions
inside of the memory region.

Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/s390-pci-inst.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index c702e8d..1277d62 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -454,12 +454,27 @@ static int trap_msix(S390PCIBusDevice *pbdev, uint64_t offset, uint8_t pcias)
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
 int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
 {
     CPUS390XState *env = &cpu->env;
     uint64_t offset, data;
     S390PCIBusDevice *pbdev;
-    MemoryRegion *mr;
     MemTxResult result;
     uint8_t len;
     uint32_t fh;
@@ -519,15 +534,7 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
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
             program_interrupt(env, PGM_OPERAND, 4);
             return 0;
-- 
2.7.4
