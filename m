Received: from eggs.gnu.org ([2001:4830:134:3::10]:48003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d0rLE-0003Q4-2R
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 11:16:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d0rLD-0000qQ-0b
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 11:16:24 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 19 Apr 2017 17:15:59 +0200
Message-Id: <1492614962-20946-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/3] migration: Call
 blk_resume_after_migration() for postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, mreitz@redhat.com, quintela@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org, lvivier@redhat.com

This fixes one of the bugs that made us disable the op blocker
assertions for the 2.9 release.

v2:
- Filter HMP output not only for common.qemu users, but for all test
  cases that had an escape character in their reference output. This
  required matching also lines that don't begin with the (qemu) prompt
  because other messages (from stderr) are interleaved. [Eric]
- Use bash $'\e' instead of sed \o for better portability [Eric]
- Added driver=$IMGFMT to test 181 [Eric]

Kevin Wolf (3):
  migration: Call blk_resume_after_migration() for postcopy
  qemu-iotests: Filter HMP readline escape characters
  qemu-iotests: Test postcopy migration

 migration/savevm.c               |   8 +++
 tests/qemu-iotests/028.out       |   2 +-
 tests/qemu-iotests/051           |   3 +-
 tests/qemu-iotests/051.out       | 106 +++++++++++++++----------------
 tests/qemu-iotests/051.pc.out    | 132 +++++++++++++++++++--------------------
 tests/qemu-iotests/068           |   4 +-
 tests/qemu-iotests/068.out       |   6 +-
 tests/qemu-iotests/130.out       |   4 +-
 tests/qemu-iotests/142           |   2 +-
 tests/qemu-iotests/142.out       |  10 +--
 tests/qemu-iotests/145           |   3 +-
 tests/qemu-iotests/145.out       |   2 +-
 tests/qemu-iotests/181           | 119 +++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/181.out       |  38 +++++++++++
 tests/qemu-iotests/common.filter |   7 +++
 tests/qemu-iotests/common.qemu   |   4 +-
 tests/qemu-iotests/group         |   1 +
 17 files changed, 313 insertions(+), 138 deletions(-)
 create mode 100755 tests/qemu-iotests/181
 create mode 100644 tests/qemu-iotests/181.out

-- 
1.8.3.1
