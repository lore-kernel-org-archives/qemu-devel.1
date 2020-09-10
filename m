Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E5BC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:10:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28C5220770
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ESX2oHcB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28C5220770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGJXe-0000of-3Q
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGJTm-0000oQ-U0
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:06:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30377
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGJTj-0007jw-8A
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599732414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7lKKRAfzAa7nguSIodEPu42yVYk+gGWaxh96Reo7ZjI=;
 b=ESX2oHcB0n6xfCF3bDGawKPp2Kaj4xgNEnnfZ/3BB4TNzAMXS8QW9brsnrUrJN9fq1wKSb
 h8I4aVKZyqn1D1Y+5K6FfMEkHpd+ihFEt0sv/X//dd3OmYcekcmnseODLnYRHMQtF2X2s1
 rPunBz4Ca4KIY0Q6Jco2l242cHDIXT8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-f3n_n02ANGmhc9JkhlIlnw-1; Thu, 10 Sep 2020 06:06:52 -0400
X-MC-Unique: f3n_n02ANGmhc9JkhlIlnw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DD7F1DE01;
 Thu, 10 Sep 2020 10:06:51 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-4.ams2.redhat.com
 [10.36.112.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 59DCF1002D41;
 Thu, 10 Sep 2020 10:06:50 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/17] crypto/gcrypt: Split QCryptoCipherGcrypt into subclasses
Date: Thu, 10 Sep 2020 11:06:23 +0100
Message-Id: <20200910100623.1088965-18-berrange@redhat.com>
In-Reply-To: <20200910100623.1088965-1-berrange@redhat.com>
References: <20200910100623.1088965-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 03:02:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

With gcrypt, most of the dispatch happens in the library,
so there aren't many classes to create.  However, we can
still create separate dispatch for CTR mode, and for
CONFIG_QEMU_PRIVATE_XTS, which avoids needing to check
for these modes at runtime.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/cipher-gcrypt.c.inc | 493 ++++++++++++++++++-------------------
 1 file changed, 238 insertions(+), 255 deletions(-)

diff --git a/crypto/cipher-gcrypt.c.inc b/crypto/cipher-gcrypt.c.inc
index 7a1fbc9745..42d4137534 100644
--- a/crypto/cipher-gcrypt.c.inc
+++ b/crypto/cipher-gcrypt.c.inc
@@ -24,8 +24,6 @@
 
 #include <gcrypt.h>
 
-static const struct QCryptoCipherDriver qcrypto_cipher_lib_driver;
-
 bool qcrypto_cipher_supports(QCryptoCipherAlgorithm alg,
                              QCryptoCipherMode mode)
 {
@@ -57,36 +55,212 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgorithm alg,
     }
 }
 
-typedef struct QCryptoCipherGcrypt QCryptoCipherGcrypt;
-struct QCryptoCipherGcrypt {
+typedef struct QCryptoCipherGcrypt {
     QCryptoCipher base;
     gcry_cipher_hd_t handle;
     size_t blocksize;
 #ifdef CONFIG_QEMU_PRIVATE_XTS
     gcry_cipher_hd_t tweakhandle;
-    /* Initialization vector or Counter */
-    uint8_t *iv;
+    uint8_t iv[XTS_BLOCK_SIZE];
 #endif
-};
+} QCryptoCipherGcrypt;
+
 
