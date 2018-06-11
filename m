Received: from eggs.gnu.org ([2001:4830:134:3::10]:43899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSTnj-0001vj-F8
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 16:52:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSTnh-0008Ly-Jt
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 16:52:31 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 11 Jun 2018 22:52:01 +0200
Message-Id: <20180611205203.2624-9-mreitz@redhat.com>
In-Reply-To: <20180611205203.2624-1-mreitz@redhat.com>
References: <20180611205203.2624-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 08/10] block: Try to create well typed
 json:{} filenames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>

By applying a health mix of qdict_flatten(), qdict_crumple(),
qdict_stringify_for_keyval(), the keyval input visitor, and the QObject
output visitor (not necessarily in that order), we can at least try to
bring bs->full_open_options into accordance with the QAPI schema.  This
may not always work (there are some options left that have not been
QAPI-fied yet), but in practice it usually will.

In any case, sometimes emitting wrongly typed json:{} filenames is
better than doing it effectively half the time.

This affects some iotests because json:{} filenames are now usually
crumpled.  In 198, "format": "auto" now appears in the qcow2 encryption
options because going through a visitor makes optional discriminators'
default values explicit.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1534396
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c                    | 66 +++++++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/059.out |  2 +-
 tests/qemu-iotests/099.out |  4 +--
 tests/qemu-iotests/110.out |  2 +-
 tests/qemu-iotests/198.out |  4 +--
 tests/qemu-iotests/207.out | 10 +++---
 6 files changed, 76 insertions(+), 12 deletions(-)

diff --git a/block.c b/block.c
index afe30caac3..6d7567b46e 100644
--- a/block.c
+++ b/block.c
@@ -36,6 +36,7 @@
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qnull.h"
 #include "qapi/qmp/qstring.h"
+#include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qapi/qapi-visit-block-core.h"
 #include "sysemu/block-backend.h"
@@ -5158,6 +5159,56 @@ static bool append_open_options(QDict *d, BlockDriverState *bs)
     return found_any;
 }
 
+/**
+ * Take a blockdev @options QDict and convert its values to the
+ * correct type.
+ *
+ * Fail if @options does not match the QAPI schema of BlockdevOptions.
+ *
+ * In case of failure, return NULL and set @errp.
+ *
+ * In case of success, return a correctly typed new QDict.
+ */
+static QDict *bdrv_type_blockdev_opts(const QDict *options, Error **errp)
+{
+    Visitor *v;
+    BlockdevOptions *blockdev_options;
+    QObject *typed_opts;
+    QDict *string_options;
+    Error *local_err = NULL;
+
+    string_options = qdict_clone_shallow(options);
+
+    qdict_flatten(string_options);
+    v = qobject_input_visitor_new_flat_confused(string_options, errp);
+    if (!v) {
+        error_prepend(errp, "Failed to prepare options: ");
+        return NULL;
+    }
+
+    visit_type_BlockdevOptions(v, NULL, &blockdev_options, &local_err);
+    visit_free(v);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        error_prepend(errp, "Not a valid BlockdevOptions object: ");
+        return NULL;
+    }
+
+    v = qobject_output_visitor_new(&typed_opts);
+    visit_type_BlockdevOptions(v, NULL, &blockdev_options, &local_err);
+    if (!local_err) {
+        visit_complete(v, &typed_opts);
+    }
+    visit_free(v);
+    qapi_free_BlockdevOptions(blockdev_options);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return NULL;
+    }
+
+    return qobject_to(QDict, typed_opts);
+}
+
 /* Updates the following BDS fields:
  *  - exact_filename: A filename which may be used for opening a block device
  *                    which (mostly) equals the given BDS (even without any
@@ -5259,10 +5310,23 @@ void bdrv_refresh_filename(BlockDriverState *bs)
     if (bs->exact_filename[0]) {
         pstrcpy(bs->filename, sizeof(bs->filename), bs->exact_filename);
     } else if (bs->full_open_options) {
-        QString *json = qobject_to_json(QOBJECT(bs->full_open_options));
+        QString *json;
+        QDict *typed_opts, *json_opts;
+
+        typed_opts = bdrv_type_blockdev_opts(bs->full_open_options, NULL);
+
+        /* We cannot be certain that bs->full_open_options matches
+         * BlockdevOptions, so bdrv_type_blockdev_opts() may fail.
+         * That is not fatal, we can just emit bs->full_open_options
+         * directly -- qemu will accept that, even if it does not
+         * match the schema. */
+        json_opts = typed_opts ?: bs->full_open_options;
+
+        json = qobject_to_json(QOBJECT(json_opts));
         snprintf(bs->filename, sizeof(bs->filename), "json:%s",
                  qstring_get_str(json));
         qobject_unref(json);
