Received: from eggs.gnu.org ([2001:4830:134:3::10]:45291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gHF2Q-0004LF-G2
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gHF2I-0002NG-FH
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1gHF2B-0002JD-9w
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:15 -0400
From: John Snow <jsnow@redhat.com>
Date: Mon, 29 Oct 2018 17:24:55 -0400
Message-Id: <20181029212501.5897-14-jsnow@redhat.com>
In-Reply-To: <20181029212501.5897-1-jsnow@redhat.com>
References: <20181029212501.5897-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 13/19] block/dirty-bitmaps: prohibit
 enable/disable on locked/frozen bitmaps
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

We're not being consistent about this. If it's in use by an operation,
the user should not be able to change the behavior of that bitmap.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20181002230218.13949-5-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockdev.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 8970f699b9..35097b92cc 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2059,6 +2059,13 @@ static void block_dirty_bitmap_enable_prepare(BlkActionState *common,
         return;
     }
 
+    if (bdrv_dirty_bitmap_user_locked(state->bitmap)) {
+        error_setg(errp,
+                   "Bitmap '%s' is currently in use by another operation"
+                   " and cannot be enabled", action->name);
+        return;
+    }
+
     state->was_enabled = bdrv_dirty_bitmap_enabled(state->bitmap);
     bdrv_enable_dirty_bitmap(state->bitmap);
 }
@@ -2093,6 +2100,13 @@ static void block_dirty_bitmap_disable_prepare(BlkActionState *common,
         return;
     }
 
+    if (bdrv_dirty_bitmap_user_locked(state->bitmap)) {
+        error_setg(errp,
+                   "Bitmap '%s' is currently in use by another operation"
+                   " and cannot be disabled", action->name);
+        return;
+    }
+
     state->was_enabled = bdrv_dirty_bitmap_enabled(state->bitmap);
     bdrv_disable_dirty_bitmap(state->bitmap);
 }
@@ -2934,10 +2948,10 @@ void qmp_x_block_dirty_bitmap_enable(const char *node, const char *name,
         return;
     }
 
-    if (bdrv_dirty_bitmap_frozen(bitmap)) {
+    if (bdrv_dirty_bitmap_user_locked(bitmap)) {
         error_setg(errp,
-                   "Bitmap '%s' is currently frozen and cannot be enabled",
-                   name);
+                   "Bitmap '%s' is currently in use by another operation"
+                   " and cannot be enabled", name);
         return;
     }
 
@@ -2955,10 +2969,10 @@ void qmp_x_block_dirty_bitmap_disable(const char *node, const char *name,
         return;
     }
 
-    if (bdrv_dirty_bitmap_frozen(bitmap)) {
+    if (bdrv_dirty_bitmap_user_locked(bitmap)) {
         error_setg(errp,
-                   "Bitmap '%s' is currently frozen and cannot be disabled",
-                   name);
+                   "Bitmap '%s' is currently in use by another operation"
+                   " and cannot be disabled", name);
         return;
     }
 
-- 
2.14.5
