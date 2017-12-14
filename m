Received: from eggs.gnu.org ([2001:4830:134:3::10]:55341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePX31-0000UT-H5
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:11:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePX2x-0007Oi-Fc
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:11:51 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 14 Dec 2017 18:09:41 +0100
Message-Id: <20171214171004.25058-24-cohuck@redhat.com>
In-Reply-To: <20171214171004.25058-1-cohuck@redhat.com>
References: <20171214171004.25058-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 23/46] s390x/pci: rework PCI STORE
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
Message-Id: <1512046530-17773-3-git-send-email-pmorel@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-pci-inst.c | 41 +++++++++++++++++++++++++----------------
 hw/s390x/s390-pci-inst.h |  4 ++++
 2 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index cb84d209e0..66d191f57f 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -474,6 +474,12 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
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
@@ -483,12 +489,10 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
     }
 
     switch (pbdev->state) {
-    case ZPCI_FS_RESERVED:
-    case ZPCI_FS_STANDBY:
-    case ZPCI_FS_DISABLED:
+    /* ZPCI_FS_RESERVED, ZPCI_FS_STANDBY and ZPCI_FS_DISABLED
+     * are already covered by the FH_MASK_ENABLE check above
+     */
     case ZPCI_FS_PERMANENT_ERROR:
-        setcc(cpu, ZPCI_PCI_LS_INVAL_HANDLE);
-        return 0;
     case ZPCI_FS_ERROR:
         setcc(cpu, ZPCI_PCI_LS_ERR);
         s390_set_status_code(env, r2, ZPCI_PCI_ST_BLOCKED);
@@ -497,9 +501,13 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
         break;
     }
 
-    data = env->regs[r1];
-    if (pcias < 6) {
-        if ((8 - (offset & 0x7)) < len) {
+    switch (pcias) {
+        /* A ZPCI PCI card may use any BAR from BAR 0 to BAR 5 */
+    case ZPCI_IO_BAR_MIN...ZPCI_IO_BAR_MAX:
+        /* Check length:
+         * A length of 0 is invalid and length should not cross a double word
+         */
+        if (!len || (len > (8 - (offset & 0x7)))) {
             s390_program_interrupt(env, PGM_OPERAND, 4, ra);
             return 0;
         }
@@ -517,20 +525,21 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
             s390_program_interrupt(env, PGM_OPERAND, 4, ra);
             return 0;
         }
-    } else if (pcias == 15) {
-        if ((4 - (offset & 0x3)) < len) {
-            s390_program_interrupt(env, PGM_OPERAND, 4, ra);
-            return 0;
-        }
-        if (zpci_endian_swap(&data, len)) {
+        break;
+    case ZPCI_CONFIG_BAR:
+        /* ZPCI uses the pseudo BAR number 15 as configuration space */
+        /* possible access lengths are 1,2,4 and must not cross a word */
+        if (!len || (len > (4 - (offset & 0x3))) || len == 3) {
             s390_program_interrupt(env, PGM_OPERAND, 4, ra);
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
diff --git a/hw/s390x/s390-pci-inst.h b/hw/s390x/s390-pci-inst.h
index 93ef290101..a396364635 100644
--- a/hw/s390x/s390-pci-inst.h
+++ b/hw/s390x/s390-pci-inst.h
@@ -304,4 +304,8 @@ int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
 int stpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
                          uintptr_t ra);
 
+#define ZPCI_IO_BAR_MIN 0
+#define ZPCI_IO_BAR_MAX 5
+#define ZPCI_CONFIG_BAR 15
+
 #endif
-- 
2.13.6
