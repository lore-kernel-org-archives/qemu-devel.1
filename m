Received: from eggs.gnu.org ([2001:4830:134:3::10]:34808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fqdlw-0004J1-35
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 08:22:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fqdlq-0004Se-PE
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 08:22:31 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 17 Aug 2018 15:22:12 +0300
Message-Id: <20180817122219.16206-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 0/7] qcow2 check improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Hi all!

v2:
02, 06: check bdrv_getlength error return code

v1:

We've faced the following problem: after host fs corruption, vm images
becomes invalid. And which is interesting, starting qemu-img check on
them led to allocating of the whole RAM and then killing qemu-img by
OOM Killer.

This was due to corrupted l2 entries, which referenced clusters far-far
beyond the end of the qcow2 file.
02 is a generic fix for the bug, 01 is unrelated improvement, 03-07 are
additional info and fixing for such corrupted table entries.

Questions on 02, 06 and 07:
1. Should restrictions be more or less strict?
2. Are there valid cases, when such entries should not be considered as
   corrupted?

Vladimir Sementsov-Ogievskiy (7):
  block/qcow2-refcount: fix check_oflag_copied
  block/qcow2-refcount: avoid eating RAM
  block/qcow2-refcount: check_refcounts_l2: refactor compressed case
  block/qcow2-refcount: check_refcounts_l2: reduce ignored overlaps
  block/qcow2-refcount: check_refcounts_l2: split fix_l2_entry_to_zero
  block/qcow2-refcount: fix out-of-file L1 entries to be zero
  block/qcow2-refcount: fix out-of-file L2 entries to be read-as-zero

 block/qcow2-refcount.c | 270 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 219 insertions(+), 51 deletions(-)

-- 
2.11.1
