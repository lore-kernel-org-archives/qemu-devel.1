Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE93C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 16:03:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2548207E0
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 16:03:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2548207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDsie-0005EW-1Z
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 12:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40580)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iDqcq-0003gD-LG
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:49:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iDqcp-0006bR-8J
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:49:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40652)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iDqcp-0006b8-04
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:49:35 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C179C8AC6FF
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 10:11:12 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-55.ams2.redhat.com
 [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E4B5460BF3;
 Fri, 27 Sep 2019 10:11:11 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] crypto: extend hash benchmark to cover more algorithms
Date: Fri, 27 Sep 2019 11:11:10 +0100
Message-Id: <20190927101110.25581-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Fri, 27 Sep 2019 10:11:12 +0000 (UTC)
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

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 tests/benchmark-crypto-hash.c | 75 +++++++++++++++++++++++++++--------
 1 file changed, 59 insertions(+), 16 deletions(-)

diff --git a/tests/benchmark-crypto-hash.c b/tests/benchmark-crypto-hash.=
c
index 9b6f7a9155..948a0be3c6 100644
--- a/tests/benchmark-crypto-hash.c
+++ b/tests/benchmark-crypto-hash.c
@@ -15,36 +15,38 @@
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
     double total =3D 0.0;
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
     do {
-        ret =3D qcrypto_hash_bytesv(QCRYPTO_HASH_ALG_SHA256,
+        ret =3D qcrypto_hash_bytesv(opts->alg,
                                   &iov, 1, &out, &out_len,
                                   NULL);
         g_assert(ret =3D=3D 0);
=20
-        total +=3D chunk_size;
+        total +=3D opts->chunk_size;
     } while (g_test_timer_elapsed() < 5.0);
=20
     total /=3D MiB;
-    g_print("sha256: ");
-    g_print("Testing chunk_size %zu bytes ", chunk_size);
-    g_print("done: %.2f MB in %.2f secs: ", total, g_test_timer_last());
-    g_print("%.2f MB/sec\n", total / g_test_timer_last());
+    g_print("%.2f MB/sec ", total / g_test_timer_last());
=20
     g_free(out);
     g_free(in);
@@ -52,17 +54,58 @@ static void test_hash_speed(const void *opaque)
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
+             "/crypto/hash/%s/speed-%d",                        \
+             QCryptoHashAlgorithm_str(QCRYPTO_HASH_ALG_ ## a),  \
+             c);                                                \
+    g_test_add_data_func(name,                                  \
+                         &opts ## a ## c,                       \
+                         test_hash_speed);
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
2.21.0


