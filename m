Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98ACC04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 12:24:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C47420675
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 12:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C47420675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55857 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNcfU-0006Iq-T9
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 08:24:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hNceZ-0005zR-La
	for qemu-devel@nongnu.org; Mon, 06 May 2019 08:23:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hNceY-0005pZ-6U
	for qemu-devel@nongnu.org; Mon, 06 May 2019 08:23:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>)
	id 1hNceU-0005ny-Sw; Mon, 06 May 2019 08:23:27 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 026AAC04FFFA;
	Mon,  6 May 2019 12:23:26 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-116-97.ams2.redhat.com
	[10.36.116.97])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0407760C43;
	Mon,  6 May 2019 12:23:23 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  6 May 2019 14:23:22 +0200
Message-Id: <20190506122322.90035-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Mon, 06 May 2019 12:23:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2] block/rbd: add preallocation support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Josh Durgin <jdurgin@redhat.com>,
	qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
	Max Reitz <mreitz@redhat.com>, Jason Dillaman <jdillama@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds the support of preallocation (off/full) for the RBD
block driver.
If available, we use rbd_writesame() to quickly fill the image when
full preallocation is required.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v2:
- Use 4 KiB buffer for rbd_writesame() [Jason]
- Use "rbd_concurrent_management_ops" and "stripe_unit" to limit
  concurrent ops to the backing cluster [Jason]
---
 block/rbd.c          | 188 +++++++++++++++++++++++++++++++++++++++----
 qapi/block-core.json |   4 +-
 2 files changed, 175 insertions(+), 17 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index 0c549c9935..bc54395e1c 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -13,6 +13,7 @@
=20
 #include "qemu/osdep.h"
=20
+#include "qemu/units.h"
 #include <rbd/librbd.h>
 #include "qapi/error.h"
 #include "qemu/error-report.h"
@@ -63,6 +64,7 @@
 #define OBJ_MAX_SIZE (1UL << OBJ_DEFAULT_OBJ_ORDER)
=20
 #define RBD_MAX_SNAPS 100
+#define RBD_DEFAULT_CONCURRENT_OPS 10
=20
 /* The LIBRBD_SUPPORTS_IOVEC is defined in librbd.h */
 #ifdef LIBRBD_SUPPORTS_IOVEC
@@ -331,6 +333,147 @@ static void qemu_rbd_memset(RADOSCB *rcb, int64_t o=
ffs)
     }
 }
=20
+static int qemu_rbd_get_max_concurrent_ops(rados_t cluster)
+{
+    char buf[16];
+    int ret, max_concurrent_ops;
+
+    ret =3D rados_conf_get(cluster, "rbd_concurrent_management_ops", buf=
,
+                         sizeof(buf));
+    if (ret < 0) {
+        return RBD_DEFAULT_CONCURRENT_OPS;
+    }
+
+    ret =3D qemu_strtoi(buf, NULL, 10, &max_concurrent_ops);
+    if (ret < 0) {
+        return RBD_DEFAULT_CONCURRENT_OPS;
+    }
+
+    return max_concurrent_ops;
+}
+
+static int qemu_rbd_do_truncate(rados_t cluster, rbd_image_t image,
+                                int64_t offset, PreallocMode prealloc,
+                                Error **errp)
+{
+    uint64_t current_length;
+    char *buf =3D NULL;
+    int ret;
+
+    ret =3D rbd_get_size(image, &current_length);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to get file length");
+        goto out;
+    }
+
+    if (current_length > offset && prealloc !=3D PREALLOC_MODE_OFF) {
+        error_setg(errp, "Cannot use preallocation for shrinking files")=
;
+        ret =3D -ENOTSUP;
+        goto out;
+    }
+
+    switch (prealloc) {
+    case PREALLOC_MODE_FULL: {
+        uint64_t current_offset =3D current_length;
+        int buf_size =3D 4 * KiB;
+        ssize_t bytes;
+
+#ifdef LIBRBD_SUPPORTS_WRITESAME
+        uint64_t stripe_unit, writesame_max_size;
+        int max_concurrent_ops;
+
+        max_concurrent_ops =3D qemu_rbd_get_max_concurrent_ops(cluster);
+        ret =3D rbd_get_stripe_unit(image, &stripe_unit);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "Failed to get stripe unit");
+            goto out;
+        }
+
+        /*
+         * We limit the rbd_writesame() size to avoid to spawn more then
+         * 'rbd_concurrent_management_ops' concurrent operations.
+         */
+        writesame_max_size =3D MIN(stripe_unit * max_concurrent_ops, INT=
_MAX);
+#endif /* LIBRBD_SUPPORTS_WRITESAME */
+
+        buf =3D g_malloc(buf_size);
+        /*
+         * Some versions of rbd_writesame() discards writes of buffers w=
ith
+         * all zeroes. In order to avoid this behaviour, we set the firs=
t byte
+         * to one.
+         */
+        buf[0] =3D 1;
+
+        ret =3D rbd_resize(image, offset);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "Failed to resize file");
+            goto out;
+        }
+
+#ifdef LIBRBD_SUPPORTS_WRITESAME
+        while (offset - current_offset > buf_size) {
+            bytes =3D MIN(offset - current_offset, writesame_max_size);
+            /*
+             * rbd_writesame() supports only request where the size of t=
he
+             * operation is multiple of buffer size.
+             */
+            bytes -=3D bytes % buf_size;
+
+            bytes =3D rbd_writesame(image, current_offset, bytes, buf, b=
uf_size,
+                                  0);
+            if (bytes < 0) {
+                ret =3D bytes;
+                error_setg_errno(errp, -ret,
+                                 "Failed to write for preallocation");
+                goto out;
+            }
+
+            current_offset +=3D bytes;
+        }
+#endif /* LIBRBD_SUPPORTS_WRITESAME */
+
+        while (current_offset < offset) {
+            bytes =3D rbd_write(image, current_offset,
+                              MIN(offset - current_offset, buf_size), bu=
f);
+            if (bytes < 0) {
+                ret =3D bytes;
+                error_setg_errno(errp, -ret,
+                                 "Failed to write for preallocation");
+                goto out;
+            }
+
+            current_offset +=3D bytes;
+        }
+
+        ret =3D rbd_flush(image);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "Failed to flush the file");
+            goto out;
+        }
+
+        break;
+    }
+    case PREALLOC_MODE_OFF:
+        ret =3D rbd_resize(image, offset);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "Failed to resize file");
+            goto out;
+        }
+        break;
+    default:
+        error_setg(errp, "Unsupported preallocation mode: %s",
+                   PreallocMode_str(prealloc));
+        ret =3D -ENOTSUP;
+        goto out;
+    }
+
+    ret =3D 0;
+
+out:
+    g_free(buf);
+    return ret;
+}
+
 static QemuOptsList runtime_opts =3D {
     .name =3D "rbd",
     .head =3D QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
@@ -376,6 +519,7 @@ static int qemu_rbd_do_create(BlockdevCreateOptions *=
options,
     BlockdevCreateOptionsRbd *opts =3D &options->u.rbd;
     rados_t cluster;
     rados_ioctx_t io_ctx;
+    rbd_image_t image;
     int obj_order =3D 0;
     int ret;
=20
@@ -404,13 +548,22 @@ static int qemu_rbd_do_create(BlockdevCreateOptions=
 *options,
         return ret;
     }
=20
-    ret =3D rbd_create(io_ctx, opts->location->image, opts->size, &obj_o=
rder);
+    ret =3D rbd_create(io_ctx, opts->location->image, 0, &obj_order);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "error rbd create");
         goto out;
     }
