Received: from eggs.gnu.org ([2001:4830:134:3::10]:37635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dsCIC-0000zr-Ey
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 14:21:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dsCIB-0006PQ-J4
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 14:21:44 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 13 Sep 2017 20:19:06 +0200
Message-Id: <20170913181910.29688-15-mreitz@redhat.com>
In-Reply-To: <20170913181910.29688-1-mreitz@redhat.com>
References: <20170913181910.29688-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 14/18] block/mirror: Distinguish active from
 passive ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

Currently, the mirror block job only knows passive operations.  But once
we introduce active writes, we need to distinguish between the two; for
example, mirror_wait_for_free_in_flight_slot() should wait for a passive
operation because active writes will not use the same in-flight slots.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/mirror.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 612fab660e..8fea619a68 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -96,6 +96,7 @@ struct MirrorOp {
     /* Set by mirror_co_read() before yielding for the first time */
     uint64_t bytes_copied;
 
+    bool is_active_write;
     CoQueue waiting_requests;
 
     QTAILQ_ENTRY(MirrorOp) next;
@@ -286,9 +287,14 @@ static inline void mirror_wait_for_free_in_flight_slot(MirrorBlockJob *s)
 {
     MirrorOp *op;
 
-    op = QTAILQ_FIRST(&s->ops_in_flight);
-    assert(op);
-    qemu_co_queue_wait(&op->waiting_requests, NULL);
+    QTAILQ_FOREACH(op, &s->ops_in_flight, next) {
+        if (!op->is_active_write) {
+            /* Only non-active operations use up in-flight slots */
+            qemu_co_queue_wait(&op->waiting_requests, NULL);
+            return;
+        }
+    }
+    abort();
 }
 
 /* Submit async read while handling COW.
-- 
2.13.5
