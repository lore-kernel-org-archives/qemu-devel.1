Received: from eggs.gnu.org ([2001:4830:134:3::10]:44791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gCMI9-0002uq-1z
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:09:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gCMI5-0006Gm-Cm
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:09:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gCMI3-0006AG-Cl
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:09:29 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue, 16 Oct 2018 11:09:12 +0100
Message-Id: <20181016100918.21030-3-berrange@redhat.com>
In-Reply-To: <20181016100918.21030-1-berrange@redhat.com>
References: <20181016100918.21030-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/8] crypto: remove code duplication in
 tweak encrypt/decrypt
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

The tweak encrypt/decrypt functions are identical except for the
comments, so can be merged. Profiling data shows that the compiler is
in fact already merging the two merges in the object files.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 crypto/xts.c | 64 ++++++++++++----------------------------------------
 1 file changed, 15 insertions(+), 49 deletions(-)

diff --git a/crypto/xts.c b/crypto/xts.c
index 95212341f6..3c1a92f01d 100644
--- a/crypto/xts.c
+++ b/crypto/xts.c
@@ -43,20 +43,20 @@ static void xts_mult_x(uint8_t *I)
=20
=20
 /**
- * xts_tweak_uncrypt:
+ * xts_tweak_encdec:
  * @param ctxt: the cipher context
  * @param func: the cipher function
- * @src: buffer providing the cipher text of XTS_BLOCK_SIZE bytes
- * @dst: buffer to output the plain text of XTS_BLOCK_SIZE bytes
+ * @src: buffer providing the input text of XTS_BLOCK_SIZE bytes
+ * @dst: buffer to output the output text of XTS_BLOCK_SIZE bytes
  * @iv: the initialization vector tweak of XTS_BLOCK_SIZE bytes
  *
- * Decrypt data with a tweak
+ * Encrypt/decrypt data with a tweak
  */
-static void xts_tweak_decrypt(const void *ctx,
-                              xts_cipher_func *func,
-                              const uint8_t *src,
-                              uint8_t *dst,
-                              uint8_t *iv)
+static void xts_tweak_encdec(const void *ctx,
+                             xts_cipher_func *func,
+                             const uint8_t *src,
+                             uint8_t *dst,
+                             uint8_t *iv)
 {
     unsigned long x;
=20
@@ -105,7 +105,7 @@ void xts_decrypt(const void *datactx,
     encfunc(tweakctx, XTS_BLOCK_SIZE, T, iv);
=20
     for (i =3D 0; i < lim; i++) {
-        xts_tweak_decrypt(datactx, decfunc, src, dst, T);
+        xts_tweak_encdec(datactx, decfunc, src, dst, T);
=20
         src +=3D XTS_BLOCK_SIZE;
         dst +=3D XTS_BLOCK_SIZE;
@@ -117,7 +117,7 @@ void xts_decrypt(const void *datactx,
         xts_mult_x(CC);
=20
         /* PP =3D tweak decrypt block m-1 */
-        xts_tweak_decrypt(datactx, decfunc, src, PP, CC);
+        xts_tweak_encdec(datactx, decfunc, src, PP, CC);
=20
         /* Pm =3D first length % XTS_BLOCK_SIZE bytes of PP */
         for (i =3D 0; i < mo; i++) {
@@ -129,7 +129,7 @@ void xts_decrypt(const void *datactx,
         }
=20
         /* Pm-1 =3D Tweak uncrypt CC */
-        xts_tweak_decrypt(datactx, decfunc, CC, dst, T);
+        xts_tweak_encdec(datactx, decfunc, CC, dst, T);
     }
=20
     /* Decrypt the iv back */
@@ -137,40 +137,6 @@ void xts_decrypt(const void *datactx,
 }
=20
=20
-/**
- * xts_tweak_crypt:
- * @param ctxt: the cipher context
- * @param func: the cipher function
- * @src: buffer providing the plain text of XTS_BLOCK_SIZE bytes
- * @dst: buffer to output the cipher text of XTS_BLOCK_SIZE bytes
- * @iv: the initialization vector tweak of XTS_BLOCK_SIZE bytes
- *
- * Encrypt data with a tweak
- */
-static void xts_tweak_encrypt(const void *ctx,
-                              xts_cipher_func *func,
-                              const uint8_t *src,
-                              uint8_t *dst,
-                              uint8_t *iv)
-{
-    unsigned long x;
-
-    /* tweak encrypt block i */
-    for (x =3D 0; x < XTS_BLOCK_SIZE; x++) {
-        dst[x] =3D src[x] ^ iv[x];
-    }
-
-    func(ctx, XTS_BLOCK_SIZE, dst, dst);
-
-    for (x =3D 0; x < XTS_BLOCK_SIZE; x++) {
-        dst[x] =3D dst[x] ^ iv[x];
-    }
-
-    /* LFSR the tweak */
-    xts_mult_x(iv);
-}
-
-
 void xts_encrypt(const void *datactx,
                  const void *tweakctx,
                  xts_cipher_func *encfunc,
@@ -200,7 +166,7 @@ void xts_encrypt(const void *datactx,
     encfunc(tweakctx, XTS_BLOCK_SIZE, T, iv);
=20
     for (i =3D 0; i < lim; i++) {
-        xts_tweak_encrypt(datactx, encfunc, src, dst, T);
+        xts_tweak_encdec(datactx, encfunc, src, dst, T);
=20
         dst +=3D XTS_BLOCK_SIZE;
         src +=3D XTS_BLOCK_SIZE;
@@ -209,7 +175,7 @@ void xts_encrypt(const void *datactx,
     /* if length is not a multiple of XTS_BLOCK_SIZE then */
     if (mo > 0) {
         /* CC =3D tweak encrypt block m-1 */
-        xts_tweak_encrypt(datactx, encfunc, src, CC, T);
+        xts_tweak_encdec(datactx, encfunc, src, CC, T);
=20
         /* Cm =3D first length % XTS_BLOCK_SIZE bytes of CC */
         for (i =3D 0; i < mo; i++) {
@@ -222,7 +188,7 @@ void xts_encrypt(const void *datactx,
         }
=20
         /* Cm-1 =3D Tweak encrypt PP */
-        xts_tweak_encrypt(datactx, encfunc, PP, dst, T);
+        xts_tweak_encdec(datactx, encfunc, PP, dst, T);
     }
=20
     /* Decrypt the iv back */
--=20
2.17.2
