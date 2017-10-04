Received: from eggs.gnu.org ([2001:4830:134:3::10]:58503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dzYjD-0000ei-Ia
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 21:44:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dzYjC-0001IU-K9
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 21:44:03 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue,  3 Oct 2017 20:43:42 -0500
Message-Id: <20171004014347.25099-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/5] block: Avoid copy-on-read assertions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, jcody@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org

During my quest to switch block status to be byte-based, John
forced me to evaluate whether we have a situation during
copy-on-read where we could exceed BDRV_REQUEST_MAX_BYTES [1].
Sure enough, we have a number of pre-existing bugs in the
copy-on-read code.  Fix those, along with adding a test.

Available as a tag at:
git fetch git://repo.or.cz/qemu/ericb.git nbd-byte-status-v4

Since v1 (available at [2]):
- tweak patch 3 (now 4) to avoid uninit variable [Kevin, patchew]
- tweak patch 4 (now 5) to add 0-length test [Kevin]
- tweak patch 4 (now 5) to skip if TEST_DIR contains spaces [Jeff]
- new patch 2 to make testing 0-length read easier

[1] https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg07286.html
[2] https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg08200.html

001/5:[----] [--] 'qemu-io: Add -C for opening with copy-on-read'
002/5:[down] 'block: Uniform handling of 0-length bdrv_get_block_status()'
003/5:[----] [--] 'block: Add blkdebug hook for copy-on-read'
004/5:[0001] [FC] 'block: Perform copy-on-read in loop'
005/5:[0025] [FC] 'iotests: Add test 197 for covering copy-on-read'

Eric Blake (5):
  qemu-io: Add -C for opening with copy-on-read
  block: Uniform handling of 0-length bdrv_get_block_status()
  block: Add blkdebug hook for copy-on-read
  block: Perform copy-on-read in loop
  iotests: Add test 197 for covering copy-on-read

 qapi/block-core.json             |   5 +-
 block/io.c                       | 123 ++++++++++++++++++++++++++-------------
 qemu-io.c                        |  15 ++++-
 tests/qemu-iotests/common.filter |   1 +
 tests/qemu-iotests/197           | 102 ++++++++++++++++++++++++++++++++
 tests/qemu-iotests/197.out       |  26 +++++++++
 tests/qemu-iotests/group         |   1 +
 7 files changed, 230 insertions(+), 43 deletions(-)
 create mode 100755 tests/qemu-iotests/197
 create mode 100644 tests/qemu-iotests/197.out

-- 
2.13.6
