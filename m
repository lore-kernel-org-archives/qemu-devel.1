Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428F9C76188
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 07:14:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 056992238C
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 07:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 056992238C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpozt-0002D5-Uo
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 03:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38454)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sgarzare@redhat.com>) id 1hpozi-0001gv-T6
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 03:13:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1hpozh-0007Ki-9c
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 03:13:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44980)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>)
 id 1hpoze-0007J1-11; Tue, 23 Jul 2019 03:13:50 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0E1103179174;
 Tue, 23 Jul 2019 07:13:49 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-117-26.ams2.redhat.com
 [10.36.117.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 944BB19C59;
 Tue, 23 Jul 2019 07:13:43 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 23 Jul 2019 09:13:42 +0200
Message-Id: <20190723071342.383909-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Tue, 23 Jul 2019 07:13:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3] block/rbd: add preallocation support
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Jason Dillaman <dillaman@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds the support of preallocation (off/full) for the RBD
block driver.
If rbd_writesame() is available and supports zeroed buffers, we use
it to quickly fill the image when full preallocation is required.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v3:
 - rebased on master
 - filled with zeroed buffer [Max]
 - used rbd_writesame() only when we can disable the discard of zeroed
   buffers
 - added 'since: 4.2' in qapi/block-core.json [Max]
 - used buffer as large as the "stripe unit"
---
 block/rbd.c          | 202 ++++++++++++++++++++++++++++++++++++++++---
 qapi/block-core.json |   5 +-
 2 files changed, 192 insertions(+), 15 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index 59757b3120..d923a5a26c 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -64,6 +64,7 @@
 #define OBJ_MAX_SIZE (1UL << OBJ_DEFAULT_OBJ_ORDER)
=20
 #define RBD_MAX_SNAPS 100
+#define RBD_DEFAULT_CONCURRENT_OPS 10
=20
 /* The LIBRBD_SUPPORTS_IOVEC is defined in librbd.h */
 #ifdef LIBRBD_SUPPORTS_IOVEC
