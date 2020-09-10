Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE5DC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:10:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E26D20770
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GI4iMYKU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E26D20770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGJXI-0000Dr-KF
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGJTZ-0000QF-BH
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:06:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44663
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGJTX-0007i0-4J
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599732402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JOk10kb0mszjBp1j55p7ooi4MUv5zXNABmQ7poAPUnQ=;
 b=GI4iMYKUIZrSvVA5iO75F17cTkMqT8GDZk0kS8VfEh1TvVH5IWCSPtPpCqBLDJ2MfJP9bW
 tLB7gKRnPp3B3Ikdykv+Vw8AGT0FxirBQ84/s1RFQYLOUsGZsknr97X8u0ZH7Jqk+YN6HW
 kzmZN+XJhyBAs6kexQZr58ys8dDOFS8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-SoqMgi60N1WDPZXCipCFEg-1; Thu, 10 Sep 2020 06:06:39 -0400
X-MC-Unique: SoqMgi60N1WDPZXCipCFEg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 969D11009443;
 Thu, 10 Sep 2020 10:06:38 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-4.ams2.redhat.com
 [10.36.112.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8AB271002D41;
 Thu, 10 Sep 2020 10:06:37 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/17] crypto: Move cipher->driver init to
 qcrypto_*_cipher_ctx_new
Date: Thu, 10 Sep 2020 11:06:15 +0100
Message-Id: <20200910100623.1088965-10-berrange@redhat.com>
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

The class vtable should be set by the class initializer.
This will also allow additional subclassing, reducing the
amount of indirection in the hierarchy.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/cipher-afalg.c       | 5 ++++-
 crypto/cipher-builtin.c.inc | 4 ++++
 crypto/cipher-gcrypt.c.inc  | 2 ++
 crypto/cipher-nettle.c.inc  | 3 +++
 crypto/cipher.c             | 7 -------
 crypto/cipherpriv.h         | 2 --
 6 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/crypto/cipher-afalg.c b/crypto/cipher-afalg.c
index 86e5249bd6..052355a8a9 100644
--- a/crypto/cipher-afalg.c
+++ b/crypto/cipher-afalg.c
@@ -58,6 +58,8 @@ qcrypto_afalg_cipher_format_name(QCryptoCipherAlgorithm alg,
     return name;
 }
 
+static const struct QCryptoCipherDriver qcrypto_cipher_afalg_driver;
+
 QCryptoCipher *
 qcrypto_afalg_cipher_ctx_new(QCryptoCipherAlgorithm alg,
                              QCryptoCipherMode mode,
@@ -109,6 +111,7 @@ qcrypto_afalg_cipher_ctx_new(QCryptoCipherAlgorithm alg,
     }
     afalg->cmsg = CMSG_FIRSTHDR(afalg->msg);
 
+    afalg->base.driver = &qcrypto_cipher_afalg_driver;
     return &afalg->base;
 }
 
@@ -222,7 +225,7 @@ static void qcrypto_afalg_comm_ctx_free(QCryptoCipher *cipher)
     qcrypto_afalg_comm_free(afalg);
 }
 
