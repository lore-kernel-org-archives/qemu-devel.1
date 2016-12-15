Received: from eggs.gnu.org ([2001:4830:134:3::10]:42860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKC5-0003eJ-TI
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKC2-0001Qv-Lb
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44403)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKC2-0001QO-Cc
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:42 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0jnBM130293
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:41 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27bdku12xq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:41 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:46:40 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:35 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-42-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 41/67] memory: Don't use memcpy for ram_device
 regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

From: Alex Williamson <alex.williamson@redhat.com>

With a vfio assigned device we lay down a base MemoryRegion registered
as an IO region, giving us read & write accessors.  If the region
supports mmap, we lay down a higher priority sub-region MemoryRegion
on top of the base layer initialized as a RAM device pointer to the
mmap.  Finally, if we have any quirks for the device (ie. address
ranges that need additional virtualization support), we put another IO
sub-region on top of the mmap MemoryRegion.  When this is flattened,
we now potentially have sub-page mmap MemoryRegions exposed which
cannot be directly mapped through KVM.

This is as expected, but a subtle detail of this is that we end up
with two different access mechanisms through QEMU.  If we disable the
mmap MemoryRegion, we make use of the IO MemoryRegion and service
accesses using pread and pwrite to the vfio device file descriptor.
If the mmap MemoryRegion is enabled and results in one of these
sub-page gaps, QEMU handles the access as RAM, using memcpy to the
mmap.  Using either pread/pwrite or the mmap directly should be
correct, but using memcpy causes us problems.  I expect that not only
does memcpy not necessarily honor the original width and alignment in
performing a copy, but it potentially also uses processor instructions
not intended for MMIO spaces.  It turns out that this has been a
problem for Realtek NIC assignment, which has such a quirk that
creates a sub-page mmap MemoryRegion access.

To resolve this, we disable memory_access_is_direct() for ram_device
regions since QEMU assumes that it can use memcpy for those regions.
Instead we access through MemoryRegionOps, which replaces the memcpy
with simple de-references of standard sizes to the host memory.

With this patch we attempt to provide unrestricted access to the RAM
device, allowing byte through qword access as well as unaligned
access.  The assumption here is that accesses initiated by the VM are
driven by a device specific driver, which knows the device
capabilities.  If unaligned accesses are not supported by the device,
we don't want them to work in a VM by performing multiple aligned
accesses to compose the unaligned access.  A down-side of this
philosophy is that the xp command from the monitor attempts to use
the largest available access weidth, unaware of the underlying
device.  Using memcpy had this same restriction, but at least now an
operator can dump individual registers, even if blocks of device
memory may result in access widths beyond the capabilities of a
given device (RTL NICs only support up to dword).

Reported-by: Thorsten Kohfeldt <thorsten.kohfeldt@gmx.de>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 4a2e242bbb306ef5c16ce9e7bb2da3bd8a4eb098)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 include/exec/memory.h |  6 +++--
 memory.c              | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++
 trace-events          |  2 ++
 3 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 4d2aa63..10ec0a2 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1446,9 +1446,11 @@ void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr);
 static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
 {
     if (is_write) {
-        return memory_region_is_ram(mr) && !mr->readonly;
+        return memory_region_is_ram(mr) &&
+               !mr->readonly && !memory_region_is_ram_device(mr);
     } else {
-        return memory_region_is_ram(mr) || memory_region_is_romd(mr);
+        return (memory_region_is_ram(mr) && !memory_region_is_ram_device(mr)) ||
+               memory_region_is_romd(mr);
     }
 }
 
diff --git a/memory.c b/memory.c
index 94c55ae..e44aea9 100644
--- a/memory.c
+++ b/memory.c
@@ -1132,6 +1132,71 @@ const MemoryRegionOps unassigned_mem_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
+static uint64_t memory_region_ram_device_read(void *opaque,
+                                              hwaddr addr, unsigned size)
+{
+    MemoryRegion *mr = opaque;
+    uint64_t data = (uint64_t)~0;
+
+    switch (size) {
+    case 1:
+        data = *(uint8_t *)(mr->ram_block->host + addr);
+        break;
+    case 2:
+        data = *(uint16_t *)(mr->ram_block->host + addr);
+        break;
+    case 4:
+        data = *(uint32_t *)(mr->ram_block->host + addr);
+        break;
+    case 8:
+        data = *(uint64_t *)(mr->ram_block->host + addr);
+        break;
+    }
+
+    trace_memory_region_ram_device_read(get_cpu_index(), mr, addr, data, size);
+
+    return data;
+}
+
+static void memory_region_ram_device_write(void *opaque, hwaddr addr,
+                                           uint64_t data, unsigned size)
+{
+    MemoryRegion *mr = opaque;
+
+    trace_memory_region_ram_device_write(get_cpu_index(), mr, addr, data, size);
+
+    switch (size) {
+    case 1:
+        *(uint8_t *)(mr->ram_block->host + addr) = (uint8_t)data;
+        break;
+    case 2:
+        *(uint16_t *)(mr->ram_block->host + addr) = (uint16_t)data;
+        break;
+    case 4:
+        *(uint32_t *)(mr->ram_block->host + addr) = (uint32_t)data;
+        break;
+    case 8:
+        *(uint64_t *)(mr->ram_block->host + addr) = data;
+        break;
+    }
+}
+
+static const MemoryRegionOps ram_device_mem_ops = {
+    .read = memory_region_ram_device_read,
+    .write = memory_region_ram_device_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+        .unaligned = true,
+    },
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+        .unaligned = true,
+    },
+};
+
 bool memory_region_access_valid(MemoryRegion *mr,
                                 hwaddr addr,
                                 unsigned size,
@@ -1367,6 +1432,8 @@ void memory_region_init_ram_device_ptr(MemoryRegion *mr,
 {
     memory_region_init_ram_ptr(mr, owner, name, size, ptr);
     mr->ram_device = true;
+    mr->ops = &ram_device_mem_ops;
+    mr->opaque = mr;
 }
 
 void memory_region_init_alias(MemoryRegion *mr,
diff --git a/trace-events b/trace-events
index 616cc52..3b4c2f5 100644
--- a/trace-events
+++ b/trace-events
@@ -139,6 +139,8 @@ memory_region_subpage_read(int cpu_index, void *mr, uint64_t offset, uint64_t va
 memory_region_subpage_write(int cpu_index, void *mr, uint64_t offset, uint64_t value, unsigned size) "cpu %d mr %p offset %#"PRIx64" value %#"PRIx64" size %u"
 memory_region_tb_read(int cpu_index, uint64_t addr, uint64_t value, unsigned size) "cpu %d addr %#"PRIx64" value %#"PRIx64" size %u"
 memory_region_tb_write(int cpu_index, uint64_t addr, uint64_t value, unsigned size) "cpu %d addr %#"PRIx64" value %#"PRIx64" size %u"
+memory_region_ram_device_read(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr %#"PRIx64" value %#"PRIx64" size %u"
+memory_region_ram_device_write(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr %#"PRIx64" value %#"PRIx64" size %u"
 
 ### Guest events, keep at bottom
 
-- 
1.9.1
