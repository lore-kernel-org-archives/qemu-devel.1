Received: from eggs.gnu.org ([2001:4830:134:3::10]:41390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dEIWQ-0007z2-4v
	for qemu-devel@nongnu.org; Fri, 26 May 2017 12:55:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dEIWO-0003a8-MG
	for qemu-devel@nongnu.org; Fri, 26 May 2017 12:55:30 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 26 May 2017 18:55:02 +0200
Message-Id: <20170526165518.7580-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 00/16] block: Preallocated truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

=3D=3D=3D Series dependencies =3D=3D=3D

This series depends on v6 of Stefan's series
"qemu-img: add measure sub-command"
(http://lists.nongnu.org/archive/html/qemu-devel/2017-05/msg01706.html).


=3D=3D=3D Actual cover letter =3D=3D=3D

This series adds preallocation to bdrv_truncate() and subsequently
qemu-img resize. This is implemented for qcow2 and raw only, just like
preallocation for newly created images is. There is no runtime interface
for this new parameter (yet).


=3D=3D=3D v3 =3D=3D=3D

General overview: Rebased on Stefan's series, addressed comments from
v2. The most important change is that I rethought the whole concept of
how to make sure that we actually have allocated the right amount of
space in a qcow2 file.

What we really want is to just preallocate the new data area. All
metadata we'll have to create along the way will be allocated
automatically, so there is no need to preallocate that as well. But we
need to preallocate the data, and in order to be able to do by issuing a
bdrv_truncate() on the underlying file, we need to place it at the end
of the qcow2 file (therefore we cannot really preallocate the data in
preallocate(): The allocation function used there may place the data
anywhere, and it may even put refcount structures afterwards if you're
really unlucky).

So we need some way to allocate a big chunk of data in a qcow2 file
without being interrupted by refcount structure allocations or anything.
It'd also be nice not to have to guess where the refcount table is
placed (if it is resized) or how many refcount blocks we'll need or
anything like that.
We can do all of that by allocating the necessary refcount structures
beforehand. Our alloc_refcount_block() function does perform this
functionality when growing the refcount table. In order to make this
usable, we'll have to place it into an own function and allow it to
cover more clusters in addition to just the new refcount structures
themselves. This is done by patch 12.

Then we just invoke that function, truncate the underlying file to
preallocate what is supposed to be the area for the new data, increase
its refcount and hook it up in the L2 tables (patch 14).


Alternatively, we could extend the preallocate() function to preallocate
the data in the underlying file. But this would require a
bdrv_preallocate() function because the new data may be placed anywhere
and bdrv_truncate() can only be used to preallocate data at the end of a
file. All in all, this would probably result in a series with a very
similar diff stat. Since I put all of my work into this version here, I
elect not to try it (unless someone thinks it would be useful) -- to be
honest, I just got the idea while writing this cover letter.
(And I personally like qcow2_refcount_area() more than what
 alloc_refcount_block() did before, although it is considerably longer.
 But maybe that is just a personal bias because I wrote it myself.)


Short per-patch differences:
- Patch 4: Rebase conflict (bumped OPTION_PREALLOCATION from 264 to 265)
- Patch 9: Use uint64_t instead of int64_t [Philippe]
- Patch 10: We should not call a *_co_* function unless in a coroutine;
            and we don't need to lock the mutex outside of a coroutine.
- Patches 12/13: New (old patches 12/13 have been dropped)
- Patch 14: Completely new implementation


git-backport-diff against v2:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/16:[----] [-C] 'block: Add PreallocMode to BD.bdrv_truncate()'
002/16:[----] [-C] 'block: Add PreallocMode to bdrv_truncate()'
003/16:[----] [-C] 'block: Add PreallocMode to blk_truncate()'
004/16:[0002] [FC] 'qemu-img: Expose PreallocMode for resizing'
005/16:[----] [--] 'block/file-posix: Small fixes in raw_create()'
006/16:[----] [--] 'block/file-posix: Extract raw_regular_truncate()'
007/16:[----] [--] 'block/file-posix: Generalize raw_regular_truncate'
008/16:[----] [--] 'block/file-posix: Preallocation for truncate'
009/16:[0003] [FC] 'block/qcow2: Generalize preallocate()'
010/16:[0008] [FC] 'block/qcow2: Lock s->lock in preallocate()'
011/16:[----] [--] 'block/qcow2: Metadata preallocation for truncate'
012/16:[down] 'block/qcow2: Add qcow2_refcount_area()'
013/16:[down] 'block/qcow2: Rename "fail_block" to just "fail"'
014/16:[0117] [FC] 'block/qcow2: falloc/full preallocating growth'
015/16:[----] [--] 'iotests: Add preallocated resize test for raw'
016/16:[----] [--] 'iotests: Add preallocated growth test for qcow2'


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
  block/qcow2: Add qcow2_refcount_area()
  block/qcow2: Rename "fail_block" to just "fail"
  block/qcow2: falloc/full preallocating growth
  iotests: Add preallocated resize test for raw
  iotests: Add preallocated growth test for qcow2

 block/qcow2.h                  |   9 +
 include/block/block.h          |   3 +-
 include/block/block_int.h      |   3 +-
 include/sysemu/block-backend.h |   3 +-
 block.c                        |   5 +-
 block/blkdebug.c               |   5 +-
 block/block-backend.c          |   5 +-
 block/commit.c                 |   4 +-
 block/crypto.c                 |   4 +-
 block/file-posix.c             | 201 +++++++++++++--------
 block/file-win32.c             |   9 +-
 block/gluster.c                |   8 +-
 block/iscsi.c                  |   9 +-
 block/mirror.c                 |   3 +-
 block/nfs.c                    |   9 +-
 block/parallels.c              |  13 +-
 block/qcow.c                   |   8 +-
 block/qcow2-refcount.c         | 277 +++++++++++++++++++----------
 block/qcow2.c                  | 196 ++++++++++++++++++---
 block/qed.c                    |  11 +-
 block/raw-format.c             |   5 +-
 block/rbd.c                    |   9 +-
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
 tests/qemu-iotests/044.out     |   2 +-
 tests/qemu-iotests/106         |  92 ++++++++++
 tests/qemu-iotests/106.out     |  50 ++++++
 tests/qemu-iotests/125         | 130 ++++++++++++++
 tests/qemu-iotests/125.out     | 386 +++++++++++++++++++++++++++++++++++=
++++++
 tests/qemu-iotests/group       |   2 +
 38 files changed, 1304 insertions(+), 234 deletions(-)
 create mode 100755 tests/qemu-iotests/106
 create mode 100644 tests/qemu-iotests/106.out
 create mode 100755 tests/qemu-iotests/125
 create mode 100644 tests/qemu-iotests/125.out

--=20
2.9.4
