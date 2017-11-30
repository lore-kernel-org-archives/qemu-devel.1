Received: from eggs.gnu.org ([2001:4830:134:3::10]:53109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eKONT-0007rP-V6
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 07:55:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eKONQ-0003m0-RW
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 07:55:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52392)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1eKONQ-0003lZ-JA
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 07:55:40 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAUCs9VP059633
	for <qemu-devel@nongnu.org>; Thu, 30 Nov 2017 07:55:37 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ejhut1jt4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 30 Nov 2017 07:55:37 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Thu, 30 Nov 2017 12:55:34 -0000
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Thu, 30 Nov 2017 13:55:24 +0100
In-Reply-To: <1512046530-17773-1-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1512046530-17773-1-git-send-email-pmorel@linux.vnet.ibm.com>
Message-Id: <1512046530-17773-2-git-send-email-pmorel@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4 1/7] s390x/pci: factor out endianess
 conversion
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

There are two places where the same endianness conversion
is done.
Let's factor this out into a static function.

Note that the conversion must always be done for data in a register:

The S390 BE guest converted date to le before issuing the instruction.

After interception in a BE host:
ZPCI VFIO using pwrite must make the conversion back for the BE kernel.
Kernel will do BE to le translation when loading the register for the
real instruction.

After interception in a le host:
TCG stores a BE register in le, swapping bytes.
But since the data in the register was already le it is now BE
ZPCI VFIO must convert it to le before writing to the PCI memory.

In both cases ZPCI VFIO must swap the bytes from the register.

Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
---
 hw/s390x/s390-pci-inst.c | 59 +++++++++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 8e088f3..3e1f1a0 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -314,6 +314,36 @@ out:
     return 0;
 }
 
+/**
+ * Swap data contained in s390x big endian registers to little endian
+ * PCI bars.
+ *
+ * @ptr: a pointer to a uint64_t data field
+ * @len: the length of the valid data, must be 1,2,4 or 8
+ */
+static int zpci_endian_swap(uint64_t *ptr, uint8_t len)
+{
+    uint64_t data = *ptr;
+
+    switch (len) {
+    case 1:
+        break;
+    case 2:
+        data = bswap16(data);
+        break;
+    case 4:
+        data = bswap32(data);
+        break;
+    case 8:
+        data = bswap64(data);
+        break;
+    default:
+        return -EINVAL;
+    }
+    *ptr = data;
+    return 0;
+}
+
 int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
 {
     CPUS390XState *env = &cpu->env;
@@ -385,19 +415,7 @@ int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
         data =  pci_host_config_read_common(
                    pbdev->pdev, offset, pci_config_size(pbdev->pdev), len);
 
-        switch (len) {
-        case 1:
-            break;
-        case 2:
-            data = bswap16(data);
-            break;
-        case 4:
-            data = bswap32(data);
-            break;
-        case 8:
-            data = bswap64(data);
-            break;
-        default:
+        if (zpci_endian_swap(&data, len)) {
             program_interrupt(env, PGM_OPERAND, 4);
             return 0;
         }
@@ -500,19 +518,8 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
             program_interrupt(env, PGM_OPERAND, 4);
             return 0;
         }
-        switch (len) {
-        case 1:
-            break;
-        case 2:
-            data = bswap16(data);
-            break;
-        case 4:
-            data = bswap32(data);
-            break;
-        case 8:
-            data = bswap64(data);
-            break;
-        default:
+
+        if (zpci_endian_swap(&data, len)) {
             program_interrupt(env, PGM_OPERAND, 4);
             return 0;
         }
-- 
2.7.4
