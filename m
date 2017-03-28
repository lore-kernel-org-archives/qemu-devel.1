Received: from eggs.gnu.org ([2001:4830:134:3::10]:43889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1csy5d-0004fk-Od
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 16:51:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1csy5c-0003Xs-V7
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 16:51:41 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 28 Mar 2017 22:51:25 +0200
Message-Id: <20170328205129.15138-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 for-2.10 0/4] block: Add errp to b{lk,
 drv}_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>

Having an Error parameter for these functions makes sense because we
sometimes want a bit more information than just "Something failed". Some
drivers already use error_report() and the like to emit this additional
information, so it's rather obvious that we do want a real error object
here.


v3:
- Patch 2: Keep "Could not resize image" message in qcow2_create2() by
           using error_prepend() [Kevin]
- Patch 3: Dropped archipelago
- Patch 4:
  - Keep errno information where available [Kevin]
  - Make all drivers generate error messages [Stefan/Eric]
  - Drop generic error message from bdrv_truncate() [Stefan/Eric]


Max Reitz (4):
  block/vhdx: Make vhdx_create() always set errp
  block: Add errp to b{lk,drv}_truncate()
  block: Add errp to BD.bdrv_truncate()
  block: Add .bdrv_truncate() error messages

 include/block/block.h          |  2 +-
 include/block/block_int.h      |  2 +-
 include/sysemu/block-backend.h |  2 +-
 block.c                        | 16 +++++++++++-----
 block/blkdebug.c               |  4 ++--
 block/block-backend.c          |  5 +++--
 block/commit.c                 |  5 +++--
 block/crypto.c                 |  5 +++--
 block/file-posix.c             | 19 +++++++++++++------
 block/file-win32.c             |  6 +++---
 block/gluster.c                |  7 +++++--
 block/iscsi.c                  |  6 ++++--
 block/mirror.c                 |  2 +-
 block/nfs.c                    | 12 ++++++++++--
 block/parallels.c              | 13 ++++++++-----
 block/qcow.c                   |  6 +++---
 block/qcow2-refcount.c         |  5 ++++-
 block/qcow2.c                  | 24 +++++++++++++++---------
 block/qed.c                    |  8 +++++---
 block/raw-format.c             |  6 ++++--
 block/rbd.c                    |  3 ++-
 block/sheepdog.c               | 14 ++++++--------
 block/vdi.c                    |  4 ++--
 block/vhdx-log.c               |  2 +-
 block/vhdx.c                   | 25 ++++++++++++++++++-------
 block/vmdk.c                   | 13 +++----------
 block/vpc.c                    | 13 +++++++------
 blockdev.c                     | 21 +--------------------
 qemu-img.c                     | 17 ++++-------------
 qemu-io-cmds.c                 |  5 +++--
 30 files changed, 147 insertions(+), 125 deletions(-)

-- 
2.12.1