+        qobject_unref(typed_opts);
     }
 }
 
diff --git a/tests/qemu-iotests/059.out b/tests/qemu-iotests/059.out
index f6dce7947c..0238b9e9a8 100644
--- a/tests/qemu-iotests/059.out
+++ b/tests/qemu-iotests/059.out
@@ -2050,7 +2050,7 @@ wrote 512/512 bytes at offset 10240
 
 === Testing monolithicFlat with internally generated JSON file name ===
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 subformat=monolithicFlat
-can't open: Cannot use relative extent paths with VMDK descriptor file 'json:{"image": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}, "driver": "blkdebug", "inject-error.0.event": "read_aio"}'
+can't open: Cannot use relative extent paths with VMDK descriptor file 'json:{"inject-error": [{"event": "read_aio"}], "image": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}, "driver": "blkdebug"}'
 
 === Testing version 3 ===
 image: TEST_DIR/iotest-version3.IMGFMT
diff --git a/tests/qemu-iotests/099.out b/tests/qemu-iotests/099.out
index 8cce627529..0a9c434148 100644
--- a/tests/qemu-iotests/099.out
+++ b/tests/qemu-iotests/099.out
@@ -12,11 +12,11 @@ blkverify:TEST_DIR/t.IMGFMT.compare:TEST_DIR/t.IMGFMT
 
 === Testing JSON filename for blkdebug ===
 
-json:{"driver": "IMGFMT", "file": {"image": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}, "driver": "blkdebug", "inject-error.0.event": "l1_update"}}
+json:{"driver": "IMGFMT", "file": {"inject-error": [{"event": "l1_update"}], "image": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}, "driver": "blkdebug"}}
 
 === Testing indirectly enforced JSON filename ===
 
-json:{"driver": "raw", "file": {"test": {"driver": "IMGFMT", "file": {"image": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}, "driver": "blkdebug", "inject-error.0.event": "l1_update"}}, "driver": "blkverify", "raw": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.compare"}}}
+json:{"driver": "raw", "file": {"test": {"driver": "IMGFMT", "file": {"inject-error": [{"event": "l1_update"}], "image": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}, "driver": "blkdebug"}}, "driver": "blkverify", "raw": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.compare"}}}
 
 === Testing plain filename for blkdebug ===
 
diff --git a/tests/qemu-iotests/110.out b/tests/qemu-iotests/110.out
index b3584ff87f..fa19315dfb 100644
--- a/tests/qemu-iotests/110.out
+++ b/tests/qemu-iotests/110.out
@@ -11,7 +11,7 @@ backing file: t.IMGFMT.base (actual path: TEST_DIR/t.IMGFMT.base)
 
 === Non-reconstructable filename ===
 
-image: json:{"driver": "IMGFMT", "file": {"set-state.0.event": "read_aio", "image": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}, "driver": "blkdebug", "set-state.0.new_state": 42}}
+image: json:{"driver": "IMGFMT", "file": {"set-state": [{"new_state": 42, "event": "read_aio"}], "image": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}, "driver": "blkdebug"}}
 file format: IMGFMT
 virtual size: 64M (67108864 bytes)
 backing file: t.IMGFMT.base (cannot determine actual path)
