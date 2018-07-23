Received: from eggs.gnu.org ([2001:4830:134:3::10]:42291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhJp-000352-Df
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:20:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhJo-0004no-Lh
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:20:33 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:17:05 -0500
Message-Id: <20180723201748.25573-57-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 56/99] migration/block-dirty-bitmap: fix memory
 leak in dirty_bitmap_load_bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Eric Blake <eblake@redhat.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Release buf on error path too.

Bug was introduced in b35ebdf076d697bc "migration: add postcopy
migration of dirty bitmaps" with the whole function.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20180427142002.21930-3-vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
CC: qemu-stable@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>
(cherry picked from commit 16a2227893dc1d5cad78ed376ad1d7e300978fbe)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 migration/block-dirty-bitmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index dd04f102d8..8819aabe3a 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -600,6 +600,7 @@ static int dirty_bitmap_load_bits(QEMUFile *f, DirtyBitmapLoadState *s)
         ret = qemu_get_buffer(f, buf, buf_size);
         if (ret != buf_size) {
             error_report("Failed to read bitmap bits");
+            g_free(buf);
             return -EIO;
         }
 
-- 
2.17.1
