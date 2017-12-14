Received: from eggs.gnu.org ([2001:4830:134:3::10]:55382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePX34-0000Xa-PO
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:11:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePX33-0007TW-L6
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:11:54 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 14 Dec 2017 18:09:42 +0100
Message-Id: <20171214171004.25058-25-cohuck@redhat.com>
In-Reply-To: <20171214171004.25058-1-cohuck@redhat.com>
References: <20171214171004.25058-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 24/46] s390x/pci: rework PCI LOAD
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

Enhance the fault detection, correction of the fault reporting.

Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Message-Id: <1512046530-17773-4-git-send-email-pmorel@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-pci-inst.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 66d191f57f..48ccf2289e 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -377,6 +377,11 @@ int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
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
@@ -385,12 +390,7 @@ int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
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
@@ -399,8 +399,9 @@ int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
         break;
     }
 
-    if (pcias < 6) {
-        if ((8 - (offset & 0x7)) < len) {
+    switch (pcias) {
+    case ZPCI_IO_BAR_MIN...ZPCI_IO_BAR_MAX:
+        if (!len || (len > (8 - (offset & 0x7)))) {
             s390_program_interrupt(env, PGM_OPERAND, 4, ra);
             return 0;
         }
@@ -411,8 +412,9 @@ int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
             s390_program_interrupt(env, PGM_OPERAND, 4, ra);
             return 0;
         }
-    } else if (pcias == 15) {
-        if ((4 - (offset & 0x3)) < len) {
+        break;
+    case ZPCI_CONFIG_BAR:
+        if (!len || (len > (4 - (offset & 0x3))) || len == 3) {
             s390_program_interrupt(env, PGM_OPERAND, 4, ra);
             return 0;
         }
@@ -423,8 +425,9 @@ int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
             s390_program_interrupt(env, PGM_OPERAND, 4, ra);
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
2.13.6
