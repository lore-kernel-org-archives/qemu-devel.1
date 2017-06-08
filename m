Received: from eggs.gnu.org ([2001:4830:134:3::10]:46844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dIxek-0001ha-Gd
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:39:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dIxei-0005TU-Mf
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:39:22 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu,  8 Jun 2017 10:39:03 -0300
Message-Id: <20170608133906.12737-3-ehabkost@redhat.com>
In-Reply-To: <20170608133906.12737-1-ehabkost@redhat.com>
References: <20170608133906.12737-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 2/5] block: Don't try to set *errp directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Assigning directly to *errp is not valid, as errp may be NULL,
&error_fatal, or &error_abort.  Use error_propagate() instead.

With this, there's no need to check if errp is NULL anymore, as
error_propagate() and error_prepend() are able to handle that.

Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 block.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/block.c b/block.c
index fa1d06d846..1750a1838e 100644
--- a/block.c
+++ b/block.c
@@ -4263,11 +4263,9 @@ bool bdrv_op_is_blocked(BlockDriverState *bs, BlockOpType op, Error **errp)
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
2.11.0.259.g40922b1
