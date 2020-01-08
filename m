Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2904C33CA2
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 11:23:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A052A206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 11:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UuiyKT2Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A052A206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip9RI-0005Yy-Id
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 06:23:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49678)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ip9Q3-0003tP-Ip
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 06:22:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ip9Q0-0004Vt-Ne
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 06:22:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32492
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ip9Q0-0004VH-CY
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 06:22:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578482551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=asjGjJ+5UzsC27I8IX7Zxas5kupKb/Y//VGwbMRwWOo=;
 b=UuiyKT2QIin9F/hNsa6IsclDCbBUpOCRoW0ABfRPKZXW8x5VKyFkjy70rYt0SSjivy+nGW
 2Ggcj4PSNQki4M4BLYp6gaNLbXiIpv2uP0fLKBuMVkhBzEko/4rp9pBeeW1Tz0S39Ym+oi
 uFP8DRF+NthF4qiAf81xZukVBp/PZfc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-MSkLTDWaMc6WM1Mn1ajo6A-1; Wed, 08 Jan 2020 06:22:30 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FB03801E77;
 Wed,  8 Jan 2020 11:22:29 +0000 (UTC)
Received: from localhost (ovpn-116-249.ams2.redhat.com [10.36.116.249])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9769960CD3;
 Wed,  8 Jan 2020 11:22:26 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] luks: extract block_crypto_calculate_payload_offset()
Date: Wed,  8 Jan 2020 11:22:17 +0000
Message-Id: <20200108112220.499180-2-stefanha@redhat.com>
In-Reply-To: <20200108112220.499180-1-stefanha@redhat.com>
References: <20200108112220.499180-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: MSkLTDWaMc6WM1Mn1ajo6A-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The qcow2 .bdrv_measure() code calculates the crypto payload offset.
This logic really belongs in block/crypto.c where it can be reused by
other image formats.

The "luks" block driver will need this same logic in order to implement
.bdrv_measure(), so extract the block_crypto_calculate_payload_offset()
function now.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/crypto.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++
 block/crypto.h |  5 ++++
 block/qcow2.c  | 59 ++++------------------------------------------
 3 files changed, 73 insertions(+), 55 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index 24823835c1..ed32202fa2 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -185,6 +185,70 @@ block_crypto_create_opts_init(QDict *opts, Error **err=
p)
 }
=20
=20
+static ssize_t block_crypto_headerlen_hdr_init_func(QCryptoBlock *block,
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
+static ssize_t block_crypto_headerlen_hdr_write_func(QCryptoBlock *block,
+        size_t offset, const uint8_t *buf, size_t buflen,
+        void *opaque, Error **errp)
+{
+    /* Discard the bytes, we're not actually writing to an image */
+    return buflen;
+}
+
+
+/* Determine the number of bytes for the crypto header */
+bool block_crypto_calculate_payload_offset(QemuOpts *opts,
+                                           const char *optprefix,
+                                           size_t *len,
+                                           Error **errp)
+{
+    QDict *cryptoopts_qdict;
+    QCryptoBlockCreateOptions *cryptoopts;
+    QCryptoBlock *crypto;
+
+    /* Extract options into a qdict */
+    if (optprefix) {
+        QDict *opts_qdict =3D qemu_opts_to_qdict(opts, NULL);
+
+        qdict_extract_subqdict(opts_qdict, &cryptoopts_qdict, optprefix);
+        qobject_unref(opts_qdict);
+    } else {
+        cryptoopts_qdict =3D qemu_opts_to_qdict(opts, NULL);
+    }
+
+    /* Build QCryptoBlockCreateOptions object from qdict */
+    qdict_put_str(cryptoopts_qdict, "format", "luks");
+
+    cryptoopts =3D block_crypto_create_opts_init(cryptoopts_qdict, errp);
+    qobject_unref(cryptoopts_qdict);
+    if (!cryptoopts) {
+        return false;
+    }
+
+    /* Fake LUKS creation in order to determine the payload size */
+    crypto =3D qcrypto_block_create(cryptoopts, optprefix,
+                                  block_crypto_headerlen_hdr_init_func,
+                                  block_crypto_headerlen_hdr_write_func,
+                                  len, errp);
+    qapi_free_QCryptoBlockCreateOptions(cryptoopts);
+    if (!crypto) {
+        return false;
+    }
+
+    qcrypto_block_free(crypto);
+    return true;
+}
+
+
 static int block_crypto_open_generic(QCryptoBlockFormat format,
                                      QemuOptsList *opts_spec,
                                      BlockDriverState *bs,
diff --git a/block/crypto.h b/block/crypto.h
index b935695e79..5a39bee71b 100644
--- a/block/crypto.h
+++ b/block/crypto.h
@@ -94,4 +94,9 @@ block_crypto_create_opts_init(QDict *opts, Error **errp);
 QCryptoBlockOpenOptions *
 block_crypto_open_opts_init(QDict *opts, Error **errp);
=20
+bool block_crypto_calculate_payload_offset(QemuOpts *opts,
+                                           const char *optprefix,
+                                           size_t *len,
+                                           Error **errp);
+
 #endif /* BLOCK_CRYPTO_H */
diff --git a/block/qcow2.c b/block/qcow2.c
index 7fbaac8457..cbdcc8695f 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4561,60 +4561,6 @@ static coroutine_fn int qcow2_co_flush_to_os(BlockDr=
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
@@ -4667,7 +4613,10 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opt=
s, BlockDriverState *in_bs,
     if (has_luks) {
         size_t headerlen;
=20
-        if (!qcow2_measure_luks_headerlen(opts, &headerlen, &local_err)) {
+        if (!block_crypto_calculate_payload_offset(opts,
+                                                   "encrypt.",
+                                                   &headerlen,
+                                                   &local_err)) {
             goto err;
         }
=20
--=20
2.24.1


