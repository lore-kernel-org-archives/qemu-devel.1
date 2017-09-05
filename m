Received: from eggs.gnu.org ([2001:4830:134:3::10]:45649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpAAc-00076i-9z
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:29:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpAAX-0007Bi-38
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:29:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dpAAW-0007At-QN
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:29:17 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue,  5 Sep 2017 10:29:09 +0100
Message-Id: <20170905092910.8946-2-berrange@redhat.com>
In-Reply-To: <20170905092910.8946-1-berrange@redhat.com>
References: <20170905092910.8946-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 1/2] tests: fix incorrect size_t format in
 benchmark-crypto
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, "Daniel P . Berrange" <berrange@redhat.com>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

  $ make check-speed
  tests/benchmark-crypto-hash.c: In function 'test_hash_speed':
  tests/benchmark-crypto-hash.c:44:5: error: format '%ld' expects argumen=
t of type 'long int', but argument 2 has type 'size_t' [-Werror=3Dformat=3D=
]
       g_print("Testing chunk_size %ld bytes ", chunk_size);
       ^
  tests/benchmark-crypto-hash.c: In function 'main':
  tests/benchmark-crypto-hash.c:62:9: error: format '%lu' expects argumen=
t of type 'long unsigned int', but argument 4 has type 'size_t' [-Werror=3D=
format=3D]
           snprintf(name, sizeof(name), "/crypto/hash/speed-%lu", i);
           ^
  cc1: all warnings being treated as errors
  rules.mak:66: recipe for target 'tests/benchmark-crypto-hash.o' failed
  make: *** [tests/benchmark-crypto-hash.o] Error 1

Reviewed-by: Longpeng(Mike) <longpeng@huawei.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 tests/benchmark-crypto-cipher.c | 4 ++--
 tests/benchmark-crypto-hash.c   | 4 ++--
 tests/benchmark-crypto-hmac.c   | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/benchmark-crypto-cipher.c b/tests/benchmark-crypto-cip=
her.c
index c6a40929e4..cf98443468 100644
--- a/tests/benchmark-crypto-cipher.c
+++ b/tests/benchmark-crypto-cipher.c
@@ -59,7 +59,7 @@ static void test_cipher_speed(const void *opaque)
     total /=3D 1024 * 1024; /* to MB */
=20
     g_print("cbc(aes128): ");
-    g_print("Testing chunk_size %ld bytes ", chunk_size);
+    g_print("Testing chunk_size %zu bytes ", chunk_size);
     g_print("done: %.2f MB in %.2f secs: ", total, g_test_timer_last());
     g_print("%.2f MB/sec\n", total / g_test_timer_last());
=20
@@ -80,7 +80,7 @@ int main(int argc, char **argv)
=20
     for (i =3D 512; i <=3D (64 * 1204); i *=3D 2) {
         memset(name, 0 , sizeof(name));
-        snprintf(name, sizeof(name), "/crypto/cipher/speed-%lu", i);
+        snprintf(name, sizeof(name), "/crypto/cipher/speed-%zu", i);
         g_test_add_data_func(name, (void *)i, test_cipher_speed);
     }
=20
diff --git a/tests/benchmark-crypto-hash.c b/tests/benchmark-crypto-hash.=
c
index 6769d2a11b..122bfb6b85 100644
--- a/tests/benchmark-crypto-hash.c
+++ b/tests/benchmark-crypto-hash.c
@@ -41,7 +41,7 @@ static void test_hash_speed(const void *opaque)
=20
     total /=3D 1024 * 1024; /* to MB */
     g_print("sha256: ");
-    g_print("Testing chunk_size %ld bytes ", chunk_size);
+    g_print("Testing chunk_size %zu bytes ", chunk_size);
     g_print("done: %.2f MB in %.2f secs: ", total, g_test_timer_last());
     g_print("%.2f MB/sec\n", total / g_test_timer_last());
=20
@@ -59,7 +59,7 @@ int main(int argc, char **argv)
=20
     for (i =3D 512; i <=3D (64 * 1204); i *=3D 2) {
         memset(name, 0 , sizeof(name));
-        snprintf(name, sizeof(name), "/crypto/hash/speed-%lu", i);
+        snprintf(name, sizeof(name), "/crypto/hash/speed-%zu", i);
         g_test_add_data_func(name, (void *)i, test_hash_speed);
     }
=20
diff --git a/tests/benchmark-crypto-hmac.c b/tests/benchmark-crypto-hmac.=
c
index 72408be987..c30250df3e 100644
--- a/tests/benchmark-crypto-hmac.c
+++ b/tests/benchmark-crypto-hmac.c
@@ -56,7 +56,7 @@ static void test_hmac_speed(const void *opaque)
     total /=3D 1024 * 1024; /* to MB */
=20
     g_print("hmac(sha256): ");
-    g_print("Testing chunk_size %ld bytes ", chunk_size);
+    g_print("Testing chunk_size %zu bytes ", chunk_size);
     g_print("done: %.2f MB in %.2f secs: ", total, g_test_timer_last());
     g_print("%.2f MB/sec\n", total / g_test_timer_last());
=20
@@ -74,7 +74,7 @@ int main(int argc, char **argv)
=20
     for (i =3D 512; i <=3D (64 * 1204); i *=3D 2) {
         memset(name, 0 , sizeof(name));
-        snprintf(name, sizeof(name), "/crypto/hmac/speed-%lu", i);
+        snprintf(name, sizeof(name), "/crypto/hmac/speed-%zu", i);
         g_test_add_data_func(name, (void *)i, test_hmac_speed);
     }
=20
--=20
2.13.5
