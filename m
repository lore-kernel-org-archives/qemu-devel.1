Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F217C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 13:59:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35ABC233A1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 13:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35ABC233A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i59La-00067D-Eg
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 09:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55901)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i58yp-0002Qu-E1
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:36:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i58yn-0006QT-Nq
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:36:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:12336)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i58yg-0006Hc-ML; Tue, 03 Sep 2019 09:36:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F3E383090FD1;
 Tue,  3 Sep 2019 13:36:09 +0000 (UTC)
Received: from localhost (ovpn-204-98.brq.redhat.com [10.40.204.98])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F6D55D9E1;
 Tue,  3 Sep 2019 13:36:09 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue,  3 Sep 2019 15:35:43 +0200
Message-Id: <20190903133553.6500-7-mreitz@redhat.com>
In-Reply-To: <20190903133553.6500-1-mreitz@redhat.com>
References: <20190903133553.6500-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 03 Sep 2019 13:36:10 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v2 06/16] vmdk: Use bdrv_dirname() for relative
 extent paths
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This makes iotest 033 pass with e.g. subformat=3DmonolithicFlat.  It also
turns a former error in 059 into success.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190815153638.4600-3-mreitz@redhat.com
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/vmdk.c               | 54 ++++++++++++++++++++++++--------------
 tests/qemu-iotests/059     |  7 +++--
 tests/qemu-iotests/059.out |  4 ++-
 3 files changed, 42 insertions(+), 23 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index fd78fd0ccf..a7f82e665e 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1076,8 +1076,7 @@ static const char *next_line(const char *s)
 }
=20
 static int vmdk_parse_extents(const char *desc, BlockDriverState *bs,
-                              const char *desc_file_path, QDict *options=
,
-                              Error **errp)
+                              QDict *options, Error **errp)
 {
     int ret;
     int matches;
@@ -1087,6 +1086,7 @@ static int vmdk_parse_extents(const char *desc, Blo=
ckDriverState *bs,
     const char *p, *np;
     int64_t sectors =3D 0;
     int64_t flat_offset;
+    char *desc_file_dir =3D NULL;
     char *extent_path;
     BdrvChild *extent_file;
     BDRVVmdkState *s =3D bs->opaque;
@@ -1130,16 +1130,23 @@ static int vmdk_parse_extents(const char *desc, B=
lockDriverState *bs,
             continue;
         }
=20
-        if (!path_is_absolute(fname) && !path_has_protocol(fname) &&
-            !desc_file_path[0])
-        {
-            bdrv_refresh_filename(bs->file->bs);
-            error_setg(errp, "Cannot use relative extent paths with VMDK=
 "
-                       "descriptor file '%s'", bs->file->bs->filename);
-            return -EINVAL;
-        }
+        if (path_is_absolute(fname)) {
+            extent_path =3D g_strdup(fname);
+        } else {
+            if (!desc_file_dir) {
+                desc_file_dir =3D bdrv_dirname(bs->file->bs, errp);
+                if (!desc_file_dir) {
+                    bdrv_refresh_filename(bs->file->bs);
+                    error_prepend(errp, "Cannot use relative paths with =
VMDK "
+                                  "descriptor file '%s': ",
+                                  bs->file->bs->filename);
+                    ret =3D -EINVAL;
+                    goto out;
+                }
+            }
=20
-        extent_path =3D path_combine(desc_file_path, fname);
+            extent_path =3D g_strconcat(desc_file_dir, fname, NULL);
+        }
=20
         ret =3D snprintf(extent_opt_prefix, 32, "extents.%d", s->num_ext=
ents);
         assert(ret < 32);
@@ -1149,7 +1156,8 @@ static int vmdk_parse_extents(const char *desc, Blo=
ckDriverState *bs,
         g_free(extent_path);
         if (local_err) {
             error_propagate(errp, local_err);
-            return -EINVAL;
+            ret =3D -EINVAL;
+            goto out;
         }
=20
         /* save to extents array */
@@ -1160,7 +1168,7 @@ static int vmdk_parse_extents(const char *desc, Blo=
ckDriverState *bs,
                             0, 0, 0, 0, 0, &extent, errp);
             if (ret < 0) {
                 bdrv_unref_child(bs, extent_file);
-                return ret;
+                goto out;
             }
             extent->flat_start_offset =3D flat_offset << 9;
         } else if (!strcmp(type, "SPARSE") || !strcmp(type, "VMFSSPARSE"=
)) {
@@ -1175,24 +1183,27 @@ static int vmdk_parse_extents(const char *desc, B=
lockDriverState *bs,
             g_free(buf);
             if (ret) {
                 bdrv_unref_child(bs, extent_file);
-                return ret;
+                goto out;
             }
             extent =3D &s->extents[s->num_extents - 1];
         } else if (!strcmp(type, "SESPARSE")) {
             ret =3D vmdk_open_se_sparse(bs, extent_file, bs->open_flags,=
 errp);
             if (ret) {
                 bdrv_unref_child(bs, extent_file);
-                return ret;
+                goto out;
             }
             extent =3D &s->extents[s->num_extents - 1];
         } else {
             error_setg(errp, "Unsupported extent type '%s'", type);
             bdrv_unref_child(bs, extent_file);
-            return -ENOTSUP;
+            ret =3D -ENOTSUP;
+            goto out;
         }
         extent->type =3D g_strdup(type);
     }
-    return 0;
+
+    ret =3D 0;
+    goto out;
=20
 invalid:
     np =3D next_line(p);
@@ -1201,7 +1212,11 @@ invalid:
         np--;
     }
     error_setg(errp, "Invalid extent line: %.*s", (int)(np - p), p);
-    return -EINVAL;
+    ret =3D -EINVAL;
+
+out:
+    g_free(desc_file_dir);
+    return ret;
 }
