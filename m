Received: from eggs.gnu.org ([2001:4830:134:3::10]:54822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dddI1-0002oP-Dn
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:09:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dddHm-0003gp-0g
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:09:21 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Fri,  4 Aug 2017 17:08:48 +0300
Message-Id: <20170804140848.880-1-berto@igalia.com>
Subject: [Qemu-devel] [PATCH] quorum: Handle bdrv_getlength() failures in
 quorum_co_flush()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, Alberto Garcia <berto@igalia.com>

A bdrv_getlength() call can fail and return a negative value. This
is not being handled in quorum_co_flush(), which can result in a
QUORUM_REPORT_BAD event with an arbitrary value on the 'sectors-count'
field.

Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/quorum.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/quorum.c b/block/quorum.c
index 55ba916655..d77991d680 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -785,8 +785,9 @@ static coroutine_fn int quorum_co_flush(BlockDriverState *bs)
     for (i = 0; i < s->num_children; i++) {
         result = bdrv_co_flush(s->children[i]->bs);
         if (result) {
+            int64_t length = bdrv_getlength(s->children[i]->bs);
             quorum_report_bad(QUORUM_OP_TYPE_FLUSH, 0,
-                              bdrv_getlength(s->children[i]->bs),
+                              length > 0 ? length : 0,
                               s->children[i]->bs->node_name, result);
             result_value.l = result;
             quorum_count_vote(&error_votes, &result_value, i);
-- 
2.11.0
