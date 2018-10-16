Received: from eggs.gnu.org ([2001:4830:134:3::10]:44790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gCMI9-0002up-1v
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:09:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gCMI5-0006Gt-Bz
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:09:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gCMI3-00066H-7J
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:09:29 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue, 16 Oct 2018 11:09:11 +0100
Message-Id: <20181016100918.21030-2-berrange@redhat.com>
In-Reply-To: <20181016100918.21030-1-berrange@redhat.com>
References: <20181016100918.21030-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/8] crypto: expand algorithm coverage for
 cipher benchmark
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Alberto Garcia <berto@igalia.com>

Add testing coverage for AES with XTS, ECB and CTR modes

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 tests/benchmark-crypto-cipher.c | 149 +++++++++++++++++++++++++++-----
 1 file changed, 126 insertions(+), 23 deletions(-)

diff --git a/tests/benchmark-crypto-cipher.c b/tests/benchmark-crypto-cip=
her.c
index f5a0d0bc32..67fdf8c31d 100644
--- a/tests/benchmark-crypto-cipher.c
+++ b/tests/benchmark-crypto-cipher.c
@@ -15,17 +15,27 @@
 #include "crypto/init.h"
 #include "crypto/cipher.h"
=20
-static void test_cipher_speed(const void *opaque)
+static void test_cipher_speed(size_t chunk_size,
+                              QCryptoCipherMode mode,
+                              QCryptoCipherAlgorithm alg)
 {
     QCryptoCipher *cipher;
     Error *err =3D NULL;
     double total =3D 0.0;
-    size_t chunk_size =3D (size_t)opaque;
     uint8_t *key =3D NULL, *iv =3D NULL;
     uint8_t *plaintext =3D NULL, *ciphertext =3D NULL;
-    size_t nkey =3D qcrypto_cipher_get_key_len(QCRYPTO_CIPHER_ALG_AES_12=
8);
-    size_t niv =3D qcrypto_cipher_get_iv_len(QCRYPTO_CIPHER_ALG_AES_128,
-                                           QCRYPTO_CIPHER_MODE_CBC);
+    size_t nkey;
+    size_t niv;
+
+    if (!qcrypto_cipher_supports(alg, mode)) {
+        return;
+    }
+
+    nkey =3D qcrypto_cipher_get_key_len(alg);
+    niv =3D qcrypto_cipher_get_iv_len(alg, mode);
+    if (mode =3D=3D QCRYPTO_CIPHER_MODE_XTS) {
+        nkey *=3D 2;
+    }
=20
     key =3D g_new0(uint8_t, nkey);
     memset(key, g_test_rand_int(), nkey);
@@ -38,14 +48,14 @@ static void test_cipher_speed(const void *opaque)
     plaintext =3D g_new0(uint8_t, chunk_size);
     memset(plaintext, g_test_rand_int(), chunk_size);
=20
-    cipher =3D qcrypto_cipher_new(QCRYPTO_CIPHER_ALG_AES_128,
-                                QCRYPTO_CIPHER_MODE_CBC,
+    cipher =3D qcrypto_cipher_new(alg, mode,
                                 key, nkey, &err);
     g_assert(cipher !=3D NULL);
=20
-    g_assert(qcrypto_cipher_setiv(cipher,
-                                  iv, niv,
-                                  &err) =3D=3D 0);
+    if (mode !=3D QCRYPTO_CIPHER_MODE_ECB)
+        g_assert(qcrypto_cipher_setiv(cipher,
+                                      iv, niv,
+                                      &err) =3D=3D 0);
=20
     g_test_timer_start();
     do {
@@ -55,13 +65,26 @@ static void test_cipher_speed(const void *opaque)
                                         chunk_size,
                                         &err) =3D=3D 0);
         total +=3D chunk_size;
-    } while (g_test_timer_elapsed() < 5.0);
+    } while (g_test_timer_elapsed() < 1.0);
=20
     total /=3D MiB;
-    g_print("cbc(aes128): ");
-    g_print("Testing chunk_size %zu bytes ", chunk_size);
-    g_print("done: %.2f MB in %.2f secs: ", total, g_test_timer_last());
-    g_print("%.2f MB/sec\n", total / g_test_timer_last());
+    g_print("Enc chunk %zu bytes ", chunk_size);
+    g_print("%.2f MB/sec ", total / g_test_timer_last());
+
+    total =3D 0.0;
+    g_test_timer_start();
+    do {
+        g_assert(qcrypto_cipher_decrypt(cipher,
+                                        plaintext,
+                                        ciphertext,
+                                        chunk_size,
+                                        &err) =3D=3D 0);
+        total +=3D chunk_size;
+    } while (g_test_timer_elapsed() < 1.0);
+
+    total /=3D MiB;
+    g_print("Dec chunk %zu bytes ", chunk_size);
+    g_print("%.2f MB/sec ", total / g_test_timer_last());
=20
     qcrypto_cipher_free(cipher);
     g_free(plaintext);
