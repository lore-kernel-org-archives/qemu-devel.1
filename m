Received: from eggs.gnu.org ([2001:4830:134:3::10]:33626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dPnBl-0007SZ-1N
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:53:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dPnBh-0001Ru-V7
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:53:41 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:37020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dPnBh-0001Me-LK
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:53:37 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OS700A9UA58G890@mailout2.w1.samsung.com> for
	qemu-devel@nongnu.org; Tue, 27 Jun 2017 10:53:32 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Tue, 27 Jun 2017 05:50:24 -0400
Message-id: <1498557027-18143-1-git-send-email-a.perevalov@samsung.com>
References: <CGME20170627095331eucas1p12a729c667ed1b48fd6d7806c384880eb@eucas1p1.samsung.com>
Subject: [Qemu-devel] [PATCH v5 0/3] Add bitmap for received pages in
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
Cc: Alexey Perevalov <a.perevalov@samsung.com>, peterx@redhat.com, i.maximets@samsung.com, quintela@redhat.com, dgilbert@redhat.com

This is 5th version of
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

Declaration is placed in two places include/migration/migration.h and into
migration/postcopy-ram.h, because some functions are required in virtio and
into public function include/exec/ram_addr.h.

----------------------------------------------------------------
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

Patchset is based on Juan's patchset:
[PATCH v2 0/5] Create setup/cleanup methods for migration incoming side

Alexey Perevalov (3):
  migration: postcopy_place_page factoring out
  migration: introduce qemu_ufd_copy_ioctl helper
  migration: add bitmap for received page

 include/exec/ram_addr.h  | 10 +++++++++
 migration/migration.c    |  1 +
 migration/postcopy-ram.c | 53 +++++++++++++++++++++++++++++++-----------------
 migration/postcopy-ram.h |  4 ++--
 migration/ram.c          | 46 ++++++++++++++++++++++++++++++++++++-----
 migration/ram.h          |  6 ++++++
 6 files changed, 94 insertions(+), 26 deletions(-)

-- 
1.8.3.1