diff --git a/tests/qemu-iotests/198.out b/tests/qemu-iotests/198.out
index adb805cce9..a3cb530a0c 100644
--- a/tests/qemu-iotests/198.out
+++ b/tests/qemu-iotests/198.out
@@ -32,7 +32,7 @@ read 16777216/16777216 bytes at offset 0
 16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 == checking image base ==
-image: json:{"encrypt.key-secret": "sec0", "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.base"}}
+image: json:{"driver": "IMGFMT", "encrypt": {"format": "auto", "key-secret": "sec0"}, "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.base"}}
 file format: IMGFMT
 virtual size: 16M (16777216 bytes)
 Format specific information:
@@ -74,7 +74,7 @@ Format specific information:
         master key iters: 1024
 
 == checking image layer ==
-image: json:{"encrypt.key-secret": "sec1", "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}}
+image: json:{"driver": "IMGFMT", "encrypt": {"format": "auto", "key-secret": "sec1"}, "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}}
 file format: IMGFMT
 virtual size: 16M (16777216 bytes)
 backing file: TEST_DIR/t.IMGFMT.base
diff --git a/tests/qemu-iotests/207.out b/tests/qemu-iotests/207.out
index 078b7e63cb..993417a77e 100644
--- a/tests/qemu-iotests/207.out
+++ b/tests/qemu-iotests/207.out
@@ -5,7 +5,7 @@
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
 {u'return': {}}
 
-image: json:{"driver": "IMGFMT", "file": {"server.host": "127.0.0.1", "server.port": "22", "driver": "ssh", "path": "TEST_IMG"}}
+image: json:{"driver": "IMGFMT", "file": {"driver": "ssh", "path": "TEST_IMG", "server": {"port": "22", "host": "127.0.0.1"}}}
 file format: IMGFMT
 virtual size: 4.0M (4194304 bytes)
 
@@ -21,7 +21,7 @@ virtual size: 4.0M (4194304 bytes)
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
 {u'return': {}}
 
-image: json:{"driver": "IMGFMT", "file": {"server.host": "127.0.0.1", "server.port": "22", "driver": "ssh", "path": "TEST_IMG"}}
+image: json:{"driver": "IMGFMT", "file": {"driver": "ssh", "path": "TEST_IMG", "server": {"port": "22", "host": "127.0.0.1"}}}
 file format: IMGFMT
 virtual size: 8.0M (8388608 bytes)
 
@@ -30,7 +30,7 @@ virtual size: 8.0M (8388608 bytes)
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
 {u'return': {}}
 
-image: json:{"driver": "IMGFMT", "file": {"server.host": "127.0.0.1", "server.port": "22", "driver": "ssh", "path": "TEST_IMG"}}
+image: json:{"driver": "IMGFMT", "file": {"driver": "ssh", "path": "TEST_IMG", "server": {"port": "22", "host": "127.0.0.1"}}}
 file format: IMGFMT
 virtual size: 4.0M (4194304 bytes)
 
@@ -45,7 +45,7 @@ Job failed: remote host key does not match host_key_check 'wrong'
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
 {u'return': {}}
 
-image: json:{"driver": "IMGFMT", "file": {"server.host": "127.0.0.1", "server.port": "22", "driver": "ssh", "path": "TEST_IMG"}}
+image: json:{"driver": "IMGFMT", "file": {"driver": "ssh", "path": "TEST_IMG", "server": {"port": "22", "host": "127.0.0.1"}}}
 file format: IMGFMT
 virtual size: 8.0M (8388608 bytes)
 
@@ -60,7 +60,7 @@ Job failed: remote host key does not match host_key_check 'wrong'
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
 {u'return': {}}
 
-image: json:{"driver": "IMGFMT", "file": {"server.host": "127.0.0.1", "server.port": "22", "driver": "ssh", "path": "TEST_IMG"}}
+image: json:{"driver": "IMGFMT", "file": {"driver": "ssh", "path": "TEST_IMG", "server": {"port": "22", "host": "127.0.0.1"}}}
 file format: IMGFMT
 virtual size: 4.0M (4194304 bytes)
 
-- 
2.17.1
