Received: from eggs.gnu.org ([2001:4830:134:3::10]:51290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dVzn6-0005aE-Et
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:33:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dVzn5-0003TC-MR
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:33:52 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 14 Jul 2017 15:33:41 +0300
Message-Id: <20170714123341.373857-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH] qcow2-bitmap: fix bitmap_free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, peter.maydell@linaro.org

Fix possible crash on error path in
qcow2_remove_persistent_dirty_bitmap. Although bitmap_free was added in
88ddffae8fc the bug was introduced later in commit 469c71edc72 (when
qcow2_remove_persistent_dirty_bitmap was added).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/qcow2-bitmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 3e8735a20d..e8d3bdbd6e 100644
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
2.11.1
