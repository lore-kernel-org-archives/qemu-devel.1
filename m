Received: from eggs.gnu.org ([2001:4830:134:3::10]:43125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.ibm.com>) id 1fC0DT-00069t-PL
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 06:03:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.ibm.com>) id 1fC0DQ-00051p-JF
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 06:02:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34740
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.ibm.com>)
	id 1fC0DQ-00051l-Di
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 06:02:56 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3RA0FWH093519
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 06:02:55 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2hm0hrtxev-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 06:02:55 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.ibm.com>;
	Fri, 27 Apr 2018 04:02:54 -0600
From: Yi Min Zhao <zyimin@linux.ibm.com>
Date: Fri, 27 Apr 2018 18:02:44 +0800
In-Reply-To: <20180427100244.14258-1-zyimin@linux.ibm.com>
References: <20180427100244.14258-1-zyimin@linux.ibm.com>
Message-Id: <20180427100244.14258-2-zyimin@linux.ibm.com>
Subject: [Qemu-devel] [RFC PATCH 1/1] s390x/pci: add common fmb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, zyimin@linux.ibm.com

Common function measurement block is used to report counters of
successfully issued pcilg/stg/stb and rpcit instructions. This patch
introduces a new struct ZpciFmb and schedules a timer callback to
copy fmb to the guest memory at a interval time which is set to
4000ms by default. While attemping to update fmb failed, an event
error would be generated. After pcilg/stg/stb and rpcit interception
handlers issue successfully, increase the related counter.

Signed-off-by: Yi Min Zhao <zyimin@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c  |  3 ++-
 hw/s390x/s390-pci-bus.h  | 16 +++++++++++++
 hw/s390x/s390-pci-inst.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++-
 hw/s390x/s390-pci-inst.h |  1 +
 4 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 10da87458e..62e121dcf6 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -967,6 +967,7 @@ static void s390_pcihost_hot_unplug(HotplugHandler *hotplug_dev,
     bus = pci_get_bus(pci_dev);
     devfn = pci_dev->devfn;
     object_unparent(OBJECT(pci_dev));
+    s390_pci_fmb_free(pbdev);
     s390_pci_msix_free(pbdev);
     s390_pci_iommu_free(s, bus, devfn);
     pbdev->pdev = NULL;
@@ -1139,7 +1140,7 @@ static void s390_pci_device_reset(DeviceState *dev)
         pci_dereg_ioat(pbdev->iommu);
     }
 
-    pbdev->fmb_addr = 0;
+    s390_pci_fmb_free(pbdev);
 }
 
 static void s390_pci_get_fid(Object *obj, Visitor *v, const char *name,
diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
index 1f7f9b5814..c280dfaacc 100644
--- a/hw/s390x/s390-pci-bus.h
+++ b/hw/s390x/s390-pci-bus.h
@@ -286,6 +286,20 @@ typedef struct S390PCIIOMMUTable {
     S390PCIIOMMU *iommu[PCI_SLOT_MAX];
 } S390PCIIOMMUTable;
 
+/* Function Measurement Block */
+#define DEFAULT_MUI 4000
+#define UPDATE_TIME_MASK (~0x1ULL)
+typedef struct ZpciFmb {
+    uint32_t format  : 8;
+    uint32_t fmt_ind : 24;
+    uint32_t sample;
+    uint64_t last_update;
+    uint64_t ld_ops;
+    uint64_t st_ops;
+    uint64_t stb_ops;
+    uint64_t rpcit_ops;
+} QEMU_PACKED ZpciFmb;
+
 struct S390PCIBusDevice {
     DeviceState qdev;
     PCIDevice *pdev;
@@ -297,6 +311,8 @@ struct S390PCIBusDevice {
     uint32_t fid;
     bool fid_defined;
     uint64_t fmb_addr;
+    ZpciFmb fmb;
+    QEMUTimer *fmb_timer;
     uint8_t isc;
     uint16_t noi;
     uint16_t maxstbl;
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 3fcc330fe3..3b64ed0960 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "cpu.h"
+#include "internal.h"
 #include "s390-pci-inst.h"
 #include "s390-pci-bus.h"
 #include "exec/memory-internal.h"
@@ -295,7 +296,7 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra)
         resgrp->fr = 1;
         stq_p(&resgrp->dasm, 0);
         stq_p(&resgrp->msia, ZPCI_MSI_ADDR);
-        stw_p(&resgrp->mui, 0);
+        stw_p(&resgrp->mui, DEFAULT_MUI);
         stw_p(&resgrp->i, 128);
         stw_p(&resgrp->maxstbl, 128);
         resgrp->version = 0;
@@ -460,6 +461,10 @@ int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
         return 0;
     }
 
+    if (pbdev->fmb_addr) {
+        pbdev->fmb.ld_ops++;
+    }
+
     env->regs[r1] = data;
     setcc(cpu, ZPCI_PCI_LS_OK);
     return 0;
@@ -567,6 +572,10 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
         return 0;
     }
 
