Received: from eggs.gnu.org ([208.118.235.92]:57672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mahaocong_work@163.com>) id 1gedO7-0007Ds-C4
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 05:04:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mahaocong_work@163.com>) id 1gedO6-0002L4-Jo
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 05:04:35 -0500
From: mahaocong <mahaocong_work@163.com>
Date: Wed,  2 Jan 2019 18:04:14 +0800
Message-Id: <20190102100415.24680-1-mahaocong_work@163.com>
Subject: [Qemu-devel] [PATCH v2 0/1] drive-mirror: add incremental mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org, mahaocong <mahaocong@didichuxing.com>

From: mahaocong <mahaocong@didichuxing.com>

This patch adds possibility to start mirroring with user-created-bitmap.
Compare with v1, this patch fix some shortcomings.
1.separate feature about copy dirty-bitmap to an individual patch.
2.remove checking for cancelled after mirror_dirty_init_incremental for bitmap
  copyimg don't have yield point.
3.adjuest input parameters on mirror_start_job and mirror_start, and so It is
  no need to find bitmap on mirror_dirty_init_incremental again.
4.assert the bitmap name is NULL on blockdev_mirror_common.
5.change the parameter's name in qmp command 'drive-mirror' from 'bitmap_name'
  to 'bitmap'.

As for the doubt about the new incremental mode, I think it is means that the
initial bitmap is appointed by user, compare with the full mode and top mode.
There is no different in other behaves, such as in iteration and complete
action.

mahaocong (1):
  drive-mirror: add incremental mode
  mirror: add incremental mode. we must add a user-named-bitmap first, then set
          this bitmap as the initial bitmap on incremental mode drive-mirror.
          in details, I first create unnamed-bitmap with the same granularity of
          user-bitmap. Next, copy It's hbitmap to unnamed-bitmap. Then, start
          mirror with this unname-bitmap.
  dirty-bitmap: add new API to copy dirty-bitmap. This feature is add in a
          separate patch called "add new function to copy dirty-bitmap"

 block/mirror.c            | 55 ++++++++++++++++++++++++++++++++++++-----------
 blockdev.c                | 37 +++++++++++++++++++++++++++++--
 include/block/block_int.h |  3 ++-
 qapi/block-core.json      |  9 +++++++-
 4 files changed, 88 insertions(+), 16 deletions(-)

-- 
2.14.1
