Received: from eggs.gnu.org ([2001:4830:134:3::10]:36664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pAH-00025W-0X
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:34:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pAG-0007Az-9a
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:34:01 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 11 May 2017 16:32:29 +0200
Message-Id: <1494513181-7900-27-git-send-email-kwolf@redhat.com>
In-Reply-To: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
References: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 26/58] qcow2: Discard preallocated zero clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

From: Max Reitz <mreitz@redhat.com>

In discard_single_l2(), we completely discard normal clusters instead of
simply turning them into preallocated zero clusters. That means we
should probably do the same with such preallocated zero clusters:
Discard them instead of keeping them allocated.

Reported-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2-cluster.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index fb91fd8..31077d8 100644
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
1.8.3.1
