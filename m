Received: from eggs.gnu.org ([2001:4830:134:3::10]:50065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fcmBi-0001QN-Eg
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 02:31:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fcmBh-0007nb-N2
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 02:31:50 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 10 Jul 2018 14:31:14 +0800
Message-Id: <20180710063124.2263-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 00/10] block: Fix dst reading after tail
 copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Based-on: 20180709163719.87107-1-vsementsov@virtuozzo.com

v3: - Rebase onto Vladmir's:
      [PATCH v5 0/4] fix image fleecing
      on top of master, which has blklogwrites to be converted to BdrvChild for
      the bdrv_co_pdiscard() parameter.  [Kevin]
    - Add file_ prefix to file protocol trace points. [Kevin]
    - Assert that BdrvTrackedRequest bytes and offset don't overflow INT64_MAX.
      [Kevin]
    - Don't misuse req->offset/req->bytes in bdrv_co_write_req_prepare/finish.
      [Kevin]
    - Fix stat64_max. [Kevin]
    - Keep lines within 80 columns. [Kevin]
    - Grammar fix in commit message and rev-by. [Eric]

Qcow2 allocates new clusters after the end of the file. If it is the destinaton
of copy offloading, we must adjust dst->bs->total_sectors. Otherwise, further
reads will drop to the "beyond EOF" code path and return zeroes, which problem
is caught by iotests 222.

Follow the logic in the normal write code and update bs->total_sectors after
I/O is done.

While at it, add a few convenient trace points to aid future debug experiences
in the topic.

Fam Zheng (10):
  block: Prefix file driver trace points with "file_"
  block: Add copy offloading trace points
  block: Use BdrvChild to discard
  block: Use uint64_t for BdrvTrackedRequest byte fields
  block: Extract common write req handling
  block: Fix handling of image enlarging write
  block: Use common req handling for discard
  block: Use common req handling in copy offloading
  block: Fix bdrv_co_truncate overlap check
  block: Use common write req handling in truncate

 block/blkdebug.c          |   2 +-
 block/blklogwrites.c      |   2 +-
 block/blkreplay.c         |   2 +-
 block/block-backend.c     |   2 +-
 block/copy-on-read.c      |   2 +-
 block/file-posix.c        |   4 +-
 block/file-win32.c        |   2 +-
 block/io.c                | 213 ++++++++++++++++++++++++--------------
 block/iscsi.c             |   3 +
 block/mirror.c            |   2 +-
 block/qcow2-refcount.c    |   2 +-
 block/raw-format.c        |   2 +-
 block/throttle.c          |   2 +-
 block/trace-events        |  10 +-
 include/block/block.h     |   4 +-
 include/block/block_int.h |   4 +-
 16 files changed, 163 insertions(+), 95 deletions(-)

-- 
2.17.1
