Received: from eggs.gnu.org ([2001:4830:134:3::10]:55187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eHd9U-0007Cf-5G
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 17:05:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eHd9Q-00038q-1h
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 17:05:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49276
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1eHd9P-000384-SD
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 17:05:47 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAMM3uW3084549
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 17:05:46 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2edgc7m6hg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 17:05:46 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Wed, 22 Nov 2017 22:05:42 -0000
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Wed, 22 Nov 2017 23:05:30 +0100
In-Reply-To: <1511388334-16347-1-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1511388334-16347-1-git-send-email-pmorel@linux.vnet.ibm.com>
Message-Id: <1511388334-16347-4-git-send-email-pmorel@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 3/7] s390x/pci: rework PCI LOAD
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

Enhance the fault detection, correction of the fault reporting.

Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
---
 hw/s390x/s390-pci-inst.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 930c197..2295412 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -373,6 +373,11 @@ int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
     len = env->regs[r2] & 0xf;
     offset = env->regs[r2 + 1];
 
+    if (!(fh & FH_MASK_ENABLE)) {
+        setcc(cpu, ZPCI_PCI_LS_INVAL_HANDLE);
+        return 0;
+    }
+
     pbdev = s390_pci_find_dev_by_fh(s390_get_phb(), fh);
     if (!pbdev) {
         DPRINTF("pcilg no pci dev\n");
@@ -381,12 +386,7 @@ int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
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
         s390_set_status_code(env, r2, ZPCI_PCI_ST_BLOCKED);
@@ -395,8 +395,9 @@ int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
         break;
     }
 
-    if (pcias < 6) {
-        if ((8 - (offset & 0x7)) < len) {
+    switch (pcias) {
+    case 0 ... 5:
+        if (!len || (len > (8 - (offset & 0x7)))) {
             program_interrupt(env, PGM_OPERAND, 4);
             return 0;
         }
@@ -407,8 +408,9 @@ int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
             program_interrupt(env, PGM_OPERAND, 4);
             return 0;
         }
-    } else if (pcias == 15) {
-        if ((4 - (offset & 0x3)) < len) {
+        break;
+    case 15:
+        if (!len || (len > (4 - (offset & 0x3))) || len == 3) {
             program_interrupt(env, PGM_OPERAND, 4);
             return 0;
         }
@@ -419,8 +421,9 @@ int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
             program_interrupt(env, PGM_OPERAND, 4);
             return 0;
         }
-    } else {
-        DPRINTF("invalid space\n");
+        break;
+    default:
+        DPRINTF("pcilg invalid space\n");
         setcc(cpu, ZPCI_PCI_LS_ERR);
         s390_set_status_code(env, r2, ZPCI_PCI_ST_INVAL_AS);
         return 0;
-- 
2.7.4
