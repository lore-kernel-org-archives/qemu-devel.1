Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0812C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 16:20:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A1C422CE9
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 16:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A1C422CE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzkOG-0004pA-8X
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 12:20:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35246)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1hzkLh-0002hS-7t
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 12:17:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hzkLf-0006EM-S1
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 12:17:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38264)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hzkLb-0006BK-5f; Mon, 19 Aug 2019 12:17:33 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 819AE11A1B;
 Mon, 19 Aug 2019 16:17:29 +0000 (UTC)
Received: from localhost (ovpn-204-64.brq.redhat.com [10.40.204.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EE60E859CE;
 Mon, 19 Aug 2019 16:17:27 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 19 Aug 2019 18:17:07 +0200
Message-Id: <20190819161723.7746-2-mreitz@redhat.com>
In-Reply-To: <20190819161723.7746-1-mreitz@redhat.com>
References: <20190819161723.7746-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Mon, 19 Aug 2019 16:17:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 01/17] LUKS: support preallocation
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Maxim Levitsky <mlevitsk@redhat.com>

preallocation=3Doff and preallocation=3Dmetadata
both allocate luks header only, and preallocation=3Dfalloc/full
is passed to underlying file.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1534951

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Message-id: 20190716161901.1430-1-mlevitsk@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json |  6 +++++-
 block/crypto.c       | 30 +++++++++++++++++++++++++++---
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index e9364a4a29..a5ab38db99 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4212,13 +4212,17 @@
 #
 # @file             Node to create the image format on
 # @size             Size of the virtual disk in bytes
+# @preallocation    Preallocation mode for the new image
+#                   (since: 4.2)
+#                   (default: off; allowed values: off, metadata, falloc=
, full)
 #
 # Since: 2.12
 ##
 { 'struct': 'BlockdevCreateOptionsLUKS',
   'base': 'QCryptoBlockCreateOptionsLUKS',
   'data': { 'file':             'BlockdevRef',
-            'size':             'size' } }
+            'size':             'size',
+            '*preallocation':   'PreallocMode' } }
=20
 ##
 # @BlockdevCreateOptionsNfs:
diff --git a/block/crypto.c b/block/crypto.c
index 8237424ae6..7eb698774e 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -74,6 +74,7 @@ static ssize_t block_crypto_read_func(QCryptoBlock *blo=
ck,
 struct BlockCryptoCreateData {
     BlockBackend *blk;
     uint64_t size;
+    PreallocMode prealloc;
 };
=20
=20
@@ -112,7 +113,7 @@ static ssize_t block_crypto_init_func(QCryptoBlock *b=
lock,
      * available to the guest, so we must take account of that
      * which will be used by the crypto header
      */
-    return blk_truncate(data->blk, data->size + headerlen, PREALLOC_MODE=
_OFF,
+    return blk_truncate(data->blk, data->size + headerlen, data->preallo=
c,
                         errp);
 }
=20
@@ -251,6 +252,7 @@ static int block_crypto_open_generic(QCryptoBlockForm=
at format,
 static int block_crypto_co_create_generic(BlockDriverState *bs,
                                           int64_t size,
                                           QCryptoBlockCreateOptions *opt=
s,
+                                          PreallocMode prealloc,
                                           Error **errp)
 {
     int ret;
@@ -266,9 +268,14 @@ static int block_crypto_co_create_generic(BlockDrive=
rState *bs,
         goto cleanup;
     }
=20
+    if (prealloc =3D=3D PREALLOC_MODE_METADATA) {
+        prealloc =3D PREALLOC_MODE_OFF;
+    }
+
     data =3D (struct BlockCryptoCreateData) {
         .blk =3D blk,
         .size =3D size,
+        .prealloc =3D prealloc,
     };
=20
     crypto =3D qcrypto_block_create(opts, NULL,
@@ -500,6 +507,7 @@ block_crypto_co_create_luks(BlockdevCreateOptions *cr=
eate_options, Error **errp)
     BlockdevCreateOptionsLUKS *luks_opts;
     BlockDriverState *bs =3D NULL;
     QCryptoBlockCreateOptions create_opts;
+    PreallocMode preallocation =3D PREALLOC_MODE_OFF;
     int ret;
=20
     assert(create_options->driver =3D=3D BLOCKDEV_DRIVER_LUKS);
@@ -515,8 +523,12 @@ block_crypto_co_create_luks(BlockdevCreateOptions *c=
reate_options, Error **errp)
         .u.luks =3D *qapi_BlockdevCreateOptionsLUKS_base(luks_opts),
     };
=20
+    if (luks_opts->has_preallocation) {
+        preallocation =3D luks_opts->preallocation;
+    }
+
     ret =3D block_crypto_co_create_generic(bs, luks_opts->size, &create_=
opts,
-                                         errp);
+                                         preallocation, errp);
     if (ret < 0) {
         goto fail;
     }
@@ -534,12 +546,24 @@ static int coroutine_fn block_crypto_co_create_opts=
_luks(const char *filename,
     QCryptoBlockCreateOptions *create_opts =3D NULL;
     BlockDriverState *bs =3D NULL;
     QDict *cryptoopts;
+    PreallocMode prealloc;
+    char *buf =3D NULL;
     int64_t size;
     int ret;
+    Error *local_err =3D NULL;
=20
     /* Parse options */
     size =3D qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0);
=20
+    buf =3D qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
+    prealloc =3D qapi_enum_parse(&PreallocMode_lookup, buf,
+                               PREALLOC_MODE_OFF, &local_err);
+    g_free(buf);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return -EINVAL;
+    }
+
     cryptoopts =3D qemu_opts_to_qdict_filtered(opts, NULL,
                                              &block_crypto_create_opts_l=
uks,
                                              true);
@@ -565,7 +589,7 @@ static int coroutine_fn block_crypto_co_create_opts_l=
uks(const char *filename,
     }
=20
     /* Create format layer */
-    ret =3D block_crypto_co_create_generic(bs, size, create_opts, errp);
+    ret =3D block_crypto_co_create_generic(bs, size, create_opts, preall=
oc, errp);
     if (ret < 0) {
         goto fail;
     }
--=20
2.21.0


