Received: from eggs.gnu.org ([2001:4830:134:3::10]:49419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fo0tX-0006qM-Cv
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 02:27:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fo0tU-0001f7-NV
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 02:27:31 -0400
From: Leonid Bloch <lbloch@janustech.com>
Date: Fri, 10 Aug 2018 09:26:42 +0300
Message-Id: <20180810062647.23211-5-lbloch@janustech.com>
In-Reply-To: <20180810062647.23211-1-lbloch@janustech.com>
References: <20180810062647.23211-1-lbloch@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v7 4/9] qcow2: Avoid duplication in setting the
 refcount cache size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>, Leonid Bloch <lbloch@janustech.com>

The refcount cache size does not need to be set to its minimum value in
read_cache_sizes(), as it is set to at least its minimum value in
qcow2_update_options_prepare().

Signed-off-by: Leonid Bloch <lbloch@janustech.com>
---
 block/qcow2.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 7a2d7a1d48..053242f94e 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -829,16 +829,13 @@ static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
                 *l2_cache_size = combined_cache_size - *refcount_cache_size;
             }
         }
-    } else {
-        if (!l2_cache_size_set) {
-            *l2_cache_size = MAX(DEFAULT_L2_CACHE_SIZE,
-                                 (uint64_t)DEFAULT_L2_CACHE_CLUSTERS
-                                 * s->cluster_size);
-        }
-        if (!refcount_cache_size_set) {
-            *refcount_cache_size = min_refcount_cache;
-        }
+    } else if (!l2_cache_size_set) {
+        *l2_cache_size = MAX(DEFAULT_L2_CACHE_SIZE,
+                             (uint64_t)DEFAULT_L2_CACHE_CLUSTERS
+                             * s->cluster_size);
     }
+    /* If refcount-cache-size is not specified, it will be set to minimum
+     * in qcow2_update_options_prepare(). No need to set it here. */
 
     if (*l2_cache_entry_size < (1 << MIN_CLUSTER_BITS) ||
         *l2_cache_entry_size > s->cluster_size ||
-- 
2.17.1
