Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCF9C742B2
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 10:19:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63BE32084B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 10:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63BE32084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlse4-0002Ix-GJ
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 06:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57409)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hlsdm-0001FW-4P
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 06:18:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hlsdk-0001PL-Hg
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 06:18:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42516)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hlsdk-0001P1-9L
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 06:18:56 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9846085543;
 Fri, 12 Jul 2019 10:18:55 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-54.ams2.redhat.com
 [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E556060BFB;
 Fri, 12 Jul 2019 10:18:53 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 12 Jul 2019 11:18:48 +0100
Message-Id: <20190712101849.8993-2-berrange@redhat.com>
In-Reply-To: <20190712101849.8993-1-berrange@redhat.com>
References: <20190712101849.8993-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Fri, 12 Jul 2019 10:18:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.1 1/2] crypto: switch to modern nettle
 AES APIs
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Amol Surati <suratiamol@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The aes_ctx struct and aes_* functions have been deprecated in nettle
3.5, in favour of keysize specific functions which were introduced
first in nettle 3.0.

Switch QEMU code to use the new APIs and add some backcompat defines
such that it still builds on nettle 2.7

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 crypto/cipher-nettle.c | 218 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 183 insertions(+), 35 deletions(-)

diff --git a/crypto/cipher-nettle.c b/crypto/cipher-nettle.c
index 3848cb3b3a..115d16dd7b 100644
--- a/crypto/cipher-nettle.c
+++ b/crypto/cipher-nettle.c
@@ -42,29 +42,89 @@ typedef void *       cipher_ctx_t;
 typedef unsigned     cipher_length_t;
=20
 #define cast5_set_key cast128_set_key
+
+#define aes128_ctx aes_ctx
+#define aes192_ctx aes_ctx
+#define aes256_ctx aes_ctx
+#define aes128_set_encrypt_key(c, k) \
+    aes_set_encrypt_key(c, 16, k)
+#define aes192_set_encrypt_key(c, k) \
+    aes_set_encrypt_key(c, 24, k)
+#define aes256_set_encrypt_key(c, k) \
+    aes_set_encrypt_key(c, 32, k)
+#define aes128_set_decrypt_key(c, k) \
+    aes_set_decrypt_key(c, 16, k)
+#define aes192_set_decrypt_key(c, k) \
+    aes_set_decrypt_key(c, 24, k)
+#define aes256_set_decrypt_key(c, k) \
+    aes_set_decrypt_key(c, 32, k)
+#define aes128_encrypt aes_encrypt
+#define aes192_encrypt aes_encrypt
+#define aes256_encrypt aes_encrypt
+#define aes128_decrypt aes_decrypt
+#define aes192_decrypt aes_decrypt
+#define aes256_decrypt aes_decrypt
 #else
 typedef nettle_cipher_func * QCryptoCipherNettleFuncNative;
 typedef const void * cipher_ctx_t;
 typedef size_t       cipher_length_t;
 #endif
