Received: from eggs.gnu.org ([2001:4830:134:3::10]:42961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fnsbN-0002kN-9e
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:36:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fnsbM-0008Ip-A2
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:36:13 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Thu,  9 Aug 2018 23:35:16 +0200
Message-Id: <20180809213528.14738-20-mreitz@redhat.com>
In-Reply-To: <20180809213528.14738-1-mreitz@redhat.com>
References: <20180809213528.14738-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.1 v10 19/31] block: Use bdrv_dirname()
 for relative filenames
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

bdrv_get_full_backing_filename_from_filename() breaks down when it comes
to JSON filenames. Using bdrv_dirname() as the basis is better because
since we have BDS, we can descend through the BDS tree to the protocol
layer, which gives us a greater probability of finding a non-JSON name;
also, bdrv_dirname() is more correct as it allows block drivers to
override the generation of that directory name in a protocol-specific
way.

We still need to keep bdrv_get_full_backing_filename_from_filename(),
though, because it has valid callers which need it during image creation
when no BDS is available yet.

This makes a test case in qemu-iotest 110, which was supposed to fail,
work. That is actually good, but we need to change the reference output
(and the comment in 110) accordingly.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c                    | 20 +++++++++++++-------
 tests/qemu-iotests/110     |  3 ++-
 tests/qemu-iotests/110.out |  2 +-
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/block.c b/block.c
index b68297e6f3..1fdbf627e0 100644
--- a/block.c
+++ b/block.c
@@ -318,16 +318,22 @@ char *bdrv_get_full_backing_filename_from_filename(const char *backed,
 static char *bdrv_make_absolute_filename(BlockDriverState *relative_to,
                                          const char *filename, Error **errp)
 {
-    char *bs_filename;
+    char *dir, *full_name;
 
-    bdrv_refresh_filename(relative_to);
+    if (!filename || filename[0] == '\0') {
+        return NULL;
+    } else if (path_has_protocol(filename) || path_is_absolute(filename)) {
+        return g_strdup(filename);
+    }
 
-    bs_filename = relative_to->exact_filename[0]
-                      ? relative_to->exact_filename
-                      : relative_to->filename;
+    dir = bdrv_dirname(relative_to, errp);
+    if (!dir) {
+        return NULL;
+    }
 
-    return bdrv_get_full_backing_filename_from_filename(bs_filename,
-                                                        filename ?: "", errp);
+    full_name = g_strconcat(dir, filename, NULL);
+    g_free(dir);
+    return full_name;
 }
 
 char *bdrv_get_full_backing_filename(BlockDriverState *bs, Error **errp)
diff --git a/tests/qemu-iotests/110 b/tests/qemu-iotests/110
index 9de7369f3a..ba1b3c6c7d 100755
--- a/tests/qemu-iotests/110
+++ b/tests/qemu-iotests/110
@@ -61,7 +61,8 @@ echo '=== Non-reconstructable filename ==='
 echo
 
 # Across blkdebug without a config file, you cannot reconstruct filenames, so
-# qemu is incapable of knowing the directory of the top image
+# qemu is incapable of knowing the directory of the top image from the filename
+# alone. However, using bdrv_dirname(), it should still work.
 TEST_IMG="json:{
     'driver': '$IMGFMT',
     'file': {
diff --git a/tests/qemu-iotests/110.out b/tests/qemu-iotests/110.out
index b3584ff87f..5370bc1d26 100644
--- a/tests/qemu-iotests/110.out
+++ b/tests/qemu-iotests/110.out
@@ -14,7 +14,7 @@ backing file: t.IMGFMT.base (actual path: TEST_DIR/t.IMGFMT.base)
 image: json:{"driver": "IMGFMT", "file": {"set-state.0.event": "read_aio", "image": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}, "driver": "blkdebug", "set-state.0.new_state": 42}}
 file format: IMGFMT
 virtual size: 64M (67108864 bytes)
-backing file: t.IMGFMT.base (cannot determine actual path)
+backing file: t.IMGFMT.base (actual path: TEST_DIR/t.IMGFMT.base)
 
 === Backing name is always relative to the backed image ===
 
-- 
2.17.1
