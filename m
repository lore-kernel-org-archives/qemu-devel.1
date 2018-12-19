Received: from eggs.gnu.org ([2001:4830:134:3::10]:53890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mahaocong_work@163.com>) id 1gZVhT-0004bm-PH
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 01:51:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mahaocong_work@163.com>) id 1gZVhT-0003Qv-4w
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 01:51:23 -0500
From: mahaocong <mahaocong_work@163.com>
Date: Wed, 19 Dec 2018 14:50:19 +0800
Message-Id: <20181219065020.81256-1-mahaocong_work@163.com>
Subject: [Qemu-devel] [PATCH v1] migration: add incremental mode on
 drive-mirror
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

Hi all,

This patch adds possibility to start mirroring with specific dirty-bitmap.
The use-case is, for live migration with ceph rbd image.
1.create rbd image in ceph cluster, and map nbd device with rbd image.
2.create a new bitmap attached to drive.
3.create a full backup on nbd device and sync it to the rbd image.
4.create new image in destination host and set it's backingfile as rbd image.
5.start incremental mirroring to destination with dirty-bitmap from step 2.
6.live migrate VM to destination, bitmap should be migrated too.
7.unmap nbd in source host and map in destination.

Then I can use incremental backup to sync data and renew bitmap. If live migrate
VM again, repeat step 4 to step 7.

mahaocong (1):
  migration: add incremental mode on drive-mirror

 block/dirty-bitmap.c         | 14 ++++++++++
 block/mirror.c               | 63 +++++++++++++++++++++++++++++++++++---------
 blockdev.c                   | 36 +++++++++++++++++++++++--
 include/block/block_int.h    |  3 ++-
 include/block/dirty-bitmap.h |  3 +++
 include/qemu/hbitmap.h       |  2 ++
 qapi/block-core.json         |  4 ++-
 util/hbitmap.c               | 28 ++++++++++++++++++++
 8 files changed, 136 insertions(+), 17 deletions(-)

-- 
1.8.3.1
