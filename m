Received: from eggs.gnu.org ([209.51.188.92]:52531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gkT85-0005LL-TK
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:20:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gkT84-00026Y-Hw
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:20:09 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 18 Jan 2019 13:19:25 +0100
Message-Id: <20190118121925.24468-12-cohuck@redhat.com>
In-Reply-To: <20190118121925.24468-1-cohuck@redhat.com>
References: <20190118121925.24468-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 11/11] s390x/pci: add common function
 measurement block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Yi Min Zhao <zyimin@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Yi Min Zhao <zyimin@linux.ibm.com>

Common function measurement block is used to report zPCI internal
counters of successful pcilg/stg/stb and rpcit instructions to
a memory location provided by the program.

This patch introduces a new ZpciFmb structure and schedules a timer
callback to copy the zPCI measures to the FMB in the guest memory
at an interval time set to 4s.

An error while attemping to update the FMB, would generate an error
event to the guest.

The pcilg/stg/stb and rpcit interception handlers increase the
related counter on a successful call.
The guest shall pass a null FMBA (FMB address) in the FIB (Function
Information Block) when it issues a Modify PCI Function Control
instruction to switch off FMB and stop the corresponding timer.

Signed-off-by: Yi Min Zhao <zyimin@linux.ibm.com>
Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Message-Id: <1546969050-8884-2-git-send-email-pmorel@linux.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-pci-bus.c  |   4 +-
 hw/s390x/s390-pci-bus.h  |  29 +++++++++
 hw/s390x/s390-pci-inst.c | 133 ++++++++++++++++++++++++++++++++++++++-
 hw/s390x/s390-pci-inst.h |   1 +
 4 files changed, 163 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 9d23c1b300..f017c1ded0 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1000,6 +1000,7 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
     bus = pci_get_bus(pci_dev);
     devfn = pci_dev->devfn;
     object_unparent(OBJECT(pci_dev));
+    fmb_timer_free(pbdev);
     s390_pci_msix_free(pbdev);
     s390_pci_iommu_free(s, bus, devfn);
     pbdev->pdev = NULL;
@@ -1148,6 +1149,7 @@ static void s390_pci_device_realize(DeviceState *dev, Error **errp)
     }
 
     zpci->state = ZPCI_FS_RESERVED;
+    zpci->fmb.format = ZPCI_FMB_FORMAT;
 }
 
 static void s390_pci_device_reset(DeviceState *dev)
@@ -1172,7 +1174,7 @@ static void s390_pci_device_reset(DeviceState *dev)
         pci_dereg_ioat(pbdev->iommu);
     }
 
-    pbdev->fmb_addr = 0;
+    fmb_timer_free(pbdev);
 }
 
 static void s390_pci_get_fid(Object *obj, Visitor *v, const char *name,
diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
index f47a0f2da5..dadad1f758 100644
--- a/hw/s390x/s390-pci-bus.h
+++ b/hw/s390x/s390-pci-bus.h
@@ -285,6 +285,33 @@ typedef struct S390PCIIOMMUTable {
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
+#define ZPCI_FMB_CNT_LD    0
+#define ZPCI_FMB_CNT_ST    1
+#define ZPCI_FMB_CNT_STB   2
+#define ZPCI_FMB_CNT_RPCIT 3
+#define ZPCI_FMB_CNT_MAX   4
+
+#define ZPCI_FMB_FORMAT    0
+
+typedef struct ZpciFmb {
+    uint32_t format;
+    uint32_t sample;
+    uint64_t last_update;
+    uint64_t counter[ZPCI_FMB_CNT_MAX];
+    ZpciFmbFmt0 fmt0;
+} ZpciFmb;
+QEMU_BUILD_BUG_MSG(offsetof(ZpciFmb, fmt0) != 48, "padding in ZpciFmb");
+
 struct S390PCIBusDevice {
     DeviceState qdev;
     PCIDevice *pdev;
@@ -296,6 +323,8 @@ struct S390PCIBusDevice {
     uint32_t fid;
     bool fid_defined;
     uint64_t fmb_addr;
+    ZpciFmb fmb;
+    QEMUTimer *fmb_timer;
     uint8_t isc;
     uint16_t noi;
     uint16_t maxstbl;
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 7b61367ee3..be2896232d 100644
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
@@ -456,6 +457,8 @@ int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
         return 0;
     }
 
+    pbdev->fmb.counter[ZPCI_FMB_CNT_LD]++;
+
     env->regs[r1] = data;
     setcc(cpu, ZPCI_PCI_LS_OK);
     return 0;
@@ -561,6 +564,8 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
         return 0;
     }
 
+    pbdev->fmb.counter[ZPCI_FMB_CNT_ST]++;
+
     setcc(cpu, ZPCI_PCI_LS_OK);
     return 0;
 }
@@ -681,6 +686,7 @@ err:
         s390_set_status_code(env, r1, ZPCI_PCI_ST_FUNC_IN_ERR);
         s390_pci_generate_error_event(error, pbdev->fh, pbdev->fid, start, 0);
     } else {
+        pbdev->fmb.counter[ZPCI_FMB_CNT_RPCIT]++;
         setcc(cpu, ZPCI_PCI_LS_OK);
     }
     return 0;
