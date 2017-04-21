Received: from eggs.gnu.org ([2001:4830:134:3::10]:51723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d1Yts-00054s-Bp
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 09:47:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d1Ytr-0002TU-GH
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 09:47:04 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Fri, 21 Apr 2017 09:46:43 -0400
Message-Id: <20170421134644.10239-12-jcody@redhat.com>
In-Reply-To: <20170421134644.10239-1-jcody@redhat.com>
References: <20170421134644.10239-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 11/12] block/rbd: Add support for reopen()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org

This adds support for reopen in rbd, for changing between r/w and r/o.

Note, that this is only a flag change, but we will block a change from
r/o to r/w if we are using an RBD internal snapshot.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: d4e87539167ec6527d44c97b164eabcccf96e4f3.1491597120.git.jcody@redhat.com
---
 block/rbd.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/block/rbd.c b/block/rbd.c
index 35853c9..6471f4f 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -668,6 +668,26 @@ failed_opts:
     return r;
 }
 
+
+/* Since RBD is currently always opened R/W via the API,
+ * we just need to check if we are using a snapshot or not, in
+ * order to determine if we will allow it to be R/W */
+static int qemu_rbd_reopen_prepare(BDRVReopenState *state,
+                                   BlockReopenQueue *queue, Error **errp)
+{
+    BDRVRBDState *s = state->bs->opaque;
+    int ret = 0;
+
+    if (s->snap && state->flags & BDRV_O_RDWR) {
+        error_setg(errp,
+                   "Cannot change node '%s' to r/w when using RBD snapshot",
+                   bdrv_get_device_or_node_name(state->bs));
+        ret = -EINVAL;
+    }
+
+    return ret;
+}
+
 static void qemu_rbd_close(BlockDriverState *bs)
 {
     BDRVRBDState *s = bs->opaque;
@@ -1074,6 +1094,7 @@ static BlockDriver bdrv_rbd = {
     .bdrv_parse_filename    = qemu_rbd_parse_filename,
     .bdrv_file_open         = qemu_rbd_open,
     .bdrv_close             = qemu_rbd_close,
+    .bdrv_reopen_prepare    = qemu_rbd_reopen_prepare,
     .bdrv_create            = qemu_rbd_create,
     .bdrv_has_zero_init     = bdrv_has_zero_init_1,
     .bdrv_get_info          = qemu_rbd_getinfo,
-- 
2.9.3
