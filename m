Received: from eggs.gnu.org ([2001:4830:134:3::10]:48310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dBeJg-0006q3-E5
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:35:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dBeJc-0006oP-IJ
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:35:24 -0400
Received: from mail-db5eur01on0105.outbound.protection.outlook.com
	([104.47.2.105]:42544
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dBeJc-0006o5-8m
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:35:20 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Fri, 19 May 2017 12:34:36 +0300
Message-ID: <1495186480-114192-10-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 09/13] qcow2: fix misleading comment about
 L2 linking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/qcow2-cluster.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 25210cd..4204db9 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -827,12 +827,10 @@ int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m)
 
     assert(l2_index + m->nb_clusters <= s->l2_size);
     for (i = 0; i < m->nb_clusters; i++) {
-        /* if two concurrent writes happen to the same unallocated cluster
-         * each write allocates separate cluster and writes data concurrently.
-         * The first one to complete updates l2 table with pointer to its
-         * cluster the second one has to do RMW (which is done above by
-         * perform_cow()), update l2 table with its cluster pointer and free
-         * old cluster. This is what this loop does */
+        /* handle_dependencies() protects from normal cluster allocation
+         * collision; still L2 entry might be !0 in case of zero or compressed
+         * cluster reusage or writing over the snapshot
+         */
         if (l2_table[l2_index + i] != 0) {
             old_cluster[j++] = l2_table[l2_index + i];
         }
-- 
2.7.4
