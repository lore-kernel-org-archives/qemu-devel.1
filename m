Received: from eggs.gnu.org ([2001:4830:134:3::10]:58370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gXqir-0003fd-DZ
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 11:53:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gXqio-0000pN-5C
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 11:53:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45018
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1gXqin-0000lp-MA
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 11:53:53 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wBEGmfqP045544
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 11:53:52 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2pcf4f45pd-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 11:53:51 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Fri, 14 Dec 2018 16:53:50 -0000
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Fri, 14 Dec 2018 17:53:42 +0100
In-Reply-To: <1544806422-21418-1-git-send-email-pmorel@linux.ibm.com>
References: <1544806422-21418-1-git-send-email-pmorel@linux.ibm.com>
Message-Id: <1544806422-21418-2-git-send-email-pmorel@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v3] s390x/pci: add common function measurement
 block
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

From: Yi Min Zhao <zyimin@linux.ibm.com>

Common function measurement block is used to report zPCI internal
counters of successful pcilg/stg/stb and rpcit instructions to
a memory location provided by the program.

This patch introduces a new ZpciFmb structure and schedules a timer
callback to copy the zPCI measures to the FMB in the guest memory
at an interval time set to 4s by default.

An error while attemping to update the FMB, would generated an error
event to the guest.

The pcilg/stg/stb and rpcit interception handlers issue, increase
the related counter on success.
The guest shall pass a null FMBA (FMB address) in the FIB (Function
Information Block) when it issues a Modify PCI Function Control
instrcuction to switch off FMB and stop the corresponding timer.

Signed-off-by: Yi Min Zhao <zyimin@linux.ibm.com>
Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c  |   4 +-
 hw/s390x/s390-pci-bus.h  |  29 ++++++++++
 hw/s390x/s390-pci-inst.c | 141 ++++++++++++++++++++++++++++++++++++++++++++++-
 hw/s390x/s390-pci-inst.h |   1 +
 4 files changed, 171 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 060ff06..f0d34dd 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -989,6 +989,7 @@ static void s390_pcihost_hot_unplug(HotplugHandler *hotplug_dev,
     bus = pci_get_bus(pci_dev);
     devfn = pci_dev->devfn;
     object_unparent(OBJECT(pci_dev));
+    fmb_timer_free(pbdev);
     s390_pci_msix_free(pbdev);
     s390_pci_iommu_free(s, bus, devfn);
     pbdev->pdev = NULL;
@@ -1136,6 +1137,7 @@ static void s390_pci_device_realize(DeviceState *dev, Error **errp)
     }
 
     zpci->state = ZPCI_FS_RESERVED;
+    zpci->fmb.format = ZPCI_FMB_FORMAT;
 }
 
 static void s390_pci_device_reset(DeviceState *dev)
@@ -1160,7 +1162,7 @@ static void s390_pci_device_reset(DeviceState *dev)
         pci_dereg_ioat(pbdev->iommu);
     }
 
-    pbdev->fmb_addr = 0;
+    fmb_timer_free(pbdev);
 }
 
 static void s390_pci_get_fid(Object *obj, Visitor *v, const char *name,
diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
index 1f7f9b5..69353ef 100644
--- a/hw/s390x/s390-pci-bus.h
+++ b/hw/s390x/s390-pci-bus.h
@@ -286,6 +286,33 @@ typedef struct S390PCIIOMMUTable {
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
@@ -297,6 +324,8 @@ struct S390PCIBusDevice {
     uint32_t fid;
     bool fid_defined;
     uint64_t fmb_addr;
+    ZpciFmb fmb;
+    QEMUTimer *fmb_timer;
     uint8_t isc;
     uint16_t noi;
     uint16_t maxstbl;
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 7b61367..117a217 100644
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
 
@@ -889,6 +897,107 @@ void pci_dereg_ioat(S390PCIIOMMU *iommu)
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
+static int fmb_do_update64(S390PCIBusDevice *pbdev, int offset, int cnt)
+{
+    MemTxResult ret = MEMTX_OK;
+    uint64_t dst = pbdev->fmb_addr + offset;
+    uint64_t *src = (uint64_t *) ((unsigned long)(&pbdev->fmb) + offset);
+    int i;
+
+    for (i = 0; i < cnt; i++, dst += 8, src++) {
+        address_space_stq_be(&address_space_memory, dst, *src,
+                             MEMTXATTRS_UNSPECIFIED, &ret);
+        if (ret != MEMTX_OK) {
+            s390_pci_generate_error_event(ERR_EVENT_FMBA, pbdev->fh, pbdev->fid,
+                                          pbdev->fmb_addr, 0);
+            fmb_timer_free(pbdev);
+            return ret;
+        }
+    }
+    return ret;
+}
+
+static int fmb_do_update(S390PCIBusDevice *pbdev, int offset, int val, int len)
+{
+    MemTxResult ret;
+    uint64_t dst = pbdev->fmb_addr + offset;
+
+    switch (len) {
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
+    uint8_t offset;
+
+    /* Update U bit */
+    pbdev->fmb.last_update |= UPDATE_U_BIT;
+    offset = offsetof(ZpciFmb, last_update);
+    if (fmb_do_update64(pbdev, offset, 1)) {
+        return;
+    }
+
+    /* Update FMB sample count */
+    offset = offsetof(ZpciFmb, sample);
+    if (fmb_do_update(pbdev, offset, pbdev->fmb.sample++,
+                      sizeof(pbdev->fmb.sample))) {
+        return;
+    }
+    /* Update FMB counters */
+    offset = offsetof(ZpciFmb, counter);
+    if (fmb_do_update64(pbdev, offset, ZPCI_FMB_CNT_MAX)) {
+        return;
+    }
+
+    /* Clear U bit and update the time */
+    pbdev->fmb.last_update = time2tod(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
+    pbdev->fmb.last_update <<= 1;
+    offset = offsetof(ZpciFmb, last_update);
+    if (fmb_do_update64(pbdev, offset, 1)) {
+        return;
+    }
+
+    timer_mod(pbdev->fmb_timer, t + DEFAULT_MUI);
+}
+
 int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
                         uintptr_t ra)
 {
@@ -1018,9 +1127,35 @@ int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
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
index 91c3d61..fa3bf8b 100644
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
2.7.4