-static void
-qcrypto_gcrypt_cipher_free_ctx(QCryptoCipherGcrypt *ctx,
-                               QCryptoCipherMode mode)
+static void qcrypto_gcrypt_ctx_free(QCryptoCipher *cipher)
 {
-    if (!ctx) {
-        return;
-    }
+    QCryptoCipherGcrypt *ctx = container_of(cipher, QCryptoCipherGcrypt, base);
 
     gcry_cipher_close(ctx->handle);
+    g_free(ctx);
+}
+
+static int qcrypto_gcrypt_encrypt(QCryptoCipher *cipher, const void *in,
+                                  void *out, size_t len, Error **errp)
+{
+    QCryptoCipherGcrypt *ctx = container_of(cipher, QCryptoCipherGcrypt, base);
+    gcry_error_t err;
+
+    if (len & (ctx->blocksize - 1)) {
+        error_setg(errp, "Length %zu must be a multiple of block size %zu",
+                   len, ctx->blocksize);
+        return -1;
+    }
+
+    err = gcry_cipher_encrypt(ctx->handle, out, len, in, len);
+    if (err != 0) {
+        error_setg(errp, "Cannot encrypt data: %s", gcry_strerror(err));
+        return -1;
+    }
+
+    return 0;
+}
+
+
+static int qcrypto_gcrypt_decrypt(QCryptoCipher *cipher, const void *in,
+                                  void *out, size_t len, Error **errp)
+{
+    QCryptoCipherGcrypt *ctx = container_of(cipher, QCryptoCipherGcrypt, base);
+    gcry_error_t err;
+
+    if (len & (ctx->blocksize - 1)) {
+        error_setg(errp, "Length %zu must be a multiple of block size %zu",
+                   len, ctx->blocksize);
+        return -1;
+    }
+
+    err = gcry_cipher_decrypt(ctx->handle, out, len, in, len);
+    if (err != 0) {
+        error_setg(errp, "Cannot decrypt data: %s",
+                   gcry_strerror(err));
+        return -1;
+    }
+
+    return 0;
+}
+
+static int qcrypto_gcrypt_setiv(QCryptoCipher *cipher,
+                                const uint8_t *iv, size_t niv,
+                                Error **errp)
+{
+    QCryptoCipherGcrypt *ctx = container_of(cipher, QCryptoCipherGcrypt, base);
+    gcry_error_t err;
+
+    if (niv != ctx->blocksize) {
+        error_setg(errp, "Expected IV size %zu not %zu",
+                   ctx->blocksize, niv);
+        return -1;
+    }
+
+    gcry_cipher_reset(ctx->handle);
+    err = gcry_cipher_setiv(ctx->handle, iv, niv);
+    if (err != 0) {
+        error_setg(errp, "Cannot set IV: %s", gcry_strerror(err));
+        return -1;
+    }
+
+    return 0;
+}
+
+static int qcrypto_gcrypt_ctr_setiv(QCryptoCipher *cipher,
+                                    const uint8_t *iv, size_t niv,
+                                    Error **errp)
+{
+    QCryptoCipherGcrypt *ctx = container_of(cipher, QCryptoCipherGcrypt, base);
+    gcry_error_t err;
+
+    if (niv != ctx->blocksize) {
+        error_setg(errp, "Expected IV size %zu not %zu",
+                   ctx->blocksize, niv);
+        return -1;
+    }
+
+    err = gcry_cipher_setctr(ctx->handle, iv, niv);
+    if (err != 0) {
+        error_setg(errp, "Cannot set Counter: %s", gcry_strerror(err));
+        return -1;
+    }
+
+    return 0;
+}
+
+
+static const struct QCryptoCipherDriver qcrypto_gcrypt_driver = {
+    .cipher_encrypt = qcrypto_gcrypt_encrypt,
+    .cipher_decrypt = qcrypto_gcrypt_decrypt,
+    .cipher_setiv = qcrypto_gcrypt_setiv,
+    .cipher_free = qcrypto_gcrypt_ctx_free,
+};
+
+static const struct QCryptoCipherDriver qcrypto_gcrypt_ctr_driver = {
+    .cipher_encrypt = qcrypto_gcrypt_encrypt,
+    .cipher_decrypt = qcrypto_gcrypt_decrypt,
+    .cipher_setiv = qcrypto_gcrypt_ctr_setiv,
+    .cipher_free = qcrypto_gcrypt_ctx_free,
+};
+
 #ifdef CONFIG_QEMU_PRIVATE_XTS
