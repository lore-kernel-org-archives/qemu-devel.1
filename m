Received: from eggs.gnu.org ([2001:4830:134:3::10]:34965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eGsP0-00085P-5U
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 15:10:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eGsOv-0006u5-KT
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 15:10:46 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 20 Nov 2017 21:09:44 +0100
Message-Id: <20171120201004.14999-6-mreitz@redhat.com>
In-Reply-To: <20171120201004.14999-1-mreitz@redhat.com>
References: <20171120201004.14999-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v7 for-2.12 05/25] block: Respect backing bs in
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

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
index eb67dfbcc0..2dc06cb9cb 100644
--- a/block.c
+++ b/block.c
@@ -5016,6 +5016,7 @@ void bdrv_refresh_filename(BlockDriverState *bs)
 
         opts = qdict_new();
         has_open_options = append_open_options(opts, bs);
+        has_open_options |= bs->backing_overridden;
 
         /* If no specific options have been given for this BDS, the filename of
          * the underlying file should suffice for this one as well */
@@ -5027,11 +5028,20 @@ void bdrv_refresh_filename(BlockDriverState *bs)
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
+            } else if (bs->backing_overridden && !bs->backing) {
+                qdict_put(opts, "backing", qstring_new());
+            }
+
             bs->full_open_options = opts;
         } else {
             QDECREF(opts);
diff --git a/tests/qemu-iotests/051.out b/tests/qemu-iotests/051.out
index e3c6eaba57..50d5cd07c8 100644
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
@@ -148,7 +148,7 @@ QEMU_PROG: -drive driver=null-co,cache=invalid_value: invalid cache option
 Testing: -drive file=TEST_DIR/t.qcow2,cache=writeback,backing.file.filename=TEST_DIR/t.qcow2.base,backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=drive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-drive0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
+drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writeback
     Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
@@ -168,7 +168,7 @@ backing-file: TEST_DIR/t.qcow2.base (file, read-only)
 Testing: -drive file=TEST_DIR/t.qcow2,cache=writethrough,backing.file.filename=TEST_DIR/t.qcow2.base,backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=drive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-drive0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
+drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writethrough
     Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
@@ -188,7 +188,7 @@ backing-file: TEST_DIR/t.qcow2.base (file, read-only)
 Testing: -drive file=TEST_DIR/t.qcow2,cache=unsafe,backing.file.filename=TEST_DIR/t.qcow2.base,backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=drive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-drive0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
+drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writeback, ignore flushes
     Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
diff --git a/tests/qemu-iotests/051.pc.out b/tests/qemu-iotests/051.pc.out
index f2c5622cee..406f83780b 100644
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
@@ -240,7 +240,7 @@ QEMU_PROG: -drive driver=null-co,cache=invalid_value: invalid cache option
 Testing: -drive file=TEST_DIR/t.qcow2,cache=writeback,backing.file.filename=TEST_DIR/t.qcow2.base,backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=drive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-drive0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
+drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writeback
     Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
@@ -260,7 +260,7 @@ backing-file: TEST_DIR/t.qcow2.base (file, read-only)
 Testing: -drive file=TEST_DIR/t.qcow2,cache=writethrough,backing.file.filename=TEST_DIR/t.qcow2.base,backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=drive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-drive0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
+drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writethrough
     Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
@@ -280,7 +280,7 @@ backing-file: TEST_DIR/t.qcow2.base (file, read-only)
 Testing: -drive file=TEST_DIR/t.qcow2,cache=unsafe,backing.file.filename=TEST_DIR/t.qcow2.base,backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=drive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-drive0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
+drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writeback, ignore flushes
     Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
diff --git a/tests/qemu-iotests/191.out b/tests/qemu-iotests/191.out
index 26ff0a315d..c1ce99985e 100644
--- a/tests/qemu-iotests/191.out
+++ b/tests/qemu-iotests/191.out
@@ -61,7 +61,7 @@ wrote 65536/65536 bytes at offset 1048576
                 },
                 "backing-filename-format": "qcow2",
                 "virtual-size": 67108864,
