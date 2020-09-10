Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D18C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:11:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8756120BED
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XwQUWpzH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8756120BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGJXz-0001R9-H8
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGJTW-0000MO-Gp
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:06:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53924)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGJTT-0007hY-Vb
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599732398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EgC3toX5BHn1BmzSD7aTNv/qJ03wUJgQwo/wZpP42u0=;
 b=XwQUWpzHFEWyGzRoI1UMiuWJeGeZlPS56C+LFnAleSCtvQ+ztA2zt36WGJZrh+rBkA/Teq
 gz85tMO+u+P8ApF5jUHDjnAKnAjXTkGbz6M3gUZxatzv++w2z9KQC0mCZOxCKRA7cKpxIA
 tlMj+NLRFmCqUJqlSmkL0ZBToV0Og6c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-Ga2o15xON8yjSxx9ZmfHTQ-1; Thu, 10 Sep 2020 06:06:36 -0400
X-MC-Unique: Ga2o15xON8yjSxx9ZmfHTQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EF9D802B6B;
 Thu, 10 Sep 2020 10:06:35 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-4.ams2.redhat.com
 [10.36.112.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C12D41002D41;
 Thu, 10 Sep 2020 10:06:34 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/17] crypto: Use the correct const type for driver
Date: Thu, 10 Sep 2020 11:06:13 +0100
Message-Id: <20200910100623.1088965-8-berrange@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 02:38:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This allows the in memory structures to be read-only.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/cipher-afalg.c       |  2 +-
 crypto/cipher-builtin.c.inc |  2 +-
 crypto/cipher-gcrypt.c.inc  |  2 +-
 crypto/cipher-nettle.c.inc  |  2 +-
 crypto/cipher.c             | 12 ++++++------
 crypto/cipherpriv.h         |  2 +-
 include/crypto/cipher.h     |  2 +-
 7 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/crypto/cipher-afalg.c b/crypto/cipher-afalg.c
index cd72284690..5c7c44761b 100644
--- a/crypto/cipher-afalg.c
+++ b/crypto/cipher-afalg.c
@@ -218,7 +218,7 @@ static void qcrypto_afalg_comm_ctx_free(QCryptoCipher *cipher)
     qcrypto_afalg_comm_free(cipher->opaque);
 }
 
