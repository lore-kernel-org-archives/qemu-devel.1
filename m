Received: from eggs.gnu.org ([2001:4830:134:3::10]:55977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dyNpt-0007Ay-Bl
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 15:54:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dyNpo-00077J-WD
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 15:54:05 -0400
From: Eric Blake <eblake@redhat.com>
Date: Sat, 30 Sep 2017 14:53:43 -0500
Message-Id: <20170930195345.23338-3-eblake@redhat.com>
In-Reply-To: <20170930195345.23338-1-eblake@redhat.com>
References: <20170930195345.23338-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 2/4] block: Add blkdebug hook for copy-on-read
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, kwolf@redhat.com, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>
List-ID: <qemu-devel.nongnu.org>

Make it possible to inject errors on writes performed during a
read operation due to copy-on-read semantics.

Signed-off-by: Eric Blake <eblake@redhat.com>
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
index d633b0f851..97d9fa655d 100644
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
