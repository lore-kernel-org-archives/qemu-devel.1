Received: from eggs.gnu.org ([2001:4830:134:3::10]:44932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gZo6K-00048r-WC
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 21:30:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gZo6A-0007O8-V7
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 21:30:12 -0500
From: John Snow <jsnow@redhat.com>
Date: Wed, 19 Dec 2018 21:29:41 -0500
Message-Id: <20181220022952.20493-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v5 00/11] bitmaps: remove x- prefix from QMP api
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, vsementsov@virtuozzo.com, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <fam@euphon.net>, Markus Armbruster <armbru@redhat.com>

Fix some outstanding bugs, change the design of an API element,
remove the x- prefix to signify stability, and add iotests.

V5:
001/11:[----] [--] 'blockdev: abort transactions in reverse order'
002/11:[down] 'block/dirty-bitmap: remove assertion from restore'
003/11:[0029] [FC] 'blockdev: n-ary bitmap merge'
004/11:[----] [-C] 'block: remove 'x' prefix from experimental bitmap APIs'
005/11:[----] [--] 'iotests.py: don't abort if IMGKEYSECRET is undefined'
006/11:[----] [--] 'iotests: add filter_generated_node_ids'
007/11:[0019] [FC] 'iotests: add qmp recursive sorting function'
008/11:[----] [-C] 'iotests: remove default filters from qmp_log'
009/11:[----] [-C] 'iotests: change qmp_log filters to expect QMP objects only'
010/11:[0005] [FC] 'iotests: implement pretty-print for log and qmp_log'
011/11:[0324] [FC] 'iotests: add iotest 236 for testing bitmap merge'

002: New bugfix.
003: I forgot to actually capture state->bitmap anywhere,
     which is needed for restoration...
007: Better commit message
     - use .items() instead of .keys() to save a lookup [Vladimir]
     - use a sequence of tuples to preserve ordering in
       the OrderedDict constructor [Vladimir]
     - Move the sort_keys boolean up from patch 010
008: Better commit message
009: Better commit message
010: Moved the sort_keys function up to patch 007
011: Expanded this test considerably:
     - query_bitmaps can now show empty results,
       and prefixes results with "bitmaps:" in the log
     - logging declarations are one line [Vladimir]
     - Added a bad version of the bitmap handoff transaction [Eric]
     - Added a bad version of the bitmap merge transaction,
       which revealed a problem that patch 02 now addresses [Eric]
     - Added bitmap removal / cleanup [Eric]
     - Added newline at end of file. [Eric]

V4:
 - Removed patches 1-5 which have been staged
 - Rewrite qmp_log entirely, split into three patches
 - Pretty-printing has been extended to log() as well as qmp_log()
 - Adjust iotest 236 to be format generic instead of qcow2 [Vladimir]
 - Adjust iotest 236 to not reduplicate serialization work [Vladimir]
 - Many other small touchups

V3:
 - Reworked qmp_log to pretty-print the outgoing command, too [Vladimir]
 - Modified test to log only bitmap information [Vladimir]
 - Test disable/enable transaction toggle [Eric]

John Snow (11):
  blockdev: abort transactions in reverse order
  block/dirty-bitmap: remove assertion from restore
  blockdev: n-ary bitmap merge
  block: remove 'x' prefix from experimental bitmap APIs
  iotests.py: don't abort if IMGKEYSECRET is undefined
  iotests: add filter_generated_node_ids
  iotests: add qmp recursive sorting function
  iotests: remove default filters from qmp_log
  iotests: change qmp_log filters to expect QMP objects only
  iotests: implement pretty-print for log and qmp_log
  iotests: add iotest 236 for testing bitmap merge

 block/dirty-bitmap.c          |   1 -
 blockdev.c                    | 107 +++++++----
 qapi/block-core.json          |  56 +++---
 qapi/transaction.json         |  12 +-
 tests/qemu-iotests/206        |   8 +-
 tests/qemu-iotests/223        |   4 +-
 tests/qemu-iotests/236        | 161 ++++++++++++++++
 tests/qemu-iotests/236.out    | 351 ++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group      |   1 +
 tests/qemu-iotests/iotests.py |  60 +++++-
 10 files changed, 673 insertions(+), 88 deletions(-)
 create mode 100755 tests/qemu-iotests/236
 create mode 100644 tests/qemu-iotests/236.out

-- 
2.17.2
