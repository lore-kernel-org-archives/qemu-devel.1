Received: from eggs.gnu.org ([2001:4830:134:3::10]:57794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g71rB-0002UI-Lg
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 13:19:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g71r9-0007Gm-VN
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 13:19:41 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  1 Oct 2018 19:18:47 +0200
Message-Id: <20181001171901.11004-10-kwolf@redhat.com>
In-Reply-To: <20181001171901.11004-1-kwolf@redhat.com>
References: <20181001171901.11004-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 09/23] block: Allow changing 'discard' on reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Alberto Garcia <berto@igalia.com>

'discard' is one of the basic BlockdevOptions available for all
drivers, but it's not handled by bdrv_reopen_prepare() so any attempt
to change it results in an error:

   (qemu) qemu-io virtio0 "reopen -o discard=on"
   Cannot change the option 'discard'

Since there's no reason why we shouldn't allow changing it and the
implementation is simple let's just do it.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/block.c b/block.c
index e36ae3e8d1..7fb267bd1f 100644
--- a/block.c
+++ b/block.c
@@ -3156,6 +3156,7 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
     BlockDriver *drv;
     QemuOpts *opts;
     QDict *orig_reopen_opts;
+    char *discard = NULL;
     bool read_only;
 
     assert(reopen_state != NULL);
@@ -3178,6 +3179,15 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
 
     update_flags_from_options(&reopen_state->flags, opts);
 
+    discard = qemu_opt_get_del(opts, "discard");
+    if (discard != NULL) {
+        if (bdrv_parse_discard_flags(discard, &reopen_state->flags) != 0) {
+            error_setg(errp, "Invalid discard option");
+            ret = -EINVAL;
+            goto error;
+        }
+    }
+
     /* All other options (including node-name and driver) must be unchanged.
      * Put them back into the QDict, so that they are checked at the end
      * of this function. */
@@ -3291,6 +3301,7 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
 error:
     qemu_opts_del(opts);
     qobject_unref(orig_reopen_opts);
+    g_free(discard);
     return ret;
 }
 
-- 
2.13.6
