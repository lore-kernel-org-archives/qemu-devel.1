Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0623C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:15:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B7BF21556
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XXaeao1s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B7BF21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGJbj-0008Ka-Gs
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGJTg-0000YJ-DZ
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:06:52 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25962
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGJTe-0007jB-D3
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599732409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A2f9SYRD21RntK1btIFerAtriqCpg0ZbaBGhCatpAE8=;
 b=XXaeao1st3EqOXatkE5+9OjVuLD1rhb2UEsOaPViQyZ8HEYytOUNqLMljbAQk7AOdu0eIS
 v1jOL28ScOvK7DJcXjbWPorZsnz9PoRHqKMLwx/Fu8q+pUbbX6XyH1/6TnzmGuvVaWICuK
 NebDDDTW0P4LZl/g8BKRzjcubQ0M83U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-dKfCdj3fOdWSqvA7Zy6txA-1; Thu, 10 Sep 2020 06:06:47 -0400
X-MC-Unique: dKfCdj3fOdWSqvA7Zy6txA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C91F64082;
 Thu, 10 Sep 2020 10:06:46 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-4.ams2.redhat.com
 [10.36.112.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1CD6D1002D41;
 Thu, 10 Sep 2020 10:06:44 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/17] crypto/builtin: Split and simplify AES_encrypt_cbc
Date: Thu, 10 Sep 2020 11:06:20 +0100
Message-Id: <20200910100623.1088965-15-berrange@redhat.com>
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

Split into encrypt/decrypt functions, dropping the "enc" argument.
Now that the function is private to this file, we know that "len"
is a multiple of AES_BLOCK_SIZE.  So drop the odd block size code.

Name the functions do_aes_*crypt_cbc to match the *_ecb functions.
Reorder and re-type the arguments to match as well.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/cipher-builtin.c.inc | 99 ++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 56 deletions(-)

diff --git a/crypto/cipher-builtin.c.inc b/crypto/cipher-builtin.c.inc
index 61baad265a..b1fe3b08c3 100644
--- a/crypto/cipher-builtin.c.inc
+++ b/crypto/cipher-builtin.c.inc
@@ -104,61 +104,50 @@ static void do_aes_decrypt_ecb(const void *vctx,
     }
 }
 
-static void AES_cbc_encrypt(const unsigned char *in, unsigned char *out,
-                            const unsigned long length, const AES_KEY *key,
-                            unsigned char *ivec, const int enc)
+static void do_aes_encrypt_cbc(const AES_KEY *key,
+                               size_t len,
+                               uint8_t *out,
+                               const uint8_t *in,
+                               uint8_t *ivec)
 {
-    unsigned long n;
-    unsigned long len = length;
-    unsigned char tmp[AES_BLOCK_SIZE];
-
-    assert(in && out && key && ivec);
-
-    if (enc) {
-        while (len >= AES_BLOCK_SIZE) {
-            for (n = 0; n < AES_BLOCK_SIZE; ++n) {
-                tmp[n] = in[n] ^ ivec[n];
-            }
-            AES_encrypt(tmp, out, key);
-            memcpy(ivec, out, AES_BLOCK_SIZE);
-            len -= AES_BLOCK_SIZE;
-            in += AES_BLOCK_SIZE;
-            out += AES_BLOCK_SIZE;
-        }
-        if (len) {
-            for (n = 0; n < len; ++n) {
-                tmp[n] = in[n] ^ ivec[n];
-            }
-            for (n = len; n < AES_BLOCK_SIZE; ++n) {
-                tmp[n] = ivec[n];
-            }
-            AES_encrypt(tmp, tmp, key);
-            memcpy(out, tmp, AES_BLOCK_SIZE);
-            memcpy(ivec, tmp, AES_BLOCK_SIZE);
-        }
-    } else {
-        while (len >= AES_BLOCK_SIZE) {
-            memcpy(tmp, in, AES_BLOCK_SIZE);
-            AES_decrypt(in, out, key);
-            for (n = 0; n < AES_BLOCK_SIZE; ++n) {
-                out[n] ^= ivec[n];
-            }
-            memcpy(ivec, tmp, AES_BLOCK_SIZE);
-            len -= AES_BLOCK_SIZE;
-            in += AES_BLOCK_SIZE;
-            out += AES_BLOCK_SIZE;
-        }
-        if (len) {
-            memcpy(tmp, in, AES_BLOCK_SIZE);
-            AES_decrypt(tmp, tmp, key);
-            for (n = 0; n < len; ++n) {
-                out[n] = tmp[n] ^ ivec[n];
-            }
-            memcpy(ivec, tmp, AES_BLOCK_SIZE);
+    uint8_t tmp[AES_BLOCK_SIZE];
+    size_t n;
+
+    /* We have already verified that len % AES_BLOCK_SIZE == 0. */
+    while (len) {
+        for (n = 0; n < AES_BLOCK_SIZE; ++n) {
+            tmp[n] = in[n] ^ ivec[n];
         }
+        AES_encrypt(tmp, out, key);
+        memcpy(ivec, out, AES_BLOCK_SIZE);
+        len -= AES_BLOCK_SIZE;
+        in += AES_BLOCK_SIZE;
+        out += AES_BLOCK_SIZE;
     }
 }
 
+static void do_aes_decrypt_cbc(const AES_KEY *key,
+                               size_t len,
+                               uint8_t *out,
+                               const uint8_t *in,
+                               uint8_t *ivec)
+{
+    uint8_t tmp[AES_BLOCK_SIZE];
+    size_t n;
+
+    /* We have already verified that len % AES_BLOCK_SIZE == 0. */
+    while (len) {
+        memcpy(tmp, in, AES_BLOCK_SIZE);
+        AES_decrypt(in, out, key);
+        for (n = 0; n < AES_BLOCK_SIZE; ++n) {
+            out[n] ^= ivec[n];
+        }
+        memcpy(ivec, tmp, AES_BLOCK_SIZE);
+        len -= AES_BLOCK_SIZE;
+        in += AES_BLOCK_SIZE;
+        out += AES_BLOCK_SIZE;
+    }
+}
 
 static int qcrypto_cipher_encrypt_aes(QCryptoCipher *cipher,
                                       const void *in,
@@ -174,9 +163,8 @@ static int qcrypto_cipher_encrypt_aes(QCryptoCipher *cipher,
         do_aes_encrypt_ecb(&ctxt->state.aes.key, len, out, in);
         break;
     case QCRYPTO_CIPHER_MODE_CBC:
-        AES_cbc_encrypt(in, out, len,
-                        &ctxt->state.aes.key.enc,
-                        ctxt->state.aes.iv, 1);
+        do_aes_encrypt_cbc(&ctxt->state.aes.key.enc, len, out, in,
+                           ctxt->state.aes.iv);
         break;
     case QCRYPTO_CIPHER_MODE_XTS:
         xts_encrypt(&ctxt->state.aes.key,
@@ -208,9 +196,8 @@ static int qcrypto_cipher_decrypt_aes(QCryptoCipher *cipher,
         do_aes_decrypt_ecb(&ctxt->state.aes.key, len, out, in);
         break;
     case QCRYPTO_CIPHER_MODE_CBC:
-        AES_cbc_encrypt(in, out, len,
-                        &ctxt->state.aes.key.dec,
-                        ctxt->state.aes.iv, 0);
+        do_aes_decrypt_cbc(&ctxt->state.aes.key.dec, len, out, in,
+                           ctxt->state.aes.iv);
         break;
     case QCRYPTO_CIPHER_MODE_XTS:
         xts_decrypt(&ctxt->state.aes.key,
-- 
2.26.2


