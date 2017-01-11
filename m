Received: from eggs.gnu.org ([2001:4830:134:3::10]:51498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cRNQH-0004ML-7e
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 13:14:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cRNQF-0008Ui-BV
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 13:14:57 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 11 Jan 2017 19:14:11 +0100
Message-Id: <20170111181432.18868-5-mreitz@redhat.com>
In-Reply-To: <20170111181432.18868-1-mreitz@redhat.com>
References: <20170111181432.18868-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 04/25] block: Respect backing bs in
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

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

iotest 051 contains test cases for overwriting the backing file, and so
its output changes with this patch applied (which I consider a good
thing).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c                       | 12 +++++++++++-
 tests/qemu-iotests/051.out    |  8 ++++----
 tests/qemu-iotests/051.pc.out |  8 ++++----
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/block.c b/block.c
index 438201d949..f7a287a60d 100644
--- a/block.c
+++ b/block.c
@@ -3999,6 +3999,7 @@ void bdrv_refresh_filename(BlockDriverState *bs)
 
         opts = qdict_new();
         has_open_options = append_open_options(opts, bs);
+        has_open_options |= bs->backing_overridden;
 
         /* If no specific options have been given for this BDS, the filename of
          * the underlying file should suffice for this one as well */
@@ -4010,13 +4011,22 @@ void bdrv_refresh_filename(BlockDriverState *bs)
          * file BDS. The full options QDict of that file BDS should somehow
          * contain a representation of the filename, therefore the following
          * suffices without querying the (exact_)filename of this BDS. */