-struct QCryptoCipherDriver qcrypto_cipher_afalg_driver = {
+const struct QCryptoCipherDriver qcrypto_cipher_afalg_driver = {
     .cipher_encrypt = qcrypto_afalg_cipher_encrypt,
     .cipher_decrypt = qcrypto_afalg_cipher_decrypt,
     .cipher_setiv = qcrypto_afalg_cipher_setiv,
diff --git a/crypto/cipher-builtin.c.inc b/crypto/cipher-builtin.c.inc
index 56d45b0227..156f32f1c7 100644
--- a/crypto/cipher-builtin.c.inc
+++ b/crypto/cipher-builtin.c.inc
@@ -522,7 +522,7 @@ qcrypto_builtin_cipher_setiv(QCryptoCipher *cipher,
 }
 
 
-static struct QCryptoCipherDriver qcrypto_cipher_lib_driver = {
+static const struct QCryptoCipherDriver qcrypto_cipher_lib_driver = {
     .cipher_encrypt = qcrypto_builtin_cipher_encrypt,
     .cipher_decrypt = qcrypto_builtin_cipher_decrypt,
     .cipher_setiv = qcrypto_builtin_cipher_setiv,
diff --git a/crypto/cipher-gcrypt.c.inc b/crypto/cipher-gcrypt.c.inc
index a62839914b..18850fadb9 100644
--- a/crypto/cipher-gcrypt.c.inc
+++ b/crypto/cipher-gcrypt.c.inc
@@ -413,7 +413,7 @@ qcrypto_gcrypt_cipher_setiv(QCryptoCipher *cipher,
 }
 
 
-static struct QCryptoCipherDriver qcrypto_cipher_lib_driver = {
+static const struct QCryptoCipherDriver qcrypto_cipher_lib_driver = {
     .cipher_encrypt = qcrypto_gcrypt_cipher_encrypt,
     .cipher_decrypt = qcrypto_gcrypt_cipher_decrypt,
     .cipher_setiv = qcrypto_gcrypt_cipher_setiv,
diff --git a/crypto/cipher-nettle.c.inc b/crypto/cipher-nettle.c.inc
index 0404cfc6da..6ecce5e8ea 100644
--- a/crypto/cipher-nettle.c.inc
+++ b/crypto/cipher-nettle.c.inc
@@ -724,7 +724,7 @@ qcrypto_nettle_cipher_setiv(QCryptoCipher *cipher,
 }
 
 
-static struct QCryptoCipherDriver qcrypto_cipher_lib_driver = {
+static const struct QCryptoCipherDriver qcrypto_cipher_lib_driver = {
     .cipher_encrypt = qcrypto_nettle_cipher_encrypt,
     .cipher_decrypt = qcrypto_nettle_cipher_decrypt,
     .cipher_setiv = qcrypto_nettle_cipher_setiv,
diff --git a/crypto/cipher.c b/crypto/cipher.c
index 005b5da4de..3ca4a7e662 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -165,7 +165,7 @@ QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
 {
     QCryptoCipher *cipher;
     void *ctx = NULL;
-    QCryptoCipherDriver *drv = NULL;
+    const QCryptoCipherDriver *drv = NULL;
 
 #ifdef CONFIG_AF_ALG
     ctx = qcrypto_afalg_cipher_ctx_new(alg, mode, key, nkey, NULL);
@@ -187,7 +187,7 @@ QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
     cipher->alg = alg;
     cipher->mode = mode;
     cipher->opaque = ctx;
-    cipher->driver = (void *)drv;
+    cipher->driver = drv;
 
     return cipher;
 }
@@ -199,7 +199,7 @@ int qcrypto_cipher_encrypt(QCryptoCipher *cipher,
                            size_t len,
                            Error **errp)
 {
-    QCryptoCipherDriver *drv = cipher->driver;
+    const QCryptoCipherDriver *drv = cipher->driver;
     return drv->cipher_encrypt(cipher, in, out, len, errp);
 }
 
@@ -210,7 +210,7 @@ int qcrypto_cipher_decrypt(QCryptoCipher *cipher,
                            size_t len,
                            Error **errp)
 {
-    QCryptoCipherDriver *drv = cipher->driver;
+    const QCryptoCipherDriver *drv = cipher->driver;
     return drv->cipher_decrypt(cipher, in, out, len, errp);
 }
 
@@ -219,14 +219,14 @@ int qcrypto_cipher_setiv(QCryptoCipher *cipher,
                          const uint8_t *iv, size_t niv,
                          Error **errp)
 {
-    QCryptoCipherDriver *drv = cipher->driver;
+    const QCryptoCipherDriver *drv = cipher->driver;
     return drv->cipher_setiv(cipher, iv, niv, errp);
 }
 
 
 void qcrypto_cipher_free(QCryptoCipher *cipher)
 {
-    QCryptoCipherDriver *drv;
+    const QCryptoCipherDriver *drv;
     if (cipher) {
         drv = cipher->driver;
         drv->cipher_free(cipher);
diff --git a/crypto/cipherpriv.h b/crypto/cipherpriv.h
index 9228c9fc3a..b73be33bd2 100644
--- a/crypto/cipherpriv.h
+++ b/crypto/cipherpriv.h
@@ -47,7 +47,7 @@ qcrypto_afalg_cipher_ctx_new(QCryptoCipherAlgorithm alg,
                              const uint8_t *key,
                              size_t nkey, Error **errp);
 
-extern struct QCryptoCipherDriver qcrypto_cipher_afalg_driver;
+extern const struct QCryptoCipherDriver qcrypto_cipher_afalg_driver;
 
 #endif
 
diff --git a/include/crypto/cipher.h b/include/crypto/cipher.h
index 8a42a683a4..cc57179a4d 100644
--- a/include/crypto/cipher.h
+++ b/include/crypto/cipher.h
@@ -81,7 +81,7 @@ struct QCryptoCipher {
     QCryptoCipherAlgorithm alg;
     QCryptoCipherMode mode;
     void *opaque;
-    void *driver;
+    const QCryptoCipherDriver *driver;
 };
 
 /**
-- 
2.26.2


