Received: from eggs.gnu.org ([2001:4830:134:3::10]:52651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e0BQL-0007gr-BN
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 15:03:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e0BQK-0002CV-DI
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 15:03:09 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu,  5 Oct 2017 14:02:42 -0500
Message-Id: <20171005190248.5537-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/6] block: Avoid copy-on-read assertions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, jsnow@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org

During my quest to switch block status to be byte-based, John
forced me to evaluate whether we have a situation during
copy-on-read where we could exceed BDRV_REQUEST_MAX_BYTES [1].
Sure enough, we have a number of pre-existing bugs in the
copy-on-read code.  Fix those, along with adding a test.

Available as a tag at:
git fetch git://repo.or.cz/qemu/ericb.git nbd-copy-on-read-v3

Since v2 (available at [2]):
- add a new patch to fix an iotests wart
- tweak patch 5 (now 6) to skip rather than fail on limited memory [patchew]
- tweak patch 2 condition for legibility [Stefan]
- add R-b

[1] https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg07286.html
[2] https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg00524.html

001/6:[----] [--] 'qemu-io: Add -C for opening with copy-on-read'
002/6:[0008] [FC] 'block: Uniform handling of 0-length bdrv_get_block_status()'
003/6:[down] 'iotests: Restore stty settings on completion'
004/6:[----] [--] 'block: Add blkdebug hook for copy-on-read'
005/6:[----] [--] 'block: Perform copy-on-read in loop'
006/6:[0013] [FC] 'iotests: Add test 197 for covering copy-on-read'

Eric Blake (6):
  qemu-io: Add -C for opening with copy-on-read
  block: Uniform handling of 0-length bdrv_get_block_status()
  iotests: Restore stty settings on completion
  block: Add blkdebug hook for copy-on-read
  block: Perform copy-on-read in loop
  iotests: Add test 197 for covering copy-on-read

 qapi/block-core.json             |   5 +-
 block/io.c                       | 123 +++++++++++++++++++++++++++------------
 qemu-io.c                        |  15 ++++-
 tests/qemu-iotests/common.filter |   1 +
 tests/qemu-iotests/197           | 109 ++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/197.out       |  26 +++++++++
 tests/qemu-iotests/check         |  10 ++++
 tests/qemu-iotests/group         |   1 +
 8 files changed, 249 insertions(+), 41 deletions(-)
 create mode 100755 tests/qemu-iotests/197
 create mode 100644 tests/qemu-iotests/197.out

-- 
2.13.6
