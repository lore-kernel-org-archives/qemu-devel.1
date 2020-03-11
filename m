Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DD7C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 13:57:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6FF621D56
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 13:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y8cQXhKJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6FF621D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC1rM-00051S-RD
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 09:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35968)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jC1ma-0003VX-Hn
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:52:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jC1mY-00028S-Pw
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:52:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28149
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jC1mY-00026x-Kh
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583934742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wkGyBa3TCP/ROrIoB7buEWTEbozhrYymF2lO25Imo80=;
 b=Y8cQXhKJCDfSoN+zNH2Z1MPyfC4Rzi7lbOw7i8gExfsdaD03KJSPRvSuQ3U4XPVxtA3F9K
 tYMuPjLP5r7Sw+Ek43zOXF90xsIALcMYGy1MRcOBp7C0pL6mBpL9oAczATEG6QnFHGV/5K
 RC4m03V5q+bxOU1ZgH/mVtJrRJ3wDy4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-gXzoG7wPOaSqt3J9GrnNDg-1; Wed, 11 Mar 2020 09:52:20 -0400
X-MC-Unique: gXzoG7wPOaSqt3J9GrnNDg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 162E6107ACC4;
 Wed, 11 Mar 2020 13:52:19 +0000 (UTC)
Received: from localhost (ovpn-117-216.ams2.redhat.com [10.36.117.216])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F0FB393;
 Wed, 11 Mar 2020 13:52:18 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 01/19] luks: extract qcrypto_block_calculate_payload_offset()
Date: Wed, 11 Mar 2020 14:51:55 +0100
Message-Id: <20200311135213.1242028-2-mreitz@redhat.com>
In-Reply-To: <20200311135213.1242028-1-mreitz@redhat.com>
References: <20200311135213.1242028-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

The qcow2 .bdrv_measure() code calculates the crypto payload offset.
This logic really belongs in crypto/block.c where it can be reused by
other image formats.

The "luks" block driver will need this same logic in order to implement
.bdrv_measure(), so extract the qcrypto_block_calculate_payload_offset()
function now.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200221112522.1497712-2-stefanha@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c          | 74 +++++++++++-------------------------------
 crypto/block.c         | 36 ++++++++++++++++++++
 include/crypto/block.h | 22 +++++++++++++
 3 files changed, 77 insertions(+), 55 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 3640e8c07d..f667349e50 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4608,60 +4608,6 @@ static coroutine_fn int qcow2_co_flush_to_os(BlockDr=
iverState *bs)
     return ret;
 }
=20
-static ssize_t qcow2_measure_crypto_hdr_init_func(QCryptoBlock *block,
-        size_t headerlen, void *opaque, Error **errp)
-{
-    size_t *headerlenp =3D opaque;
-
-    /* Stash away the payload size */
-    *headerlenp =3D headerlen;
-    return 0;
-}
-
-static ssize_t qcow2_measure_crypto_hdr_write_func(QCryptoBlock *block,
-        size_t offset, const uint8_t *buf, size_t buflen,
-        void *opaque, Error **errp)
-{
-    /* Discard the bytes, we're not actually writing to an image */
-    return buflen;
-}
-
-/* Determine the number of bytes for the LUKS payload */
-static bool qcow2_measure_luks_headerlen(QemuOpts *opts, size_t *len,
-                                         Error **errp)
-{
-    QDict *opts_qdict;
-    QDict *cryptoopts_qdict;
-    QCryptoBlockCreateOptions *cryptoopts;
-    QCryptoBlock *crypto;
-
-    /* Extract "encrypt." options into a qdict */
-    opts_qdict =3D qemu_opts_to_qdict(opts, NULL);
-    qdict_extract_subqdict(opts_qdict, &cryptoopts_qdict, "encrypt.");
-    qobject_unref(opts_qdict);
-
-    /* Build QCryptoBlockCreateOptions object from qdict */
-    qdict_put_str(cryptoopts_qdict, "format", "luks");
-    cryptoopts =3D block_crypto_create_opts_init(cryptoopts_qdict, errp);
-    qobject_unref(cryptoopts_qdict);
-    if (!cryptoopts) {
-        return false;
-    }
-
-    /* Fake LUKS creation in order to determine the payload size */
-    crypto =3D qcrypto_block_create(cryptoopts, "encrypt.",
-                                  qcow2_measure_crypto_hdr_init_func,
-                                  qcow2_measure_crypto_hdr_write_func,
-                                  len, errp);
-    qapi_free_QCryptoBlockCreateOptions(cryptoopts);
-    if (!crypto) {
-        return false;
-    }
-
-    qcrypto_block_free(crypto);
-    return true;
-}
-
 static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *i=
