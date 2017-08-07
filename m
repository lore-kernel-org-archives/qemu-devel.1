Received: from eggs.gnu.org ([2001:4830:134:3::10]:53006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dehHv-0002uC-3P
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:37:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dehHq-0002Rx-3y
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:37:39 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Mon,  7 Aug 2017 15:36:58 +0300
Message-Id: <20170807123658.28772-1-berto@igalia.com>
Subject: [Qemu-devel] [PATCH for-2.10] quorum: Set sectors-count to 0 when
 reporting a flush error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>

The QUORUM_REPORT_BAD event has fields to report the sector in which
the error was detected and the number of affected sectors starting
from that one. This is important for read and write errors, but not
for flush errors.

For flush errors the current code reports the total size of the disk
image. That is however not useful information in this case. Moreover,
the bdrv_getlength() call can fail, and there's no good way of
handling that failure.

Since we're reporting useless information and we cannot even guarantee
to do it in a consistent way, this patch changes the code to report 0
instead in all cases.

Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/quorum.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/quorum.c b/block/quorum.c
index 55ba916655..d04da4f430 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -785,8 +785,7 @@ static coroutine_fn int quorum_co_flush(BlockDriverState *bs)
     for (i = 0; i < s->num_children; i++) {
         result = bdrv_co_flush(s->children[i]->bs);
         if (result) {
-            quorum_report_bad(QUORUM_OP_TYPE_FLUSH, 0,
-                              bdrv_getlength(s->children[i]->bs),
+            quorum_report_bad(QUORUM_OP_TYPE_FLUSH, 0, 0,
                               s->children[i]->bs->node_name, result);
             result_value.l = result;
             quorum_count_vote(&error_votes, &result_value, i);
-- 
2.11.0
