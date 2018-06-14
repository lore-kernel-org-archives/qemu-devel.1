Received: from eggs.gnu.org ([2001:4830:134:3::10]:53123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fTUVM-0000j7-V2
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 11:49:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fTUVI-0003n0-0D
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 11:49:44 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 14 Jun 2018 18:49:05 +0300
Message-Id: <aa54c0ee63a929deba92b65bc20b5b761030233b.1528991017.git.berto@igalia.com>
In-Reply-To: <cover.1528991017.git.berto@igalia.com>
References: <cover.1528991017.git.berto@igalia.com>
In-Reply-To: <cover.1528991017.git.berto@igalia.com>
References: <cover.1528991017.git.berto@igalia.com>
Subject: [Qemu-devel] [RFC PATCH 08/10] block: Add
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
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alberto Garcia <berto@igalia.com>

bdrv_reopen_prepare() receives a BDRVReopenState with (among other
things) a new set of options to be applied to that BlockDriverState.

If an option is missing then it means that we want to reset it to its
default value rather than keeping the previous one. This way the state
of the block device after being reopened is comparable to that of a
device added with "blockdev-add" using the same set of options.

Not all options from all drivers can be changed, however. If the user
attempts to reset an immutable option to its default value using this
method then we must forbid it.

This new function takes a QemuOptsList with the options of a block
driver and checks if there's any that was explicitly set but is not
present in the BDRVReopenState.

If the option is present in both sets we don't need to check that it
keeps the same value. The loop at the end of bdrv_reopen_prepare()
already takes care of that.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/block.c b/block.c
index 91fff6361f..4aa40f7f10 100644
--- a/block.c
+++ b/block.c
@@ -2823,6 +2823,43 @@ BlockDriverState *bdrv_open(const char *filename, const char *reference,
 }
 
 /*
+ * For every option in @list, check that if it is present in
+ * @state->bs->explicit_options then it is also present in
+ * @state->options. Options present in @mutable_opts are skipped.
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
+    QemuOptDesc *desc;
+    for (desc = list->desc; desc && desc->name; desc++) {
+        unsigned i;
+        bool skip_option = false;
+        for (i = 0; mutable_opts && mutable_opts[i] != 0; i++) {
+            if (!strcmp(desc->name, mutable_opts[i])) {
+                skip_option = true;
+                break;
+            }
+        }
+
+        if (!skip_option && !qdict_haskey(state->options, desc->name) &&
+            qdict_haskey(state->bs->explicit_options, desc->name)) {
+            error_setg(errp, "Option '%s' can't be reset to its default value",
+                       desc->name);
+            return -EINVAL;
+        }
+    }
+
+    return 0;
+}
+
+/*
  * Returns true if @child can be reached recursively from @bs
  */
 static bool bdrv_recurse_has_child(BlockDriverState *bs,
@@ -3254,6 +3291,18 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
     }
 
     if (drv->bdrv_reopen_prepare) {
+        /* If a driver-specified option is missing, it means that we
+         * should reset it to its default value. Not all options can
+         * be modified, so we need to check that first */
+        if (drv->runtime_opts) {
+            ret = bdrv_reset_options_allowed(reopen_state, drv->runtime_opts,
+                                             drv->mutable_opts, &local_err);
+            if (ret) {
+                error_propagate(errp, local_err);
+                goto error;
+            }
+        }
+
         ret = drv->bdrv_reopen_prepare(reopen_state, queue, &local_err);
         if (ret) {
             if (local_err != NULL) {
-- 
2.11.0
