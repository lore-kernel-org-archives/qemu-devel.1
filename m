Received: from eggs.gnu.org ([2001:4830:134:3::10]:41065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYdKO-00080A-8N
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:15:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYdKN-0007jn-BE
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:15:40 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 28 Jun 2018 15:15:23 -0500
Message-Id: <20180628201525.281787-7-eblake@redhat.com>
In-Reply-To: <20180628201525.281787-1-eblake@redhat.com>
References: <20180628201525.281787-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 6/8] replication: Switch to byte-based calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jcody@redhat.com, kwolf@redhat.com, famz@redhat.com, stefanha@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, Wen Congyang <wencongyang2@huawei.com>, Xie Changlong <xiechanglong.d@gmail.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Make the change for the last few sector-based calls
into the block layer from the replication driver.

Ideally, the replication driver should switch to doing everything
byte-based, but that's a more invasive change that requires a
bit more auditing.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
---
 block/replication.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/block/replication.c b/block/replication.c
index 826db7b3049..6349d6958e4 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -246,13 +246,14 @@ static coroutine_fn int replication_co_readv(BlockDriverState *bs,
         backup_cow_request_begin(&req, child->bs->job,
                                  sector_num * BDRV_SECTOR_SIZE,
                                  remaining_bytes);
-        ret = bdrv_co_readv(bs->file, sector_num, remaining_sectors,
-                            qiov);
+        ret = bdrv_co_preadv(bs->file, sector_num * BDRV_SECTOR_SIZE,
+                             remaining_bytes, qiov, 0);
         backup_cow_request_end(&req);
         goto out;
     }

-    ret = bdrv_co_readv(bs->file, sector_num, remaining_sectors, qiov);
+    ret = bdrv_co_preadv(bs->file, sector_num * BDRV_SECTOR_SIZE,
+                         remaining_sectors * BDRV_SECTOR_SIZE, qiov, 0);
 out:
     return replication_return_value(s, ret);
 }
@@ -279,8 +280,8 @@ static coroutine_fn int replication_co_writev(BlockDriverState *bs,
     }

     if (ret == 0) {
-        ret = bdrv_co_writev(top, sector_num,
-                             remaining_sectors, qiov);
+        ret = bdrv_co_pwritev(top, sector_num * BDRV_SECTOR_SIZE,
+                              remaining_sectors * BDRV_SECTOR_SIZE, qiov, 0);
         return replication_return_value(s, ret);
     }

@@ -306,7 +307,8 @@ static coroutine_fn int replication_co_writev(BlockDriverState *bs,
         qemu_iovec_concat(&hd_qiov, qiov, bytes_done, count);

         target = ret ? top : base;
-        ret = bdrv_co_writev(target, sector_num, n, &hd_qiov);
+        ret = bdrv_co_pwritev(target, sector_num * BDRV_SECTOR_SIZE,
+                              n * BDRV_SECTOR_SIZE, &hd_qiov, 0);
         if (ret < 0) {
             goto out1;
         }
-- 
2.14.4
