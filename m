Received: from eggs.gnu.org ([2001:4830:134:3::10]:47448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDzMb-0007Vk-J3
	for qemu-devel@nongnu.org; Wed, 02 May 2018 17:32:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDzMa-0000NA-FI
	for qemu-devel@nongnu.org; Wed, 02 May 2018 17:32:37 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  2 May 2018 23:32:16 +0200
Message-Id: <20180502213219.7842-5-mreitz@redhat.com>
In-Reply-To: <20180502213219.7842-1-mreitz@redhat.com>
References: <20180502213219.7842-1-mreitz@redhat.com>
Subject: [Qemu-devel] [RFC 4/7] block: Add bdrv_open_string_opts()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>

This function is to be used by callers that cannot guarantee that all
values in @options are correctly typed.  In the future, we would like
this function to be gone, of course, but for now it at least lets us
begin a proper separation of legacy interfaces.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block.h |  2 ++
 block.c               | 84 +++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 83 insertions(+), 3 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 3894edda9d..5335fa8c20 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -261,6 +261,8 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
                            const char *bdref_key, Error **errp);
 BlockDriverState *bdrv_open(const char *filename, const char *reference,
                             QDict *options, int flags, Error **errp);
+BlockDriverState *bdrv_open_string_opts(const char *filename, QDict *options,
+                                        int flags, Error **errp);
 BlockDriverState *bdrv_new_open_driver(BlockDriver *drv, const char *node_name,
                                        int flags, Error **errp);
 BlockReopenQueue *bdrv_reopen_queue(BlockReopenQueue *bs_queue,
diff --git a/block.c b/block.c
index 8a8d9c02a9..1969fa303f 100644
--- a/block.c
+++ b/block.c
@@ -35,6 +35,7 @@
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qnull.h"
 #include "qapi/qmp/qstring.h"
+#include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qapi/qapi-visit-block-core.h"
 #include "sysemu/block-backend.h"
@@ -77,6 +78,8 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
                                            const BdrvChildRole *child_role,
                                            Error **errp);
 
+static QDict *bdrv_type_blockdev_opts(QDict *options);
+
 /* If non-zero, use only whitelisted block drivers */
 static int use_bdrv_whitelist;
 
@@ -1465,9 +1468,7 @@ static QDict *parse_json_filename(const char *filename, Error **errp)
         return NULL;
     }
 
-    qdict_flatten(options);
-
-    return options;
+    return bdrv_type_blockdev_opts(options);
 }
 
 static void parse_json_protocol(QDict *options, const char **pfilename,
@@ -2801,6 +2802,83 @@ BlockDriverState *bdrv_open(const char *filename, const char *reference,
                              NULL, errp);
 }
 
+/*
+ * Take a blockdev @options QDict and convert its values to the
+ * correct type.  This function takes ownership of @options.
+ *
+ * On both success and failure, @options is flattened.  On success,
+ * its refcount is decreased and a new well typed flattened QDict is
+ * returned.  On failure, @options is returned.
+ *
+ * TODO: Currently, this function cannot cope with partially typed
+ * dicts.  If everything is typed correctly, the keyval visitor will
+ * complain and we will return the original @options -- which is
+ * correct.  If all values are strings, the visitor will convert them
+ * to the correct type (if possible).  But if both are mixed, the
+ * visitor will fail and the partially typed @options is returned.  In
+ * practice, this should only be an issue with json:{} filenames,
+ * though.
+ *
+ * TODO: If @options does not conform to the schema, that should be a
+ * real error.
+ *
+ * TODO: Ideally, bdrv_open() should take BlockdevOptions, and the BDS
+ * should only contain BlockdevOptions.  But this is not possible
+ * until this function really rejects anything it does not recognize
+ * (without breaking existing interfaces).
+ */
+static QDict *bdrv_type_blockdev_opts(QDict *options)
+{
+    Visitor *v;
+    BlockdevOptions *blockdev_options = NULL;
+    QObject *typed_opts, *crumpled_opts = NULL;
+    Error *local_err = NULL;
+
+    if (!options) {
+        return NULL;
+    }
+
+    qdict_flatten(options);
+    crumpled_opts = qdict_crumple(options, &local_err);
+    if (local_err) {
+        goto done;
+    }
+
+    v = qobject_input_visitor_new_keyval(crumpled_opts);
+    visit_type_BlockdevOptions(v, NULL, &blockdev_options, &local_err);
+    visit_free(v);
+    if (local_err) {
+        goto done;
+    }
+
+    v = qobject_output_visitor_new(&typed_opts);
+    visit_type_BlockdevOptions(v, NULL, &blockdev_options, &local_err);
+    if (!local_err) {
+        visit_complete(v, &typed_opts);
+    }
+    visit_free(v);
+    if (local_err) {
+        goto done;
+    }
+
+    QDECREF(options);
+    options = qobject_to(QDict, typed_opts);
+    qdict_flatten(options);
+
+done:
+    error_free(local_err);
+    qapi_free_BlockdevOptions(blockdev_options);
+    qobject_decref(crumpled_opts);
+    return options;
+}
+
+BlockDriverState *bdrv_open_string_opts(const char *filename, QDict *options,
+                                        int flags, Error **errp)
+{
+    return bdrv_open_inherit(filename, NULL, bdrv_type_blockdev_opts(options),
+                             flags, NULL, NULL, errp);
+}
+
 /*
  * Adds a BlockDriverState to a simple queue for an atomic, transactional
  * reopen of multiple devices.
-- 
2.14.3
