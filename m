Received: from eggs.gnu.org ([2001:4830:134:3::10]:43094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fnsbY-0002vQ-Kq
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:36:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fnsbX-000053-EW
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:36:24 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Thu,  9 Aug 2018 23:35:19 +0200
Message-Id: <20180809213528.14738-23-mreitz@redhat.com>
In-Reply-To: <20180809213528.14738-1-mreitz@redhat.com>
References: <20180809213528.14738-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.1 v10 22/31] block: Add
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>

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
implementation and the ones that we actually (currently) want to use
differ. See quorum_gather_child_options() for more information.

Note that both of these are cases which are not ideal: In case of VMDK
it would probably be nice to be able to specify options for all extents.
In case of quorum, the current runtime option structure is simply broken
and needs to be fixed (but that is left for another patch).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block_int.h | 24 +++++++++++++++++++++++
 block/quorum.c            | 40 +++++++++++++++++++++++++++++++++++++++
 block/vmdk.c              | 19 +++++++++++++++++++
 3 files changed, 83 insertions(+)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 1f53adfd96..adaaf2572c 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -141,6 +141,30 @@ struct BlockDriver {
 
     void (*bdrv_refresh_filename)(BlockDriverState *bs, QDict *options);
 
+    /*
+     * Gathers the open options for all children into @target.
+     * A simple format driver (without backing file support) might
+     * implement this function like this:
+     *
+     *     QINCREF(bs->file->bs->full_open_options);
+     *     qdict_put(target, "file", bs->file->bs->full_open_options);
+     *
+     * If not specified, the generic implementation will simply put
+     * all children's options under their respective name.
+     *
+     * @backing_overridden is true when bs->backing seems not to be
+     * the child that would result from opening bs->backing_file.
+     * Therefore, if it is true, the backing child's options should be
+     * gathered; otherwise, there is no need since the backing child
+     * is the one implied by the image header.
+     *
+     * Note that ideally this function would not be needed.  Every
+     * block driver which implements it is probably doing something
+     * shady regarding its runtime option structure.
+     */
+    void (*bdrv_gather_child_options)(BlockDriverState *bs, QDict *target,
+                                      bool backing_overridden);
+
     /*
      * Returns an allocated string which is the directory name of this BDS: It
      * will be used to make relative filenames absolute by prepending this
diff --git a/block/quorum.c b/block/quorum.c
index fdc0e7d16d..f464260044 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1101,6 +1101,45 @@ static void quorum_refresh_filename(BlockDriverState *bs, QDict *options)
     bs->full_open_options = opts;
 }
 
+static void quorum_gather_child_options(BlockDriverState *bs, QDict *target,
+                                        bool backing_overridden)
+{
+    BDRVQuorumState *s = bs->opaque;
+    QList *children_list;
+    int i;
+
+    /*
+     * The generic implementation for gathering child options in
+     * bdrv_refresh_filename() would use the names of the children
+     * as specified for bdrv_open_child() or bdrv_attach_child(),
+     * which is "children.%u" with %u being a value
+     * (s->next_child_index) that is incremented each time a new child
+     * is added (and never decremented).  Since children can be
+     * deleted at runtime, there may be gaps in that enumeration.
+     * When creating a new quorum BDS and specifying the children for
+     * it through runtime options, the enumeration used there may not
+     * have any gaps, though.
+     *
+     * Therefore, we have to create a new gap-less enumeration here
+     * (which we can achieve by simply putting all of the children's
+     * full_open_options into a QList).
+     *
+     * XXX: Note that there are issues with the current child option
+     *      structure quorum uses (such as the fact that children do
+     *      not really have unique permanent names).  Therefore, this
+     *      is going to have to change in the future and ideally we
+     *      want quorum to be covered by the generic implementation.
+     */
+
+    children_list = qlist_new();
+    qdict_put(target, "children", children_list);
+
+    for (i = 0; i < s->num_children; i++) {
+        qlist_append(children_list,
+                     qobject_ref(s->children[i]->bs->full_open_options));
+    }
+}
+
 static char *quorum_dirname(BlockDriverState *bs, Error **errp)
 {
     /* In general, there are multiple BDSs with different dirnames below this
@@ -1128,6 +1167,7 @@ static BlockDriver bdrv_quorum = {
     .bdrv_open                          = quorum_open,
     .bdrv_close                         = quorum_close,
     .bdrv_refresh_filename              = quorum_refresh_filename,
+    .bdrv_gather_child_options          = quorum_gather_child_options,
     .bdrv_dirname                       = quorum_dirname,
 
     .bdrv_co_flush_to_disk              = quorum_co_flush,
diff --git a/block/vmdk.c b/block/vmdk.c
index 1b1a829fa1..399ab0fdd0 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -27,6 +27,7 @@
 #include "qapi/error.h"
 #include "block/block_int.h"
 #include "sysemu/block-backend.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
@@ -2356,6 +2357,23 @@ static int vmdk_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
     return 0;
 }
 
+static void vmdk_gather_child_options(BlockDriverState *bs, QDict *target,
+                                      bool backing_overridden)
+{
+    /* No children but file and backing can be explicitly specified (TODO) */
+    qdict_put(target, "file",
+              qobject_ref(bs->file->bs->full_open_options));
+
+    if (backing_overridden) {
+        if (bs->backing) {
+            qdict_put(target, "backing",
+                      qobject_ref(bs->backing->bs->full_open_options));
+        } else {
+            qdict_put_null(target, "backing");
+        }
+    }
+}
+
 static QemuOptsList vmdk_create_opts = {
     .name = "vmdk-create-opts",
     .head = QTAILQ_HEAD_INITIALIZER(vmdk_create_opts.head),
@@ -2426,6 +2444,7 @@ static BlockDriver bdrv_vmdk = {
     .bdrv_get_specific_info       = vmdk_get_specific_info,
     .bdrv_refresh_limits          = vmdk_refresh_limits,
     .bdrv_get_info                = vmdk_get_info,
+    .bdrv_gather_child_options    = vmdk_gather_child_options,
 
     .supports_backing             = true,
     .create_opts                  = &vmdk_create_opts,
-- 
2.17.1