@@ -783,6 +789,8 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
         }
     }
 
+    pbdev->fmb.counter[ZPCI_FMB_CNT_STB]++;
+
     setcc(cpu, ZPCI_PCI_LS_OK);
     return 0;
 
@@ -889,6 +897,99 @@ void pci_dereg_ioat(S390PCIIOMMU *iommu)
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
+static int fmb_do_update(S390PCIBusDevice *pbdev, int offset, uint64_t val,
+                         int len)
+{
+    MemTxResult ret;
+    uint64_t dst = pbdev->fmb_addr + offset;
+
+    switch (len) {
+    case 8:
+        address_space_stq_be(&address_space_memory, dst, val,
+                             MEMTXATTRS_UNSPECIFIED,
+                             &ret);
+        break;
+    case 4:
+        address_space_stl_be(&address_space_memory, dst, val,
+                             MEMTXATTRS_UNSPECIFIED,
+                             &ret);
+        break;
+    case 2:
+        address_space_stw_be(&address_space_memory, dst, val,
+                             MEMTXATTRS_UNSPECIFIED,
+                             &ret);
+        break;
+    case 1:
+        address_space_stb(&address_space_memory, dst, val,
+                          MEMTXATTRS_UNSPECIFIED,
+                          &ret);
+        break;
+    default:
+        ret = MEMTX_ERROR;
+        break;
+    }
+    if (ret != MEMTX_OK) {
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
+    int i;
+
+    /* Update U bit */
+    pbdev->fmb.last_update *= 2;
+    pbdev->fmb.last_update |= UPDATE_U_BIT;
+    if (fmb_do_update(pbdev, offsetof(ZpciFmb, last_update),
+                      pbdev->fmb.last_update,
+                      sizeof(pbdev->fmb.last_update))) {
+        return;
+    }
+
+    /* Update FMB sample count */
+    if (fmb_do_update(pbdev, offsetof(ZpciFmb, sample),
+                      pbdev->fmb.sample++,
+                      sizeof(pbdev->fmb.sample))) {
+        return;
+    }
+
+    /* Update FMB counters */
+    for (i = 0; i < ZPCI_FMB_CNT_MAX; i++) {
+        if (fmb_do_update(pbdev, offsetof(ZpciFmb, counter[i]),
+                          pbdev->fmb.counter[i],
+                          sizeof(pbdev->fmb.counter[0]))) {
+            return;
+        }
+    }
+
+    /* Clear U bit and update the time */
+    pbdev->fmb.last_update = time2tod(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
+    pbdev->fmb.last_update *= 2;
+    if (fmb_do_update(pbdev, offsetof(ZpciFmb, last_update),
+                      pbdev->fmb.last_update,
+                      sizeof(pbdev->fmb.last_update))) {
+        return;
+    }
+    timer_mod(pbdev->fmb_timer, t + DEFAULT_MUI);
+}
+
 int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
                         uintptr_t ra)
 {
@@ -1018,9 +1119,35 @@ int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
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
+        if (!pbdev->fmb_timer) {
+            pbdev->fmb_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
+                                            fmb_update, pbdev);
+        } else if (timer_pending(pbdev->fmb_timer)) {
+            /* Remove pending timer to update FMB address. */
+            timer_del(pbdev->fmb_timer);
+        }
+        pbdev->fmb_addr = fmb_addr;
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
2.17.2
