Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A4ECA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 16:09:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A497C208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 16:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CQQQhiwb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A497C208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP7a9-0006s8-0K
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 12:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32995)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iP7HB-0003xl-1d
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:49:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iP7H9-00015g-Jt
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:49:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36807
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iP7H9-00015V-GB
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:49:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572277787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c+h/i9leFm5UIiefBkZRC/Y4pHCEuRBjNrZH7giOCj0=;
 b=CQQQhiwbyQPFDtXv8q0PQV/vHHn2472+hjHu4NrndQVNtJ9EgAztIAQRljaqQc9ePnBoMg
 EeC/wx6cTZE7Aa1qmUWEfY0/wE16Ik4RncHu4IfjiQWJp82KtCj6l8P7Lk2EdAbAwFS8we
 DMvte1L6/uzrDQZkiZOSvdMOsMNJMKA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-VWhYsZjpPJGruDk7Gxsyqg-1; Mon, 28 Oct 2019 11:49:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF17B107AD28
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 15:49:44 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-24.ams2.redhat.com
 [10.36.112.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 267CF5D9C8;
 Mon, 28 Oct 2019 15:49:39 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/4] tests: benchmark crypto with fixed data size,
 not time period
Date: Mon, 28 Oct 2019 16:49:12 +0100
Message-Id: <20191028154914.84821-3-berrange@redhat.com>
In-Reply-To: <20191028154914.84821-1-berrange@redhat.com>
References: <20191028154914.84821-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: VWhYsZjpPJGruDk7Gxsyqg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently the crypto benchmarks are processing data in varying chunk
sizes, over a fixed time period. This turns out to be a terrible idea
because with small chunk sizes the overhead of checking the elapsed
time on each loop iteration masks the true performance.

Benchmarking over a fixed data size avoids the loop running any system
calls which can interfere with the performance measurements.

Before this change

Enc chunk 512 bytes 2283.47 MB/sec Dec chunk 512 bytes 2236.23 MB/sec OK
Enc chunk 4096 bytes 2744.97 MB/sec Dec chunk 4096 bytes 2614.71 MB/sec OK
Enc chunk 16384 bytes 2777.53 MB/sec Dec chunk 16384 bytes 2678.44 MB/sec O=
K
Enc chunk 65536 bytes 2809.34 MB/sec Dec chunk 65536 bytes 2699.47 MB/sec O=
K

After this change

Enc chunk 512 bytes 2058.22 MB/sec Dec chunk 512 bytes 2030.11 MB/sec OK
Enc chunk 4096 bytes 2699.27 MB/sec Dec chunk 4096 bytes 2573.78 MB/sec OK
Enc chunk 16384 bytes 2748.52 MB/sec Dec chunk 16384 bytes 2653.76 MB/sec O=
K
Enc chunk 65536 bytes 2814.08 MB/sec Dec chunk 65536 bytes 2712.74 MB/sec O=
K

The actual crypto performance hasn't changed, which shows how
significant the mis-measurement has been for small data sizes.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 tests/benchmark-crypto-cipher.c | 26 ++++++++++++++------------
 tests/benchmark-crypto-hash.c   | 17 +++++++++--------
 2 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/tests/benchmark-crypto-cipher.c b/tests/benchmark-crypto-ciphe=
r.c
index 3ca31a2779..53032334ec 100644
--- a/tests/benchmark-crypto-cipher.c
+++ b/tests/benchmark-crypto-cipher.c
@@ -21,11 +21,12 @@ static void test_cipher_speed(size_t chunk_size,
 {
     QCryptoCipher *cipher;
     Error *err =3D NULL;
-    double total =3D 0.0;
     uint8_t *key =3D NULL, *iv =3D NULL;
     uint8_t *plaintext =3D NULL, *ciphertext =3D NULL;
     size_t nkey;
     size_t niv;
+    const size_t total =3D 2 * GiB;
+    size_t remain;
=20
     if (!qcrypto_cipher_supports(alg, mode)) {
         return;
@@ -58,33 +59,34 @@ static void test_cipher_speed(size_t chunk_size,
                                       &err) =3D=3D 0);
=20
     g_test_timer_start();
-    do {
+    remain =3D total;
+    while (remain) {
         g_assert(qcrypto_cipher_encrypt(cipher,
                                         plaintext,
                                         ciphertext,
                                         chunk_size,
                                         &err) =3D=3D 0);
-        total +=3D chunk_size;
-    } while (g_test_timer_elapsed() < 1.0);
+        remain -=3D chunk_size;
+    }
+    g_test_timer_elapsed();
=20
-    total /=3D MiB;
     g_print("Enc chunk %zu bytes ", chunk_size);
-    g_print("%.2f MB/sec ", total / g_test_timer_last());
+    g_print("%.2f MB/sec ", (double)total / MiB / g_test_timer_last());
=20
-    total =3D 0.0;
     g_test_timer_start();
-    do {
+    remain =3D total;
+    while (remain) {
         g_assert(qcrypto_cipher_decrypt(cipher,
                                         plaintext,
                                         ciphertext,
                                         chunk_size,
                                         &err) =3D=3D 0);
-        total +=3D chunk_size;
-    } while (g_test_timer_elapsed() < 1.0);
+        remain -=3D chunk_size;
+    }
+    g_test_timer_elapsed();
=20
-    total /=3D MiB;
     g_print("Dec chunk %zu bytes ", chunk_size);
-    g_print("%.2f MB/sec ", total / g_test_timer_last());
+    g_print("%.2f MB/sec ", (double)total / MiB / g_test_timer_last());
=20
     qcrypto_cipher_free(cipher);
     g_free(plaintext);
diff --git a/tests/benchmark-crypto-hash.c b/tests/benchmark-crypto-hash.c
index 9b6f7a9155..7f659f7323 100644
--- a/tests/benchmark-crypto-hash.c
+++ b/tests/benchmark-crypto-hash.c
@@ -20,7 +20,8 @@ static void test_hash_speed(const void *opaque)
     size_t chunk_size =3D (size_t)opaque;
     uint8_t *in =3D NULL, *out =3D NULL;
     size_t out_len =3D 0;
-    double total =3D 0.0;
+    const size_t total =3D 2 * GiB;
+    size_t remain;
     struct iovec iov;
     int ret;
=20
@@ -31,20 +32,20 @@ static void test_hash_speed(const void *opaque)
     iov.iov_len =3D chunk_size;
=20
     g_test_timer_start();
-    do {
+    remain =3D total;
+    while (remain) {
         ret =3D qcrypto_hash_bytesv(QCRYPTO_HASH_ALG_SHA256,
                                   &iov, 1, &out, &out_len,
                                   NULL);
         g_assert(ret =3D=3D 0);
=20
-        total +=3D chunk_size;
-    } while (g_test_timer_elapsed() < 5.0);
+        remain -=3D chunk_size;
+    }
+    g_test_timer_elapsed();
=20
-    total /=3D MiB;
     g_print("sha256: ");
-    g_print("Testing chunk_size %zu bytes ", chunk_size);
-    g_print("done: %.2f MB in %.2f secs: ", total, g_test_timer_last());
-    g_print("%.2f MB/sec\n", total / g_test_timer_last());
+    g_print("Hash %zu GB chunk size %zu bytes ", total / GiB, chunk_size);
+    g_print("%.2f MB/sec ", (double)total / MiB / g_test_timer_last());
=20
     g_free(out);
     g_free(in);
--=20
2.23.0


