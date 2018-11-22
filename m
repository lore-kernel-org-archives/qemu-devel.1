Received: from eggs.gnu.org ([2001:4830:134:3::10]:59664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gPu1S-0003OA-LX
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 13:48:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gPu1P-00074Y-Um
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 13:48:18 -0500
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Thu, 22 Nov 2018 21:48:02 +0300
Message-Id: <1542912487-279165-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 0/5] Discrad blocks during block-stream
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

Hello everyone!

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
existing child permission mechanism. There is a commented up hack in the
callback function bdrv_stream_top_pwritev() in block/stream.c that redirects
write operations below the filter node. Being uncommented, it enables writing
into the inactive layer and passing all the iotests in the 030 file. Otherwise,
no WRITE permission is granted after the filter insertion above the target node.
Any suggestions to resolve that issue will be appreciated.

The suggestions of Dr. David Alan Gilbert and Alberto Garcia after their first
review have been applied.

Sincerely,

Andrey Shinkevich (5):
  Discard blocks while copy-on-read
  The discard flag for block stream operation
  iotests: allow resume_drive by node name
  iotests: prepare 030 for graph change
  iotests: 030 with block-stream discard

 block/stream.c                | 429 ++++++++++++++++++++++++++++++++++++++++--
 blockdev.c                    |   8 +-
 hmp-commands.hx               |   4 +-
 hmp.c                         |   4 +-
 include/block/block_int.h     |   2 +-
 qapi/block-core.json          |   5 +-
 tests/qemu-iotests/030        | 163 +++++++++++-----
 tests/qemu-iotests/030.out    |   4 +-
 tests/qemu-iotests/iotests.py |   9 +-
 9 files changed, 558 insertions(+), 70 deletions(-)

-- 
1.8.3.1
