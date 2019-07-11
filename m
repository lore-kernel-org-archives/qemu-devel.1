Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F1BC742A1
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 19:59:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AACF3208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 19:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AACF3208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlfDy-0007J9-90
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 15:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51752)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hlfDW-0005sd-MF
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 15:58:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hlfDU-0001JV-Nc
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 15:58:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57714)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hlfDQ-0000rh-Dx; Thu, 11 Jul 2019 15:58:52 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6DB32308213A;
 Thu, 11 Jul 2019 19:58:24 +0000 (UTC)
Received: from localhost (unknown [10.40.205.198])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D77B60BE2;
 Thu, 11 Jul 2019 19:58:22 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 11 Jul 2019 21:58:03 +0200
Message-Id: <20190711195804.30703-5-mreitz@redhat.com>
In-Reply-To: <20190711195804.30703-1-mreitz@redhat.com>
References: <20190711195804.30703-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 11 Jul 2019 19:58:24 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC 4/5] block: Generic file creation fallback
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
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If a protocol driver does not support image creation, we can see whether
maybe the file exists already.  If so, just truncating it will be
sufficient.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 65 insertions(+), 12 deletions(-)

diff --git a/block.c b/block.c
index c139540f2b..8fb8e4dfda 100644
--- a/block.c
+++ b/block.c
@@ -531,20 +531,57 @@ out:
     return ret;
 }
=20
-int bdrv_create_file(const char *filename, QemuOpts *opts, Error **errp)
+static int bdrv_create_file_fallback(const char *filename, BlockDriver *=
drv,
+                                     QemuOpts *opts, Error **errp)
 {
-    BlockDriver *drv;
+    BlockBackend *blk;
+    QDict *options =3D qdict_new();
+    int64_t size =3D 0;
+    char *buf =3D NULL;
+    PreallocMode prealloc;
     Error *local_err =3D NULL;
     int ret;
=20
+    size =3D qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0);
+    buf =3D qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
+    prealloc =3D qapi_enum_parse(&PreallocMode_lookup, buf,
+                               PREALLOC_MODE_OFF, &local_err);
+    g_free(buf);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return -EINVAL;
+    }
+
+    qdict_put_str(options, "driver", drv->format_name);
+
+    blk =3D blk_new_open(filename, NULL, options,
+                       BDRV_O_RDWR | BDRV_O_RESIZE, errp);
+    if (!blk) {
+        error_prepend(errp, "Protocol driver '%s' does not support "
+                      "image creation, and opening the image failed: ",
+                      drv->format_name);
+        return -EINVAL;
+    }
+
+    ret =3D blk_truncate(blk, size, prealloc, errp);
+    blk_unref(blk);
+    return ret;
+}
+
+int bdrv_create_file(const char *filename, QemuOpts *opts, Error **errp)
+{
+    BlockDriver *drv;
+
     drv =3D bdrv_find_protocol(filename, true, errp);
     if (drv =3D=3D NULL) {
         return -ENOENT;
     }
=20
-    ret =3D bdrv_create(drv, filename, opts, &local_err);
-    error_propagate(errp, local_err);
-    return ret;
+    if (drv->bdrv_co_create_opts) {
+        return bdrv_create(drv, filename, opts, errp);
+    } else {
+        return bdrv_create_file_fallback(filename, drv, opts, errp);
+    }
 }
=20
 /**
@@ -1420,6 +1457,24 @@ QemuOptsList bdrv_runtime_opts =3D {
     },
 };
=20
+static QemuOptsList fallback_create_opts =3D {
+    .name =3D "fallback-create-opts",
+    .head =3D QTAILQ_HEAD_INITIALIZER(fallback_create_opts.head),
+    .desc =3D {
+        {
+            .name =3D BLOCK_OPT_SIZE,
+            .type =3D QEMU_OPT_SIZE,
+            .help =3D "Virtual disk size"
+        },
+        {
+            .name =3D BLOCK_OPT_PREALLOC,
+            .type =3D QEMU_OPT_STRING,
+            .help =3D "Preallocation mode (allowed values: off)"
+        },
+        { /* end of list */ }
+    }
+};
+
 /*
  * Common part for opening disk images and files
  *
@@ -5681,14 +5736,12 @@ void bdrv_img_create(const char *filename, const =
char *fmt,
         return;
     }
=20
-    if (!proto_drv->create_opts) {
-        error_setg(errp, "Protocol driver '%s' does not support image cr=
eation",
-                   proto_drv->format_name);
-        return;
-    }
-
     create_opts =3D qemu_opts_append(create_opts, drv->create_opts);
-    create_opts =3D qemu_opts_append(create_opts, proto_drv->create_opts=
);
+    if (proto_drv->create_opts) {
+        create_opts =3D qemu_opts_append(create_opts, proto_drv->create_=
opts);
+    } else {
+        create_opts =3D qemu_opts_append(create_opts, &fallback_create_o=
pts);
+    }
=20
     /* Create parameter list with default values */
     opts =3D qemu_opts_create(create_opts, NULL, 0, &error_abort);
--=20
2.21.0


