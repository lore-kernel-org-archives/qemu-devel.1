Received: from eggs.gnu.org ([2001:4830:134:3::10]:54727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1dUezw-0006lE-TZ
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 16:09:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1dUezt-0005bU-Fs
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 16:09:36 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36792)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <x1917x@gmail.com>) id 1dUezt-0005Ry-50
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 16:09:33 -0400
Received: by mail-lf0-f68.google.com with SMTP id f28so12050266lfi.3
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 13:09:10 -0700 (PDT)
Received: from localhost ([31.200.224.22]) by smtp.gmail.com with ESMTPSA id
	x13sm2565988ljd.64.2017.07.10.13.08.07 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 10 Jul 2017 13:08:08 -0700 (PDT)
Date: Tue, 11 Jul 2017 06:08:02 +1000
From: Alexey G <x1917x@gmail.com>
Message-ID: <20170711060802.00005020@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] xen-mapcache: Fix the bug when overlapping
 emulated DMA operations may cause inconsistency in guest memory mappings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

(Sorry, sent to a wrong mailing list first instead of QEMU-devel)

Under certain circumstances normal xen-mapcache functioning may be broken
by guest's actions. This may lead to either QEMU performing exit() due to
a caught bad pointer (and with QEMU process gone the guest domain simply
appears hung afterwards) or actual use of the incorrect pointer inside
QEMU address space -- a write to unmapped memory is possible. The bug is
hard to reproduce on a i440 machine as multiple DMA sources are required
(though it's possible in theory, using multiple emulated devices), but can
be reproduced somewhat easily on a Q35 machine using an emulated AHCI
controller -- each NCQ queue command slot may be used as an independent
DMA source ex. using READ FPDMA QUEUED command, so a single storage
device on the AHCI controller port will be enough to produce multiple DMAs
(up to 32). The detailed description of the issue follows.

Xen-mapcache provides an ability to map parts of a guest memory into
QEMU's own address space to work with.

There are two types of cache lookups:
 - translating a guest physical address into a pointer in QEMU's address
   space, mapping a part of guest domain memory if necessary (while trying
   to reduce a number of such (re)mappings to a minimum)
 - translating a QEMU's pointer back to its physical address in guest RAM

These lookups are managed via two linked-lists of structures.
MapCacheEntry is used for forward cache lookups, while MapCacheRev -- for
reverse lookups.

Every guest physical address is broken down into 2 parts:
    address_index  = phys_addr >> MCACHE_BUCKET_SHIFT;
    address_offset = phys_addr & (MCACHE_BUCKET_SIZE - 1);

MCACHE_BUCKET_SHIFT depends on a system (32/64) and is equal to 20 for
a 64-bit system (which assumed for the further description). Basically,
this means that we deal with 1 MB chunks and offsets within those 1 MB
chunks. All mappings are created with 1MB-granularity, i.e. 1MB/2MB/3MB
etc. Most DMA transfers typically are less than 1MB, however, if the
transfer crosses any 1MB border(s) - than a nearest larger mapping size
will be used, so ex. a 512-byte DMA transfer with the start address
700FFF80h will actually require a 2MB range.

Current implementation assumes that MapCacheEntries are unique for a given
address_index and size pair and that a single MapCacheEntry may be reused
by multiple requests -- in this case the 'lock' field will be larger than
1. On other hand, each requested guest physical address (with 'lock' flag)
is described by each own MapCacheRev. So there may be multiple MapCacheRev
entries corresponding to a single MapCacheEntry. The xen-mapcache code
uses MapCacheRev entries to retrieve the address_index & size pair which
in turn used to find a related MapCacheEntry. The 'lock' field within
a MapCacheEntry structure is actually a reference counter which shows
a number of corresponding MapCacheRev entries.

The bug lies in ability for the guest to indirectly manipulate with the
xen-mapcache MapCacheEntries list via a special sequence of DMA
operations, typically for storage devices. In order to trigger the bug,
guest needs to issue DMA operations in specific order and timing.
Although xen-mapcache is protected by the mutex lock -- this doesn't help
in this case, as the bug is not due to a race condition.

Suppose we have 3 DMA transfers, namely A, B and C, where
- transfer A crosses 1MB border and thus uses a 2MB mapping
- transfers B and C are normal transfers within 1MB range
- and all 3 transfers belong to the same address_index

In this case, if all these transfers are to be executed one-by-one
(without overlaps), no special treatment necessary -- each transfer's
mapping lock will be set and then cleared on unmap before starting
the next transfer.
The situation changes when DMA transfers overlap in time, ex. like this:

  |===== transfer A (2MB) =====|

              |===== transfer B (1MB) =====|

                          |===== transfer C (1MB) =====|
 time --->

In this situation the following sequence of actions happens:

1. transfer A creates a mapping to 2MB area (lock=1)
2. transfer B (1MB) tries to find available mapping but cannot find one
   because transfer A is still in progress, and it has 2MB size + non-zero
   lock. So transfer B creates another mapping -- same address_index,
   but 1MB size.
3. transfer A completes, making 1st mapping entry available by setting its
   lock to 0
4. transfer C starts and tries to find available mapping entry and sees
   that 1st entry has lock=0, so it uses this entry but remaps the mapping
   to a 1MB size
5. transfer B completes and by this time
  - there are two locked entries in the MapCacheEntry list with the SAME
    values for both address_index and size
  - the entry for transfer B actually resides farther in list while
    transfer C's entry is first
6. xen_ram_addr_from_mapcache() for transfer B gets correct address_index
   and size pair from corresponding MapCacheRev entry, but then it starts
   looking for MapCacheEntry with these values and finds the first entry
   -- which belongs to transfer C.

At this point there may be following possible (bad) consequences:

1. xen_ram_addr_from_mapcache() will use a wrong entry->vaddr_base value
   in this statement:

   raddr = (reventry->paddr_index << MCACHE_BUCKET_SHIFT) +
       ((unsigned long) ptr - (unsigned long) entry->vaddr_base);

resulting in an incorrent raddr value returned from the function. The
(ptr - entry->vaddr_base) expression may produce both positive and negative
numbers and its actual value may differ greatly as there are many
map/unmap operations take place. If the value will be beyond guest RAM
limits then a "Bad RAM offset" error will be triggered and logged,
followed by exit() in QEMU.

2. If raddr value won't exceed guest RAM boundaries, the same sequence
of actions will be performed for xen_invalidate_map_cache_entry() on DMA
unmap, resulting in a wrong MapCacheEntry being unmapped while DMA
operation which uses it is still active. The above example must
be extended by one more DMA transfer in order to allow unmapping as the
first mapping in the list is sort of resident.

The patch modifies the behavior in which MapCacheEntry's are added to the
list, avoiding duplicates.

Signed-off-by: Alexey Gerasimenko <x1917x@gmail.com>
---
 hw/i386/xen/xen-mapcache.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/hw/i386/xen/xen-mapcache.c b/hw/i386/xen/xen-mapcache.c
index e60156c..84f25ef 100644
--- a/hw/i386/xen/xen-mapcache.c
+++ b/hw/i386/xen/xen-mapcache.c
@@ -206,6 +206,7 @@ static uint8_t *xen_map_cache_unlocked(hwaddr phys_addr, hwaddr size,
                                        uint8_t lock, bool dma)
 {
     MapCacheEntry *entry, *pentry = NULL;
+    MapCacheEntry *avl_entry = NULL, *avl_entry_prev = NULL;
     hwaddr address_index;
     hwaddr address_offset;
     hwaddr cache_size = size;
@@ -251,14 +252,36 @@ tryagain:
 
     entry = &mapcache->entry[address_index % mapcache->nr_buckets];
 
-    while (entry && entry->lock && entry->vaddr_base &&
-            (entry->paddr_index != address_index || entry->size != cache_size ||
-             !test_bits(address_offset >> XC_PAGE_SHIFT,
-                 test_bit_size >> XC_PAGE_SHIFT,
-                 entry->valid_mapping))) {
+    /* find a remappable entry. An existing locked entry which can be reused
+     * has a priority over all other entries (with lock=0, etc).
+     * Normally there will be just few entries for a given address_index
+     * bucket, typically 1-2 entries only
+     */
+    while (entry) {
+        if (entry->lock &&
+            entry->paddr_index == address_index &&
+            entry->size == cache_size &&
+            test_bits(address_offset >> XC_PAGE_SHIFT,
+                 test_bit_size >> XC_PAGE_SHIFT, entry->valid_mapping)) {
+            break;
+        }
+        else if (!entry->lock || !entry->vaddr_base) {
+            avl_entry = entry;
+            avl_entry_prev = pentry;
+        }
+
         pentry = entry;
         entry = entry->next;
     }
+
+    /* if the reuseable entry was not found, use any available.
+     * Otherwise, a new entry will be created
+     */
+    if (avl_entry && !entry) {
+        pentry = avl_entry_prev;
+        entry = avl_entry;
+    }
+
     if (!entry) {
         entry = g_malloc0(sizeof (MapCacheEntry));
         pentry->next = entry;
-- 
2.1.4
