Received: from eggs.gnu.org ([2001:4830:134:3::10]:33067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dT9nf-0004nc-7B
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:38:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dT9ne-00060w-D3
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:38:43 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  6 Jul 2017 18:38:19 +0200
Message-Id: <20170706163828.24082-3-pbonzini@redhat.com>
In-Reply-To: <20170706163828.24082-1-pbonzini@redhat.com>
References: <20170706163828.24082-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 02/11] block: make write-threshold thread-safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com

For simplicity, use bdrv_drained_begin/end to avoid concurrent
writes to the write threshold, or reading it while it is being set.
qmp_block_set_write_threshold is protected by the BQL.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/write-threshold.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/block/write-threshold.c b/block/write-threshold.c
index c8ebc32b4d..64ddd3d653 100644
--- a/block/write-threshold.c
+++ b/block/write-threshold.c
@@ -112,7 +112,6 @@ void qmp_block_set_write_threshold(const char *node_name,
                                    Error **errp)
 {
     BlockDriverState *bs;
-    AioContext *aio_context;
 
     bs = bdrv_find_node(node_name);
     if (!bs) {
@@ -120,10 +119,8 @@ void qmp_block_set_write_threshold(const char *node_name,
         return;
     }
 
-    aio_context = bdrv_get_aio_context(bs);
-    aio_context_acquire(aio_context);
-
+    /* Avoid a concurrent write_threshold_disable.  */
+    bdrv_drained_begin(bs);
     bdrv_write_threshold_set(bs, threshold_bytes);
-
-    aio_context_release(aio_context);
+    bdrv_drained_end(bs);
 }
-- 
2.13.0
