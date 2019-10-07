Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9890C47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 12:23:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DCB6206BB
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 12:23:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DCB6206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHS31-0005N6-EZ
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 08:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48129)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iHRql-00028z-7n
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 08:10:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iHRqj-0004No-N5
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 08:10:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50560)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1iHRqc-0004B2-LP; Mon, 07 Oct 2019 08:10:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D39621056FB5;
 Mon,  7 Oct 2019 12:10:41 +0000 (UTC)
Received: from localhost (unknown [10.36.118.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 34CC960A9D;
 Mon,  7 Oct 2019 12:10:34 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/16] block/file-posix.c: extend to use io_uring
Date: Mon,  7 Oct 2019 13:09:29 +0100
Message-Id: <20191007120937.5862-9-stefanha@redhat.com>
In-Reply-To: <20191007120937.5862-1-stefanha@redhat.com>
References: <20191007120937.5862-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Mon, 07 Oct 2019 12:10:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
 Julia Suvorova <jusual@mail.ru>, Julia Suvorova <jusual@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aarushi Mehta <mehta.aaru20@gmail.com>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
Reviewed-by: Maxim Levitsky <maximlevitsky@gmail.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/file-posix.c | 99 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 79 insertions(+), 20 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index f12c06de2d..264c44fc3f 100644
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
@@ -439,7 +440,7 @@ static QemuOptsList raw_runtime_opts =3D {
         {
             .name =3D "aio",
             .type =3D QEMU_OPT_STRING,
-            .help =3D "host AIO implementation (threads, native)",
+            .help =3D "host AIO implementation (threads, native, io_urin=
g)",
         },
         {
             .name =3D "locking",
@@ -498,9 +499,15 @@ static int raw_open_common(BlockDriverState *bs, QDi=
ct *options,
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
     aio =3D qapi_enum_parse(&BlockdevAioOptions_lookup,
                           qemu_opt_get(opts, "aio"),
                           aio_default, &local_err);
@@ -509,7 +516,11 @@ static int raw_open_common(BlockDriverState *bs, QDi=
ct *options,
         ret =3D -EINVAL;
         goto fail;
     }
+
     s->use_linux_aio =3D (aio =3D=3D BLOCKDEV_AIO_OPTIONS_NATIVE);
+#ifdef CONFIG_LINUX_IO_URING
+    s->use_linux_io_uring =3D (aio =3D=3D BLOCKDEV_AIO_OPTIONS_IO_URING)=
;
+#endif
=20
     locking =3D qapi_enum_parse(&OnOffAuto_lookup,
                               qemu_opt_get(opts, "locking"),
@@ -573,7 +584,7 @@ static int raw_open_common(BlockDriverState *bs, QDic=
t *options,
     s->shared_perm =3D BLK_PERM_ALL;
=20
 #ifdef CONFIG_LINUX_AIO
-     /* Currently Linux does AIO only for files opened with O_DIRECT */
+    /* Currently Linux does AIO only for files opened with O_DIRECT */
     if (s->use_linux_aio) {
         if (!(s->open_flags & O_DIRECT)) {
             error_setg(errp, "aio=3Dnative was specified, but it require=
s "
@@ -595,6 +606,22 @@ static int raw_open_common(BlockDriverState *bs, QDi=
ct *options,
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
+        error_setg(errp, "aio=3Dio_uring was specified, but is not suppo=
rted "
+                         "in this build.");
+        ret =3D -EINVAL;
+        goto fail;
+    }
+#endif /* !defined(CONFIG_LINUX_IO_URING) */
+
     s->has_discard =3D true;
     s->has_write_zeroes =3D true;
     if ((bs->open_flags & BDRV_O_NOCACHE) !=3D 0) {
@@ -1871,21 +1898,25 @@ static int coroutine_fn raw_co_prw(BlockDriverSta=
te *bs, uint64_t offset,
         return -EIO;
=20
     /*
-     * Check if the underlying device requires requests to be aligned,
-     * and if the request we are trying to submit is aligned or not.
-     * If this is the case tell the low-level driver that it needs
-     * to copy the buffer.
+     * When using O_DIRECT, the request must be aligned to be able to us=
e
+     * either libaio or io_uring interface. If not fail back to regular =
thread
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
+        LuringState *aio =3D aio_get_linux_io_uring(bdrv_get_aio_context=
(bs));
+        assert(qiov->size =3D=3D bytes);
+        return luring_co_submit(bs, aio, s->fd, offset, qiov, type);
+#endif
 #ifdef CONFIG_LINUX_AIO
-        } else if (s->use_linux_aio) {
-            LinuxAioState *aio =3D aio_get_linux_aio(bdrv_get_aio_contex=
t(bs));
-            assert(qiov->size =3D=3D bytes);
-            return laio_co_submit(bs, aio, s->fd, offset, qiov, type);
+    } else if (s->use_linux_aio) {
+        LinuxAioState *aio =3D aio_get_linux_aio(bdrv_get_aio_context(bs=
));
+        assert(qiov->size =3D=3D bytes);
+        return laio_co_submit(bs, aio, s->fd, offset, qiov, type);
 #endif
-        }
     }
=20
     acb =3D (RawPosixAIOData) {
@@ -1921,24 +1952,36 @@ static int coroutine_fn raw_co_pwritev(BlockDrive=
rState *bs, uint64_t offset,
=20
 static void raw_aio_plug(BlockDriverState *bs)
 {
+    BDRVRawState __attribute__((unused)) *s =3D bs->opaque;
 #ifdef CONFIG_LINUX_AIO
-    BDRVRawState *s =3D bs->opaque;
     if (s->use_linux_aio) {
         LinuxAioState *aio =3D aio_get_linux_aio(bdrv_get_aio_context(bs=
));
         laio_io_plug(bs, aio);
     }
 #endif
+#ifdef CONFIG_LINUX_IO_URING
+    if (s->use_linux_io_uring) {
+        LuringState *aio =3D aio_get_linux_io_uring(bdrv_get_aio_context=
(bs));
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
         LinuxAioState *aio =3D aio_get_linux_aio(bdrv_get_aio_context(bs=
));
         laio_io_unplug(bs, aio);
     }
 #endif
+#ifdef CONFIG_LINUX_IO_URING
+    if (s->use_linux_io_uring) {
+        LuringState *aio =3D aio_get_linux_io_uring(bdrv_get_aio_context=
(bs));
+        luring_io_unplug(bs, aio);
+    }
+#endif
 }
=20
 static int raw_co_flush_to_disk(BlockDriverState *bs)
@@ -1958,14 +2001,20 @@ static int raw_co_flush_to_disk(BlockDriverState =
*bs)
         .aio_type       =3D QEMU_AIO_FLUSH,
     };
=20
+#ifdef CONFIG_LINUX_IO_URING
+    if (s->use_linux_io_uring) {
+        LuringState *aio =3D aio_get_linux_io_uring(bdrv_get_aio_context=
(bs));
+        return luring_co_submit(bs, aio, s->fd, 0, NULL, QEMU_AIO_FLUSH)=
;
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
         Error *local_err;
         if (!aio_setup_linux_aio(new_context, &local_err)) {
@@ -1975,6 +2024,16 @@ static void raw_aio_attach_aio_context(BlockDriver=
State *bs,
         }
     }
 #endif
+#ifdef CONFIG_LINUX_IO_URING
+    if (s->use_linux_io_uring) {
+        Error *local_err;
+        if (!aio_setup_linux_io_uring(new_context, &local_err)) {
+            error_reportf_err(local_err, "Unable to use linux io_uring, =
"
+                                         "falling back to thread pool: "=
);
+            s->use_linux_io_uring =3D false;
+        }
+    }
+#endif
 }
=20
 static void raw_close(BlockDriverState *bs)
--=20
2.21.0


