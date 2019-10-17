Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34AADFA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:45:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B30821835
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:45:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B30821835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL7yH-0006Wm-Oh
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 11:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52064)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iL7D3-000540-3Y
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:57:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iL7D1-000377-R4
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:57:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11231)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iL7D1-00036j-LW
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:56:59 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E512E18CB917
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 14:56:58 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-36.ams2.redhat.com
 [10.36.112.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 339AF1001B0B;
 Thu, 17 Oct 2019 14:56:58 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] tests: allow filtering crypto cipher benchmark tests
Date: Thu, 17 Oct 2019 15:56:51 +0100
Message-Id: <20191017145654.11371-2-berrange@redhat.com>
In-Reply-To: <20191017145654.11371-1-berrange@redhat.com>
References: <20191017145654.11371-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Thu, 17 Oct 2019 14:56:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add support for specifying a cipher mode and chunk size as argv to
filter which combinations are benchmarked. For example to only
benchmark XTS mode with 512 byte chunks:

  ./tests/benchmark-crypto-cipher xts 512

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 tests/benchmark-crypto-cipher.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tests/benchmark-crypto-cipher.c b/tests/benchmark-crypto-cip=
her.c
index 67fdf8c31d..3ca31a2779 100644
--- a/tests/benchmark-crypto-cipher.c
+++ b/tests/benchmark-crypto-cipher.c
@@ -161,15 +161,26 @@ static void test_cipher_speed_xts_aes_256(const voi=
d *opaque)
=20
 int main(int argc, char **argv)
 {
+    char *alg =3D NULL;
+    char *size =3D NULL;
     g_test_init(&argc, &argv, NULL);
     g_assert(qcrypto_init(NULL) =3D=3D 0);
=20
 #define ADD_TEST(mode, cipher, keysize, chunk)                          =
\
-    g_test_add_data_func(                                               =
\
+    if ((!alg || g_str_equal(alg, #mode)) &&                            =
\
+        (!size || g_str_equal(size, #chunk)))                           =
\
+        g_test_add_data_func(                                           =
\
         "/crypto/cipher/" #mode "-" #cipher "-" #keysize "/chunk-" #chun=
k, \
         (void *)chunk,                                                  =
\
         test_cipher_speed_ ## mode ## _ ## cipher ## _ ## keysize)
=20
+    if (argc >=3D 2) {
+        alg =3D argv[1];
+    }
+    if (argc >=3D 3) {
+        size =3D argv[2];
+    }
+
 #define ADD_TESTS(chunk)                        \
     do {                                        \
         ADD_TEST(ecb, aes, 128, chunk);         \
--=20
2.21.0


