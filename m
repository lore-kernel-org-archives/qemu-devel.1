Received: from eggs.gnu.org ([2001:4830:134:3::10]:47959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mahaocong_work@163.com>) id 1gZtrE-0006cR-9J
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 03:39:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mahaocong_work@163.com>) id 1gZtrD-0004m6-Ji
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 03:39:04 -0500
From: mahaocong <mahaocong_work@163.com>
Date: Thu, 20 Dec 2018 16:38:38 +0800
Message-Id: <20181220083839.85523-1-mahaocong_work@163.com>
Subject: [Qemu-devel] [PATCH v1 0/1] migration: add incremental mode on
 drive-mirror
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org, mahaocong <mahaocong@didichuxing.com>

From: mahaocong <mahaocong@didichuxing.com>

This patch adds possibility to start mirroring with user-created-bitmap.
The use-case is, for live migration with ceph rbd image. I think the new
function may be used to reduce the initial dirty block number on drive-mirror
by using user-created-bitmap instead of created from block-backing-chain,
comparing with full mode and top mode, and thus accelerate the live-migration speed.

This function should be used with backup. My test steps is as follows:
1.create rbd image in ceph cluster, and map nbd device with rbd image.
2.create a new bitmap attached to drive.
3.create a full backup on nbd device and sync it to the rbd image.
4.create new image in destination host and set it's backingfile as rbd image.
5.start incremental mirroring to destination with dirty-bitmap from step 2.
6.live migrate VM to destination, bitmap should be migrated too.
7.unmap nbd in source host and map in destination.

Then I can use incremental backup to sync data and renew bitmap. If live migrate
VM again, repeat step 4 to step 7. The first live-migration depend on full backup,
but in the next live-migration, we can reuse backup data and bitmap to reduce the
initial dirty block number on mirror.
User-created-bitmap should be migrated, which record dirty block starting
in backup and in live-migration.

mahaocong (1):
  mirror: add incremental mode support. when use incremental in drive-mirror
          by qmp-command, drive-mirror create unnamed-bitmap with the same
          granularity of user-bitmap setting on qmp-command. Next, copy It's
          hbitmap to unnamed-bitmap. Then, start mirror with this unnamed-bitmap.
  dirty-bitmap: add new API to copy dirty-bitmap.
  hbitmap: add new function to copy hbitmap.

 block/dirty-bitmap.c         | 14 ++++++++++
 block/mirror.c               | 63 +++++++++++++++++++++++++++++++++++---------
 blockdev.c                   | 36 +++++++++++++++++++++++--
 include/block/block_int.h    |  3 ++-
 include/block/dirty-bitmap.h |  3 +++
 include/qemu/hbitmap.h       |  2 ++
 qapi/block-core.json         |  9 ++++++-
 util/hbitmap.c               | 28 ++++++++++++++++++++
 8 files changed, 141 insertions(+), 17 deletions(-)

-- 
2.14.1
