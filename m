Received: from eggs.gnu.org ([2001:4830:134:3::10]:55257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePX2w-0000PO-6f
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:11:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePX2v-0007MY-4N
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:11:46 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 14 Dec 2017 18:09:40 +0100
Message-Id: <20171214171004.25058-23-cohuck@redhat.com>
In-Reply-To: <20171214171004.25058-1-cohuck@redhat.com>
References: <20171214171004.25058-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 22/46] s390x/pci: factor out endianess conversion
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
Message-Id: <1512046530-17773-2-git-send-email-pmorel@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-pci-inst.c | 58 ++++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 6f41083244..cb84d209e0 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -318,6 +318,36 @@ out:
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
 int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
 {
     CPUS390XState *env = &cpu->env;
@@ -389,19 +419,7 @@ int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
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
             s390_program_interrupt(env, PGM_OPERAND, 4, ra);
             return 0;
         }
@@ -504,19 +522,7 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
             s390_program_interrupt(env, PGM_OPERAND, 4, ra);
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
+        if (zpci_endian_swap(&data, len)) {
             s390_program_interrupt(env, PGM_OPERAND, 4, ra);
             return 0;
         }
-- 
2.13.6