-    if (mode == QCRYPTO_CIPHER_MODE_XTS) {
-        gcry_cipher_close(ctx->tweakhandle);
+static void qcrypto_gcrypt_xts_ctx_free(QCryptoCipher *cipher)
+{
+    QCryptoCipherGcrypt *ctx = container_of(cipher, QCryptoCipherGcrypt, base);
+
+    gcry_cipher_close(ctx->tweakhandle);
+    qcrypto_gcrypt_ctx_free(cipher);
+}
+
+static void qcrypto_gcrypt_xts_wrape(const void *ctx, size_t length,
+                                     uint8_t *dst, const uint8_t *src)
+{
+    gcry_error_t err;
+    err = gcry_cipher_encrypt((gcry_cipher_hd_t)ctx, dst, length, src, length);
+    g_assert(err == 0);
+}
+
+static void qcrypto_gcrypt_xts_wrapd(const void *ctx, size_t length,
+                                     uint8_t *dst, const uint8_t *src)
+{
+    gcry_error_t err;
+    err = gcry_cipher_decrypt((gcry_cipher_hd_t)ctx, dst, length, src, length);
+    g_assert(err == 0);
+}
+
+static int qcrypto_gcrypt_xts_encrypt(QCryptoCipher *cipher, const void *in,
+                                      void *out, size_t len, Error **errp)
+{
+    QCryptoCipherGcrypt *ctx = container_of(cipher, QCryptoCipherGcrypt, base);
+
+    if (len & (ctx->blocksize - 1)) {
+        error_setg(errp, "Length %zu must be a multiple of block size %zu",
+                   len, ctx->blocksize);
+        return -1;
     }
-    g_free(ctx->iv);
-#endif
-    g_free(ctx);
+
+    xts_encrypt(ctx->handle, ctx->tweakhandle,
+                qcrypto_gcrypt_xts_wrape, qcrypto_gcrypt_xts_wrapd,
+                ctx->iv, len, out, in);
+    return 0;
+}
+
+static int qcrypto_gcrypt_xts_decrypt(QCryptoCipher *cipher, const void *in,
+                                      void *out, size_t len, Error **errp)
+{
+    QCryptoCipherGcrypt *ctx = container_of(cipher, QCryptoCipherGcrypt, base);
+
+    if (len & (ctx->blocksize - 1)) {
+        error_setg(errp, "Length %zu must be a multiple of block size %zu",
+                   len, ctx->blocksize);
+        return -1;
+    }
+
+    xts_decrypt(ctx->handle, ctx->tweakhandle,
+                qcrypto_gcrypt_xts_wrape, qcrypto_gcrypt_xts_wrapd,
+                ctx->iv, len, out, in);
+    return 0;
+}
+
+static int qcrypto_gcrypt_xts_setiv(QCryptoCipher *cipher,
+                                    const uint8_t *iv, size_t niv,
+                                    Error **errp)
+{
+    QCryptoCipherGcrypt *ctx = container_of(cipher, QCryptoCipherGcrypt, base);
+
+    if (niv != ctx->blocksize) {
+        error_setg(errp, "Expected IV size %zu not %zu",
+                   ctx->blocksize, niv);
+        return -1;
+    }
+
+    memcpy(ctx->iv, iv, niv);
+    return 0;
 }
 
+static const struct QCryptoCipherDriver qcrypto_gcrypt_xts_driver = {
+    .cipher_encrypt = qcrypto_gcrypt_xts_encrypt,
+    .cipher_decrypt = qcrypto_gcrypt_xts_decrypt,
+    .cipher_setiv = qcrypto_gcrypt_xts_setiv,
+    .cipher_free = qcrypto_gcrypt_xts_ctx_free,
+};
+#endif /* CONFIG_QEMU_PRIVATE_XTS */
+
 
 static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
                                              QCryptoCipherMode mode,
@@ -95,32 +269,10 @@ static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
                                              Error **errp)
 {
     QCryptoCipherGcrypt *ctx;
+    const QCryptoCipherDriver *drv;
     gcry_error_t err;
     int gcryalg, gcrymode;
 
-    switch (mode) {
-    case QCRYPTO_CIPHER_MODE_ECB:
-        gcrymode = GCRY_CIPHER_MODE_ECB;
-        break;
-    case QCRYPTO_CIPHER_MODE_XTS:
-#ifdef CONFIG_QEMU_PRIVATE_XTS
-        gcrymode = GCRY_CIPHER_MODE_ECB;
-#else
-        gcrymode = GCRY_CIPHER_MODE_XTS;
-#endif
-        break;
-    case QCRYPTO_CIPHER_MODE_CBC:
-        gcrymode = GCRY_CIPHER_MODE_CBC;
-        break;
-    case QCRYPTO_CIPHER_MODE_CTR:
-        gcrymode = GCRY_CIPHER_MODE_CTR;
-        break;
-    default:
-        error_setg(errp, "Unsupported cipher mode %s",
-                   QCryptoCipherMode_str(mode));
-        return NULL;
-    }
-
     if (!qcrypto_cipher_validate_key_length(alg, mode, nkey, errp)) {
         return NULL;
     }
@@ -129,54 +281,70 @@ static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
     case QCRYPTO_CIPHER_ALG_DES_RFB:
         gcryalg = GCRY_CIPHER_DES;
         break;
-
     case QCRYPTO_CIPHER_ALG_3DES:
         gcryalg = GCRY_CIPHER_3DES;
         break;
-
     case QCRYPTO_CIPHER_ALG_AES_128:
         gcryalg = GCRY_CIPHER_AES128;
         break;
-
     case QCRYPTO_CIPHER_ALG_AES_192:
         gcryalg = GCRY_CIPHER_AES192;
         break;
-
     case QCRYPTO_CIPHER_ALG_AES_256:
         gcryalg = GCRY_CIPHER_AES256;
         break;
-
     case QCRYPTO_CIPHER_ALG_CAST5_128:
         gcryalg = GCRY_CIPHER_CAST5;
         break;
-
     case QCRYPTO_CIPHER_ALG_SERPENT_128:
         gcryalg = GCRY_CIPHER_SERPENT128;
         break;
-
     case QCRYPTO_CIPHER_ALG_SERPENT_192:
         gcryalg = GCRY_CIPHER_SERPENT192;
         break;
-
     case QCRYPTO_CIPHER_ALG_SERPENT_256:
         gcryalg = GCRY_CIPHER_SERPENT256;
         break;
-
     case QCRYPTO_CIPHER_ALG_TWOFISH_128:
         gcryalg = GCRY_CIPHER_TWOFISH128;
         break;
-
     case QCRYPTO_CIPHER_ALG_TWOFISH_256:
         gcryalg = GCRY_CIPHER_TWOFISH;
         break;
-
     default:
         error_setg(errp, "Unsupported cipher algorithm %s",
                    QCryptoCipherAlgorithm_str(alg));
         return NULL;
     }
 
