Received: from eggs.gnu.org ([2001:4830:134:3::10]:55205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eHd9U-0007DA-Vq
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 17:05:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eHd9T-0003Ba-69
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 17:05:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1eHd9S-0003Ai-T9
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 17:05:51 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAMM3xNK018363
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 17:05:47 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2edgfruw7e-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 17:05:47 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Wed, 22 Nov 2017 22:05:40 -0000
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Wed, 22 Nov 2017 23:05:29 +0100
In-Reply-To: <1511388334-16347-1-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1511388334-16347-1-git-send-email-pmorel@linux.vnet.ibm.com>
Message-Id: <1511388334-16347-3-git-send-email-pmorel@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 2/7] s390x/pci: rework PCI STORE
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
 hw/s390x/s390-pci-inst.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 3e1f1a0..930c197 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -470,6 +470,12 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
     pcias = (env->regs[r2] >> 16) & 0xf;
     len = env->regs[r2] & 0xf;
     offset = env->regs[r2 + 1];
+    data = env->regs[r1];
+
+    if (!(fh & FH_MASK_ENABLE)) {
+        setcc(cpu, ZPCI_PCI_LS_INVAL_HANDLE);
+        return 0;
+    }
 
     pbdev = s390_pci_find_dev_by_fh(s390_get_phb(), fh);
     if (!pbdev) {
@@ -479,12 +485,7 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
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
@@ -493,9 +494,13 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
         break;
     }
 
-    data = env->regs[r1];
-    if (pcias < 6) {
-        if ((8 - (offset & 0x7)) < len) {
+    switch (pcias) {
+        /* A ZPCI PCI card may use any BAR from BAR 0 to BAR 5 */
+    case 0 ... 5:
+        /* Check length:
+         * A length of 0 is invalid and length should not cross a double word
+         */
+        if (!len || (len > (8 - (offset & 0x7)))) {
             program_interrupt(env, PGM_OPERAND, 4);
             return 0;
         }
@@ -513,21 +518,21 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
             program_interrupt(env, PGM_OPERAND, 4);
             return 0;
         }
-    } else if (pcias == 15) {
-        if ((4 - (offset & 0x3)) < len) {
-            program_interrupt(env, PGM_OPERAND, 4);
-            return 0;
-        }
-
-        if (zpci_endian_swap(&data, len)) {
+        break;
+    case 15:
+        /* ZPCI uses the pseudo BAR number 15 as configuration space */
+        /* possible access lengths are 1,2,4 and must not cross a word */
+        if (!len || (len > (4 - (offset & 0x3))) || len == 3) {
             program_interrupt(env, PGM_OPERAND, 4);
             return 0;
         }
-
+        /* len = 1,2,4 so we do not need to test */
+        zpci_endian_swap(&data, len);
         pci_host_config_write_common(pbdev->pdev, offset,
                                      pci_config_size(pbdev->pdev),
                                      data, len);
-    } else {
+        break;
+    default:
         DPRINTF("pcistg invalid space\n");
         setcc(cpu, ZPCI_PCI_LS_ERR);
         s390_set_status_code(env, r2, ZPCI_PCI_ST_INVAL_AS);
-- 
2.7.4
