Received: from eggs.gnu.org ([209.51.188.92]:42034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1ghDKl-0000tI-OH
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 07:51:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1ghDAs-0004CE-5c
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 07:41:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52858
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1ghDAq-0004BI-F2
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 07:41:33 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x09CYHFq121897
	for <qemu-devel@nongnu.org>; Wed, 9 Jan 2019 07:41:31 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2pwejsy26k-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 09 Jan 2019 07:41:31 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Wed, 9 Jan 2019 12:41:29 -0000
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Wed,  9 Jan 2019 13:41:20 +0100
In-Reply-To: <1547037680-21458-1-git-send-email-pmorel@linux.ibm.com>
References: <1547037680-21458-1-git-send-email-pmorel@linux.ibm.com>
Message-Id: <1547037680-21458-4-git-send-email-pmorel@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v1 3/3] s390x/pci: Reporting the host aperture
 to the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: walling@linux.ibm.com
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, rth@twiddle.net, david@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, pasic@linux.ibm.com, thuth@redhat.com

The S390 PCI driver in the guest needs to know the IOMMU
aperture associated with the zPCI real device in the host
through Start DMA and End DMA value in the response to the
Get Function Group information query.

Let's report these SDMA and EDMA using the value we got from
the host through the real IOMMU associated with the VFIO container.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c       |  2 +-
 hw/s390x/s390-pci-bus.h       |  3 +++
 hw/s390x/s390-pci-inst.c      | 20 +++++++++++++++++---
 hw/vfio/common.c              |  4 +++-
 include/hw/vfio/vfio-common.h |  3 +++
 5 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 27963b2..29177ac 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -551,7 +551,7 @@ static void s390_pci_iommu_replay(IOMMUMemoryRegion *iommu,
     return;
 }
 
-static S390PCIIOMMU *s390_pci_get_iommu(S390pciState *s, PCIBus *bus,
+S390PCIIOMMU *s390_pci_get_iommu(S390pciState *s, PCIBus *bus,
                                         int devfn)
 {
     uint64_t key = (uintptr_t)bus;
diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
index 1f7f9b5..951a3d8 100644
--- a/hw/s390x/s390-pci-bus.h
+++ b/hw/s390x/s390-pci-bus.h
@@ -276,6 +276,8 @@ typedef struct S390PCIIOMMU {
     IOMMUMemoryRegion iommu_mr;
     bool enabled;
     uint64_t g_iota;
+    uint64_t sdma;
+    uint64_t edma;
     uint64_t pba;
     uint64_t pal;
     GHashTable *iotlb;
@@ -344,5 +346,6 @@ S390PCIBusDevice *s390_pci_find_dev_by_target(S390pciState *s,
                                               const char *target);
 S390PCIBusDevice *s390_pci_find_next_avail_dev(S390pciState *s,
                                                S390PCIBusDevice *pbdev);
+S390PCIIOMMU *s390_pci_get_iommu(S390pciState *s, PCIBus *bus, int devfn);
 
 #endif
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 7b61367..5125c1b 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -19,6 +19,7 @@
 #include "exec/memory-internal.h"
 #include "qemu/error-report.h"
 #include "sysemu/hw_accel.h"
+#include "hw/vfio/vfio-common.h"
 
 #ifndef DEBUG_S390PCI_INST
 #define DEBUG_S390PCI_INST  0
@@ -31,6 +32,16 @@
         }                                                          \
     } while (0)
 
+void vfio_s390_iommu_setup(VFIOContainer *container, uint64_t min,
+                           uint64_t max, uint64_t pgsize)
+{
+    S390PCIIOMMU *iommu;
+
+    iommu = container_of(container->space->as, S390PCIIOMMU, as);
+    iommu->sdma = min;
+    iommu->edma = max;
+}
+
 static void s390_set_status_code(CPUS390XState *env,
                                  uint8_t r, uint64_t status_code)
 {
@@ -153,6 +164,7 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra)
     uint8_t cc = 0;
     CPUS390XState *env = &cpu->env;
     S390pciState *s = s390_get_phb();
+    S390PCIIOMMU *iommu;
     int i;
 
     if (env->psw.mask & PSW_MASK_PSTATE) {
@@ -279,8 +291,10 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra)
                     resquery->bar_size[i]);
         }
 
-        stq_p(&resquery->sdma, ZPCI_SDMA_ADDR);
-        stq_p(&resquery->edma, ZPCI_EDMA_ADDR);
+        iommu = s390_pci_get_iommu(s, pci_get_bus(pbdev->pdev),
+                                   PCI_FUNC(pbdev->pdev->devfn));
+        stq_p(&resquery->sdma, iommu->sdma);
+        stq_p(&resquery->edma, iommu->edma);
         stl_p(&resquery->fid, pbdev->fid);
         stw_p(&resquery->pchid, 0);
         stw_p(&resquery->ug, 1);
@@ -860,7 +874,7 @@ static int reg_ioat(CPUS390XState *env, S390PCIIOMMU *iommu, ZpciFib fib,
 
     pba &= ~0xfff;
     pal |= 0xfff;
-    if (pba > pal || pba < ZPCI_SDMA_ADDR || pal > ZPCI_EDMA_ADDR) {
+    if (pba > pal || pba < iommu->sdma || pal > iommu->edma) {
         s390_program_interrupt(env, PGM_OPERAND, 6, ra);
         return -EINVAL;
     }
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index fd7e991..906b208 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1045,7 +1045,6 @@ static void vfio_iommu_type1_get_info(int fd, VFIOContainer *container)
     int ret = 0;
 
     info = g_malloc0(argsz);
-
 retry:
     info->argsz = argsz;
     info->flags = VFIO_IOMMU_INFO_CAPABILITIES;
@@ -1079,6 +1078,8 @@ retry:
                               dma_info->dma_end - dma_info->dma_start,
                               info->iova_pgsizes);
             container->pgsizes = info->iova_pgsizes;
+            vfio_s390_iommu_setup(container, dma_info->dma_start,
+                                  dma_info->dma_end, info->iova_pgsizes);
             return;
         }
         hdr = (struct vfio_info_cap_header *)((unsigned char *) dma_info +
@@ -1088,6 +1089,7 @@ out:
     /* Assume 4k IOVA page size */
     vfio_host_win_add(container, 0, (hwaddr)-1,  4096);
     container->pgsizes = 4096;
+    vfio_s390_iommu_setup(container, 0,  (hwaddr)-1,  4096);
     return;
 }
 
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 1b434d0..2c8bea8 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -198,4 +198,7 @@ int vfio_spapr_create_window(VFIOContainer *container,
 int vfio_spapr_remove_window(VFIOContainer *container,
                              hwaddr offset_within_address_space);
 
+void vfio_s390_iommu_setup(VFIOContainer *container, uint64_t min,
+                           uint64_t max, uint64_t pgsize);
+
 #endif /* HW_VFIO_VFIO_COMMON_H */
-- 
2.7.4
