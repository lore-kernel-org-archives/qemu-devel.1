Received: from eggs.gnu.org ([2001:4830:134:3::10]:57858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g71rC-0002Vl-SJ
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 13:19:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g71rB-0007JE-J3
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 13:19:42 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  1 Oct 2018 19:18:52 +0200
Message-Id: <20181001171901.11004-15-kwolf@redhat.com>
In-Reply-To: <20181001171901.11004-1-kwolf@redhat.com>
References: <20181001171901.11004-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 14/23] qcow2: Avoid duplication in setting the
 refcount cache size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Leonid Bloch <lbloch@janustech.com>

The refcount cache size does not need to be set to its minimum value in
read_cache_sizes(), as it is set to at least its minimum value in
qcow2_update_options_prepare().

Signed-off-by: Leonid Bloch <lbloch@janustech.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index d2c07ce9fe..cd0053b6ee 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -834,10 +834,9 @@ static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
                                  (uint64_t)DEFAULT_L2_CACHE_CLUSTERS
                                  * s->cluster_size);
         }
-        if (!refcount_cache_size_set) {
-            *refcount_cache_size = min_refcount_cache;
-        }
     }
+    /* l2_cache_size and refcount_cache_size are ensured to have at least
+     * their minimum values in qcow2_update_options_prepare() */
 
     if (*l2_cache_entry_size < (1 << MIN_CLUSTER_BITS) ||
         *l2_cache_entry_size > s->cluster_size ||
-- 
2.13.6
