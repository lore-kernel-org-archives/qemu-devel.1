Received: from eggs.gnu.org ([2001:4830:134:3::10]:53165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eKONZ-0007tz-9T
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 07:55:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eKONW-0003pK-8I
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 07:55:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43264
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1eKONW-0003p6-2Y
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 07:55:46 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAUCsGZf109932
	for <qemu-devel@nongnu.org>; Thu, 30 Nov 2017 07:55:43 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ejf9ebgnp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 30 Nov 2017 07:55:43 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Thu, 30 Nov 2017 12:55:41 -0000
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Thu, 30 Nov 2017 13:55:27 +0100
In-Reply-To: <1512046530-17773-1-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1512046530-17773-1-git-send-email-pmorel@linux.vnet.ibm.com>
Message-Id: <1512046530-17773-5-git-send-email-pmorel@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4 4/7] s390x/pci: rework PCI STORE BLOCK
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

Enhance the fault detection.

Fixup the precedence to check the destination path existance
before checking for the source accessibility.

Add the maxstbl entry to both the Query PCI Function Group
response and the PCIBusDevice structure.

Initialize the maxstbl to 128 per default until we get
the actual data from the hardware.

Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
---
 hw/s390x/s390-pci-bus.h  |  1 +
 hw/s390x/s390-pci-inst.c | 63 ++++++++++++++++++++++++++++++------------------
 hw/s390x/s390-pci-inst.h |  2 +-
 3 files changed, 41 insertions(+), 25 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
index 560bd82..2993f0d 100644
--- a/hw/s390x/s390-pci-bus.h
+++ b/hw/s390x/s390-pci-bus.h
@@ -284,6 +284,7 @@ struct S390PCIBusDevice {
     uint64_t fmb_addr;
     uint8_t isc;
     uint16_t noi;
+    uint16_t maxstbl;
     uint8_t sum;
     S390MsixInfo msix;
     AdapterRoutes routes;
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index bab347e..bab7353 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -294,6 +294,7 @@ int clp_service_call(S390CPU *cpu, uint8_t r2)
         stq_p(&resgrp->msia, ZPCI_MSI_ADDR);
         stw_p(&resgrp->mui, 0);
         stw_p(&resgrp->i, 128);
+        stw_p(&resgrp->maxstbl, 128);
         resgrp->version = 0;
 
         stw_p(&resgrp->hdr.rsp, CLP_RC_OK);
@@ -648,6 +649,7 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
     S390PCIBusDevice *pbdev;
     MemoryRegion *mr;
     MemTxResult result;
+    uint64_t offset;
     int i;
     uint32_t fh;
     uint8_t pcias;
@@ -662,22 +664,10 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
     fh = env->regs[r1] >> 32;
     pcias = (env->regs[r1] >> 16) & 0xf;
     len = env->regs[r1] & 0xff;
+    offset = env->regs[r3];
 
-    if (pcias > 5) {
-        DPRINTF("pcistb invalid space\n");
-        setcc(cpu, ZPCI_PCI_LS_ERR);
-        s390_set_status_code(env, r1, ZPCI_PCI_ST_INVAL_AS);
-        return 0;
-    }
-
-    switch (len) {
-    case 16:
-    case 32:
-    case 64:
-    case 128:
-        break;
-    default:
-        program_interrupt(env, PGM_SPECIFICATION, 6);
+    if (!(fh & FH_MASK_ENABLE)) {
+        setcc(cpu, ZPCI_PCI_LS_INVAL_HANDLE);
         return 0;
     }
 
@@ -689,12 +679,7 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
     }
 
     switch (pbdev->state) {
-    case ZPCI_FS_RESERVED:
-    case ZPCI_FS_STANDBY:
-    case ZPCI_FS_DISABLED:
     case ZPCI_FS_PERMANENT_ERROR:
-        setcc(cpu, ZPCI_PCI_LS_INVAL_HANDLE);
-        return 0;
     case ZPCI_FS_ERROR:
         setcc(cpu, ZPCI_PCI_LS_ERR);
         s390_set_status_code(env, r1, ZPCI_PCI_ST_BLOCKED);
@@ -703,8 +688,34 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
         break;
     }
 
+    if (pcias > ZPCI_IO_BAR_MAX) {
+        DPRINTF("pcistb invalid space\n");
+        setcc(cpu, ZPCI_PCI_LS_ERR);
+        s390_set_status_code(env, r1, ZPCI_PCI_ST_INVAL_AS);
+        return 0;
+    }
+
+    /* Verify the address, offset and length */
+    /* offset must be a multiple of 8 */
+    if (offset % 8) {
+        goto specification_error;
+    }
+    /* Length must be greater than 8, a multiple of 8 */
+    /* and not greater than maxstbl */
+    if ((len <= 8) || (len % 8) || (len > pbdev->maxstbl)) {
+        goto specification_error;
+    }
+    /* Do not cross a 4K-byte boundary */
+    if (((offset & 0xfff) + len) > 0x1000) {
+        goto specification_error;
+    }
+    /* Guest address must be double word aligned */
+    if (gaddr & 0x07UL) {
+        goto specification_error;
+    }
+
     mr = pbdev->pdev->io_regions[pcias].memory;
-    if (!memory_region_access_valid(mr, env->regs[r3], len, true)) {
+    if (!memory_region_access_valid(mr, offset, len, true)) {
         program_interrupt(env, PGM_OPERAND, 6);
         return 0;
     }
@@ -714,9 +725,9 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
     }
 
     for (i = 0; i < len / 8; i++) {
-        result = memory_region_dispatch_write(mr, env->regs[r3] + i * 8,
-                                     ldq_p(buffer + i * 8), 8,
-                                     MEMTXATTRS_UNSPECIFIED);
+        result = memory_region_dispatch_write(mr, offset + i * 8,
+                                              ldq_p(buffer + i * 8), 8,
+                                              MEMTXATTRS_UNSPECIFIED);
         if (result != MEMTX_OK) {
             program_interrupt(env, PGM_OPERAND, 6);
             return 0;
@@ -725,6 +736,10 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
 
     setcc(cpu, ZPCI_PCI_LS_OK);
     return 0;
+
+specification_error:
+    program_interrupt(env, PGM_SPECIFICATION, 6);
+    return 0;
 }
 
 static int reg_irqs(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib)
diff --git a/hw/s390x/s390-pci-inst.h b/hw/s390x/s390-pci-inst.h
index 4be58fe..d4578d2 100644
--- a/hw/s390x/s390-pci-inst.h
+++ b/hw/s390x/s390-pci-inst.h
@@ -162,7 +162,7 @@ typedef struct ClpRspQueryPciGrp {
 #define CLP_RSP_QPCIG_MASK_FRAME   0x2
 #define CLP_RSP_QPCIG_MASK_REFRESH 0x1
     uint8_t fr;
-    uint16_t reserved2;
+    uint16_t maxstbl;
     uint16_t mui;
     uint64_t reserved3;
     uint64_t dasm; /* dma address space mask */
-- 
2.7.4
