Received: from eggs.gnu.org ([2001:4830:134:3::10]:42256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1df52E-00007m-ES
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:59:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1df529-0001zh-KL
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:59:02 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  8 Aug 2017 15:58:22 +0200
Message-Id: <20170808135838.11525-3-kwolf@redhat.com>
In-Reply-To: <20170808135838.11525-1-kwolf@redhat.com>
References: <20170808135838.11525-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 02/18] quorum: Set sectors-count to 0 when
 reporting a flush error
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

From: Alberto Garcia <berto@igalia.com>

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
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
2.13.4