+    drv = &qcrypto_gcrypt_driver;
+    switch (mode) {
+    case QCRYPTO_CIPHER_MODE_ECB:
+        gcrymode = GCRY_CIPHER_MODE_ECB;
+        break;
+    case QCRYPTO_CIPHER_MODE_XTS:
+#ifdef CONFIG_QEMU_PRIVATE_XTS
+        drv = &qcrypto_gcrypt_xts_driver;
+        gcrymode = GCRY_CIPHER_MODE_ECB;
+#else
+        gcrymode = GCRY_CIPHER_MODE_XTS;
+#endif
+        break;
+    case QCRYPTO_CIPHER_MODE_CBC:
+        gcrymode = GCRY_CIPHER_MODE_CBC;
+        break;
+    case QCRYPTO_CIPHER_MODE_CTR:
+        drv = &qcrypto_gcrypt_ctr_driver;
+        gcrymode = GCRY_CIPHER_MODE_CTR;
+        break;
+    default:
+        error_setg(errp, "Unsupported cipher mode %s",
+                   QCryptoCipherMode_str(mode));
+        return NULL;
+    }
+
     ctx = g_new0(QCryptoCipherGcrypt, 1);
+    ctx->base.driver = drv;
 
     err = gcry_cipher_open(&ctx->handle, gcryalg, gcrymode, 0);
     if (err != 0) {
@@ -184,8 +352,16 @@ static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
                    gcry_strerror(err));
         goto error;
     }
