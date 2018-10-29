Received: from eggs.gnu.org ([2001:4830:134:3::10]:45308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gHF2V-0004QV-1G
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gHF2Q-0002Qt-0y
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1gHF2B-0002Im-C8
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:19 -0400
From: John Snow <jsnow@redhat.com>
Date: Mon, 29 Oct 2018 17:24:53 -0400
Message-Id: <20181029212501.5897-12-jsnow@redhat.com>
In-Reply-To: <20181029212501.5897-1-jsnow@redhat.com>
References: <20181029212501.5897-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 11/19] block/dirty-bitmaps: fix merge permissions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, peter.maydell@linaro.org

In prior commits that made merge transactionable, we removed the
assertion that merge cannot operate on disabled bitmaps. In addition,
we want to make sure that we are prohibiting merges to "locked" bitmaps.

Use the new user_locked function to check.

Reported-by: Eric Blake <eblake@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20181002230218.13949-3-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/dirty-bitmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 9603cdd29b..bfccb0ea15 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -806,9 +806,9 @@ void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const BdrvDirtyBitmap *src,
 
     qemu_mutex_lock(dest->mutex);
 
-    if (bdrv_dirty_bitmap_frozen(dest)) {
-        error_setg(errp, "Bitmap '%s' is frozen and cannot be modified",
-                   dest->name);
+    if (bdrv_dirty_bitmap_user_locked(dest)) {
+        error_setg(errp, "Bitmap '%s' is currently in use by another"
+        " operation and cannot be modified", dest->name);
         goto out;
     }
 
-- 
2.14.5
