Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6621C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:07:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CFE52145D
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VtICTKqa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CFE52145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGJUO-0001lw-8m
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:07:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGJTO-0008Vk-EB
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:06:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56689)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGJTM-0007fy-Ki
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599732391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WL9HiUwIz+WYhnrnfM+ZjFXjjET46LmVvkoQ4mSa12Q=;
 b=VtICTKqaDuY/eon8K2zUInVeNItabvIu6qZmvSUMyhtUO4yRxh3n/AUayOcL9LSJB0dUVD
 x87r1X7V3DHc2PQXqWfW2SM9XaX6C3XZ4mUqKkaGDVH2fVE6Y4n3qyxMdgLcsUw4JLoW+e
 Pd3g3xGB74I6VbD2Am4wt7Vrwod1xDU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-DhBfS2Y-MfiQ00-9ZYS6KQ-1; Thu, 10 Sep 2020 06:06:29 -0400
X-MC-Unique: DhBfS2Y-MfiQ00-9ZYS6KQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CB5E1009441;
 Thu, 10 Sep 2020 10:06:28 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-4.ams2.redhat.com
 [10.36.112.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F34D01002D41;
 Thu, 10 Sep 2020 10:06:26 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/17] crypto: Assume blocksize is a power of 2
Date: Thu, 10 Sep 2020 11:06:08 +0100
Message-Id: <20200910100623.1088965-3-berrange@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 00:49:43
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

The check in the encode/decode path using full division has a
noticeable amount of overhead.  By asserting the blocksize is
a power of 2, we can reduce this check to a mask.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/cipher-builtin.c | 4 ++--
 crypto/cipher-gcrypt.c  | 5 +++--
 crypto/cipher-nettle.c  | 5 +++--
 crypto/cipher.c         | 1 +
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/crypto/cipher-builtin.c b/crypto/cipher-builtin.c
index 35cf7820d9..6eafd39da0 100644
--- a/crypto/cipher-builtin.c
+++ b/crypto/cipher-builtin.c
@@ -484,7 +484,7 @@ qcrypto_builtin_cipher_encrypt(QCryptoCipher *cipher,
 {
     QCryptoCipherBuiltin *ctxt = cipher->opaque;
 
-    if (len % ctxt->blocksize) {
+    if (len & (ctxt->blocksize - 1)) {
         error_setg(errp, "Length %zu must be a multiple of block size %zu",
                    len, ctxt->blocksize);
         return -1;
@@ -503,7 +503,7 @@ qcrypto_builtin_cipher_decrypt(QCryptoCipher *cipher,
 {
     QCryptoCipherBuiltin *ctxt = cipher->opaque;
 
-    if (len % ctxt->blocksize) {
+    if (len & (ctxt->blocksize - 1)) {
         error_setg(errp, "Length %zu must be a multiple of block size %zu",
                    len, ctxt->blocksize);
         return -1;
diff --git a/crypto/cipher-gcrypt.c b/crypto/cipher-gcrypt.c
index 2864099527..81e4745bff 100644
--- a/crypto/cipher-gcrypt.c
+++ b/crypto/cipher-gcrypt.c
@@ -245,6 +245,7 @@ static QCryptoCipherGcrypt *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
             g_assert_not_reached();
         }
     }
+    g_assert(is_power_of_2(ctx->blocksize));
 
 #ifdef CONFIG_QEMU_PRIVATE_XTS
     if (mode == QCRYPTO_CIPHER_MODE_XTS) {
@@ -305,7 +306,7 @@ qcrypto_gcrypt_cipher_encrypt(QCryptoCipher *cipher,
     QCryptoCipherGcrypt *ctx = cipher->opaque;
     gcry_error_t err;
 
-    if (len % ctx->blocksize) {
+    if (len & (ctx->blocksize - 1)) {
         error_setg(errp, "Length %zu must be a multiple of block size %zu",
                    len, ctx->blocksize);
         return -1;
@@ -344,7 +345,7 @@ qcrypto_gcrypt_cipher_decrypt(QCryptoCipher *cipher,
     QCryptoCipherGcrypt *ctx = cipher->opaque;
     gcry_error_t err;
 
-    if (len % ctx->blocksize) {
+    if (len & (ctx->blocksize - 1)) {
         error_setg(errp, "Length %zu must be a multiple of block size %zu",
                    len, ctx->blocksize);
         return -1;
diff --git a/crypto/cipher-nettle.c b/crypto/cipher-nettle.c
index 7e9a4cc199..0677fdfd33 100644
--- a/crypto/cipher-nettle.c
+++ b/crypto/cipher-nettle.c
@@ -576,6 +576,7 @@ static QCryptoCipherNettle *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
                    QCryptoCipherAlgorithm_str(alg));
         goto error;
     }
+    g_assert(is_power_of_2(ctx->blocksize));
 
     if (mode == QCRYPTO_CIPHER_MODE_XTS &&
         ctx->blocksize != XTS_BLOCK_SIZE) {
@@ -613,7 +614,7 @@ qcrypto_nettle_cipher_encrypt(QCryptoCipher *cipher,
 {
     QCryptoCipherNettle *ctx = cipher->opaque;
 
-    if (len % ctx->blocksize) {
+    if (len & (ctx->blocksize - 1)) {
         error_setg(errp, "Length %zu must be a multiple of block size %zu",
                    len, ctx->blocksize);
         return -1;
@@ -666,7 +667,7 @@ qcrypto_nettle_cipher_decrypt(QCryptoCipher *cipher,
 {
     QCryptoCipherNettle *ctx = cipher->opaque;
 
-    if (len % ctx->blocksize) {
+    if (len & (ctx->blocksize - 1)) {
         error_setg(errp, "Length %zu must be a multiple of block size %zu",
                    len, ctx->blocksize);
         return -1;
diff --git a/crypto/cipher.c b/crypto/cipher.c
index e5adb56271..2722dc7d87 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/host-utils.h"
 #include "qapi/error.h"
 #include "crypto/cipher.h"
 #include "cipherpriv.h"
-- 
2.26.2


