Received: from eggs.gnu.org ([2001:4830:134:3::10]:46452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1da1Vx-0002Be-O4
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:12:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1da1Vx-0007OA-02
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:12:49 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 25 Jul 2017 17:12:32 +0200
Message-Id: <20170725151233.26077-3-mreitz@redhat.com>
In-Reply-To: <20170725151233.26077-1-mreitz@redhat.com>
References: <20170725151233.26077-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 2/3] qcow2-bitmap: fix bitmap_free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Fix possible crash on error path in
qcow2_remove_persistent_dirty_bitmap. Although bitmap_free was added in
88ddffae8fc the bug was introduced later in commit 469c71edc72 (when
qcow2_remove_persistent_dirty_bitmap was added).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20170714123341.373857-1-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-bitmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 3e8735a..e8d3bdb 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -487,6 +487,10 @@ static inline void bitmap_directory_to_be(uint8_t *dir, size_t size)
 
 static void bitmap_free(Qcow2Bitmap *bm)
 {
+    if (bm == NULL) {
+        return;
+    }
+
     g_free(bm->name);
     g_free(bm);
 }
-- 
2.9.4
