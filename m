Received: from eggs.gnu.org ([209.51.188.92]:39098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gk9gp-0001tx-9L
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:34:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gk9gn-0007pE-K5
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:34:43 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 17 Jan 2019 17:34:01 +0200
Message-Id: <5ab350fa5bd78747f4162b294e46ef125243b66c.1547739122.git.berto@igalia.com>
In-Reply-To: <cover.1547739122.git.berto@igalia.com>
References: <cover.1547739122.git.berto@igalia.com>
In-Reply-To: <cover.1547739122.git.berto@igalia.com>
References: <cover.1547739122.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 10/13] block: Add bdrv_reset_options_allowed()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

bdrv_reopen_prepare() receives a BDRVReopenState with (among other
things) a new set of options to be applied to that BlockDriverState.

If an option is missing then it means that we want to reset it to its
default value rather than keep the previous one. This way the state
of the block device after being reopened is comparable to that of a
device added with "blockdev-add" using the same set of options.

Not all options from all drivers can be changed this way, however.
If the user attempts to reset an immutable option to its default value
using this method then we must forbid it.

This new function takes a QemuOptsList with the options of a block
driver and checks if there's any that was previously set but is
missing from the new set of options in the BDRVReopenState.

If the option is present in both sets we don't need to check that they
have the same value. The loop at the end of bdrv_reopen_prepare()
already takes care of that.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/block.c b/block.c
index 10847416b2..eea7aefa99 100644
--- a/block.c
+++ b/block.c
@@ -2909,6 +2909,43 @@ BlockDriverState *bdrv_open(const char *filename, const char *reference,
 }
 
 /*
+ * For every option in @list, check that if it is set in the current
+ * set of options (@state->bs->options) then it is also set in the new
+ * set (@state->options). Options listed in @mutable_opts are skipped.
+ *
+ * @mutable_opts is either NULL or a NULL-terminated array of option
+ * names.
+ *
+ * Return 0 on success, -EINVAL otherwise.
+ */
+static int bdrv_reset_options_allowed(BDRVReopenState *state,
+                                      QemuOptsList *list,
+                                      const char *const mutable_opts[],
+                                      Error **errp)
+{
+    QemuOptDesc *desc = list->desc;
+    while (desc->name) {
+        unsigned i;
+        for (i = 0; mutable_opts != NULL && mutable_opts[i] != NULL; i++) {
+            if (!strcmp(desc->name, mutable_opts[i])) {
+                goto next;
+            }
+        }
+
+        if (!qdict_haskey(state->options, desc->name) &&
+            qdict_haskey(state->bs->options, desc->name)) {
+            error_setg(errp, "Option '%s' can't be reset to its default value",
+                       desc->name);
+            return -EINVAL;
+        }
+    next:
+        desc++;
+    }
+
+    return 0;
+}
+
+/*
  * Returns true if @child can be reached recursively from @bs
  */
 static bool bdrv_recurse_has_child(BlockDriverState *bs,
@@ -3392,6 +3429,19 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
     }
 
     if (drv->bdrv_reopen_prepare) {
+        /*
+         * If a driver-specific option is missing, it means that we
+         * should reset it to its default value.
+         * But not all options allow that, so we need to check it first.
+         */
+        if (drv->runtime_opts) {
+            ret = bdrv_reset_options_allowed(reopen_state, drv->runtime_opts,
+                                             drv->mutable_opts, errp);
+            if (ret) {
+                goto error;
+            }
+        }
+
         ret = drv->bdrv_reopen_prepare(reopen_state, queue, &local_err);
         if (ret) {
             if (local_err != NULL) {
-- 
2.11.0
