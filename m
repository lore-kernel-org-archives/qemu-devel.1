Received: from eggs.gnu.org ([2001:4830:134:3::10]:43105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cYb0i-0006Qk-E8
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:10:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cYb0e-0006l3-Fu
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:10:24 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Tue, 31 Jan 2017 18:09:53 +0200
Message-Id: <cover.1485878688.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 0/2] qemu-io: check the size of the I/O requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>

Hi,

qemu-io allows arbitrary values (up to SIZE_MAX) for the size of its
I/O requests, but QEMU cannot handle anything larger than INT_MAX.

   $ qemu-io -c 'aio_write 0 2G' hd.qcow2
   block/block-backend.c:1035: blk_aio_write_entry:
   Assertion `!rwco->qiov || rwco->qiov->size == acb->bytes' failed.

   $ qemu-io -c 'aio_read 0 1G 1G' hd.qcow2
   block/block-backend.c:1024:
   blk_aio_read_entry: Assertion `rwco->qiov->size == acb->bytes' failed.

This series checks that those values are within range and also adds
assertions to qemu_iovec_add() and qemu_iovec_init_external() to
detect these cases earlier.

Regards,

Berto

Alberto Garcia (2):
  qemu-io: don't allow I/O operations larger than INT_MAX
  iov: assert that qiov->size doesn't exceed INT_MAX

 qemu-io-cmds.c | 21 ++++++++++++---------
 util/iov.c     |  7 ++++++-
 2 files changed, 18 insertions(+), 10 deletions(-)

-- 
2.11.0
