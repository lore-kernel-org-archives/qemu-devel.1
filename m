Received: from eggs.gnu.org ([2001:4830:134:3::10]:33230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dT9np-0004yD-C4
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:38:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dT9no-00067C-Cu
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:38:53 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  6 Jul 2017 18:38:24 +0200
Message-Id: <20170706163828.24082-8-pbonzini@redhat.com>
In-Reply-To: <20170706163828.24082-1-pbonzini@redhat.com>
References: <20170706163828.24082-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 07/11] block: do not acquire AioContext in
 check_to_replace_node
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

The only caller does it already.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/block.c b/block.c
index 694396281b..af0a9a1c22 100644
--- a/block.c
+++ b/block.c
@@ -4701,23 +4701,19 @@ bool bdrv_is_first_non_filter(BlockDriverState *candidate)
     return false;
 }
 
+/* Called with AioContext lock held.  */
 BlockDriverState *check_to_replace_node(BlockDriverState *parent_bs,
                                         const char *node_name, Error **errp)
 {
     BlockDriverState *to_replace_bs = bdrv_find_node(node_name);
-    AioContext *aio_context;
 
     if (!to_replace_bs) {
         error_setg(errp, "Node name '%s' not found", node_name);
         return NULL;
     }
 
-    aio_context = bdrv_get_aio_context(to_replace_bs);
-    aio_context_acquire(aio_context);
-
     if (bdrv_op_is_blocked(to_replace_bs, BLOCK_OP_TYPE_REPLACE, errp)) {
-        to_replace_bs = NULL;
-        goto out;
+        return NULL;
     }
 
     /* We don't want arbitrary node of the BDS chain to be replaced only the top
@@ -4727,12 +4723,9 @@ BlockDriverState *check_to_replace_node(BlockDriverState *parent_bs,
      */
     if (!bdrv_recurse_is_first_non_filter(parent_bs, to_replace_bs)) {
         error_setg(errp, "Only top most non filter can be replaced");
-        to_replace_bs = NULL;
-        goto out;
+        return NULL;
     }
 
-out:
-    aio_context_release(aio_context);
     return to_replace_bs;
 }
 
-- 
2.13.0
