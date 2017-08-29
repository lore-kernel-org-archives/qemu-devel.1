Received: from eggs.gnu.org ([2001:4830:134:3::10]:47528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCC-0000v0-IA
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:15:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCA-0005Bf-ET
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:15:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCA-0005Af-3t
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:15:54 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0E85d005466
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:15:53 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cmvjejk4c-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:15:52 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 20:15:51 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:13:54 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-20-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 19/79] block: Reuse bs as backing hd for
 drive-backup sync=none
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

From: Fam Zheng <famz@redhat.com>

Opening the backing image for the second time is bad, especially here
when it is also in use as the active image as the source. The
drive-backup job itself doesn't read from target->backing for COW,
instead it gets data from the write notifier, so it's not a big problem.
However, exporting the target to NBD etc. won't work, because of the
likely stale metadata cache.

Use BDRV_O_NO_BACKING in this case and manually set up the backing
BdrvChild.

Cc: qemu-stable@nongnu.org
Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit fc0932fdcfc3e5cafa3641e361b681c07f639812)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 blockdev.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/blockdev.c b/blockdev.c
index e2f9c1e..841200e 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3170,6 +3170,7 @@ static BlockJob *do_drive_backup(DriveBackup *backup, BlockJobTxn *txn,
     Error *local_err = NULL;
     int flags;
     int64_t size;
+    bool set_backing_hd = false;
 
     if (!backup->has_speed) {
         backup->speed = 0;
@@ -3220,6 +3221,8 @@ static BlockJob *do_drive_backup(DriveBackup *backup, BlockJobTxn *txn,
     }
     if (backup->sync == MIRROR_SYNC_MODE_NONE) {
         source = bs;
+        flags |= BDRV_O_NO_BACKING;
+        set_backing_hd = true;
     }
 
     size = bdrv_getlength(bs);
@@ -3246,7 +3249,9 @@ static BlockJob *do_drive_backup(DriveBackup *backup, BlockJobTxn *txn,
     }
 
     if (backup->format) {
-        options = qdict_new();
+        if (!options) {
+            options = qdict_new();
+        }
         qdict_put_str(options, "driver", backup->format);
     }
 
@@ -3257,6 +3262,14 @@ static BlockJob *do_drive_backup(DriveBackup *backup, BlockJobTxn *txn,
 
     bdrv_set_aio_context(target_bs, aio_context);
 
+    if (set_backing_hd) {
+        bdrv_set_backing_hd(target_bs, source, &local_err);
+        if (local_err) {
+            bdrv_unref(target_bs);
+            goto out;
+        }
+    }
+
     if (backup->has_bitmap) {
         bmap = bdrv_find_dirty_bitmap(bs, backup->bitmap);
         if (!bmap) {
-- 
2.7.4
