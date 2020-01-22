Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8313C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 16:48:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91D4421835
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 16:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VYGH33S4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91D4421835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuJAt-0000jr-66
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 11:48:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50130)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iuJ8X-0007fC-0R
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 11:45:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iuJ8V-0000ir-Mt
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 11:45:48 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39201)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iuJ8V-0000ia-Ju
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 11:45:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579711547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yk0j2xVRHT9NFg5jvYcwqi9ZuCWPnCoIifD7HCdVElw=;
 b=VYGH33S4EO13m2g4b7YPl7TmZPnZfO9fKCcu1tZN/IvV+zF95bfyBKVRLCPKjSv+9c6AkU
 NX9DOP+f9rNIhgJ1sDTzwhUQhmlNRGO459xzEwYKqBGGti66JSgERE6JSMHc5WuDMx6aBC
 qfanKJQG6ZqF9Z7osF/FtBYKjeJJdJU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-fP1M6xYRM1mXqGq6IPafDw-1; Wed, 22 Jan 2020 11:45:42 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67EC41085925;
 Wed, 22 Jan 2020 16:45:41 +0000 (UTC)
Received: from localhost (unknown [10.36.118.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 82010858BE;
 Wed, 22 Jan 2020 16:45:40 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 2/5] block: Generic file creation fallback
Date: Wed, 22 Jan 2020 17:45:29 +0100
Message-Id: <20200122164532.178040-3-mreitz@redhat.com>
In-Reply-To: <20200122164532.178040-1-mreitz@redhat.com>
References: <20200122164532.178040-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: fP1M6xYRM1mXqGq6IPafDw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If a protocol driver does not support image creation, we can see whether
maybe the file exists already.  If so, just truncating it will be
sufficient.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 159 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 147 insertions(+), 12 deletions(-)

diff --git a/block.c b/block.c
index 99ce26d64d..e167eca04b 100644
--- a/block.c
+++ b/block.c
@@ -532,20 +532,139 @@ out:
     return ret;
 }
=20
-int bdrv_create_file(const char *filename, QemuOpts *opts, Error **errp)
+/**
+ * Helper function for bdrv_create_file_fallback(): Resize @blk to at
+ * least the given @minimum_size.
+ *
+ * On success, return @blk's actual length.
+ * Otherwise, return -errno.
+ */
+static int64_t create_file_fallback_truncate(BlockBackend *blk,
+                                             int64_t minimum_size, Error *=
*errp)
 {
-    BlockDriver *drv;
+    Error *local_err =3D NULL;
+    int64_t size;
+    int ret;
+
+    ret =3D blk_truncate(blk, minimum_size, false, PREALLOC_MODE_OFF, &loc=
al_err);
+    if (ret < 0 && ret !=3D -ENOTSUP) {
+        error_propagate(errp, local_err);
+        return ret;
+    }
+
+    size =3D blk_getlength(blk);
+    if (size < 0) {
+        error_free(local_err);
+        error_setg_errno(errp, -size,
+                         "Failed to inquire the new image file's length");
+        return size;
+    }
+
+    if (size < minimum_size) {
+        /* Need to grow the image, but we failed to do that */
+        error_propagate(errp, local_err);
+        return -ENOTSUP;
+    }
+
+    error_free(local_err);
+    local_err =3D NULL;
+
+    return size;
+}
+
+/**
+ * Helper function for bdrv_create_file_fallback(): Zero the first
+ * sector to remove any potentially pre-existing image header.
+ */
+static int create_file_fallback_zero_first_sector(BlockBackend *blk,
+                                                  int64_t current_size,
+                                                  Error **errp)
+{
+    int64_t bytes_to_clear;
+    int ret;
+
+    bytes_to_clear =3D MIN(current_size, BDRV_SECTOR_SIZE);
+    if (bytes_to_clear) {
+        ret =3D blk_pwrite_zeroes(blk, 0, bytes_to_clear, BDRV_REQ_MAY_UNM=
AP);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret,
+                             "Failed to clear the new image's first sector=
");
+            return ret;
+        }
+    }
+
+    return 0;
+}
+
+static int bdrv_create_file_fallback(const char *filename, BlockDriver *dr=
v,
+                                     QemuOpts *opts, Error **errp)
+{
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
+    if (prealloc !=3D PREALLOC_MODE_OFF) {
+        error_setg(errp, "Unsupported preallocation mode '%s'",
+                   PreallocMode_str(prealloc));
+        return -ENOTSUP;
+    }
+
+    qdict_put_str(options, "driver", drv->format_name);
+
+    blk =3D blk_new_open(filename, NULL, options,
+                       BDRV_O_RDWR | BDRV_O_RESIZE, errp);
+    if (!blk) {
+        error_prepend(errp, "Protocol driver '%s' does not support image "
+                      "creation, and opening the image failed: ",
+                      drv->format_name);
+        return -EINVAL;
+    }
+
+    size =3D create_file_fallback_truncate(blk, size, errp);
+    if (size < 0) {
+        ret =3D size;
+        goto out;
+    }
+
+    ret =3D create_file_fallback_zero_first_sector(blk, size, errp);
+    if (ret < 0) {
+        goto out;
+    }
+
+    ret =3D 0;
+out:
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
@@ -1422,6 +1541,24 @@ QemuOptsList bdrv_runtime_opts =3D {
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
@@ -5749,15 +5886,13 @@ void bdrv_img_create(const char *filename, const ch=
ar *fmt,
         return;
     }
=20
-    if (!proto_drv->create_opts) {
-        error_setg(errp, "Protocol driver '%s' does not support image crea=
tion",
-                   proto_drv->format_name);
-        return;
-    }
-
     /* Create parameter list */
     create_opts =3D qemu_opts_append(create_opts, drv->create_opts);
-    create_opts =3D qemu_opts_append(create_opts, proto_drv->create_opts);
+    if (proto_drv->create_opts) {
+        create_opts =3D qemu_opts_append(create_opts, proto_drv->create_op=
ts);
+    } else {
+        create_opts =3D qemu_opts_append(create_opts, &fallback_create_opt=
s);
+    }
=20
     opts =3D qemu_opts_create(create_opts, NULL, 0, &error_abort);
=20
--=20
2.24.1


