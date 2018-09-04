Received: from eggs.gnu.org ([2001:4830:134:3::10]:46117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.ibm.com>) id 1fx7RN-0006S0-Ty
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 05:16:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.ibm.com>) id 1fx7RJ-0001el-TV
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 05:16:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46784
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.ibm.com>)
	id 1fx7RJ-0001eD-N1
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 05:16:01 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w849ERON096791
	for <qemu-devel@nongnu.org>; Tue, 4 Sep 2018 05:16:00 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2m9mfhfddm-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Sep 2018 05:15:59 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.ibm.com>;
	Tue, 4 Sep 2018 03:15:58 -0600
From: Yi Min Zhao <zyimin@linux.ibm.com>
Date: Tue,  4 Sep 2018 17:15:49 +0800
Message-Id: <20180904091549.6361-1-zyimin@linux.ibm.com>
Subject: [Qemu-devel] [PATCH] s390x/pci: add common fmb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cohuck@redhat.com, thuth@redhat.com, borntraeger@de.ibm.com, pmorel@linux.ibm.com, zyimin@linux.ibm.com

Common function measurement block is used to report counters of
successfully issued pcilg/stg/stb and rpcit instructions. This patch
introduces a new struct ZpciFmb and schedules a timer callback to
copy fmb to the guest memory at a interval time which is set to
4s by default. While attemping to update fmb failed, an event error
would be generated. After pcilg/stg/stb and rpcit interception
handlers issue successfully, increase the related counter. The guest
could pass null address to switch off FMB and stop corresponding
timer.

Signed-off-by: Yi Min Zhao <zyimin@linux.ibm.com>
Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c  |   3 +-
 hw/s390x/s390-pci-bus.h  |  24 +++++++++++
 hw/s390x/s390-pci-inst.c | 105 +++++++++++++++++++++++++++++++++++++++++++++--
 hw/s390x/s390-pci-inst.h |   1 +
 4 files changed, 129 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index e3e0ebb7f6..7bd0b9d1e5 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -967,6 +967,7 @@ static void s390_pcihost_hot_unplug(HotplugHandler *hotplug_dev,
     bus = pci_get_bus(pci_dev);
     devfn = pci_dev->devfn;
     object_unparent(OBJECT(pci_dev));
+    fmb_timer_free(pbdev);
     s390_pci_msix_free(pbdev);
     s390_pci_iommu_free(s, bus, devfn);
     pbdev->pdev = NULL;
@@ -1139,7 +1140,7 @@ static void s390_pci_device_reset(DeviceState *dev)
         pci_dereg_ioat(pbdev->iommu);
     }
 
-    pbdev->fmb_addr = 0;
+    fmb_timer_free(pbdev);
 }
 
 static void s390_pci_get_fid(Object *obj, Visitor *v, const char *name,
diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
index 1f7f9b5814..fdf13a19c0 100644
--- a/hw/s390x/s390-pci-bus.h
+++ b/hw/s390x/s390-pci-bus.h
@@ -286,6 +286,28 @@ typedef struct S390PCIIOMMUTable {
     S390PCIIOMMU *iommu[PCI_SLOT_MAX];
 } S390PCIIOMMUTable;
 
+/* Function Measurement Block */
+#define DEFAULT_MUI 4000
+#define UPDATE_U_BIT 0x1ULL
+#define FMBK_MASK 0xfULL
+
+typedef struct ZpciFmbFmt0 {
+    uint64_t dma_rbytes;
+    uint64_t dma_wbytes;
+} ZpciFmbFmt0;
+
+typedef struct ZpciFmb {
+    uint8_t format;
+    uint8_t fmt_ind[3];
+    uint32_t sample;
+    uint64_t last_update;
+    uint64_t ld_ops;
+    uint64_t st_ops;
+    uint64_t stb_ops;
+    uint64_t rpcit_ops;
+    ZpciFmbFmt0 fmt0;
+} QEMU_PACKED __attribute((__aligned__(8))) ZpciFmb;
+
 struct S390PCIBusDevice {
     DeviceState qdev;
     PCIDevice *pdev;
@@ -297,6 +319,8 @@ struct S390PCIBusDevice {
     uint32_t fid;
     bool fid_defined;
     uint64_t fmb_addr;
+    ZpciFmb fmb;
+    QEMUTimer *fmb_timer;
     uint8_t isc;
     uint16_t noi;
     uint16_t maxstbl;
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 7b61367ee3..1ed5cb91d0 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -19,6 +19,7 @@
 #include "exec/memory-internal.h"
 #include "qemu/error-report.h"
 #include "sysemu/hw_accel.h"
+#include "hw/s390x/tod.h"
 
 #ifndef DEBUG_S390PCI_INST
 #define DEBUG_S390PCI_INST  0
@@ -293,7 +294,7 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra)
         resgrp->fr = 1;
         stq_p(&resgrp->dasm, 0);
         stq_p(&resgrp->msia, ZPCI_MSI_ADDR);
-        stw_p(&resgrp->mui, 0);
+        stw_p(&resgrp->mui, DEFAULT_MUI);
         stw_p(&resgrp->i, 128);
         stw_p(&resgrp->maxstbl, 128);
         resgrp->version = 0;
@@ -456,6 +457,10 @@ int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
         return 0;
     }
 
+    if (pbdev->fmb_addr) {
+        pbdev->fmb.ld_ops++;
+    }
+
     env->regs[r1] = data;
     setcc(cpu, ZPCI_PCI_LS_OK);
     return 0;
@@ -561,6 +566,10 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
         return 0;
     }
 