+    if (pbdev->fmb_addr) {
+        pbdev->fmb.st_ops++;
+    }
+
     setcc(cpu, ZPCI_PCI_LS_OK);
     return 0;
 }
@@ -689,6 +698,9 @@ err:
         s390_set_status_code(env, r1, ZPCI_PCI_ST_FUNC_IN_ERR);
         s390_pci_generate_error_event(error, pbdev->fh, pbdev->fid, start, 0);
     } else {
+        if (pbdev->fmb_addr) {
+            pbdev->fmb.rpcit_ops++;
+        }
         setcc(cpu, ZPCI_PCI_LS_OK);
     }
     return 0;
@@ -740,6 +752,8 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
         break;
     }
 
+    atomic_inc(&pbdev->fmb.stb_ops);
+
     if (pcias > ZPCI_IO_BAR_MAX) {
         DPRINTF("pcistb invalid space\n");
         setcc(cpu, ZPCI_PCI_LS_ERR);
@@ -896,6 +910,42 @@ void pci_dereg_ioat(S390PCIIOMMU *iommu)
     iommu->g_iota = 0;
 }
 
+void s390_pci_fmb_free(S390PCIBusDevice *pbdev)
+{
+    if (!pbdev) {
+        return;
+    }
+
+    if (pbdev->fmb_timer) {
+        timer_del(pbdev->fmb_timer);
+        timer_free(pbdev->fmb_timer);
+        pbdev->fmb_timer = NULL;
+    }
+    pbdev->fmb_addr = 0;
+    memset(&pbdev->fmb, 0, sizeof(ZpciFmb));
+}
+
+static void fmb_update(void *opaque)
+{
+    S390PCIBusDevice *pbdev = opaque;
+    MemTxResult ret;
+
+    pbdev->fmb.sample++;
+    pbdev->fmb.last_update = time2tod(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL))
+                             & UPDATE_TIME_MASK;
+    ret = address_space_write(&address_space_memory, pbdev->fmb_addr,
+                              MEMTXATTRS_UNSPECIFIED, (uint8_t *)&pbdev->fmb,
+                              sizeof(ZpciFmb));
+    if (ret) {
+        s390_pci_generate_error_event(ERR_EVENT_FMBA, pbdev->fh, pbdev->fid,
+                                      pbdev->fmb_addr, 0);
+        s390_pci_fmb_free(pbdev);
+    } else {
+        timer_mod(pbdev->fmb_timer,
+                  qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + DEFAULT_MUI);
+    }
+}
+
 int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
                         uintptr_t ra)
 {
@@ -1027,6 +1077,14 @@ int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
         break;
     case ZPCI_MOD_FC_SET_MEASURE:
         pbdev->fmb_addr = ldq_p(&fib.fmb_addr);
+        if (!pbdev->fmb_addr) {
+            s390_pci_fmb_free(pbdev);
+        } else {
+            pbdev->fmb_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
+			                    fmb_update, pbdev);
+            timer_mod(pbdev->fmb_timer,
+                      qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + DEFAULT_MUI);
+        }
         break;
     default:
         s390_program_interrupt(&cpu->env, PGM_OPERAND, 6, ra);
diff --git a/hw/s390x/s390-pci-inst.h b/hw/s390x/s390-pci-inst.h
index 91c3d61f2a..579fc55255 100644
--- a/hw/s390x/s390-pci-inst.h
+++ b/hw/s390x/s390-pci-inst.h
@@ -303,6 +303,7 @@ int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
                         uintptr_t ra);
 int stpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
                          uintptr_t ra);
+void s390_pci_fmb_free(S390PCIBusDevice *pbdev);
 
 #define ZPCI_IO_BAR_MIN 0
 #define ZPCI_IO_BAR_MAX 5
-- 
2.15.1 (Apple Git-101)
