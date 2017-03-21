Received: from eggs.gnu.org ([2001:4830:134:3::10]:39305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cqAI5-0001J5-Fy
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 23:17:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cqAI0-0000IJ-4h
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 23:16:53 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 21 Mar 2017 11:16:19 +0800
Message-Id: <20170321031635.22123-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 00/16] block: Protect AIO context change
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Eject / change of scsi-cd on a virtio-scsi dataplane bus causes abort() because
the new BDS doesn't get proper bdrv_set_aio_context().

Store the AioContext in BB and do it in blk_insert_bs. That is done by
Vladimir's patch.

Other patches are to make sure such a bdrv_set_aio_context() doesn't interfere
with other BBs using other nodes from this graph.

RFC note:

Unfortunately, a use-after-free crash in iotests 030 appears since patch 7,
which I believe is a latent bug that bdrv_reopen is "reentered" in existing
code, rather than from this series:

> #4  0x0000561ab90425a7 in bdrv_reopen
> #5  0x0000561ab8e1d28e in stream_complete
> #6  0x0000561ab9048543 in block_job_defer_to_main_loop_bh
> #7  0x0000561ab91305bc in aio_bh_call
> #8  0x0000561ab9130659 in aio_bh_poll
> #9  0x0000561ab9135656 in aio_poll
> #10 0x0000561ab90a6cf5 in bdrv_flush
> #11 0x0000561ab904285a in bdrv_reopen_prepare
> #12 0x0000561ab90423f0 in bdrv_reopen_multiple
> #13 0x0000561ab90425ef in bdrv_reopen
> #14 0x0000561ab909fa49 in commit_active_start
> #15 0x0000561ab8dd6ffb in qmp_block_commit
> #16 0x0000561ab8ded485 in qmp_marshal_block_commit
> #17 0x0000561ab9123e6c in do_qmp_dispatch
> #18 0x0000561ab9123fa4 in qmp_dispatch
> #19 0x0000561ab8ca26b7 in handle_qmp_command

I have a fix that I'll post separately.

The last patches are an alternative to patch 7, to "workaround" this in a
really non-obvious way.

Fam

Fam Zheng (15):
  block: Define BLK_PERM_AIO_CONTEXT_CHANGE
  block-backend: Add blk_request_perm
  blockjob: Add BLK_PERM_AIO_CONTEXT_CHANGE shared perm on bs
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
  mirror: Lazily request aio context change permission on target
  Revert "mirror: Request aio context change permission on target"

Vladimir Sementsov-Ogievskiy (1):
  blk: fix aio context loss on media change

 block.c                         | 20 ++++++++++++--------
 block/backup.c                  | 11 ++++++++++-
 block/block-backend.c           | 23 +++++++++++++++++++++++
 block/commit.c                  |  3 ++-
 block/mirror.c                  | 10 ++++++++++
 block/vvfat.c                   |  2 +-
 blockdev.c                      | 18 ------------------
 blockjob.c                      |  3 +++
 hw/block/dataplane/virtio-blk.c | 15 +++++++++++----
 hw/scsi/virtio-scsi.c           |  4 ++++
 include/block/block.h           |  7 ++++++-
 include/sysemu/block-backend.h  |  1 +
 nbd/server.c                    |  6 ++++--
 13 files changed, 87 insertions(+), 36 deletions(-)

-- 
2.9.3
