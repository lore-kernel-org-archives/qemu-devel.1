Received: from eggs.gnu.org ([2001:4830:134:3::10]:46743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gKNSU-0003xi-4Z
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 08:01:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gKNSB-0002I4-L6
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 08:01:13 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Wed,  7 Nov 2018 14:59:45 +0200
Message-Id: <9f849af9a99edbe97e449843bb8c20f6aab8f6fe.1541595424.git.berto@igalia.com>
In-Reply-To: <cover.1541595424.git.berto@igalia.com>
References: <cover.1541595424.git.berto@igalia.com>
In-Reply-To: <cover.1541595424.git.berto@igalia.com>
References: <cover.1541595424.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v4 10/15] qemu-io: Put flag changes in the
 options QDict in reopen_f()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

When reopen_f() puts a block device in the reopen queue, some of the
new options are passed using a QDict, but others ("read-only" and the
cache options) are passed as flags.

This patch puts those flags in the QDict. This way the flags parameter
becomes redundant and we'll be able to get rid of it in a subsequent
patch.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 qemu-io-cmds.c             | 27 ++++++++++++++++++++++++++-
 tests/qemu-iotests/133     |  9 +++++++++
 tests/qemu-iotests/133.out |  8 ++++++++
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 5363482213..c9ae09d574 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -10,6 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qdict.h"
 #include "qemu-io.h"
 #include "sysemu/block-backend.h"
 #include "block/block.h"
@@ -1978,6 +1979,7 @@ static int reopen_f(BlockBackend *blk, int argc, char **argv)
     int flags = bs->open_flags;
     bool writethrough = !blk_enable_write_cache(blk);
     bool has_rw_option = false;
+    bool has_cache_option = false;
 
     BlockReopenQueue *brq;
     Error *local_err = NULL;
@@ -1989,6 +1991,7 @@ static int reopen_f(BlockBackend *blk, int argc, char **argv)
                 error_report("Invalid cache option: %s", optarg);
                 return -EINVAL;
             }
+            has_cache_option = true;
             break;
         case 'o':
             if (!qemu_opts_parse_noisily(&reopen_opts, optarg, 0)) {
@@ -2046,9 +2049,31 @@ static int reopen_f(BlockBackend *blk, int argc, char **argv)
     }
 
     qopts = qemu_opts_find(&reopen_opts, NULL);
-    opts = qopts ? qemu_opts_to_qdict(qopts, NULL) : NULL;
+    opts = qopts ? qemu_opts_to_qdict(qopts, NULL) : qdict_new();
     qemu_opts_reset(&reopen_opts);
 
+    if (qdict_haskey(opts, BDRV_OPT_READ_ONLY)) {
+        if (has_rw_option) {
+            error_report("Cannot set both -r/-w and '" BDRV_OPT_READ_ONLY "'");
+            qobject_unref(opts);
+            return -EINVAL;
+        }
+    } else {
+        qdict_put_bool(opts, BDRV_OPT_READ_ONLY, !(flags & BDRV_O_RDWR));
+    }
+
+    if (qdict_haskey(opts, BDRV_OPT_CACHE_DIRECT) ||
+        qdict_haskey(opts, BDRV_OPT_CACHE_NO_FLUSH)) {
+        if (has_cache_option) {
+            error_report("Cannot set both -c and the cache options");
+            qobject_unref(opts);
+            return -EINVAL;
+        }
+    } else {
+        qdict_put_bool(opts, BDRV_OPT_CACHE_DIRECT, flags & BDRV_O_NOCACHE);
+        qdict_put_bool(opts, BDRV_OPT_CACHE_NO_FLUSH, flags & BDRV_O_NO_FLUSH);
+    }
+
     bdrv_subtree_drained_begin(bs);
     brq = bdrv_reopen_queue(NULL, bs, opts, flags);
     bdrv_reopen_multiple(bdrv_get_aio_context(bs), brq, &local_err);
diff --git a/tests/qemu-iotests/133 b/tests/qemu-iotests/133
index af6b3e1dd4..14e6b3b972 100755
--- a/tests/qemu-iotests/133
+++ b/tests/qemu-iotests/133
@@ -92,6 +92,15 @@ echo
 IMGOPTSSYNTAX=false $QEMU_IO -f null-co -c 'reopen' -c 'info' \
     "json:{'driver': 'null-co', 'size': 65536}"
 
+echo
+echo "=== Check that mixing -c/-r/-w and their corresponding options is forbidden ==="
+echo
+
+$QEMU_IO -c 'reopen -r -o read-only=on' $TEST_IMG
+$QEMU_IO -c 'reopen -w -o read-only=on' $TEST_IMG
+$QEMU_IO -c 'reopen -c none -o cache.direct=on' $TEST_IMG
+$QEMU_IO -c 'reopen -c writeback -o cache.direct=on' $TEST_IMG
+$QEMU_IO -c 'reopen -c directsync -o cache.no-flush=on' $TEST_IMG
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/133.out b/tests/qemu-iotests/133.out
index f4a85aeb63..48a9d087f0 100644
--- a/tests/qemu-iotests/133.out
+++ b/tests/qemu-iotests/133.out
@@ -24,4 +24,12 @@ Cannot change the option 'driver'
 
 format name: null-co
 format name: null-co
+
+=== Check that mixing -c/-r/-w and their corresponding options is forbidden ===
+
+Cannot set both -r/-w and 'read-only'
+Cannot set both -r/-w and 'read-only'
+Cannot set both -c and the cache options
+Cannot set both -c and the cache options
+Cannot set both -c and the cache options
 *** done
-- 
2.11.0