+    ctx->blocksize = gcry_cipher_get_algo_blklen(gcryalg);
+
 #ifdef CONFIG_QEMU_PRIVATE_XTS
     if (mode == QCRYPTO_CIPHER_MODE_XTS) {
+        if (ctx->blocksize != XTS_BLOCK_SIZE) {
+            error_setg(errp,
+                       "Cipher block size %zu must equal XTS block size %d",
+		       ctx->blocksize, XTS_BLOCK_SIZE);
+            goto error;
+        }
         err = gcry_cipher_open(&ctx->tweakhandle, gcryalg, gcrymode, 0);
         if (err != 0) {
             error_setg(errp, "Cannot initialize cipher: %s",
@@ -203,224 +379,31 @@ static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
         uint8_t *rfbkey = qcrypto_cipher_munge_des_rfb_key(key, nkey);
         err = gcry_cipher_setkey(ctx->handle, rfbkey, nkey);
         g_free(rfbkey);
-        ctx->blocksize = 8;
     } else {
 #ifdef CONFIG_QEMU_PRIVATE_XTS
         if (mode == QCRYPTO_CIPHER_MODE_XTS) {
             nkey /= 2;
-            err = gcry_cipher_setkey(ctx->handle, key, nkey);
+            err = gcry_cipher_setkey(ctx->tweakhandle, key + nkey, nkey);
             if (err != 0) {
-                error_setg(errp, "Cannot set key: %s",
-                           gcry_strerror(err));
+                error_setg(errp, "Cannot set key: %s", gcry_strerror(err));
                 goto error;
             }
-            err = gcry_cipher_setkey(ctx->tweakhandle, key + nkey, nkey);
-        } else {
-#endif
-            err = gcry_cipher_setkey(ctx->handle, key, nkey);
-#ifdef CONFIG_QEMU_PRIVATE_XTS
         }
 #endif
-        if (err != 0) {
-            error_setg(errp, "Cannot set key: %s",
-                       gcry_strerror(err));
-            goto error;
-        }
-        switch (alg) {
-        case QCRYPTO_CIPHER_ALG_AES_128:
-        case QCRYPTO_CIPHER_ALG_AES_192:
-        case QCRYPTO_CIPHER_ALG_AES_256:
-        case QCRYPTO_CIPHER_ALG_SERPENT_128:
-        case QCRYPTO_CIPHER_ALG_SERPENT_192:
-        case QCRYPTO_CIPHER_ALG_SERPENT_256:
-        case QCRYPTO_CIPHER_ALG_TWOFISH_128:
-        case QCRYPTO_CIPHER_ALG_TWOFISH_256:
-            ctx->blocksize = 16;
-            break;
-        case QCRYPTO_CIPHER_ALG_3DES:
-        case QCRYPTO_CIPHER_ALG_CAST5_128:
-            ctx->blocksize = 8;
-            break;
-        default:
-            g_assert_not_reached();
-        }
+        err = gcry_cipher_setkey(ctx->handle, key, nkey);
     }
-    g_assert(is_power_of_2(ctx->blocksize));
-
-#ifdef CONFIG_QEMU_PRIVATE_XTS
-    if (mode == QCRYPTO_CIPHER_MODE_XTS) {
-        if (ctx->blocksize != XTS_BLOCK_SIZE) {
-            error_setg(errp,
-                       "Cipher block size %zu must equal XTS block size %d",
-                       ctx->blocksize, XTS_BLOCK_SIZE);
-            goto error;
-        }
-        ctx->iv = g_new0(uint8_t, ctx->blocksize);
+    if (err != 0) {
+        error_setg(errp, "Cannot set key: %s", gcry_strerror(err));
+        goto error;
     }
-#endif
 
-    ctx->base.driver = &qcrypto_cipher_lib_driver;
     return &ctx->base;
 
  error:
-    qcrypto_gcrypt_cipher_free_ctx(ctx, mode);
-    return NULL;
-}
-
-
-static void
-qcrypto_gcrypt_cipher_ctx_free(QCryptoCipher *cipher)
-{
-    QCryptoCipherGcrypt *ctx = container_of(cipher, QCryptoCipherGcrypt, base);
-
-    qcrypto_gcrypt_cipher_free_ctx(ctx, cipher->mode);
-}
-
-
-#ifdef CONFIG_QEMU_PRIVATE_XTS
-static void qcrypto_gcrypt_xts_encrypt(const void *ctx,
-                                       size_t length,
-                                       uint8_t *dst,
-                                       const uint8_t *src)
-{
-    gcry_error_t err;
-    err = gcry_cipher_encrypt((gcry_cipher_hd_t)ctx, dst, length, src, length);
-    g_assert(err == 0);
-}
-
-static void qcrypto_gcrypt_xts_decrypt(const void *ctx,
-                                       size_t length,
-                                       uint8_t *dst,
-                                       const uint8_t *src)
-{
-    gcry_error_t err;
-    err = gcry_cipher_decrypt((gcry_cipher_hd_t)ctx, dst, length, src, length);
-    g_assert(err == 0);
-}
-#endif
-
-static int
-qcrypto_gcrypt_cipher_encrypt(QCryptoCipher *cipher,
-                              const void *in,
-                              void *out,
-                              size_t len,
-                              Error **errp)
-{
-    QCryptoCipherGcrypt *ctx = container_of(cipher, QCryptoCipherGcrypt, base);
-    gcry_error_t err;
-
-    if (len & (ctx->blocksize - 1)) {
-        error_setg(errp, "Length %zu must be a multiple of block size %zu",
-                   len, ctx->blocksize);
-        return -1;
-    }
-
-#ifdef CONFIG_QEMU_PRIVATE_XTS
-    if (cipher->mode == QCRYPTO_CIPHER_MODE_XTS) {
-        xts_encrypt(ctx->handle, ctx->tweakhandle,
-                    qcrypto_gcrypt_xts_encrypt,
-                    qcrypto_gcrypt_xts_decrypt,
-                    ctx->iv, len, out, in);
-        return 0;
-    }
-#endif
-
-    err = gcry_cipher_encrypt(ctx->handle,
-                              out, len,
-                              in, len);
-    if (err != 0) {
-        error_setg(errp, "Cannot encrypt data: %s",
-                   gcry_strerror(err));
-        return -1;
-    }
-
-    return 0;
-}
-
-
-static int
-qcrypto_gcrypt_cipher_decrypt(QCryptoCipher *cipher,
-                              const void *in,
-                              void *out,
-                              size_t len,
-                              Error **errp)
-{
-    QCryptoCipherGcrypt *ctx = container_of(cipher, QCryptoCipherGcrypt, base);
-    gcry_error_t err;
-
-    if (len & (ctx->blocksize - 1)) {
-        error_setg(errp, "Length %zu must be a multiple of block size %zu",
-                   len, ctx->blocksize);
-        return -1;
-    }
-
-#ifdef CONFIG_QEMU_PRIVATE_XTS
-    if (cipher->mode == QCRYPTO_CIPHER_MODE_XTS) {
-        xts_decrypt(ctx->handle, ctx->tweakhandle,
-                    qcrypto_gcrypt_xts_encrypt,
-                    qcrypto_gcrypt_xts_decrypt,
-                    ctx->iv, len, out, in);
-        return 0;
-    }
-#endif
-
-    err = gcry_cipher_decrypt(ctx->handle,
-                              out, len,
-                              in, len);
-    if (err != 0) {
-        error_setg(errp, "Cannot decrypt data: %s",
-                   gcry_strerror(err));
-        return -1;
-    }
-
-    return 0;
-}
-
-static int
-qcrypto_gcrypt_cipher_setiv(QCryptoCipher *cipher,
-                            const uint8_t *iv, size_t niv,
-                            Error **errp)
-{
-    QCryptoCipherGcrypt *ctx = container_of(cipher, QCryptoCipherGcrypt, base);
-    gcry_error_t err;
-
-    if (niv != ctx->blocksize) {
-        error_setg(errp, "Expected IV size %zu not %zu",
-                   ctx->blocksize, niv);
-        return -1;
-    }
-
 #ifdef CONFIG_QEMU_PRIVATE_XTS
-    if (ctx->iv) {
-        memcpy(ctx->iv, iv, niv);
-        return 0;
-    }
+    gcry_cipher_close(ctx->tweakhandle);
 #endif
-
-    if (cipher->mode == QCRYPTO_CIPHER_MODE_CTR) {
-        err = gcry_cipher_setctr(ctx->handle, iv, niv);
-        if (err != 0) {
-            error_setg(errp, "Cannot set Counter: %s",
-                       gcry_strerror(err));
-            return -1;
-        }
-    } else {
-        gcry_cipher_reset(ctx->handle);
-        err = gcry_cipher_setiv(ctx->handle, iv, niv);
-        if (err != 0) {
-            error_setg(errp, "Cannot set IV: %s",
-                       gcry_strerror(err));
-            return -1;
-        }
-    }
-
-    return 0;
+    gcry_cipher_close(ctx->handle);
+    g_free(ctx);
+    return NULL;
 }
-
-
-static const struct QCryptoCipherDriver qcrypto_cipher_lib_driver = {
-    .cipher_encrypt = qcrypto_gcrypt_cipher_encrypt,
-    .cipher_decrypt = qcrypto_gcrypt_cipher_decrypt,
-    .cipher_setiv = qcrypto_gcrypt_cipher_setiv,
-    .cipher_free = qcrypto_gcrypt_cipher_ctx_free,
-};
-- 
2.26.2


