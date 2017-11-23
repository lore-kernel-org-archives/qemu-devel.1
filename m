Received: from eggs.gnu.org ([2001:4830:134:3::10]:54901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eHvlh-0007Tg-Eq
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 12:58:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eHvlg-0007Gw-Az
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 12:58:33 -0500
From: Fam Zheng <famz@redhat.com>
Date: Fri, 24 Nov 2017 01:57:47 +0800
Message-Id: <20171123175747.2309-2-famz@redhat.com>
In-Reply-To: <20171123175747.2309-1-famz@redhat.com>
References: <20171123175747.2309-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 1/1] block: Don't poll for drain end
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, pbonzini@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, jcody@redhat.com

Only drained_begin cares about in flight requests are processed, there
is no need to do BDRV_POLL_WHILE() if begin==false, because all that
need to be done is recursively invoking children's callbacks.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/io.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/io.c b/block/io.c
index 4fdf93a014..55256c130b 100644
--- a/block/io.c
+++ b/block/io.c
@@ -192,13 +192,15 @@ static void bdrv_drain_invoke(BlockDriverState *bs, bool begin)
 static bool bdrv_drain_recurse(BlockDriverState *bs, bool begin)
 {
     BdrvChild *child, *tmp;
-    bool waited;
+    bool waited = false;
 
     /* Ensure any pending metadata writes are submitted to bs->file.  */
     bdrv_drain_invoke(bs, begin);
 
-    /* Wait for drained requests to finish */
-    waited = BDRV_POLL_WHILE(bs, atomic_read(&bs->in_flight) > 0);
+    if (begin) {
+        /* Wait for drained requests to finish */
+        waited = BDRV_POLL_WHILE(bs, atomic_read(&bs->in_flight) > 0);
+    }
 
     QLIST_FOREACH_SAFE(child, &bs->children, next, tmp) {
         BlockDriverState *bs = child->bs;
-- 
2.14.3
