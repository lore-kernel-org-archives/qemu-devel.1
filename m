Received: from eggs.gnu.org ([209.51.188.92]:38340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1grTIv-0000Gs-JM
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 14:56:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1grTIs-00081l-V2
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 14:56:16 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  6 Feb 2019 20:55:49 +0100
Message-Id: <20190206195551.28893-7-mreitz@redhat.com>
In-Reply-To: <20190206195551.28893-1-mreitz@redhat.com>
References: <20190206195551.28893-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 6/8] block: Try to create well typed json:{}
 filenames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>

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

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1534396
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c                    | 68 +++++++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/059.out |  2 +-
 tests/qemu-iotests/099.out |  4 +--
 tests/qemu-iotests/110.out |  2 +-
 tests/qemu-iotests/198.out |  4 +--
 tests/qemu-iotests/207.out | 10 +++---
 6 files changed, 78 insertions(+), 12 deletions(-)

diff --git a/block.c b/block.c
index d496debda4..c22f3fe5f1 100644
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
@@ -5581,6 +5582,56 @@ static bool bdrv_backing_overridden(BlockDriverSta=
te *bs)
     }
 }
=20
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
+static QDict *bdrv_type_blockdev_opts(const QDict *options, Error **errp=
)
+{
+    Visitor *v;
+    BlockdevOptions *blockdev_options;
+    QObject *typed_opts;
+    QDict *string_options;
+    Error *local_err =3D NULL;
+
+    string_options =3D qdict_clone_shallow(options);
+
+    qdict_flatten(string_options);
+    v =3D qobject_input_visitor_new_flat_confused(string_options, errp);
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
+    v =3D qobject_output_visitor_new(&typed_opts);
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
  *  - exact_filename: A filename which may be used for opening a block d=
evice
  *                    which (mostly) equals the given BDS (even without =
any
@@ -5698,10 +5749,25 @@ void bdrv_refresh_filename(BlockDriverState *bs)
     if (bs->exact_filename[0]) {
         pstrcpy(bs->filename, sizeof(bs->filename), bs->exact_filename);
     } else {
-        QString *json =3D qobject_to_json(QOBJECT(bs->full_open_options)=
);
+        QString *json;
+        QDict *typed_opts, *json_opts;
+
+        typed_opts =3D bdrv_type_blockdev_opts(bs->full_open_options, NU=
LL);
+
+        /*
+         * We cannot be certain that bs->full_open_options matches
+         * BlockdevOptions, so bdrv_type_blockdev_opts() may fail.
+         * That is not fatal, we can just emit bs->full_open_options
+         * directly -- qemu will accept that, even if it does not
+         * match the schema.
+         */
+        json_opts =3D typed_opts ?: bs->full_open_options;
+
+        json =3D qobject_to_json(QOBJECT(json_opts));
         snprintf(bs->filename, sizeof(bs->filename), "json:%s",
                  qstring_get_str(json));
         qobject_unref(json);
+        qobject_unref(typed_opts);
     }
 }
=20
diff --git a/tests/qemu-iotests/059.out b/tests/qemu-iotests/059.out
index f6dce7947c..0238b9e9a8 100644
--- a/tests/qemu-iotests/059.out
+++ b/tests/qemu-iotests/059.out
@@ -2050,7 +2050,7 @@ wrote 512/512 bytes at offset 10240
=20
 =3D=3D=3D Testing monolithicFlat with internally generated JSON file nam=
e =3D=3D=3D
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 subformat=3D=
monolithicFlat
-can't open: Cannot use relative extent paths with VMDK descriptor file '=
json:{"image": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}, "driv=
er": "blkdebug", "inject-error.0.event": "read_aio"}'
+can't open: Cannot use relative extent paths with VMDK descriptor file '=
json:{"inject-error": [{"event": "read_aio"}], "image": {"driver": "file"=
, "filename": "TEST_DIR/t.IMGFMT"}, "driver": "blkdebug"}'
=20
 =3D=3D=3D Testing version 3 =3D=3D=3D
 image: TEST_DIR/iotest-version3.IMGFMT
diff --git a/tests/qemu-iotests/099.out b/tests/qemu-iotests/099.out
index 8cce627529..0a9c434148 100644
--- a/tests/qemu-iotests/099.out
+++ b/tests/qemu-iotests/099.out
@@ -12,11 +12,11 @@ blkverify:TEST_DIR/t.IMGFMT.compare:TEST_DIR/t.IMGFMT
=20
 =3D=3D=3D Testing JSON filename for blkdebug =3D=3D=3D
=20
-json:{"driver": "IMGFMT", "file": {"image": {"driver": "file", "filename=
": "TEST_DIR/t.IMGFMT"}, "driver": "blkdebug", "inject-error.0.event": "l=
1_update"}}
+json:{"driver": "IMGFMT", "file": {"inject-error": [{"event": "l1_update=
"}], "image": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}, "drive=
r": "blkdebug"}}
=20
 =3D=3D=3D Testing indirectly enforced JSON filename =3D=3D=3D
=20
-json:{"driver": "raw", "file": {"test": {"driver": "IMGFMT", "file": {"i=
mage": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}, "driver": "bl=
kdebug", "inject-error.0.event": "l1_update"}}, "driver": "blkverify", "r=
aw": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.compare"}}}
+json:{"driver": "raw", "file": {"test": {"driver": "IMGFMT", "file": {"i=
nject-error": [{"event": "l1_update"}], "image": {"driver": "file", "file=
name": "TEST_DIR/t.IMGFMT"}, "driver": "blkdebug"}}, "driver": "blkverify=
", "raw": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.compare"}}}
=20
 =3D=3D=3D Testing plain filename for blkdebug =3D=3D=3D
=20
diff --git a/tests/qemu-iotests/110.out b/tests/qemu-iotests/110.out
index 46e6a60510..cb055ed39c 100644
--- a/tests/qemu-iotests/110.out
+++ b/tests/qemu-iotests/110.out
@@ -11,7 +11,7 @@ backing file: t.IMGFMT.base (actual path: TEST_DIR/t.IM=
GFMT.base)
=20
 =3D=3D=3D Non-reconstructable filename =3D=3D=3D
=20
-image: json:{"driver": "IMGFMT", "file": {"set-state.0.event": "read_aio=
", "image": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}, "driver"=
: "blkdebug", "set-state.0.new_state": 42}}
+image: json:{"driver": "IMGFMT", "file": {"set-state": [{"new_state": 42=
, "event": "read_aio"}], "image": {"driver": "file", "filename": "TEST_DI=
R/t.IMGFMT"}, "driver": "blkdebug"}}
 file format: IMGFMT
 virtual size: 64M (67108864 bytes)
 backing file: t.IMGFMT.base (actual path: TEST_DIR/t.IMGFMT.base)
diff --git a/tests/qemu-iotests/198.out b/tests/qemu-iotests/198.out
index adb805cce9..a3cb530a0c 100644
--- a/tests/qemu-iotests/198.out
+++ b/tests/qemu-iotests/198.out
@@ -32,7 +32,7 @@ read 16777216/16777216 bytes at offset 0
 16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 =3D=3D checking image base =3D=3D
-image: json:{"encrypt.key-secret": "sec0", "driver": "IMGFMT", "file": {=
"driver": "file", "filename": "TEST_DIR/t.IMGFMT.base"}}
+image: json:{"driver": "IMGFMT", "encrypt": {"format": "auto", "key-secr=
et": "sec0"}, "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.b=
ase"}}
 file format: IMGFMT
 virtual size: 16M (16777216 bytes)
 Format specific information:
@@ -74,7 +74,7 @@ Format specific information:
         master key iters: 1024
=20
 =3D=3D checking image layer =3D=3D
-image: json:{"encrypt.key-secret": "sec1", "driver": "IMGFMT", "file": {=
"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}}
+image: json:{"driver": "IMGFMT", "encrypt": {"format": "auto", "key-secr=
et": "sec1"}, "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}=
}
 file format: IMGFMT
 virtual size: 16M (16777216 bytes)
 backing file: TEST_DIR/t.IMGFMT.base
diff --git a/tests/qemu-iotests/207.out b/tests/qemu-iotests/207.out
index 45ac7c2a8f..b7d285a1e5 100644
--- a/tests/qemu-iotests/207.out
+++ b/tests/qemu-iotests/207.out
@@ -5,7 +5,7 @@
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-image: json:{"driver": "IMGFMT", "file": {"server.host": "127.0.0.1", "s=
erver.port": "22", "driver": "ssh", "path": "TEST_IMG"}}
+image: json:{"driver": "IMGFMT", "file": {"driver": "ssh", "path": "TEST=
_IMG", "server": {"port": "22", "host": "127.0.0.1"}}}
 file format: IMGFMT
 virtual size: 4.0M (4194304 bytes)
=20
@@ -21,7 +21,7 @@ virtual size: 4.0M (4194304 bytes)
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-image: json:{"driver": "IMGFMT", "file": {"server.host": "127.0.0.1", "s=
erver.port": "22", "driver": "ssh", "path": "TEST_IMG"}}
+image: json:{"driver": "IMGFMT", "file": {"driver": "ssh", "path": "TEST=
_IMG", "server": {"port": "22", "host": "127.0.0.1"}}}
 file format: IMGFMT
 virtual size: 8.0M (8388608 bytes)
=20
@@ -30,7 +30,7 @@ virtual size: 8.0M (8388608 bytes)
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-image: json:{"driver": "IMGFMT", "file": {"server.host": "127.0.0.1", "s=
erver.port": "22", "driver": "ssh", "path": "TEST_IMG"}}
+image: json:{"driver": "IMGFMT", "file": {"driver": "ssh", "path": "TEST=
_IMG", "server": {"port": "22", "host": "127.0.0.1"}}}
 file format: IMGFMT
 virtual size: 4.0M (4194304 bytes)
=20
@@ -45,7 +45,7 @@ Job failed: remote host key does not match host_key_che=
ck 'wrong'
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-image: json:{"driver": "IMGFMT", "file": {"server.host": "127.0.0.1", "s=
erver.port": "22", "driver": "ssh", "path": "TEST_IMG"}}
+image: json:{"driver": "IMGFMT", "file": {"driver": "ssh", "path": "TEST=
_IMG", "server": {"port": "22", "host": "127.0.0.1"}}}
 file format: IMGFMT
 virtual size: 8.0M (8388608 bytes)
=20
@@ -60,7 +60,7 @@ Job failed: remote host key does not match host_key_che=
ck 'wrong'
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-image: json:{"driver": "IMGFMT", "file": {"server.host": "127.0.0.1", "s=
erver.port": "22", "driver": "ssh", "path": "TEST_IMG"}}
+image: json:{"driver": "IMGFMT", "file": {"driver": "ssh", "path": "TEST=
_IMG", "server": {"port": "22", "host": "127.0.0.1"}}}
 file format: IMGFMT
 virtual size: 4.0M (4194304 bytes)
=20
--=20
2.20.1
