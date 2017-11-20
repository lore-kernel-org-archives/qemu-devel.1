Received: from eggs.gnu.org ([2001:4830:134:3::10]:35693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eGsQE-00016p-AJ
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 15:12:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eGsQ9-0007pp-Qq
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 15:12:02 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 20 Nov 2017 21:10:02 +0100
Message-Id: <20171120201004.14999-24-mreitz@redhat.com>
In-Reply-To: <20171120201004.14999-1-mreitz@redhat.com>
References: <20171120201004.14999-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v7 for-2.12 23/25] block: Fix FIXME from "Add
 BDS.backing_overridden"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

Said commit introduced a FIXME stating that bdrv_open_backing_file()
should set bs->backing_overridden to true not only if the file.filename
option was set, but if the "options" QDict contained any option that is
significant for any node in the BDS tree emerging from the backing BDS.
This behavior is implemented by this patch.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 75 insertions(+), 6 deletions(-)

diff --git a/block.c b/block.c
index 526ce43e9b..40007544e5 100644
--- a/block.c
+++ b/block.c
@@ -73,6 +73,9 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
                                            const BdrvChildRole *child_role,
                                            Error **errp);
 
+static bool has_significant_runtime_options(BlockDriverState *bs,
+                                            const QDict *d);
+
 /* If non-zero, use only whitelisted block drivers */
 static int use_bdrv_whitelist;
 
@@ -2214,6 +2217,42 @@ out:
     bdrv_refresh_limits(bs, NULL);
 }
 
+/**
+ * Checks whether @options contains any significant option for any of the nodes
+ * in the BDS tree emerging from @bs.
+ */
+static bool is_significant_option_tree(BlockDriverState *bs, QDict *options)
+{
+    BdrvChild *child;
+
+    if (!qdict_size(options)) {
+        /* No need to recurse */
+        return false;
+    }
+
+    if (has_significant_runtime_options(bs, options)) {
+        return true;
+    }
+
+    QLIST_FOREACH(child, &bs->children, next) {
+        QDict *child_options;
+        char *option_prefix;
+
+        option_prefix = g_strdup_printf("%s.", child->name);
+        qdict_extract_subqdict(options, &child_options, option_prefix);
+        g_free(option_prefix);
+
+        if (is_significant_option_tree(child->bs, child_options)) {
+            QDECREF(child_options);
+            return true;
+        }
+
+        QDECREF(child_options);
+    }
+
+    return false;
+}
+
 /*
  * Opens the backing file for a BlockDriverState if not yet open
  *
@@ -2232,7 +2271,7 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
     const char *reference = NULL;
     int ret = 0;
     BlockDriverState *backing_hd;
-    QDict *options;
+    QDict *options, *cloned_options = NULL;
     QDict *tmp_parent_options = NULL;
     Error *local_err = NULL;
 
@@ -2262,11 +2301,6 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
     reference = qdict_get_try_str(parent_options, bdref_key);
     if (reference || qdict_haskey(options, "file.filename")) {
         /* keep backing_filename NULL */
-
-        /* FIXME: Should also be set to true if @options contains other runtime
-         *        options which control the data that is read from the backing
-         *        BDS */
-        bs->backing_overridden = true;
     } else if (bs->backing_file[0] == '\0' && qdict_size(options) == 0) {
         QDECREF(options);
         goto free_exit;
@@ -2287,6 +2321,8 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
         goto free_exit;
     }
 
+    cloned_options = qdict_clone_shallow(options);
+
     if (!reference &&
         bs->backing_format[0] != '\0' && !qdict_haskey(options, "driver")) {
         qdict_put_str(options, "driver", bs->backing_format);
@@ -2302,6 +2338,10 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
     }
     bdrv_set_aio_context(backing_hd, bdrv_get_aio_context(bs));
 
+    if (reference || is_significant_option_tree(backing_hd, cloned_options)) {
+        bs->backing_overridden = true;
+    }
+
     /* Hook up the backing file link; drop our reference, bs owns the
      * backing_hd reference now */
     bdrv_set_backing_hd(bs, backing_hd, &local_err);
@@ -2317,6 +2357,7 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
 free_exit:
     g_free(backing_filename);
     QDECREF(tmp_parent_options);
+    QDECREF(cloned_options);
     return ret;
 }
 
@@ -4973,6 +5014,34 @@ static const char *const *significant_options(BlockDriverState *bs,
 }
 
 /**
+ * Returns true if @d contains any options the block driver of @bs considers to
+ * be significant runtime options.
+ */
+static bool has_significant_runtime_options(BlockDriverState *bs,
+                                            const QDict *d)
+{
+    const char *const *option_name = NULL;
+
+    while ((option_name = significant_options(bs, option_name))) {
+        assert(strlen(*option_name) > 0);
+        if ((*option_name)[strlen(*option_name) - 1] != '.') {
+            if (qdict_haskey(d, *option_name)) {
+                return true;
+            }
+        } else {
+            const QDictEntry *entry;
+            for (entry = qdict_first(d); entry; entry = qdict_next(d, entry)) {
+                if (strstart(qdict_entry_key(entry), *option_name, NULL)) {
+                    return true;
+                }
+            }
+        }
+    }
+
+    return false;
+}
+
+/**
  * Copies all significant runtime options from bs->options to the given QDict.
  * The set of significant option keys is determined by invoking
  * significant_options().
-- 
2.13.6
