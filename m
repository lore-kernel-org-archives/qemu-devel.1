Received: from eggs.gnu.org ([2001:4830:134:3::10]:46694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d2jX5-0001fO-Sr
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 15:20:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d2jX5-0002nu-1r
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 15:20:23 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Mon, 24 Apr 2017 15:19:59 -0400
Message-Id: <20170424192002.18622-10-jcody@redhat.com>
In-Reply-To: <20170424192002.18622-1-jcody@redhat.com>
References: <20170424192002.18622-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL v2 09/12] block: use bdrv_can_set_read_only()
 during reopen
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

Signed-off-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 00aed7ffdd7be4b9ed9ce1007d50028a72b34ebe.1491597120.git.jcody@redhat.com
---
 block.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/block.c b/block.c
index 1ac05c1..5db266b 100644
--- a/block.c
+++ b/block.c
@@ -2789,6 +2789,7 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
     BlockDriver *drv;
     QemuOpts *opts;
     const char *value;
+    bool read_only;
 
     assert(reopen_state != NULL);
     assert(reopen_state->bs->drv != NULL);
@@ -2817,12 +2818,13 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
         qdict_put(reopen_state->options, "driver", qstring_from_str(value));
     }
 
-    /* if we are to stay read-only, do not allow permission change
-     * to r/w */
-    if (!(reopen_state->bs->open_flags & BDRV_O_ALLOW_RDWR) &&
-        reopen_state->flags & BDRV_O_RDWR) {
-        error_setg(errp, "Node '%s' is read only",
-                   bdrv_get_device_or_node_name(reopen_state->bs));
+    /* If we are to stay read-only, do not allow permission change
+     * to r/w. Attempting to set to r/w may fail if either BDRV_O_ALLOW_RDWR is
+     * not set, or if the BDS still has copy_on_read enabled */
+    read_only = !(reopen_state->flags & BDRV_O_RDWR);
+    ret = bdrv_can_set_read_only(reopen_state->bs, read_only, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
         goto error;
     }
 
-- 
2.9.3
