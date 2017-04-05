Received: from eggs.gnu.org ([2001:4830:134:3::10]:34378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cvpgr-0007Bs-HT
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 14:30:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cvpgm-0002KK-8o
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 14:29:53 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Wed,  5 Apr 2017 14:28:50 -0400
Message-Id: <613303fd54633f005eeea485e32f590994eb299f.1491416061.git.jcody@redhat.com>
In-Reply-To: <cover.1491416061.git.jcody@redhat.com>
References: <cover.1491416061.git.jcody@redhat.com>
In-Reply-To: <cover.1491416061.git.jcody@redhat.com>
References: <cover.1491416061.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 8/9] block/rbd: do not blindly set
 bs->read_only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, stefanha@redhat.com, kwolf@redhat.com

We do not want to just blindly set bs->read_only.  The only time
we need to set it with the current rbd driver, is if we are using an
rbd snapshot.  In that case, we must set it to read-only.

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/rbd.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index c5e1aeb..35853c9 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -635,6 +635,7 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
         goto failed_shutdown;
     }
 
+    /* rbd_open is always r/w */
     r = rbd_open(s->io_ctx, s->image_name, &s->image, s->snap);
     if (r < 0) {
         error_setg_errno(errp, -r, "error reading header from %s",
@@ -642,10 +643,14 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
         goto failed_open;
     }
 
-    r = bdrv_set_read_only(bs, (s->snap != NULL), &local_err);
-    if (r < 0) {
-        error_propagate(errp, local_err);
-        goto failed_open;
+    /* If we are using an rbd snapshot, we must be r/o, otherwise
+     * leave as-is */
+    if (s->snap != NULL) {
+        r = bdrv_set_read_only(bs, true, &local_err);
+        if (r < 0) {
+            error_propagate(errp, local_err);
+            goto failed_open;
+        }
     }
 
     qemu_opts_del(opts);
-- 
2.9.3
