Received: from eggs.gnu.org ([209.51.188.92]:36759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mahaocong_work@163.com>) id 1gp3nV-0003ne-LB
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 23:17:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mahaocong_work@163.com>) id 1gp3nU-0005Pr-FI
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 23:17:53 -0500
From: mahaocong <mahaocong_work@163.com>
Date: Thu, 31 Jan 2019 12:01:53 +0800
Message-Id: <20190131040154.3770-1-mahaocong_work@163.com>
Subject: [Qemu-devel] [PATCH v3 0/1] Drive-mirror: add incremental mode
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
On full mode, mirror create a non-named-bitmap by scanning whole block-chain,
and on top mode, mirror create a bitmap by scanning the top block layer. So I
think I can copy a user-created-bitmap and use it as the initial state of the
mirror, the same as incremental mode drive-backup, and I call this new mode
as incremental mode drive-mirror.

A possible usage scene of incremental mode mirror is live migration. For maintain
the block data and recover after a malfunction, someone may backup data to ceph
or other distributed storage. On qemu incremental backup, we need to create a new
bitmap and attach to block device before the first backup job. Then the bitmap
records the change after the backup job. If we want to migration this vm, we can
migrate block data between source and destionation by using drive-mirror directly,
or use backup data and backup-bitmap to reduce the data should be synchronize.
To do this, we should first create a new image in destination and set backing file
as backup image, then set backup-bitmap as the initial state of incremental mode
drive-mirror, and synchronize dirty block starting with the state set by the last
incremental backup job. When the mirror complete, we get an active layer on destination,
and its backing file is backup image on ceph. Then we can do live copy data from
backing files into overlay images by using block-stream, or do backup continually.

In this scene, It seems that If the guest os doesn't write too many data after the
last backup, the incremental mode may transmit less data than full mode or top
mode. However, if the write data is too many, there is no advantage on incremental
mode compare with other mode.

This scene can be described as following steps:
1.create rbd image in ceph, and map nbd device with rbd image.
2.create a new bitmap and attach to block device.
3.do full mode backup on nbd device and thus sync it to the rbd image.
4.severl times incremental mode backup.
5.create new image in destination and set its backing file as backup image.
6.do live-migration, and migrate block data by incremental mode drive-mirror
  with bitmap created from step 2.

mahaocong (1):
  drive-mirror: add incremental mode
  compare with old version, there are following changes:
  1.replace the copy bitmap function by bdrv_merge_dirty_bitmap
  2.remove checking for cancelled after mirror_dirty_init_incremental for bitmap
    copyimg don't have yield point.
  3.adjuest input parameters on mirror_start_job and mirror_start, and so It is
    no need to find bitmap on mirror_dirty_init_incremental again.
  4.assert the bitmap name is NULL on blockdev_mirror_common.
  5.change the parameter's name in qmp command 'drive-mirror' from 'bitmap_name'
    to 'bitmap'.

 block/mirror.c            | 46 ++++++++++++++++++++++++++++++++++------------
 blockdev.c                | 37 +++++++++++++++++++++++++++++++++++--
 include/block/block_int.h |  3 ++-
 qapi/block-core.json      |  7 ++++++-
 4 files changed, 77 insertions(+), 16 deletions(-)

-- 
2.14.1
