Received: from eggs.gnu.org ([2001:4830:134:3::10]:55443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVF-0000Wa-V2
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVC-0003IB-N2
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:13 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 15 Dec 2017 13:53:54 +0100
Message-Id: <43f6f21c8f42204c23efce2755d6f53272ebb51a.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 26/32] qcow2: Update qcow2_truncate() to
 support L2 slices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>

The qcow2_truncate() code is mostly independent from whether
we're using L2 slices or full L2 tables, but in full and
falloc preallocation modes new L2 tables are allocated using
qcow2_alloc_cluster_link_l2().  Therefore the code needs to be
modified to ensure that all nb_clusters that are processed in each
call can be allocated with just one L2 slice.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index c1e4bab391..38c2ccf210 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3288,8 +3288,9 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset,
         guest_offset = old_length;
         while (nb_new_data_clusters) {
             int64_t guest_cluster = guest_offset >> s->cluster_bits;
-            int64_t nb_clusters = MIN(nb_new_data_clusters,
-                                      s->l2_size - guest_cluster % s->l2_size);
+            int64_t nb_clusters = MIN(
+                nb_new_data_clusters,
+                s->l2_slice_size - guest_cluster % s->l2_slice_size);
             QCowL2Meta allocation = {
                 .offset       = guest_offset,
                 .alloc_offset = host_offset,
-- 
2.11.0
