Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC5CC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:12:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A21220BED
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LLAwAj8K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A21220BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGJZ1-0003iy-SM
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGJTd-0000U1-Be
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:06:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54284
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGJTb-0007il-Az
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:06:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599732406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ks5DjWJdmSrk8l3V2pBehAqHtpAVlLDpFKUC7ipwfQ4=;
 b=LLAwAj8KBtCTwrMnY1KVpoTd2UlPwNyfQYW9+K27G1w2HG0PhBGBlyggGf4vbuboawORqo
 IlnOIICqR7snqy8Qw9/zuZhlBa3Firi1xv5+GcoGvvP1lTFOSuuKe55EVhVLjKeg3NYGvq
 /dveAdh0OqLFmHUCfMzTx2OD0NGlyh0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-xWiUS65bMwuoiiwoPK5N3Q-1; Thu, 10 Sep 2020 06:06:44 -0400
X-MC-Unique: xWiUS65bMwuoiiwoPK5N3Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A5E2801F95;
 Thu, 10 Sep 2020 10:06:43 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-4.ams2.redhat.com
 [10.36.112.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 11FFB1002D41;
 Thu, 10 Sep 2020 10:06:41 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/17] crypto/builtin: Merge qcrypto_cipher_aes_{ecb, xts}_{en,
 de}crypt
Date: Thu, 10 Sep 2020 11:06:18 +0100
Message-Id: <20200910100623.1088965-13-berrange@redhat.com>
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
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 01:23:25
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
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

There's no real reason we need two separate helper functions here.
Standardize on the function signature required for xts_encrypt.
Rename to do_aes_{en,de}crypt_ecb, since the helper does not
itself do anything with respect to xts.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/cipher-builtin.c.inc | 73 +++++++++++--------------------------
 1 file changed, 22 insertions(+), 51 deletions(-)

diff --git a/crypto/cipher-builtin.c.inc b/crypto/cipher-builtin.c.inc
index e2ae5d090c..8e21f2673f 100644
--- a/crypto/cipher-builtin.c.inc
+++ b/crypto/cipher-builtin.c.inc
@@ -72,65 +72,38 @@ static void qcrypto_cipher_free_aes(QCryptoCipher *cipher)
     g_free(cipher);
 }
 
-
-static void qcrypto_cipher_aes_ecb_encrypt(const AES_KEY *key,
-                                           const void *in,
-                                           void *out,
-                                           size_t len)
+static void do_aes_encrypt_ecb(const void *vctx,
+                               size_t len,
+                               uint8_t *out,
+                               const uint8_t *in)
 {
-    const uint8_t *inptr = in;
-    uint8_t *outptr = out;
+    const QCryptoCipherBuiltinAESContext *ctx = vctx;
 
     /* We have already verified that len % AES_BLOCK_SIZE == 0. */
     while (len) {
-        AES_encrypt(inptr, outptr, key);
-        inptr += AES_BLOCK_SIZE;
-        outptr += AES_BLOCK_SIZE;
+        AES_encrypt(in, out, &ctx->enc);
+        in += AES_BLOCK_SIZE;
+        out += AES_BLOCK_SIZE;
         len -= AES_BLOCK_SIZE;
     }
 }
 
-
-static void qcrypto_cipher_aes_ecb_decrypt(const AES_KEY *key,
-                                           const void *in,
-                                           void *out,
-                                           size_t len)
+static void do_aes_decrypt_ecb(const void *vctx,
+                               size_t len,
+                               uint8_t *out,
+                               const uint8_t *in)
 {
-    const uint8_t *inptr = in;
-    uint8_t *outptr = out;
+    const QCryptoCipherBuiltinAESContext *ctx = vctx;
 
     /* We have already verified that len % AES_BLOCK_SIZE == 0. */
     while (len) {
-        AES_decrypt(inptr, outptr, key);
-        inptr += AES_BLOCK_SIZE;
-        outptr += AES_BLOCK_SIZE;
+        AES_decrypt(in, out, &ctx->dec);
+        in += AES_BLOCK_SIZE;
+        out += AES_BLOCK_SIZE;
         len -= AES_BLOCK_SIZE;
     }
 }
 
-
-static void qcrypto_cipher_aes_xts_encrypt(const void *ctx,
-                                           size_t length,
-                                           uint8_t *dst,
-                                           const uint8_t *src)
-{
-    const QCryptoCipherBuiltinAESContext *aesctx = ctx;
-
-    qcrypto_cipher_aes_ecb_encrypt(&aesctx->enc, src, dst, length);
-}
-
-
-static void qcrypto_cipher_aes_xts_decrypt(const void *ctx,
-                                           size_t length,
-                                           uint8_t *dst,
-                                           const uint8_t *src)
-{
-    const QCryptoCipherBuiltinAESContext *aesctx = ctx;
-
-    qcrypto_cipher_aes_ecb_decrypt(&aesctx->dec, src, dst, length);
-}
-
-
 static int qcrypto_cipher_encrypt_aes(QCryptoCipher *cipher,
                                       const void *in,
                                       void *out,
@@ -142,8 +115,7 @@ static int qcrypto_cipher_encrypt_aes(QCryptoCipher *cipher,
 
     switch (cipher->mode) {
     case QCRYPTO_CIPHER_MODE_ECB:
-        qcrypto_cipher_aes_ecb_encrypt(&ctxt->state.aes.key.enc,
-                                       in, out, len);
+        do_aes_encrypt_ecb(&ctxt->state.aes.key, len, out, in);
         break;
     case QCRYPTO_CIPHER_MODE_CBC:
         AES_cbc_encrypt(in, out, len,
@@ -153,8 +125,8 @@ static int qcrypto_cipher_encrypt_aes(QCryptoCipher *cipher,
     case QCRYPTO_CIPHER_MODE_XTS:
         xts_encrypt(&ctxt->state.aes.key,
                     &ctxt->state.aes.key_tweak,
-                    qcrypto_cipher_aes_xts_encrypt,
-                    qcrypto_cipher_aes_xts_decrypt,
+                    do_aes_encrypt_ecb,
+                    do_aes_decrypt_ecb,
                     ctxt->state.aes.iv,
                     len, out, in);
         break;
@@ -177,8 +149,7 @@ static int qcrypto_cipher_decrypt_aes(QCryptoCipher *cipher,
 
     switch (cipher->mode) {
     case QCRYPTO_CIPHER_MODE_ECB:
-        qcrypto_cipher_aes_ecb_decrypt(&ctxt->state.aes.key.dec,
-                                       in, out, len);
+        do_aes_decrypt_ecb(&ctxt->state.aes.key, len, out, in);
         break;
     case QCRYPTO_CIPHER_MODE_CBC:
         AES_cbc_encrypt(in, out, len,
@@ -188,8 +159,8 @@ static int qcrypto_cipher_decrypt_aes(QCryptoCipher *cipher,
     case QCRYPTO_CIPHER_MODE_XTS:
         xts_decrypt(&ctxt->state.aes.key,
                     &ctxt->state.aes.key_tweak,
-                    qcrypto_cipher_aes_xts_encrypt,
-                    qcrypto_cipher_aes_xts_decrypt,
+                    do_aes_encrypt_ecb,
+                    do_aes_decrypt_ecb,
                     ctxt->state.aes.iv,
                     len, out, in);
         break;
-- 
2.26.2


