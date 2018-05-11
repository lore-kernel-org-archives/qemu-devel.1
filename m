Received: from eggs.gnu.org ([2001:4830:134:3::10]:46546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fH6qs-0002I6-MB
	for qemu-devel@nongnu.org; Fri, 11 May 2018 08:08:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fH6qr-00032J-Tp
	for qemu-devel@nongnu.org; Fri, 11 May 2018 08:08:46 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 11 May 2018 20:08:13 +0800
Message-Id: <20180511120823.7892-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 00/10] qemu-img convert with copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, eblake@redhat.com

v4: - Fix raw offset and size. [Eric]
    - iscsi: Drop unnecessary return values and variables in favor of
      constants. [Stefan]
    - qcow2: Handle small backing case. [Stefan]
    - file-posix: Translate ENOSYS to ENOTSUP. [Stefan]
    - API documentation and commit message. [Stefan]
    - Add rev-by to patches 3, 5 - 10. [Stefan, Eric]

This series introduces block layer API for copy offloading and makes use of it
in qemu-img convert.

For now we implemented the operation in local file protocol with
copy_file_range(2).  Besides that it's possible to add similar to iscsi, nfs
and potentially more.

As far as its usage goes, in addition to qemu-img convert, we can emulate
offloading in scsi-disk (handle EXTENDED COPY command), and use the API in
block jobs too.

Fam Zheng (10):
  block: Introduce API for copy offloading
  raw: Check byte range uniformly
  raw: Implement copy offloading
  qcow2: Implement copy offloading
  file-posix: Implement bdrv_co_copy_range
  iscsi: Query and save device designator when opening
  iscsi: Create and use iscsi_co_wait_for_task
  iscsi: Implement copy offloading
  block-backend: Add blk_co_copy_range
  qemu-img: Convert with copy offloading

 block/block-backend.c          |  18 +++
 block/file-posix.c             |  96 ++++++++++++-
 block/io.c                     |  96 +++++++++++++
 block/iscsi.c                  | 314 ++++++++++++++++++++++++++++++++++++-----
 block/qcow2.c                  | 232 ++++++++++++++++++++++++++----
 block/raw-format.c             |  95 +++++++++----
 include/block/block.h          |  32 +++++
 include/block/block_int.h      |  38 +++++
 include/block/raw-aio.h        |  10 +-
 include/scsi/constants.h       |   5 +
 include/sysemu/block-backend.h |   4 +
 qemu-img.c                     |  50 ++++++-
 12 files changed, 891 insertions(+), 99 deletions(-)

-- 
2.14.3
