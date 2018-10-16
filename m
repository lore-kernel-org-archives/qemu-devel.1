Received: from eggs.gnu.org ([2001:4830:134:3::10]:44860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gCMIB-0002xG-Qa
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:09:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gCMI9-0006O9-Tb
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:09:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gCMI9-0006Lf-Ga
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:09:33 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue, 16 Oct 2018 11:09:17 +0100
Message-Id: <20181016100918.21030-8-berrange@redhat.com>
In-Reply-To: <20181016100918.21030-1-berrange@redhat.com>
References: <20181016100918.21030-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 7/8] crypto: refactor XTS cipher mode test
 suite
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

The current XTS test overloads two different tests in a single function
making the code a little hard to follow. Split it into distinct test
cases.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 tests/test-crypto-xts.c | 140 +++++++++++++++++++++++-----------------
 1 file changed, 80 insertions(+), 60 deletions(-)

diff --git a/tests/test-crypto-xts.c b/tests/test-crypto-xts.c
index 1f1412c45a..81606d90ad 100644
--- a/tests/test-crypto-xts.c
+++ b/tests/test-crypto-xts.c
@@ -1,7 +1,7 @@
 /*
  * QEMU Crypto XTS cipher mode
  *
- * Copyright (c) 2015-2016 Red Hat, Inc.
+ * Copyright (c) 2015-2018 Red Hat, Inc.
  *
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
@@ -340,70 +340,79 @@ static void test_xts_aes_decrypt(const void *ctx,
 static void test_xts(const void *opaque)
 {
     const QCryptoXTSTestData *data =3D opaque;
-    unsigned char out[512], Torg[16], T[16];
+    uint8_t out[512], Torg[16], T[16];
     uint64_t seq;
-    int j;
-    unsigned long len;
     struct TestAES aesdata;
     struct TestAES aestweak;
=20
-    for (j =3D 0; j < 2; j++) {
-        /* skip the cases where
-         * the length is smaller than 2*blocklen
-         * or the length is not a multiple of 32
-         */
-        if ((j =3D=3D 1) && ((data->PTLEN < 32) || (data->PTLEN % 32))) =
{
-            continue;
-        }
-        len =3D data->PTLEN / 2;
-
-        AES_set_encrypt_key(data->key1, data->keylen / 2 * 8, &aesdata.e=
nc);
-        AES_set_decrypt_key(data->key1, data->keylen / 2 * 8, &aesdata.d=
ec);
-        AES_set_encrypt_key(data->key2, data->keylen / 2 * 8, &aestweak.=
enc);
-        AES_set_decrypt_key(data->key2, data->keylen / 2 * 8, &aestweak.=
dec);
-
-        seq =3D data->seqnum;
-        STORE64L(seq, Torg);
-        memset(Torg + 8, 0, 8);
-
-        memcpy(T, Torg, sizeof(T));
-        if (j =3D=3D 0) {
-            xts_encrypt(&aesdata, &aestweak,
-                        test_xts_aes_encrypt,
-                        test_xts_aes_decrypt,
-                        T, data->PTLEN, out, data->PTX);
-        } else {
-            xts_encrypt(&aesdata, &aestweak,
-                        test_xts_aes_encrypt,
-                        test_xts_aes_decrypt,
-                        T, len, out, data->PTX);
-            xts_encrypt(&aesdata, &aestweak,
-                        test_xts_aes_encrypt,
-                        test_xts_aes_decrypt,
-                        T, len, &out[len], &data->PTX[len]);
-        }
+    AES_set_encrypt_key(data->key1, data->keylen / 2 * 8, &aesdata.enc);
+    AES_set_decrypt_key(data->key1, data->keylen / 2 * 8, &aesdata.dec);
+    AES_set_encrypt_key(data->key2, data->keylen / 2 * 8, &aestweak.enc)=
;
+    AES_set_decrypt_key(data->key2, data->keylen / 2 * 8, &aestweak.dec)=
;
=20
-        g_assert(memcmp(out, data->CTX, data->PTLEN) =3D=3D 0);
-
-        memcpy(T, Torg, sizeof(T));
-        if (j =3D=3D 0) {
-            xts_decrypt(&aesdata, &aestweak,
-                        test_xts_aes_encrypt,
-                        test_xts_aes_decrypt,
-                        T, data->PTLEN, out, data->CTX);
-        } else {
-            xts_decrypt(&aesdata, &aestweak,
-                        test_xts_aes_encrypt,
-                        test_xts_aes_decrypt,
-                        T, len, out, data->CTX);
-            xts_decrypt(&aesdata, &aestweak,
-                        test_xts_aes_encrypt,
-                        test_xts_aes_decrypt,
-                        T, len, &out[len], &data->CTX[len]);
-        }
+    seq =3D data->seqnum;
+    STORE64L(seq, Torg);
+    memset(Torg + 8, 0, 8);
=20
-        g_assert(memcmp(out, data->PTX, data->PTLEN) =3D=3D 0);
-    }
+    memcpy(T, Torg, sizeof(T));
+    xts_encrypt(&aesdata, &aestweak,
+                test_xts_aes_encrypt,
+                test_xts_aes_decrypt,
+                T, data->PTLEN, out, data->PTX);
+
+    g_assert(memcmp(out, data->CTX, data->PTLEN) =3D=3D 0);
+
+    memcpy(T, Torg, sizeof(T));
+    xts_decrypt(&aesdata, &aestweak,
+                test_xts_aes_encrypt,
+                test_xts_aes_decrypt,
+                T, data->PTLEN, out, data->CTX);
+
+    g_assert(memcmp(out, data->PTX, data->PTLEN) =3D=3D 0);
+}
+
+
+static void test_xts_split(const void *opaque)
+{
+    const QCryptoXTSTestData *data =3D opaque;
+    uint8_t out[512], Torg[16], T[16];
+    uint64_t seq;
+    unsigned long len =3D data->PTLEN / 2;
+    struct TestAES aesdata;
+    struct TestAES aestweak;
+
+    AES_set_encrypt_key(data->key1, data->keylen / 2 * 8, &aesdata.enc);
+    AES_set_decrypt_key(data->key1, data->keylen / 2 * 8, &aesdata.dec);
+    AES_set_encrypt_key(data->key2, data->keylen / 2 * 8, &aestweak.enc)=
;
+    AES_set_decrypt_key(data->key2, data->keylen / 2 * 8, &aestweak.dec)=
;
+
+    seq =3D data->seqnum;
+    STORE64L(seq, Torg);
+    memset(Torg + 8, 0, 8);
+
+    memcpy(T, Torg, sizeof(T));
+    xts_encrypt(&aesdata, &aestweak,
+                test_xts_aes_encrypt,
+                test_xts_aes_decrypt,
+                T, len, out, data->PTX);
+    xts_encrypt(&aesdata, &aestweak,
+                test_xts_aes_encrypt,
+                test_xts_aes_decrypt,
+                T, len, &out[len], &data->PTX[len]);
+
+    g_assert(memcmp(out, data->CTX, data->PTLEN) =3D=3D 0);
+
+    memcpy(T, Torg, sizeof(T));
+    xts_decrypt(&aesdata, &aestweak,
+                test_xts_aes_encrypt,
+                test_xts_aes_decrypt,
+                T, len, out, data->CTX);
+    xts_decrypt(&aesdata, &aestweak,
+                test_xts_aes_encrypt,
+                test_xts_aes_decrypt,
+                T, len, &out[len], &data->CTX[len]);
+
+    g_assert(memcmp(out, data->PTX, data->PTLEN) =3D=3D 0);
 }
=20
=20
@@ -416,7 +425,18 @@ int main(int argc, char **argv)
     g_assert(qcrypto_init(NULL) =3D=3D 0);
=20
     for (i =3D 0; i < G_N_ELEMENTS(test_data); i++) {
-        g_test_add_data_func(test_data[i].path, &test_data[i], test_xts)=
;
+        gchar *path =3D g_strdup_printf("%s/basic", test_data[i].path);
+        g_test_add_data_func(path, &test_data[i], test_xts);
+        g_free(path);
+
+        /* skip the cases where the length is smaller than 2*blocklen
+         * or the length is not a multiple of 32
+         */
+        if ((test_data[i].PTLEN >=3D 32) && !(test_data[i].PTLEN % 32)) =
{
+            path =3D g_strdup_printf("%s/split", test_data[i].path);
+            g_test_add_data_func(path, &test_data[i], test_xts_split);
+            g_free(path);
+        }
     }
=20
     return g_test_run();
--=20
2.17.2
