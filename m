Received: from eggs.gnu.org ([2001:4830:134:3::10]:55543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePX3E-0000eg-63
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:12:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePX3D-0007dl-Bi
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:12:04 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 14 Dec 2017 18:09:44 +0100
Message-Id: <20171214171004.25058-27-cohuck@redhat.com>
In-Reply-To: <20171214171004.25058-1-cohuck@redhat.com>
References: <20171214171004.25058-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 26/46] s390x/pci: move the memory region read
 from pcilg
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

Let's move the memory region read from pcilg into a dedicated function.
This allows us to prepare a later patch.

Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1512046530-17773-6-git-send-email-pmorel@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-pci-inst.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index e70cd04eb4..f0247e0ba7 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -349,13 +349,22 @@ static int zpci_endian_swap(uint64_t *ptr, uint8_t len)
     return 0;
 }
 
+static MemTxResult zpci_read_bar(S390PCIBusDevice *pbdev, uint8_t pcias,
+                                 uint64_t offset, uint64_t *data, uint8_t len)
+{
+    MemoryRegion *mr;
+
+    mr = pbdev->pdev->io_regions[pcias].memory;
+    return memory_region_dispatch_read(mr, offset, data, len,
+                                       MEMTXATTRS_UNSPECIFIED);
+}
+
 int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
 {
     CPUS390XState *env = &cpu->env;
     S390PCIBusDevice *pbdev;
     uint64_t offset;
     uint64_t data;
-    MemoryRegion *mr;
     MemTxResult result;
     uint8_t len;
     uint32_t fh;
@@ -406,9 +415,7 @@ int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
             s390_program_interrupt(env, PGM_OPERAND, 4, ra);
             return 0;
         }
-        mr = pbdev->pdev->io_regions[pcias].memory;
-        result = memory_region_dispatch_read(mr, offset, &data, len,
-                                             MEMTXATTRS_UNSPECIFIED);
+        result = zpci_read_bar(pbdev, pcias, offset, &data, len);
         if (result != MEMTX_OK) {
             s390_program_interrupt(env, PGM_OPERAND, 4, ra);
             return 0;
-- 
2.13.6
