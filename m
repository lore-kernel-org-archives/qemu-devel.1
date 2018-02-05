Received: from eggs.gnu.org ([2001:4830:134:3::10]:52892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eiiY1-0008Iy-2o
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:19:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eiiXy-0005v6-T2
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:19:09 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon,  5 Feb 2018 16:18:14 +0100
Message-Id: <20180205151835.20812-6-mreitz@redhat.com>
In-Reply-To: <20180205151835.20812-1-mreitz@redhat.com>
References: <20180205151835.20812-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v8 05/26] block: Respect backing bs in
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>

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

iotests 051 and 191 contain test cases for overwriting the backing file,
and so their output changes with this patch applied (which I consider a
good thing). Note that in the case of 191, the implicitly opened
(non-overridden) base file is included in the json:{} filename as well
-- this will be remedied by a later patch.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c                       | 12 +++++++++++-
 tests/qemu-iotests/051.out    |  8 ++++----
 tests/qemu-iotests/051.pc.out |  8 ++++----
 tests/qemu-iotests/191.out    | 24 ++++++++++++------------
 4 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/block.c b/block.c
index 66e37219b9..249616af68 100644
--- a/block.c
+++ b/block.c
@@ -5071,6 +5071,7 @@ void bdrv_refresh_filename(BlockDriverState *bs)
 
         opts = qdict_new();
         has_open_options = append_open_options(opts, bs);
+        has_open_options |= bs->backing_overridden;
 
         /* If no specific options have been given for this BDS, the filename of
          * the underlying file should suffice for this one as well */
@@ -5082,11 +5083,20 @@ void bdrv_refresh_filename(BlockDriverState *bs)
          * file BDS. The full options QDict of that file BDS should somehow
          * contain a representation of the filename, therefore the following
          * suffices without querying the (exact_)filename of this BDS. */
-        if (bs->file->bs->full_open_options) {
+        if (bs->file->bs->full_open_options &&
+            (!bs->backing || bs->backing->bs->full_open_options))
+        {
             qdict_put_str(opts, "driver", drv->format_name);
             QINCREF(bs->file->bs->full_open_options);
             qdict_put(opts, "file", bs->file->bs->full_open_options);
 
+            if (bs->backing) {
+                QINCREF(bs->backing->bs->full_open_options);
+                qdict_put(opts, "backing", bs->backing->bs->full_open_options);
+            } else if (bs->backing_overridden) {
+                qdict_put(opts, "backing", qstring_new());
+            }
+
             bs->full_open_options = opts;
         } else {
             QDECREF(opts);
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
index 830c11880a..777a6b3adc 100644
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
@@ -241,7 +241,7 @@ QEMU_PROG: -drive driver=null-co,cache=invalid_value: invalid cache option
 Testing: -drive file=TEST_DIR/t.qcow2,cache=writeback,backing.file.filename=TEST_DIR/t.qcow2.base,backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=drive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-drive0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
+drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writeback
     Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
@@ -261,7 +261,7 @@ backing-file: TEST_DIR/t.qcow2.base (file, read-only)
 Testing: -drive file=TEST_DIR/t.qcow2,cache=writethrough,backing.file.filename=TEST_DIR/t.qcow2.base,backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=drive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-drive0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
+drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writethrough
     Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
@@ -281,7 +281,7 @@ backing-file: TEST_DIR/t.qcow2.base (file, read-only)
 Testing: -drive file=TEST_DIR/t.qcow2,cache=unsafe,backing.file.filename=TEST_DIR/t.qcow2.base,backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=drive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-drive0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
+drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writeback, ignore flushes
     Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
diff --git a/tests/qemu-iotests/191.out b/tests/qemu-iotests/191.out
index 575cd3ea2d..b22471b40a 100644
--- a/tests/qemu-iotests/191.out
+++ b/tests/qemu-iotests/191.out
@@ -52,7 +52,7 @@ wrote 65536/65536 bytes at offset 1048576
                 },
                 "backing-filename-format": "IMGFMT",
                 "virtual-size": 67108864,
-                "filename": "TEST_DIR/t.IMGFMT.ovl2",
+                "filename": "json:{"backing": {"backing": {"driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.base"}}, "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.mid"}}, "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.ovl2"}}",
                 "cluster-size": 65536,
                 "format": "IMGFMT",
                 "actual-size": SIZE,
@@ -77,7 +77,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "direct": false,
                 "writeback": true
             },