@@ -104,6 +105,7 @@ typedef struct BDRVRBDState {
     char *image_name;
     char *snap;
     uint64_t image_size;
+    bool ws_zero_supported; /* rbd_writesame() supports zeroed buffers *=
/
 } BDRVRBDState;
=20
 static int qemu_rbd_connect(rados_t *cluster, rados_ioctx_t *io_ctx,
@@ -333,6 +335,155 @@ static void qemu_rbd_memset(RADOSCB *rcb, int64_t o=
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
+                                bool ws_zero_supported, Error **errp)
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
+        uint64_t buf_size, current_offset =3D current_length;
+        ssize_t bytes;
+
+        ret =3D rbd_get_stripe_unit(image, &buf_size);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "Failed to get stripe unit");
+            goto out;
+        }
+
+        ret =3D rbd_resize(image, offset);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "Failed to resize file");
+            goto out;
+        }
+
+        buf =3D g_malloc0(buf_size);
+
+#ifdef LIBRBD_SUPPORTS_WRITESAME
+        if (ws_zero_supported) {
+            uint64_t writesame_max_size;
+            int max_concurrent_ops;
+
+            max_concurrent_ops =3D qemu_rbd_get_max_concurrent_ops(clust=
er);
+            /*
+             * We limit the rbd_writesame() size to avoid to spawn more =
then
+             * 'rbd_concurrent_management_ops' concurrent operations.
+             */
+            writesame_max_size =3D MIN(buf_size * max_concurrent_ops, IN=
T_MAX);
+
+            while (offset - current_offset > buf_size) {
+                bytes =3D MIN(offset - current_offset, writesame_max_siz=
e);
+                /*
+                 * rbd_writesame() supports only request where the size =
of the
+                 * operation is multiple of buffer size.
+                 */
+                bytes -=3D bytes % buf_size;
+
+                bytes =3D rbd_writesame(image, current_offset, bytes, bu=
f,
+                                      buf_size, 0);
+                if (bytes < 0) {
+                    ret =3D bytes;
+                    error_setg_errno(errp, -ret,
+                                     "Failed to write for preallocation"=
);
+                    goto out;
+                }
+
+                current_offset +=3D bytes;
+            }
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
+static bool qemu_rbd_writesame_zero_supported(rados_t *cluster)
+{
+    int ret =3D 1;
+
+#ifdef LIBRBD_SUPPORTS_WRITESAME
+    /*
+     * When "rbd_discard_on_zeroed_write_same" is not available, rbd_wri=
tesame()
+     * can discard requests with zeroed buffer.
+     */
+    ret =3D rados_conf_set(*cluster, "rbd_discard_on_zeroed_write_same",=
 "false");
+#endif
+
+    return ret =3D=3D 0;
+}
+
 static QemuOptsList runtime_opts =3D {
     .name =3D "rbd",
     .head =3D QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
@@ -378,6 +529,7 @@ static int qemu_rbd_do_create(BlockdevCreateOptions *=
options,
     BlockdevCreateOptionsRbd *opts =3D &options->u.rbd;
     rados_t cluster;
     rados_ioctx_t io_ctx;
+    rbd_image_t image;
     int obj_order =3D 0;
     int ret;
=20
@@ -406,13 +558,23 @@ static int qemu_rbd_do_create(BlockdevCreateOptions=
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
+                               qemu_rbd_writesame_zero_supported(&cluste=
r),
+                               errp);
+
+    rbd_close(image);
 out:
     rados_ioctx_destroy(io_ctx);
     rados_shutdown(cluster);
@@ -433,6 +595,7 @@ static int coroutine_fn qemu_rbd_co_create_opts(const=
 char *filename,
     BlockdevOptionsRbd *loc;
     Error *local_err =3D NULL;
     const char *keypairs, *password_secret;
+    char *prealloc;
     QDict *options =3D NULL;
     int ret =3D 0;
=20
@@ -451,6 +614,16 @@ static int coroutine_fn qemu_rbd_co_create_opts(cons=
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
@@ -770,6 +943,7 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict =
*options, int flags,
=20
     s->snap =3D g_strdup(opts->snapshot);
     s->image_name =3D g_strdup(opts->image);
+    s->ws_zero_supported =3D qemu_rbd_writesame_zero_supported(&s->clust=
er);
=20
     /* rbd_open is always r/w */
     r =3D rbd_open(s->io_ctx, s->image_name, &s->image, s->snap);
@@ -1089,21 +1263,16 @@ static int coroutine_fn qemu_rbd_co_truncate(Bloc=
kDriverState *bs,
                                              PreallocMode prealloc,
                                              Error **errp)
 {
-    int r;
-
-    if (prealloc !=3D PREALLOC_MODE_OFF) {
-        error_setg(errp, "Unsupported preallocation mode '%s'",
-                   PreallocMode_str(prealloc));
-        return -ENOTSUP;
-    }
+    BDRVRBDState *s =3D bs->opaque;
+    int ret;
=20
-    r =3D qemu_rbd_resize(bs, offset);
-    if (r < 0) {
-        error_setg_errno(errp, -r, "Failed to resize file");
-        return r;
+    ret =3D qemu_rbd_do_truncate(s->cluster, s->image, offset, prealloc,
+                               s->ws_zero_supported, errp);
+    if (ret =3D=3D 0) {
+        s->image_size =3D offset;
     }
=20
-    return 0;
+    return ret;
 }
=20
 static int qemu_rbd_snap_create(BlockDriverState *bs,
@@ -1256,6 +1425,11 @@ static QemuOptsList qemu_rbd_create_opts =3D {
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
index 0d43d4f37c..ff55171f8d 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4346,13 +4346,16 @@
 #                   point to a snapshot.
 # @size             Size of the virtual disk in bytes
 # @cluster-size     RBD object size
+# @preallocation    Preallocation mode for the new image (since: 4.2)
+#                   (default: off; allowed values: off, full)
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


