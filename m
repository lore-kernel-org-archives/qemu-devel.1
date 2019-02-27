Received: from eggs.gnu.org ([209.51.188.92]:51190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gz2vY-0002wW-0W
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 12:23:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gz2vM-0002wx-1u
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 12:23:19 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 27 Feb 2019 18:22:36 +0100
Message-Id: <20190227172256.30368-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/20] qcow2: External data files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

There are use cases where raw images are given (e.g. existing physical
disks), but advanced features like dirty bitmaps or backing files are
wanted that require use of a proper image format like qcow2.

This series adds an incompatible feature bit to qcow2 which allows to
use an external data file: Metadata is kept in the qcow2 file like
usual, but guest data is written to an external file. Clusters in the
data file are not reference counted, instead we use a flat layout where
host cluster offset =3D=3D guest cluster offset. The external data file i=
s
therefore readable as a raw image (though writing to it invalidates the
associated qcow2 metadata). Features that require refcounting such as
internal snapshots or compression are not supposed in such setups.

Major changes since the RFC (many more minor changes):

- Added a 'data-file-raw' flag to the spec to keep the data file a valid
  self-consistent raw image (write_zeroes must always be propagated)
- Added QAPI documentation
- Added some test cases
- Implemented data file support or error paths for discard, check,
  compressed writes, snapshots
- Fixed qcow2_co_block_status()
- Rearranged qcow2_do_open() code for data files for better error
  handling (e.g. no more fallback to default data file if an explicit,
  but invalid data-file option is given)

git-backport-diff compared to the RFC:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/20:[down] 'qemu-iotests: Test qcow2 preallocation modes'
002/20:[down] 'qcow2: Simplify preallocation code'
003/20:[0027] [FC] 'qcow2: Extend spec for external data files'
004/20:[0014] [FC] 'qcow2: Basic definitions for external data files'
005/20:[----] [--] 'qcow2: Pass bs to qcow2_get_cluster_type()'
006/20:[----] [--] 'qcow2: Prepare qcow2_get_cluster_type() for external =
data file'
007/20:[----] [--] 'qcow2: Prepare count_contiguous_clusters() for extern=
al data file'
008/20:[----] [--] 'qcow2: Don't assume 0 is an invalid cluster offset'
009/20:[down] 'qcow2: Return 0/-errno in qcow2_alloc_compressed_cluster_o=
ffset()'
010/20:[down] 'qcow2: Prepare qcow2_co_block_status() for data file'
011/20:[0024] [FC] 'qcow2: External file I/O'
012/20:[down] 'qcow2: Return error for snapshot operation with data file'
013/20:[down] 'qcow2: Support external data file in qemu-img check'
014/20:[0035] [FC] 'qcow2: Add basic data-file infrastructure'
015/20:[0003] [FC] 'qcow2: Creating images with external data file'
016/20:[0057] [FC] 'qcow2: Store data file name in the image'
017/20:[down] 'qcow2: Implement data-file-raw create option'
018/20:[down] 'qemu-iotests: Preallocation with external data file'
019/20:[down] 'qemu-iotests: General tests for qcow2 with external data f=
ile'
020/20:[down] 'qemu-iotests: amend with external data file'


Kevin Wolf (20):
  qemu-iotests: Test qcow2 preallocation modes
  qcow2: Simplify preallocation code
  qcow2: Extend spec for external data files
  qcow2: Basic definitions for external data files
  qcow2: Pass bs to qcow2_get_cluster_type()
  qcow2: Prepare qcow2_get_cluster_type() for external data file
  qcow2: Prepare count_contiguous_clusters() for external data file
  qcow2: Don't assume 0 is an invalid cluster offset
  qcow2: Return 0/-errno in qcow2_alloc_compressed_cluster_offset()
  qcow2: Prepare qcow2_co_block_status() for data file
  qcow2: External file I/O
  qcow2: Return error for snapshot operation with data file
  qcow2: Support external data file in qemu-img check
  qcow2: Add basic data-file infrastructure
  qcow2: Creating images with external data file
  qcow2: Store data file name in the image
  qcow2: Implement data-file-raw create option
  qemu-iotests: Preallocation with external data file
  qemu-iotests: General tests for qcow2 with external data file
  qemu-iotests: amend with external data file

 qapi/block-core.json       |  26 ++-
 docs/interop/qcow2.txt     |  38 ++++-
 block/qcow2.h              |  66 ++++++--
 include/block/block_int.h  |   2 +
 block/qcow2-bitmap.c       |   7 +-
 block/qcow2-cache.c        |   6 +-
 block/qcow2-cluster.c      | 182 ++++++++++++---------
 block/qcow2-refcount.c     |  88 ++++++++---
 block/qcow2-snapshot.c     |  22 ++-
 block/qcow2.c              | 314 +++++++++++++++++++++++++++++++------
 tests/qemu-iotests/031.out |   8 +-
 tests/qemu-iotests/036.out |   4 +-
 tests/qemu-iotests/061     |  45 +++++-
 tests/qemu-iotests/061.out | 103 +++++++++++-
 tests/qemu-iotests/082.out |  54 +++++++
 tests/qemu-iotests/220.out |   2 +-
 tests/qemu-iotests/243     |  85 ++++++++++
 tests/qemu-iotests/243.out |  58 +++++++
 tests/qemu-iotests/244     | 200 +++++++++++++++++++++++
 tests/qemu-iotests/244.out | 125 +++++++++++++++
 tests/qemu-iotests/group   |   2 +
 21 files changed, 1243 insertions(+), 194 deletions(-)
 create mode 100755 tests/qemu-iotests/243
 create mode 100644 tests/qemu-iotests/243.out
 create mode 100755 tests/qemu-iotests/244
 create mode 100644 tests/qemu-iotests/244.out

--=20
2.20.1
