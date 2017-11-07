Received: from eggs.gnu.org ([2001:4830:134:3::10]:54085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eC7cS-0001yk-Vf
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:25:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eC7cP-0005KJ-OJ
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:25:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33490)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1eC7cP-0005Jl-Fr
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:24:57 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA7HODoI079034
	for <qemu-devel@nongnu.org>; Tue, 7 Nov 2017 12:24:53 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e3e62u7ac-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 12:24:52 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Tue, 7 Nov 2017 17:24:47 -0000
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Tue,  7 Nov 2017 18:24:37 +0100
In-Reply-To: <1510075479-17224-1-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1510075479-17224-1-git-send-email-pmorel@linux.vnet.ibm.com>
Message-Id: <1510075479-17224-6-git-send-email-pmorel@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 5/7] s390x/pci: move the memory region read
 from pcilg
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

Let's move the memory region read from pcilg into a dedicated function.
This allows us to prepare a later patch.

Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
---
 hw/s390x/s390-pci-inst.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 646137e..50135a0 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -344,13 +344,22 @@ static int zpci_endian_swap(uint64_t *ptr, uint8_t len)
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
 int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
 {
     CPUS390XState *env = &cpu->env;
     S390PCIBusDevice *pbdev;
     uint64_t offset;
     uint64_t data;
-    MemoryRegion *mr;
     MemTxResult result;
     uint8_t len;
     uint32_t fh;
@@ -401,9 +410,7 @@ int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
             program_interrupt(env, PGM_OPERAND, 4);
             return 0;
         }
-        mr = pbdev->pdev->io_regions[pcias].memory;
-        result = memory_region_dispatch_read(mr, offset, &data, len,
-                                             MEMTXATTRS_UNSPECIFIED);
+        result = zpci_read_bar(pbdev, pcias, offset, &data, len);
         if (result != MEMTX_OK) {
             program_interrupt(env, PGM_OPERAND, 4);
             return 0;
-- 
2.7.4
