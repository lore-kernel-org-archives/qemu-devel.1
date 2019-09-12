Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57113C4CEC7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 22:34:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2634220830
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 22:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2634220830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8XfV-0001oQ-Nc
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 18:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42034)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i8XcU-00088a-4F
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 18:31:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i8XcS-0005yk-OL
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 18:31:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51758)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i8XcP-0005wM-IF; Thu, 12 Sep 2019 18:31:13 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E2234898105;
 Thu, 12 Sep 2019 22:31:12 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9D1805C1B2;
 Thu, 12 Sep 2019 22:31:10 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 13 Sep 2019 01:30:25 +0300
Message-Id: <20190912223028.18496-9-mlevitsk@redhat.com>
In-Reply-To: <20190912223028.18496-1-mlevitsk@redhat.com>
References: <20190912223028.18496-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Thu, 12 Sep 2019 22:31:12 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 08/11] block/crypto: implement blockdev-amend
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 block/crypto.c       | 85 ++++++++++++++++++++++++++++++++++----------
 qapi/block-core.json |  7 ++--
 2 files changed, 71 insertions(+), 21 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index f42fa057e6..5905f7f520 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -534,6 +534,17 @@ block_crypto_co_create_luks(BlockdevCreateOptions *c=
reate_options, Error **errp)
     assert(create_options->driver =3D=3D BLOCKDEV_DRIVER_LUKS);
     luks_opts =3D &create_options->u.luks;
=20
+    if (!luks_opts->has_size) {
+        error_setg(errp, "'size' is manadatory for image creation");
+        return -EINVAL;
+    }
+
+    if (!luks_opts->has_file) {
+        error_setg(errp, "'file' is manadatory for image creation");
+        return -EINVAL;
+    }
+
+
     bs =3D bdrv_open_blockdev_ref(luks_opts->file, errp);
     if (bs =3D=3D NULL) {
         return -EIO;
@@ -667,6 +678,39 @@ block_crypto_get_specific_info_luks(BlockDriverState=
 *bs, Error **errp)
 }
=20
=20
+static int
+block_crypto_amend_options_generic(BlockDriverState *bs,
+                                   QCryptoBlockCreateOptions *amend_opti=
ons,
+                                   bool force,
+                                   Error **errp)
+{
+    BlockCrypto *crypto =3D bs->opaque;
+    int ret =3D -1;
+
+    assert(crypto);
+    assert(crypto->block);
+
+    /* apply for exclusive write permissions to the underlying file*/
+    crypto->updating_keys =3D true;
+    ret =3D bdrv_child_refresh_perms(bs, bs->file, errp);
+    if (ret) {
+        goto cleanup;
+    }
+
+    ret =3D qcrypto_block_amend_options(crypto->block,
+                                      block_crypto_read_func,
+                                      block_crypto_write_func,
+                                      bs,
+                                      amend_options,
+                                      force,
+                                      errp);
+cleanup:
+    /* release exclusive write permissions to the underlying file*/
+    crypto->updating_keys =3D false;
+    bdrv_child_refresh_perms(bs, bs->file, errp);
+    return ret;
+}
+
 static int
 block_crypto_amend_options(BlockDriverState *bs,
                            QemuOpts *opts,
@@ -678,44 +722,45 @@ block_crypto_amend_options(BlockDriverState *bs,
     BlockCrypto *crypto =3D bs->opaque;
     QDict *cryptoopts =3D NULL;
     QCryptoBlockCreateOptions *amend_options =3D NULL;
-    int ret;
+    int ret =3D -EINVAL;
=20
     assert(crypto);
     assert(crypto->block);
=20
-    crypto->updating_keys =3D true;
-
-    ret =3D bdrv_child_refresh_perms(bs, bs->file, errp);
-    if (ret < 0) {
-        goto cleanup;
-    }
-
     cryptoopts =3D qemu_opts_to_qdict_filtered(opts, NULL,
                                              &block_crypto_create_opts_l=
uks,
                                              true);
=20
     qdict_put_str(cryptoopts, "format", "luks");
     amend_options =3D block_crypto_create_opts_init(cryptoopts, errp);
+
     if (!amend_options) {
-        ret =3D -EINVAL;
         goto cleanup;
     }
=20
-    ret =3D qcrypto_block_amend_options(crypto->block,
-                                      block_crypto_read_func,
-                                      block_crypto_write_func,
-                                      bs,
-                                      amend_options,
-                                      force,
-                                      errp);
+    ret =3D block_crypto_amend_options_generic(bs, amend_options, force,=
 errp);
 cleanup:
-    crypto->updating_keys =3D false;
-    bdrv_child_refresh_perms(bs, bs->file, errp);
     qapi_free_QCryptoBlockCreateOptions(amend_options);
     qobject_unref(cryptoopts);
     return ret;
 }
=20
+static int
+coroutine_fn block_crypto_co_amend(BlockDriverState *bs,
+                                   BlockdevCreateOptions *opts,
+                                   bool force,
+                                   Error **errp)
+{
+    QCryptoBlockCreateOptions amend_opts;
+
+    amend_opts =3D (QCryptoBlockCreateOptions) {
+        .format =3D Q_CRYPTO_BLOCK_FORMAT_LUKS,
+        .u.luks =3D *qapi_BlockdevCreateOptionsLUKS_base(&opts->u.luks),
+    };
+
+    return block_crypto_amend_options_generic(bs, &amend_opts, force, er=
rp);
+}
+
=20
 static void
 block_crypto_child_perms(BlockDriverState *bs, BdrvChild *c,
@@ -750,7 +795,8 @@ block_crypto_child_perms(BlockDriverState *bs, BdrvCh=
ild *c,
      */
=20
     if (crypto->updating_keys) {
-        /*need exclusive write access for header update  */
+        assert(!(bs->open_flags & BDRV_O_NO_IO));
+        /*need exclusive read and write access for header update  */
         perm |=3D BLK_PERM_WRITE;
         shared &=3D ~(BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE);
     }
@@ -786,6 +832,7 @@ static BlockDriver bdrv_crypto_luks =3D {
     .bdrv_get_info      =3D block_crypto_get_info_luks,
     .bdrv_get_specific_info =3D block_crypto_get_specific_info_luks,
     .bdrv_amend_options =3D block_crypto_amend_options,
+    .bdrv_co_amend      =3D block_crypto_co_amend,
=20
     .strong_runtime_opts =3D block_crypto_strong_runtime_opts,
 };
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 7900914506..4a6db98938 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4211,8 +4211,11 @@
 # Driver specific image creation options for LUKS.
 #
 # @file             Node to create the image format on
+#                   Mandatory for create
 # @size             Size of the virtual disk in bytes
+#                   Mandatory for create
 # @preallocation    Preallocation mode for the new image
+#                   Only for create
 #                   (since: 4.2)
 #                   (default: off; allowed values: off, metadata, falloc=
, full)
 #
@@ -4220,8 +4223,8 @@
 ##
 { 'struct': 'BlockdevCreateOptionsLUKS',
   'base': 'QCryptoBlockCreateOptionsLUKS',
-  'data': { 'file':             'BlockdevRef',
-            'size':             'size',
+  'data': { '*file':             'BlockdevRef',
+            '*size':             'size',
             '*preallocation':   'PreallocMode' } }
=20
 ##
--=20
2.17.2


