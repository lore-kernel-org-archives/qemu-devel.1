Received: from eggs.gnu.org ([2001:4830:134:3::10]:57791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gHyTz-0004fe-74
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 17:57:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gHyTu-0008Hk-0f
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 17:56:56 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 31 Oct 2018 22:56:10 +0100
Message-Id: <20181031215622.27690-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/12] file-posix: Simplify delegation to
 worker thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

This series cleans up and simplifies the code that calls worker thread
functions for the various operations in the file-posix driver. This
results in less indirection and better readability as well as reduced
heap allocations because we can store ACBs on the coroutine stack now.

Kevin Wolf (12):
  file-posix: Reorganise RawPosixAIOData
  file-posix: Factor out raw_thread_pool_submit()
  file-posix: Avoid aio_worker() for QEMU_AIO_TRUNCATE
  file-posix: Avoid aio_worker() for QEMU_AIO_COPY_RANGE
  file-posix: Avoid aio_worker() for QEMU_AIO_WRITE_ZEROES
  file-posix: Avoid aio_worker() for QEMU_AIO_DISCARD
  file-posix: Avoid aio_worker() for QEMU_AIO_FLUSH
  file-posix: Move read/write operation logic out of aio_worker()
  file-posix: Avoid aio_worker() for QEMU_AIO_READ/WRITE
  file-posix: Remove paio_submit_co()
  file-posix: Switch to .bdrv_co_ioctl
  file-posix: Avoid aio_worker() for QEMU_AIO_IOCTL

 include/scsi/pr-manager.h |   8 +-
 block/file-posix.c        | 380 ++++++++++++++++++++------------------
 scsi/pr-manager.c         |  21 +--
 scsi/trace-events         |   2 +-
 4 files changed, 210 insertions(+), 201 deletions(-)

--=20
2.19.1
