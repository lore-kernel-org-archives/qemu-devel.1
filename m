Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4518EC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 14:23:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E6EE20678
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 14:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MTwT61vi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E6EE20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itXxg-0002l3-Jn
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 09:23:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39961)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1itXuk-0007Q5-Kt
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:20:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1itXug-0006Oz-KJ
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:20:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58221
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1itXug-0006Oe-FR
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:20:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579530022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=viQq/3zVgkeAg3g8w0rxue+f/NvZPq/Ufyv3yRiAgzc=;
 b=MTwT61vi0xlIjcmnatGfKhyxeKg6AVHVU3Ge2I80DhTbEks/YxesoEGmUcUiYrNsRTxES6
 DuA4wFatQLid+MqJH9bBpKF5ASJflEhpLgq5tST7OP6okKR6qsOkuTvUx+YQ6wvVZrcpv9
 yzEah5CwGstkaDDwrPymYU89GNJgTzA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-1T2mc5ZRPruIlGaDz3WKBA-1; Mon, 20 Jan 2020 09:20:20 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 436FB8017CC;
 Mon, 20 Jan 2020 14:20:19 +0000 (UTC)
Received: from localhost (ovpn-117-223.ams2.redhat.com [10.36.117.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A0AC460C05;
 Mon, 20 Jan 2020 14:20:11 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 08/15] block/file-posix.c: extend to use io_uring
Date: Mon, 20 Jan 2020 14:18:51 +0000
Message-Id: <20200120141858.587874-9-stefanha@redhat.com>
In-Reply-To: <20200120141858.587874-1-stefanha@redhat.com>
References: <20200120141858.587874-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 1T2mc5ZRPruIlGaDz3WKBA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: oleksandr@redhat.com, Kevin Wolf <kwolf@redhat.com>,
 Maxim Levitsky <maximlevitsky@gmail.com>, qemu-block@nongnu.org,
 Julia Suvorova <jusual@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Aarushi Mehta <mehta.aaru20@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aarushi Mehta <mehta.aaru20@gmail.com>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
Reviewed-by: Maxim Levitsky <maximlevitsky@gmail.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
v5:
 * Add back BDRV_O_IO_URING check that was dropped accidentally in v3
   [Kevin]
---
 block/file-posix.c | 98 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 79 insertions(+), 19 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 1b805bd938..f4e6e4d33e 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -156,6 +156,7 @@ typedef struct BDRVRawState {
     bool has_write_zeroes:1;
     bool discard_zeroes:1;
     bool use_linux_aio:1;
+    bool use_linux_io_uring:1;
     bool page_cache_inconsistent:1;
     bool has_fallocate;
     bool needs_alignment;
@@ -444,7 +445,7 @@ static QemuOptsList raw_runtime_opts =3D {
         {
             .name =3D "aio",
             .type =3D QEMU_OPT_STRING,
-            .help =3D "host AIO implementation (threads, native)",
+            .help =3D "host AIO implementation (threads, native, io_uring)=
",
         },
         {
             .name =3D "locking",
@@ -503,9 +504,16 @@ static int raw_open_common(BlockDriverState *bs, QDict=
 *options,
         goto fail;
     }
=20
-    aio_default =3D (bdrv_flags & BDRV_O_NATIVE_AIO)
-                  ? BLOCKDEV_AIO_OPTIONS_NATIVE
-                  : BLOCKDEV_AIO_OPTIONS_THREADS;
+    if (bdrv_flags & BDRV_O_NATIVE_AIO) {
+        aio_default =3D BLOCKDEV_AIO_OPTIONS_NATIVE;
+#ifdef CONFIG_LINUX_IO_URING
+    } else if (bdrv_flags & BDRV_O_IO_URING) {
+        aio_default =3D BLOCKDEV_AIO_OPTIONS_IO_URING;
+#endif
+    } else {
+        aio_default =3D BLOCKDEV_AIO_OPTIONS_THREADS;
+    }
+
     aio =3D qapi_enum_parse(&BlockdevAioOptions_lookup,
                           qemu_opt_get(opts, "aio"),
                           aio_default, &local_err);
@@ -514,7 +522,11 @@ static int raw_open_common(BlockDriverState *bs, QDict=
 *options,
         ret =3D -EINVAL;
         goto fail;
     }
+
     s->use_linux_aio =3D (aio =3D=3D BLOCKDEV_AIO_OPTIONS_NATIVE);
+#ifdef CONFIG_LINUX_IO_URING
+    s->use_linux_io_uring =3D (aio =3D=3D BLOCKDEV_AIO_OPTIONS_IO_URING);
+#endif
=20
     locking =3D qapi_enum_parse(&OnOffAuto_lookup,
                               qemu_opt_get(opts, "locking"),
@@ -600,6 +612,22 @@ static int raw_open_common(BlockDriverState *bs, QDict=
 *options,
     }
 #endif /* !defined(CONFIG_LINUX_AIO) */
=20
+#ifdef CONFIG_LINUX_IO_URING
+    if (s->use_linux_io_uring) {
+        if (!aio_setup_linux_io_uring(bdrv_get_aio_context(bs), errp)) {
+            error_prepend(errp, "Unable to use io_uring: ");
+            goto fail;
+        }
+    }
+#else
+    if (s->use_linux_io_uring) {
+        error_setg(errp, "aio=3Dio_uring was specified, but is not support=
ed "
+                         "in this build.");
+        ret =3D -EINVAL;
+        goto fail;
+    }
+#endif /* !defined(CONFIG_LINUX_IO_URING) */
+
     s->has_discard =3D true;
     s->has_write_zeroes =3D true;
     if ((bs->open_flags & BDRV_O_NOCACHE) !=3D 0) {
@@ -1877,21 +1905,25 @@ static int coroutine_fn raw_co_prw(BlockDriverState=
 *bs, uint64_t offset,
         return -EIO;
=20
     /*
-     * Check if the underlying device requires requests to be aligned,
-     * and if the request we are trying to submit is aligned or not.
-     * If this is the case tell the low-level driver that it needs
-     * to copy the buffer.
+     * When using O_DIRECT, the request must be aligned to be able to use
+     * either libaio or io_uring interface. If not fail back to regular th=
read
+     * pool read/write code which emulates this for us if we
+     * set QEMU_AIO_MISALIGNED.
      */
-    if (s->needs_alignment) {
-        if (!bdrv_qiov_is_aligned(bs, qiov)) {
-            type |=3D QEMU_AIO_MISALIGNED;
+    if (s->needs_alignment && !bdrv_qiov_is_aligned(bs, qiov)) {
+        type |=3D QEMU_AIO_MISALIGNED;
+#ifdef CONFIG_LINUX_IO_URING
+    } else if (s->use_linux_io_uring) {
+        LuringState *aio =3D aio_get_linux_io_uring(bdrv_get_aio_context(b=
s));
+        assert(qiov->size =3D=3D bytes);
+        return luring_co_submit(bs, aio, s->fd, offset, qiov, type);
+#endif
 #ifdef CONFIG_LINUX_AIO
-        } else if (s->use_linux_aio) {
-            LinuxAioState *aio =3D aio_get_linux_aio(bdrv_get_aio_context(=
bs));
-            assert(qiov->size =3D=3D bytes);
-            return laio_co_submit(bs, aio, s->fd, offset, qiov, type);
+    } else if (s->use_linux_aio) {
+        LinuxAioState *aio =3D aio_get_linux_aio(bdrv_get_aio_context(bs))=
;
+        assert(qiov->size =3D=3D bytes);
+        return laio_co_submit(bs, aio, s->fd, offset, qiov, type);
 #endif
-        }
     }
=20
     acb =3D (RawPosixAIOData) {
@@ -1927,24 +1959,36 @@ static int coroutine_fn raw_co_pwritev(BlockDriverS=
tate *bs, uint64_t offset,
=20
 static void raw_aio_plug(BlockDriverState *bs)
 {
+    BDRVRawState __attribute__((unused)) *s =3D bs->opaque;
 #ifdef CONFIG_LINUX_AIO
-    BDRVRawState *s =3D bs->opaque;
     if (s->use_linux_aio) {
         LinuxAioState *aio =3D aio_get_linux_aio(bdrv_get_aio_context(bs))=
;
         laio_io_plug(bs, aio);
     }
 #endif
+#ifdef CONFIG_LINUX_IO_URING
+    if (s->use_linux_io_uring) {
+        LuringState *aio =3D aio_get_linux_io_uring(bdrv_get_aio_context(b=
s));
+        luring_io_plug(bs, aio);
+    }
+#endif
 }
=20
 static void raw_aio_unplug(BlockDriverState *bs)
 {
+    BDRVRawState __attribute__((unused)) *s =3D bs->opaque;
 #ifdef CONFIG_LINUX_AIO
-    BDRVRawState *s =3D bs->opaque;
     if (s->use_linux_aio) {
         LinuxAioState *aio =3D aio_get_linux_aio(bdrv_get_aio_context(bs))=
;
         laio_io_unplug(bs, aio);
     }
 #endif
+#ifdef CONFIG_LINUX_IO_URING
+    if (s->use_linux_io_uring) {
+        LuringState *aio =3D aio_get_linux_io_uring(bdrv_get_aio_context(b=
s));
+        luring_io_unplug(bs, aio);
+    }
+#endif
 }
=20
 static int raw_co_flush_to_disk(BlockDriverState *bs)
@@ -1964,14 +2008,20 @@ static int raw_co_flush_to_disk(BlockDriverState *b=
s)
         .aio_type       =3D QEMU_AIO_FLUSH,
     };
=20
+#ifdef CONFIG_LINUX_IO_URING
+    if (s->use_linux_io_uring) {
+        LuringState *aio =3D aio_get_linux_io_uring(bdrv_get_aio_context(b=
s));
+        return luring_co_submit(bs, aio, s->fd, 0, NULL, QEMU_AIO_FLUSH);
+    }
+#endif
     return raw_thread_pool_submit(bs, handle_aiocb_flush, &acb);
 }
=20
 static void raw_aio_attach_aio_context(BlockDriverState *bs,
                                        AioContext *new_context)
 {
+    BDRVRawState __attribute__((unused)) *s =3D bs->opaque;
 #ifdef CONFIG_LINUX_AIO
-    BDRVRawState *s =3D bs->opaque;
     if (s->use_linux_aio) {
         Error *local_err =3D NULL;
         if (!aio_setup_linux_aio(new_context, &local_err)) {
@@ -1981,6 +2031,16 @@ static void raw_aio_attach_aio_context(BlockDriverSt=
ate *bs,
         }
     }
 #endif
+#ifdef CONFIG_LINUX_IO_URING
+    if (s->use_linux_io_uring) {
+        Error *local_err;
+        if (!aio_setup_linux_io_uring(new_context, &local_err)) {
+            error_reportf_err(local_err, "Unable to use linux io_uring, "
+                                         "falling back to thread pool: ");
+            s->use_linux_io_uring =3D false;
+        }
+    }
+#endif
 }
=20
 static void raw_close(BlockDriverState *bs)
--=20
2.24.1


