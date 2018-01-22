Received: from eggs.gnu.org ([2001:4830:134:3::10]:56021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1edkID-0007GW-9X
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 17:10:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1edkIC-00049d-Av
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 17:10:17 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 22 Jan 2018 23:08:02 +0100
Message-Id: <20180122220806.22154-13-mreitz@redhat.com>
In-Reply-To: <20180122220806.22154-1-mreitz@redhat.com>
References: <20180122220806.22154-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 12/16] block/mirror: Distinguish active from
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Currently, the mirror block job only knows passive operations.  But once
we introduce active writes, we need to distinguish between the two; for
example, mirror_wait_for_free_in_flight_slot() should wait for a passive
operation because active writes will not use the same in-flight slots.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/mirror.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 2363e79563..bb46f3c4e9 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -89,6 +89,7 @@ struct MirrorOp {
     int64_t *bytes_handled;
 
     bool is_pseudo_op;
+    bool is_active_write;
     CoQueue waiting_requests;
 
     QTAILQ_ENTRY(MirrorOp) next;
@@ -281,8 +282,10 @@ static inline void mirror_wait_for_free_in_flight_slot(MirrorBlockJob *s)
          * some other operation to start, which may in fact be the
          * caller of this function.  Since there is only one pseudo op
          * at any given time, we will always find some real operation
-         * to wait on. */
-        if (!op->is_pseudo_op) {
+         * to wait on.
+         * Also, only non-active operations use up in-flight slots, so
+         * we can ignore active operations. */
+        if (!op->is_pseudo_op && !op->is_active_write) {
             qemu_co_queue_wait(&op->waiting_requests, NULL);
             return;
         }
-- 
2.14.3
