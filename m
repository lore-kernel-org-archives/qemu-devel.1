Received: from eggs.gnu.org ([2001:4830:134:3::10]:34240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cvpgY-0006vd-0p
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 14:29:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cvpgT-0002EJ-4L
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 14:29:38 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Wed,  5 Apr 2017 14:28:48 -0400
Message-Id: <abc6320f80ff4af4788fe33b12bb12cbfa83d980.1491416061.git.jcody@redhat.com>
In-Reply-To: <cover.1491416061.git.jcody@redhat.com>
References: <cover.1491416061.git.jcody@redhat.com>
In-Reply-To: <cover.1491416061.git.jcody@redhat.com>
References: <cover.1491416061.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 6/9] block: use
 bdrv_try_set_read_only() during reopen
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

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/block.c b/block.c
index ad958b9..3245fae 100644
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
+    read_only = !(reopen_state->bs->open_flags & BDRV_O_RDWR);
+    ret = bdrv_try_set_read_only(reopen_state->bs, read_only, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
         goto error;
     }
 
-- 
2.9.3
