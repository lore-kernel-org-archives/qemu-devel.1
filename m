Received: from eggs.gnu.org ([2001:4830:134:3::10]:42769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fKlQJ-0002qW-P4
	for qemu-devel@nongnu.org; Mon, 21 May 2018 10:04:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fKlQD-0000vq-GW
	for qemu-devel@nongnu.org; Mon, 21 May 2018 10:04:27 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 May 2018 15:03:42 +0100
Message-Id: <20180521140402.23318-8-peter.maydell@linaro.org>
In-Reply-To: <20180521140402.23318-1-peter.maydell@linaro.org>
References: <20180521140402.23318-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 07/27] Make memory_region_access_valid() take a
 MemTxAttrs argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

As part of plumbing MemTxAttrs down to the IOMMU translate method,
add MemTxAttrs as an argument to memory_region_access_valid().
Its callers either have an attrs value to hand, or don't care
and can use MEMTXATTRS_UNSPECIFIED.

The callsite in flatview_access_valid() is part of a recursive
loop flatview_access_valid() -> memory_region_access_valid() ->
 subpage_accepts() -> flatview_access_valid(); we make it pass
MEMTXATTRS_UNSPECIFIED for now, until the next several commits
have plumbed an attrs parameter through the rest of the loop
and we can add an attrs parameter to flatview_access_valid().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/exec/memory-internal.h | 3 ++-
 exec.c                         | 4 +++-
 hw/s390x/s390-pci-inst.c       | 3 ++-
 memory.c                       | 7 ++++---
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/exec/memory-internal.h b/include/exec/memory-internal.h
index 58399b9318..56c25c0ef7 100644
--- a/include/exec/memory-internal.h
+++ b/include/exec/memory-internal.h
@@ -37,7 +37,8 @@ void flatview_unref(FlatView *view);
 extern const MemoryRegionOps unassigned_mem_ops;
 
 bool memory_region_access_valid(MemoryRegion *mr, hwaddr addr,
-                                unsigned size, bool is_write);
+                                unsigned size, bool is_write,
+                                MemTxAttrs attrs);
 
 void flatview_add_to_dispatch(FlatView *fv, MemoryRegionSection *section);
 AddressSpaceDispatch *address_space_dispatch_new(FlatView *fv);
diff --git a/exec.c b/exec.c
index 718b33921b..6cf97b5d28 100644
--- a/exec.c
+++ b/exec.c
@@ -3468,7 +3468,9 @@ static bool flatview_access_valid(FlatView *fv, hwaddr addr, int len,
         mr = flatview_translate(fv, addr, &xlat, &l, is_write);
         if (!memory_access_is_direct(mr, is_write)) {
             l = memory_access_size(mr, l, addr);
-            if (!memory_region_access_valid(mr, xlat, l, is_write)) {
+            /* When our callers all have attrs we'll pass them through here */
+            if (!memory_region_access_valid(mr, xlat, l, is_write,
+                                            MEMTXATTRS_UNSPECIFIED)) {
                 return false;
             }
         }
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 02a815fd31..d1a5f79678 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -762,7 +762,8 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
     mr = s390_get_subregion(mr, offset, len);
     offset -= mr->addr;
 
-    if (!memory_region_access_valid(mr, offset, len, true)) {
+    if (!memory_region_access_valid(mr, offset, len, true,
+                                    MEMTXATTRS_UNSPECIFIED)) {
         s390_program_interrupt(env, PGM_OPERAND, 6, ra);
         return 0;
     }
diff --git a/memory.c b/memory.c
index fc7f9b782b..279f7c9b4a 100644
--- a/memory.c
+++ b/memory.c
@@ -1347,7 +1347,8 @@ static const MemoryRegionOps ram_device_mem_ops = {
 bool memory_region_access_valid(MemoryRegion *mr,
                                 hwaddr addr,
                                 unsigned size,
-                                bool is_write)
+                                bool is_write,
+                                MemTxAttrs attrs)
 {
     int access_size_min, access_size_max;
     int access_size, i;
@@ -1416,7 +1417,7 @@ MemTxResult memory_region_dispatch_read(MemoryRegion *mr,
 {
     MemTxResult r;
 
-    if (!memory_region_access_valid(mr, addr, size, false)) {
+    if (!memory_region_access_valid(mr, addr, size, false, attrs)) {
         *pval = unassigned_mem_read(mr, addr, size);
         return MEMTX_DECODE_ERROR;
     }
@@ -1458,7 +1459,7 @@ MemTxResult memory_region_dispatch_write(MemoryRegion *mr,
                                          unsigned size,
                                          MemTxAttrs attrs)
 {
-    if (!memory_region_access_valid(mr, addr, size, true)) {
+    if (!memory_region_access_valid(mr, addr, size, true, attrs)) {
         unassigned_mem_write(mr, addr, data, size);
         return MEMTX_DECODE_ERROR;
     }
-- 
2.17.0
