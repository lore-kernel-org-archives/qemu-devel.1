Received: from eggs.gnu.org ([2001:4830:134:3::10]:34197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cvpgP-0006oa-KN
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 14:29:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cvpgO-0002DL-MT
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 14:29:29 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Wed,  5 Apr 2017 14:28:47 -0400
Message-Id: <1eeddeba3dc5775183bd1e44ecae616c233b932d.1491416061.git.jcody@redhat.com>
In-Reply-To: <cover.1491416061.git.jcody@redhat.com>
References: <cover.1491416061.git.jcody@redhat.com>
In-Reply-To: <cover.1491416061.git.jcody@redhat.com>
References: <cover.1491416061.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 5/9] block: introduce
 bdrv_try_set_read_only()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, stefanha@redhat.com, kwolf@redhat.com

Introduce try function for setting read_only flags.  Will return < 0 on
error, with appropriate Error value set.  Does not alter any flags.

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block.c               | 14 +++++++++++++-
 include/block/block.h |  1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 8bfe7f4..ad958b9 100644
--- a/block.c
+++ b/block.c
@@ -197,7 +197,7 @@ bool bdrv_is_read_only(BlockDriverState *bs)
     return bs->read_only;
 }
 
-int bdrv_set_read_only(BlockDriverState *bs, bool read_only, Error **errp)
+int bdrv_try_set_read_only(BlockDriverState *bs, bool read_only, Error **errp)
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
+    ret = bdrv_try_set_read_only(bs, read_only, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
     bs->read_only = read_only;
     return 0;
 }
diff --git a/include/block/block.h b/include/block/block.h
index beb563a..0049b57 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -426,6 +426,7 @@ int bdrv_is_allocated_above(BlockDriverState *top, BlockDriverState *base,
                             int64_t sector_num, int nb_sectors, int *pnum);
 
 bool bdrv_is_read_only(BlockDriverState *bs);
+int bdrv_try_set_read_only(BlockDriverState *bs, bool read_only, Error **errp);
 int bdrv_set_read_only(BlockDriverState *bs, bool read_only, Error **errp);
 bool bdrv_is_sg(BlockDriverState *bs);
 bool bdrv_is_inserted(BlockDriverState *bs);
-- 
2.9.3
