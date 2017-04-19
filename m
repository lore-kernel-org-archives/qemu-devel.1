Received: from eggs.gnu.org ([2001:4830:134:3::10]:52137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d0m9j-0003mP-8e
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:44:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d0m9i-00057q-Dk
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:44:11 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 19 Apr 2017 17:43:40 +0800
Message-Id: <20170419094356.19826-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 00/16] block: Protect AIO context change
 with perm API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

v2: Address Stefan's comments:

    - Clean up redundancy in bdrv_format_default_perms change.
    - Add a test case to check both success/failure cases.
      A failure case is not possible at user interface level because of other
      checks we have, so write a unit test in tests/test-blk-perm.c.

Eject / change of scsi-cd on a virtio-scsi dataplane bus causes abort() because
the new BDS doesn't get proper bdrv_set_aio_context().

Store the AioContext in BB and do it in blk_insert_bs. That is done by
Vladimir's patch.

Other patches are to make sure such a bdrv_set_aio_context() doesn't interfere
with other BBs using other nodes from this graph.

Fam

Fam Zheng (15):
  block: Define BLK_PERM_AIO_CONTEXT_CHANGE
  block-backend: Add blk_request_perm
  blockjob: Add BLK_PERM_AIO_CONTEXT_CHANGE shared perm on bs
  blockjob: Allow aio context change on intermediate nodes
  block: Propagate BLK_PERM_AIO_CONTEXT_CHANGE down the graph
  backup: Request BLK_PERM_AIO_CONTEXT_CHANGE on target
  backup: Do initial aio context move of target via BB interface
  mirror: Request aio context change permission on target
  commit: Allow aio context change on s->base
  mirror: Do initial aio context move of target via BB interface
  virtio-scsi: Request BLK_PERM_AIO_CONTEXT_CHANGE for dataplane
  virtio-blk: Request BLK_PERM_AIO_CONTEXT_CHANGE for dataplane
  nbd: Allow BLK_PERM_AIO_CONTEXT_CHANGE on BB
  block: Add perm assertion on blk_set_aio_context
  tests: Add test case for BLK_PERM_AIO_CONTEXT_CHANGE

Vladimir Sementsov-Ogievskiy (1):
  blk: fix aio context loss on media change

 block.c                         | 12 ++++++---
 block/backup.c                  | 11 +++++++-
 block/block-backend.c           | 22 +++++++++++++++
 block/commit.c                  |  6 +++--
 block/mirror.c                  | 13 ++++++++-
 block/stream.c                  |  3 ++-
 block/vvfat.c                   |  2 +-
 blockdev.c                      | 18 -------------
 blockjob.c                      |  3 +++
 hw/block/dataplane/virtio-blk.c | 15 ++++++++---
 hw/scsi/virtio-scsi.c           |  4 +++
 include/block/block.h           |  7 ++++-
 include/sysemu/block-backend.h  |  1 +
 nbd/server.c                    |  6 +++--
 tests/Makefile.include          |  2 ++
 tests/test-blk-perm.c           | 59 +++++++++++++++++++++++++++++++++++++++++
 16 files changed, 149 insertions(+), 35 deletions(-)
 create mode 100644 tests/test-blk-perm.c

-- 
2.9.3
