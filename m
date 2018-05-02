Received: from eggs.gnu.org ([2001:4830:134:3::10]:47427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDzMa-0007Ur-Qk
	for qemu-devel@nongnu.org; Wed, 02 May 2018 17:32:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDzMZ-0000Mo-MG
	for qemu-devel@nongnu.org; Wed, 02 May 2018 17:32:36 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  2 May 2018 23:32:15 +0200
Message-Id: <20180502213219.7842-4-mreitz@redhat.com>
In-Reply-To: <20180502213219.7842-1-mreitz@redhat.com>
References: <20180502213219.7842-1-mreitz@redhat.com>
Subject: [Qemu-devel] [RFC 3/7] block: Make use of qdict_set_default_bool()
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

When dealing with blockdev option QDicts that contain purely string
values, it is not really advisable to break that by adding non-string
values.  But it does make sense to use the correct type for QDicts that
may contain non-string values already, so do that.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c       | 12 ++++++------
 block/vvfat.c |  4 ++--
 blockdev.c    | 23 ++++++++++++++++-------
 3 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/block.c b/block.c
index a2caadf0a0..8a8d9c02a9 100644
--- a/block.c
+++ b/block.c
@@ -856,8 +856,8 @@ static void bdrv_temp_snapshot_options(int *child_flags, QDict *child_options,
     *child_flags = (parent_flags & ~BDRV_O_SNAPSHOT) | BDRV_O_TEMPORARY;
 
     /* For temporary files, unconditional cache=unsafe is fine */
-    qdict_set_default_str(child_options, BDRV_OPT_CACHE_DIRECT, "off");
-    qdict_set_default_str(child_options, BDRV_OPT_CACHE_NO_FLUSH, "on");
+    qdict_set_default_bool(child_options, BDRV_OPT_CACHE_DIRECT, false);
+    qdict_set_default_bool(child_options, BDRV_OPT_CACHE_NO_FLUSH, true);
 
     /* Copy the read-only option from the parent */
     qdict_copy_default(child_options, parent_options, BDRV_OPT_READ_ONLY);
@@ -1005,7 +1005,7 @@ static void bdrv_backing_options(int *child_flags, QDict *child_options,
     qdict_copy_default(child_options, parent_options, BDRV_OPT_FORCE_SHARE);
 
     /* backing files always opened read-only */
-    qdict_set_default_str(child_options, BDRV_OPT_READ_ONLY, "on");
+    qdict_set_default_bool(child_options, BDRV_OPT_READ_ONLY, true);
     flags &= ~BDRV_O_COPY_ON_READ;
 
     /* snapshot=on is handled on the top layer */
@@ -2440,9 +2440,9 @@ BlockDriverState *bdrv_open_blockdev_ref(BlockdevRef *ref, Error **errp)
         /* bdrv_open_inherit() defaults to the values in bdrv_flags (for
          * compatibility with other callers) rather than what we want as the
          * real defaults. Apply the defaults here instead. */
-        qdict_set_default_str(qdict, BDRV_OPT_CACHE_DIRECT, "off");
-        qdict_set_default_str(qdict, BDRV_OPT_CACHE_NO_FLUSH, "off");
-        qdict_set_default_str(qdict, BDRV_OPT_READ_ONLY, "off");
+        qdict_set_default_bool(qdict, BDRV_OPT_CACHE_DIRECT, false);
+        qdict_set_default_bool(qdict, BDRV_OPT_CACHE_NO_FLUSH, false);
+        qdict_set_default_bool(qdict, BDRV_OPT_READ_ONLY, false);
     }
 
     bs = bdrv_open_inherit(NULL, reference, qdict, 0, NULL, NULL, errp);
diff --git a/block/vvfat.c b/block/vvfat.c
index 1569783b0f..177b179ed2 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -3128,8 +3128,8 @@ static BlockDriver vvfat_write_target = {
 static void vvfat_qcow_options(int *child_flags, QDict *child_options,
                                int parent_flags, QDict *parent_options)
 {
-    qdict_set_default_str(child_options, BDRV_OPT_READ_ONLY, "off");
-    qdict_set_default_str(child_options, BDRV_OPT_CACHE_NO_FLUSH, "on");
+    qdict_set_default_bool(child_options, BDRV_OPT_READ_ONLY, false);
+    qdict_set_default_bool(child_options, BDRV_OPT_CACHE_NO_FLUSH, true);
 }
 
 static const BdrvChildRole child_vvfat_qcow = {
diff --git a/blockdev.c b/blockdev.c
index 76f811c415..9d4955f23e 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -645,17 +645,26 @@ err_no_opts:
     return NULL;
 }
 
-/* Takes the ownership of bs_opts */
-static BlockDriverState *bds_tree_init(QDict *bs_opts, Error **errp)
+/* Takes the ownership of bs_opts.
+ * If @string_opts is true, @bs_opts contains purely string values.
+ * Otherwise, all values are correctly typed. */
+static BlockDriverState *bds_tree_init(QDict *bs_opts, bool string_opts,
+                                       Error **errp)
 {
     int bdrv_flags = 0;
 
     /* bdrv_open() defaults to the values in bdrv_flags (for compatibility
      * with other callers) rather than what we want as the real defaults.
      * Apply the defaults here instead. */
-    qdict_set_default_str(bs_opts, BDRV_OPT_CACHE_DIRECT, "off");
-    qdict_set_default_str(bs_opts, BDRV_OPT_CACHE_NO_FLUSH, "off");
-    qdict_set_default_str(bs_opts, BDRV_OPT_READ_ONLY, "off");
+    if (string_opts) {
+        qdict_set_default_str(bs_opts, BDRV_OPT_CACHE_DIRECT, "off");
+        qdict_set_default_str(bs_opts, BDRV_OPT_CACHE_NO_FLUSH, "off");
+        qdict_set_default_str(bs_opts, BDRV_OPT_READ_ONLY, "off");
+    } else {
+        qdict_set_default_bool(bs_opts, BDRV_OPT_CACHE_DIRECT, false);
+        qdict_set_default_bool(bs_opts, BDRV_OPT_CACHE_NO_FLUSH, false);
+        qdict_set_default_bool(bs_opts, BDRV_OPT_READ_ONLY, false);
+    }
 
     if (runstate_check(RUN_STATE_INMIGRATE)) {
         bdrv_flags |= BDRV_O_INACTIVE;
@@ -4027,7 +4036,7 @@ void hmp_drive_add_node(Monitor *mon, const char *optstr)
         goto out;
     }
 
-    BlockDriverState *bs = bds_tree_init(qdict, &local_err);
+    BlockDriverState *bs = bds_tree_init(qdict, true, &local_err);
     if (!bs) {
         error_report_err(local_err);
         goto out;
@@ -4063,7 +4072,7 @@ void qmp_blockdev_add(BlockdevOptions *options, Error **errp)
         goto fail;
     }
 
-    bs = bds_tree_init(qdict, errp);
+    bs = bds_tree_init(qdict, false, errp);
     if (!bs) {
         goto fail;
     }
-- 
2.14.3
