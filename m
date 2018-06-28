Received: from eggs.gnu.org ([2001:4830:134:3::10]:57582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fYKTl-0004WO-Pj
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 20:08:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fYKTj-0003qX-OE
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 20:08:05 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Thu, 28 Jun 2018 02:07:19 +0200
Message-Id: <20180628000745.4477-6-mreitz@redhat.com>
In-Reply-To: <20180628000745.4477-1-mreitz@redhat.com>
References: <20180628000745.4477-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v9 05/31] block: Respect backing bs in
 bdrv_refresh_filename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Basically, bdrv_refresh_filename() should respect all children of a
BlockDriverState. However, generally those children are driver-specific,
so this function cannot handle the general case. On the other hand,
there are only few drivers which use other children than @file and
@backing (that being vmdk, quorum, and blkverify).

Most block drivers only use @file and/or @backing (if they use any
children at all). Both can be implemented directly in
bdrv_refresh_filename.

The user overriding the file's filename is already handled, however, the
user overriding the backing file is not. If this is done, opening the
BDS with the plain filename of its file will not be correct, so we may
not set bs->exact_filename in that case.

iotest 051 contains test cases for overriding the backing file, and so
its output changes with this patch applied.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c                       | 30 +++++++++++++++++++++++++++++-
 tests/qemu-iotests/051.out    |  8 ++++----
 tests/qemu-iotests/051.pc.out |  8 ++++----
 3 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/block.c b/block.c
index 415c251eac..262b66b00f 100644
--- a/block.c
+++ b/block.c
@@ -5195,6 +5195,7 @@ void bdrv_refresh_filename(BlockDriverState *bs)
     BlockDriver *drv = bs->drv;
     BdrvChild *child;
     QDict *opts;
+    bool backing_overridden;
 
     if (!drv) {
         return;
@@ -5220,6 +5221,23 @@ void bdrv_refresh_filename(BlockDriverState *bs)
         return;
     }
 
+    if (bs->backing) {
+        backing_overridden = strcmp(bs->auto_backing_file,
+                                    bs->backing->bs->filename);
+    } else {
+        /* @bs has no backing BDS, so if bs->backing_file is
+         * non-empty, the backing file has been overridden */
+        backing_overridden = (bs->auto_backing_file[0] != '\0');
+    }
+
+    if (bs->open_flags & BDRV_O_NO_IO) {
+        /* Without I/O, the backing file does not change anything.
+         * Therefore, in such a case (primarily qemu-img), we can
+         * pretend the backing file has not been overridden even if
+         * it technically has been. */
+        backing_overridden = false;
+    }
+
     if (drv->bdrv_refresh_filename) {
         /* Obsolete information is of no use here, so drop the old file name
          * information before refreshing it */
@@ -5245,6 +5263,7 @@ void bdrv_refresh_filename(BlockDriverState *bs)
 
         opts = qdict_new();
         has_open_options = append_open_options(opts, bs);
+        has_open_options |= backing_overridden;
 
         /* If no specific options have been given for this BDS, the filename of
          * the underlying file should suffice for this one as well */
@@ -5256,11 +5275,20 @@ void bdrv_refresh_filename(BlockDriverState *bs)
          * file BDS. The full options QDict of that file BDS should somehow
          * contain a representation of the filename, therefore the following
          * suffices without querying the (exact_)filename of this BDS. */
-        if (bs->file->bs->full_open_options) {
+        if (bs->file->bs->full_open_options &&
+            (!bs->backing || bs->backing->bs->full_open_options))
+        {
             qdict_put_str(opts, "driver", drv->format_name);
             qdict_put(opts, "file",
                       qobject_ref(bs->file->bs->full_open_options));
 
+            if (bs->backing) {
+                qdict_put(opts, "backing",
+                          qobject_ref(bs->backing->bs->full_open_options));
+            } else if (backing_overridden) {
+                qdict_put_null(opts, "backing");
+            }
+
             bs->full_open_options = opts;
         } else {
             qobject_unref(opts);
diff --git a/tests/qemu-iotests/051.out b/tests/qemu-iotests/051.out
index dd9846d1ce..6bf76ed0fb 100644
--- a/tests/qemu-iotests/051.out
+++ b/tests/qemu-iotests/051.out
@@ -59,7 +59,7 @@ QEMU X.Y.Z monitor - type 'help' for more information
 Testing: -drive file=TEST_DIR/t.qcow2,driver=qcow2,backing.file.filename=TEST_DIR/t.qcow2.orig,if=none,id=drive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-drive0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
+drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.orig"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writeback
     Backing file:     TEST_DIR/t.qcow2.orig (chain depth: 1)
@@ -149,7 +149,7 @@ QEMU_PROG: -drive driver=null-co,cache=invalid_value: invalid cache option
 Testing: -drive file=TEST_DIR/t.qcow2,cache=writeback,backing.file.filename=TEST_DIR/t.qcow2.base,backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=drive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-drive0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
+drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writeback
     Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
@@ -169,7 +169,7 @@ backing-file: TEST_DIR/t.qcow2.base (file, read-only)
 Testing: -drive file=TEST_DIR/t.qcow2,cache=writethrough,backing.file.filename=TEST_DIR/t.qcow2.base,backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=drive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-drive0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
+drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writethrough
     Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
@@ -189,7 +189,7 @@ backing-file: TEST_DIR/t.qcow2.base (file, read-only)
 Testing: -drive file=TEST_DIR/t.qcow2,cache=unsafe,backing.file.filename=TEST_DIR/t.qcow2.base,backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=drive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-drive0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
+drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writeback, ignore flushes
     Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
diff --git a/tests/qemu-iotests/051.pc.out b/tests/qemu-iotests/051.pc.out
index b01f9a90d7..789694d879 100644
--- a/tests/qemu-iotests/051.pc.out
+++ b/tests/qemu-iotests/051.pc.out
@@ -59,7 +59,7 @@ QEMU X.Y.Z monitor - type 'help' for more information
 Testing: -drive file=TEST_DIR/t.qcow2,driver=qcow2,backing.file.filename=TEST_DIR/t.qcow2.orig,if=none,id=drive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-drive0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
+drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.orig"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writeback
     Backing file:     TEST_DIR/t.qcow2.orig (chain depth: 1)
@@ -221,7 +221,7 @@ QEMU_PROG: -drive driver=null-co,cache=invalid_value: invalid cache option
 Testing: -drive file=TEST_DIR/t.qcow2,cache=writeback,backing.file.filename=TEST_DIR/t.qcow2.base,backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=drive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-drive0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
+drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writeback
     Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
@@ -241,7 +241,7 @@ backing-file: TEST_DIR/t.qcow2.base (file, read-only)
 Testing: -drive file=TEST_DIR/t.qcow2,cache=writethrough,backing.file.filename=TEST_DIR/t.qcow2.base,backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=drive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-drive0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
+drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writethrough
     Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
@@ -261,7 +261,7 @@ backing-file: TEST_DIR/t.qcow2.base (file, read-only)
 Testing: -drive file=TEST_DIR/t.qcow2,cache=unsafe,backing.file.filename=TEST_DIR/t.qcow2.base,backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=drive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-drive0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
+drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writeback, ignore flushes
     Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
-- 
2.17.1
