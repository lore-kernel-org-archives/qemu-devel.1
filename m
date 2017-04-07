Received: from eggs.gnu.org ([2001:4830:134:3::10]:50449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cwav5-0005yD-K5
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 16:55:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cwav4-0003LG-7c
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 16:55:47 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Fri,  7 Apr 2017 16:55:24 -0400
Message-Id: <cover.1491597120.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.10 0/8] RBD reopen, read_only cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, kwolf@redhat.com, jsnow@redhat.com, eblake@redhat.com


Changes from v1:

Patch 2: Has v1 patch 8 (do not blindly xset bs->read_only) squashed into it
         (thanks Stefan)
         COW -> "copy-on-read" (Thanks John)
         Drop unneeded call in vvfat, and bypass enable_write_target (Stefan)

Patch 5: Rename bdrv_try_... to bdrv_can_set_read_only() (Thanks John, Stefan)

Patch 6: Use "reopen_state->flags" not "reopen_state->bs->open_flags"
         (Thanks John)



This series does two things:

1.) Cleans up some of the logic behind setting the read_only flag
    for a BDS in the block layer, so that it is done consistently
    (and rules are applied consistently), and

2.) Adds .bdrv_reopen_prepare() implementation for RBD, so that block
    jobs can be run on backing chains that have rbd protocol nodes.

Jeff Cody (8):
  block: add bdrv_set_read_only() helper function
  block: do not set BDS read_only if copy_on_read enabled
  block: honor BDRV_O_ALLOW_RDWR when clearing bs->read_only
  block: code movement
  block: introduce bdrv_can_set_read_only()
  block: use bdrv_can_set_read_only() during reopen
  block/rbd - update variable names to more apt names
  block/rbd: Add support for reopen()

 block.c               | 56 +++++++++++++++++++++++++++++++++++---------
 block/bochs.c         |  5 +++-
 block/cloop.c         |  5 +++-
 block/dmg.c           |  6 ++++-
 block/rbd.c           | 65 +++++++++++++++++++++++++++++++++++++--------------
 block/vvfat.c         | 19 +++++++++++----
 include/block/block.h |  2 ++
 7 files changed, 123 insertions(+), 35 deletions(-)

-- 
2.9.3
