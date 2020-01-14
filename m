Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FBDC33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 19:37:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0556424655
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 19:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PAYX0L6G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0556424655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irS0A-0005Dy-Jn
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 14:37:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38441)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1irRyN-0003GD-Dr
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 14:35:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1irRyK-0007jh-OG
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 14:35:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21380
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1irRyK-0007j6-K8
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 14:35:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579030528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Yy7MXuoHyFbyV2yl4FMvL6qH7mKHQC/6W4zJtb6D0E=;
 b=PAYX0L6GUy4Vzz1aJLjpcqGzB6mgbh+n6NivI7FMTy7bwyc3Nt874Q1zr4BU9AyU/6ikO2
 HoPZs17hWJrSapbr9jl8UyFYVz1pxdIVdbJ55OhhskUcTG5gFVqLByM+UPzz3vKBvrjCdb
 THPoRXzmBH0T7VeBSNeNQQD0x8JtFnw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-2rGv6P3ROyCJXtQW96Hptg-1; Tue, 14 Jan 2020 14:34:19 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C969DC24;
 Tue, 14 Jan 2020 19:34:18 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.41])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5F4C687EFE;
 Tue, 14 Jan 2020 19:34:16 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/13] qcow2: extend qemu-img amend interface with crypto
 options
Date: Tue, 14 Jan 2020 21:33:44 +0200
Message-Id: <20200114193350.10830-8-mlevitsk@redhat.com>
In-Reply-To: <20200114193350.10830-1-mlevitsk@redhat.com>
References: <20200114193350.10830-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 2rGv6P3ROyCJXtQW96Hptg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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

Now that we have all the infrastructure in place,
wire it in the qcow2 driver and expose this to the user.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 block/qcow2.c | 101 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 79 insertions(+), 22 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index c6c2deee75..1b01174aed 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -173,6 +173,19 @@ static ssize_t qcow2_crypto_hdr_write_func(QCryptoBloc=
k *block, size_t offset,
     return ret;
 }
=20
+static QDict*
+qcow2_extract_crypto_opts(QemuOpts *opts, const char *fmt, Error **errp)
+{
+    QDict *cryptoopts_qdict;
+    QDict *opts_qdict;
+
+    /* Extract "encrypt." options into a qdict */
+    opts_qdict =3D qemu_opts_to_qdict(opts, NULL);
+    qdict_extract_subqdict(opts_qdict, &cryptoopts_qdict, "encrypt.");
+    qobject_unref(opts_qdict);
+    qdict_put_str(cryptoopts_qdict, "format", "luks");
+    return cryptoopts_qdict;
+}
=20
 /*=20
  * read qcow2 extension and fill bs
@@ -4631,20 +4644,18 @@ static ssize_t qcow2_measure_crypto_hdr_write_func(=
QCryptoBlock *block,
 static bool qcow2_measure_luks_headerlen(QemuOpts *opts, size_t *len,
                                          Error **errp)
 {
-    QDict *opts_qdict;
-    QDict *cryptoopts_qdict;
     QCryptoBlockCreateOptions *cryptoopts;
+    QDict* crypto_opts_dict;
     QCryptoBlock *crypto;
=20
-    /* Extract "encrypt." options into a qdict */
-    opts_qdict =3D qemu_opts_to_qdict(opts, NULL);
-    qdict_extract_subqdict(opts_qdict, &cryptoopts_qdict, "encrypt.");
-    qobject_unref(opts_qdict);
+    crypto_opts_dict =3D qcow2_extract_crypto_opts(opts, "luks", errp);
+    if (!crypto_opts_dict) {
+        return false;
+    }
+
+    cryptoopts =3D block_crypto_create_opts_init(crypto_opts_dict, errp);
+    qobject_unref(crypto_opts_dict);
=20
-    /* Build QCryptoBlockCreateOptions object from qdict */
-    qdict_put_str(cryptoopts_qdict, "format", "luks");
-    cryptoopts =3D block_crypto_create_opts_init(cryptoopts_qdict, errp);
-    qobject_unref(cryptoopts_qdict);
     if (!cryptoopts) {
         return false;
     }
@@ -5083,6 +5094,7 @@ typedef enum Qcow2AmendOperation {
     QCOW2_NO_OPERATION =3D 0,
=20
     QCOW2_UPGRADING,
+    QCOW2_UPDATING_ENCRYPTION,
     QCOW2_CHANGING_REFCOUNT_ORDER,
     QCOW2_DOWNGRADING,
 } Qcow2AmendOperation;
