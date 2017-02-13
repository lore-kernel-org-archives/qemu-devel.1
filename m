Received: from eggs.gnu.org ([2001:4830:134:3::10]:59757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdKMP-0003oj-HE
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:24:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdKMO-0006NQ-6b
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:24:21 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 13 Feb 2017 18:22:52 +0100
Message-Id: <1487006583-24350-31-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 30/41] backup: Use real permissions in
 backup block job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

The backup block job doesn't have very complicated requirements: It
needs to read from the source and write to the target, but it's fine
with either side being changed. The only restriction is that we can't
resize the image because the job uses a cached value.

qemu-iotests 055 needs to be changed because it used a target which was
already attached to a virtio-blk device. The permission system correctly
forbids this (virtio-blk can't accept another writer with its default
share-rw=off).

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/backup.c         | 15 ++++++++++-----
 tests/qemu-iotests/055 | 11 +++++++----
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 22171f4..47fadfb 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -618,15 +618,20 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
         goto error;
     }
 
-    /* FIXME Use real permissions */
-    job = block_job_create(job_id, &backup_job_driver, bs, 0, BLK_PERM_ALL,
+    /* job->common.len is fixed, so we can't allow resize */
+    job = block_job_create(job_id, &backup_job_driver, bs,
+                           BLK_PERM_CONSISTENT_READ,
+                           BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE |
+                           BLK_PERM_WRITE_UNCHANGED | BLK_PERM_GRAPH_MOD,
                            speed, creation_flags, cb, opaque, errp);
     if (!job) {
         goto error;
     }
 
-    /* FIXME Use real permissions */
-    job->target = blk_new(0, BLK_PERM_ALL);
+    /* The target must match the source in size, so no resize here either */
+    job->target = blk_new(BLK_PERM_WRITE,
+                          BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE |
+                          BLK_PERM_WRITE_UNCHANGED | BLK_PERM_GRAPH_MOD);
     ret = blk_insert_bs(job->target, target, errp);
     if (ret < 0) {
         goto error;
@@ -657,7 +662,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
         job->cluster_size = MAX(BACKUP_CLUSTER_SIZE_DEFAULT, bdi.cluster_size);
     }
 
-    /* FIXME Use real permissions */
+    /* Required permissions are already taken with target's blk_new() */
     block_job_add_bdrv(&job->common, target, 0, BLK_PERM_ALL, &error_abort);
     job->common.len = len;
     block_job_txn_add_job(txn, &job->common);
diff --git a/tests/qemu-iotests/055 b/tests/qemu-iotests/055
index 1d3fd04..aafcd24 100755
--- a/tests/qemu-iotests/055
+++ b/tests/qemu-iotests/055
@@ -48,7 +48,8 @@ class TestSingleDrive(iotests.QMPTestCase):
     def setUp(self):
         qemu_img('create', '-f', iotests.imgfmt, blockdev_target_img, str(image_len))
 
-        self.vm = iotests.VM().add_drive(test_img).add_drive(blockdev_target_img)
+        self.vm = iotests.VM().add_drive(test_img)
+        self.vm.add_drive(blockdev_target_img, interface="none")
         if iotests.qemu_default_machine == 'pc':
             self.vm.add_drive(None, 'media=cdrom', 'ide')
         self.vm.launch()
@@ -164,7 +165,8 @@ class TestSetSpeed(iotests.QMPTestCase):
     def setUp(self):
         qemu_img('create', '-f', iotests.imgfmt, blockdev_target_img, str(image_len))
 
-        self.vm = iotests.VM().add_drive(test_img).add_drive(blockdev_target_img)
+        self.vm = iotests.VM().add_drive(test_img)
+        self.vm.add_drive(blockdev_target_img, interface="none")
         self.vm.launch()
 
     def tearDown(self):
@@ -247,7 +249,8 @@ class TestSingleTransaction(iotests.QMPTestCase):
     def setUp(self):
         qemu_img('create', '-f', iotests.imgfmt, blockdev_target_img, str(image_len))
 
-        self.vm = iotests.VM().add_drive(test_img).add_drive(blockdev_target_img)
+        self.vm = iotests.VM().add_drive(test_img)
+        self.vm.add_drive(blockdev_target_img, interface="none")
         if iotests.qemu_default_machine == 'pc':
             self.vm.add_drive(None, 'media=cdrom', 'ide')
         self.vm.launch()
@@ -460,7 +463,7 @@ class TestDriveCompression(iotests.QMPTestCase):
 
         qemu_img('create', '-f', fmt, blockdev_target_img,
                  str(TestDriveCompression.image_len), *args)
-        self.vm.add_drive(blockdev_target_img, format=fmt)
+        self.vm.add_drive(blockdev_target_img, format=fmt, interface="none")
 
         self.vm.launch()
 
-- 
1.8.3.1
