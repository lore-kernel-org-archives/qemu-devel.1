Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03075C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:13:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53A4720BED
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QI0w8kCO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A4720BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGJZu-0004xv-8o
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGJTb-0000Sh-Me
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:06:47 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32364
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGJTZ-0007iL-8M
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599732404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yq0dLty2zOPZXtWacMEsSs09G1z6ITTkf3f7aeY0XKI=;
 b=QI0w8kCOsoqTFJrh7Rwx0Y2xGs+eR/vQb6LrBgRMgyyZO+EROS7a3V61hcXVnFT/L074ym
 26weHqh6yKFH7nJc9j4JpyEU/BNf6J5mwhuMiCrGrNLHHxxcBFCS4RqAqOrQOIHu/azhF2
 Ba0890On0WE+obe4Zfdmig6C3IZEntA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-grfCSkOxNSeMiHmFzGDQmA-1; Thu, 10 Sep 2020 06:06:42 -0400
X-MC-Unique: grfCSkOxNSeMiHmFzGDQmA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A380B1009443;
 Thu, 10 Sep 2020 10:06:41 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-4.ams2.redhat.com
 [10.36.112.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9BEE91002D41;
 Thu, 10 Sep 2020 10:06:40 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/17] crypto/builtin: Remove odd-sized AES block handling
Date: Thu, 10 Sep 2020 11:06:17 +0100
Message-Id: <20200910100623.1088965-12-berrange@redhat.com>
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

We verified that the data block is properly sized modulo
AES_BLOCK_SIZE within qcrypto_builtin_cipher_{en,de}crypt.
Therefore we will never have to handle odd sized blocks.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/cipher-builtin.c.inc | 40 +++++++++++--------------------------
 1 file changed, 12 insertions(+), 28 deletions(-)

diff --git a/crypto/cipher-builtin.c.inc b/crypto/cipher-builtin.c.inc
index 1444139f36..e2ae5d090c 100644
--- a/crypto/cipher-builtin.c.inc
+++ b/crypto/cipher-builtin.c.inc
@@ -80,21 +80,13 @@ static void qcrypto_cipher_aes_ecb_encrypt(const AES_KEY *key,
 {
     const uint8_t *inptr = in;
     uint8_t *outptr = out;
+
+    /* We have already verified that len % AES_BLOCK_SIZE == 0. */
     while (len) {
-        if (len > AES_BLOCK_SIZE) {
-            AES_encrypt(inptr, outptr, key);
-            inptr += AES_BLOCK_SIZE;
-            outptr += AES_BLOCK_SIZE;
-            len -= AES_BLOCK_SIZE;
-        } else {
-            uint8_t tmp1[AES_BLOCK_SIZE], tmp2[AES_BLOCK_SIZE];
-            memcpy(tmp1, inptr, len);
-            /* Fill with 0 to avoid valgrind uninitialized reads */
-            memset(tmp1 + len, 0, sizeof(tmp1) - len);
-            AES_encrypt(tmp1, tmp2, key);
-            memcpy(outptr, tmp2, len);
-            len = 0;
-        }
+        AES_encrypt(inptr, outptr, key);
+        inptr += AES_BLOCK_SIZE;
+        outptr += AES_BLOCK_SIZE;
+        len -= AES_BLOCK_SIZE;
     }
 }
 
@@ -106,21 +98,13 @@ static void qcrypto_cipher_aes_ecb_decrypt(const AES_KEY *key,
 {
     const uint8_t *inptr = in;
     uint8_t *outptr = out;
+
+    /* We have already verified that len % AES_BLOCK_SIZE == 0. */
     while (len) {
-        if (len > AES_BLOCK_SIZE) {
-            AES_decrypt(inptr, outptr, key);
-            inptr += AES_BLOCK_SIZE;
-            outptr += AES_BLOCK_SIZE;
-            len -= AES_BLOCK_SIZE;
-        } else {
-            uint8_t tmp1[AES_BLOCK_SIZE], tmp2[AES_BLOCK_SIZE];
-            memcpy(tmp1, inptr, len);
-            /* Fill with 0 to avoid valgrind uninitialized reads */
-            memset(tmp1 + len, 0, sizeof(tmp1) - len);
-            AES_decrypt(tmp1, tmp2, key);
-            memcpy(outptr, tmp2, len);
-            len = 0;
-        }
+        AES_decrypt(inptr, outptr, key);
+        inptr += AES_BLOCK_SIZE;
+        outptr += AES_BLOCK_SIZE;
+        len -= AES_BLOCK_SIZE;
     }
 }
 
-- 
2.26.2


