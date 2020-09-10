Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB25EC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:09:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 284F92145D
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MxIuC4P1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 284F92145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGJVl-0005Vk-1q
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGJTX-0000NX-GH
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:06:43 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50460
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGJTU-0007hn-Qq
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599732400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bVZPMD+AIZrLMsJu3MarbFpKaLTjhfH4X3KAM0N6Wfo=;
 b=MxIuC4P1//iy8OhpV6FzdFmOtnvantuvCCqwn0Pfst8BA9SWoswdMe3Y7Nvk6XfxCm824U
 WteWxtzb8p0W/ygxq0uTgx9g5WedAvNECz6jatOEdVHqjL1SgZyuLnTcQFCO7MpLLMJcVS
 sfjUD29vJkz/+9yxsXzb+RV6jLgrQNk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-kwmkB3uQNVunQ4Ex9iCP9Q-1; Thu, 10 Sep 2020 06:06:38 -0400
X-MC-Unique: kwmkB3uQNVunQ4Ex9iCP9Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D6C764081;
 Thu, 10 Sep 2020 10:06:37 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-4.ams2.redhat.com
 [10.36.112.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EAA011002D5C;
 Thu, 10 Sep 2020 10:06:35 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/17] crypto: Allocate QCryptoCipher with the subclass
Date: Thu, 10 Sep 2020 11:06:14 +0100
Message-Id: <20200910100623.1088965-9-berrange@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 00:49:43
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

Merge the allocation of "opaque" into the allocation of "cipher".
This is step one in reducing the indirection in these classes.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/afalgpriv.h          |  3 ++
 crypto/cipher-afalg.c       | 20 ++++++-----
 crypto/cipher-builtin.c.inc | 68 +++++++++++++++++++------------------
 crypto/cipher-gcrypt.c.inc  | 23 +++++++------
 crypto/cipher-nettle.c.inc  | 24 +++++++------
 crypto/cipher.c             | 20 ++++-------
 crypto/cipherpriv.h         |  2 +-
 include/crypto/cipher.h     |  1 -
 8 files changed, 84 insertions(+), 77 deletions(-)

diff --git a/crypto/afalgpriv.h b/crypto/afalgpriv.h
index f6550b5c51..5a2393f1b7 100644
--- a/crypto/afalgpriv.h
+++ b/crypto/afalgpriv.h
@@ -15,6 +15,7 @@
 #define QCRYPTO_AFALGPRIV_H
 
 #include <linux/if_alg.h>
+#include "crypto/cipher.h"
 
 #define SALG_TYPE_LEN_MAX 14
 #define SALG_NAME_LEN_MAX 64
