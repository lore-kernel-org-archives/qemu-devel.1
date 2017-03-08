Received: from eggs.gnu.org ([2001:4830:134:3::10]:48210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1clh2s-0002xh-HZ
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 14:14:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1clh2r-0007oW-8F
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 14:14:46 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  8 Mar 2017 20:14:30 +0100
Message-Id: <20170308191434.2413-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.10 0/4] block: Add errp to b{lk,
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Having an Error parameter for these functions makes sense because we
sometimes want a bit more information than just "Something failed". Some
drivers already use error_report() and the like to emit this additional
information, so it's rather obvious that we do want a real error object
here.


v2:
- Fix cover letter subject.
- Patch 1: Added so we can let patch 2 make use of the error object
           returned by the blk_truncate() calls in vhdx_create_bat()
           [Kevin]
- Patch 2: [Kevin]
  - Make use of those error objects as described above
  - Pass the error object returned by blk_truncate() to vpc_create()
  - Let qemu-io print blk_truncate()'s error message
- Patch 3: Fixed archipelago, not sure if that is relevant any longer...
- Patch 4:
  - Consistently always generate error messages in drivers that at least
    sometimes do so instead of sometimes relying on the default one
    [Eric]
  - Fix (pre-existing) coding style issue [Patchew]


git-backport-diff against v2:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/4:[down] 'block/vhdx: Make vhdx_create() always set errp'
002/4:[0026] [FC] 'block: Add errp to b{lk,drv}_truncate()'
003/4:[0002] [FC] 'block: Add errp to BD.bdrv_truncate()'
004/4:[0013] [FC] 'block: Add some bdrv_truncate() error messages'


Max Reitz (4):
  block/vhdx: Make vhdx_create() always set errp
  block: Add errp to b{lk,drv}_truncate()
  block: Add errp to BD.bdrv_truncate()
  block: Add some bdrv_truncate() error messages

 include/block/block.h          |  2 +-
 include/block/block_int.h      |  2 +-
 include/sysemu/block-backend.h |  2 +-
 block.c                        | 18 +++++++++++++-----
 block/archipelago.c            |  3 ++-
 block/blkdebug.c               |  4 ++--
 block/block-backend.c          |  5 +++--
 block/commit.c                 |  5 +++--
 block/crypto.c                 |  5 +++--
 block/file-posix.c             | 19 +++++++++++++------
 block/file-win32.c             |  6 +++---
 block/gluster.c                |  3 ++-
 block/iscsi.c                  |  4 ++--
 block/mirror.c                 |  2 +-
 block/nfs.c                    |  2 +-
 block/parallels.c              | 13 ++++++++-----
 block/qcow.c                   |  6 +++---
 block/qcow2-refcount.c         |  5 ++++-
 block/qcow2.c                  | 23 ++++++++++++++---------
 block/qed.c                    |  8 +++++---
 block/raw-format.c             |  6 ++++--
 block/rbd.c                    |  2 +-
 block/sheepdog.c               | 14 ++++++--------
 block/vdi.c                    |  4 ++--
 block/vhdx-log.c               |  2 +-
 block/vhdx.c                   | 25 ++++++++++++++++++-------
 block/vmdk.c                   | 13 +++----------
 block/vpc.c                    | 13 +++++++------
 blockdev.c                     | 21 +--------------------
 qemu-img.c                     | 17 ++++-------------
 qemu-io-cmds.c                 |  5 +++--
 31 files changed, 135 insertions(+), 124 deletions(-)

-- 
2.12.0
