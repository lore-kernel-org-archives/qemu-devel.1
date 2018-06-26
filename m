Received: from eggs.gnu.org ([2001:4830:134:3::10]:42837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fXoti-0001op-IK
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 10:24:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fXoth-00031a-Jp
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 10:24:46 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 26 Jun 2018 16:24:29 +0200
Message-Id: <20180626142434.22090-2-kwolf@redhat.com>
In-Reply-To: <20180626142434.22090-1-kwolf@redhat.com>
References: <20180626142434.22090-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/6] qcow2: Fix qcow2_truncate() error
 return value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

If qcow2_alloc_clusters_at() returns an error, we do need to negate it
to get back the positive errno code for error_setg_errno(), but we still
need to return the negative error code.

Fixes: 772d1f973f87269f6a4a4ea4b880680f3779bbdf
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index a3a3aa2a97..6b2e1e1058 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3597,7 +3597,7 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset,
         if (clusters_allocated < 0) {
             error_setg_errno(errp, -clusters_allocated,
                              "Failed to allocate data clusters");
-            return -clusters_allocated;
+            return clusters_allocated;
         }
 
         assert(clusters_allocated == nb_new_data_clusters);
-- 
2.13.6
