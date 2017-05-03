Received: from eggs.gnu.org ([2001:4830:134:3::10]:59830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d63Qp-00023S-Kn
	for qemu-devel@nongnu.org; Wed, 03 May 2017 19:11:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d63Qo-000617-7U
	for qemu-devel@nongnu.org; Wed, 03 May 2017 19:11:39 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Thu,  4 May 2017 01:11:19 +0200
Message-Id: <20170503231120.23507-4-mreitz@redhat.com>
In-Reply-To: <20170503231120.23507-1-mreitz@redhat.com>
References: <20170503231120.23507-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] qcow2: Discard preallocated zero clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>

In discard_single_l2(), we completely discard normal clusters instead of
simply turning them into preallocated zero clusters. That means we
should probably do the same with such preallocated zero clusters:
Discard them instead of keeping them allocated.

Reported-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cluster.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index fb91fd8979..31077d8102 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1511,7 +1511,8 @@ static int discard_single_l2(BlockDriverState *bs, uint64_t offset,
                 break;
 
             case QCOW2_CLUSTER_ZERO:
-                if (!full_discard) {
+                /* Preallocated zero clusters should be discarded in any case */
+                if (!full_discard && (old_l2_entry & L2E_OFFSET_MASK) == 0) {
                     continue;
                 }
                 break;
-- 
2.12.2
