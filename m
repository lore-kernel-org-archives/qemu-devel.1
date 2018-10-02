Received: from eggs.gnu.org ([2001:4830:134:3::10]:41219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g7TwF-0002sN-Tk
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 19:18:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g7Tga-0004DM-9F
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 19:02:37 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue,  2 Oct 2018 19:02:16 -0400
Message-Id: <20181002230218.13949-5-jsnow@redhat.com>
In-Reply-To: <20181002230218.13949-1-jsnow@redhat.com>
References: <20181002230218.13949-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v4 4/6] block/dirty-bitmaps: prohibit
 enable/disable on locked/frozen bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, vsementsov@virtuozzo.com, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

We're not being consistent about this. If it's in use by an operation,
the user should not be able to change the behavior of that bitmap.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockdev.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index cccd36b5e7..d0febfca79 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2058,6 +2058,13 @@ static void block_dirty_bitmap_enable_prepare(BlkActionState *common,
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
@@ -2092,6 +2099,13 @@ static void block_dirty_bitmap_disable_prepare(BlkActionState *common,
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
@@ -2933,10 +2947,10 @@ void qmp_x_block_dirty_bitmap_enable(const char *node, const char *name,
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
 
@@ -2954,10 +2968,10 @@ void qmp_x_block_dirty_bitmap_disable(const char *node, const char *name,
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
2.14.4
