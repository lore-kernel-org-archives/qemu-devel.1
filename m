Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBC6C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:14:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B77EA20BED
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fd4wcEAS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B77EA20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGJaY-0006KM-Pt
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGJTf-0000Wi-PZ
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:06:51 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21140
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGJTd-0007j0-5L
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599732408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z5kz+dl4NiZGR3DyQwvuH4nV2SaU5K6TRvwu9idGUNw=;
 b=fd4wcEASKQ4MI22OK3oNTIrEHi2rsLYOmcOMAEA5iQZWHlr+MVRZcNsLw7hrDefttw9YfY
 qsDQpkeXeYUKyxFwsjiXmr+aJ8nMvxJXyvIwPJvPqjs8FeVuhl3ACCm6vrfi92B3gV6xNZ
 cjRwEQeIKQdUK5e2N4ddCtZBLNTjl7w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-icB0_c8eMwesHJwalp4Ajg-1; Thu, 10 Sep 2020 06:06:45 -0400
X-MC-Unique: icB0_c8eMwesHJwalp4Ajg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C96E6801AB8;
 Thu, 10 Sep 2020 10:06:44 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-4.ams2.redhat.com
 [10.36.112.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7BC1F1002D5C;
 Thu, 10 Sep 2020 10:06:43 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/17] crypto/builtin: Move AES_cbc_encrypt into
 cipher-builtin.inc.c
Date: Thu, 10 Sep 2020 11:06:19 +0100
Message-Id: <20200910100623.1088965-14-berrange@redhat.com>
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
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

By making the function private, we will be able to make further
simplifications.  Re-indent the migrated code and fix the missing
braces for CODING_STYLE.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/aes.c                | 51 ---------------------------------
 crypto/cipher-builtin.c.inc | 56 +++++++++++++++++++++++++++++++++++++
 include/crypto/aes.h        |  4 ---
 3 files changed, 56 insertions(+), 55 deletions(-)

diff --git a/crypto/aes.c b/crypto/aes.c
index 0f6a195af8..159800df65 100644
--- a/crypto/aes.c
+++ b/crypto/aes.c
@@ -1599,54 +1599,3 @@ void AES_decrypt(const unsigned char *in, unsigned char *out,
 }
 
 #endif /* AES_ASM */
-
-void AES_cbc_encrypt(const unsigned char *in, unsigned char *out,
-                     const unsigned long length, const AES_KEY *key,
-                     unsigned char *ivec, const int enc)
-{
-
-        unsigned long n;
-        unsigned long len = length;
-        unsigned char tmp[AES_BLOCK_SIZE];
-
-        assert(in && out && key && ivec);
-
-        if (enc) {
-                while (len >= AES_BLOCK_SIZE) {
-                        for(n=0; n < AES_BLOCK_SIZE; ++n)
-                                tmp[n] = in[n] ^ ivec[n];
-                        AES_encrypt(tmp, out, key);
-                        memcpy(ivec, out, AES_BLOCK_SIZE);
-                        len -= AES_BLOCK_SIZE;
-                        in += AES_BLOCK_SIZE;
-                        out += AES_BLOCK_SIZE;
-                }
-                if (len) {
-                        for(n=0; n < len; ++n)
-                                tmp[n] = in[n] ^ ivec[n];
-                        for(n=len; n < AES_BLOCK_SIZE; ++n)
-                                tmp[n] = ivec[n];
-                        AES_encrypt(tmp, tmp, key);
-                        memcpy(out, tmp, AES_BLOCK_SIZE);
-                        memcpy(ivec, tmp, AES_BLOCK_SIZE);
-                }
-        } else {
-                while (len >= AES_BLOCK_SIZE) {
-                        memcpy(tmp, in, AES_BLOCK_SIZE);
-                        AES_decrypt(in, out, key);
-                        for(n=0; n < AES_BLOCK_SIZE; ++n)
-                                out[n] ^= ivec[n];
-                        memcpy(ivec, tmp, AES_BLOCK_SIZE);
-                        len -= AES_BLOCK_SIZE;
-                        in += AES_BLOCK_SIZE;
-                        out += AES_BLOCK_SIZE;
-                }
-                if (len) {
-                        memcpy(tmp, in, AES_BLOCK_SIZE);
-                        AES_decrypt(tmp, tmp, key);
-                        for(n=0; n < len; ++n)
-                                out[n] = tmp[n] ^ ivec[n];
-                        memcpy(ivec, tmp, AES_BLOCK_SIZE);
-                }
-        }
-}
diff --git a/crypto/cipher-builtin.c.inc b/crypto/cipher-builtin.c.inc
index 8e21f2673f..61baad265a 100644
--- a/crypto/cipher-builtin.c.inc
+++ b/crypto/cipher-builtin.c.inc
@@ -104,6 +104,62 @@ static void do_aes_decrypt_ecb(const void *vctx,
     }
 }
 
