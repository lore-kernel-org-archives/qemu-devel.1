Received: from eggs.gnu.org ([209.51.188.92]:59617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1h1b1t-0004Qp-E7
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 13:12:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1h1b1m-00062c-5k
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 13:12:31 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Wed,  6 Mar 2019 20:11:10 +0200
Message-Id: <afc903b73d8562518fef4ae953c8992f5a8f0c40.1551895814.git.berto@igalia.com>
In-Reply-To: <cover.1551895813.git.berto@igalia.com>
References: <cover.1551895813.git.berto@igalia.com>
In-Reply-To: <cover.1551895813.git.berto@igalia.com>
References: <cover.1551895813.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 10/13] block: Add
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

This new function takes a BlockDriverState and a new set of options
and checks if there's any option that was previously set but is
missing from the new set of options.

If the option is present in both sets we don't need to check that they
have the same value. The loop at the end of bdrv_reopen_prepare()
already takes care of that.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/block.c b/block.c
index 9c83adab7a..83788457e1 100644
--- a/block.c
+++ b/block.c
@@ -2984,6 +2984,53 @@ BlockDriverState *bdrv_open(const char *filename, const char *reference,
                              NULL, errp);
 }
 
+/* Return true if the NULL-terminated @list contains @str */
+static bool is_str_in_list(const char *str, const char *const *list)
+{
+    if (str && list) {
+        int i;
+        for (i = 0; list[i] != NULL; i++) {
+            if (!strcmp(str, list[i])) {
+                return true;
+            }
+        }
+    }
+    return false;
+}
+
+/*
+ * Check that every option set in @bs->options is also set in
+ * @new_opts.
+ *
+ * Options listed in the common_options list and in
+ * @bs->drv->mutable_opts are skipped.
+ *
+ * Return 0 on success, otherwise return -EINVAL and set @errp.
+ */
+static int bdrv_reset_options_allowed(BlockDriverState *bs,
+                                      const QDict *new_opts, Error **errp)
+{
+    const QDictEntry *e;
+    /* These options are common to all block drivers and are handled
+     * in bdrv_reopen_prepare() so they can be left out of @new_opts */
+    const char *const common_options[] = {
+        "node-name", "discard", "cache.direct", "cache.no-flush",
+        "read-only", "auto-read-only", "detect-zeroes", NULL
+    };
+
+    for (e = qdict_first(bs->options); e; e = qdict_next(bs->options, e)) {
+        if (!qdict_haskey(new_opts, e->key) &&
+            !is_str_in_list(e->key, common_options) &&
+            !is_str_in_list(e->key, bs->drv->mutable_opts)) {
+            error_setg(errp, "Option '%s' cannot be reset "
+                       "to its default value", e->key);
+            return -EINVAL;
+        }
+    }
+
+    return 0;
+}
+
 /*
  * Returns true if @child can be reached recursively from @bs
  */
@@ -3504,6 +3551,17 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
     }
 
     if (drv->bdrv_reopen_prepare) {
+        /*
+         * If a driver-specific option is missing, it means that we
+         * should reset it to its default value.
+         * But not all options allow that, so we need to check it first.
+         */
+        ret = bdrv_reset_options_allowed(reopen_state->bs,
+                                         reopen_state->options, errp);
+        if (ret) {
+            goto error;
+        }
+
         ret = drv->bdrv_reopen_prepare(reopen_state, queue, &local_err);
         if (ret) {
             if (local_err != NULL) {
-- 
2.11.0
