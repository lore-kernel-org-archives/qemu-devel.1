Received: from eggs.gnu.org ([2001:4830:134:3::10]:36605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pAF-0001yP-0P
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:34:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pAB-00075g-2S
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:33:59 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 11 May 2017 16:32:27 +0200
Message-Id: <1494513181-7900-25-git-send-email-kwolf@redhat.com>
In-Reply-To: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
References: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 24/58] qcow2: Fix preallocation size formula
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

When calculating the number of reftable entries, we should actually use
the number of refblocks and not (wrongly[1]) re-calculate it.

[1] "Wrongly" means: Dividing the number of clusters by the number of
    entries per refblock and rounding down instead of up.

Reported-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 1c26977..8caf800 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2139,7 +2139,7 @@ static int qcow2_create2(const char *filename, int64_t total_size,
          * too, as long as the bulk is allocated here). Therefore, using
          * floating point arithmetic is fine. */
         int64_t meta_size = 0;
-        uint64_t nreftablee, nrefblocke, nl1e, nl2e;
+        uint64_t nreftablee, nrefblocke, nl1e, nl2e, refblock_count;
         int64_t aligned_total_size = align_offset(total_size, cluster_size);
         int refblock_bits, refblock_size;
         /* refcount entry size in bytes */
@@ -2182,11 +2182,12 @@ static int qcow2_create2(const char *filename, int64_t total_size,
         nrefblocke = (aligned_total_size + meta_size + cluster_size)
                    / (cluster_size - rces - rces * sizeof(uint64_t)
                                                  / cluster_size);
-        meta_size += DIV_ROUND_UP(nrefblocke, refblock_size) * cluster_size;
+        refblock_count = DIV_ROUND_UP(nrefblocke, refblock_size);
+        meta_size += refblock_count * cluster_size;
 
         /* total size of refcount tables */
-        nreftablee = nrefblocke / refblock_size;
-        nreftablee = align_offset(nreftablee, cluster_size / sizeof(uint64_t));
+        nreftablee = align_offset(refblock_count,
+                                  cluster_size / sizeof(uint64_t));
         meta_size += nreftablee * sizeof(uint64_t);
 
         qemu_opt_set_number(opts, BLOCK_OPT_SIZE,
-- 
1.8.3.1
