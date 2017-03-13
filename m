Received: from eggs.gnu.org ([2001:4830:134:3::10]:43444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cnXhN-0006qF-4O
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 17:40:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cnXhM-0001b4-9c
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 17:40:13 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 13 Mar 2017 22:39:45 +0100
Message-Id: <20170313214001.26339-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 00/16] block: Preallocated truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

=== Series dependencies ===

This series is based on Kevin's block-next branch rebased onto master
with v2 of my "block: Add errp to b{lk,drv}_truncate()" series applied
on top.


=== Actual cover letter ===

This series adds preallocation to bdrv_truncate() and subsequently
qemu-img resize. This is implemented for qcow2 and raw only, just like
preallocation for newly created images is.

There is no runtime interface for this new parameter (yet). This is
because preallocation takes time and would thus require an asynchronous
QMP truncate command. Since I hope there is no immediate need for this I
put implementing this off for later (if at all).

If preallocation fails, the image is supposed to be returned to its
original size. However, this is not always trivially possible: For qcow2
for instance, metadata preallocation may fail and then it is rather
difficult to restore the original size. Since it is rather unlikely that
this step fails (at least in "falloc" or "full" mode where all of the
space should already be preallocated in the underlying file which means
that ENOSPC should be impossible to occur) I opted to not restore the
image size in that case.

(I have started a patch to undo the changes done by qcow2's
 preallocate() function, but it turned out to be rather complicated for
 (in my opinion) little gain, so I decided to abandon it. If you'd like
 me to continue it and include in v2 anyway, I can certainly do so,
 though.)


Also something that may be added later: The parallels block driver can
make the underlying file grow by using either blk_truncate() or by
writing zeroes (runtime "prealloc-mode" parameter). It would not be
entirely trivial to make use of this new bdrv_truncate() parameter there
(because most protocol block drivers just do not support it and that
case would still need to be covered), but it is possible and may be nice
to have.


Max Reitz (16):
  block: Add PreallocMode to BD.bdrv_truncate()
  block: Add PreallocMode to bdrv_truncate()
  block: Add PreallocMode to blk_truncate()
  qemu-img: Expose PreallocMode for resizing
  block/file-posix: Small fixes in raw_create()
  block/file-posix: Extract raw_regular_truncate()
  block/file-posix: Generalize raw_regular_truncate
  block/file-posix: Preallocation for truncate
  block/qcow2: Generalize preallocate()
  block/qcow2: Lock s->lock in preallocate()
  block/qcow2: Metadata preallocation for truncate
  block/qcow2: Extract qcow2_calc_size_usage()
  block/qcow2: qcow2_calc_size_usage() for truncate
  block/qcow2: falloc/full preallocating growth
  iotests: Add preallocated resize test for raw
  iotests: Add preallocated growth test for qcow2

 include/block/block.h          |   3 +-
 include/block/block_int.h      |   3 +-
 include/sysemu/block-backend.h |   3 +-
 block.c                        |  12 +-
 block/blkdebug.c               |   5 +-
 block/block-backend.c          |   5 +-
 block/commit.c                 |   4 +-
 block/crypto.c                 |   4 +-
 block/file-posix.c             | 209 ++++++++++++++--------
 block/file-win32.c             |   9 +-
 block/gluster.c                |   6 +-
 block/iscsi.c                  |   7 +-
 block/mirror.c                 |   3 +-
 block/nfs.c                    |   8 +-
 block/parallels.c              |  13 +-
 block/qcow.c                   |   8 +-
 block/qcow2-refcount.c         |   2 +-
 block/qcow2.c                  | 279 +++++++++++++++++++++--------
 block/qed.c                    |  11 +-
 block/raw-format.c             |   5 +-
 block/rbd.c                    |   7 +-
 block/sheepdog.c               |  11 +-
 block/vdi.c                    |   3 +-
 block/vhdx-log.c               |   2 +-
 block/vhdx.c                   |   8 +-
 block/vmdk.c                   |   7 +-
 block/vpc.c                    |   2 +-
 blockdev.c                     |   2 +-
 qemu-img.c                     |  33 +++-
 qemu-io-cmds.c                 |   2 +-
 qemu-img.texi                  |   7 +-
 tests/qemu-iotests/106         |  92 ++++++++++
 tests/qemu-iotests/106.out     |  50 ++++++
 tests/qemu-iotests/125         | 130 ++++++++++++++
 tests/qemu-iotests/125.out     | 386 +++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group       |   2 +
 36 files changed, 1148 insertions(+), 195 deletions(-)
 create mode 100755 tests/qemu-iotests/106
 create mode 100644 tests/qemu-iotests/106.out
 create mode 100755 tests/qemu-iotests/125
 create mode 100644 tests/qemu-iotests/125.out

-- 
2.12.0
