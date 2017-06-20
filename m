Received: from eggs.gnu.org ([2001:4830:134:3::10]:51201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dNInn-0007n7-DL
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 09:02:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dNInj-0000kg-FN
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 09:02:39 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Tue, 20 Jun 2017 16:01:36 +0300
Message-Id: <20170620130136.14557-1-berto@igalia.com>
Subject: [Qemu-devel] [PATCH] qcow2: Use offset_into_cluster() and
 offset_to_l2_index()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>

We already have functions for doing these calculations, so let's use
them instead of doing everything by hand. This makes the code a bit
more readable.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cluster.c | 4 ++--
 block/qcow2.c         | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index d779ea19cf..a2c612433d 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -548,7 +548,7 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, uint64_t offset,
 
     /* find the cluster offset for the given disk offset */
 
-    l2_index = (offset >> s->cluster_bits) & (s->l2_size - 1);
+    l2_index = offset_to_l2_index(s, offset);
     *cluster_offset = be64_to_cpu(l2_table[l2_index]);
 
     nb_clusters = size_to_clusters(s, bytes_needed);
@@ -685,7 +685,7 @@ static int get_cluster_table(BlockDriverState *bs, uint64_t offset,
 
     /* find the cluster offset for the given disk offset */
 
-    l2_index = (offset >> s->cluster_bits) & (s->l2_size - 1);
+    l2_index = offset_to_l2_index(s, offset);
 
     *new_l2_table = l2_table;
     *new_l2_index = l2_index;
diff --git a/block/qcow2.c b/block/qcow2.c
index b3ba5daa93..adb604fc81 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -356,7 +356,7 @@ static int validate_table_offset(BlockDriverState *bs, uint64_t offset,
     }
 
     /* Tables must be cluster aligned */
-    if (offset & (s->cluster_size - 1)) {
+    if (offset_into_cluster(s, offset) != 0) {
         return -EINVAL;
     }
 
-- 
2.11.0
