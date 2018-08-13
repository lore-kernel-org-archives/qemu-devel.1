Received: from eggs.gnu.org ([2001:4830:134:3::10]:44551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fp1Lj-0007fQ-1c
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 21:08:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fp1Lf-0001ip-Ug
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 21:08:46 -0400
From: Leonid Bloch <lbloch@janustech.com>
Date: Mon, 13 Aug 2018 04:07:24 +0300
Message-Id: <20180813010729.4844-4-lbloch@janustech.com>
In-Reply-To: <20180813010729.4844-1-lbloch@janustech.com>
References: <20180813010729.4844-1-lbloch@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v8 3/8] qcow2: Avoid duplication in setting the
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
 block/qcow2.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 67cc82f0b9..7949d15fc6 100644
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
2.17.1
