Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C4EC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:16:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B80612078E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Exk7hNt2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B80612078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGJdG-0002PD-QW
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGJTi-0000cy-RC
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:06:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52684
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGJTf-0007jK-OU
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599732411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kQAjIvRFPGeB+uOYcrZForNu6YLc+GC6+X5PocLP3I4=;
 b=Exk7hNt2WIUybhID2kmdAlaWKKvmjrU8uB5WNV/BZ6TLFEb4WYqrF1vEexxmcJbZgDgwjW
 kbkZeXwJfX4qZUjTTP4M8qiGgOnc1mqPeK4qSI6+6we4RzbkZPoGZGOvtnigwRSDz8B/dr
 TpTiwml2zg1VHJ7F2nuEsM+f8j0RCP0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-bRJSIcSuOJC56A_prj0LQg-1; Thu, 10 Sep 2020 06:06:48 -0400
X-MC-Unique: bRJSIcSuOJC56A_prj0LQg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8F9064081;
 Thu, 10 Sep 2020 10:06:47 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-4.ams2.redhat.com
 [10.36.112.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A69781002D41;
 Thu, 10 Sep 2020 10:06:46 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/17] crypto/builtin: Split QCryptoCipherBuiltin into
 subclasses
Date: Thu, 10 Sep 2020 11:06:21 +0100
Message-Id: <20200910100623.1088965-16-berrange@redhat.com>
In-Reply-To: <20200910100623.1088965-1-berrange@redhat.com>
References: <20200910100623.1088965-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 01:44:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We had a second set of function pointers in QCryptoCipherBuiltin,
which are redundant with QCryptoCipherDriver.  Split the AES and
DES implementations to avoid one level of indirection.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/cipher-builtin.c.inc | 519 +++++++++++++++---------------------
 1 file changed, 210 insertions(+), 309 deletions(-)

diff --git a/crypto/cipher-builtin.c.inc b/crypto/cipher-builtin.c.inc
index b1fe3b08c3..7597cf4a10 100644
--- a/crypto/cipher-builtin.c.inc
+++ b/crypto/cipher-builtin.c.inc
@@ -22,56 +22,45 @@
 #include "crypto/desrfb.h"
 #include "crypto/xts.h"
 
-static const struct QCryptoCipherDriver qcrypto_cipher_lib_driver;
-
 typedef struct QCryptoCipherBuiltinAESContext QCryptoCipherBuiltinAESContext;
 struct QCryptoCipherBuiltinAESContext {
     AES_KEY enc;
     AES_KEY dec;
 };
+
 typedef struct QCryptoCipherBuiltinAES QCryptoCipherBuiltinAES;
 struct QCryptoCipherBuiltinAES {
+    QCryptoCipher base;
     QCryptoCipherBuiltinAESContext key;
     QCryptoCipherBuiltinAESContext key_tweak;
     uint8_t iv[AES_BLOCK_SIZE];
 };
-typedef struct QCryptoCipherBuiltinDESRFB QCryptoCipherBuiltinDESRFB;
-struct QCryptoCipherBuiltinDESRFB {
-    uint8_t *key;
-    size_t nkey;
-};
 
-typedef struct QCryptoCipherBuiltin QCryptoCipherBuiltin;
-struct QCryptoCipherBuiltin {
-    QCryptoCipher base;
-
-    union {
-        QCryptoCipherBuiltinAES aes;
-        QCryptoCipherBuiltinDESRFB desrfb;
-    } state;
-    size_t blocksize;
-    void (*free)(QCryptoCipher *cipher);
-    int (*setiv)(QCryptoCipher *cipher,
-                 const uint8_t *iv, size_t niv,
-                 Error **errp);
-    int (*encrypt)(QCryptoCipher *cipher,
-                   const void *in,
-                   void *out,
-                   size_t len,
-                   Error **errp);
-    int (*decrypt)(QCryptoCipher *cipher,
-                   const void *in,
-                   void *out,
-                   size_t len,
-                   Error **errp);
-};
 
