Received: from eggs.gnu.org ([2001:4830:134:3::10]:46127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsVJx-0005TH-3P
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:40:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsVJv-0002J8-Jr
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:40:49 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 14 Sep 2017 09:40:12 -0500
Message-Id: <20170914144032.14945-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 00/20] add byte-based block_status driver
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
Cc: kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org

There are patches floating around to add NBD_CMD_BLOCK_STATUS,
but NBD wants to report status on byte granularity (even if the
reporting will probably be naturally aligned to sectors or even
much higher levels).  I've therefore started the task of
converting our block status code to report at a byte granularity
rather than sectors.

Now that 2.11 is open, I'm rebasing/reposting the remaining patches.

The overall conversion currently looks like:
part 1: bdrv_is_allocated (merged, commit 51b0a488)
part 2: dirty-bitmap (v7 is posted [1], mostly reviewed, but may need v8)
part 3: bdrv_get_block_status (v4 is posted [2], partially reviewed)
part 4: .bdrv_co_block_status (this series, v2 was here [3])

Available as a tag at:
git fetch git://repo.or.cz/qemu/ericb.git nbd-byte-status-v4

Based-on: <20170912203119.24166-1-eblake@redhat.com>
([PATCH v7 00/20] make dirty-bitmap byte-based)

Based-on: <20170914134923.2479-1-eblake@redhat.com>
([PATCH v2] osdep: Fix ROUND_UP(64-bit, 32-bit))

Based-on: <20170913160333.23622-1-eblake@redhat.com>
([PATCH v4 00/24] make bdrv_get_block_status byte-based)

[1] https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg03160.html
[2] https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg03543.html
[3] https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg04370.html

Diff from v2:
- Minor rebasing

001/20:[----] [--] 'block: Add .bdrv_co_block_status() callback'
002/20:[0002] [FC] 'block: Switch passthrough drivers to .bdrv_co_block_s=
tatus()'
003/20:[----] [--] 'file-posix: Switch to .bdrv_co_block_status()'
004/20:[----] [--] 'gluster: Switch to .bdrv_co_block_status()'
005/20:[----] [--] 'iscsi: Switch cluster_sectors to byte-based'
006/20:[----] [--] 'iscsi: Switch iscsi_allocmap_update() to byte-based'
007/20:[----] [--] 'iscsi: Switch to .bdrv_co_block_status()'
008/20:[----] [--] 'null: Switch to .bdrv_co_block_status()'
009/20:[----] [--] 'parallels: Switch to .bdrv_co_block_status()'
010/20:[0008] [FC] 'qcow: Switch to .bdrv_co_block_status()'
011/20:[----] [--] 'qcow2: Switch to .bdrv_co_block_status()'
012/20:[----] [--] 'qed: Switch to .bdrv_co_block_status()'
013/20:[----] [--] 'raw: Switch to .bdrv_co_block_status()'
014/20:[----] [--] 'sheepdog: Switch to .bdrv_co_block_status()'
015/20:[----] [--] 'vdi: Avoid bitrot of debugging code'
016/20:[----] [--] 'vdi: Switch to .bdrv_co_block_status()'
017/20:[----] [--] 'vmdk: Switch to .bdrv_co_block_status()'
018/20:[0015] [FC] 'vpc: Switch to .bdrv_co_block_status()'
019/20:[----] [--] 'vvfat: Switch to .bdrv_co_block_status()'
020/20:[----] [--] 'block: Drop unused .bdrv_co_get_block_status()'

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
 block/throttle.c          |   2 +-
 block/vdi.c               |  40 ++++++-------
 block/vmdk.c              |  27 +++++----
 block/vpc.c               |  35 +++++------
 block/vvfat.c             |  16 +++--
 20 files changed, 350 insertions(+), 305 deletions(-)

--=20
2.13.5
