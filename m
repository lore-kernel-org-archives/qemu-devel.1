Received: from eggs.gnu.org ([2001:4830:134:3::10]:59144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVeA2-0008Vp-Ih
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:28:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVeA1-0001Nq-N2
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:28:06 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 13 Jul 2017 15:27:49 +0200
Message-Id: <1499952476-3454-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1499952476-3454-1-git-send-email-armbru@redhat.com>
References: <1499952476-3454-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 2/9] block: Don't try to set *errp directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

From: Eduardo Habkost <ehabkost@redhat.com>

Assigning directly to *errp is not valid, as errp may be NULL,
&error_fatal, or &error_abort.  Use error_propagate() instead.

With this, there's no need to check if errp is NULL anymore, as
error_propagate() and error_prepend() are able to handle that.

Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20170608133906.12737-3-ehabkost@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/block.c b/block.c
index 6943962..b1599d2 100644
--- a/block.c
+++ b/block.c
@@ -4267,11 +4267,9 @@ bool bdrv_op_is_blocked(BlockDriverState *bs, BlockOpType op, Error **errp)
     assert((int) op >= 0 && op < BLOCK_OP_TYPE_MAX);
     if (!QLIST_EMPTY(&bs->op_blockers[op])) {
         blocker = QLIST_FIRST(&bs->op_blockers[op]);
-        if (errp) {
-            *errp = error_copy(blocker->reason);
-            error_prepend(errp, "Node '%s' is busy: ",
-                          bdrv_get_device_or_node_name(bs));
-        }
+        error_propagate(errp, error_copy(blocker->reason));
+        error_prepend(errp, "Node '%s' is busy: ",
+                      bdrv_get_device_or_node_name(bs));
         return true;
     }
     return false;
-- 
2.7.5
