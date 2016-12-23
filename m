Received: from eggs.gnu.org ([2001:4830:134:3::10]:58316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cKW1P-00083I-RD
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 15:00:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cKW1O-0007CD-Ur
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 15:00:55 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 23 Dec 2016 17:28:51 +0300
Message-ID: <1482503344-6424-9-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 08/21] backup: skip unallocated clusters for
 full mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, vsementsov@virtuozzo.com, pbonzini@redhat.com, jcody@redhat.com

In case of full backup we can skip unallocated clusters if the target
disk is already zero-initialized.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/backup.c         | 8 ++++++--
 tests/qemu-iotests/055 | 2 ++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 2afd1b6..4ef8daf 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -562,9 +562,13 @@ static void coroutine_fn backup_run(void *opaque)
         if (job->sync_mode == MIRROR_SYNC_MODE_INCREMENTAL) {
             backup_incremental_init_copy_bitmap(job);
         } else {
+            /* top or full mode */
+            bool is_top = job->sync_mode == MIRROR_SYNC_MODE_TOP;
+            BlockDriverState *base =
+                    is_top ? backing_bs(blk_bs(job->common.blk)) : NULL;
             hbitmap_set(job->copy_bitmap, 0, end);
-            if (job->sync_mode == MIRROR_SYNC_MODE_TOP) {
-                backup_skip_loop(job, backing_bs(blk_bs(job->common.blk)));
+            if (is_top || bdrv_has_zero_init(blk_bs(job->target))) {
+                backup_skip_loop(job, base);
             }
         }
         ret = backup_loop(job);
diff --git a/tests/qemu-iotests/055 b/tests/qemu-iotests/055
index 1d3fd04..388b7b2 100755
--- a/tests/qemu-iotests/055
+++ b/tests/qemu-iotests/055
@@ -30,6 +30,7 @@ target_img = os.path.join(iotests.test_dir, 'target.img')
 blockdev_target_img = os.path.join(iotests.test_dir, 'blockdev-target.img')
 
 image_len = 64 * 1024 * 1024 # MB
+pause_write = '3M'
 
 def setUpModule():
     qemu_img('create', '-f', iotests.imgfmt, test_img, str(image_len))
@@ -39,6 +40,7 @@ def setUpModule():
     qemu_io('-f', iotests.imgfmt, '-c', 'write -P0xd5 1M 32k', test_img)
     qemu_io('-f', iotests.imgfmt, '-c', 'write -P0xdc 32M 124k', test_img)
     qemu_io('-f', iotests.imgfmt, '-c', 'write -P0x33 67043328 64k', test_img)
+    qemu_io('-f', iotests.imgfmt, '-c', 'write -P0xdc 40M ' + pause_write, test_img)
 
 def tearDownModule():
     os.remove(test_img)
-- 
1.8.3.1
