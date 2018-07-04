Received: from eggs.gnu.org ([2001:4830:134:3::10]:48923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fab2v-0004b6-2J
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 02:13:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fab2u-0002oL-9A
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 02:13:45 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed,  4 Jul 2018 14:13:19 +0800
Message-Id: <20180704061320.2041-2-famz@redhat.com>
In-Reply-To: <20180704061320.2041-1-famz@redhat.com>
References: <20180704061320.2041-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] block: Fix dst total_sectors after copy
 offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This was noticed by the new image fleecing tests case 222. The issue is
apparent and we should just do the same right things as in
bdrv_aligned_pwritev.

Reported-by: John Snow <jsnow@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/io.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/io.c b/block/io.c
index 1a2272fad3..8e02f4ab95 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2945,6 +2945,10 @@ static int coroutine_fn bdrv_co_copy_range_internal(BdrvChild *src,
                                                   dst, dst_offset,
                                                   bytes, flags);
     }
+    if (ret == 0) {
+        int64_t end_sector = DIV_ROUND_UP(dst_offset + bytes, BDRV_SECTOR_SIZE);
+        dst->bs->total_sectors = MAX(dst->bs->total_sectors, end_sector);
+    }
     tracked_request_end(&src_req);
     tracked_request_end(&dst_req);
     bdrv_dec_in_flight(src->bs);
-- 
2.17.1
