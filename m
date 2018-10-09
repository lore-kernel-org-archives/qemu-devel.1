Received: from eggs.gnu.org ([2001:4830:134:3::10]:44000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1g9rYV-0000c1-7c
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 08:56:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1g9rYP-0004GI-6C
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 08:56:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1g9rYN-0004Dn-7U
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 08:55:59 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue,  9 Oct 2018 13:55:39 +0100
Message-Id: <20181009125541.24455-5-berrange@redhat.com>
In-Reply-To: <20181009125541.24455-1-berrange@redhat.com>
References: <20181009125541.24455-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/6] crypto: convert xts_tweak_encdec to use
 xts_uint128 type
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

Using 64-bit arithmetic increases the performance for xts-aes-128
when built with gcrypt:

  Encrypt: 235 MB/s -> 320 MB/s
  Decrypt: 245 MB/s -> 325 MB/s

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 crypto/xts.c | 52 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/crypto/xts.c b/crypto/xts.c
index ded4365191..f109c8a3ee 100644
--- a/crypto/xts.c
+++ b/crypto/xts.c
@@ -31,6 +31,12 @@ typedef struct {
     uint64_t b;
 } xts_uint128;
=20
+#define xts_uint128_xor(D, S1, S2)              \
+    do {                                        \
+        (D)->a =3D (S1)->a ^ (S2)->a;             \
+        (D)->b =3D (S1)->b ^ (S2)->b;             \
+    } while (0)
+
 static void xts_mult_x(uint8_t *I)
 {
     int x;
@@ -59,25 +65,19 @@ static void xts_mult_x(uint8_t *I)
  */
 static void xts_tweak_encdec(const void *ctx,
                              xts_cipher_func *func,
-                             const uint8_t *src,
-                             uint8_t *dst,
-                             uint8_t *iv)
+                             const xts_uint128 *src,
+                             xts_uint128 *dst,
+                             xts_uint128 *iv)
 {
-    unsigned long x;
-
     /* tweak encrypt block i */
-    for (x =3D 0; x < XTS_BLOCK_SIZE; x++) {
-        dst[x] =3D src[x] ^ iv[x];
-    }
+    xts_uint128_xor(dst, src, iv);
=20
-    func(ctx, XTS_BLOCK_SIZE, dst, dst);
+    func(ctx, XTS_BLOCK_SIZE, (uint8_t *)dst, (uint8_t *)dst);
=20
-    for (x =3D 0; x < XTS_BLOCK_SIZE; x++) {
-        dst[x] =3D dst[x] ^ iv[x];
-    }
+    xts_uint128_xor(dst, dst, iv);
=20
     /* LFSR the tweak */
-    xts_mult_x(iv);
+    xts_mult_x((uint8_t *)iv);
 }
=20
=20
@@ -110,7 +110,11 @@ void xts_decrypt(const void *datactx,
     encfunc(tweakctx, XTS_BLOCK_SIZE, (uint8_t *)&T, iv);
=20
     for (i =3D 0; i < lim; i++) {
-        xts_tweak_encdec(datactx, decfunc, src, dst, (uint8_t *)&T);
+        xts_uint128 S, D;
+
+        memcpy(&S, src, XTS_BLOCK_SIZE);
+        xts_tweak_encdec(datactx, decfunc, &S, &D, &T);
+        memcpy(dst, &D, XTS_BLOCK_SIZE);
=20
         src +=3D XTS_BLOCK_SIZE;
         dst +=3D XTS_BLOCK_SIZE;
@@ -118,11 +122,13 @@ void xts_decrypt(const void *datactx,
=20
     /* if length is not a multiple of XTS_BLOCK_SIZE then */
     if (mo > 0) {
+        xts_uint128 S, D;
         memcpy(&CC, &T, XTS_BLOCK_SIZE);
         xts_mult_x((uint8_t *)&CC);
=20
         /* PP =3D tweak decrypt block m-1 */
-        xts_tweak_encdec(datactx, decfunc, src, (uint8_t *)&PP, (uint8_t=
 *)&CC);
+        memcpy(&S, src, XTS_BLOCK_SIZE);
+        xts_tweak_encdec(datactx, decfunc, &S, &PP, &CC);
=20
         /* Pm =3D first length % XTS_BLOCK_SIZE bytes of PP */
         for (i =3D 0; i < mo; i++) {
@@ -134,7 +140,8 @@ void xts_decrypt(const void *datactx,
         }
=20
         /* Pm-1 =3D Tweak uncrypt CC */
-        xts_tweak_encdec(datactx, decfunc, (uint8_t *)&CC, dst, (uint8_t=
 *)&T);
+        xts_tweak_encdec(datactx, decfunc, &CC, &D, &T);
+        memcpy(dst, &D, XTS_BLOCK_SIZE);
     }
=20
     /* Decrypt the iv back */
@@ -171,7 +178,11 @@ void xts_encrypt(const void *datactx,
     encfunc(tweakctx, XTS_BLOCK_SIZE, (uint8_t *)&T, iv);
=20
     for (i =3D 0; i < lim; i++) {
-        xts_tweak_encdec(datactx, encfunc, src, dst, (uint8_t *)&T);
+        xts_uint128 S, D;
+
+        memcpy(&S, src, XTS_BLOCK_SIZE);
+        xts_tweak_encdec(datactx, encfunc, &S, &D, &T);
+        memcpy(dst, &D, XTS_BLOCK_SIZE);
=20
         dst +=3D XTS_BLOCK_SIZE;
         src +=3D XTS_BLOCK_SIZE;
@@ -179,8 +190,10 @@ void xts_encrypt(const void *datactx,
=20
     /* if length is not a multiple of XTS_BLOCK_SIZE then */
     if (mo > 0) {
+        xts_uint128 S, D;
         /* CC =3D tweak encrypt block m-1 */
-        xts_tweak_encdec(datactx, encfunc, src, (uint8_t *)&CC, (uint8_t=
 *)&T);
+        memcpy(&S, src, XTS_BLOCK_SIZE);
+        xts_tweak_encdec(datactx, encfunc, &S, &CC, &T);
=20
         /* Cm =3D first length % XTS_BLOCK_SIZE bytes of CC */
         for (i =3D 0; i < mo; i++) {
@@ -193,7 +206,8 @@ void xts_encrypt(const void *datactx,
         }
=20
         /* Cm-1 =3D Tweak encrypt PP */
-        xts_tweak_encdec(datactx, encfunc, (uint8_t *)&PP, dst, (uint8_t=
 *)&T);
+        xts_tweak_encdec(datactx, encfunc, &PP, &D, &T);
+        memcpy(dst, &D, XTS_BLOCK_SIZE);
     }
=20
     /* Decrypt the iv back */
--=20
2.17.1
