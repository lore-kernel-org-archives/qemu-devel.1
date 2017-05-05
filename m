Received: from eggs.gnu.org ([2001:4830:134:3::10]:47116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6aFI-0002MT-FP
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:13:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6aFH-0006eq-Da
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:13:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d6aFH-0006eR-3X
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:13:55 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  5 May 2017 12:13:28 +0200
Message-Id: <20170505101337.4650-13-pbonzini@redhat.com>
In-Reply-To: <20170505101337.4650-1-pbonzini@redhat.com>
References: <20170505101337.4650-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 12/21] hax: Fix memory mapping de-duplication
 logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yu Ning <yu.ning@linux.intel.com>

From: Yu Ning <yu.ning@linux.intel.com>

hax_update_mapping() avoids unnecessary and potentially expensive
calls to HAX_VM_IOCTL_SET_RAM by computing the net result (i.e.
effective mapping changes) of each MemoryRegion transaction, with
the help of a linked list of HAXMapping objects.

However, when processing a new mapping that overlaps with an
existing mapping in the list, it fails to handle the case where the
start address of the new mapping is above that of the existing
mapping in the guest physical address space. This happens when QEMU
is launched with "-machine q35 -enable-hax", which involves the
following MemoryRegion transaction for digging the VGA hole:

 region_del: 0x00000000->0x08000000 VA 05fa0000 ('pc.ram')
 region_add: 0x00000000->0x000a0000 VA 05fa0000 ('pc.ram')
 region_add: 0x000a0000->0x000c0000 VA 00000000 ('vga-lowmem')
 region_add: 0x000c0000->0x08000000 VA 06060000 ('pc.ram')

where the third MemoryRegion is MMIO and is ignored. The current
de-duplication logic handles the last MemoryRegion incorrectly and
produces the following result:

 hax_mapping_dump_list updates:
         + 0x000c0000->0x08000000 VA 0x06060000
         - 0x07fe0000->0x08000000 VA 0x0df80000

which is why VGA emulation does not work for Q35.

With this patch, one can see VGA output as Q35 boots up. Note that
Q35 support also requires a change to HAXM kernel module, which is
not available in the current HAXM release (6.1.2).

+ Add a warning if the input MemoryRegion is a ROM device, which is
  not supported by HAXM kernel module at this time.

Signed-off-by: Yu Ning <yu.ning@linux.intel.com>
Message-Id: <20170428072723.7036-1-yu.ning@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hax-mem.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/target/i386/hax-mem.c b/target/i386/hax-mem.c
index 2884040021..af090343f3 100644
--- a/target/i386/hax-mem.c
+++ b/target/i386/hax-mem.c
@@ -106,10 +106,10 @@ static void hax_update_mapping(uint64_t start_pa, uint32_t size,
                                uint64_t host_va, uint8_t flags)
 {
     uint64_t end_pa = start_pa + size;
-    uint32_t chunk_sz;
     HAXMapping *entry, *next;
 
     QTAILQ_FOREACH_SAFE(entry, &mappings, entry, next) {
+        uint32_t chunk_sz;
         if (start_pa >= entry->start_pa + entry->size) {
             continue;
         }
@@ -121,7 +121,16 @@ static void hax_update_mapping(uint64_t start_pa, uint32_t size,
             start_pa += chunk_sz;
             host_va += chunk_sz;
             size -= chunk_sz;
+        } else if (start_pa > entry->start_pa) {
+            /* split the existing chunk at start_pa */
+            chunk_sz = start_pa - entry->start_pa;
+            hax_insert_mapping_before(entry, entry->start_pa, chunk_sz,
+                                      entry->host_va, entry->flags);
+            entry->start_pa += chunk_sz;
+            entry->host_va += chunk_sz;
+            entry->size -= chunk_sz;
         }
+        /* now start_pa == entry->start_pa */
         chunk_sz = MIN(size, entry->size);
         if (chunk_sz) {
             bool nop = hax_mapping_is_opposite(entry, host_va, flags);
@@ -165,8 +174,14 @@ static void hax_process_section(MemoryRegionSection *section, uint8_t flags)
     unsigned int delta;
     uint64_t host_va;
 
-    /* We only care about RAM pages */
+    /* We only care about RAM and ROM regions */
     if (!memory_region_is_ram(mr)) {
+        if (memory_region_is_romd(mr)) {
+            /* HAXM kernel module does not support ROMD yet  */
+            fprintf(stderr, "%s: Warning: Ignoring ROMD region 0x%016" PRIx64
+                    "->0x%016" PRIx64 "\n", __func__, start_pa,
+                    start_pa + size);
+        }
         return;
     }
 
-- 
2.12.2
