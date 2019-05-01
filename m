Received: from eggs.gnu.org ([209.51.188.92]:45598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hLtkb-0007N2-RO
	for qemu-devel@nongnu.org; Wed, 01 May 2019 14:14:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hLtka-0002bN-0P
	for qemu-devel@nongnu.org; Wed, 01 May 2019 14:14:37 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Wed,  1 May 2019 21:13:54 +0300
Message-Id: <cover.1556732434.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 0/5] Remove bdrv_read() and bdrv_write()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

Hi,

this API only had a few users left so it can be easily removed.

Regards,

Berto

v2:
- Patch 2: Add QEMU_BUILD_BUG_ON(sizeof(VdiHeader) != 512) [Kevin]
           Correct size parameter in bdrv_pwrite() call [Kevin]
           Return 0 on success, never a positive number [Kevin]
- Patch 3: Check that the return values of bdrv_pread()/bdrv_pwrite()
           are strictly < 0 for errors, not simply != 0 [Kevin]
- Patch 4: Reuse the documenation of bdrv_write() for bdrv_pwrite()

v1: https://lists.gnu.org/archive/html/qemu-block/2019-04/msg00832.html

Output of git backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/5:[----] [--] 'qcow2: Replace bdrv_write() with bdrv_pwrite()'
002/5:[0006] [FC] 'vdi: Replace bdrv_{read,write}() with bdrv_{pread,pwrite}()'
003/5:[0004] [FC] 'vvfat: Replace bdrv_{read,write}() with bdrv_{pread,pwrite}()'
004/5:[0007] [FC] 'block: Remove bdrv_read() and bdrv_write()'
005/5:[----] [--] 'qcow2: Remove BDRVQcow2State.cluster_sectors'

Alberto Garcia (5):
  qcow2: Replace bdrv_write() with bdrv_pwrite()
  vdi: Replace bdrv_{read,write}() with bdrv_{pread,pwrite}()
  vvfat: Replace bdrv_{read,write}() with bdrv_{pread,pwrite}()
  block: Remove bdrv_read() and bdrv_write()
  qcow2: Remove BDRVQcow2State.cluster_sectors

 block/io.c             | 43 +++++++------------------------------------
 block/qcow2-refcount.c |  4 ++--
 block/qcow2.c          |  1 -
 block/qcow2.h          |  1 -
 block/vdi.c            | 15 +++++++++------
 block/vvfat.c          | 12 +++++++-----
 include/block/block.h  |  4 ----
 7 files changed, 25 insertions(+), 55 deletions(-)

-- 
2.11.0