+    if (pbdev->fmb_addr) {
+        pbdev->fmb.st_ops++;
+    }
+
     setcc(cpu, ZPCI_PCI_LS_OK);
     return 0;
 }
@@ -681,6 +690,9 @@ err:
         s390_set_status_code(env, r1, ZPCI_PCI_ST_FUNC_IN_ERR);
         s390_pci_generate_error_event(error, pbdev->fh, pbdev->fid, start, 0);
     } else {
+        if (pbdev->fmb_addr) {
+            pbdev->fmb.rpcit_ops++;
+        }
         setcc(cpu, ZPCI_PCI_LS_OK);
     }
     return 0;
@@ -783,6 +795,10 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
         }
     }
 
+    if (pbdev->fmb_addr) {
+        pbdev->fmb.stb_ops++;
+    }
+
     setcc(cpu, ZPCI_PCI_LS_OK);
     return 0;
 
@@ -889,6 +905,63 @@ void pci_dereg_ioat(S390PCIIOMMU *iommu)
     iommu->g_iota = 0;
 }
 
+void fmb_timer_free(S390PCIBusDevice *pbdev)
+{
+    if (pbdev->fmb_timer) {
+        timer_del(pbdev->fmb_timer);
+        timer_free(pbdev->fmb_timer);
+        pbdev->fmb_timer = NULL;
+    }
+    pbdev->fmb_addr = 0;
+    memset(&pbdev->fmb, 0, sizeof(ZpciFmb));
+}
+
+static int fmb_do_update(S390PCIBusDevice *pbdev, uint8_t offset, int len)
+{
+    MemTxResult ret;
+
+    ret = address_space_write(&address_space_memory,
+                              pbdev->fmb_addr + (uint64_t)offset,
+                              MEMTXATTRS_UNSPECIFIED,
+                              (uint8_t *)&pbdev->fmb + offset,
+                              len);
+    if (ret) {
+        s390_pci_generate_error_event(ERR_EVENT_FMBA, pbdev->fh, pbdev->fid,
+                                      pbdev->fmb_addr, 0);
+        fmb_timer_free(pbdev);
+    }
+
+    return ret;
+}
+
+static void fmb_update(void *opaque)
+{
+    S390PCIBusDevice *pbdev = opaque;
+    int64_t t = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
+    uint8_t offset = offsetof(ZpciFmb, last_update);
+
+    /* Update U bit */
+    pbdev->fmb.last_update |= UPDATE_U_BIT;
+    if (fmb_do_update(pbdev, offset, sizeof(uint64_t))) {
+        return;
+    }
+
+    /* Update FMB counters */
+    pbdev->fmb.sample++;
+    if (fmb_do_update(pbdev, 0, sizeof(ZpciFmb))) {
+        return;
+    }
+
+    /* Clear U bit and update the time */
+    pbdev->fmb.last_update = time2tod(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
+    pbdev->fmb.last_update &= ~UPDATE_U_BIT;
+    if (fmb_do_update(pbdev, offset, sizeof(uint64_t))) {
+        return;
+    }
+
+    timer_mod(pbdev->fmb_timer, t + DEFAULT_MUI);
+}
+
 int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
                         uintptr_t ra)
 {
@@ -1018,9 +1091,35 @@ int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
             s390_set_status_code(env, r1, ZPCI_MOD_ST_SEQUENCE);
         }
         break;
-    case ZPCI_MOD_FC_SET_MEASURE:
-        pbdev->fmb_addr = ldq_p(&fib.fmb_addr);
+    case ZPCI_MOD_FC_SET_MEASURE: {
+        uint64_t fmb_addr = ldq_p(&fib.fmb_addr);
+
+        if (fmb_addr & FMBK_MASK) {
+            cc = ZPCI_PCI_LS_ERR;
+            s390_pci_generate_error_event(ERR_EVENT_FMBPRO, pbdev->fh,
+                                          pbdev->fid, fmb_addr, 0);
+            fmb_timer_free(pbdev);
+            break;
+        }
+
+        if (!fmb_addr) {
+            /* Stop updating FMB. */
+            fmb_timer_free(pbdev);
+            break;
+        }
+
+        pbdev->fmb_addr = fmb_addr;
+        if (!pbdev->fmb_timer) {
+            pbdev->fmb_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
+                                            fmb_update, pbdev);
+        } else if (timer_pending(pbdev->fmb_timer)) {
+            /* Remove pending timer to update FMB address. */
+            timer_del(pbdev->fmb_timer);
+        }
+        timer_mod(pbdev->fmb_timer,
+                  qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + DEFAULT_MUI);
         break;
+    }
     default:
         s390_program_interrupt(&cpu->env, PGM_OPERAND, 6, ra);
         cc = ZPCI_PCI_LS_ERR;
diff --git a/hw/s390x/s390-pci-inst.h b/hw/s390x/s390-pci-inst.h
index 91c3d61f2a..fa3bf8b5aa 100644
--- a/hw/s390x/s390-pci-inst.h
+++ b/hw/s390x/s390-pci-inst.h
@@ -303,6 +303,7 @@ int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
                         uintptr_t ra);
 int stpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
                          uintptr_t ra);
+void fmb_timer_free(S390PCIBusDevice *pbdev);
 
 #define ZPCI_IO_BAR_MIN 0
 #define ZPCI_IO_BAR_MAX 5
-- 
Yi Min