-                "filename": "TEST_DIR/t.qcow2.ovl2",
+                "filename": "json:{"backing": {"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.mid"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.ovl2"}}",
                 "cluster-size": 65536,
                 "format": "qcow2",
                 "actual-size": SIZE,
@@ -95,7 +95,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "direct": false,
                 "writeback": true
             },
-            "file": "TEST_DIR/t.qcow2.ovl2",
+            "file": "json:{"backing": {"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.mid"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.ovl2"}}",
             "encryption_key_missing": false
         },
         {
@@ -150,7 +150,7 @@ wrote 65536/65536 bytes at offset 1048576
                 },
                 "backing-filename-format": "qcow2",
                 "virtual-size": 67108864,
-                "filename": "TEST_DIR/t.qcow2",
+                "filename": "json:{"backing": {"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.mid"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}}",
                 "cluster-size": 65536,
                 "format": "qcow2",
                 "actual-size": SIZE,
@@ -184,7 +184,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "direct": false,
                 "writeback": true
             },
-            "file": "TEST_DIR/t.qcow2",
+            "file": "json:{"backing": {"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.mid"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}}",
             "encryption_key_missing": false
         },
         {
@@ -464,7 +464,7 @@ wrote 65536/65536 bytes at offset 1048576
                 },
                 "backing-filename-format": "qcow2",
                 "virtual-size": 67108864,
-                "filename": "TEST_DIR/t.qcow2.ovl2",
+                "filename": "json:{"backing": {"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.mid"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.ovl2"}}",
                 "cluster-size": 65536,
                 "format": "qcow2",
                 "actual-size": SIZE,
@@ -498,7 +498,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "direct": false,
                 "writeback": true
             },
-            "file": "TEST_DIR/t.qcow2.ovl2",
+            "file": "json:{"backing": {"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.mid"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.ovl2"}}",
             "encryption_key_missing": false
         },
         {
@@ -554,7 +554,7 @@ wrote 65536/65536 bytes at offset 1048576
                     },
                     "backing-filename-format": "qcow2",
                     "virtual-size": 67108864,
-                    "filename": "TEST_DIR/t.qcow2.ovl2",
+                    "filename": "json:{"backing": {"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.mid"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.ovl2"}}",
                     "cluster-size": 65536,
                     "format": "qcow2",
                     "actual-size": SIZE,
@@ -573,7 +573,7 @@ wrote 65536/65536 bytes at offset 1048576
                 },
                 "backing-filename-format": "qcow2",
                 "virtual-size": 67108864,
-                "filename": "TEST_DIR/t.qcow2.ovl3",
+                "filename": "json:{"backing": {"backing": {"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.mid"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.ovl2"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.ovl3"}}",
                 "cluster-size": 65536,
                 "format": "qcow2",
                 "actual-size": SIZE,
@@ -586,8 +586,8 @@ wrote 65536/65536 bytes at offset 1048576
                         "corrupt": false
                     }
                 },
-                "full-backing-filename": "TEST_DIR/t.qcow2.ovl2",
-                "backing-filename": "TEST_DIR/t.qcow2.ovl2",
+                "full-backing-filename": "json:{"backing": {"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.mid"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.ovl2"}}",
+                "backing-filename": "json:{"backing": {"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.mid"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.ovl2"}}",
                 "dirty-flag": false
             },
             "iops_wr": 0,
@@ -598,7 +598,7 @@ wrote 65536/65536 bytes at offset 1048576
             "iops": 0,
             "bps_wr": 0,
             "write_threshold": 0,
-            "backing_file": "TEST_DIR/t.qcow2.ovl2",
+            "backing_file": "json:{"backing": {"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.mid"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.ovl2"}}",
             "encrypted": false,
             "bps": 0,
             "bps_rd": 0,
@@ -607,7 +607,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "direct": false,
                 "writeback": true
             },
-            "file": "TEST_DIR/t.qcow2.ovl3",
+            "file": "json:{"backing": {"backing": {"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.mid"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.ovl2"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.ovl3"}}",
             "encryption_key_missing": false
         },
         {
-- 
2.13.6
