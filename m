Received: from eggs.gnu.org ([2001:4830:134:3::10]:48551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1f3kjN-0001hK-VT
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 11:53:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1f3kjN-0004Nh-64
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 11:53:50 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Wed,  4 Apr 2018 11:53:31 -0400
Message-Id: <78bd072951c71d940c8efaa5c0486342239ea996.1522857106.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12] block/rbd: remove processed options
 from qdict
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

Commit 4bfb274 added some QAPIfication of option parsing in
qemu_rbd_open().  We need to remove all the options we processed,
otherwise in bdrv_open_inherit() we will think the remaining options are
invalid.

(This needs to go in 2.12 to avoid a regression that prevents rbd
from being opened.)

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/rbd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/rbd.c b/block/rbd.c
index 5b64849dc6..c9359d0ad8 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -623,6 +623,7 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
     BlockdevOptionsRbd *opts = NULL;
     Visitor *v;
     QObject *crumpled = NULL;
+    const QDictEntry *e;
     Error *local_err = NULL;
     const char *filename;
     char *keypairs, *secretid;
@@ -671,6 +672,12 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
         goto out;
     }
 
+    /* Remove the processed options from the QDict (the visitor processes
+     * _all_ options in the QDict) */
+    while ((e = qdict_first(options))) {
+        qdict_del(options, e->key);
+    }
+
     r = qemu_rbd_connect(&s->cluster, &s->io_ctx, opts,
                          !(flags & BDRV_O_NOCACHE), keypairs, secretid, errp);
     if (r < 0) {
-- 
2.13.6
