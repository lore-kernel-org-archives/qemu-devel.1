Received: from eggs.gnu.org ([2001:4830:134:3::10]:51876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpvLT-0004OV-Ls
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 08:56:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpvL4-0000SP-3c
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 08:56:14 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 15 Aug 2018 14:55:16 +0200
Message-Id: <20180815125537.10651-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/21] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

The following changes since commit 38441756b70eec5807b5f60dad11a93a911998=
66:

  Update version for v3.0.0 release (2018-08-14 16:38:43 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to b5fc2d306664c0c1c6c5cf8e164ffa7b8892283e:

  qapi: block: Remove mentions of error types which were removed (2018-08=
-15 12:50:39 +0200)

----------------------------------------------------------------
Block layer patches:

- Remove deprecated -drive options for geometry/serial/addr
- luks: Allow shared writers if the parents allow them (share-rw=3Don)
- qemu-img: Fix error when trying to convert to encrypted target image
- mirror: Fail gracefully for source =3D=3D target
- I/O throttling: Fix behaviour during drain (always ignore the limits)
- bdrv_reopen() related fixes for bs->options/explicit_options content
- Documentation improvements

----------------------------------------------------------------
Alberto Garcia (9):
      qemu-iotests: Test removing a throttle group member with a pending =
timer
      throttle-groups: Skip the round-robin if a member is being drained
      qemu-iotests: Update 093 to improve the draining test
      throttle-groups: Don't allow timers without throttled requests
      qdict: Make qdict_extract_subqdict() accept dst =3D NULL
      block: Remove children options from bs->{options,explicit_options}
      block: Simplify bdrv_reopen_abort()
      block: Update bs->options if bdrv_reopen() succeeds
      block: Simplify append_open_options()

Daniel P. Berrang=C3=A9 (1):
      qemu-img: fix regression copying secrets during convert

Fam Zheng (1):
      luks: Allow share-rw=3Don

Kevin Wolf (7):
      block/qapi: Fix memory leak in qmp_query_blockstats()
      block: Remove deprecated -drive geometry options
      block: Remove deprecated -drive option addr
      block: Remove deprecated -drive option serial
      block: Remove dead deprecation warning code
      qapi/block: Document restrictions for node names
      mirror: Fail gracefully for source =3D=3D target

Peter Krempa (1):
      qapi: block: Remove mentions of error types which were removed

Vladimir Sementsov-Ogievskiy (2):
      block: make .bdrv_close optional
      block: drop empty .bdrv_close handlers

 qapi/block-core.json       |   8 ++--
 include/hw/block/block.h   |   1 -
 include/sysemu/blockdev.h  |   3 --
 block.c                    |  46 ++++++++++++++-----
 block/blkreplay.c          |   5 ---
 block/block-backend.c      |   1 -
 block/commit.c             |   5 ---
 block/copy-on-read.c       |   6 ---
 block/crypto.c             |   4 +-
 block/mirror.c             |  10 ++---
 block/null.c               |   6 ---
 block/qapi.c               |   3 +-
 block/raw-format.c         |   5 ---
 block/snapshot.c           |   4 +-
 block/throttle-groups.c    |  41 ++++++++++++-----
 blockdev.c                 | 110 ---------------------------------------=
------
 device-hotplug.c           |   4 --
 hw/block/block.c           |  27 -----------
 hw/block/nvme.c            |   1 -
 hw/block/virtio-blk.c      |   1 -
 hw/ide/qdev.c              |   1 -
 hw/scsi/scsi-disk.c        |   1 -
 hw/usb/dev-storage.c       |   1 -
 qemu-img.c                 |  32 +++++++------
 qobject/block-qdict.c      |  11 +++--
 tests/ahci-test.c          |   6 +--
 tests/hd-geo-test.c        |  37 +++------------
 tests/ide-test.c           |   8 ++--
 hmp-commands.hx            |   1 -
 qemu-deprecated.texi       |  15 -------
 qemu-options.hx            |  14 +-----
 tests/qemu-iotests/041     |   6 +++
 tests/qemu-iotests/041.out |   4 +-
 tests/qemu-iotests/093     |  55 +++++++++++++++++++++++
 tests/qemu-iotests/093.out |   4 +-
 35 files changed, 185 insertions(+), 302 deletions(-)
