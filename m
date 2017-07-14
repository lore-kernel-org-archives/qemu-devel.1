Received: from eggs.gnu.org ([2001:4830:134:3::10]:46333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVzV5-0003Ox-Vk
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:15:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVzV4-0003dE-Nn
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:15:15 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri, 14 Jul 2017 07:14:37 -0500
Message-Id: <20170714121457.10322-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 00/20] add byte-based block_status driver
 callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com

There are patches floating around to add NBD_CMD_BLOCK_STATUS,
but NBD wants to report status on byte granularity (even if the
reporting will probably be naturally aligned to sectors or even
much higher levels).  I've therefore started the task of
converting our block status code to report at a byte granularity
rather than sectors.

The overall conversion currently looks like:
part 1: bdrv_is_allocated (merged, commit 51b0a488)
part 2: dirty-bitmap (v5 is posted [1], mostly reviewed)
part 3: bdrv_get_block_status (v3 is posted [2], mostly reviewed)
part 4: .bdrv_co_block_status (this series, second half of v1 [3])

Available as a tag at:
git fetch git://repo.or.cz/qemu/ericb.git nbd-byte-callback-v2

It depends on my dirty-bitmap patches [1], Manos' filter cleanups [4],
and my bdrv_get_block_status patches [2].

[1] https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg03512.html
[2] https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg03853.html
[3] https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg02642.html
[4] https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg03846.html

Since v1:
- rebase to master and changes in earlier series
- fix a couple of bugs

001/20:[0083] [FC] 'block: Add .bdrv_co_block_status() callback'
002/20:[down] 'block: Switch passthrough drivers to .bdrv_co_block_status=
()'
003/20:[0010] [FC] 'file-posix: Switch to .bdrv_co_block_status()'
004/20:[0017] [FC] 'gluster: Switch to .bdrv_co_block_status()'
005/20:[----] [--] 'iscsi: Switch cluster_sectors to byte-based'
006/20:[0016] [FC] 'iscsi: Switch iscsi_allocmap_update() to byte-based'
007/20:[0004] [FC] 'iscsi: Switch to .bdrv_co_block_status()'
008/20:[0001] [FC] 'null: Switch to .bdrv_co_block_status()'
009/20:[0006] [FC] 'parallels: Switch to .bdrv_co_block_status()'
010/20:[0005] [FC] 'qcow: Switch to .bdrv_co_block_status()'
011/20:[0006] [FC] 'qcow2: Switch to .bdrv_co_block_status()'
012/20:[0010] [FC] 'qed: Switch to .bdrv_co_block_status()'
013/20:[0001] [FC] 'raw: Switch to .bdrv_co_block_status()'
014/20:[0004] [FC] 'sheepdog: Switch to .bdrv_co_block_status()'
015/20:[----] [--] 'vdi: Avoid bitrot of debugging code'
016/20:[0005] [FC] 'vdi: Switch to .bdrv_co_block_status()'
017/20:[0005] [FC] 'vmdk: Switch to .bdrv_co_block_status()'
018/20:[0013] [FC] 'vpc: Switch to .bdrv_co_block_status()'
019/20:[0016] [FC] 'vvfat: Switch to .bdrv_co_block_status()'
020/20:[0068] [FC] 'block: Drop unused .bdrv_co_get_block_status()'

Eric Blake (20):
  block: Add .bdrv_co_block_status() callback
  block: Switch passthrough drivers to .bdrv_co_block_status()
  file-posix: Switch to .bdrv_co_block_status()
  gluster: Switch to .bdrv_co_block_status()
  iscsi: Switch cluster_sectors to byte-based
  iscsi: Switch iscsi_allocmap_update() to byte-based
  iscsi: Switch to .bdrv_co_block_status()
  null: Switch to .bdrv_co_block_status()
  parallels: Switch to .bdrv_co_block_status()
  qcow: Switch to .bdrv_co_block_status()
  qcow2: Switch to .bdrv_co_block_status()
  qed: Switch to .bdrv_co_block_status()
  raw: Switch to .bdrv_co_block_status()
  sheepdog: Switch to .bdrv_co_block_status()
  vdi: Avoid bitrot of debugging code
  vdi: Switch to .bdrv_co_block_status()
  vmdk: Switch to .bdrv_co_block_status()
  vpc: Switch to .bdrv_co_block_status()
  vvfat: Switch to .bdrv_co_block_status()
  block: Drop unused .bdrv_co_get_block_status()

 include/block/block_int.h |  38 ++++++------
 block/io.c                |  60 ++++++++++---------
 block/blkdebug.c          |  19 +++---
 block/commit.c            |   2 +-
 block/file-posix.c        |  57 ++++++++++--------
 block/gluster.c           |  62 +++++++++++---------
 block/iscsi.c             | 146 +++++++++++++++++++++++++---------------=
------
 block/mirror.c            |   2 +-
 block/null.c              |  22 +++----
 block/parallels.c         |  19 ++++--
 block/qcow.c              |  25 ++++----
 block/qcow2.c             |  21 ++++---
 block/qed.c               |  22 +++----
 block/raw-format.c        |  17 +++---
 block/sheepdog.c          |  23 ++++----
 block/vdi.c               |  40 ++++++-------
 block/vmdk.c              |  27 +++++----
 block/vpc.c               |  40 ++++++-------
 block/vvfat.c             |  16 +++--
 19 files changed, 349 insertions(+), 309 deletions(-)

--=20
2.9.4
