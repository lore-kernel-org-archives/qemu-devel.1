Received: from eggs.gnu.org ([2001:4830:134:3::10]:56068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d6Jzu-00088w-3i
	for qemu-devel@nongnu.org; Thu, 04 May 2017 12:52:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d6Jzs-0003n4-UH
	for qemu-devel@nongnu.org; Thu, 04 May 2017 12:52:58 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu,  4 May 2017 18:52:35 +0200
Message-Id: <1493916761-32319-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 0/6] block: Fix op blockers for inactive images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org

Fam's image locking series introduced some special-casing in the file-posix
driver that avoids taking locks when the image is inactive. While this works,
it really isn't the job of the file-posix driver, but the core block layer
should consider that inactive nodes require a lot less permissions.

This series integrates op blockers with bdrv_inactivate/invalidate_cache() to
solve this problem gennerically, and removes the workaround in file-posix.

Kevin Wolf (6):
  migration: Unify block node activation error handling
  block: New BdrvChildRole.activate() for blk_resume_after_migration()
  block: Drop permissions when migration completes
  block: Inactivate parents before children
  block: Fix write/resize permissions for inactive images
  file-posix: Remove .bdrv_inactivate/invalidate_cache

 block.c                   | 76 ++++++++++++++++++++++++++++++++++++++++----
 block/block-backend.c     | 81 +++++++++++++++++++++++++++++++----------------
 block/file-posix.c        | 33 -------------------
 include/block/block.h     |  3 +-
 include/block/block_int.h |  6 ++++
 migration/migration.c     | 13 ++------
 migration/savevm.c        |  9 ++----
 qmp.c                     | 18 ++++-------
 8 files changed, 139 insertions(+), 100 deletions(-)

-- 
1.8.3.1
