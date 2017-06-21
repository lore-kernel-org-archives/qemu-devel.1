Received: from eggs.gnu.org ([2001:4830:134:3::10]:34394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dNf74-0008O9-9S
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:52:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dNf6z-0005St-C7
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:52:02 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 21 Jun 2017 14:50:41 +0200
Message-Id: <20170621125047.30294-20-mreitz@redhat.com>
In-Reply-To: <20170621125047.30294-1-mreitz@redhat.com>
References: <20170621125047.30294-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v5 19/25] block: Add
 BlockDriver.bdrv_gather_child_options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>

Some follow-up patches will rework the way bs->full_open_options is
refreshed in bdrv_refresh_filename(). The new implementation will remove
the need for the block drivers' bdrv_refresh_filename() implementations
to set bs->full_open_options; instead, it will be generic and use static
information from each block driver.

However, by implementing bdrv_gather_child_options(), block drivers will
still be able to override the way the full_open_options of their
children are incorporated into their own.

We need to implement this function for VMDK because we have to prevent
the generic implementation from gathering the options of all children:
It is not possible to specify options for the extents through the
runtime options.

For quorum, the child names that would be used by the generic
implementation and the ones that we actually want to use differ. See
quorum_gather_child_options() for more information.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block_int.h | 13 +++++++++++++
 block/quorum.c            | 30 ++++++++++++++++++++++++++++++
 block/vmdk.c              | 13 +++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 1ec1d70..ec37ab3 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -132,6 +132,19 @@ struct BlockDriver {
     void (*bdrv_refresh_filename)(BlockDriverState *bs, QDict *options);
 
     /*
+     * Gathers the open options for all children into @target. A simple format
+     * driver (without backing file support) might implement this function like
+     * this:
+     *
+     *     QINCREF(bs->file->bs->full_open_options);
+     *     qdict_put(target, "file", bs->file->bs->full_open_options);
+     *
+     * If not specified, the generic implementation will simply put all
+     * children's options under their respective name.
+     */
+    void (*bdrv_gather_child_options)(BlockDriverState *bs, QDict *target);
+
+    /*
      * Returns an allocated string which is the directory name of this BDS: It
      * will be used to make relative filenames absolute by prepending this
      * function's return value to them.
diff --git a/block/quorum.c b/block/quorum.c
index 768dcf3..a2d6c32 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1108,6 +1108,35 @@ static void quorum_refresh_filename(BlockDriverState *bs, QDict *options)
     bs->full_open_options = opts;
 }
 
+static void quorum_gather_child_options(BlockDriverState *bs, QDict *target)
+{
+    BDRVQuorumState *s = bs->opaque;
+    QList *children_list;
+    int i;
+
+    /* The generic implementation for gathering child options in
+     * bdrv_refresh_filename() would use the names of the children as specified
+     * for bdrv_open_child() or bdrv_attach_child(), which is "children.%u" with
+     * %u being a value (s->next_child_index) that is incremented each time a
+     * new child is added (and never decremented). Since children can be deleted
+     * at runtime, there may be gaps in that enumeration. When creating a new
+     * quorum BDS and specifying the children for it through runtime options,
+     * the enumeration used there may not have any gaps, though.
+     *
+     * Therefore, we have to create a new gap-less enumeration here (which we
+     * can achieve by simply putting all of the children's full_open_options
+     * into a QList).
+     */
+
+    children_list = qlist_new();
+    qdict_put(target, "children", children_list);
+
+    for (i = 0; i < s->num_children; i++) {
+        QINCREF(s->children[i]->bs->full_open_options);
+        qlist_append(children_list, s->children[i]->bs->full_open_options);
+    }
+}
+
 static char *quorum_dirname(BlockDriverState *bs, Error **errp)
 {
     /* In general, there are multiple BDSs with different dirnames below this
@@ -1127,6 +1156,7 @@ static BlockDriver bdrv_quorum = {
     .bdrv_file_open                     = quorum_open,
     .bdrv_close                         = quorum_close,
     .bdrv_refresh_filename              = quorum_refresh_filename,
+    .bdrv_gather_child_options          = quorum_gather_child_options,
     .bdrv_dirname                       = quorum_dirname,
 
     .bdrv_co_flush_to_disk              = quorum_co_flush,
diff --git a/block/vmdk.c b/block/vmdk.c
index 4e92ce4..2bd064b 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2295,6 +2295,18 @@ static int vmdk_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
     return 0;
 }
 
+static void vmdk_gather_child_options(BlockDriverState *bs, QDict *target)
+{
+    /* No children but file and backing can be explicitly specified */
+    QINCREF(bs->file->bs->full_open_options);
+    qdict_put(target, "file", bs->file->bs->full_open_options);
+
+    if (bs->backing && bs->backing_overridden) {
+        QINCREF(bs->backing->bs->full_open_options);
+        qdict_put(target, "backing", bs->backing->bs->full_open_options);
+    }
+}
+
 static QemuOptsList vmdk_create_opts = {
     .name = "vmdk-create-opts",
     .head = QTAILQ_HEAD_INITIALIZER(vmdk_create_opts.head),
@@ -2365,6 +2377,7 @@ static BlockDriver bdrv_vmdk = {
     .bdrv_get_specific_info       = vmdk_get_specific_info,
     .bdrv_refresh_limits          = vmdk_refresh_limits,
     .bdrv_get_info                = vmdk_get_info,
+    .bdrv_gather_child_options    = vmdk_gather_child_options,
 
     .supports_backing             = true,
     .create_opts                  = &vmdk_create_opts,
-- 
2.9.4