@@ -32,6 +33,8 @@
 typedef struct QCryptoAFAlg QCryptoAFAlg;
 
 struct QCryptoAFAlg {
+    QCryptoCipher base;
+
     int tfmfd;
     int opfd;
     struct msghdr *msg;
diff --git a/crypto/cipher-afalg.c b/crypto/cipher-afalg.c
index 5c7c44761b..86e5249bd6 100644
--- a/crypto/cipher-afalg.c
+++ b/crypto/cipher-afalg.c
@@ -58,7 +58,7 @@ qcrypto_afalg_cipher_format_name(QCryptoCipherAlgorithm alg,
     return name;
 }
 
-QCryptoAFAlg *
+QCryptoCipher *
 qcrypto_afalg_cipher_ctx_new(QCryptoCipherAlgorithm alg,
                              QCryptoCipherMode mode,
                              const uint8_t *key,
@@ -109,7 +109,7 @@ qcrypto_afalg_cipher_ctx_new(QCryptoCipherAlgorithm alg,
     }
     afalg->cmsg = CMSG_FIRSTHDR(afalg->msg);
 
-    return afalg;
+    return &afalg->base;
 }
 
 static int
@@ -117,9 +117,9 @@ qcrypto_afalg_cipher_setiv(QCryptoCipher *cipher,
                            const uint8_t *iv,
                            size_t niv, Error **errp)
 {
+    QCryptoAFAlg *afalg = container_of(cipher, QCryptoAFAlg, base);
     struct af_alg_iv *alg_iv;
     size_t expect_niv;
-    QCryptoAFAlg *afalg = cipher->opaque;
 
     expect_niv = qcrypto_cipher_get_iv_len(cipher->alg, cipher->mode);
     if (niv != expect_niv) {
@@ -200,8 +200,9 @@ qcrypto_afalg_cipher_encrypt(QCryptoCipher *cipher,
                              const void *in, void *out,
                              size_t len, Error **errp)
 {
-    return qcrypto_afalg_cipher_op(cipher->opaque, in, out,
-                                   len, true, errp);
+    QCryptoAFAlg *afalg = container_of(cipher, QCryptoAFAlg, base);
+
+    return qcrypto_afalg_cipher_op(afalg, in, out, len, true, errp);
 }
 
 static int
@@ -209,13 +210,16 @@ qcrypto_afalg_cipher_decrypt(QCryptoCipher *cipher,
                              const void *in, void *out,
                              size_t len, Error **errp)
 {
-    return qcrypto_afalg_cipher_op(cipher->opaque, in, out,
-                                   len, false, errp);
+    QCryptoAFAlg *afalg = container_of(cipher, QCryptoAFAlg, base);
+
+    return qcrypto_afalg_cipher_op(afalg, in, out, len, false, errp);
 }
 
 static void qcrypto_afalg_comm_ctx_free(QCryptoCipher *cipher)
 {
-    qcrypto_afalg_comm_free(cipher->opaque);
+    QCryptoAFAlg *afalg = container_of(cipher, QCryptoAFAlg, base);
+
+    qcrypto_afalg_comm_free(afalg);
 }
 
 const struct QCryptoCipherDriver qcrypto_cipher_afalg_driver = {
diff --git a/crypto/cipher-builtin.c.inc b/crypto/cipher-builtin.c.inc
index 156f32f1c7..6a03e23040 100644
--- a/crypto/cipher-builtin.c.inc
+++ b/crypto/cipher-builtin.c.inc
@@ -41,6 +41,8 @@ struct QCryptoCipherBuiltinDESRFB {
 
 typedef struct QCryptoCipherBuiltin QCryptoCipherBuiltin;
 struct QCryptoCipherBuiltin {
+    QCryptoCipher base;
+
     union {
         QCryptoCipherBuiltinAES aes;
         QCryptoCipherBuiltinDESRFB desrfb;
@@ -65,10 +67,7 @@ struct QCryptoCipherBuiltin {
 
 static void qcrypto_cipher_free_aes(QCryptoCipher *cipher)
 {
-    QCryptoCipherBuiltin *ctxt = cipher->opaque;
-
-    g_free(ctxt);
-    cipher->opaque = NULL;
+    g_free(cipher);
 }
 
 
@@ -152,7 +151,8 @@ static int qcrypto_cipher_encrypt_aes(QCryptoCipher *cipher,
                                       size_t len,
                                       Error **errp)
 {
-    QCryptoCipherBuiltin *ctxt = cipher->opaque;
+    QCryptoCipherBuiltin *ctxt
+        = container_of(cipher, QCryptoCipherBuiltin, base);
 
     switch (cipher->mode) {
     case QCRYPTO_CIPHER_MODE_ECB:
@@ -186,7 +186,8 @@ static int qcrypto_cipher_decrypt_aes(QCryptoCipher *cipher,
                                       size_t len,
                                       Error **errp)
 {
-    QCryptoCipherBuiltin *ctxt = cipher->opaque;
+    QCryptoCipherBuiltin *ctxt
+        = container_of(cipher, QCryptoCipherBuiltin, base);
 
     switch (cipher->mode) {
     case QCRYPTO_CIPHER_MODE_ECB:
@@ -217,7 +218,9 @@ static int qcrypto_cipher_setiv_aes(QCryptoCipher *cipher,
                                      const uint8_t *iv, size_t niv,
                                      Error **errp)
 {
-    QCryptoCipherBuiltin *ctxt = cipher->opaque;
+    QCryptoCipherBuiltin *ctxt
+        = container_of(cipher, QCryptoCipherBuiltin, base);
+
     if (niv != AES_BLOCK_SIZE) {
         error_setg(errp, "IV must be %d bytes not %zu",
                    AES_BLOCK_SIZE, niv);
@@ -232,7 +235,7 @@ static int qcrypto_cipher_setiv_aes(QCryptoCipher *cipher,
 
 
 
-static QCryptoCipherBuiltin *
+static QCryptoCipher *
 qcrypto_cipher_init_aes(QCryptoCipherMode mode,
                         const uint8_t *key, size_t nkey,
                         Error **errp)
@@ -289,7 +292,7 @@ qcrypto_cipher_init_aes(QCryptoCipherMode mode,
     ctxt->encrypt = qcrypto_cipher_encrypt_aes;
     ctxt->decrypt = qcrypto_cipher_decrypt_aes;
 
-    return ctxt;
+    return &ctxt->base;
 
  error:
     g_free(ctxt);
@@ -299,11 +302,11 @@ qcrypto_cipher_init_aes(QCryptoCipherMode mode,
 
 static void qcrypto_cipher_free_des_rfb(QCryptoCipher *cipher)
 {
-    QCryptoCipherBuiltin *ctxt = cipher->opaque;
+    QCryptoCipherBuiltin *ctxt
+        = container_of(cipher, QCryptoCipherBuiltin, base);
 
     g_free(ctxt->state.desrfb.key);
     g_free(ctxt);
-    cipher->opaque = NULL;
 }
 
 
@@ -313,7 +316,8 @@ static int qcrypto_cipher_encrypt_des_rfb(QCryptoCipher *cipher,
                                           size_t len,
                                           Error **errp)
 {
-    QCryptoCipherBuiltin *ctxt = cipher->opaque;
+    QCryptoCipherBuiltin *ctxt
+        = container_of(cipher, QCryptoCipherBuiltin, base);
     size_t i;
 
     if (len % 8) {
@@ -338,7 +342,8 @@ static int qcrypto_cipher_decrypt_des_rfb(QCryptoCipher *cipher,
                                           size_t len,
                                           Error **errp)
 {
-    QCryptoCipherBuiltin *ctxt = cipher->opaque;
+    QCryptoCipherBuiltin *ctxt
+        = container_of(cipher, QCryptoCipherBuiltin, base);
     size_t i;
 
     if (len % 8) {
@@ -366,7 +371,7 @@ static int qcrypto_cipher_setiv_des_rfb(QCryptoCipher *cipher,
 }
 
 
-static QCryptoCipherBuiltin *
+static QCryptoCipher *
 qcrypto_cipher_init_des_rfb(QCryptoCipherMode mode,
                             const uint8_t *key, size_t nkey,
                             Error **errp)
@@ -391,7 +396,7 @@ qcrypto_cipher_init_des_rfb(QCryptoCipherMode mode,
     ctxt->encrypt = qcrypto_cipher_encrypt_des_rfb;
     ctxt->decrypt = qcrypto_cipher_decrypt_des_rfb;
 
-    return ctxt;
+    return &ctxt->base;
 }
 
 
@@ -421,14 +426,12 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgorithm alg,
 }
 
 
-static QCryptoCipherBuiltin *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
-                                                    QCryptoCipherMode mode,
-                                                    const uint8_t *key,
-                                                    size_t nkey,
-                                                    Error **errp)
+static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
+                                             QCryptoCipherMode mode,
+                                             const uint8_t *key,
+                                             size_t nkey,
+                                             Error **errp)
 {
-    QCryptoCipherBuiltin *ctxt;
-
     switch (mode) {
     case QCRYPTO_CIPHER_MODE_ECB:
     case QCRYPTO_CIPHER_MODE_CBC:
@@ -446,29 +449,25 @@ static QCryptoCipherBuiltin *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
 
     switch (alg) {
     case QCRYPTO_CIPHER_ALG_DES_RFB:
-        ctxt = qcrypto_cipher_init_des_rfb(mode, key, nkey, errp);
-        break;
+        return qcrypto_cipher_init_des_rfb(mode, key, nkey, errp);
     case QCRYPTO_CIPHER_ALG_AES_128:
     case QCRYPTO_CIPHER_ALG_AES_192:
     case QCRYPTO_CIPHER_ALG_AES_256:
-        ctxt = qcrypto_cipher_init_aes(mode, key, nkey, errp);
-        break;
+        return qcrypto_cipher_init_aes(mode, key, nkey, errp);
     default:
         error_setg(errp,
                    "Unsupported cipher algorithm %s",
                    QCryptoCipherAlgorithm_str(alg));
         return NULL;
     }
-
-    return ctxt;
 }
 
 static void
 qcrypto_builtin_cipher_ctx_free(QCryptoCipher *cipher)
 {
-    QCryptoCipherBuiltin *ctxt;
+    QCryptoCipherBuiltin *ctxt
+        = container_of(cipher, QCryptoCipherBuiltin, base);
 
-    ctxt = cipher->opaque;
     ctxt->free(cipher);
 }
 
@@ -480,7 +479,8 @@ qcrypto_builtin_cipher_encrypt(QCryptoCipher *cipher,
                                size_t len,
                                Error **errp)
 {
-    QCryptoCipherBuiltin *ctxt = cipher->opaque;
+    QCryptoCipherBuiltin *ctxt
+        = container_of(cipher, QCryptoCipherBuiltin, base);
 
     if (len & (ctxt->blocksize - 1)) {
         error_setg(errp, "Length %zu must be a multiple of block size %zu",
@@ -499,7 +499,8 @@ qcrypto_builtin_cipher_decrypt(QCryptoCipher *cipher,
                                size_t len,
                                Error **errp)
 {
-    QCryptoCipherBuiltin *ctxt = cipher->opaque;
+    QCryptoCipherBuiltin *ctxt
+        = container_of(cipher, QCryptoCipherBuiltin, base);
 
     if (len & (ctxt->blocksize - 1)) {
         error_setg(errp, "Length %zu must be a multiple of block size %zu",
@@ -516,7 +517,8 @@ qcrypto_builtin_cipher_setiv(QCryptoCipher *cipher,
                              const uint8_t *iv, size_t niv,
                              Error **errp)
 {
-    QCryptoCipherBuiltin *ctxt = cipher->opaque;
+    QCryptoCipherBuiltin *ctxt
+        = container_of(cipher, QCryptoCipherBuiltin, base);
 
     return ctxt->setiv(cipher, iv, niv, errp);
 }
diff --git a/crypto/cipher-gcrypt.c.inc b/crypto/cipher-gcrypt.c.inc
index 18850fadb9..3b3c85e265 100644
--- a/crypto/cipher-gcrypt.c.inc
+++ b/crypto/cipher-gcrypt.c.inc
@@ -58,6 +58,7 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgorithm alg,
 
 typedef struct QCryptoCipherGcrypt QCryptoCipherGcrypt;
 struct QCryptoCipherGcrypt {
+    QCryptoCipher base;
     gcry_cipher_hd_t handle;
     size_t blocksize;
 #ifdef CONFIG_QEMU_PRIVATE_XTS
@@ -86,11 +87,11 @@ qcrypto_gcrypt_cipher_free_ctx(QCryptoCipherGcrypt *ctx,
 }
 
 
-static QCryptoCipherGcrypt *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
-                                                   QCryptoCipherMode mode,
-                                                   const uint8_t *key,
-                                                   size_t nkey,
-                                                   Error **errp)
+static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
+                                             QCryptoCipherMode mode,
+                                             const uint8_t *key,
+                                             size_t nkey,
+                                             Error **errp)
 {
     QCryptoCipherGcrypt *ctx;
     gcry_error_t err;
@@ -257,7 +258,7 @@ static QCryptoCipherGcrypt *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
     }
 #endif
 
-    return ctx;
+    return &ctx->base;
 
  error:
     qcrypto_gcrypt_cipher_free_ctx(ctx, mode);
@@ -268,7 +269,9 @@ static QCryptoCipherGcrypt *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
 static void
 qcrypto_gcrypt_cipher_ctx_free(QCryptoCipher *cipher)
 {
-    qcrypto_gcrypt_cipher_free_ctx(cipher->opaque, cipher->mode);
+    QCryptoCipherGcrypt *ctx = container_of(cipher, QCryptoCipherGcrypt, base);
+
+    qcrypto_gcrypt_cipher_free_ctx(ctx, cipher->mode);
 }
 
 
@@ -301,7 +304,7 @@ qcrypto_gcrypt_cipher_encrypt(QCryptoCipher *cipher,
                               size_t len,
                               Error **errp)
 {
-    QCryptoCipherGcrypt *ctx = cipher->opaque;
+    QCryptoCipherGcrypt *ctx = container_of(cipher, QCryptoCipherGcrypt, base);
     gcry_error_t err;
 
     if (len & (ctx->blocksize - 1)) {
@@ -340,7 +343,7 @@ qcrypto_gcrypt_cipher_decrypt(QCryptoCipher *cipher,
                               size_t len,
                               Error **errp)
 {
-    QCryptoCipherGcrypt *ctx = cipher->opaque;
+    QCryptoCipherGcrypt *ctx = container_of(cipher, QCryptoCipherGcrypt, base);
     gcry_error_t err;
 
     if (len & (ctx->blocksize - 1)) {
@@ -376,7 +379,7 @@ qcrypto_gcrypt_cipher_setiv(QCryptoCipher *cipher,
                             const uint8_t *iv, size_t niv,
                             Error **errp)
 {
-    QCryptoCipherGcrypt *ctx = cipher->opaque;
+    QCryptoCipherGcrypt *ctx = container_of(cipher, QCryptoCipherGcrypt, base);
     gcry_error_t err;
 
     if (niv != ctx->blocksize) {
diff --git a/crypto/cipher-nettle.c.inc b/crypto/cipher-nettle.c.inc
index 6ecce5e8ea..d8371d1f37 100644
--- a/crypto/cipher-nettle.c.inc
+++ b/crypto/cipher-nettle.c.inc
@@ -294,6 +294,8 @@ static void twofish_decrypt_wrapper(const void *ctx, size_t length,
 
 typedef struct QCryptoCipherNettle QCryptoCipherNettle;
 struct QCryptoCipherNettle {
+    QCryptoCipher base;
+
     /* Primary cipher context for all modes */
     void *ctx;
     /* Second cipher context for XTS mode only */
@@ -355,11 +357,11 @@ qcrypto_nettle_cipher_free_ctx(QCryptoCipherNettle *ctx)
 }
 
 
-static QCryptoCipherNettle *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
-                                                   QCryptoCipherMode mode,
-                                                   const uint8_t *key,
-                                                   size_t nkey,
-                                                   Error **errp)
+static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
+                                             QCryptoCipherMode mode,
+                                             const uint8_t *key,
+                                             size_t nkey,
+                                             Error **errp)
 {
     QCryptoCipherNettle *ctx;
     uint8_t *rfbkey;
@@ -585,7 +587,7 @@ static QCryptoCipherNettle *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
 
     ctx->iv = g_new0(uint8_t, ctx->blocksize);
 
-    return ctx;
+    return &ctx->base;
 
  error:
     qcrypto_nettle_cipher_free_ctx(ctx);
@@ -596,9 +598,8 @@ static QCryptoCipherNettle *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
 static void
 qcrypto_nettle_cipher_ctx_free(QCryptoCipher *cipher)
 {
-    QCryptoCipherNettle *ctx;
+    QCryptoCipherNettle *ctx = container_of(cipher, QCryptoCipherNettle, base);
 
-    ctx = cipher->opaque;
     qcrypto_nettle_cipher_free_ctx(ctx);
 }
 
@@ -610,7 +611,7 @@ qcrypto_nettle_cipher_encrypt(QCryptoCipher *cipher,
                               size_t len,
                               Error **errp)
 {
-    QCryptoCipherNettle *ctx = cipher->opaque;
+    QCryptoCipherNettle *ctx = container_of(cipher, QCryptoCipherNettle, base);
 
     if (len & (ctx->blocksize - 1)) {
         error_setg(errp, "Length %zu must be a multiple of block size %zu",
@@ -663,7 +664,7 @@ qcrypto_nettle_cipher_decrypt(QCryptoCipher *cipher,
                               size_t len,
                               Error **errp)
 {
-    QCryptoCipherNettle *ctx = cipher->opaque;
+    QCryptoCipherNettle *ctx = container_of(cipher, QCryptoCipherNettle, base);
 
     if (len & (ctx->blocksize - 1)) {
         error_setg(errp, "Length %zu must be a multiple of block size %zu",
@@ -713,7 +714,8 @@ qcrypto_nettle_cipher_setiv(QCryptoCipher *cipher,
                             const uint8_t *iv, size_t niv,
                             Error **errp)
 {
-    QCryptoCipherNettle *ctx = cipher->opaque;
+    QCryptoCipherNettle *ctx = container_of(cipher, QCryptoCipherNettle, base);
+
     if (niv != ctx->blocksize) {
         error_setg(errp, "Expected IV size %zu not %zu",
                    ctx->blocksize, niv);
diff --git a/crypto/cipher.c b/crypto/cipher.c
index 3ca4a7e662..737fc0735d 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -163,30 +163,27 @@ QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
                                   const uint8_t *key, size_t nkey,
                                   Error **errp)
 {
-    QCryptoCipher *cipher;
-    void *ctx = NULL;
+    QCryptoCipher *cipher = NULL;
     const QCryptoCipherDriver *drv = NULL;
 
 #ifdef CONFIG_AF_ALG
-    ctx = qcrypto_afalg_cipher_ctx_new(alg, mode, key, nkey, NULL);
-    if (ctx) {
+    cipher = qcrypto_afalg_cipher_ctx_new(alg, mode, key, nkey, NULL);
+    if (cipher) {
         drv = &qcrypto_cipher_afalg_driver;
     }
 #endif
 
-    if (!ctx) {
-        ctx = qcrypto_cipher_ctx_new(alg, mode, key, nkey, errp);
-        if (!ctx) {
+    if (!cipher) {
+        cipher = qcrypto_cipher_ctx_new(alg, mode, key, nkey, errp);
+        if (!cipher) {
             return NULL;
         }
 
         drv = &qcrypto_cipher_lib_driver;
     }
 
-    cipher = g_new0(QCryptoCipher, 1);
     cipher->alg = alg;
     cipher->mode = mode;
-    cipher->opaque = ctx;
     cipher->driver = drv;
 
     return cipher;
@@ -226,10 +223,7 @@ int qcrypto_cipher_setiv(QCryptoCipher *cipher,
 
 void qcrypto_cipher_free(QCryptoCipher *cipher)
 {
-    const QCryptoCipherDriver *drv;
     if (cipher) {
-        drv = cipher->driver;
-        drv->cipher_free(cipher);
-        g_free(cipher);
+        cipher->driver->cipher_free(cipher);
     }
 }
diff --git a/crypto/cipherpriv.h b/crypto/cipherpriv.h
index b73be33bd2..437b109b5e 100644
--- a/crypto/cipherpriv.h
+++ b/crypto/cipherpriv.h
@@ -41,7 +41,7 @@ struct QCryptoCipherDriver {
 
 #include "afalgpriv.h"
 
-extern QCryptoAFAlg *
+extern QCryptoCipher *
 qcrypto_afalg_cipher_ctx_new(QCryptoCipherAlgorithm alg,
                              QCryptoCipherMode mode,
                              const uint8_t *key,
diff --git a/include/crypto/cipher.h b/include/crypto/cipher.h
index cc57179a4d..083e12a7d9 100644
--- a/include/crypto/cipher.h
+++ b/include/crypto/cipher.h
@@ -80,7 +80,6 @@ typedef struct QCryptoCipherDriver QCryptoCipherDriver;
 struct QCryptoCipher {
     QCryptoCipherAlgorithm alg;
     QCryptoCipherMode mode;
-    void *opaque;
     const QCryptoCipherDriver *driver;
 };
 
-- 
2.26.2