+static void AES_cbc_encrypt(const unsigned char *in, unsigned char *out,
+                            const unsigned long length, const AES_KEY *key,
+                            unsigned char *ivec, const int enc)
+{
+    unsigned long n;
+    unsigned long len = length;
+    unsigned char tmp[AES_BLOCK_SIZE];
+
+    assert(in && out && key && ivec);
+
+    if (enc) {
+        while (len >= AES_BLOCK_SIZE) {
+            for (n = 0; n < AES_BLOCK_SIZE; ++n) {
+                tmp[n] = in[n] ^ ivec[n];
+            }
+            AES_encrypt(tmp, out, key);
+            memcpy(ivec, out, AES_BLOCK_SIZE);
+            len -= AES_BLOCK_SIZE;
+            in += AES_BLOCK_SIZE;
+            out += AES_BLOCK_SIZE;
+        }
+        if (len) {
+            for (n = 0; n < len; ++n) {
+                tmp[n] = in[n] ^ ivec[n];
+            }
+            for (n = len; n < AES_BLOCK_SIZE; ++n) {
+                tmp[n] = ivec[n];
+            }
+            AES_encrypt(tmp, tmp, key);
+            memcpy(out, tmp, AES_BLOCK_SIZE);
+            memcpy(ivec, tmp, AES_BLOCK_SIZE);
+        }
+    } else {
+        while (len >= AES_BLOCK_SIZE) {
+            memcpy(tmp, in, AES_BLOCK_SIZE);
+            AES_decrypt(in, out, key);
+            for (n = 0; n < AES_BLOCK_SIZE; ++n) {
+                out[n] ^= ivec[n];
+            }
+            memcpy(ivec, tmp, AES_BLOCK_SIZE);
+            len -= AES_BLOCK_SIZE;
+            in += AES_BLOCK_SIZE;
+            out += AES_BLOCK_SIZE;
+        }
+        if (len) {
+            memcpy(tmp, in, AES_BLOCK_SIZE);
+            AES_decrypt(tmp, tmp, key);
+            for (n = 0; n < len; ++n) {
+                out[n] = tmp[n] ^ ivec[n];
+            }
+            memcpy(ivec, tmp, AES_BLOCK_SIZE);
+        }
+    }
+}
+
+
 static int qcrypto_cipher_encrypt_aes(QCryptoCipher *cipher,
                                       const void *in,
                                       void *out,
diff --git a/include/crypto/aes.h b/include/crypto/aes.h
index 12fb321b89..ba297d6a73 100644
--- a/include/crypto/aes.h
+++ b/include/crypto/aes.h
@@ -16,7 +16,6 @@ typedef struct aes_key_st AES_KEY;
 #define AES_set_decrypt_key QEMU_AES_set_decrypt_key
 #define AES_encrypt QEMU_AES_encrypt
 #define AES_decrypt QEMU_AES_decrypt
-#define AES_cbc_encrypt QEMU_AES_cbc_encrypt
 
 int AES_set_encrypt_key(const unsigned char *userKey, const int bits,
 	AES_KEY *key);
@@ -27,9 +26,6 @@ void AES_encrypt(const unsigned char *in, unsigned char *out,
 	const AES_KEY *key);
 void AES_decrypt(const unsigned char *in, unsigned char *out,
 	const AES_KEY *key);
-void AES_cbc_encrypt(const unsigned char *in, unsigned char *out,
-		     const unsigned long length, const AES_KEY *key,
-		     unsigned char *ivec, const int enc);
 
 extern const uint8_t AES_sbox[256];
 extern const uint8_t AES_isbox[256];
-- 
2.26.2


