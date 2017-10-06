Received: from eggs.gnu.org ([2001:4830:134:3::10]:56511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0UyR-0001BG-Jy
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:55:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0UyN-000409-1S
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:55:39 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  6 Oct 2017 17:54:09 +0200
Message-Id: <20171006155422.10135-42-kwolf@redhat.com>
In-Reply-To: <20171006155422.10135-1-kwolf@redhat.com>
References: <20171006155422.10135-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 41/54] block: Add blkdebug hook for copy-on-read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

Make it possible to inject errors on writes performed during a
read operation due to copy-on-read semantics.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json | 5 ++++-
 block/io.c           | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 750bb0c77c..ab96e348e6 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2538,6 +2538,8 @@
 #
 # @l1_shrink_free_l2_clusters: discard the l2 tables. (since 2.11)
 #
+# @cor_write: a write due to copy-on-read (since 2.11)
+#
 # Since: 2.9
 ##
 { 'enum': 'BlkdebugEvent', 'prefix': 'BLKDBG',
@@ -2555,7 +2557,8 @@
             'flush_to_disk', 'pwritev_rmw_head', 'pwritev_rmw_after_head',
             'pwritev_rmw_tail', 'pwritev_rmw_after_tail', 'pwritev',
             'pwritev_zero', 'pwritev_done', 'empty_image_prepare',
-            'l1_shrink_write_table', 'l1_shrink_free_l2_clusters' ] }
+            'l1_shrink_write_table', 'l1_shrink_free_l2_clusters',
+            'cor_write'] }
 
 ##
 # @BlkdebugInjectErrorOptions:
diff --git a/block/io.c b/block/io.c
index 94f74703b7..a5598ed869 100644
--- a/block/io.c
+++ b/block/io.c
@@ -983,6 +983,7 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
         goto err;
     }
 
+    bdrv_debug_event(bs, BLKDBG_COR_WRITE);
     if (drv->bdrv_co_pwrite_zeroes &&
         buffer_is_zero(bounce_buffer, iov.iov_len)) {
         /* FIXME: Should we (perhaps conditionally) be setting
-- 
2.13.6