-const struct QCryptoCipherDriver qcrypto_cipher_afalg_driver = {
+static const struct QCryptoCipherDriver qcrypto_cipher_afalg_driver = {
     .cipher_encrypt = qcrypto_afalg_cipher_encrypt,
     .cipher_decrypt = qcrypto_afalg_cipher_decrypt,
     .cipher_setiv = qcrypto_afalg_cipher_setiv,
diff --git a/crypto/cipher-builtin.c.inc b/crypto/cipher-builtin.c.inc
index 6a03e23040..1444139f36 100644
--- a/crypto/cipher-builtin.c.inc
+++ b/crypto/cipher-builtin.c.inc
@@ -22,6 +22,8 @@
 #include "crypto/desrfb.h"
 #include "crypto/xts.h"
 
+static const struct QCryptoCipherDriver qcrypto_cipher_lib_driver;
+
 typedef struct QCryptoCipherBuiltinAESContext QCryptoCipherBuiltinAESContext;
 struct QCryptoCipherBuiltinAESContext {
     AES_KEY enc;
@@ -292,6 +294,7 @@ qcrypto_cipher_init_aes(QCryptoCipherMode mode,
     ctxt->encrypt = qcrypto_cipher_encrypt_aes;
     ctxt->decrypt = qcrypto_cipher_decrypt_aes;
 
+    ctxt->base.driver = &qcrypto_cipher_lib_driver;
     return &ctxt->base;
 
  error:
@@ -396,6 +399,7 @@ qcrypto_cipher_init_des_rfb(QCryptoCipherMode mode,
     ctxt->encrypt = qcrypto_cipher_encrypt_des_rfb;
     ctxt->decrypt = qcrypto_cipher_decrypt_des_rfb;
 
+    ctxt->base.driver = &qcrypto_cipher_lib_driver;
     return &ctxt->base;
 }
 
diff --git a/crypto/cipher-gcrypt.c.inc b/crypto/cipher-gcrypt.c.inc
index 3b3c85e265..7a1fbc9745 100644
--- a/crypto/cipher-gcrypt.c.inc
+++ b/crypto/cipher-gcrypt.c.inc
@@ -24,6 +24,7 @@
 
 #include <gcrypt.h>
 
+static const struct QCryptoCipherDriver qcrypto_cipher_lib_driver;
 
 bool qcrypto_cipher_supports(QCryptoCipherAlgorithm alg,
                              QCryptoCipherMode mode)
@@ -258,6 +259,7 @@ static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
     }
 #endif
 
+    ctx->base.driver = &qcrypto_cipher_lib_driver;
     return &ctx->base;
 
  error:
diff --git a/crypto/cipher-nettle.c.inc b/crypto/cipher-nettle.c.inc
index d8371d1f37..36d57ef430 100644
--- a/crypto/cipher-nettle.c.inc
+++ b/crypto/cipher-nettle.c.inc
@@ -34,6 +34,8 @@
 #include <nettle/xts.h>
 #endif
 
+static const struct QCryptoCipherDriver qcrypto_cipher_lib_driver;
+
 typedef void (*QCryptoCipherNettleFuncWrapper)(const void *ctx,
                                                size_t length,
                                                uint8_t *dst,
@@ -587,6 +589,7 @@ static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
 
     ctx->iv = g_new0(uint8_t, ctx->blocksize);
 
+    ctx->base.driver = &qcrypto_cipher_lib_driver;
     return &ctx->base;
 
  error:
diff --git a/crypto/cipher.c b/crypto/cipher.c
index 737fc0735d..3711b552fa 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -164,13 +164,9 @@ QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
                                   Error **errp)
 {
     QCryptoCipher *cipher = NULL;
-    const QCryptoCipherDriver *drv = NULL;
 
 #ifdef CONFIG_AF_ALG
     cipher = qcrypto_afalg_cipher_ctx_new(alg, mode, key, nkey, NULL);
-    if (cipher) {
-        drv = &qcrypto_cipher_afalg_driver;
-    }
 #endif
 
     if (!cipher) {
@@ -178,13 +174,10 @@ QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
         if (!cipher) {
             return NULL;
         }
-
-        drv = &qcrypto_cipher_lib_driver;
     }
 
     cipher->alg = alg;
     cipher->mode = mode;
-    cipher->driver = drv;
 
     return cipher;
 }
diff --git a/crypto/cipherpriv.h b/crypto/cipherpriv.h
index 437b109b5e..396527857d 100644
--- a/crypto/cipherpriv.h
+++ b/crypto/cipherpriv.h
@@ -47,8 +47,6 @@ qcrypto_afalg_cipher_ctx_new(QCryptoCipherAlgorithm alg,
                              const uint8_t *key,
                              size_t nkey, Error **errp);
 
-extern const struct QCryptoCipherDriver qcrypto_cipher_afalg_driver;
-
 #endif
 
 #endif
-- 
2.26.2


