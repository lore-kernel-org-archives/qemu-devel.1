Received: from eggs.gnu.org ([2001:4830:134:3::10]:44867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gCMIC-0002xl-7P
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:09:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gCMIA-0006Pj-W7
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:09:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gCMIA-0006O5-Ic
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:09:34 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue, 16 Oct 2018 11:09:18 +0100
Message-Id: <20181016100918.21030-9-berrange@redhat.com>
In-Reply-To: <20181016100918.21030-1-berrange@redhat.com>
References: <20181016100918.21030-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 8/8] crypto: add testing for unaligned
 buffers with XTS cipher mode
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

Validate that the XTS cipher mode will correctly operate with plain
text, cipher text and IV buffers that are not 64-bit aligned.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 tests/test-crypto-xts.c | 86 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/tests/test-crypto-xts.c b/tests/test-crypto-xts.c
index 81606d90ad..6fb61cf635 100644
--- a/tests/test-crypto-xts.c
+++ b/tests/test-crypto-xts.c
@@ -416,6 +416,88 @@ static void test_xts_split(const void *opaque)
 }
=20
=20
+static void test_xts_unaligned(const void *opaque)
+{
+#define BAD_ALIGN 3
+    const QCryptoXTSTestData *data =3D opaque;
+    uint8_t in[512 + BAD_ALIGN], out[512 + BAD_ALIGN];
+    uint8_t Torg[16], T[16 + BAD_ALIGN];
+    uint64_t seq;
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
+    /* IV not aligned */
+    memcpy(T + BAD_ALIGN, Torg, 16);
+    memcpy(in, data->PTX, data->PTLEN);
+    xts_encrypt(&aesdata, &aestweak,
+                test_xts_aes_encrypt,
+                test_xts_aes_decrypt,
+                T + BAD_ALIGN, data->PTLEN, out, in);
+
+    g_assert(memcmp(out, data->CTX, data->PTLEN) =3D=3D 0);
+
+    /* plain text not aligned */
+    memcpy(T, Torg, 16);
+    memcpy(in + BAD_ALIGN, data->PTX, data->PTLEN);
+    xts_encrypt(&aesdata, &aestweak,
+                test_xts_aes_encrypt,
+                test_xts_aes_decrypt,
+                T, data->PTLEN, out, in + BAD_ALIGN);
+
+    g_assert(memcmp(out, data->CTX, data->PTLEN) =3D=3D 0);
+
+    /* cipher text not aligned */
+    memcpy(T, Torg, 16);
+    memcpy(in, data->PTX, data->PTLEN);
+    xts_encrypt(&aesdata, &aestweak,
+                test_xts_aes_encrypt,
+                test_xts_aes_decrypt,
+                T, data->PTLEN, out + BAD_ALIGN, in);
+
+    g_assert(memcmp(out + BAD_ALIGN, data->CTX, data->PTLEN) =3D=3D 0);
+
+
+    /* IV not aligned */
+    memcpy(T + BAD_ALIGN, Torg, 16);
+    memcpy(in, data->CTX, data->PTLEN);
+    xts_decrypt(&aesdata, &aestweak,
+                test_xts_aes_encrypt,
+                test_xts_aes_decrypt,
+                T + BAD_ALIGN, data->PTLEN, out, in);
+
+    g_assert(memcmp(out, data->PTX, data->PTLEN) =3D=3D 0);
+
+    /* cipher text not aligned */
+    memcpy(T, Torg, 16);
+    memcpy(in + BAD_ALIGN, data->CTX, data->PTLEN);
+    xts_decrypt(&aesdata, &aestweak,
+                test_xts_aes_encrypt,
+                test_xts_aes_decrypt,
+                T, data->PTLEN, out, in + BAD_ALIGN);
+
+    g_assert(memcmp(out, data->PTX, data->PTLEN) =3D=3D 0);
+
+    /* plain text not aligned */
+    memcpy(T, Torg, 16);
+    memcpy(in, data->CTX, data->PTLEN);
+    xts_decrypt(&aesdata, &aestweak,
+                test_xts_aes_encrypt,
+                test_xts_aes_decrypt,
+                T, data->PTLEN, out + BAD_ALIGN, in);
+
+    g_assert(memcmp(out + BAD_ALIGN, data->PTX, data->PTLEN) =3D=3D 0);
+}
+
+
 int main(int argc, char **argv)
 {
     size_t i;
@@ -437,6 +519,10 @@ int main(int argc, char **argv)
             g_test_add_data_func(path, &test_data[i], test_xts_split);
             g_free(path);
         }
+
+        path =3D g_strdup_printf("%s/unaligned", test_data[i].path);
+        g_test_add_data_func(path, &test_data[i], test_xts_unaligned);
+        g_free(path);
     }
=20
     return g_test_run();
--=20
2.17.2
