Received: from eggs.gnu.org ([2001:4830:134:3::10]:55496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fOgKw-00060L-KL
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 05:27:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fOgKv-0007Mo-F1
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 05:27:06 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  1 Jun 2018 17:26:38 +0800
Message-Id: <20180601092648.24614-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v9 00/10] qemu-img convert with copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, eblake@redhat.com

v9: Don't break older libiscsi. [patchew]

v8: Fix compiling against new glibc and libiscsi on Fedora 28 where v7 had
    conflict definitions. [Stefan, myself]
    - Add HAVE_COPY_FILE_RANGE in configure.
    - Drop IDENT_DESCR_TGT_DESCR from scsi constants header.

v7: Fix qcow2.

v6: Pick up rev-by from Stefan and Eric.
    Tweak patch 2 commit message.

v5: - Fix raw offset/bytes check for read. [Eric]
    - Fix qcow2_handle_l2meta. [Stefan]
    - Add coroutine_fn whereever appropriate. [Stefan]

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

 block/block-backend.c          |  18 ++
 block/file-posix.c             |  98 +++++++++-
 block/io.c                     |  97 ++++++++++
 block/iscsi.c                  | 314 +++++++++++++++++++++++++++++----
 block/qcow2.c                  | 229 ++++++++++++++++++++----
 block/raw-format.c             |  96 +++++++---
 configure                      |  17 ++
 include/block/block.h          |  32 ++++
 include/block/block_int.h      |  38 ++++
 include/block/raw-aio.h        |  10 +-
 include/scsi/constants.h       |   4 +
 include/sysemu/block-backend.h |   4 +
 qemu-img.c                     |  50 +++++-
 13 files changed, 908 insertions(+), 99 deletions(-)

-- 
2.17.0