-        if (bs->file->bs->full_open_options) {
+        if (bs->file->bs->full_open_options &&
+            (!bs->backing || bs->backing->bs->full_open_options))
+        {
             qdict_put_obj(opts, "driver",
                           QOBJECT(qstring_from_str(drv->format_name)));
             QINCREF(bs->file->bs->full_open_options);
             qdict_put_obj(opts, "file",
                           QOBJECT(bs->file->bs->full_open_options));
 
+            if (bs->backing) {
+                QINCREF(bs->backing->bs->full_open_options);
+                qdict_put(opts, "backing", bs->backing->bs->full_open_options);
+            } else if (bs->backing_overridden && !bs->backing) {
+                qdict_put(opts, "backing", qstring_new());
+            }
+
             bs->full_open_options = opts;
         } else {
             QDECREF(opts);
diff --git a/tests/qemu-iotests/051.out b/tests/qemu-iotests/051.out
index 42bf4164ca..0d0b3b138c 100644
--- a/tests/qemu-iotests/051.out
+++ b/tests/qemu-iotests/051.out
@@ -59,7 +59,7 @@ QEMU X.Y.Z monitor - type 'help' for more information
 Testing: -drive file=TEST_DIR/t.qcow2,driver=qcow2,backing.file.filename=TEST_DIR/t.qcow2.orig,if=none,id=drive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) i[K[Din[K[D[Dinf[K[D[D[Dinfo[K[D[D[D[Dinfo [K[D[D[D[D[Dinfo b[K[D[D[D[D[D[Dinfo bl[K[D[D[D[D[D[D[Dinfo blo[K[D[D[D[D[D[D[D[Dinfo bloc[K[D[D[D[D[D[D[D[D[Dinfo block[K
-drive0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
+drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.orig"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writeback
     Backing file:     TEST_DIR/t.qcow2.orig (chain depth: 1)
@@ -148,7 +148,7 @@ QEMU_PROG: -drive driver=null-co,cache=invalid_value: invalid cache option
 Testing: -drive file=TEST_DIR/t.qcow2,cache=writeback,backing.file.filename=TEST_DIR/t.qcow2.base,backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=drive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) i[K[Din[K[D[Dinf[K[D[D[Dinfo[K[D[D[D[Dinfo [K[D[D[D[D[Dinfo b[K[D[D[D[D[D[Dinfo bl[K[D[D[D[D[D[D[Dinfo blo[K[D[D[D[D[D[D[D[Dinfo bloc[K[D[D[D[D[D[D[D[D[Dinfo block[K
-drive0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
+drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writeback
     Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
@@ -168,7 +168,7 @@ backing-file: TEST_DIR/t.qcow2.base (file, read-only)
 Testing: -drive file=TEST_DIR/t.qcow2,cache=writethrough,backing.file.filename=TEST_DIR/t.qcow2.base,backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=drive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) i[K[Din[K[D[Dinf[K[D[D[Dinfo[K[D[D[D[Dinfo [K[D[D[D[D[Dinfo b[K[D[D[D[D[D[Dinfo bl[K[D[D[D[D[D[D[Dinfo blo[K[D[D[D[D[D[D[D[Dinfo bloc[K[D[D[D[D[D[D[D[D[Dinfo block[K
-drive0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
+drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writethrough
     Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
@@ -188,7 +188,7 @@ backing-file: TEST_DIR/t.qcow2.base (file, read-only)
 Testing: -drive file=TEST_DIR/t.qcow2,cache=unsafe,backing.file.filename=TEST_DIR/t.qcow2.base,backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=drive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) i[K[Din[K[D[Dinf[K[D[D[Dinfo[K[D[D[D[Dinfo [K[D[D[D[D[Dinfo b[K[D[D[D[D[D[Dinfo bl[K[D[D[D[D[D[D[Dinfo blo[K[D[D[D[D[D[D[D[Dinfo bloc[K[D[D[D[D[D[D[D[D[Dinfo block[K
-drive0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
+drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writeback, ignore flushes
     Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
diff --git a/tests/qemu-iotests/051.pc.out b/tests/qemu-iotests/051.pc.out
index 603bb768d6..4b830bc71a 100644
--- a/tests/qemu-iotests/051.pc.out
+++ b/tests/qemu-iotests/051.pc.out
@@ -59,7 +59,7 @@ QEMU X.Y.Z monitor - type 'help' for more information
 Testing: -drive file=TEST_DIR/t.qcow2,driver=qcow2,backing.file.filename=TEST_DIR/t.qcow2.orig,if=none,id=drive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) i[K[Din[K[D[Dinf[K[D[D[Dinfo[K[D[D[D[Dinfo [K[D[D[D[D[Dinfo b[K[D[D[D[D[D[Dinfo bl[K[D[D[D[D[D[D[Dinfo blo[K[D[D[D[D[D[D[D[Dinfo bloc[K[D[D[D[D[D[D[D[D[Dinfo block[K
-drive0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
+drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.orig"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writeback
     Backing file:     TEST_DIR/t.qcow2.orig (chain depth: 1)
@@ -242,7 +242,7 @@ QEMU_PROG: -drive driver=null-co,cache=invalid_value: invalid cache option
 Testing: -drive file=TEST_DIR/t.qcow2,cache=writeback,backing.file.filename=TEST_DIR/t.qcow2.base,backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=drive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) i[K[Din[K[D[Dinf[K[D[D[Dinfo[K[D[D[D[Dinfo [K[D[D[D[D[Dinfo b[K[D[D[D[D[D[Dinfo bl[K[D[D[D[D[D[D[Dinfo blo[K[D[D[D[D[D[D[D[Dinfo bloc[K[D[D[D[D[D[D[D[D[Dinfo block[K
-drive0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
+drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writeback
     Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
@@ -262,7 +262,7 @@ backing-file: TEST_DIR/t.qcow2.base (file, read-only)
 Testing: -drive file=TEST_DIR/t.qcow2,cache=writethrough,backing.file.filename=TEST_DIR/t.qcow2.base,backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=drive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) i[K[Din[K[D[Dinf[K[D[D[Dinfo[K[D[D[D[Dinfo [K[D[D[D[D[Dinfo b[K[D[D[D[D[D[Dinfo bl[K[D[D[D[D[D[D[Dinfo blo[K[D[D[D[D[D[D[D[Dinfo bloc[K[D[D[D[D[D[D[D[D[Dinfo block[K
-drive0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
+drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writethrough
     Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
@@ -282,7 +282,7 @@ backing-file: TEST_DIR/t.qcow2.base (file, read-only)
 Testing: -drive file=TEST_DIR/t.qcow2,cache=unsafe,backing.file.filename=TEST_DIR/t.qcow2.base,backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=drive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) i[K[Din[K[D[Dinf[K[D[D[Dinfo[K[D[D[D[Dinfo [K[D[D[D[D[Dinfo b[K[D[D[D[D[D[Dinfo bl[K[D[D[D[D[D[D[Dinfo blo[K[D[D[D[D[D[D[D[Dinfo bloc[K[D[D[D[D[D[D[D[D[Dinfo block[K
-drive0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
+drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writeback, ignore flushes
     Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
-- 
2.11.0
