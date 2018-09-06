Received: from eggs.gnu.org ([2001:4830:134:3::10]:51958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fxqjK-0005j8-Mh
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 05:37:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fxqjG-0003ac-Qp
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 05:37:38 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu,  6 Sep 2018 12:37:08 +0300
Message-Id: <4e73b26693677b6067545590708adcba66da1c06.1536226505.git.berto@igalia.com>
In-Reply-To: <cover.1536226505.git.berto@igalia.com>
References: <cover.1536226505.git.berto@igalia.com>
In-Reply-To: <cover.1536226505.git.berto@igalia.com>
References: <cover.1536226505.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v3 08/10] block: Allow changing 'discard' on
 reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

'discard' is one of the basic BlockdevOptions available for all
drivers, but it's not handled by bdrv_reopen_prepare() so any attempt
to change it results in an error:

   (qemu) qemu-io virtio0 "reopen -o discard=on"
   Cannot change the option 'discard'

Since there's no reason why we shouldn't allow changing it and the
implementation is simple let's just do it.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/block.c b/block.c
index 1c0f72454a..bd8467bed8 100644
--- a/block.c
+++ b/block.c
@@ -3155,6 +3155,7 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
     BlockDriver *drv;
     QemuOpts *opts;
     QDict *orig_reopen_opts;
+    char *discard = NULL;
     bool read_only;
 
     assert(reopen_state != NULL);
@@ -3177,6 +3178,15 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
 
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
@@ -3290,6 +3300,7 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
 error:
     qemu_opts_del(opts);
     qobject_unref(orig_reopen_opts);
+    g_free(discard);
     return ret;
 }
 
-- 
2.11.0
