Received: from eggs.gnu.org ([2001:4830:134:3::10]:60613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f1VR5-0001UR-Cy
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 07:09:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f1VR4-00037W-Dm
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 07:09:39 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu, 29 Mar 2018 19:09:06 +0800
Message-Id: <20180329110914.20888-1-famz@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 0/8] qemu-img convert with copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, pbonzini@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, eblake@redhat.com

[Posting a preview RFC for the general idea discussion and internal API review.
Libiscsi support is being worked on in the meantime.]

This series introduces block layer API for copy offloading and makes use of it
in qemu-img convert.

For now we implemented the operation in local file protocol with
copy_file_range(2).  Besides that it's possible to add similar to iscsi, nfs
and potentially more.

As far as its usage goes, in addition to qemu-img convert, we can emulate
offloading in scsi-disk (EXTENDED COPY), and do similar to drive-mirror.

The new bdrv_co_map_range can also be an alternative way to implement format
drivers in the future, once we make block/io.c use it in preadv/pwritev paths.

Fam Zheng (8):
  block: Introduce bdrv_co_map_range API
  qcow2: Implement bdrv_co_map_range
  block: Introduce bdrv_co_copy_range
  file-posix: Implement bdrv_co_copy_range
  file-posix: Implement bdrv_co_map_range
  raw: Implement raw_co_map_range
  block-backend: Add blk_co_copy_range
  qemu-img: Convert with copy offloading

 block/block-backend.c          |   8 ++
 block/file-posix.c             |  92 +++++++++++++++++++-
 block/io.c                     | 192 +++++++++++++++++++++++++++++++++++++++++
 block/qcow2.c                  | 103 +++++++++++++++-------
 block/raw-format.c             |   9 ++
 include/block/block.h          |  12 ++-
 include/block/block_int.h      |  35 ++++++++
 include/block/raw-aio.h        |  10 ++-
 include/sysemu/block-backend.h |   4 +
 qemu-img.c                     |  45 +++++++++-
 10 files changed, 472 insertions(+), 38 deletions(-)

-- 
2.14.3
