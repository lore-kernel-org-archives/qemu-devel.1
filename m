Received: from eggs.gnu.org ([2001:4830:134:3::10]:51724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dGRom-0000T6-DY
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:15:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dGRoj-0004nU-7q
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:15:20 -0400
Received: from mail-db5eur01on0122.outbound.protection.outlook.com
	([104.47.2.122]:10425
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dGRoi-0004n4-T3
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:15:17 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Thu, 1 Jun 2017 18:14:31 +0300
Message-ID: <1496330073-51338-14-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1496330073-51338-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1496330073-51338-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 13/15] qcow2-cluster: make
 handle_dependencies() logic easier to follow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

Avoid complicated nested conditions; return or continue asap instead.
The logic is not changed.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/qcow2-cluster.c | 45 ++++++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 95e8862..2fa549d 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -926,32 +926,31 @@ static int handle_dependencies(BlockDriverState *bs, uint64_t guest_offset,
 
         if (end <= old_start || start >= old_end) {
             /* No intersection */
-        } else {
-            if (start < old_start) {
-                /* Stop at the start of a running allocation */
-                bytes = old_start - start;
-            } else {
-                bytes = 0;
-            }
+            continue;
+        }
 
-            /* Stop if already an l2meta exists. After yielding, it wouldn't
-             * be valid any more, so we'd have to clean up the old L2Metas
-             * and deal with requests depending on them before starting to
-             * gather new ones. Not worth the trouble. */
-            if (bytes == 0 && *m) {
-                /* start must be cluster aligned at this point */
-                assert(start == start_of_cluster(s, start));
-                *cur_bytes = 0;
-                return 0;
-            }
+        if (start < old_start) {
+            /* Stop at the start of a running allocation */
+            bytes = old_start - start;
+            /* ..if there is no other conflict, keep checking */
+            continue;
+        }
 
-            if (bytes == 0) {
-                /* Wait for the dependency to complete. We need to recheck
-                 * the free/allocated clusters when we continue. */
-                qemu_co_queue_wait(&old_alloc->dependent_requests, &s->lock);
-                return -EAGAIN;
-            }
+        /* Stop if an l2meta already exists. After yielding, it wouldn't
+         * be valid any more, so we'd have to clean up the old L2Metas
+         * and deal with requests depending on them before starting to
+         * gather new ones. Not worth the trouble. */
+        if (*m) {
+            /* start must be cluster aligned at this point */
+            assert(start == start_of_cluster(s, start));
+            *cur_bytes = 0;
+            return 0;
         }
+
+        /* Wait for the dependency to complete. We need to recheck
+         * the free/allocated clusters when we continue. */
+        qemu_co_queue_wait(&old_alloc->dependent_requests, &s->lock);
+        return -EAGAIN;
     }
 
     /* Make sure that existing clusters and new allocations are only used up to
-- 
2.7.4
