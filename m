Received: from eggs.gnu.org ([2001:4830:134:3::10]:44122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fEanR-0006yh-H7
	for qemu-devel@nongnu.org; Fri, 04 May 2018 09:30:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fEanM-0003MX-Tk
	for qemu-devel@nongnu.org; Fri, 04 May 2018 09:30:49 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri,  4 May 2018 08:30:32 -0500
Message-Id: <20180504133034.1328397-3-eblake@redhat.com>
In-Reply-To: <20180504133034.1328397-1-eblake@redhat.com>
References: <20180504133034.1328397-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 2/4] migration/block-dirty-bitmap: fix memory
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "open list:Block I/O path" <qemu-block@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Release buf on error path too.

Bug was introduced in b35ebdf076d697bc "migration: add postcopy
migration of dirty bitmaps" with the whole function.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20180427142002.21930-3-vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
CC: qemu-stable@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 migration/block-dirty-bitmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index dd04f102d8d..8819aabe3a0 100644
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
2.14.3
