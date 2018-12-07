Received: from eggs.gnu.org ([2001:4830:134:3::10]:51758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gVEhg-0006xS-R3
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 06:53:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gVEhg-0004a8-2Y
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 06:53:56 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Dec 2018 12:53:38 +0100
Message-Id: <20181207115343.6747-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 0/5] vmdk: Implement blockdev-create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

I picked up the patch series from Fam and rebased it to current master
(which involved a major rework on the test case) and tried to address
Markus' review comments for v2. I did not do any further review of the
actual code, but it passes the tests, so I guess having it in tree is
better than continuing to let it bitrot.

v4:
- Use "legacyESX" in QAPI instead of "legacyesx" (requires an additional
  exception from the QAPI rules, but the string is directly written into
  the VMDK file, and "legacyESX" is the spelling in the spec). The
  QemuOpts based parser stays case sensitive in v4. [Markus]
- Documentation fixes [Markus]
- Added tests for adapter types
- Added patch 5 to forbid excess extents in blockdev-create [Markus]

Fam Zheng (3):
  vmdk: Refactor vmdk_create_extent
  vmdk: Implement .bdrv_co_create callback
  iotests: Filter cid numbers in VMDK extent info

Kevin Wolf (2):
  iotests: Add VMDK tests for blockdev-create
  vmdk: Reject excess extents in blockdev-create

 qapi/block-core.json             |  71 +++++
 qapi/qapi-schema.json            |  16 +-
 block/vmdk.c                     | 532 ++++++++++++++++++++++---------
 tests/qemu-iotests/237           | 237 ++++++++++++++
 tests/qemu-iotests/237.out       | 348 ++++++++++++++++++++
 tests/qemu-iotests/common.filter |   1 +
 tests/qemu-iotests/group         |   1 +
 tests/qemu-iotests/iotests.py    |   1 +
 8 files changed, 1049 insertions(+), 158 deletions(-)
 create mode 100755 tests/qemu-iotests/237
 create mode 100644 tests/qemu-iotests/237.out

--=20
2.19.2
