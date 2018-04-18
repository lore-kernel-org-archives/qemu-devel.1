Received: from eggs.gnu.org ([2001:4830:134:3::10]:45026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f8dOt-0002BN-PA
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 23:04:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f8dOs-0002NF-Qw
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 23:04:51 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 18 Apr 2018 11:04:17 +0800
Message-Id: <20180418030424.28980-1-famz@redhat.com>
Subject: [Qemu-devel] [RFC PATCH v2 0/7] qemu-img convert with copy
 offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

v2: - Add iscsi EXTENDED COPY.
    - Design change: bdrv_co_copy_range_{from,to}. [Stefan]
    - Retry upon EINTR. [Stefan]
    - Drop the bounce buffer fallback. It is inefficient to attempt the
      offloaded copy over and over again if the error is returned from the host
      rather than checking our internal state. E.g.  trying copy_file_range
      between two filesystems results in EXDEV, in which case qemu-img.c should
      switch back to the copy path for the remaining sectors.

This series introduces block layer API for copy offloading and makes use of it
in qemu-img convert.

For now we implemented the operation in local file protocol with
copy_file_range(2).  Besides that it's possible to add similar to iscsi, nfs
and potentially more.

As far as its usage goes, in addition to qemu-img convert, we can emulate
offloading in scsi-disk (handle EXTENDED COPY command), and use the API in
block jobs too.

Fam Zheng (7):
  block: Introduce API for copy offloading
  raw: Implement copy offloading
  qcow2: Implement copy offloading
  file-posix: Implement bdrv_co_copy_range
  iscsi: Implement copy offloading
  block-backend: Add blk_co_copy_range
  qemu-img: Convert with copy offloading

 block/block-backend.c          |   9 ++
 block/file-posix.c             |  99 ++++++++++++++-
 block/io.c                     |  91 ++++++++++++++
 block/iscsi.c                  | 266 +++++++++++++++++++++++++++++++++++++++++
 block/qcow2.c                  | 224 +++++++++++++++++++++++++++++-----
 block/raw-format.c             |  20 ++++
 include/block/block.h          |   4 +
 include/block/block_int.h      |  30 +++++
 include/block/raw-aio.h        |  10 +-
 include/scsi/constants.h       |   3 +
 include/sysemu/block-backend.h |   4 +
 qemu-img.c                     |  50 +++++++-
 12 files changed, 773 insertions(+), 37 deletions(-)

-- 
2.14.3
