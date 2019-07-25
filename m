Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D6CC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 08:44:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5088C2238C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 08:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5088C2238C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqZMK-0006Su-9g
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 04:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49986)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hqZLz-0005Lt-IK
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 04:44:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hqZLy-0008Im-H5
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 04:43:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39356)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hqZLy-0008IY-Bx
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 04:43:58 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B0A0883F3D
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 08:43:57 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 43B031001B32;
 Thu, 25 Jul 2019 08:43:53 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 25 Jul 2019 09:43:40 +0100
Message-Id: <20190725084341.8287-3-berrange@redhat.com>
In-Reply-To: <20190725084341.8287-1-berrange@redhat.com>
References: <20190725084341.8287-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Thu, 25 Jul 2019 08:43:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 2/3] crypto: define cleanup functions for
 use with g_autoptr
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allow crypto structs to be used with g_autoptr, avoiding the need to
explicitly call XXX_free() functions when variables go out of scope on
the stack.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 include/crypto/block.h      | 2 ++
 include/crypto/cipher.h     | 2 ++
 include/crypto/hmac.h       | 2 ++
 include/crypto/ivgen.h      | 2 ++
 include/crypto/tlssession.h | 2 ++
 5 files changed, 10 insertions(+)

diff --git a/include/crypto/block.h b/include/crypto/block.h
index fe12899831..d49d2c2da9 100644
--- a/include/crypto/block.h
+++ b/include/crypto/block.h
@@ -268,4 +268,6 @@ uint64_t qcrypto_block_get_sector_size(QCryptoBlock *=
block);
  */
 void qcrypto_block_free(QCryptoBlock *block);
=20
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(QCryptoBlock, qcrypto_block_free)
+
 #endif /* QCRYPTO_BLOCK_H */
diff --git a/include/crypto/cipher.h b/include/crypto/cipher.h
index cac90b410c..5928e5ecc7 100644
--- a/include/crypto/cipher.h
+++ b/include/crypto/cipher.h
@@ -170,6 +170,8 @@ QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgori=
thm alg,
  */
 void qcrypto_cipher_free(QCryptoCipher *cipher);
=20
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(QCryptoCipher, qcrypto_cipher_free)
+
 /**
  * qcrypto_cipher_encrypt:
  * @cipher: the cipher object
diff --git a/include/crypto/hmac.h b/include/crypto/hmac.h
index aa3c97a2ff..ad4d778416 100644
--- a/include/crypto/hmac.h
+++ b/include/crypto/hmac.h
@@ -65,6 +65,8 @@ QCryptoHmac *qcrypto_hmac_new(QCryptoHashAlgorithm alg,
  */
 void qcrypto_hmac_free(QCryptoHmac *hmac);
=20
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(QCryptoHmac, qcrypto_hmac_free)
+
 /**
  * qcrypto_hmac_bytesv:
  * @hmac: the hmac object
diff --git a/include/crypto/ivgen.h b/include/crypto/ivgen.h
index 9b4a62f7bb..e41521519c 100644
--- a/include/crypto/ivgen.h
+++ b/include/crypto/ivgen.h
@@ -203,4 +203,6 @@ QCryptoHashAlgorithm qcrypto_ivgen_get_hash(QCryptoIV=
Gen *ivgen);
  */
 void qcrypto_ivgen_free(QCryptoIVGen *ivgen);
=20
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(QCryptoIVGen, qcrypto_ivgen_free)
+
 #endif /* QCRYPTO_IVGEN_H */
diff --git a/include/crypto/tlssession.h b/include/crypto/tlssession.h
index 816300cdcc..e01e1a9dc2 100644
--- a/include/crypto/tlssession.h
+++ b/include/crypto/tlssession.h
@@ -160,6 +160,8 @@ QCryptoTLSSession *qcrypto_tls_session_new(QCryptoTLS=
Creds *creds,
  */
 void qcrypto_tls_session_free(QCryptoTLSSession *sess);
=20
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(QCryptoTLSSession, qcrypto_tls_session_fre=
e)
+
 /**
  * qcrypto_tls_session_check_credentials:
  * @sess: the TLS session object
--=20
2.21.0


