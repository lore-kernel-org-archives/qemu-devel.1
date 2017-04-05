Received: from eggs.gnu.org ([2001:4830:134:3::10]:34060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cvpg1-0006XT-1k
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 14:29:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cvpg0-00027K-7C
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 14:29:05 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Wed,  5 Apr 2017 14:28:42 -0400
Message-Id: <cover.1491416061.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 0/9] RBD reopen, read_only cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, stefanha@redhat.com, kwolf@redhat.com

This series does two things:

1.) Cleans up some of the logic behind setting the read_only flag
    for a BDS in the block layer, so that it is done consistently
    (and rules are applied consistently), and

2.) Adds .bdrv_reopen_prepare() implementation for RBD, so that block
    jobs can be run on backing chains that have rbd protocol nodes.

Jeff Cody (9):
  block: add bdrv_set_read_only() helper function
  block: do not set BDS read_only if copy_on_read enabled
  block: honor BDRV_O_ALLOW_RDWR when clearing bs->read_only
  block: code movement
  block: introduce bdrv_try_set_read_only()
  block: use bdrv_try_set_read_only() during reopen
  block/rbd - update variable names to more apt names
  block/rbd: do not blindly set bs->read_only
  block/rbd: Add support for reopen()

 block.c               | 56 +++++++++++++++++++++++++++++++++++---------
 block/bochs.c         |  5 +++-
 block/cloop.c         |  5 +++-
 block/dmg.c           |  6 ++++-
 block/rbd.c           | 65 +++++++++++++++++++++++++++++++++++++--------------
 block/vvfat.c         | 15 +++++++++---
 include/block/block.h |  2 ++
 7 files changed, 120 insertions(+), 34 deletions(-)

-- 
2.9.3