=20
 static int vmdk_open_desc_file(BlockDriverState *bs, int flags, char *bu=
f,
@@ -1228,8 +1243,7 @@ static int vmdk_open_desc_file(BlockDriverState *bs=
, int flags, char *buf,
     }
     s->create_type =3D g_strdup(ct);
     s->desc_offset =3D 0;
-    ret =3D vmdk_parse_extents(buf, bs, bs->file->bs->exact_filename, op=
tions,
-                             errp);
+    ret =3D vmdk_parse_extents(buf, bs, options, errp);
 exit:
     return ret;
 }
diff --git a/tests/qemu-iotests/059 b/tests/qemu-iotests/059
index 279aee6815..fbed5f9483 100755
--- a/tests/qemu-iotests/059
+++ b/tests/qemu-iotests/059
@@ -114,9 +114,12 @@ $QEMU_IMG convert -f qcow2 -O vmdk -o subformat=3Dst=
reamOptimized "$TEST_IMG.qcow2
=20
 echo
 echo "=3D=3D=3D Testing monolithicFlat with internally generated JSON fi=
le name =3D=3D=3D"
+# Should work, because bdrv_dirname() works fine with blkdebug
 IMGOPTS=3D"subformat=3DmonolithicFlat" _make_test_img 64M
-$QEMU_IO -c "open -o driver=3D$IMGFMT,file.driver=3Dblkdebug,file.image.=
filename=3D$TEST_IMG,file.inject-error.0.event=3Dread_aio" 2>&1 \
-    | _filter_testdir | _filter_imgfmt
+$QEMU_IO -c "open -o driver=3D$IMGFMT,file.driver=3Dblkdebug,file.image.=
filename=3D$TEST_IMG,file.inject-error.0.event=3Dread_aio" \
+         -c info \
+    2>&1 \
+    | _filter_testdir | _filter_imgfmt | _filter_img_info
 _cleanup_test_img
=20
 echo
diff --git a/tests/qemu-iotests/059.out b/tests/qemu-iotests/059.out
index b2e718d29f..a51b571d27 100644
--- a/tests/qemu-iotests/059.out
+++ b/tests/qemu-iotests/059.out
@@ -2050,7 +2050,9 @@ wrote 512/512 bytes at offset 10240
=20
 =3D=3D=3D Testing monolithicFlat with internally generated JSON file nam=
e =3D=3D=3D
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
-qemu-io: can't open: Cannot use relative extent paths with VMDK descript=
or file 'json:{"image": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT=
"}, "driver": "blkdebug", "inject-error.0.event": "read_aio"}'
+format name: IMGFMT
+cluster size: 0 bytes
+vm state offset: 0 bytes
=20
 =3D=3D=3D Testing version 3 =3D=3D=3D
 image: TEST_DIR/iotest-version3.IMGFMT
--=20
2.21.0