@@ -70,19 +93,99 @@ static void test_cipher_speed(const void *opaque)
     g_free(key);
 }
=20
-int main(int argc, char **argv)
+
+static void test_cipher_speed_ecb_aes_128(const void *opaque)
+{
+    size_t chunk_size =3D (size_t)opaque;
+    test_cipher_speed(chunk_size,
+                      QCRYPTO_CIPHER_MODE_ECB,
+                      QCRYPTO_CIPHER_ALG_AES_128);
+}
+
+static void test_cipher_speed_ecb_aes_256(const void *opaque)
 {
-    size_t i;
-    char name[64];
+    size_t chunk_size =3D (size_t)opaque;
+    test_cipher_speed(chunk_size,
+                      QCRYPTO_CIPHER_MODE_ECB,
+                      QCRYPTO_CIPHER_ALG_AES_256);
+}
+
+static void test_cipher_speed_cbc_aes_128(const void *opaque)
+{
+    size_t chunk_size =3D (size_t)opaque;
+    test_cipher_speed(chunk_size,
+                      QCRYPTO_CIPHER_MODE_CBC,
+                      QCRYPTO_CIPHER_ALG_AES_128);
+}
=20
+static void test_cipher_speed_cbc_aes_256(const void *opaque)
+{
+    size_t chunk_size =3D (size_t)opaque;
+    test_cipher_speed(chunk_size,
+                      QCRYPTO_CIPHER_MODE_CBC,
+                      QCRYPTO_CIPHER_ALG_AES_256);
+}
+
+static void test_cipher_speed_ctr_aes_128(const void *opaque)
+{
+    size_t chunk_size =3D (size_t)opaque;
+    test_cipher_speed(chunk_size,
+                      QCRYPTO_CIPHER_MODE_CTR,
+                      QCRYPTO_CIPHER_ALG_AES_128);
+}
+
+static void test_cipher_speed_ctr_aes_256(const void *opaque)
+{
+    size_t chunk_size =3D (size_t)opaque;
+    test_cipher_speed(chunk_size,
+                      QCRYPTO_CIPHER_MODE_CTR,
+                      QCRYPTO_CIPHER_ALG_AES_256);
+}
+
+static void test_cipher_speed_xts_aes_128(const void *opaque)
+{
+    size_t chunk_size =3D (size_t)opaque;
+    test_cipher_speed(chunk_size,
+                      QCRYPTO_CIPHER_MODE_XTS,
+                      QCRYPTO_CIPHER_ALG_AES_128);
+}
+
+static void test_cipher_speed_xts_aes_256(const void *opaque)
+{
+    size_t chunk_size =3D (size_t)opaque;
+    test_cipher_speed(chunk_size,
+                      QCRYPTO_CIPHER_MODE_XTS,
+                      QCRYPTO_CIPHER_ALG_AES_256);
+}
+
+
+int main(int argc, char **argv)
+{
     g_test_init(&argc, &argv, NULL);
     g_assert(qcrypto_init(NULL) =3D=3D 0);
=20
-    for (i =3D 512; i <=3D 64 * KiB; i *=3D 2) {
-        memset(name, 0 , sizeof(name));
-        snprintf(name, sizeof(name), "/crypto/cipher/speed-%zu", i);
-        g_test_add_data_func(name, (void *)i, test_cipher_speed);
-    }
+#define ADD_TEST(mode, cipher, keysize, chunk)                          =
\
+    g_test_add_data_func(                                               =
\
+        "/crypto/cipher/" #mode "-" #cipher "-" #keysize "/chunk-" #chun=
k, \
+        (void *)chunk,                                                  =
\
+        test_cipher_speed_ ## mode ## _ ## cipher ## _ ## keysize)
+
+#define ADD_TESTS(chunk)                        \
+    do {                                        \
+        ADD_TEST(ecb, aes, 128, chunk);         \
+        ADD_TEST(ecb, aes, 256, chunk);         \
+        ADD_TEST(cbc, aes, 128, chunk);         \
+        ADD_TEST(cbc, aes, 256, chunk);         \
+        ADD_TEST(ctr, aes, 128, chunk);         \
+        ADD_TEST(ctr, aes, 256, chunk);         \
+        ADD_TEST(xts, aes, 128, chunk);         \
+        ADD_TEST(xts, aes, 256, chunk);         \
+    } while (0)
+
+    ADD_TESTS(512);
+    ADD_TESTS(4096);
+    ADD_TESTS(16384);
+    ADD_TESTS(65536);
=20
     return g_test_run();
 }
--=20
2.17.2