-            "file": "TEST_DIR/t.IMGFMT.ovl2",
+            "file": "json:{"backing": {"backing": {"driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.base"}}, "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.mid"}}, "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.ovl2"}}",
             "encryption_key_missing": false
         },
         {
@@ -123,7 +123,7 @@ wrote 65536/65536 bytes at offset 1048576
                 },
                 "backing-filename-format": "IMGFMT",
                 "virtual-size": 67108864,
-                "filename": "TEST_DIR/t.IMGFMT",
+                "filename": "json:{"backing": {"backing": {"driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.base"}}, "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.mid"}}, "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}}",
                 "cluster-size": 65536,
                 "format": "IMGFMT",
                 "actual-size": SIZE,
@@ -148,7 +148,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "direct": false,
                 "writeback": true
             },
-            "file": "TEST_DIR/t.IMGFMT",
+            "file": "json:{"backing": {"backing": {"driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.base"}}, "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.mid"}}, "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}}",
             "encryption_key_missing": false
         },
         {
@@ -392,7 +392,7 @@ wrote 65536/65536 bytes at offset 1048576
                 },
                 "backing-filename-format": "IMGFMT",
                 "virtual-size": 67108864,
-                "filename": "TEST_DIR/t.IMGFMT.ovl2",
+                "filename": "json:{"backing": {"backing": {"driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.base"}}, "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.mid"}}, "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.ovl2"}}",
                 "cluster-size": 65536,
                 "format": "IMGFMT",
                 "actual-size": SIZE,
@@ -417,7 +417,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "direct": false,
                 "writeback": true
             },
-            "file": "TEST_DIR/t.IMGFMT.ovl2",
+            "file": "json:{"backing": {"backing": {"driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.base"}}, "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.mid"}}, "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.ovl2"}}",
             "encryption_key_missing": false
         },
         {
@@ -464,7 +464,7 @@ wrote 65536/65536 bytes at offset 1048576
                     },
                     "backing-filename-format": "IMGFMT",
                     "virtual-size": 67108864,
-                    "filename": "TEST_DIR/t.IMGFMT.ovl2",
+                    "filename": "json:{"backing": {"backing": {"driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.base"}}, "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.mid"}}, "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.ovl2"}}",
                     "cluster-size": 65536,
                     "format": "IMGFMT",
                     "actual-size": SIZE,
@@ -474,12 +474,12 @@ wrote 65536/65536 bytes at offset 1048576
                 },
                 "backing-filename-format": "IMGFMT",
                 "virtual-size": 67108864,
-                "filename": "TEST_DIR/t.IMGFMT.ovl3",
+                "filename": "json:{"backing": {"backing": {"backing": {"driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.base"}}, "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.mid"}}, "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.ovl2"}}, "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.ovl3"}}",
                 "cluster-size": 65536,
                 "format": "IMGFMT",
                 "actual-size": SIZE,
-                "full-backing-filename": "TEST_DIR/t.IMGFMT.ovl2",
-                "backing-filename": "TEST_DIR/t.IMGFMT.ovl2",
+                "full-backing-filename": "json:{"backing": {"backing": {"driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.base"}}, "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.mid"}}, "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.ovl2"}}",
+                "backing-filename": "json:{"backing": {"backing": {"driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.base"}}, "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.mid"}}, "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.ovl2"}}",
                 "dirty-flag": false
             },
             "iops_wr": 0,
@@ -490,7 +490,7 @@ wrote 65536/65536 bytes at offset 1048576
             "iops": 0,
             "bps_wr": 0,
             "write_threshold": 0,
-            "backing_file": "TEST_DIR/t.IMGFMT.ovl2",
+            "backing_file": "json:{"backing": {"backing": {"driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.base"}}, "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.mid"}}, "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.ovl2"}}",
             "encrypted": false,
             "bps": 0,
             "bps_rd": 0,
@@ -499,7 +499,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "direct": false,
                 "writeback": true
             },
-            "file": "TEST_DIR/t.IMGFMT.ovl3",
+            "file": "json:{"backing": {"backing": {"backing": {"driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.base"}}, "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.mid"}}, "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.ovl2"}}, "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.ovl3"}}",
             "encryption_key_missing": false
         },
         {
-- 
2.14.3
