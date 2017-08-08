Received: from eggs.gnu.org ([2001:4830:134:3::10]:42579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1df52W-0000RP-K4
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:59:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1df52R-0002HI-TP
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:59:20 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  8 Aug 2017 15:58:35 +0200
Message-Id: <20170808135838.11525-16-kwolf@redhat.com>
In-Reply-To: <20170808135838.11525-1-kwolf@redhat.com>
References: <20170808135838.11525-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 15/18] block: Set BDRV_O_ALLOW_RDWR during rw
 reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org

Reopening an image should be consistent with opening it, so we should
set BDRV_O_ALLOW_RDWR for any image that is reopened read-write like in
bdrv_open_inherit().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 block.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 2711c3dd3b..3615a6809e 100644
--- a/block.c
+++ b/block.c
@@ -2729,8 +2729,11 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
     bdrv_join_options(bs, options, old_options);
     QDECREF(old_options);
 
-    /* bdrv_open() masks this flag out */
+    /* bdrv_open_inherit() sets and clears some additional flags internally */
     flags &= ~BDRV_O_PROTOCOL;
+    if (flags & BDRV_O_RDWR) {
+        flags |= BDRV_O_ALLOW_RDWR;
+    }
 
     QLIST_FOREACH(child, &bs->children, next) {
         QDict *new_child_options;
-- 
2.13.4
