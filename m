Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC5DC43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 17:51:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8DFE20665
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 17:51:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8DFE20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53506 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfT7Z-0000WM-4t
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 13:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49158)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hfSx2-0001g7-R1
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 13:40:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hfSx0-0005Vy-0F
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 13:40:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43256)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hfSwv-0005K1-0b; Mon, 24 Jun 2019 13:40:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C99835D61E;
 Mon, 24 Jun 2019 17:40:06 +0000 (UTC)
Received: from localhost (ovpn-204-152.brq.redhat.com [10.40.204.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D1E15D9C5;
 Mon, 24 Jun 2019 17:40:05 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 24 Jun 2019 19:39:31 +0200
Message-Id: <20190624173935.25747-12-mreitz@redhat.com>
In-Reply-To: <20190624173935.25747-1-mreitz@redhat.com>
References: <20190624173935.25747-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Mon, 24 Jun 2019 17:40:06 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 11/14] block: Try to create well typed
 json:{} filenames
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

By applying qdict_flatten(), the flat-confused input visitor, and the
output visitor, we can at least try to bring bs->full_open_options into
accordance with the QAPI schema.  This may not always work (there are
some options left that have not been QAPI-fied yet), but in practice it
usually will.

In any case, sometimes emitting wrongly typed json:{} filenames is
better than doing it effectively half the time.

This affects some iotests because json:{} filenames are now usually
crumpled.  In 198, "format": "auto" now appears in the qcow2 encryption
options because going through a visitor makes optional members' default
values explicit.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1534396
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c                    | 68 +++++++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/059.out |  2 +-
 tests/qemu-iotests/099.out |  4 +--
 tests/qemu-iotests/110.out |  2 +-
 tests/qemu-iotests/198.out |  4 +--
 5 files changed, 73 insertions(+), 7 deletions(-)

diff --git a/block.c b/block.c
index c139540f2b..d3c1041087 100644
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
@@ -6283,6 +6284,56 @@ static bool bdrv_backing_overridden(BlockDriverSta=
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
@@ -6400,10 +6451,25 @@ void bdrv_refresh_filename(BlockDriverState *bs)
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
index 4fab42a28c..53109b2d49 100644
--- a/tests/qemu-iotests/059.out
+++ b/tests/qemu-iotests/059.out
@@ -2050,7 +2050,7 @@ wrote 512/512 bytes at offset 10240
=20
 =3D=3D=3D Testing monolithicFlat with internally generated JSON file nam=
e =3D=3D=3D
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 subformat=3D=
monolithicFlat
-qemu-io: can't open: Cannot use relative extent paths with VMDK descript=
or file 'json:{"image": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT=
"}, "driver": "blkdebug", "inject-error.0.event": "read_aio"}'
+qemu-io: can't open: Cannot use relative extent paths with VMDK descript=
or file 'json:{"inject-error": [{"event": "read_aio"}], "image": {"driver=
": "file", "filename": "TEST_DIR/t.IMGFMT"}, "driver": "blkdebug"}'
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
index f60b26390e..d95b92bee7 100644
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
 virtual size: 64 MiB (67108864 bytes)
 backing file: t.IMGFMT.base (actual path: TEST_DIR/t.IMGFMT.base)
diff --git a/tests/qemu-iotests/198.out b/tests/qemu-iotests/198.out
index e86b175e39..eef8af3cdc 100644
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
 virtual size: 16 MiB (16777216 bytes)
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
 virtual size: 16 MiB (16777216 bytes)
 backing file: TEST_DIR/t.IMGFMT.base
--=20
2.21.0