n_bs,
                                        Error **errp)
 {
@@ -4712,9 +4658,27 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opt=
s, BlockDriverState *in_bs,
     g_free(optstr);
=20
     if (has_luks) {
+        g_autoptr(QCryptoBlockCreateOptions) create_opts =3D NULL;
+        QDict *opts_qdict;
+        QDict *cryptoopts;
         size_t headerlen;
=20
-        if (!qcow2_measure_luks_headerlen(opts, &headerlen, &local_err)) {
+        opts_qdict =3D qemu_opts_to_qdict(opts, NULL);
+        qdict_extract_subqdict(opts_qdict, &cryptoopts, "encrypt.");
+        qobject_unref(opts_qdict);
+
+        qdict_put_str(cryptoopts, "format", "luks");
+
+        create_opts =3D block_crypto_create_opts_init(cryptoopts, errp);
+        qobject_unref(cryptoopts);
+        if (!create_opts) {
+            goto err;
+        }
+
+        if (!qcrypto_block_calculate_payload_offset(create_opts,
+                                                    "encrypt.",
+                                                    &headerlen,
+                                                    &local_err)) {
             goto err;
         }
=20
diff --git a/crypto/block.c b/crypto/block.c
index 325752871c..6f42b32f1e 100644
--- a/crypto/block.c
+++ b/crypto/block.c
@@ -115,6 +115,42 @@ QCryptoBlock *qcrypto_block_create(QCryptoBlockCreateO=
ptions *options,
 }
=20
=20
+static ssize_t qcrypto_block_headerlen_hdr_init_func(QCryptoBlock *block,
+        size_t headerlen, void *opaque, Error **errp)
+{
+    size_t *headerlenp =3D opaque;
+
+    /* Stash away the payload size */
+    *headerlenp =3D headerlen;
+    return 0;
+}
+
+
+static ssize_t qcrypto_block_headerlen_hdr_write_func(QCryptoBlock *block,
+        size_t offset, const uint8_t *buf, size_t buflen,
+        void *opaque, Error **errp)
+{
+    /* Discard the bytes, we're not actually writing to an image */
+    return buflen;
+}
+
+
+bool
+qcrypto_block_calculate_payload_offset(QCryptoBlockCreateOptions *create_o=
pts,
+                                       const char *optprefix,
+                                       size_t *len,
+                                       Error **errp)
+{
+    /* Fake LUKS creation in order to determine the payload size */
+    g_autoptr(QCryptoBlock) crypto =3D
+        qcrypto_block_create(create_opts, optprefix,
+                             qcrypto_block_headerlen_hdr_init_func,
+                             qcrypto_block_headerlen_hdr_write_func,
+                             len, errp);
+    return crypto !=3D NULL;
+}
+
+
 QCryptoBlockInfo *qcrypto_block_get_info(QCryptoBlock *block,
                                          Error **errp)
 {
diff --git a/include/crypto/block.h b/include/crypto/block.h
index d49d2c2da9..c77ccaf9c0 100644
--- a/include/crypto/block.h
+++ b/include/crypto/block.h
@@ -145,6 +145,26 @@ QCryptoBlock *qcrypto_block_create(QCryptoBlockCreateO=
ptions *options,
                                    Error **errp);
=20
=20
+/**
+ * qcrypto_block_calculate_payload_offset:
+ * @create_opts: the encryption options
+ * @optprefix: name prefix for options
+ * @len: output for number of header bytes before payload
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Calculate the number of header bytes before the payload in an encrypted
+ * storage volume.  The header is an area before the payload that is reser=
ved
+ * for encryption metadata.
+ *
+ * Returns: true on success, false on error
+ */
+bool
+qcrypto_block_calculate_payload_offset(QCryptoBlockCreateOptions *create_o=
pts,
+                                       const char *optprefix,
+                                       size_t *len,
+                                       Error **errp);
+
+
 /**
  * qcrypto_block_get_info:
  * @block: the block encryption object
@@ -269,5 +289,7 @@ uint64_t qcrypto_block_get_sector_size(QCryptoBlock *bl=
ock);
 void qcrypto_block_free(QCryptoBlock *block);
=20
 G_DEFINE_AUTOPTR_CLEANUP_FUNC(QCryptoBlock, qcrypto_block_free)
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(QCryptoBlockCreateOptions,
+                              qapi_free_QCryptoBlockCreateOptions)
=20
 #endif /* QCRYPTO_BLOCK_H */
--=20
2.24.1


