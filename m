Received: from eggs.gnu.org ([2001:4830:134:3::10]:44801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gCMI9-0002vs-G4
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:09:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gCMI7-0006KJ-6h
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:09:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gCMI5-0006FP-9Z
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:09:30 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue, 16 Oct 2018 11:09:14 +0100
Message-Id: <20181016100918.21030-5-berrange@redhat.com>
In-Reply-To: <20181016100918.21030-1-berrange@redhat.com>
References: <20181016100918.21030-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 4/8] crypto: convert xts_tweak_encdec to use
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

  Encrypt: 272 MB/s -> 355 MB/s
  Decrypt: 275 MB/s -> 362 MB/s

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 crypto/xts.c | 84 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 58 insertions(+), 26 deletions(-)

diff --git a/crypto/xts.c b/crypto/xts.c
index bee23f890e..2e3430672c 100644
--- a/crypto/xts.c
+++ b/crypto/xts.c
@@ -31,6 +31,13 @@ typedef union {
     uint64_t u[2];
 } xts_uint128;
=20
+static inline void xts_uint128_xor(xts_uint128 *D,
+                                   const xts_uint128 *S1,
+                                   const xts_uint128 *S2)
+{
+    D->u[0] =3D S1->u[0] ^ S2->u[0];
+    D->u[1] =3D S1->u[1] ^ S2->u[1];
+}
=20
 static void xts_mult_x(uint8_t *I)
 {
@@ -60,25 +67,19 @@ static void xts_mult_x(uint8_t *I)
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
+    func(ctx, XTS_BLOCK_SIZE, dst->b, dst->b);
=20
-    for (x =3D 0; x < XTS_BLOCK_SIZE; x++) {
-        dst[x] =3D dst[x] ^ iv[x];
-    }
+    xts_uint128_xor(dst, dst, iv);
=20
     /* LFSR the tweak */
-    xts_mult_x(iv);
+    xts_mult_x(iv->b);
 }
=20
=20
@@ -110,20 +111,34 @@ void xts_decrypt(const void *datactx,
     /* encrypt the iv */
     encfunc(tweakctx, XTS_BLOCK_SIZE, T.b, iv);
=20
-    for (i =3D 0; i < lim; i++) {
-        xts_tweak_encdec(datactx, decfunc, src, dst, T.b);
-
-        src +=3D XTS_BLOCK_SIZE;
-        dst +=3D XTS_BLOCK_SIZE;
+    if (QEMU_PTR_IS_ALIGNED(src, sizeof(uint64_t)) &&
+        QEMU_PTR_IS_ALIGNED(dst, sizeof(uint64_t))) {
+        xts_uint128 *S =3D (xts_uint128 *)src;
+        xts_uint128 *D =3D (xts_uint128 *)dst;
+        for (i =3D 0; i < lim; i++, S++, D++) {
+            xts_tweak_encdec(datactx, decfunc, S, D, &T);
+        }
+    } else {
+        xts_uint128 S, D;
+
+        for (i =3D 0; i < lim; i++) {
+            memcpy(&S, src, XTS_BLOCK_SIZE);
+            xts_tweak_encdec(datactx, decfunc, &S, &D, &T);
+            memcpy(dst, &D, XTS_BLOCK_SIZE);
+            src +=3D XTS_BLOCK_SIZE;
+            dst +=3D XTS_BLOCK_SIZE;
+        }
     }
=20
     /* if length is not a multiple of XTS_BLOCK_SIZE then */
     if (mo > 0) {
+        xts_uint128 S, D;
         memcpy(&CC, &T, XTS_BLOCK_SIZE);
         xts_mult_x(CC.b);
=20
         /* PP =3D tweak decrypt block m-1 */
-        xts_tweak_encdec(datactx, decfunc, src, PP.b, CC.b);
+        memcpy(&S, src, XTS_BLOCK_SIZE);
+        xts_tweak_encdec(datactx, decfunc, &S, &PP, &CC);
=20
         /* Pm =3D first length % XTS_BLOCK_SIZE bytes of PP */
         for (i =3D 0; i < mo; i++) {
@@ -135,7 +150,8 @@ void xts_decrypt(const void *datactx,
         }
=20
         /* Pm-1 =3D Tweak uncrypt CC */
-        xts_tweak_encdec(datactx, decfunc, CC.b, dst, T.b);
+        xts_tweak_encdec(datactx, decfunc, &CC, &D, &T);
+        memcpy(dst, &D, XTS_BLOCK_SIZE);
     }
=20
     /* Decrypt the iv back */
@@ -171,17 +187,32 @@ void xts_encrypt(const void *datactx,
     /* encrypt the iv */
     encfunc(tweakctx, XTS_BLOCK_SIZE, T.b, iv);
=20
-    for (i =3D 0; i < lim; i++) {
-        xts_tweak_encdec(datactx, encfunc, src, dst, T.b);
+    if (QEMU_PTR_IS_ALIGNED(src, sizeof(uint64_t)) &&
+        QEMU_PTR_IS_ALIGNED(dst, sizeof(uint64_t))) {
+        xts_uint128 *S =3D (xts_uint128 *)src;
+        xts_uint128 *D =3D (xts_uint128 *)dst;
+        for (i =3D 0; i < lim; i++, S++, D++) {
+            xts_tweak_encdec(datactx, encfunc, S, D, &T);
+        }
+    } else {
+        xts_uint128 S, D;
+
+        for (i =3D 0; i < lim; i++) {
+            memcpy(&S, src, XTS_BLOCK_SIZE);
+            xts_tweak_encdec(datactx, encfunc, &S, &D, &T);
+            memcpy(dst, &D, XTS_BLOCK_SIZE);
=20
-        dst +=3D XTS_BLOCK_SIZE;
-        src +=3D XTS_BLOCK_SIZE;
+            dst +=3D XTS_BLOCK_SIZE;
+            src +=3D XTS_BLOCK_SIZE;
+        }
     }
=20
     /* if length is not a multiple of XTS_BLOCK_SIZE then */
     if (mo > 0) {
+        xts_uint128 S, D;
         /* CC =3D tweak encrypt block m-1 */
-        xts_tweak_encdec(datactx, encfunc, src, CC.b, T.b);
+        memcpy(&S, src, XTS_BLOCK_SIZE);
+        xts_tweak_encdec(datactx, encfunc, &S, &CC, &T);
=20
         /* Cm =3D first length % XTS_BLOCK_SIZE bytes of CC */
         for (i =3D 0; i < mo; i++) {
@@ -194,7 +225,8 @@ void xts_encrypt(const void *datactx,
         }
=20
         /* Cm-1 =3D Tweak encrypt PP */
-        xts_tweak_encdec(datactx, encfunc, PP.b, dst, T.b);
+        xts_tweak_encdec(datactx, encfunc, &PP, &D, &T);
+        memcpy(dst, &D, XTS_BLOCK_SIZE);
     }
=20
     /* Decrypt the iv back */
--=20
2.17.2
