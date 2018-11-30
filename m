Received: from eggs.gnu.org ([2001:4830:134:3::10]:51874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gSkZt-0007kN-TK
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:19:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gSkZq-0006kT-MG
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:19:37 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 30 Nov 2018 17:17:48 +0200
Message-Id: <1da8275a88ef7593d554ae1185b18ee83d91c3ae.1543590618.git.berto@igalia.com>
In-Reply-To: <cover.1543590618.git.berto@igalia.com>
References: <cover.1543590618.git.berto@igalia.com>
In-Reply-To: <cover.1543590618.git.berto@igalia.com>
References: <cover.1543590618.git.berto@igalia.com>
Subject: [Qemu-devel] [RFC PATCH v2 10/12] block: Add
 bdrv_reset_options_allowed()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

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
 block.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/block.c b/block.c
index e8babee971..59aa72f15e 100644
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
@@ -3374,6 +3411,17 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
     }
 
     if (drv->bdrv_reopen_prepare) {
+        /* If a driver-specific option is missing, it means that we
+         * should reset it to its default value.
+         * But not all options allow that, so we need to check it first. */
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
