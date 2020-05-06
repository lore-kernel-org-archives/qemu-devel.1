Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FFBC28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 13:52:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D74820752
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 13:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XP8vPFqb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D74820752
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWKTS-00032l-4K
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 09:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jWKSf-0001zA-9l
 for qemu-devel@nongnu.org; Wed, 06 May 2020 09:51:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46731
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jWKSe-0003Xx-0O
 for qemu-devel@nongnu.org; Wed, 06 May 2020 09:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588773102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=b3oUpO4LXoxCUdR0u56sRWIR9gcY8GxlhyR8jNkWBK8=;
 b=XP8vPFqbJMJ4zsVj13UaEM3k4T5+5thVyMWYWoIXjQ1SxFNaxX0CM7hyroXjenyCICMVh8
 qVgVexN6WFhDdE7QuCEJlF0JZzr7fuxLODZ1210Ojt/NVCQsAnm2IN4YHcxC2P7L9DJWZm
 XhiLBavHsqjeSNgeB7pGfrQrWb7unbo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-6WtQcl7lMZyv5hFfDk9TjA-1; Wed, 06 May 2020 09:51:30 -0400
X-MC-Unique: 6WtQcl7lMZyv5hFfDk9TjA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1AAEAB689
 for <qemu-devel@nongnu.org>; Wed,  6 May 2020 13:51:12 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F24765F7E2;
 Wed,  6 May 2020 13:51:11 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] crypto: extend hash benchmark to cover more algorithms
Date: Wed,  6 May 2020 14:51:04 +0100
Message-Id: <20200506135104.1080162-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 04:02:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Extend the hash benchmark so that it can validate all algorithms
supported by QEMU instead of being limited to sha256.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 tests/benchmark-crypto-hash.c | 73 ++++++++++++++++++++++++++++-------
 1 file changed, 59 insertions(+), 14 deletions(-)

diff --git a/tests/benchmark-crypto-hash.c b/tests/benchmark-crypto-hash.c
index 7f659f7323..d16837d00a 100644
--- a/tests/benchmark-crypto-hash.c
+++ b/tests/benchmark-crypto-hash.c
@@ -15,9 +15,14 @@
 #include "crypto/init.h"
 #include "crypto/hash.h"
=20
+typedef struct QCryptoHashOpts {
+    size_t chunk_size;
+    QCryptoHashAlgorithm alg;
+} QCryptoHashOpts;
+
 static void test_hash_speed(const void *opaque)
 {
-    size_t chunk_size =3D (size_t)opaque;
+    const QCryptoHashOpts *opts =3D opaque;
     uint8_t *in =3D NULL, *out =3D NULL;
     size_t out_len =3D 0;
     const size_t total =3D 2 * GiB;
@@ -25,26 +30,24 @@ static void test_hash_speed(const void *opaque)
     struct iovec iov;
     int ret;
=20
-    in =3D g_new0(uint8_t, chunk_size);
-    memset(in, g_test_rand_int(), chunk_size);
+    in =3D g_new0(uint8_t, opts->chunk_size);
+    memset(in, g_test_rand_int(), opts->chunk_size);
=20
     iov.iov_base =3D (char *)in;
-    iov.iov_len =3D chunk_size;
+    iov.iov_len =3D opts->chunk_size;
=20
     g_test_timer_start();
     remain =3D total;
     while (remain) {
-        ret =3D qcrypto_hash_bytesv(QCRYPTO_HASH_ALG_SHA256,
+        ret =3D qcrypto_hash_bytesv(opts->alg,
                                   &iov, 1, &out, &out_len,
                                   NULL);
         g_assert(ret =3D=3D 0);
=20
-        remain -=3D chunk_size;
+        remain -=3D opts->chunk_size;
     }
     g_test_timer_elapsed();
=20
-    g_print("sha256: ");
-    g_print("Hash %zu GB chunk size %zu bytes ", total / GiB, chunk_size);
     g_print("%.2f MB/sec ", (double)total / MiB / g_test_timer_last());
=20
     g_free(out);
@@ -53,17 +56,59 @@ static void test_hash_speed(const void *opaque)
=20
 int main(int argc, char **argv)
 {
-    size_t i;
     char name[64];
=20
     g_test_init(&argc, &argv, NULL);
     g_assert(qcrypto_init(NULL) =3D=3D 0);
=20
-    for (i =3D 512; i <=3D 64 * KiB; i *=3D 2) {
-        memset(name, 0 , sizeof(name));
-        snprintf(name, sizeof(name), "/crypto/hash/speed-%zu", i);
-        g_test_add_data_func(name, (void *)i, test_hash_speed);
-    }
+#define TEST_ONE(a, c)                                          \
+    QCryptoHashOpts opts ## a ## c =3D {                          \
+        .alg =3D QCRYPTO_HASH_ALG_ ## a, .chunk_size =3D c,         \
+    };                                                          \
+    memset(name, 0 , sizeof(name));                             \
+    snprintf(name, sizeof(name),                                \
+             "/crypto/benchmark/hash/%s/bufsize-%d",            \
+             QCryptoHashAlgorithm_str(QCRYPTO_HASH_ALG_ ## a),  \
+             c);                                                \
+    if (qcrypto_hash_supports(QCRYPTO_HASH_ALG_ ## a))          \
+        g_test_add_data_func(name,                              \
+                             &opts ## a ## c,                   \
+                             test_hash_speed);
+
+    TEST_ONE(MD5, 512);
+    TEST_ONE(MD5, 1024);
+    TEST_ONE(MD5, 4096);
+    TEST_ONE(MD5, 16384);
+
+    TEST_ONE(SHA1, 512);
+    TEST_ONE(SHA1, 1024);
+    TEST_ONE(SHA1, 4096);
+    TEST_ONE(SHA1, 16384);
+
+    TEST_ONE(SHA224, 512);
+    TEST_ONE(SHA224, 1024);
+    TEST_ONE(SHA224, 4096);
+    TEST_ONE(SHA224, 16384);
+
+    TEST_ONE(SHA384, 512);
+    TEST_ONE(SHA384, 1024);
+    TEST_ONE(SHA384, 4096);
+    TEST_ONE(SHA384, 16384);
+
+    TEST_ONE(SHA256, 512);
+    TEST_ONE(SHA256, 1024);
+    TEST_ONE(SHA256, 4096);
+    TEST_ONE(SHA256, 16384);
+
+    TEST_ONE(SHA512, 512);
+    TEST_ONE(SHA512, 1024);
+    TEST_ONE(SHA512, 4096);
+    TEST_ONE(SHA512, 16384);
+
+    TEST_ONE(RIPEMD160, 512);
+    TEST_ONE(RIPEMD160, 1024);
+    TEST_ONE(RIPEMD160, 4096);
+    TEST_ONE(RIPEMD160, 16384);
=20
     return g_test_run();
 }
--=20
2.26.2


