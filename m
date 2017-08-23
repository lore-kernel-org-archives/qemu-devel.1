Received: from eggs.gnu.org ([2001:4830:134:3::10]:48187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkYbZ-0008Ti-Dz
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:34:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkYbY-0005Rq-Hu
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:34:09 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 23 Aug 2017 11:33:47 -0500
Message-Id: <20170823163349.11663-5-eblake@redhat.com>
In-Reply-To: <20170823163349.11663-1-eblake@redhat.com>
References: <20170823163349.11663-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 4/6] block: Update open_flags after
 ->inactivate() callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

In the ->inactivate() callbacks, permissions are updated, which
typically involves a recursive check of the whole graph. Setting
BDRV_O_INACTIVE right before doing that creates a state that
bdrv_is_writable() returns false, which causes permission update
failure.

Reorder them so the flag is updated after calling the function. Note
that this doesn't break the assert in bdrv_child_cb_inactivate() because
for any specific BDS, we still update its flags first before calling
->inactivate() on it one level deeper in the recursion.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170823134242.12080-5-famz@redhat.com>
Tested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/block.c b/block.c
index 3615a6809e..3308814bba 100644
--- a/block.c
+++ b/block.c
@@ -4085,21 +4085,20 @@ static int bdrv_inactivate_recurse(BlockDriverState *bs,
         }
     }

-    if (setting_flag) {
+    if (setting_flag && !(bs->open_flags & BDRV_O_INACTIVE)) {
         uint64_t perm, shared_perm;

-        bs->open_flags |= BDRV_O_INACTIVE;
-
         QLIST_FOREACH(parent, &bs->parents, next_parent) {
             if (parent->role->inactivate) {
                 ret = parent->role->inactivate(parent);
                 if (ret < 0) {
-                    bs->open_flags &= ~BDRV_O_INACTIVE;
                     return ret;
                 }
             }
         }

+        bs->open_flags |= BDRV_O_INACTIVE;
+
         /* Update permissions, they may differ for inactive nodes */
         bdrv_get_cumulative_perm(bs, &perm, &shared_perm);
         bdrv_check_perm(bs, perm, shared_perm, NULL, &error_abort);
-- 
2.13.5
