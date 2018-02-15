Received: from eggs.gnu.org ([2001:4830:134:3::10]:50028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emPD8-0006F2-Ua
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 14:28:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emPD8-0000lv-0e
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 14:28:50 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu, 15 Feb 2018 13:28:23 -0600
Message-Id: <20180215192829.9944-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 0/6] block: byte-based AIO read/write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

While we would prefer that block drivers use coroutines instead
of aio callbacks, it is a fairly easy exercise to prove that
all existing drivers with aio callbacks are merely scaling
from bytes into sectors and back to bytes.  So, even though I
am not set up to completely run (or even compile-test) this
full series, it seems pretty straightforward to change the
signature to quit playing games with pointless scaling.

Note that except for the null-aio driver, I intentionally did
NOT try and change the request_alignment from the block layer's
default of 512 (it defaults to 1 only for drivers that use
coroutines).

(And along the way, I got my docker-test-mingw@fedora working;
thanks to the help I got on IRC)

Eric Blake (6):
  block: Support byte-based aio callbacks
  file-win32: Switch to byte-based callbacks
  null: Switch to byte-based read/write
  rbd: Switch to byte-based callbacks
  vxhs: Switch to byte-based callbacks
  block: Drop last of the sector-based aio callbacks

 include/block/block_int.h |  8 +++---
 include/block/raw-aio.h   |  2 +-
 block/io.c                | 26 ++++++++++++-------
 block/file-win32.c        | 36 +++++++++++++-------------
 block/null.c              | 66 ++++++++++++++++++++++++++---------------------
 block/rbd.c               | 36 ++++++++++++--------------
 block/vxhs.c              | 36 +++++++++++---------------
 block/win32-aio.c         |  5 ++--
 8 files changed, 109 insertions(+), 106 deletions(-)

-- 
2.14.3
