Received: from eggs.gnu.org ([2001:4830:134:3::10]:57007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fB3Z3-0007sZ-St
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 15:25:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fB3Z2-0003L5-UJ
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 15:25:21 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 24 Apr 2018 14:25:00 -0500
Message-Id: <20180424192506.149089-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/6] block: byte-based AIO read/write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, kwolf@redhat.com, qemu-block@nongnu.org

While we would prefer that block drivers use coroutines instead
of aio callbacks, it is a fairly easy exercise to prove that
all existing drivers with aio callbacks are merely scaling
from bytes into sectors and back to bytes.  So, even though I
am not set up to completely run (or even compile-test) this
full series, it seems pretty straightforward to change the
signature to quit playing games with pointless scaling.

Incorporate Kevin's review on v1, which amounted to pretty much
rewriting the series to be saner (the block layer now defaults
to alignment of 1, so drivers that still need 512 for keeping the
patch conservative have to override that; and improve the code
in io.c to put byte-based access before sector-based fallbacks).

001/6:[0023] [FC] 'block: Support byte-based aio callbacks'
002/6:[0011] [FC] 'file-win32: Switch to byte-based callbacks'
003/6:[0007] [FC] 'null: Switch to byte-based read/write'
004/6:[0008] [FC] 'rbd: Switch to byte-based callbacks'
005/6:[0007] [FC] 'vxhs: Switch to byte-based callbacks'
006/6:[0093] [FC] 'block: Drop last of the sector-based aio callbacks'

Eric Blake (6):
  block: Support byte-based aio callbacks
  file-win32: Switch to byte-based callbacks
  null: Switch to byte-based read/write
  rbd: Switch to byte-based callbacks
  vxhs: Switch to byte-based callbacks
  block: Drop last of the sector-based aio callbacks

 include/block/block_int.h |  8 +++---
 include/block/raw-aio.h   |  2 +-
 block/io.c                | 64 ++++++++++++++++++++++++++---------------------
 block/file-win32.c        | 47 +++++++++++++++++++++-------------
 block/null.c              | 59 ++++++++++++++++++++++---------------------
 block/rbd.c               | 44 +++++++++++++++++---------------
 block/vxhs.c              | 43 +++++++++++++++----------------
 block/win32-aio.c         |  5 ++--
 8 files changed, 148 insertions(+), 124 deletions(-)

-- 
2.14.3
