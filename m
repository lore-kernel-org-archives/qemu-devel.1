Received: from eggs.gnu.org ([2001:4830:134:3::10]:50580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cwavF-00066p-OJ
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 16:56:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cwavE-0003TZ-Tp
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 16:55:57 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Fri,  7 Apr 2017 16:55:29 -0400
Message-Id: <e2bba34ac3bc76a0c42adc390413f358ae0566e8.1491597120.git.jcody@redhat.com>
In-Reply-To: <cover.1491597120.git.jcody@redhat.com>
References: <cover.1491597120.git.jcody@redhat.com>
In-Reply-To: <cover.1491597120.git.jcody@redhat.com>
References: <cover.1491597120.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.10 5/8] block: introduce
 bdrv_can_set_read_only()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, kwolf@redhat.com, jsnow@redhat.com, eblake@redhat.com

Introduce check function for setting read_only flags.  Will return < 0 on
error, with appropriate Error value set.  Does not alter any flags.

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block.c               | 14 +++++++++++++-
 include/block/block.h |  1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index a05ad48..1514ae9 100644
--- a/block.c
+++ b/block.c
@@ -197,7 +197,7 @@ bool bdrv_is_read_only(BlockDriverState *bs)
     return bs->read_only;
 }
 
-int bdrv_set_read_only(BlockDriverState *bs, bool read_only, Error **errp)
+int bdrv_can_set_read_only(BlockDriverState *bs, bool read_only, Error **errp)
 {
     /* Do not set read_only if copy_on_read is enabled */
     if (bs->copy_on_read && read_only) {
@@ -213,6 +213,18 @@ int bdrv_set_read_only(BlockDriverState *bs, bool read_only, Error **errp)
         return -EPERM;
     }
 
+    return 0;
+}
+
+int bdrv_set_read_only(BlockDriverState *bs, bool read_only, Error **errp)
+{
+    int ret = 0;
+
+    ret = bdrv_can_set_read_only(bs, read_only, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
     bs->read_only = read_only;
     return 0;
 }
diff --git a/include/block/block.h b/include/block/block.h
index beb563a..dfd8694 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -426,6 +426,7 @@ int bdrv_is_allocated_above(BlockDriverState *top, BlockDriverState *base,
                             int64_t sector_num, int nb_sectors, int *pnum);
 
 bool bdrv_is_read_only(BlockDriverState *bs);
+int bdrv_can_set_read_only(BlockDriverState *bs, bool read_only, Error **errp);
 int bdrv_set_read_only(BlockDriverState *bs, bool read_only, Error **errp);
 bool bdrv_is_sg(BlockDriverState *bs);
 bool bdrv_is_inserted(BlockDriverState *bs);
-- 
2.9.3
