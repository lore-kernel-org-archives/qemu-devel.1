Received: from eggs.gnu.org ([2001:4830:134:3::10]:40786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fC4EN-0003p2-Os
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 10:20:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fC4EI-0003g8-92
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 10:20:11 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 27 Apr 2018 17:20:02 +0300
Message-Id: <20180427142002.21930-3-vsementsov@virtuozzo.com>
In-Reply-To: <20180427142002.21930-1-vsementsov@virtuozzo.com>
References: <20180427142002.21930-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 2/2] migration/block-dirty-bitmap: fix memory
 leak in dirty_bitmap_load_bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org
Cc: eblake@redhat.com, pbonzini@redhat.com, dgilbert@redhat.com, quintela@redhat.com, famz@redhat.com, stefanha@redhat.com, vsementsov@virtuozzo.com, den@openvz.org, peter.maydell@linaro.org

Release buf on error path too.

Bug was introduced in b35ebdf076d697bc "migration: add postcopy
migration of dirty bitmaps" with the whole function.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
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
2.11.1
