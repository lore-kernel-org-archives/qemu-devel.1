Received: from eggs.gnu.org ([2001:4830:134:3::10]:42943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eii5K-0007ft-V4
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:49:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eii5J-0000mH-Kp
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:49:31 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Mon,  5 Feb 2018 16:33:31 +0200
Message-Id: <1fd7d272b5e7b66254a090b74cf2bed1cc334c0e.1517840877.git.berto@igalia.com>
In-Reply-To: <cover.1517840876.git.berto@igalia.com>
References: <cover.1517840876.git.berto@igalia.com>
In-Reply-To: <cover.1517840876.git.berto@igalia.com>
References: <cover.1517840876.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v4 31/39] qcow2: Update qcow2_truncate() to
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
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

The qcow2_truncate() code is mostly independent from whether
we're using L2 slices or full L2 tables, but in full and
falloc preallocation modes new L2 tables are allocated using
qcow2_alloc_cluster_link_l2().  Therefore the code needs to be
modified to ensure that all nb_clusters that are processed in each
call can be allocated with just one L2 slice.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 78f067cae7..28050a4b3e 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3260,9 +3260,9 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset,
         host_offset = allocation_start;
         guest_offset = old_length;
         while (nb_new_data_clusters) {
-            int64_t guest_cluster = guest_offset >> s->cluster_bits;
-            int64_t nb_clusters = MIN(nb_new_data_clusters,
-                                      s->l2_size - guest_cluster % s->l2_size);
+            int64_t nb_clusters = MIN(
+                nb_new_data_clusters,
+                s->l2_slice_size - offset_to_l2_slice_index(s, guest_offset));
             QCowL2Meta allocation = {
                 .offset       = guest_offset,
                 .alloc_offset = host_offset,
-- 
2.11.0
