Received: from eggs.gnu.org ([2001:4830:134:3::10]:59632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyhfy-0004wA-MH
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:37:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyhfx-0001fg-O1
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:37:26 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 21 Mar 2018 18:37:02 +0100
Message-Id: <20180321173714.14741-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-2.12 v2 00/12] block: Follow-up for
 .bdrv_co_create (part 1)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, jcody@redhat.com, eblake@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org

This series adds qemu-iotests for a few more block drivers (yet more to
come in another series) and fixes a few things that previous review and
these tests brought up.

The only major design change is that I converted the vdi block driver
from a boolean 'static' create option to the standard 'preallocation'
one that other drivers are using. This seems like a good move to make
while the interface isn't stable yet.

v2:
- Patch 1: Mention allowed values for 'preallocation' [Eric]
- Patch 3: Fixed comments, removed 2^63-512 case [Eric]
- Patch 6: Added missing reference output change [Eric]
- Patch 7: s/UINT64_MAX/INT64_MAX/ [Eric]
- Patches 8 and 12: Fixed comments [Eric]

Kevin Wolf (12):
  vdi: Change 'static' create option to 'preallocation' in QMP
  vdi: Fix build with CONFIG_VDI_DEBUG
  qemu-iotests: Test vdi image creation with QMP
  qemu-iotests: Enable 025 for luks
  luks: Turn another invalid assertion into check
  qemu-iotests: Test invalid resize on luks
  parallels: Check maximum cluster size on create
  qemu-iotests: Test parallels image creation with QMP
  vhdx: Require power-of-two block size on create
  vhdx: Don't use error_setg_errno() with constant errno
  vhdx: Check for 4 GB maximum log size on creation
  qemu-iotests: Test vhdx image creation with QMP

 qapi/block-core.json       |   7 +-
 block/crypto.c             |   6 +-
 block/parallels.c          |   5 +
 block/vdi.c                |  46 ++++--
 block/vhdx.c               |  17 ++-
 tests/qemu-iotests/025     |   9 +-
 tests/qemu-iotests/210     |  37 +++++
 tests/qemu-iotests/210.out |  16 +++
 tests/qemu-iotests/211     | 246 ++++++++++++++++++++++++++++++++
 tests/qemu-iotests/211.out |  97 +++++++++++++
 tests/qemu-iotests/212     | 326 +++++++++++++++++++++++++++++++++++++++=
+++
 tests/qemu-iotests/212.out | 111 ++++++++++++++
 tests/qemu-iotests/213     | 349 +++++++++++++++++++++++++++++++++++++++=
++++++
 tests/qemu-iotests/213.out | 121 ++++++++++++++++
 tests/qemu-iotests/group   |   3 +
 15 files changed, 1371 insertions(+), 25 deletions(-)
 create mode 100755 tests/qemu-iotests/211
 create mode 100644 tests/qemu-iotests/211.out
 create mode 100755 tests/qemu-iotests/212
 create mode 100644 tests/qemu-iotests/212.out
 create mode 100755 tests/qemu-iotests/213
 create mode 100644 tests/qemu-iotests/213.out

--=20
2.13.6
