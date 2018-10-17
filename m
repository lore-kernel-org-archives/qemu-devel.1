Received: from eggs.gnu.org ([2001:4830:134:3::10]:45006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gCouT-0007YT-3N
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 12:43:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gCouI-0004AH-Un
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 12:42:56 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 17 Oct 2018 18:41:51 +0200
Message-Id: <20181017164200.22344-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/9] block: Add auto-read-only option
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

Kevin Wolf (9):
  block: Update flags in bdrv_set_read_only()
  block: Add auto-read-only option
  block: Require auto-read-only for existing fallbacks
  nbd: Support auto-read-only option
  file-posix: Support auto-read-only option
  curl: Support auto-read-only option
  gluster: Support auto-read-only option
  iscsi: Support auto-read-only option
  block: Make auto-read-only=3Don default for -drive

 qapi/block-core.json  |  7 ++++++
 include/block/block.h |  5 +++-
 block.c               | 54 +++++++++++++++++++++++++++++++++++--------
 block/bochs.c         | 17 +++++---------
 block/cloop.c         | 16 ++++---------
 block/curl.c          |  8 +++----
 block/dmg.c           | 16 ++++---------
 block/file-posix.c    | 19 ++++++++++++---
 block/gluster.c       | 12 ++++++++--
 block/iscsi.c         |  8 ++++---
 block/nbd-client.c    | 10 ++++----
 block/rbd.c           | 14 ++++-------
 block/vvfat.c         | 11 +++------
 blockdev.c            |  1 +
 14 files changed, 120 insertions(+), 78 deletions(-)

--=20
2.19.1
