Received: from eggs.gnu.org ([2001:4830:134:3::10]:50569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cwavF-00066J-7E
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 16:55:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cwavE-0003TH-DT
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 16:55:57 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Fri,  7 Apr 2017 16:55:30 -0400
Message-Id: <00aed7ffdd7be4b9ed9ce1007d50028a72b34ebe.1491597120.git.jcody@redhat.com>
In-Reply-To: <cover.1491597120.git.jcody@redhat.com>
References: <cover.1491597120.git.jcody@redhat.com>
In-Reply-To: <cover.1491597120.git.jcody@redhat.com>
References: <cover.1491597120.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.10 6/8] block: use
 bdrv_can_set_read_only() during reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, kwolf@redhat.com, jsnow@redhat.com, eblake@redhat.com

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/block.c b/block.c
index 1514ae9..5d560f5 100644
--- a/block.c
+++ b/block.c
@@ -2785,6 +2785,7 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
     BlockDriver *drv;
     QemuOpts *opts;
     const char *value;
+    bool read_only;
 
     assert(reopen_state != NULL);
     assert(reopen_state->bs->drv != NULL);
@@ -2813,12 +2814,13 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
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
