Received: from eggs.gnu.org ([2001:4830:134:3::10]:36706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fwpwh-0004G6-TA
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 10:35:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fwpwc-0000YV-Kl
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 10:35:15 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Mon,  3 Sep 2018 17:34:06 +0300
Message-Id: <b4bf05291f304b35658af1a12c97cdcf8d390fa2.1535983918.git.berto@igalia.com>
In-Reply-To: <cover.1535983918.git.berto@igalia.com>
References: <cover.1535983918.git.berto@igalia.com>
In-Reply-To: <cover.1535983918.git.berto@igalia.com>
References: <cover.1535983918.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 08/10] block: Allow changing 'discard' on
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
Cc: Max Reitz <mreitz@redhat.com>
---
 block.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/block.c b/block.c
index 1c0f72454a..3f4b7640fa 100644
--- a/block.c
+++ b/block.c
@@ -3155,6 +3155,7 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
     BlockDriver *drv;
     QemuOpts *opts;
     QDict *orig_reopen_opts;
+    const char *value;
     bool read_only;
 
     assert(reopen_state != NULL);
@@ -3177,6 +3178,15 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
 
     update_flags_from_options(&reopen_state->flags, opts);
 
+    value = qemu_opt_get_del(opts, "discard");
+    if (value != NULL) {
+        if (bdrv_parse_discard_flags(value, &reopen_state->flags) != 0) {
+            error_setg(errp, "Invalid discard option");
+            ret = -EINVAL;
+            goto error;
+        }
+    }
+
     /* All other options (including node-name and driver) must be unchanged.
      * Put them back into the QDict, so that they are checked at the end
      * of this function. */
-- 
2.11.0
