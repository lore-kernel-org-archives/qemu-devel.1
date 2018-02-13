Received: from eggs.gnu.org ([2001:4830:134:3::10]:52828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elhAm-0008HN-79
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 15:27:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elhAj-0007k6-Ce
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 15:27:28 -0500
From: Eric Blake <eblake@redhat.com>
Date: Tue, 13 Feb 2018 14:26:40 -0600
Message-Id: <20180213202701.15858-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 00/21] add byte-based block_status driver
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
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org

There are patches floating around to add NBD_CMD_BLOCK_STATUS,
but NBD wants to report status on byte granularity (even if the
reporting will probably be naturally aligned to sectors or even
much higher levels).  I've therefore started the task of
converting our block status code to report at a byte granularity
rather than sectors.

These patches have been around for a while, but it's time to
finish it now that 2.12 is open for patches.

Based-on: <20180213170529.10858-1-kwolf@redhat.com>
(Kevin's [PULL 00/55] Block layer patches)

The overall conversion currently looks like:
part 1: bdrv_is_allocated (merged, commit 51b0a488, 2.10)
part 2: dirty-bitmap (merged, commit ca759622, 2.11)
part 3: bdrv_get_block_status (merged, commit f0a9c18f, 2.11)
part 4: .bdrv_co_block_status (this series, v7 was here [1])

[1] https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg00954.html

Available as a tag at:
git fetch git://repo.or.cz/qemu/ericb.git nbd-byte-callback-v8

Since v7:
- rebase to master (more iscsi context changes, nvme driver is new)
- add a few more R-bys

Eric Blake (21):
  block: Add .bdrv_co_block_status() callback
  nvme: Drop pointless .bdrv_co_get_block_status()
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

 include/block/block.h     |  14 ++---
 include/block/block_int.h |  51 +++++++++------
 block/io.c                |  86 +++++++++++--------------
 block/blkdebug.c          |  20 +++---
 block/commit.c            |   2 +-
 block/file-posix.c        |  62 +++++++++---------
 block/gluster.c           |  70 ++++++++++-----------
 block/iscsi.c             | 157 ++++++++++++++++++++++++----------------=
------
 block/mirror.c            |   2 +-
 block/null.c              |  23 +++----
 block/nvme.c              |  14 -----
 block/parallels.c         |  22 ++++---
 block/qcow.c              |  27 ++++----
 block/qcow2.c             |  24 +++----
 block/qed.c               |  84 +++++++++----------------
 block/raw-format.c        |  16 ++---
 block/sheepdog.c          |  26 ++++----
 block/throttle.c          |   2 +-
 block/vdi.c               |  45 +++++++------
 block/vmdk.c              |  38 +++++------
 block/vpc.c               |  45 ++++++-------
 block/vvfat.c             |  16 +++--
 22 files changed, 404 insertions(+), 442 deletions(-)

--=20
2.14.3
