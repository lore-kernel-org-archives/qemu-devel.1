Received: from eggs.gnu.org ([2001:4830:134:3::10]:38291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1f5vmZ-0002Tn-4V
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 12:06:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1f5vmV-0003vT-01
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 12:06:07 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Tue, 10 Apr 2018 18:05:03 +0200
Message-Id: <0f687957feb72e80c740403191a47e607c2463fe.1523376013.git.berto@igalia.com>
In-Reply-To: <cover.1523376013.git.berto@igalia.com>
References: <cover.1523376013.git.berto@igalia.com>
In-Reply-To: <cover.1523376013.git.berto@igalia.com>
References: <cover.1523376013.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 1/2] Fix error message about compressed
 clusters with OFLAG_COPIED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Compressed clusters are not supposed to have the COPIED bit set.
"qemu-img check" detects that and prints an error message reporting
the number of the affected host cluster. This doesn't make much sense
because compressed clusters are not aligned to host clusters, so it
would be better to report the offset instead. Plus, the calculation is
wrong and it uses the raw L2 entry as if it was simply an offset.

This patch fixes the error message and reports the offset of the
compressed cluster.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-refcount.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 6b8b63514a..2dc23005b7 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1577,9 +1577,9 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
         case QCOW2_CLUSTER_COMPRESSED:
             /* Compressed clusters don't have QCOW_OFLAG_COPIED */
             if (l2_entry & QCOW_OFLAG_COPIED) {
-                fprintf(stderr, "ERROR: cluster %" PRId64 ": "
+                fprintf(stderr, "ERROR: coffset=0x%" PRIx64 ": "
                     "copied flag must never be set for compressed "
-                    "clusters\n", l2_entry >> s->cluster_bits);
+                    "clusters\n", l2_entry & s->cluster_offset_mask);
                 l2_entry &= ~QCOW_OFLAG_COPIED;
                 res->corruptions++;
             }
-- 
2.11.0
