Received: from eggs.gnu.org ([2001:4830:134:3::10]:59609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gAchX-0006ai-VS
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 11:16:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gAchV-0006hr-3Y
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 11:16:35 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 11 Oct 2018 18:16:15 +0300
Message-Id: <20181011151623.25702-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 0/8] qcow2 check improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Hi all!

v3:

01: s/l2_fixed_entries/l2_dirty/
02: add comment, s/>/>=
03: s/BDRV_SECTOR_SIZE/512
04: add Max's r-b
05: new
06-08: mostly rewritten

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

Vladimir Sementsov-Ogievskiy (8):
  block/qcow2-refcount: fix check_oflag_copied
  block/qcow2-refcount: avoid eating RAM
  block/qcow2-refcount: check_refcounts_l2: refactor compressed case
  block/qcow2-refcount: check_refcounts_l2: reduce ignored overlaps
  block/qcow2-refcount: check_refcounts_l2: don't count corrupted
    entries
  block/qcow2-refcount: refactor fixing L2 entry
  block/qcow2-refcount: fix out-of-file L1 entries to be zero
  block/qcow2-refcount: fix out-of-file L2 entries

 block/qcow2-refcount.c | 352 ++++++++++++++++++++++++++++++-----------
 1 file changed, 264 insertions(+), 88 deletions(-)

-- 
2.18.0