@@ -5167,6 +5179,7 @@ static int qcow2_amend_options(BlockDriverState *bs, =
QemuOpts *opts,
     int ret;
     QemuOptDesc *desc =3D opts->list->desc;
     Qcow2AmendHelperCBInfo helper_cb_info;
+    bool encryption_update =3D false;
=20
     while (desc && desc->name) {
         if (!qemu_opt_find(opts, desc->name)) {
@@ -5215,9 +5228,17 @@ static int qcow2_amend_options(BlockDriverState *bs,=
 QemuOpts *opts,
                 return -ENOTSUP;
             }
         } else if (g_str_has_prefix(desc->name, "encrypt.")) {
-            error_setg(errp,
-                       "Changing the encryption parameters is not supporte=
d");
-            return -ENOTSUP;
+            if (!s->crypto) {
+                error_setg(errp,
+                           "Can't amend encryption options - encryption no=
t present");
+                return -EINVAL;
+            }
+            if (s->crypt_method_header !=3D QCOW_CRYPT_LUKS) {
+                error_setg(errp,
+                           "Only LUKS encryption options can be amended");
+                return -ENOTSUP;
+            }
+            encryption_update =3D true;
         } else if (!strcmp(desc->name, BLOCK_OPT_CLUSTER_SIZE)) {
             cluster_size =3D qemu_opt_get_size(opts, BLOCK_OPT_CLUSTER_SIZ=
E,
                                              cluster_size);
@@ -5267,7 +5288,8 @@ static int qcow2_amend_options(BlockDriverState *bs, =
QemuOpts *opts,
         .original_status_cb =3D status_cb,
         .original_cb_opaque =3D cb_opaque,
         .total_operations =3D (new_version !=3D old_version)
-                          + (s->refcount_bits !=3D refcount_bits)
+                          + (s->refcount_bits !=3D refcount_bits) +
+                            (encryption_update =3D=3D true)
     };
=20
     /* Upgrade first (some features may require compat=3D1.1) */
@@ -5280,6 +5302,33 @@ static int qcow2_amend_options(BlockDriverState *bs,=
 QemuOpts *opts,
         }
     }
=20
+    if (encryption_update) {
+        QDict *amend_opts_dict;
+        QCryptoBlockAmendOptions *amend_opts;
+
+        helper_cb_info.current_operation =3D QCOW2_UPDATING_ENCRYPTION;
+        amend_opts_dict =3D qcow2_extract_crypto_opts(opts, "luks", errp);
+        if (!amend_opts_dict) {
+            return -EINVAL;
+        }
+        amend_opts =3D block_crypto_amend_opts_init(amend_opts_dict, errp)=
;
+        qobject_unref(amend_opts_dict);
+        if (!amend_opts) {
+            return -EINVAL;
+        }
+        ret =3D qcrypto_block_amend_options(s->crypto,
+                                          qcow2_crypto_hdr_read_func,
+                                          qcow2_crypto_hdr_write_func,
+                                          bs,
+                                          amend_opts,
+                                          force,
+                                          errp);
+        qapi_free_QCryptoBlockAmendOptions(amend_opts);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
     if (s->refcount_bits !=3D refcount_bits) {
         int refcount_order =3D ctz32(refcount_bits);
=20
@@ -5488,14 +5537,6 @@ void qcow2_signal_corruption(BlockDriverState *bs, b=
ool fatal, int64_t offset,
         .type =3D QEMU_OPT_STRING,                                    \
         .help =3D "Encrypt the image, format choices: 'aes', 'luks'", \
     },                                                              \
-    BLOCK_CRYPTO_OPT_DEF_KEY_SECRET("encrypt.",                     \
-        "ID of secret providing qcow AES key or LUKS passphrase"),  \
-    BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_ALG("encrypt."),               \
-    BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_MODE("encrypt."),              \
-    BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_ALG("encrypt."),                \
-    BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_HASH_ALG("encrypt."),           \
-    BLOCK_CRYPTO_OPT_DEF_LUKS_HASH_ALG("encrypt."),                 \
-    BLOCK_CRYPTO_OPT_DEF_LUKS_ITER_TIME("encrypt."),                \
     {                                                               \
         .name =3D BLOCK_OPT_CLUSTER_SIZE,                             \
         .type =3D QEMU_OPT_SIZE,                                      \
@@ -5526,6 +5567,14 @@ static QemuOptsList qcow2_create_opts =3D {
     .head =3D QTAILQ_HEAD_INITIALIZER(qcow2_create_opts.head),
     .desc =3D {
         QCOW_COMMON_OPTIONS,
+        BLOCK_CRYPTO_OPT_DEF_KEY_SECRET("encrypt.",
+            "ID of secret providing qcow AES key or LUKS passphrase"),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_ALG("encrypt."),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_MODE("encrypt."),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_ALG("encrypt."),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_HASH_ALG("encrypt."),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_HASH_ALG("encrypt."),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_ITER_TIME("encrypt."),
         { /* end of list */ }
     }
 };
@@ -5535,6 +5584,14 @@ static QemuOptsList qcow2_amend_opts =3D {
     .head =3D QTAILQ_HEAD_INITIALIZER(qcow2_amend_opts.head),
     .desc =3D {
         QCOW_COMMON_OPTIONS,
+        BLOCK_CRYPTO_OPT_DEF_LUKS_KEYSLOT_UPDATE("encrypt.keys.0."),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_KEYSLOT_UPDATE("encrypt.keys.1."),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_KEYSLOT_UPDATE("encrypt.keys.2."),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_KEYSLOT_UPDATE("encrypt.keys.3."),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_KEYSLOT_UPDATE("encrypt.keys.4."),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_KEYSLOT_UPDATE("encrypt.keys.5."),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_KEYSLOT_UPDATE("encrypt.keys.6."),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_KEYSLOT_UPDATE("encrypt.keys.7."),
         { /* end of list */ }
     }
 };
--=20
2.17.2


