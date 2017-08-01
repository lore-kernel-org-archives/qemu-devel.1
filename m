Received: from eggs.gnu.org ([2001:4830:134:3::10]:46225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dcVXZ-0002xk-GE
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 07:40:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dcVXU-0002UE-4m
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 07:40:45 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:9229)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dcVXT-0002Sc-S4
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 07:40:40 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OU000MT58FOICA0@mailout2.w1.samsung.com> for
	qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:40:36 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Tue, 01 Aug 2017 14:40:21 +0300
Message-id: <1501587624-5915-1-git-send-email-a.perevalov@samsung.com>
References: <CGME20170801114034eucas1p1a4473bb03afada257f68392c38263b99@eucas1p1.samsung.com>
Subject: [Qemu-devel] [PATCH v9 0/3] Add bitmap for received pages in
 postcopy migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>, quintela@redhat.com, dgilbert@redhat.com, peterx@redhat.com, i.maximets@samsung.com, heetae82.ahn@samsung.com

This is 9th version of
[PATCH v1 0/2] Add bitmap for copied pages in postcopy migration
cover message from there

This is a separate patch set, it derived from
https://www.mail-archive.com/qemu-devel@nongnu.org/msg456004.html

There are several possible use cases:
1. solve issue with postcopy live migration and shared memory.
OVS-VSWITCH requires information about copied pages, to fallocate
newly allocated pages.
2. calculation vCPU blocktime
for more details see
https://www.mail-archive.com/qemu-devel@nongnu.org/msg456004.html
3. Recovery after fail in the middle of postcopy migration 

----------------------------------------------------------------
V8 -> V9
    - patch: "migration: fix incorrect postcopy recved_bitmap" from
"[RFC 00/29] Migration: postcopy failure recovery" patch set was squashed
into the latest patch of this patchset, getpagesize was replaced to
qemu_target_page_size, as David suggested.
    - for the sake of API uniformity semantics of all functions were
changed, now RAMBlock *rb is the first argument, as well as in bitmap API.
    - Also define TARGET_PAGE_BITS was replaced to qemu_target_page_bits in
all other places of this patchset, for uniformity and maintenance. 

V7 -> V8
    - removed unnecessary renaming and moving of block variable to ram_load's
function scope
    - ramblock_recv_map_init became static function

V6 -> V7
    - rebased on
[PATCH v7 0/5] Create setup/cleanup methods for migration incoming side
    - live time of the received map was changed (ram_load_setup/ram_load_cleanup) 

V5 -> V6
    - call ramblock_recv_map_init from migration_fd_process_incoming (Peter suggested)But finalization is still in ram_load_cleanup as Juan suggested.    

V4 -> V5
    - remove ramblock_recv_bitmap_clear_range in favor to bitmap_clear (comment from David)
    - single invocation place for ramblock_recv_bitmap_set (comment from Peter)
    - minor changes like removing comment from qemu_ufd_copy_ioctl and local variable from
ramblock_recv_map_init (comment from Peter)

V3 -> V4
    - clear_bit instead of ramblock_recv_bitmap_clear in ramblock_recv_bitmap_clear_range,
it reduced number of operation (comment from Juan)
    - for postcopy ramblock_recv_bitmap_set is calling after page was copied,
only in case of success (comment from David)
    - indentation fixes (comment from Juan)

V2 -> V3
    - ramblock_recv_map_init call is placed into migration_incoming_get_current,
looks like it's general place for both precopy and postcopy case.
    - received bitmap memory releasing is placed into ram_load_cleanup,
unfortunatelly, it calls only in case of precopy.
    - precopy case and discard ram block case
    - function renaming, and another minor cleanups

V1 -> V2
    - change in terminology s/copied/received/g
    - granularity became TARGET_PAGE_SIZE, but not actual page size of the
ramblock
    - movecopiedmap & get_copiedmap_size were removed, until patch set where
it will be necessary
    - releasing memory of receivedmap was added into ram_load_cleanup
    - new patch "migration: introduce qemu_ufd_copy_ioctl helper"

Patchset is based on:
commit 6d60e295ef020759a03b90724d0342012c189ba2
"Merge remote-tracking branch 'remotes/jnsnow/tags/ide-pull-request' into staging"

Alexey Perevalov (3):
  migration: postcopy_place_page factoring out
  migration: introduce qemu_ufd_copy_ioctl helper
  migration: add bitmap for received page

 include/exec/ram_addr.h  | 10 +++++++++
 migration/postcopy-ram.c | 54 +++++++++++++++++++++++++++++++-----------------
 migration/postcopy-ram.h |  4 ++--
 migration/ram.c          | 49 +++++++++++++++++++++++++++++++++++++++++--
 migration/ram.h          |  6 ++++++
 5 files changed, 100 insertions(+), 23 deletions(-)

-- 
1.9.1
