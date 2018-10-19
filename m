Received: from eggs.gnu.org ([2001:4830:134:3::10]:37346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gDXfb-0002uc-5h
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:30:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gDXfW-00020x-Jw
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:30:38 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 19 Oct 2018 18:30:04 +0200
Message-Id: <20181019163013.11787-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 00/11] block: Add auto-read-only option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

See patch 2 for an explanation of the motivation.

v4:
- Split fix for missing rbd_close() into a separate patch [Eric]
- Added qemu-iotests case

v3:
- Clarified QAPI schema documentation that auto-read-only can only
  degrade read-write to read-only, not the other way round [Eric]
- Don't refuse to set copy-on-read=3Don and auto-read-only=3Don at the sa=
me
  time; only complain when actually trying to degrade to read-only
- Let bdrv_apply_auto_read_only() return -EACCESS on all errors
- Fixed file-posix and gluster implementations [Eric, Niels]
- Added a patch to make auto-read-only=3Don the default for human user
  interfaces (-drive/-hda/...)

v2:
- Turn bdrv_set_read_only() into bdrv_apply_auto_read_only()
- Support the option in a lot more block drivers

Kevin Wolf (11):
  block: Update flags in bdrv_set_read_only()
  block: Add auto-read-only option
  rbd: Close image in qemu_rbd_open() error path
  block: Require auto-read-only for existing fallbacks
  nbd: Support auto-read-only option
  file-posix: Support auto-read-only option
  curl: Support auto-read-only option
  gluster: Support auto-read-only option
  iscsi: Support auto-read-only option
  block: Make auto-read-only=3Don default for -drive
  qemu-iotests: Test auto-read-only with -drive and -blockdev

 qapi/block-core.json       |   7 ++
 include/block/block.h      |   5 +-
 block.c                    |  54 +++++++++++---
 block/bochs.c              |  17 ++---
 block/cloop.c              |  16 ++--
 block/curl.c               |   8 +-
 block/dmg.c                |  16 ++--
 block/file-posix.c         |  19 ++++-
 block/gluster.c            |  12 ++-
 block/iscsi.c              |   8 +-
 block/nbd-client.c         |  10 +--
 block/rbd.c                |  14 +---
 block/vvfat.c              |  11 +--
 blockdev.c                 |   1 +
 tests/qemu-iotests/232     | 147 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/232.out |  59 +++++++++++++++
 tests/qemu-iotests/group   |   1 +
 17 files changed, 327 insertions(+), 78 deletions(-)
 create mode 100755 tests/qemu-iotests/232
 create mode 100644 tests/qemu-iotests/232.out

--=20
2.19.1
