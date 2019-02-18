Received: from eggs.gnu.org ([209.51.188.92]:33114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gvjcY-00056o-3t
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:10:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gvjcW-0007Ro-2v
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:10:10 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 18 Feb 2019 17:09:09 +0300
Message-Id: <20190218140926.333779-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 00/17] block: local qiov helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com, jsnow@redhat.com, den@openvz.org, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com

Hi all!

Here is a new simple helper for a very often patter
around qemu_iovec_init_external, when we need simple qiov with only
one iov, initialized from external buffer.

v4:
 01: tiny improvements by Eric
     + fix bug: s/niov/nalloc in assertion
     + rename s/qemu_iovec_get_buf/qemu_iovec_buf,
       to don't look like getter, which in turn should not return
       pointer to something internal to be freed separately.
     So, no r-b's in 01 
 07,10,16
    - rebase on new function name qemu_iovec_buf 
    - save r-b's by Eric and Stefan
 others unchanged, add r-b's by Eric and Stefan

v3:
  01-02: tiny improvements, described in patch-emails
  03-17: new patches

  Note: only hw/scsi/scsi-disk.c not updated, as it has too tricky
        logic around @iov fields of structures. So, it is simpler to
        keep it as is.

v2 was "[PATCH v2 0/2] block: local qiov helper: part I"
https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg01610.html

Vladimir Sementsov-Ogievskiy (17):
  block: enhance QEMUIOVector structure
  block/io: use qemu_iovec_init_buf
  block/block-backend: use QEMU_IOVEC_INIT_BUF
  block/backup: use qemu_iovec_init_buf
  block/commit: use QEMU_IOVEC_INIT_BUF
  block/stream: use QEMU_IOVEC_INIT_BUF
  block/parallels: use QEMU_IOVEC_INIT_BUF
  block/qcow: use qemu_iovec_init_buf
  block/qcow2: use qemu_iovec_init_buf
  block/qed: use qemu_iovec_init_buf
  block/vmdk: use qemu_iovec_init_buf
  qemu-img: use qemu_iovec_init_buf
  migration/block: use qemu_iovec_init_buf
  tests/test-bdrv-drain: use QEMU_IOVEC_INIT_BUF
  hw/ide: drop iov field from IDEState
  hw/ide: drop iov field from IDEBufferedRequest
  hw/ide: drop iov field from IDEDMA

 include/hw/ide/internal.h |  3 --
 include/qemu/iov.h        | 64 +++++++++++++++++++++++++++-
 block/backup.c            |  5 +--
 block/block-backend.c     | 13 +-----
 block/commit.c            |  7 +--
 block/io.c                | 89 +++++++++------------------------------
 block/parallels.c         | 13 +++---
 block/qcow.c              | 21 ++-------
 block/qcow2.c             | 12 +-----
 block/qed-table.c         | 16 ++-----
 block/qed.c               | 31 ++++----------
 block/stream.c            |  7 +--
 block/vmdk.c              |  7 +--
 hw/ide/atapi.c            | 14 +++---
 hw/ide/core.c             | 19 ++++-----
 migration/block.c         | 10 ++---
 qemu-img.c                | 10 +----
 tests/test-bdrv-drain.c   | 29 ++-----------
 18 files changed, 134 insertions(+), 236 deletions(-)

-- 
2.18.0