=20
-    ret =3D 0;
+    ret =3D rbd_open(io_ctx, opts->location->image, &image, NULL);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "error rbd open");
+        goto out;
+    }
+
+    ret =3D qemu_rbd_do_truncate(cluster, image, opts->size, opts->preal=
location,
+                               errp);
+
+    rbd_close(image);
 out:
     rados_ioctx_destroy(io_ctx);
     rados_shutdown(cluster);
@@ -431,6 +584,7 @@ static int coroutine_fn qemu_rbd_co_create_opts(const=
 char *filename,
     BlockdevOptionsRbd *loc;
     Error *local_err =3D NULL;
     const char *keypairs, *password_secret;
+    char *prealloc;
     QDict *options =3D NULL;
     int ret =3D 0;
=20
@@ -449,6 +603,16 @@ static int coroutine_fn qemu_rbd_co_create_opts(cons=
t char *filename,
                                                    BLOCK_OPT_CLUSTER_SIZ=
E, 0);
     rbd_opts->has_cluster_size =3D (rbd_opts->cluster_size !=3D 0);
=20
+    prealloc =3D qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
+    rbd_opts->preallocation =3D qapi_enum_parse(&PreallocMode_lookup, pr=
ealloc,
+                                              PREALLOC_MODE_OFF, &local_=
err);
+    g_free(prealloc);
+    if (local_err) {
+        ret =3D -EINVAL;
+        error_propagate(errp, local_err);
+        goto exit;
+    }
+
     options =3D qdict_new();
     qemu_rbd_parse_filename(filename, options, &local_err);
     if (local_err) {
@@ -1052,21 +1216,8 @@ static int coroutine_fn qemu_rbd_co_truncate(Block=
DriverState *bs,
                                              Error **errp)
 {
     BDRVRBDState *s =3D bs->opaque;
-    int r;
=20
-    if (prealloc !=3D PREALLOC_MODE_OFF) {
-        error_setg(errp, "Unsupported preallocation mode '%s'",
-                   PreallocMode_str(prealloc));
-        return -ENOTSUP;
-    }
-
-    r =3D rbd_resize(s->image, offset);
-    if (r < 0) {
-        error_setg_errno(errp, -r, "Failed to resize file");
-        return r;
-    }
-
-    return 0;
+    return qemu_rbd_do_truncate(s->cluster, s->image, offset, prealloc, =
errp);
 }
=20
 static int qemu_rbd_snap_create(BlockDriverState *bs,
@@ -1219,6 +1370,11 @@ static QemuOptsList qemu_rbd_create_opts =3D {
             .type =3D QEMU_OPT_SIZE,
             .help =3D "RBD object size"
         },
+        {
+            .name =3D BLOCK_OPT_PREALLOC,
+            .type =3D QEMU_OPT_STRING,
+            .help =3D "Preallocation mode (allowed values: off, full)"
+        },
         {
             .name =3D "password-secret",
             .type =3D QEMU_OPT_STRING,
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 7ccbfff9d0..db25a4065b 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4277,13 +4277,15 @@
 #                   point to a snapshot.
 # @size             Size of the virtual disk in bytes
 # @cluster-size     RBD object size
+# @preallocation    Preallocation mode (allowed values: off, full)
 #
 # Since: 2.12
 ##
 { 'struct': 'BlockdevCreateOptionsRbd',
   'data': { 'location':         'BlockdevOptionsRbd',
             'size':             'size',
-            '*cluster-size' :   'size' } }
+            '*cluster-size' :   'size',
+            '*preallocation':   'PreallocMode' } }
=20
 ##
 # @BlockdevVmdkSubformat:
--=20
2.20.1


