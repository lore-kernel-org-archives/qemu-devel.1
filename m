Received: from eggs.gnu.org ([2001:4830:134:3::10]:53122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fxEpl-0004gk-7a
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 13:09:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fxEpk-0001da-8i
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 13:09:45 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue,  4 Sep 2018 13:09:20 -0400
Message-Id: <20180904170930.28619-6-jsnow@redhat.com>
In-Reply-To: <20180904170930.28619-1-jsnow@redhat.com>
References: <20180904170930.28619-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v4 05/15] block/mirror: don't install backing
 chain on abort
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, jtc@redhat.com, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

In cases where we abort the block/mirror job, there's no point in
installing the new backing chain before we finish aborting.

Move this to the "success" portion of mirror_exit.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/mirror.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index cba555b4ef..3365bcfdfb 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -642,7 +642,7 @@ static void mirror_exit(Job *job)
      * required before it could become a backing file of target_bs. */
     bdrv_child_try_set_perm(mirror_top_bs->backing, 0, BLK_PERM_ALL,
                             &error_abort);
-    if (s->backing_mode == MIRROR_SOURCE_BACKING_CHAIN) {
+    if (ret == 0 && s->backing_mode == MIRROR_SOURCE_BACKING_CHAIN) {
         BlockDriverState *backing = s->is_none_mode ? src : s->base;
         if (backing_bs(target_bs) != backing) {
             bdrv_set_backing_hd(target_bs, backing, &local_err);
@@ -659,10 +659,7 @@ static void mirror_exit(Job *job)
     }
 
     if (s->should_complete && ret == 0) {
-        BlockDriverState *to_replace = src;
-        if (s->to_replace) {
-            to_replace = s->to_replace;
-        }
+        BlockDriverState *to_replace = s->to_replace ? s->to_replace : src;
 
         if (bdrv_get_flags(target_bs) != bdrv_get_flags(to_replace)) {
             bdrv_reopen(target_bs, bdrv_get_flags(to_replace), NULL);
-- 
2.14.4
