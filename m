Received: from eggs.gnu.org ([2001:4830:134:3::10]:59392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i44-0001GB-LY
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:19:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i41-0002ei-SJ
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:19:16 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 26 Oct 2017 15:17:39 +0200
Message-Id: <20171026131741.5059-34-kwolf@redhat.com>
In-Reply-To: <20171026131741.5059-1-kwolf@redhat.com>
References: <20171026131741.5059-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 33/35] qcow2: Fix unaligned preallocated
 truncation
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

From: Max Reitz <mreitz@redhat.com>

A qcow2 image file's length is not required to have a length that is a
multiple of the cluster size.  However, qcow2_refcount_area() expects an
aligned value for its @start_offset parameter, so we need to round
@old_file_size up to the next cluster boundary.

Reported-by: Ping Li <pingl@redhat.com>
Bug: https://bugzilla.redhat.com/show_bug.cgi?id=1414049
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20171009215533.12530-2-mreitz@redhat.com
Cc: qemu-stable@nongnu.org
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index d3e114bce5..1ea763126d 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3188,6 +3188,7 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset,
                              "Failed to inquire current file length");
             return old_file_size;
         }
+        old_file_size = ROUND_UP(old_file_size, s->cluster_size);
 
         nb_new_data_clusters = DIV_ROUND_UP(offset - old_length,
                                             s->cluster_size);
-- 
2.13.6
