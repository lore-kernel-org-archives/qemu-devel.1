Received: from eggs.gnu.org ([2001:4830:134:3::10]:45250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJU-0000hy-Oh
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJT-0005xp-KR
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:48 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 12 Mar 2018 13:36:01 -0500
Message-Id: <20180312183628.394722-11-eblake@redhat.com>
In-Reply-To: <20180312183628.394722-1-eblake@redhat.com>
References: <20180312183628.394722-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 10/36] block: Handle null backing link
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

Instead of converting all "backing": null instances into "backing": "",
handle a null value directly in bdrv_open_inherit().

This enables explicitly null backing links for json:{} filenames.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Message-Id: <20180224154033.29559-7-mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: rebase to qobject_to() parameter order and qapi headers split]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block.c                    |  5 ++++-
 blockdev.c                 | 14 --------------
 tests/qemu-iotests/089     | 20 ++++++++++++++++++++
 tests/qemu-iotests/089.out |  8 ++++++++
 4 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/block.c b/block.c
index cd74da3a601..b673a004daf 100644
--- a/block.c
+++ b/block.c
@@ -33,6 +33,7 @@
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qjson.h"
+#include "qapi/qmp/qnull.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qapi/qapi-visit-block-core.h"
@@ -2645,7 +2646,9 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,

     /* See cautionary note on accessing @options above */
     backing = qdict_get_try_str(options, "backing");
-    if (backing && *backing == '\0') {
+    if (qobject_to(QNull, qdict_get(options, "backing")) != NULL ||
+        (backing && *backing == '\0'))
+    {
         flags |= BDRV_O_NO_BACKING;
         qdict_del(options, "backing");
     }
diff --git a/blockdev.c b/blockdev.c
index c9a212b3149..6a751996022 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3973,7 +3973,6 @@ void qmp_blockdev_add(BlockdevOptions *options, Error **errp)
     QObject *obj;
     Visitor *v = qobject_output_visitor_new(&obj);
     QDict *qdict;
-    const QDictEntry *ent;
     Error *local_err = NULL;

     visit_type_BlockdevOptions(v, NULL, &options, &local_err);
@@ -3987,19 +3986,6 @@ void qmp_blockdev_add(BlockdevOptions *options, Error **errp)

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
index 0b059aba905..aa1ba4a98e7 100755
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
index 0bf5a13ec18..89e3e4340a4 100644
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
