Received: from eggs.gnu.org ([2001:4830:134:3::10]:33346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eHgwZ-0004Vl-RN
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 21:08:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eHgwY-00018d-LL
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 21:08:47 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Thu, 23 Nov 2017 03:08:15 +0100
Message-Id: <20171123020832.8165-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 00/17] iotests: Fix iotests for weird
 formats/options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Fam Zheng <famz@redhat.com>

This series fixes the qemu-iotests for qcow, vmdk, qcow2 v2 and qcow2 v3
with refcount_bits=1.

Patches 1 and 2 contain real fixes (not urgent, though, so no need to
hurry for 2.11--we can take them into 2.11 if we want to, but there is
no absolute need for them).

Patches 3 and 4 add blkdebug events to qcow and vmdk so iotests 020 can
work with them even after patch 10.

Patches 5 and 6 are general "fixes" for the iotests infrastructure.

Patches 7, 8, and 9 add some missing skips under certain circumstances
to tests that need them.

The rest of this series (patches 10 through 17) actually fix tests so
they work for the formats and options mentioned above.

(Fun fact: qcow v1 wasn't broken before this series.  But it would be
 broken by patch 10 if I didn't include patch 3.  That is why I
 mentioned it above.)


Personal note:  I should really stop writing bash tests, at least as
soon as there is QMP involved.  While working on this series I got
sidetracked a bit and actually wrote some iotests.py functions that may
come in handy next time I write a test.

(I hate to write Python tests because the boilerplate seems so large and
 the debugging is so hard.  But there is test 194 which shows that it is
 possible to write simple bash-like tests as well--and that is how I
 should probably write tests from now on.)


Max Reitz (17):
  block/vmdk: Fix , instead of ; at end of line
  qcow2: No persistent dirty bitmaps for compat=0.10
  block/qcow: Add blkdebug events
  block/vmdk: Add blkdebug events
  iotests: Fix _img_info for backslashes
  iotests: Drop format-specific in _filter_img_info
  iotests: Forbid 020 for non-file protocols
  iotests: Skip 103 for refcount_bits=1
  iotests: Disable some tests for compat=0.10
  iotests: Fix 020 for vmdk
  iotests: Fix 051 for compat=0.10
  iotests: Fix 059's reference output
  iotests: Fix 067 for compat=0.10
  iotests: Make 089 compatible with compat=0.10
  iotests: Make 184 image-less
  iotests: Make 191 work with qcow2 options
  iotests: Filter compat-dependent info in 198

 block/qcow.c                     |  16 ++
 block/qcow2-bitmap.c             |  10 ++
 block/qcow2.c                    |  14 +-
 block/vmdk.c                     |  18 ++-
 tests/qemu-iotests/020           |  17 +--
 tests/qemu-iotests/020.out       |   6 +-
 tests/qemu-iotests/051           |   2 +
 tests/qemu-iotests/051.out       |   1 +
 tests/qemu-iotests/051.pc.out    |   1 +
 tests/qemu-iotests/059.out       |   2 +-
 tests/qemu-iotests/067           |   3 +-
 tests/qemu-iotests/067.out       |  97 ++++--------
 tests/qemu-iotests/080           |   5 +-
 tests/qemu-iotests/089           |   4 +-
 tests/qemu-iotests/089.out       |  10 --
 tests/qemu-iotests/103           |   2 +
 tests/qemu-iotests/130           |   2 +
 tests/qemu-iotests/137           |   2 +
 tests/qemu-iotests/176           |   2 +
 tests/qemu-iotests/177           |  13 +-
 tests/qemu-iotests/184           |  25 +---
 tests/qemu-iotests/184.out       |  63 ++------
 tests/qemu-iotests/191           |   5 +-
 tests/qemu-iotests/191.out       | 313 +++++++++++----------------------------
 tests/qemu-iotests/198           |   8 +-
 tests/qemu-iotests/198.out       |   8 -
 tests/qemu-iotests/common.filter |  29 +++-
 tests/qemu-iotests/common.rc     |   2 +-
 28 files changed, 254 insertions(+), 426 deletions(-)

-- 
2.13.6
