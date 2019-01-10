Received: from eggs.gnu.org ([209.51.188.92]:46231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ghaGX-0002Yw-EL
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 08:20:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ghaGV-0001mb-QE
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 08:20:57 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 10 Jan 2019 16:20:48 +0300
Message-Id: <20190110132048.49451-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH] block: don't probe zeroes in bs->file by
 default on block_status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, eblake@redhat.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

drv_co_block_status digs bs->file for additional, more accurate search
for hole inside region, reported as DATA by bs since 5daa74a6ebc.

This accuracy is not free: assume we have qcow2 disk. Actually, qcow2
knows, where are holes and where is data. But every block_status
request calls lseek additionally. Assume a big disk, full of
data, in any iterative copying block job (or img convert) we'll call
lseek(HOLE) on every iteration, and each of these lseeks will have to
iterate through all metadata up to the end of file. It's obviously
ineffective behavior. And for many scenarios we don't need this lseek
at all.

So, let's "5daa74a6ebc" by default, leaving an option to return
previous behavior, which is needed for scenarios with preallocated
images.

Add iotest illustrating new option semantics.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

Hi all!

I don't call it v2, as it do completely another thing, but here is a
link to my previous try with discussion:
[PATCH] file-posix: add rough-block-status parameter
(https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg01322.html)

And the previous discussion on the topic is
"do not lseek in qcow2 block_status" thread
(https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg05749.html)

 qapi/block-core.json       |  5 +++-
 include/block/block.h      |  1 +
 include/block/block_int.h  |  1 +
 block.c                    |  9 ++++++
 block/io.c                 |  2 +-
 qemu-options.hx            |  4 +++
 tests/qemu-iotests/237     | 61 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/237.out | 12 ++++++++
 tests/qemu-iotests/group   |  1 +
 9 files changed, 94 insertions(+), 2 deletions(-)
 create mode 100755 tests/qemu-iotests/237
 create mode 100644 tests/qemu-iotests/237.out

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 762000f31f..9eed36f3f4 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3673,6 +3673,8 @@
 #                 (default: off)
 # @force-share:   force share all permission on added nodes.
 #                 Requires read-only=true. (Since 2.10)
+# @probe-zeroes:  Probe zeroes on protocol layer if format reports data
+#                 (default: false) (since 4.0)
 #
 # Remaining options are determined by the block driver.
 #
@@ -3686,7 +3688,8 @@
             '*read-only': 'bool',
             '*auto-read-only': 'bool',
             '*force-share': 'bool',
