Received: from eggs.gnu.org ([2001:4830:134:3::10]:48507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1crPty-0003Am-5B
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 10:09:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1crPtu-0006yU-3s
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 10:09:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1crPtt-0006yJ-RS
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 10:09:10 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 24 Mar 2017 14:08:53 +0000
Message-Id: <20170324140854.28134-4-stefanha@redhat.com>
In-Reply-To: <20170324140854.28134-1-stefanha@redhat.com>
References: <20170324140854.28134-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL for-2.9 3/3] trace: Avoid abuse of
 amdvi_mmio_read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Eric Blake <eblake@redhat.com>

hw/i386/trace-events has an amdvi_mmio_read trace that is used for
both normal reads (listing the register name, address, size, and
offset) and for an error case (abusing the register name to show
an error message, the address to show the maximum value supported,
then shoehorning address and size into the size and offset
parameters).  The change from a wide address to a narrower size
parameter could truncate a (rather-large) bogus read attempt, so
it's better to create a separate dedicated trace with correct types,
rather than abusing the trace mechanism.  Broken since its
introduction in commit d29a09c.

[Change trace event argument type from hwaddr to uint64_t since
user-defined types should not be used for trace events.  This fixes a
build failure with LTTng UST.
--Stefan]

Signed-off-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/i386/amd_iommu.c  | 3 +--
 hw/i386/trace-events | 1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index e0732cc..f86a40a 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -572,8 +572,7 @@ static uint64_t amdvi_mmio_read(void *opaque, hwaddr addr, unsigned size)
 
     uint64_t val = -1;
     if (addr + size > AMDVI_MMIO_SIZE) {
-        trace_amdvi_mmio_read("error: addr outside region: max ",
-                (uint64_t)AMDVI_MMIO_SIZE, addr, size);
+        trace_amdvi_mmio_read_invalid(AMDVI_MMIO_SIZE, addr, size);
         return (uint64_t)-1;
     }
 
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index 88ad5e4..baed874 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -37,6 +37,7 @@ amdvi_cache_update(uint16_t domid, uint8_t bus, uint8_t slot, uint8_t func, uint
 amdvi_completion_wait_fail(uint64_t addr) "error: fail to write at address 0x%"PRIx64
 amdvi_mmio_write(const char *reg, uint64_t addr, unsigned size, uint64_t val, uint64_t offset) "%s write addr 0x%"PRIx64", size %u, val 0x%"PRIx64", offset 0x%"PRIx64
 amdvi_mmio_read(const char *reg, uint64_t addr, unsigned size, uint64_t offset) "%s read addr 0x%"PRIx64", size %u offset 0x%"PRIx64
+amdvi_mmio_read_invalid(int max, uint64_t addr, unsigned size) "error: addr outside region (max 0x%x): read addr 0x%" PRIx64 ", size %u"
 amdvi_command_error(uint64_t status) "error: Executing commands with command buffer disabled 0x%"PRIx64
 amdvi_command_read_fail(uint64_t addr, uint32_t head) "error: fail to access memory at 0x%"PRIx64" + 0x%"PRIx32
 amdvi_command_exec(uint32_t head, uint32_t tail, uint64_t buf) "command buffer head at 0x%"PRIx32" command buffer tail at 0x%"PRIx32" command buffer base at 0x%"PRIx64
-- 
2.9.3
