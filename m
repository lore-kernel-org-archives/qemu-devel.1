Received: from eggs.gnu.org ([2001:4830:134:3::10]:59674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORM1-0001EX-0g
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORM0-0007hW-3S
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:40 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 23 Jun 2017 18:21:22 +0200
Message-Id: <1498234919-27316-25-git-send-email-kwolf@redhat.com>
In-Reply-To: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
References: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 24/61] qcow2: Use offset_into_cluster() and
 offset_to_l2_index()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Alberto Garcia <berto@igalia.com>

We already have functions for doing these calculations, so let's use
them instead of doing everything by hand. This makes the code a bit
more readable.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2-cluster.c | 4 ++--
 block/qcow2.c         | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 01f2101..3d341fd 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -556,7 +556,7 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, uint64_t offset,
 
     /* find the cluster offset for the given disk offset */
 
-    l2_index = (offset >> s->cluster_bits) & (s->l2_size - 1);
+    l2_index = offset_to_l2_index(s, offset);
     *cluster_offset = be64_to_cpu(l2_table[l2_index]);
 
     nb_clusters = size_to_clusters(s, bytes_needed);
@@ -693,7 +693,7 @@ static int get_cluster_table(BlockDriverState *bs, uint64_t offset,
 
     /* find the cluster offset for the given disk offset */
 
-    l2_index = (offset >> s->cluster_bits) & (s->l2_size - 1);
+    l2_index = offset_to_l2_index(s, offset);
 
     *new_l2_table = l2_table;
     *new_l2_index = l2_index;
diff --git a/block/qcow2.c b/block/qcow2.c
index 328b1d4..088ffe1 100644
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
1.8.3.1
