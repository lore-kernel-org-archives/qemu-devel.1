Received: from eggs.gnu.org ([2001:4830:134:3::10]:45769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dFMGQ-0001Qj-6M
	for qemu-devel@nongnu.org; Mon, 29 May 2017 11:07:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dFMGP-0006Uk-8i
	for qemu-devel@nongnu.org; Mon, 29 May 2017 11:07:22 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 29 May 2017 17:06:52 +0200
Message-Id: <1496070414-6744-14-git-send-email-kwolf@redhat.com>
In-Reply-To: <1496070414-6744-1-git-send-email-kwolf@redhat.com>
References: <1496070414-6744-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 13/15] block: Tweak error message related to
 qemu-img amend
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

From: Eric Blake <eblake@redhat.com>

When converting a 1.1 image down to 0.10, qemu-iotests 060 forces
a contrived failure where allocating a cluster used to replace a
zero cluster reads unaligned data.  Since it is a zero cluster
rather than a data cluster being converted, changing the error
message to match our earlier change in 'qcow2: Make distinction
between zero cluster types obvious' is worthwhile.

Suggested-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-id: 20170508171302.17805-1-eblake@redhat.com
[mreitz: Commit message fixes]
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cluster.c      | 3 ++-
 tests/qemu-iotests/060.out | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 347d94b..d779ea1 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1797,7 +1797,8 @@ static int expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
             }
 
             if (offset_into_cluster(s, offset)) {
-                qcow2_signal_corruption(bs, true, -1, -1, "Data cluster offset "
+                qcow2_signal_corruption(bs, true, -1, -1,
+                                        "Cluster allocation offset "
                                         "%#" PRIx64 " unaligned (L2 offset: %#"
                                         PRIx64 ", L2 index: %#x)", offset,
                                         l2_offset, j);
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index 9e8f5b9..3bc1461 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -143,7 +143,7 @@ read failed: Input/output error
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qcow2: Marking image as corrupt: Data cluster offset 0x52a00 unaligned (L2 offset: 0x40000, L2 index: 0); further corruption events will be suppressed
+qcow2: Marking image as corrupt: Cluster allocation offset 0x52a00 unaligned (L2 offset: 0x40000, L2 index: 0); further corruption events will be suppressed
 qemu-img: Error while amending options: Input/output error
 
 === Testing unaligned reftable entry ===
-- 
1.8.3.1
