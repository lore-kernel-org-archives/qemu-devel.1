Return-Path: <SRS0=qQQb=4Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EF9C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 15:28:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 115672072A
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 15:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H/liNsfm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 115672072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAxrI-0005Qn-7x
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 11:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37128)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jAxiX-0000k3-0k
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 11:19:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jAxiV-0001la-Gh
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 11:19:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26235
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jAxiV-0001lP-Cu
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 11:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583680787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=99Breszu+andB2udJj10ZHBRLjYraHwO421pxnBhUuQ=;
 b=H/liNsfmfpETIP3FLNK2Bzt1got59W6MdQ4jzLua/0fEKrF8e6ZQA5EScI+rCSUQIVep5B
 +2EYDbWuM+zAW8p1IAgEpfLIBY48uTCui4ePaNcDz4JDVzuaqadC9RfRQT7JSBBse7+UvC
 rLrSidETtCgMBtPZVpPKUlMJoSS4iX8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-To_XQ_bLMgSwG1lwevQcmA-1; Sun, 08 Mar 2020 11:19:45 -0400
X-MC-Unique: To_XQ_bLMgSwG1lwevQcmA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50053107ACC9;
 Sun,  8 Mar 2020 15:19:44 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EA6E25C1B0;
 Sun,  8 Mar 2020 15:19:41 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 12/14] block/crypto: implement blockdev-amend
Date: Sun,  8 Mar 2020 17:19:01 +0200
Message-Id: <20200308151903.25941-13-mlevitsk@redhat.com>
In-Reply-To: <20200308151903.25941-1-mlevitsk@redhat.com>
References: <20200308151903.25941-1-mlevitsk@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 block/crypto.c       | 72 ++++++++++++++++++++++++++++++++------------
 qapi/block-core.json | 14 ++++++++-
 2 files changed, 66 insertions(+), 20 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index 727a3fde58..389586200f 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -694,32 +694,21 @@ block_crypto_get_specific_info_luks(BlockDriverState =
*bs, Error **errp)
 }
=20
 static int
-block_crypto_amend_options_luks(BlockDriverState *bs,
-                           QemuOpts *opts,
-                           BlockDriverAmendStatusCB *status_cb,
-                           void *cb_opaque,
-                           bool force,
-                           Error **errp)
+block_crypto_amend_options_generic_luks(BlockDriverState *bs,
+                                        QCryptoBlockAmendOptions *amend_op=
tions,
+                                        bool force,
+                                        Error **errp)
 {
     BlockCrypto *crypto =3D bs->opaque;
-    QDict *cryptoopts =3D NULL;
-    QCryptoBlockAmendOptions *amend_options =3D NULL;
     int ret;
=20
     assert(crypto);
     assert(crypto->block);
-    crypto->updating_keys =3D true;
=20
+    /* apply for exclusive read/write permissions to the underlying file*/
+    crypto->updating_keys =3D true;
     ret =3D bdrv_child_refresh_perms(bs, bs->file, errp);
-    if (ret < 0) {
-        goto cleanup;
-    }
-
-    cryptoopts =3D qemu_opts_to_qdict(opts, NULL);
-    qdict_put_str(cryptoopts, "format", "luks");
-    amend_options =3D block_crypto_amend_opts_init(cryptoopts, errp);
-    if (!amend_options) {
-        ret =3D -EINVAL;
+    if (ret) {
         goto cleanup;
     }
=20
@@ -731,13 +720,57 @@ block_crypto_amend_options_luks(BlockDriverState *bs,
                                       force,
                                       errp);
 cleanup:
+    /* release exclusive read/write permissions to the underlying file*/
     crypto->updating_keys =3D false;
     bdrv_child_refresh_perms(bs, bs->file, errp);
-    qapi_free_QCryptoBlockAmendOptions(amend_options);
+    return ret;
+}
+
+static int
+block_crypto_amend_options_luks(BlockDriverState *bs,
+                                QemuOpts *opts,
+                                BlockDriverAmendStatusCB *status_cb,
+                                void *cb_opaque,
+                                bool force,
+                                Error **errp)
+{
+    BlockCrypto *crypto =3D bs->opaque;
+    QDict *cryptoopts =3D NULL;
+    QCryptoBlockAmendOptions *amend_options =3D NULL;
+    int ret =3D -EINVAL;
+
+    assert(crypto);
+    assert(crypto->block);
+
+    cryptoopts =3D qemu_opts_to_qdict(opts, NULL);
+    qdict_put_str(cryptoopts, "format", "luks");
+    amend_options =3D block_crypto_amend_opts_init(cryptoopts, errp);
     qobject_unref(cryptoopts);
+    if (!amend_options) {
+        goto cleanup;
+    }
+    ret =3D block_crypto_amend_options_generic_luks(bs, amend_options,
+                                                  force, errp);
+cleanup:
+    qapi_free_QCryptoBlockAmendOptions(amend_options);
     return ret;
 }
=20
+static int
+coroutine_fn block_crypto_co_amend_luks(BlockDriverState *bs,
+                                        BlockdevAmendOptions *opts,
+                                        bool force,
+                                        Error **errp)
+{
+    QCryptoBlockAmendOptions amend_opts;
+
+    amend_opts =3D (QCryptoBlockAmendOptions) {
+        .format =3D Q_CRYPTO_BLOCK_FORMAT_LUKS,
+        .u.luks =3D *qapi_BlockdevAmendOptionsLUKS_base(&opts->u.luks),
+    };
+    return block_crypto_amend_options_generic_luks(bs, &amend_opts,
+                                                   force, errp);
+}
=20
 static void
 block_crypto_child_perms(BlockDriverState *bs, BdrvChild *c,
@@ -809,6 +842,7 @@ static BlockDriver bdrv_crypto_luks =3D {
     .bdrv_get_info      =3D block_crypto_get_info_luks,
     .bdrv_get_specific_info =3D block_crypto_get_specific_info_luks,
     .bdrv_amend_options =3D block_crypto_amend_options_luks,
+    .bdrv_co_amend      =3D block_crypto_co_amend_luks,
=20
     .strong_runtime_opts =3D block_crypto_strong_runtime_opts,
 };
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 192da75a10..967b5738c9 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4757,6 +4757,18 @@
   'data': { 'job-id': 'str',
             'options': 'BlockdevCreateOptions' } }
=20
+##
+# @BlockdevAmendOptionsLUKS:
+#
+# Driver specific image amend options for LUKS.
+#
+# Since: 5.0
+##
+{ 'struct': 'BlockdevAmendOptionsLUKS',
+  'base': 'QCryptoBlockAmendOptionsLUKS',
+  'data': { }
+}
+
 ##
 # @BlockdevAmendOptions:
 #
@@ -4771,7 +4783,7 @@
       'driver':         'BlockdevDriver' },
   'discriminator': 'driver',
   'data': {
-  } }
+      'luks':           'BlockdevAmendOptionsLUKS' } }
=20
 ##
 # @x-blockdev-amend:
--=20
2.17.2


