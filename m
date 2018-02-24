Received: from eggs.gnu.org ([2001:4830:134:3::10]:50528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1epbwa-0000lC-4f
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 10:41:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1epbwZ-0005A9-5P
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 10:41:00 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Sat, 24 Feb 2018 16:40:32 +0100
Message-Id: <20180224154033.29559-7-mreitz@redhat.com>
In-Reply-To: <20180224154033.29559-1-mreitz@redhat.com>
References: <20180224154033.29559-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 6/7] block: Handle null backing link
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Instead of converting all "backing": null instances into "backing": "",
handle a null value directly in bdrv_open_inherit().

This enables explicitly null backing links for json:{} filenames.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block.c                    |  4 +++-
 blockdev.c                 | 14 --------------
 tests/qemu-iotests/089     | 20 ++++++++++++++++++++
 tests/qemu-iotests/089.out |  8 ++++++++
 4 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/block.c b/block.c
index cb69fd7ae4..b86614d8ad 100644
--- a/block.c
+++ b/block.c
@@ -2600,7 +2600,9 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
 
     /* See cautionary note on accessing @options above */
     backing = qdict_get_try_str(options, "backing");
-    if (backing && *backing == '\0') {
+    if (qobject_to(qdict_get(options, "backing"), QNull) != NULL ||
+        (backing && *backing == '\0'))
+    {
         flags |= BDRV_O_NO_BACKING;
         qdict_del(options, "backing");
     }
diff --git a/blockdev.c b/blockdev.c
index edc699ae15..003245c6cb 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3972,7 +3972,6 @@ void qmp_blockdev_add(BlockdevOptions *options, Error **errp)
     QObject *obj;
     Visitor *v = qobject_output_visitor_new(&obj);
     QDict *qdict;
-    const QDictEntry *ent;
     Error *local_err = NULL;
 
     visit_type_BlockdevOptions(v, NULL, &options, &local_err);
@@ -3986,19 +3985,6 @@ void qmp_blockdev_add(BlockdevOptions *options, Error **errp)
 
     qdict_flatten(qdict);
 
-    /*
-     * Rewrite "backing": null to "backing": ""
-     * TODO Rewrite "" to null instead, and perhaps not even here
-     */
-    for (ent = qdict_first(qdict); ent; ent = qdict_next(qdict, ent)) {
-        char *dot = strrchr(ent->key, '.');
-
-        if (!strcmp(dot ? dot + 1 : ent->key, "backing")
-            && qobject_type(ent->value) == QTYPE_QNULL) {
-            qdict_put(qdict, ent->key, qstring_new());
-        }
-    }
-
     if (!qdict_get_try_str(qdict, "node-name")) {
         error_setg(errp, "'node-name' must be specified for the root node");
         goto fail;
diff --git a/tests/qemu-iotests/089 b/tests/qemu-iotests/089
index 0b059aba90..aa1ba4a98e 100755
--- a/tests/qemu-iotests/089
+++ b/tests/qemu-iotests/089
@@ -82,6 +82,26 @@ $QEMU_IO_PROG --cache $CACHEMODE \
 $QEMU_IO -c 'read -P 42 0 512' "$TEST_IMG" | _filter_qemu_io
 
 
+echo
+echo "=== Testing correct handling of 'backing':null ==="
+echo
+
+_make_test_img -b "$TEST_IMG.base" $IMG_SIZE
+
+# This should read 42
+$QEMU_IO -c 'read -P 42 0 512' "$TEST_IMG" | _filter_qemu_io
+
+# This should read 0
+$QEMU_IO -c 'read -P 0 0 512' "json:{\
+    'driver': '$IMGFMT',
+    'file': {
+        'driver': 'file',
+        'filename': '$TEST_IMG'
+    },
+    'backing': null
+}" | _filter_qemu_io
+
+
 # Taken from test 071
 echo
 echo "=== Testing blkdebug ==="
diff --git a/tests/qemu-iotests/089.out b/tests/qemu-iotests/089.out
index 0bf5a13ec1..89e3e4340a 100644
--- a/tests/qemu-iotests/089.out
+++ b/tests/qemu-iotests/089.out
@@ -19,6 +19,14 @@ Pattern verification failed at offset 0, 512 bytes
 read 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
+=== Testing correct handling of 'backing':null ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base
+read 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
 === Testing blkdebug ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-- 
2.14.3
