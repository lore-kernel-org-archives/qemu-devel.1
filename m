Received: from eggs.gnu.org ([2001:4830:134:3::10]:56647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fGQYF-0006pt-MI
	for qemu-devel@nongnu.org; Wed, 09 May 2018 10:58:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fGQYE-0006Bk-AR
	for qemu-devel@nongnu.org; Wed, 09 May 2018 10:58:43 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed,  9 May 2018 22:58:06 +0800
Message-Id: <20180509145815.3330-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/9] qemu-img convert with copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

v3: Drop RFC.
    Update iotests reference output.
    Address Stefan's comments to v2:
    - Added a TODO for qcow2 copy with refcnt within the same image.
    - Include sys/syscall.h only on Linux.
    - Provide a dummy implementation returning -ENOSYS to reduce #ifdefs.
    - Use aio_ prefix for RawPosixAIOData fields.
    - Iscsi: split patches for code refactoring and device designator query.
    - Iscsi: improve parameter verification, types. don't use meaningless
      offset calculation.
    - Iscsi: set next pointer to NULL.
    - Iscsi: don't free uninitialized pointers.
    - Block backend: check request byte range.
    - Add reviewed-by lines.

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

Fam Zheng (9):
  block: Introduce API for copy offloading
  raw: Implement copy offloading
  qcow2: Implement copy offloading
  file-posix: Implement bdrv_co_copy_range
  iscsi: Query and save device designator when opening
  iscsi: Create and use iscsi_co_wait_for_task
  iscsi: Implement copy offloading
  block-backend: Add blk_co_copy_range
  qemu-img: Convert with copy offloading

 block/block-backend.c            |  18 +++
 block/file-posix.c               |  94 +++++++++++-
 block/io.c                       |  91 +++++++++++
 block/iscsi.c                    | 323 ++++++++++++++++++++++++++++++++++-----
 block/qcow2.c                    | 228 +++++++++++++++++++++++----
 block/raw-format.c               |  20 +++
 include/block/block.h            |   4 +
 include/block/block_int.h        |  30 ++++
 include/block/raw-aio.h          |  10 +-
 include/scsi/constants.h         |   5 +
 include/sysemu/block-backend.h   |   4 +
 qemu-img.c                       |  50 +++++-
 tests/qemu-iotests/178.out.qcow2 |   8 +-
 13 files changed, 807 insertions(+), 78 deletions(-)

-- 
2.14.3
