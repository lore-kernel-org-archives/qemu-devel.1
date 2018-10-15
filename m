Received: from eggs.gnu.org ([2001:4830:134:3::10]:53276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gC5OF-0008JH-9h
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 12:06:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gC5OA-00053r-Sd
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 12:06:43 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 15 Oct 2018 19:06:25 +0300
Message-Id: <20181015160633.63130-4-vsementsov@virtuozzo.com>
In-Reply-To: <20181015160633.63130-1-vsementsov@virtuozzo.com>
References: <20181015160633.63130-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 03/11] block: allow serialized reads to
 intersect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: famz@redhat.com, stefanha@redhat.com, jcody@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org, eblake@redhat.com

Otherwise, if we have serialized read-part in copy_range from backing
file to its parent if CoW take place, this CoW's sub-reads will
intersect with firstly created serialized read request.

Anyway, reads should not influence on disk view, let's allow them to
intersect.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index bd9d688f8b..d4e46cb3dc 100644
--- a/block/io.c
+++ b/block/io.c
@@ -735,7 +735,8 @@ static bool coroutine_fn wait_serialising_requests(BdrvTrackedRequest *self)
         retry = false;
         qemu_co_mutex_lock(&bs->reqs_lock);
         QLIST_FOREACH(req, &bs->tracked_requests, list) {
-            if (req == self || (!req->serialising && !self->serialising)) {
+            if (req == self || (!req->serialising && !self->serialising) ||
+                (self->type == BDRV_TRACKED_READ && req->type == self->type)) {
                 continue;
             }
             if (tracked_request_overlaps(req, self->overlap_offset,
-- 
2.18.0
