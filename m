Received: from eggs.gnu.org ([209.51.188.92]:51222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpGZK-0005jq-6i
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 12:56:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpGZJ-00054b-6Y
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 12:56:06 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 31 Jan 2019 18:55:38 +0100
Message-Id: <20190131175549.11691-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 00/11] qcow2: External data files
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

There are a few reasons why this is still RFC:

- The resulting code passes qemu-iotests, so we don't regress on normal
  qcow2 files, but testing with external data files is still minimal
  (converting an existing image and confirming it reads back unmodified;
  installing a guest OS and making sure it boots). We need at least some
  qemu-iotests cases.

- QAPI documentation is missing

- Discard isn't passed through to the data file yet

- s->image_data_file isn't correct, it gets the value from the attached
  node rather than just from the image file. This means that on header
  updates we might be writing "back" a path that wasn't there before.

- Probably something else I just can't remember now :-)

Kevin Wolf (11):
  qcow2: Extend spec for external data files
  qcow2: Basic definitions for external data files
  qcow2: Pass bs to qcow2_get_cluster_type()
  qcow2: Prepare qcow2_get_cluster_type() for external data file
  qcow2: Prepare count_contiguous_clusters() for external data file
  qcow2: Don't assume 0 is an invalid cluster offset
  qcow2: External file I/O
  qcow2: Add basic data-file infrastructure
  qcow2: Creating images with external data file
  qcow2: Store data file name in the image
  qcow2: Add data file to ImageInfoSpecificQCow2

 qapi/block-core.json       |   5 +-
 docs/interop/qcow2.txt     |  19 ++++-
 block/qcow2.h              |  40 +++++++--
 include/block/block_int.h  |   1 +
 block/qcow2-bitmap.c       |   7 +-
 block/qcow2-cache.c        |   6 +-
 block/qcow2-cluster.c      | 144 +++++++++++++++++++-------------
 block/qcow2-refcount.c     |  40 ++++++---
 block/qcow2-snapshot.c     |   7 +-
 block/qcow2.c              | 166 ++++++++++++++++++++++++++++++++++---
 tests/qemu-iotests/031.out |   8 +-
 tests/qemu-iotests/036.out |   4 +-
 tests/qemu-iotests/061.out |  14 ++--
 tests/qemu-iotests/082.out |  27 ++++++
 14 files changed, 372 insertions(+), 116 deletions(-)

--=20
2.20.1
