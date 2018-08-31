Received: from eggs.gnu.org ([2001:4830:134:3::10]:57918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fvs0G-0001d2-VF
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 18:34:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fvrus-00079u-L8
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 18:29:23 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri, 31 Aug 2018 18:28:57 -0400
Message-Id: <20180831222907.16257-6-jsnow@redhat.com>
In-Reply-To: <20180831222907.16257-1-jsnow@redhat.com>
References: <20180831222907.16257-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v3 05/15] block/mirror: don't install backing
 chain on abort
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: jtc@redhat.com, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Jeff Cody <jcody@redhat.com>, John Snow <jsnow@redhat.com>

In cases where we abort the block/mirror job, there's no point in
installing the new backing chain before we finish aborting.

Move this to the "success" portion of mirror_exit.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/mirror.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index cba555b4ef..c164fee883 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -642,16 +642,6 @@ static void mirror_exit(Job *job)
      * required before it could become a backing file of target_bs. */
     bdrv_child_try_set_perm(mirror_top_bs->backing, 0, BLK_PERM_ALL,
                             &error_abort);
-    if (s->backing_mode == MIRROR_SOURCE_BACKING_CHAIN) {
-        BlockDriverState *backing = s->is_none_mode ? src : s->base;
-        if (backing_bs(target_bs) != backing) {
-            bdrv_set_backing_hd(target_bs, backing, &local_err);
-            if (local_err) {
-                error_report_err(local_err);
-                ret = -EPERM;
-            }
-        }
-    }
 
     if (s->to_replace) {
         replace_aio_context = bdrv_get_aio_context(s->to_replace);
@@ -659,9 +649,18 @@ static void mirror_exit(Job *job)
     }
 
     if (s->should_complete && ret == 0) {
-        BlockDriverState *to_replace = src;
-        if (s->to_replace) {
-            to_replace = s->to_replace;
+        BlockDriverState *to_replace = s->to_replace ? s->to_replace : src;
+
+        if (s->backing_mode == MIRROR_SOURCE_BACKING_CHAIN) {
+            BlockDriverState *backing = s->is_none_mode ? src : s->base;
+            if (backing_bs(target_bs) != backing) {
+                bdrv_set_backing_hd(target_bs, backing, &local_err);
+                if (local_err) {
+                    error_report_err(local_err);
+                    ret = -EPERM;
+                    goto clean;
+                }
+            }
         }
 
         if (bdrv_get_flags(target_bs) != bdrv_get_flags(to_replace)) {
@@ -678,6 +677,8 @@ static void mirror_exit(Job *job)
             ret = -EPERM;
         }
     }
+
+ clean:
     if (s->to_replace) {
         bdrv_op_unblock_all(s->to_replace, s->replace_blocker);
         error_free(s->replace_blocker);
-- 
2.14.4
