Received: from eggs.gnu.org ([2001:4830:134:3::10]:47853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dLXl9-00086V-JH
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 12:36:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dLXl4-0001Z7-F4
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 12:36:39 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:13695)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dLXl4-0001X8-98
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 12:36:34 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0ORL00JKYKSUVG40@mailout1.w1.samsung.com> for
	qemu-devel@nongnu.org; Thu, 15 Jun 2017 17:36:30 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Thu, 15 Jun 2017 19:36:12 +0300
Message-id: <1497544575-18628-1-git-send-email-a.perevalov@samsung.com>
References: <CGME20170615163628eucas1p29770ee263d64d3ad254c1fbaa43a46b2@eucas1p2.samsung.com>
Subject: [Qemu-devel] [PATCH v2 0/3] Add bitmap for received pages in
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

This is second version of
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
migration/postcopy-ram.h, because some functions are required in virtio.

----------------------------------------------------------------


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

 include/exec/ram_addr.h  |  2 ++
 migration/postcopy-ram.c | 53 ++++++++++++++++++++++++++++++++----------------
 migration/postcopy-ram.h |  4 ++--
 migration/ram.c          | 37 +++++++++++++++++++++++++++++++--
 migration/ram.h          |  5 +++++
 migration/savevm.c       |  1 +
 6 files changed, 80 insertions(+), 22 deletions(-)

-- 
1.9.1
