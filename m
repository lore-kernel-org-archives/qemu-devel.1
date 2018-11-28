Received: from eggs.gnu.org ([2001:4830:134:3::10]:55749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atsushi.nemoto@sord.co.jp>) id 1gRvyJ-0003LA-G5
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 04:17:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atsushi.nemoto@sord.co.jp>) id 1gRvyG-0006ta-B2
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 04:17:27 -0500
Received: from ms2.toshiba-tops.co.jp ([61.200.21.4]:40308
	helo=dmz-ms2.toshiba-tops.co.jp)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atsushi.nemoto@sord.co.jp>) id 1gRvyF-0006o2-RH
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 04:17:24 -0500
Date: Wed, 28 Nov 2018 18:17:00 +0900
Message-ID: <20181128.181700.1038782556965887223.atsushi.nemoto@sord.co.jp>
From: Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] memory: update coalesced_range on
 transaction_commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

The e1000 driver calls memory_region_add_coalescing but
kvm_coalesce_mmio_region never been called for those regions.

Update coalesced_range on memory_region_transaction_commit to fix this.

It seems very old bug since memory region API
was merged on commit 093bc2cd885e ("Hierarchical memory region API").

Signed-off-by: Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
---
 memory.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/memory.c b/memory.c
index d14c6dec1d..f773b0be50 100644
--- a/memory.c
+++ b/memory.c
@@ -1021,6 +1021,8 @@ void memory_region_transaction_begin(void)
     ++memory_region_transaction_depth;
 }
 
+static void memory_region_update_coalesced_range_as(MemoryRegion *mr, AddressSpace *as);
+
 void memory_region_transaction_commit(void)
 {
     AddressSpace *as;
@@ -1038,6 +1040,7 @@ void memory_region_transaction_commit(void)
             QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
                 address_space_set_flatview(as);
                 address_space_update_ioeventfds(as);
+                memory_region_update_coalesced_range_as(NULL, as);
             }
             memory_region_update_pending = false;
             ioeventfd_update_pending = false;
@@ -2142,7 +2145,7 @@ static void memory_region_update_coalesced_range_as(MemoryRegion *mr, AddressSpa
 
     view = address_space_get_flatview(as);
     FOR_EACH_FLAT_RANGE(fr, view) {
-        if (fr->mr == mr) {
+        if (fr->mr == mr || (!mr && !QTAILQ_EMPTY(&fr->mr->coalesced))) {
             section = (MemoryRegionSection) {
                 .fv = view,
                 .offset_within_address_space = int128_get64(fr->addr.start),
@@ -2152,7 +2155,7 @@ static void memory_region_update_coalesced_range_as(MemoryRegion *mr, AddressSpa
             MEMORY_LISTENER_CALL(as, coalesced_io_del, Reverse, &section,
                                  int128_get64(fr->addr.start),
                                  int128_get64(fr->addr.size));
-            QTAILQ_FOREACH(cmr, &mr->coalesced, link) {
+            QTAILQ_FOREACH(cmr, &fr->mr->coalesced, link) {
                 tmp = addrrange_shift(cmr->addr,
                                       int128_sub(fr->addr.start,
                                                  int128_make64(fr->offset_in_region)));
-- 
2.11.0