-            '*detect-zeroes': 'BlockdevDetectZeroesOptions' },
+            '*detect-zeroes': 'BlockdevDetectZeroesOptions',
+            '*probe-zeroes': 'bool' },
   'discriminator': 'driver',
   'data': {
       'blkdebug':   'BlockdevOptionsBlkdebug',
diff --git a/include/block/block.h b/include/block/block.h
index f70a843b72..1d7f4a6296 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -129,6 +129,7 @@ typedef struct HDGeometry {
 #define BDRV_OPT_AUTO_READ_ONLY "auto-read-only"
 #define BDRV_OPT_DISCARD        "discard"
 #define BDRV_OPT_FORCE_SHARE    "force-share"
+#define BDRV_OPT_PROBE_ZEROES   "probe-zeroes"
 
 
 #define BDRV_SECTOR_BITS   9
diff --git a/include/block/block_int.h b/include/block/block_int.h
index f605622216..68bddf06b8 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -753,6 +753,7 @@ struct BlockDriverState {
     QDict *options;
     QDict *explicit_options;
     BlockdevDetectZeroesOptions detect_zeroes;
+    bool probe_zeroes;
 
     /* The error object in use for blocking operations on backing_hd */
     Error *backing_blocker;
diff --git a/block.c b/block.c
index 4f5ff2cc12..23a17435c9 100644
--- a/block.c
+++ b/block.c
@@ -939,6 +939,7 @@ static void bdrv_inherited_options(int *child_flags, QDict *child_options,
     qdict_copy_default(child_options, parent_options, BDRV_OPT_CACHE_DIRECT);
     qdict_copy_default(child_options, parent_options, BDRV_OPT_CACHE_NO_FLUSH);
     qdict_copy_default(child_options, parent_options, BDRV_OPT_FORCE_SHARE);
+    qdict_copy_default(child_options, parent_options, BDRV_OPT_PROBE_ZEROES);
 
     /* Inherit the read-only option from the parent if it's not set */
     qdict_copy_default(child_options, parent_options, BDRV_OPT_READ_ONLY);
@@ -1063,6 +1064,7 @@ static void bdrv_backing_options(int *child_flags, QDict *child_options,
     qdict_copy_default(child_options, parent_options, BDRV_OPT_CACHE_DIRECT);
     qdict_copy_default(child_options, parent_options, BDRV_OPT_CACHE_NO_FLUSH);
     qdict_copy_default(child_options, parent_options, BDRV_OPT_FORCE_SHARE);
+    qdict_copy_default(child_options, parent_options, BDRV_OPT_PROBE_ZEROES);
 
     /* backing files always opened read-only */
     qdict_set_default_str(child_options, BDRV_OPT_READ_ONLY, "on");
@@ -1364,6 +1366,12 @@ QemuOptsList bdrv_runtime_opts = {
             .type = QEMU_OPT_BOOL,
             .help = "always accept other writers (default: off)",
         },
+        {
+            .name = BDRV_OPT_PROBE_ZEROES,
+            .type = QEMU_OPT_BOOL,
+            .help = "probe zeroes on protocol layer if format reports data "
+                    "(default: false)",
+        },
         { /* end of list */ }
     },
 };
@@ -1403,6 +1411,7 @@ static int bdrv_open_common(BlockDriverState *bs, BlockBackend *file,
     assert(drv != NULL);
 
     bs->force_share = qemu_opt_get_bool(opts, BDRV_OPT_FORCE_SHARE, false);
+    bs->probe_zeroes = qemu_opt_get_bool(opts, BDRV_OPT_PROBE_ZEROES, false);
 
     if (bs->force_share && (bs->open_flags & BDRV_O_RDWR)) {
         error_setg(errp,
diff --git a/block/io.c b/block/io.c
index bd9d688f8b..0c0cb3a17f 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2186,7 +2186,7 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
         }
     }
 
-    if (want_zero && local_file && local_file != bs &&
+    if (want_zero && bs->probe_zeroes && local_file && local_file != bs &&
         (ret & BDRV_BLOCK_DATA) && !(ret & BDRV_BLOCK_ZERO) &&
         (ret & BDRV_BLOCK_OFFSET_VALID)) {
         int64_t file_pnum;
diff --git a/qemu-options.hx b/qemu-options.hx
index d4f3564b78..7b8dfcfaf6 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -615,6 +615,7 @@ DEF("blockdev", HAS_ARG, QEMU_OPTION_blockdev,
     "-blockdev [driver=]driver[,node-name=N][,discard=ignore|unmap]\n"
     "          [,cache.direct=on|off][,cache.no-flush=on|off]\n"
     "          [,read-only=on|off][,detect-zeroes=on|off|unmap]\n"
+    "          [,probe-zeroes=on|off]\n"
     "          [,driver specific parameters...]\n"
     "                configure a block backend\n", QEMU_ARCH_ALL)
 STEXI
@@ -670,6 +671,8 @@ discard requests.
 conversion of plain zero writes by the OS to driver specific optimized
 zero write commands. You may even choose "unmap" if @var{discard} is set
 to "unmap" to allow a zero write to be converted to an @code{unmap} operation.
+@item probe-zeroes=@var{probe-zeroes}
+Probe zeroes on protocol layer if format reports data. Default is "off".
 @end table
 
 @item Driver-specific options for @code{file}
@@ -793,6 +796,7 @@ DEF("drive", HAS_ARG, QEMU_OPTION_drive,
     "       [,werror=ignore|stop|report|enospc][,id=name][,aio=threads|native]\n"
     "       [,readonly=on|off][,copy-on-read=on|off]\n"
     "       [,discard=ignore|unmap][,detect-zeroes=on|off|unmap]\n"
+    "       [,probe-zeroes=on|off]\n"
     "       [[,bps=b]|[[,bps_rd=r][,bps_wr=w]]]\n"
     "       [[,iops=i]|[[,iops_rd=r][,iops_wr=w]]]\n"
     "       [[,bps_max=bm]|[[,bps_rd_max=rm][,bps_wr_max=wm]]]\n"
diff --git a/tests/qemu-iotests/237 b/tests/qemu-iotests/237
new file mode 100755
index 0000000000..9e66230c13
--- /dev/null
+++ b/tests/qemu-iotests/237
@@ -0,0 +1,61 @@
+#!/bin/bash
+#
+# Test probe-zeroes drive option
+#
+# Copyright (c) 2019 Virtuozzo International GmbH. All rights reserved.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+# creator
+owner=vsementsov@virtuozzo.com
+
+seq="$(basename $0)"
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+
+_cleanup()
+{
+	_cleanup_test_img
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
+_supported_fmt qcow2
+_supported_proto file
+_supported_os Linux
+
+IMGOPTS='preallocation=metadata' _make_test_img 1M
+
+echo "== default map =="
+$QEMU_IMG map --output=json "$TEST_IMG"
+
+echo
+echo "== map with probe-zeroes=off =="
+$QEMU_IMG map --output=json --image-opts \
+        driver="$IMGFMT",file.filename="$TEST_IMG",probe-zeroes=off
+
+echo
+echo "== map with probe-zeroes=on =="
+$QEMU_IMG map --output=json --image-opts \
+        driver="$IMGFMT",file.filename="$TEST_IMG",probe-zeroes=on
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/237.out b/tests/qemu-iotests/237.out
new file mode 100644
index 0000000000..8747757da7
--- /dev/null
+++ b/tests/qemu-iotests/237.out
@@ -0,0 +1,12 @@
+QA output created by 237
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 preallocation=metadata
+== default map ==
+[{ "start": 0, "length": 1048576, "depth": 0, "zero": false, "data": true, "offset": 327680}]
+
+== map with probe-zeroes=off ==
+[{ "start": 0, "length": 1048576, "depth": 0, "zero": false, "data": true, "offset": 327680}]
+
+== map with probe-zeroes=on ==
+[{ "start": 0, "length": 1044480, "depth": 0, "zero": true, "data": true, "offset": 327680},
+{ "start": 1044480, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": 1372160}]
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 61a6d98ebd..3064a04911 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -233,3 +233,4 @@
 233 auto quick
 234 auto quick migration
 235 auto quick
+237 auto quick
-- 
2.18.0
