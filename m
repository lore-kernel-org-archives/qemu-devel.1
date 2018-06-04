Received: from eggs.gnu.org ([2001:4830:134:3::10]:36560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fPnXe-0007nj-HQ
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 07:20:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fPnXd-0001Pd-Lj
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 07:20:50 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon,  4 Jun 2018 12:20:25 +0100
Message-Id: <20180604112036.2715-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 00/11] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

The following changes since commit c25e8bba1f546ea72744ccfab77f8a9e8a323be8:

  Merge remote-tracking branch 'remotes/otubo/tags/pull-seccomp-20180601' into staging (2018-06-01 13:11:30 +0100)

are available in the Git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 21891a5a3011608845b5d7f1f9cce60cdc2bcc62:

  main-loop: drop spin_counter (2018-06-01 16:01:29 +0100)

----------------------------------------------------------------
Pull request

 * Copy offloading for qemu-img convert (iSCSI, raw, and qcow2)

   If the underlying storage supports copy offloading, qemu-img convert will
   use it instead of performing reads and writes.  This avoids data transfers
   and thus frees up storage bandwidth for other purposes.  SCSI EXTENDED COPY
   and Linux copy_file_range(2) are used to implement this optimization.

 * Drop spurious "WARNING: I\/O thread spun for 1000 iterations" warning

----------------------------------------------------------------

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

Stefan Hajnoczi (1):
  main-loop: drop spin_counter

 configure                        |  17 ++
 include/block/block.h            |  32 ++++
 include/block/block_int.h        |  38 ++++
 include/block/raw-aio.h          |  10 +-
 include/scsi/constants.h         |   4 +
 include/sysemu/block-backend.h   |   4 +
 block/block-backend.c            |  18 ++
 block/file-posix.c               |  98 +++++++++-
 block/io.c                       |  97 ++++++++++
 block/iscsi.c                    | 314 +++++++++++++++++++++++++++----
 block/qcow2.c                    | 229 +++++++++++++++++++---
 block/raw-format.c               |  96 +++++++---
 qemu-img.c                       |  50 ++++-
 util/main-loop.c                 |  25 ---
 tests/qemu-iotests/common.filter |   1 -
 15 files changed, 908 insertions(+), 125 deletions(-)

-- 
2.17.1
