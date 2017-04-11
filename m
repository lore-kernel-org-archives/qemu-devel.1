Received: from eggs.gnu.org ([2001:4830:134:3::10]:59732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cxw6D-0007w7-Lh
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:44:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cxw6C-0002a4-GQ
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:44:49 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 11 Apr 2017 15:44:33 +0200
Message-Id: <20170411134435.27271-2-mreitz@redhat.com>
In-Reply-To: <20170411134435.27271-1-mreitz@redhat.com>
References: <20170411134435.27271-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 1/3] block: pass the right options for
 BlockDriver.bdrv_open()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

raw_open() expects the caller always passing in the right actual
@options parameter. But when trying to applying snapshot on a RBD
image, bdrv_snapshot_goto() calls raw_open() (by calling the
bdrv_open callback on the BlockDriver) with a NULL @options, and
that will result in a Segmentation fault.

For the other non-raw format drivers, it also makes sense to passing
in the actual options, althought they don't trigger the problem so
far.

Let's prepare a @options by adding the "file" key-value pair to a
copy of the actual options that were given for the node (i.e.
bs->options), and pass it to the callback.

BlockDriver.bdrv_open() expects bs->file to be NULL and just
overwrites it with the result from bdrv_open_child(). That means we
should actually make sure it's NULL because otherwise the child BDS
will have a reference count that is 1 too high. So we unconditionally
invoke bdrv_unref_child() before calling BlockDriver.bdrv_open(), and
we wrap everything in bdrv_ref()/bdrv_unref() so the BDS isn't
deleted in the meantime.

Suggested-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Message-id: 20170405091909.36357-2-bjsdjshi@linux.vnet.ibm.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/snapshot.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/block/snapshot.c b/block/snapshot.c
index bf5c2ca5e1..06b1185d27 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -27,6 +27,7 @@
 #include "block/block_int.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
+#include "qapi/qmp/qstring.h"
 
 QemuOptsList internal_snapshot_opts = {
     .name = "snapshot",
@@ -189,14 +190,33 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
     }
 
     if (bs->file) {
+        BlockDriverState *file;
+        QDict *options = qdict_clone_shallow(bs->options);
+        QDict *file_options;
+
+        file = bs->file->bs;
+        /* Prevent it from getting deleted when detached from bs */
+        bdrv_ref(file);
+
+        qdict_extract_subqdict(options, &file_options, "file.");
+        QDECREF(file_options);
+        qdict_put(options, "file", qstring_from_str(bdrv_get_node_name(file)));
+
         drv->bdrv_close(bs);
-        ret = bdrv_snapshot_goto(bs->file->bs, snapshot_id);
-        open_ret = drv->bdrv_open(bs, NULL, bs->open_flags, NULL);
+        bdrv_unref_child(bs, bs->file);
+        bs->file = NULL;
+
+        ret = bdrv_snapshot_goto(file, snapshot_id);
+        open_ret = drv->bdrv_open(bs, options, bs->open_flags, NULL);
+        QDECREF(options);
         if (open_ret < 0) {
-            bdrv_unref(bs->file->bs);
+            bdrv_unref(file);
             bs->drv = NULL;
             return open_ret;
         }
+
+        assert(bs->file->bs == file);
+        bdrv_unref(file);
         return ret;
     }
 
-- 
2.12.2
