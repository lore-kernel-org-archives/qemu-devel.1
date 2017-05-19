Received: from eggs.gnu.org ([2001:4830:134:3::10]:48170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dBeJQ-0006eC-5h
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:35:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dBeJM-0006fo-7q
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:35:08 -0400
Received: from mail-db5eur01on0097.outbound.protection.outlook.com
	([104.47.2.97]:23097
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dBeJL-0006e7-Ht
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:35:04 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Fri, 19 May 2017 12:34:27 +0300
Message-ID: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 00/13] qcow2: space preallocation and COW
 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

This pull request is to address a few performance problems of qcow2 format:

  1. non cluster-aligned write requests (to unallocated clusters) explicitly
    pad data with zeroes if there is no backing data. This can be avoided
    and the whole clusters are preallocated and zeroed in a single
    efficient write_zeroes() operation, also providing better host file
    continuity

  2. moreover, efficient write_zeroes() operation can be used to preallocate
    space megabytes ahead which gives noticeable improvement on some storage
    types (e.g. distributed storages where space allocation operation is
    expensive)

  3. preallocating/zeroing the clusters in advance makes possible to enable
    simultaneous writes to the same unallocated cluster, which is beneficial
    for parallel sequential write operations which are not cluster-aligned

Performance test results are added to commit messages (see patch 3, 12)

Anton Nefedov (9):
  qcow2: is_zero_sectors(): return true if area is outside of backing
    file
  qcow2: do not COW the empty areas
  qcow2: set inactive flag
  qcow2: handle_prealloc(): find out if area zeroed by earlier
    preallocation
  qcow2: fix misleading comment about L2 linking
  qcow2-cluster: slightly refactor handle_dependencies()
  qcow2-cluster: make handle_dependencies() logic easier to follow
  qcow2: allow concurrent unaligned writes to the same clusters
  iotest 046: test simultaneous cluster write error case

Denis V. Lunev (3):
  qcow2: alloc space for COW in one chunk
  qcow2: preallocation at image expand
  qcow2: truncate preallocated space

Pavel Butsykin (1):
  qcow2: check space leak at the end of the image

 block/qcow2-cache.c                |   3 +
 block/qcow2-cluster.c              | 216 +++++++++++++++++++++++-----
 block/qcow2-refcount.c             |  21 +++
 block/qcow2.c                      | 286 ++++++++++++++++++++++++++++++++++++-
 block/qcow2.h                      |  26 ++++
 tests/qemu-iotests/026.out         | 104 ++++++++++----
 tests/qemu-iotests/026.out.nocache | 104 ++++++++++----
 tests/qemu-iotests/029.out         |   5 +-
 tests/qemu-iotests/046             |  38 ++++-
 tests/qemu-iotests/046.out         |  23 +++
 tests/qemu-iotests/060             |   2 +-
 tests/qemu-iotests/060.out         |  13 +-
 tests/qemu-iotests/061.out         |   5 +-
 tests/qemu-iotests/066             |   2 +-
 tests/qemu-iotests/066.out         |   9 +-
 tests/qemu-iotests/098.out         |   7 +-
 tests/qemu-iotests/108.out         |   5 +-
 tests/qemu-iotests/112.out         |   5 +-
 tests/qemu-iotests/154.out         |   4 +-
 19 files changed, 769 insertions(+), 109 deletions(-)

-- 
2.7.4