=20
-typedef struct QCryptoNettleAES {
-    struct aes_ctx enc;
-    struct aes_ctx dec;
-} QCryptoNettleAES;
+typedef struct QCryptoNettleAES128 {
+    struct aes128_ctx enc;
+    struct aes128_ctx dec;
+} QCryptoNettleAES128;
+
+typedef struct QCryptoNettleAES192 {
+    struct aes192_ctx enc;
+    struct aes192_ctx dec;
+} QCryptoNettleAES192;
+
+typedef struct QCryptoNettleAES256 {
+    struct aes256_ctx enc;
+    struct aes256_ctx dec;
+} QCryptoNettleAES256;
+
+static void aes128_encrypt_native(cipher_ctx_t ctx, cipher_length_t leng=
th,
+                                  uint8_t *dst, const uint8_t *src)
+{
+    const QCryptoNettleAES128 *aesctx =3D ctx;
+    aes128_encrypt(&aesctx->enc, length, dst, src);
+}
+
+static void aes128_decrypt_native(cipher_ctx_t ctx, cipher_length_t leng=
th,
+                                  uint8_t *dst, const uint8_t *src)
+{
+    const QCryptoNettleAES128 *aesctx =3D ctx;
+    aes128_decrypt(&aesctx->dec, length, dst, src);
+}
+
+static void aes192_encrypt_native(cipher_ctx_t ctx, cipher_length_t leng=
th,
+                               uint8_t *dst, const uint8_t *src)
+{
+    const QCryptoNettleAES192 *aesctx =3D ctx;
+    aes192_encrypt(&aesctx->enc, length, dst, src);
+}
+
+static void aes192_decrypt_native(cipher_ctx_t ctx, cipher_length_t leng=
th,
+                               uint8_t *dst, const uint8_t *src)
+{
+    const QCryptoNettleAES192 *aesctx =3D ctx;
+    aes192_decrypt(&aesctx->dec, length, dst, src);
+}
=20
-static void aes_encrypt_native(cipher_ctx_t ctx, cipher_length_t length,
+static void aes256_encrypt_native(cipher_ctx_t ctx, cipher_length_t leng=
th,
                                uint8_t *dst, const uint8_t *src)
 {
-    const QCryptoNettleAES *aesctx =3D ctx;
-    aes_encrypt(&aesctx->enc, length, dst, src);
+    const QCryptoNettleAES256 *aesctx =3D ctx;
+    aes256_encrypt(&aesctx->enc, length, dst, src);
 }
=20
-static void aes_decrypt_native(cipher_ctx_t ctx, cipher_length_t length,
+static void aes256_decrypt_native(cipher_ctx_t ctx, cipher_length_t leng=
th,
                                uint8_t *dst, const uint8_t *src)
 {
-    const QCryptoNettleAES *aesctx =3D ctx;
-    aes_decrypt(&aesctx->dec, length, dst, src);
+    const QCryptoNettleAES256 *aesctx =3D ctx;
+    aes256_decrypt(&aesctx->dec, length, dst, src);
 }
=20
 static void des_encrypt_native(cipher_ctx_t ctx, cipher_length_t length,
@@ -127,18 +187,46 @@ static void twofish_decrypt_native(cipher_ctx_t ctx=
, cipher_length_t length,
     twofish_decrypt(ctx, length, dst, src);
 }
=20
-static void aes_encrypt_wrapper(const void *ctx, size_t length,
+static void aes128_encrypt_wrapper(const void *ctx, size_t length,
+                                uint8_t *dst, const uint8_t *src)
+{
+    const QCryptoNettleAES128 *aesctx =3D ctx;
+    aes128_encrypt(&aesctx->enc, length, dst, src);
+}
+
+static void aes128_decrypt_wrapper(const void *ctx, size_t length,
                                 uint8_t *dst, const uint8_t *src)
 {
-    const QCryptoNettleAES *aesctx =3D ctx;
-    aes_encrypt(&aesctx->enc, length, dst, src);
+    const QCryptoNettleAES128 *aesctx =3D ctx;
+    aes128_decrypt(&aesctx->dec, length, dst, src);
 }
=20
-static void aes_decrypt_wrapper(const void *ctx, size_t length,
+static void aes192_encrypt_wrapper(const void *ctx, size_t length,
                                 uint8_t *dst, const uint8_t *src)
 {
-    const QCryptoNettleAES *aesctx =3D ctx;
-    aes_decrypt(&aesctx->dec, length, dst, src);
+    const QCryptoNettleAES192 *aesctx =3D ctx;
+    aes192_encrypt(&aesctx->enc, length, dst, src);
+}
+
+static void aes192_decrypt_wrapper(const void *ctx, size_t length,
+                                uint8_t *dst, const uint8_t *src)
+{
+    const QCryptoNettleAES192 *aesctx =3D ctx;
+    aes192_decrypt(&aesctx->dec, length, dst, src);
+}
+
+static void aes256_encrypt_wrapper(const void *ctx, size_t length,
+                                uint8_t *dst, const uint8_t *src)
+{
+    const QCryptoNettleAES256 *aesctx =3D ctx;
+    aes256_encrypt(&aesctx->enc, length, dst, src);
+}
+
+static void aes256_decrypt_wrapper(const void *ctx, size_t length,
+                                uint8_t *dst, const uint8_t *src)
+{
+    const QCryptoNettleAES256 *aesctx =3D ctx;
+    aes256_decrypt(&aesctx->dec, length, dst, src);
 }
=20
 static void des_encrypt_wrapper(const void *ctx, size_t length,
@@ -319,34 +407,94 @@ static QCryptoCipherNettle *qcrypto_cipher_ctx_new(=
QCryptoCipherAlgorithm alg,
         break;
=20
     case QCRYPTO_CIPHER_ALG_AES_128:
+        ctx->ctx =3D g_new0(QCryptoNettleAES128, 1);
+
+        if (mode =3D=3D QCRYPTO_CIPHER_MODE_XTS) {
+            ctx->ctx_tweak =3D g_new0(QCryptoNettleAES128, 1);
+
+            nkey /=3D 2;
+            aes128_set_encrypt_key(&((QCryptoNettleAES128 *)ctx->ctx)->e=
nc,
+                                   key);
+            aes128_set_decrypt_key(&((QCryptoNettleAES128 *)ctx->ctx)->d=
ec,
+                                   key);
+
+            aes128_set_encrypt_key(&((QCryptoNettleAES128 *)ctx->ctx_twe=
ak)->
+                                   enc, key + nkey);
+            aes128_set_decrypt_key(&((QCryptoNettleAES128 *)ctx->ctx_twe=
ak)->
+                                   dec, key + nkey);
+        } else {
+            aes128_set_encrypt_key(&((QCryptoNettleAES128 *)ctx->ctx)->e=
nc,
+                                   key);
+            aes128_set_decrypt_key(&((QCryptoNettleAES128 *)ctx->ctx)->d=
ec,
+                                   key);
+        }
+
+        ctx->alg_encrypt_native =3D aes128_encrypt_native;
+        ctx->alg_decrypt_native =3D aes128_decrypt_native;
+        ctx->alg_encrypt_wrapper =3D aes128_encrypt_wrapper;
+        ctx->alg_decrypt_wrapper =3D aes128_decrypt_wrapper;
+
+        ctx->blocksize =3D AES_BLOCK_SIZE;
+        break;
+
     case QCRYPTO_CIPHER_ALG_AES_192:
+        ctx->ctx =3D g_new0(QCryptoNettleAES192, 1);
+
+        if (mode =3D=3D QCRYPTO_CIPHER_MODE_XTS) {
+            ctx->ctx_tweak =3D g_new0(QCryptoNettleAES192, 1);
+
+            nkey /=3D 2;
+            aes192_set_encrypt_key(&((QCryptoNettleAES192 *)ctx->ctx)->e=
nc,
+                                   key);
+            aes192_set_decrypt_key(&((QCryptoNettleAES192 *)ctx->ctx)->d=
ec,
+                                   key);
+
+            aes192_set_encrypt_key(&((QCryptoNettleAES192 *)ctx->ctx_twe=
ak)->
+                                   enc, key + nkey);
+            aes192_set_decrypt_key(&((QCryptoNettleAES192 *)ctx->ctx_twe=
ak)->
+                                   dec, key + nkey);
+        } else {
+            aes192_set_encrypt_key(&((QCryptoNettleAES192 *)ctx->ctx)->e=
nc,
+                                   key);
+            aes192_set_decrypt_key(&((QCryptoNettleAES192 *)ctx->ctx)->d=
ec,
+                                   key);
+        }
+
+        ctx->alg_encrypt_native =3D aes192_encrypt_native;
+        ctx->alg_decrypt_native =3D aes192_decrypt_native;
+        ctx->alg_encrypt_wrapper =3D aes192_encrypt_wrapper;
+        ctx->alg_decrypt_wrapper =3D aes192_decrypt_wrapper;
+
+        ctx->blocksize =3D AES_BLOCK_SIZE;
+        break;
+
     case QCRYPTO_CIPHER_ALG_AES_256:
-        ctx->ctx =3D g_new0(QCryptoNettleAES, 1);
+        ctx->ctx =3D g_new0(QCryptoNettleAES256, 1);
=20
         if (mode =3D=3D QCRYPTO_CIPHER_MODE_XTS) {
-            ctx->ctx_tweak =3D g_new0(QCryptoNettleAES, 1);
+            ctx->ctx_tweak =3D g_new0(QCryptoNettleAES256, 1);
=20
             nkey /=3D 2;
-            aes_set_encrypt_key(&((QCryptoNettleAES *)ctx->ctx)->enc,
-                                nkey, key);
-            aes_set_decrypt_key(&((QCryptoNettleAES *)ctx->ctx)->dec,
-                                nkey, key);
-
-            aes_set_encrypt_key(&((QCryptoNettleAES *)ctx->ctx_tweak)->e=
nc,
-                                nkey, key + nkey);
-            aes_set_decrypt_key(&((QCryptoNettleAES *)ctx->ctx_tweak)->d=
ec,
-                                nkey, key + nkey);
+            aes256_set_encrypt_key(&((QCryptoNettleAES256 *)ctx->ctx)->e=
nc,
+                                   key);
+            aes256_set_decrypt_key(&((QCryptoNettleAES256 *)ctx->ctx)->d=
ec,
+                                   key);
+
+            aes256_set_encrypt_key(&((QCryptoNettleAES256 *)ctx->ctx_twe=
ak)->
+                                   enc, key + nkey);
+            aes256_set_decrypt_key(&((QCryptoNettleAES256 *)ctx->ctx_twe=
ak)->
+                                   dec, key + nkey);
         } else {
-            aes_set_encrypt_key(&((QCryptoNettleAES *)ctx->ctx)->enc,
-                                nkey, key);
-            aes_set_decrypt_key(&((QCryptoNettleAES *)ctx->ctx)->dec,
-                                nkey, key);
+            aes256_set_encrypt_key(&((QCryptoNettleAES256 *)ctx->ctx)->e=
nc,
+                                   key);
+            aes256_set_decrypt_key(&((QCryptoNettleAES256 *)ctx->ctx)->d=
ec,
+                                   key);
         }
=20
-        ctx->alg_encrypt_native =3D aes_encrypt_native;
-        ctx->alg_decrypt_native =3D aes_decrypt_native;
-        ctx->alg_encrypt_wrapper =3D aes_encrypt_wrapper;
-        ctx->alg_decrypt_wrapper =3D aes_decrypt_wrapper;
+        ctx->alg_encrypt_native =3D aes256_encrypt_native;
+        ctx->alg_decrypt_native =3D aes256_decrypt_native;
+        ctx->alg_encrypt_wrapper =3D aes256_encrypt_wrapper;
+        ctx->alg_decrypt_wrapper =3D aes256_decrypt_wrapper;
=20
         ctx->blocksize =3D AES_BLOCK_SIZE;
         break;
--=20
2.21.0