+static inline bool qcrypto_length_check(size_t len, size_t blocksize,
+                                        Error **errp)
+{
+    if (unlikely(len & (blocksize - 1))) {
+        error_setg(errp, "Length %zu must be a multiple of block size %zu",
+                   len, blocksize);
+        return false;
+    }
+    return true;
+}
 
-static void qcrypto_cipher_free_aes(QCryptoCipher *cipher)
+static void qcrypto_cipher_ctx_free(QCryptoCipher *cipher)
 {
     g_free(cipher);
 }
 
+static int qcrypto_cipher_no_setiv(QCryptoCipher *cipher,
+                                   const uint8_t *iv, size_t niv,
+                                   Error **errp)
+{
+    error_setg(errp, "Setting IV is not supported");
+    return -1;
+}
+
 static void do_aes_encrypt_ecb(const void *vctx,
                                size_t len,
                                uint8_t *out,
@@ -149,185 +138,154 @@ static void do_aes_decrypt_cbc(const AES_KEY *key,
     }
 }
 
-static int qcrypto_cipher_encrypt_aes(QCryptoCipher *cipher,
-                                      const void *in,
-                                      void *out,
-                                      size_t len,
-                                      Error **errp)
+static int qcrypto_cipher_aes_encrypt_ecb(QCryptoCipher *cipher,
+                                          const void *in, void *out,
+                                          size_t len, Error **errp)
 {
-    QCryptoCipherBuiltin *ctxt
-        = container_of(cipher, QCryptoCipherBuiltin, base);
+    QCryptoCipherBuiltinAES *ctx
+        = container_of(cipher, QCryptoCipherBuiltinAES, base);
 
-    switch (cipher->mode) {
-    case QCRYPTO_CIPHER_MODE_ECB:
-        do_aes_encrypt_ecb(&ctxt->state.aes.key, len, out, in);
-        break;
-    case QCRYPTO_CIPHER_MODE_CBC:
-        do_aes_encrypt_cbc(&ctxt->state.aes.key.enc, len, out, in,
-                           ctxt->state.aes.iv);
-        break;
-    case QCRYPTO_CIPHER_MODE_XTS:
-        xts_encrypt(&ctxt->state.aes.key,
-                    &ctxt->state.aes.key_tweak,
-                    do_aes_encrypt_ecb,
-                    do_aes_decrypt_ecb,
-                    ctxt->state.aes.iv,
-                    len, out, in);
-        break;
-    default:
-        g_assert_not_reached();
+    if (!qcrypto_length_check(len, AES_BLOCK_SIZE, errp)) {
+        return -1;
     }
-
+    do_aes_encrypt_ecb(&ctx->key, len, out, in);
     return 0;
 }
 
-
-static int qcrypto_cipher_decrypt_aes(QCryptoCipher *cipher,
-                                      const void *in,
-                                      void *out,
-                                      size_t len,
-                                      Error **errp)
+static int qcrypto_cipher_aes_decrypt_ecb(QCryptoCipher *cipher,
+                                          const void *in, void *out,
+                                          size_t len, Error **errp)
 {
-    QCryptoCipherBuiltin *ctxt
-        = container_of(cipher, QCryptoCipherBuiltin, base);
+    QCryptoCipherBuiltinAES *ctx
+        = container_of(cipher, QCryptoCipherBuiltinAES, base);
 
-    switch (cipher->mode) {
-    case QCRYPTO_CIPHER_MODE_ECB:
-        do_aes_decrypt_ecb(&ctxt->state.aes.key, len, out, in);
-        break;
-    case QCRYPTO_CIPHER_MODE_CBC:
-        do_aes_decrypt_cbc(&ctxt->state.aes.key.dec, len, out, in,
-                           ctxt->state.aes.iv);
-        break;
-    case QCRYPTO_CIPHER_MODE_XTS:
-        xts_decrypt(&ctxt->state.aes.key,
-                    &ctxt->state.aes.key_tweak,
-                    do_aes_encrypt_ecb,
-                    do_aes_decrypt_ecb,
-                    ctxt->state.aes.iv,
-                    len, out, in);
-        break;
-    default:
-        g_assert_not_reached();
+    if (!qcrypto_length_check(len, AES_BLOCK_SIZE, errp)) {
+        return -1;
     }
-
+    do_aes_decrypt_ecb(&ctx->key, len, out, in);
     return 0;
 }
 
-static int qcrypto_cipher_setiv_aes(QCryptoCipher *cipher,
-                                     const uint8_t *iv, size_t niv,
-                                     Error **errp)
+static int qcrypto_cipher_aes_encrypt_cbc(QCryptoCipher *cipher,
+                                          const void *in, void *out,
+                                          size_t len, Error **errp)
 {
-    QCryptoCipherBuiltin *ctxt
-        = container_of(cipher, QCryptoCipherBuiltin, base);
+    QCryptoCipherBuiltinAES *ctx
+        = container_of(cipher, QCryptoCipherBuiltinAES, base);
 
-    if (niv != AES_BLOCK_SIZE) {
-        error_setg(errp, "IV must be %d bytes not %zu",
-                   AES_BLOCK_SIZE, niv);
+    if (!qcrypto_length_check(len, AES_BLOCK_SIZE, errp)) {
         return -1;
     }
-
-    memcpy(ctxt->state.aes.iv, iv, AES_BLOCK_SIZE);
-
+    do_aes_encrypt_cbc(&ctx->key.enc, len, out, in, ctx->iv);
     return 0;
 }
 
+static int qcrypto_cipher_aes_decrypt_cbc(QCryptoCipher *cipher,
+                                          const void *in, void *out,
+                                          size_t len, Error **errp)
+{
+    QCryptoCipherBuiltinAES *ctx
+        = container_of(cipher, QCryptoCipherBuiltinAES, base);
 
+    if (!qcrypto_length_check(len, AES_BLOCK_SIZE, errp)) {
+        return -1;
+    }
+    do_aes_decrypt_cbc(&ctx->key.dec, len, out, in, ctx->iv);
+    return 0;
+}
 
-
-static QCryptoCipher *
-qcrypto_cipher_init_aes(QCryptoCipherMode mode,
-                        const uint8_t *key, size_t nkey,
-                        Error **errp)
+static int qcrypto_cipher_aes_encrypt_xts(QCryptoCipher *cipher,
+                                          const void *in, void *out,
+                                          size_t len, Error **errp)
 {
-    QCryptoCipherBuiltin *ctxt;
+    QCryptoCipherBuiltinAES *ctx
+        = container_of(cipher, QCryptoCipherBuiltinAES, base);
 
-    if (mode != QCRYPTO_CIPHER_MODE_CBC &&
-        mode != QCRYPTO_CIPHER_MODE_ECB &&
-        mode != QCRYPTO_CIPHER_MODE_XTS) {
-        error_setg(errp, "Unsupported cipher mode %s",
-                   QCryptoCipherMode_str(mode));
-        return NULL;
+    if (!qcrypto_length_check(len, AES_BLOCK_SIZE, errp)) {
+        return -1;
     }
+    xts_encrypt(&ctx->key, &ctx->key_tweak,
+                do_aes_encrypt_ecb, do_aes_decrypt_ecb,
+                ctx->iv, len, out, in);
+    return 0;
+}
 
-    ctxt = g_new0(QCryptoCipherBuiltin, 1);
+static int qcrypto_cipher_aes_decrypt_xts(QCryptoCipher *cipher,
+                                          const void *in, void *out,
+                                          size_t len, Error **errp)
+{
+    QCryptoCipherBuiltinAES *ctx
+        = container_of(cipher, QCryptoCipherBuiltinAES, base);
 
-    if (mode == QCRYPTO_CIPHER_MODE_XTS) {
-        if (AES_set_encrypt_key(key, nkey * 4, &ctxt->state.aes.key.enc) != 0) {
-            error_setg(errp, "Failed to set encryption key");
-            goto error;
-        }
+    if (!qcrypto_length_check(len, AES_BLOCK_SIZE, errp)) {
+        return -1;
+    }
+    xts_decrypt(&ctx->key, &ctx->key_tweak,
+                do_aes_encrypt_ecb, do_aes_decrypt_ecb,
+                ctx->iv, len, out, in);
+    return 0;
+}
 
-        if (AES_set_decrypt_key(key, nkey * 4, &ctxt->state.aes.key.dec) != 0) {
-            error_setg(errp, "Failed to set decryption key");
-            goto error;
-        }
 
-        if (AES_set_encrypt_key(key + (nkey / 2), nkey * 4,
-                                &ctxt->state.aes.key_tweak.enc) != 0) {
-            error_setg(errp, "Failed to set encryption key");
-            goto error;
-        }
-
-        if (AES_set_decrypt_key(key + (nkey / 2), nkey * 4,
-                                &ctxt->state.aes.key_tweak.dec) != 0) {
-            error_setg(errp, "Failed to set decryption key");
-            goto error;
-        }
-    } else {
-        if (AES_set_encrypt_key(key, nkey * 8, &ctxt->state.aes.key.enc) != 0) {
-            error_setg(errp, "Failed to set encryption key");
-            goto error;
-        }
+static int qcrypto_cipher_aes_setiv(QCryptoCipher *cipher, const uint8_t *iv,
+                             size_t niv, Error **errp)
+{
+    QCryptoCipherBuiltinAES *ctx
+        = container_of(cipher, QCryptoCipherBuiltinAES, base);
 
-        if (AES_set_decrypt_key(key, nkey * 8, &ctxt->state.aes.key.dec) != 0) {
-            error_setg(errp, "Failed to set decryption key");
-            goto error;
-        }
+    if (niv != AES_BLOCK_SIZE) {
+        error_setg(errp, "IV must be %d bytes not %zu",
+                   AES_BLOCK_SIZE, niv);
+        return -1;
     }
 
-    ctxt->blocksize = AES_BLOCK_SIZE;
-    ctxt->free = qcrypto_cipher_free_aes;
-    ctxt->setiv = qcrypto_cipher_setiv_aes;
-    ctxt->encrypt = qcrypto_cipher_encrypt_aes;
-    ctxt->decrypt = qcrypto_cipher_decrypt_aes;
+    memcpy(ctx->iv, iv, AES_BLOCK_SIZE);
+    return 0;
+}
 
-    ctxt->base.driver = &qcrypto_cipher_lib_driver;
-    return &ctxt->base;
+static const struct QCryptoCipherDriver qcrypto_cipher_aes_driver_ecb = {
+    .cipher_encrypt = qcrypto_cipher_aes_encrypt_ecb,
+    .cipher_decrypt = qcrypto_cipher_aes_decrypt_ecb,
+    .cipher_setiv = qcrypto_cipher_no_setiv,
+    .cipher_free = qcrypto_cipher_ctx_free,
+};
 
- error:
-    g_free(ctxt);
-    return NULL;
-}
+static const struct QCryptoCipherDriver qcrypto_cipher_aes_driver_cbc = {
+    .cipher_encrypt = qcrypto_cipher_aes_encrypt_cbc,
+    .cipher_decrypt = qcrypto_cipher_aes_decrypt_cbc,
+    .cipher_setiv = qcrypto_cipher_aes_setiv,
+    .cipher_free = qcrypto_cipher_ctx_free,
+};
 
+static const struct QCryptoCipherDriver qcrypto_cipher_aes_driver_xts = {
+    .cipher_encrypt = qcrypto_cipher_aes_encrypt_xts,
+    .cipher_decrypt = qcrypto_cipher_aes_decrypt_xts,
+    .cipher_setiv = qcrypto_cipher_aes_setiv,
+    .cipher_free = qcrypto_cipher_ctx_free,
+};
 
-static void qcrypto_cipher_free_des_rfb(QCryptoCipher *cipher)
-{
-    QCryptoCipherBuiltin *ctxt
-        = container_of(cipher, QCryptoCipherBuiltin, base);
 
-    g_free(ctxt->state.desrfb.key);
-    g_free(ctxt);
-}
+typedef struct QCryptoCipherBuiltinDESRFB QCryptoCipherBuiltinDESRFB;
+struct QCryptoCipherBuiltinDESRFB {
+    QCryptoCipher base;
 
+    /* C.f. alg_key_len[QCRYPTO_CIPHER_ALG_DES_RFB] */
+    uint8_t key[8];
+};
 
 static int qcrypto_cipher_encrypt_des_rfb(QCryptoCipher *cipher,
-                                          const void *in,
-                                          void *out,
-                                          size_t len,
-                                          Error **errp)
+                                          const void *in, void *out,
+                                          size_t len, Error **errp)
 {
-    QCryptoCipherBuiltin *ctxt
-        = container_of(cipher, QCryptoCipherBuiltin, base);
+    QCryptoCipherBuiltinDESRFB *ctx
+        = container_of(cipher, QCryptoCipherBuiltinDESRFB, base);
     size_t i;
 
-    if (len % 8) {
-        error_setg(errp, "Buffer size must be multiple of 8 not %zu",
-                   len);
+    if (!qcrypto_length_check(len, 8, errp)) {
         return -1;
     }
 
-    deskey(ctxt->state.desrfb.key, EN0);
+    deskey(ctx->key, EN0);
 
     for (i = 0; i < len; i += 8) {
         des((void *)in + i, out + i);
@@ -336,24 +294,19 @@ static int qcrypto_cipher_encrypt_des_rfb(QCryptoCipher *cipher,
     return 0;
 }
 
-
 static int qcrypto_cipher_decrypt_des_rfb(QCryptoCipher *cipher,
-                                          const void *in,
-                                          void *out,
-                                          size_t len,
-                                          Error **errp)
+                                          const void *in, void *out,
+                                          size_t len, Error **errp)
 {
-    QCryptoCipherBuiltin *ctxt
-        = container_of(cipher, QCryptoCipherBuiltin, base);
+    QCryptoCipherBuiltinDESRFB *ctx
+        = container_of(cipher, QCryptoCipherBuiltinDESRFB, base);
     size_t i;
 
-    if (len % 8) {
-        error_setg(errp, "Buffer size must be multiple of 8 not %zu",
-                   len);
+    if (!qcrypto_length_check(len, 8, errp)) {
         return -1;
     }
 
-    deskey(ctxt->state.desrfb.key, DE1);
+    deskey(ctx->key, DE1);
 
     for (i = 0; i < len; i += 8) {
         des((void *)in + i, out + i);
@@ -362,173 +315,121 @@ static int qcrypto_cipher_decrypt_des_rfb(QCryptoCipher *cipher,
     return 0;
 }
 
-
-static int qcrypto_cipher_setiv_des_rfb(QCryptoCipher *cipher,
-                                        const uint8_t *iv, size_t niv,
-                                        Error **errp)
-{
-    error_setg(errp, "Setting IV is not supported");
-    return -1;
-}
-
-
-static QCryptoCipher *
-qcrypto_cipher_init_des_rfb(QCryptoCipherMode mode,
-                            const uint8_t *key, size_t nkey,
-                            Error **errp)
-{
-    QCryptoCipherBuiltin *ctxt;
-
-    if (mode != QCRYPTO_CIPHER_MODE_ECB) {
-        error_setg(errp, "Unsupported cipher mode %s",
-                   QCryptoCipherMode_str(mode));
-        return NULL;
-    }
-
-    ctxt = g_new0(QCryptoCipherBuiltin, 1);
-
-    ctxt->state.desrfb.key = g_new0(uint8_t, nkey);
-    memcpy(ctxt->state.desrfb.key, key, nkey);
-    ctxt->state.desrfb.nkey = nkey;
-
-    ctxt->blocksize = 8;
-    ctxt->free = qcrypto_cipher_free_des_rfb;
-    ctxt->setiv = qcrypto_cipher_setiv_des_rfb;
-    ctxt->encrypt = qcrypto_cipher_encrypt_des_rfb;
-    ctxt->decrypt = qcrypto_cipher_decrypt_des_rfb;
-
-    ctxt->base.driver = &qcrypto_cipher_lib_driver;
-    return &ctxt->base;
-}
-
+static const struct QCryptoCipherDriver qcrypto_cipher_des_rfb_driver = {
+    .cipher_encrypt = qcrypto_cipher_encrypt_des_rfb,
+    .cipher_decrypt = qcrypto_cipher_decrypt_des_rfb,
+    .cipher_setiv = qcrypto_cipher_no_setiv,
+    .cipher_free = qcrypto_cipher_ctx_free,
+};
 
 bool qcrypto_cipher_supports(QCryptoCipherAlgorithm alg,
                              QCryptoCipherMode mode)
 {
     switch (alg) {
     case QCRYPTO_CIPHER_ALG_DES_RFB:
+        return mode == QCRYPTO_CIPHER_MODE_ECB;
     case QCRYPTO_CIPHER_ALG_AES_128:
     case QCRYPTO_CIPHER_ALG_AES_192:
     case QCRYPTO_CIPHER_ALG_AES_256:
+        switch (mode) {
+        case QCRYPTO_CIPHER_MODE_ECB:
+        case QCRYPTO_CIPHER_MODE_CBC:
+        case QCRYPTO_CIPHER_MODE_XTS:
+            return true;
+        default:
+            return false;
+        }
         break;
     default:
         return false;
     }
-
-    switch (mode) {
-    case QCRYPTO_CIPHER_MODE_ECB:
-    case QCRYPTO_CIPHER_MODE_CBC:
-    case QCRYPTO_CIPHER_MODE_XTS:
-        return true;
-    case QCRYPTO_CIPHER_MODE_CTR:
-        return false;
-    default:
-        return false;
-    }
 }
 
-
 static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
                                              QCryptoCipherMode mode,
                                              const uint8_t *key,
                                              size_t nkey,
                                              Error **errp)
 {
-    switch (mode) {
-    case QCRYPTO_CIPHER_MODE_ECB:
-    case QCRYPTO_CIPHER_MODE_CBC:
-    case QCRYPTO_CIPHER_MODE_XTS:
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
 
     switch (alg) {
     case QCRYPTO_CIPHER_ALG_DES_RFB:
-        return qcrypto_cipher_init_des_rfb(mode, key, nkey, errp);
+        if (mode == QCRYPTO_CIPHER_MODE_ECB) {
+            QCryptoCipherBuiltinDESRFB *ctx;
+
+            ctx = g_new0(QCryptoCipherBuiltinDESRFB, 1);
+            ctx->base.driver = &qcrypto_cipher_des_rfb_driver;
+            memcpy(ctx->key, key, sizeof(ctx->key));
+
+            return &ctx->base;
+        }
+        goto bad_mode;
+
     case QCRYPTO_CIPHER_ALG_AES_128:
     case QCRYPTO_CIPHER_ALG_AES_192:
     case QCRYPTO_CIPHER_ALG_AES_256:
-        return qcrypto_cipher_init_aes(mode, key, nkey, errp);
+        {
+            QCryptoCipherBuiltinAES *ctx;
+            const QCryptoCipherDriver *drv;
+
+            switch (mode) {
+            case QCRYPTO_CIPHER_MODE_ECB:
+                drv = &qcrypto_cipher_aes_driver_ecb;
+                break;
+            case QCRYPTO_CIPHER_MODE_CBC:
+                drv = &qcrypto_cipher_aes_driver_cbc;
+                break;
+            case QCRYPTO_CIPHER_MODE_XTS:
+                drv = &qcrypto_cipher_aes_driver_xts;
+                break;
+            default:
+                goto bad_mode;
+            }
+
+            ctx = g_new0(QCryptoCipherBuiltinAES, 1);
+            ctx->base.driver = drv;
+
+            if (mode == QCRYPTO_CIPHER_MODE_XTS) {
+                nkey /= 2;
+                if (AES_set_encrypt_key(key + nkey, nkey * 8,
+                                        &ctx->key_tweak.enc)) {
+                    error_setg(errp, "Failed to set encryption key");
+                    goto error;
+                }
+                if (AES_set_decrypt_key(key + nkey, nkey * 8,
+                                        &ctx->key_tweak.dec)) {
+                    error_setg(errp, "Failed to set decryption key");
+                    goto error;
+                }
+            }
+            if (AES_set_encrypt_key(key, nkey * 8, &ctx->key.enc)) {
+                error_setg(errp, "Failed to set encryption key");
+                goto error;
+            }
+            if (AES_set_decrypt_key(key, nkey * 8, &ctx->key.dec)) {
+                error_setg(errp, "Failed to set decryption key");
+                goto error;
+            }
+
+            return &ctx->base;
+
+        error:
+            g_free(ctx);
+            return NULL;
+        }
+
     default:
         error_setg(errp,
                    "Unsupported cipher algorithm %s",
                    QCryptoCipherAlgorithm_str(alg));
         return NULL;
     }
-}
-
-static void
-qcrypto_builtin_cipher_ctx_free(QCryptoCipher *cipher)
-{
-    QCryptoCipherBuiltin *ctxt
-        = container_of(cipher, QCryptoCipherBuiltin, base);
-
-    ctxt->free(cipher);
-}
 
-
-static int
-qcrypto_builtin_cipher_encrypt(QCryptoCipher *cipher,
-                               const void *in,
-                               void *out,
-                               size_t len,
-                               Error **errp)
-{
-    QCryptoCipherBuiltin *ctxt
-        = container_of(cipher, QCryptoCipherBuiltin, base);
-
-    if (len & (ctxt->blocksize - 1)) {
-        error_setg(errp, "Length %zu must be a multiple of block size %zu",
-                   len, ctxt->blocksize);
-        return -1;
-    }
-
-    return ctxt->encrypt(cipher, in, out, len, errp);
-}
-
-
-static int
-qcrypto_builtin_cipher_decrypt(QCryptoCipher *cipher,
-                               const void *in,
-                               void *out,
-                               size_t len,
-                               Error **errp)
-{
-    QCryptoCipherBuiltin *ctxt
-        = container_of(cipher, QCryptoCipherBuiltin, base);
-
-    if (len & (ctxt->blocksize - 1)) {
-        error_setg(errp, "Length %zu must be a multiple of block size %zu",
-                   len, ctxt->blocksize);
-        return -1;
-    }
-
-    return ctxt->decrypt(cipher, in, out, len, errp);
-}
-
-
-static int
-qcrypto_builtin_cipher_setiv(QCryptoCipher *cipher,
-                             const uint8_t *iv, size_t niv,
-                             Error **errp)
-{
-    QCryptoCipherBuiltin *ctxt
-        = container_of(cipher, QCryptoCipherBuiltin, base);
-
-    return ctxt->setiv(cipher, iv, niv, errp);
+ bad_mode:
+    error_setg(errp, "Unsupported cipher mode %s",
+               QCryptoCipherMode_str(mode));
+    return NULL;
 }
-
-
-static const struct QCryptoCipherDriver qcrypto_cipher_lib_driver = {
-    .cipher_encrypt = qcrypto_builtin_cipher_encrypt,
-    .cipher_decrypt = qcrypto_builtin_cipher_decrypt,
-    .cipher_setiv = qcrypto_builtin_cipher_setiv,
-    .cipher_free = qcrypto_builtin_cipher_ctx_free,
-};
-- 
2.26.2


