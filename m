Received: from eggs.gnu.org ([2001:4830:134:3::10]:55736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dyNpl-00075c-1a
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 15:53:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dyNpk-00073L-50
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 15:53:57 -0400
From: Eric Blake <eblake@redhat.com>
Date: Sat, 30 Sep 2017 14:53:41 -0500
Message-Id: <20170930195345.23338-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] block: Avoid copy-on-read assertions
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, kwolf@redhat.com, qemu-block@nongnu.org
List-ID: <qemu-devel.nongnu.org>

During my quest to switch block status to be byte-based, John
forced me to evaluate whether we have a situation during
copy-on-read where we could exceed BDRV_REQUEST_MAX_BYTES [1].
Sure enough, we have a number of pre-existing bugs in the
copy-on-read code.  Fix those (patch 3), along with adding a
test (patch 4, but needs a couple of additions in patch 1 and
2 to make the test even possible).  Swapping patch 3 and 4
demonstrates that the test indeed exposes flaws.

[1] https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg07286.html

Eric Blake (4):
  qemu-io: Add -C for opening with copy-on-read
  block: Add blkdebug hook for copy-on-read
  block: Perform copy-on-read in loop
  iotests: Add test 197 for covering copy-on-read

 qapi/block-core.json             |   5 +-
 block/io.c                       | 118 +++++++++++++++++++++++++++------------
 qemu-io.c                        |  15 ++++-
 tests/qemu-iotests/common.filter |   1 +
 tests/qemu-iotests/197           |  93 ++++++++++++++++++++++++++++++
 tests/qemu-iotests/197.out       |  24 ++++++++
 tests/qemu-iotests/group         |   1 +
 7 files changed, 216 insertions(+), 41 deletions(-)
 create mode 100755 tests/qemu-iotests/197
 create mode 100644 tests/qemu-iotests/197.out

-- 
2.13.6
