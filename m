Received: from eggs.gnu.org ([208.118.235.92]:43335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gdhOq-0001g3-Kr
	for qemu-devel@nongnu.org; Sun, 30 Dec 2018 15:09:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gdhOp-0008Fz-3g
	for qemu-devel@nongnu.org; Sun, 30 Dec 2018 15:09:28 -0500
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Sun, 30 Dec 2018 23:09:11 +0300
Message-Id: <1546200557-774583-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v5 0/6] Discrad blocks during block-stream
 operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, dgilbert@redhat.com, eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, andrey.shinkevich@virtuozzo.com

Dear collegues,

The given feature discards blocks with copy-on-read operation while the
streaming process runs. Adding the 'discard' argument to the QMP block-stream
command allows dropping a block in the backing chain after it has been copied
to the active layer. That will elude the block duplication in the intermediate
backing file. It saves the disk space while external snapshots are being
merged.
The method involves the filter insertion above the active layer to allow write
operation in the backing chain. The method is similar to that in the 'commit
active' command (mirror.c).
The permission to write into an inactive layer can not be obtained due to the
existing child permission mechanism. 

v5:
The existing copy-on-read filter driver was applied to the block-stream
operation in the separated patch. The code refactoring in 'stream.c' is big.
Unfortunately, there are issues with getting "write" lock in iotests -
subject to further resolution.

v4:
"[PATCH v4 0/5] Discrad blocks during block-stream operation"
The targeted version of the release at 'Since' word of the comment to 'discard'
argument changed to 4.0 in the file qapi/block-core.json as Eric Blake noticed.

v3:
"[PATCH v3 0/5] Discrad blocks during block-stream operation"
The series version number and the given changelog were added. 'Signed-off-by'
subscription of the patch [PATCH 3/5] amended as Peter Krempa requested.

v2:
"[PATCH 0/5] Discrad blocks during block-stream operation"
The suggestions of Dr. David Alan Gilbert and Alberto Garcia after their first
review have been applied.
The abort() callback function have been added to the filter driver and some
refactoring work done.
The test suite for the 'block-stream' command with 'discard' option was added
to the 030 file of iotests.

v1:
"[PATCH 0/2] Discrad blocks during block-stream operation"
The initial implementation of the feature.

Sincerely,

Andrey Shinkevich (6):
  Stream block job involves copy-on-read filter driver
  Discard blocks while copy-on-read
  The discard flag for block stream operation
  iotests: allow resume_drive by node name
  iotests: prepare 030 for graph change
  iotests: 030 with block-stream discard

 block/copy-on-read.c          |  24 ++++
 block/stream.c                | 290 ++++++++++++++++++++++++++++++++++++++++--
 blockdev.c                    |   8 +-
 hmp-commands.hx               |   4 +-
 hmp.c                         |   4 +-
 include/block/block_int.h     |   2 +-
 qapi/block-core.json          |   5 +-
 tests/qemu-iotests/030        | 163 ++++++++++++++++++------
 tests/qemu-iotests/030.out    |   4 +-
 tests/qemu-iotests/iotests.py |   9 +-
 10 files changed, 448 insertions(+), 65 deletions(-)

-- 
1.8.3.1
