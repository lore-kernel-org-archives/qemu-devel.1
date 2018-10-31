Received: from eggs.gnu.org ([2001:4830:134:3::10]:53952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gHter-0006j2-7e
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:47:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gHtem-0004dU-Vn
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:47:53 -0400
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Wed, 31 Oct 2018 19:47:18 +0300
Message-Id: <1541004440-182262-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 0/2] Discrad blocks during block-stream
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

Andrey Shinkevich (2):
  The discard flag for block stream operation
  Discard blocks while copy-on-read

 block/stream.c            | 402 ++++++++++++++++++++++++++++++++++++++++++++--
 blockdev.c                |   8 +-
 hmp-commands.hx           |   4 +-
 hmp.c                     |   4 +-
 include/block/block_int.h |   2 +-
 qapi/block-core.json      |   5 +-
 6 files changed, 407 insertions(+), 18 deletions(-)

-- 
1.8.3.1
