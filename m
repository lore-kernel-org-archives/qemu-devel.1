Received: from eggs.gnu.org ([2001:4830:134:3::10]:43961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1g9rYN-0000Xi-8D
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 08:56:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1g9rYL-0004E3-K5
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 08:55:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1g9rYL-0004BB-B6
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 08:55:57 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue,  9 Oct 2018 13:55:38 +0100
Message-Id: <20181009125541.24455-4-berrange@redhat.com>
In-Reply-To: <20181009125541.24455-1-berrange@redhat.com>
References: <20181009125541.24455-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/6] crypto: introduce a xts_uint128 data type
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

The new type is designed to allow use of 64-bit arithmetic instead
of operating 1-byte at a time. The following patches will use this to
improve performance.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 crypto/xts.c | 45 +++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/crypto/xts.c b/crypto/xts.c
index 3c1a92f01d..ded4365191 100644
--- a/crypto/xts.c
+++ b/crypto/xts.c
@@ -26,6 +26,11 @@
 #include "qemu/osdep.h"
 #include "crypto/xts.h"
=20
+typedef struct {
+    uint64_t a;
+    uint64_t b;
+} xts_uint128;
+
 static void xts_mult_x(uint8_t *I)
 {
     int x;
@@ -85,7 +90,7 @@ void xts_decrypt(const void *datactx,
                  uint8_t *dst,
                  const uint8_t *src)
 {
-    uint8_t PP[XTS_BLOCK_SIZE], CC[XTS_BLOCK_SIZE], T[XTS_BLOCK_SIZE];
+    xts_uint128 PP, CC, T;
     unsigned long i, m, mo, lim;
=20
     /* get number of blocks */
@@ -102,10 +107,10 @@ void xts_decrypt(const void *datactx,
     }
=20
     /* encrypt the iv */
-    encfunc(tweakctx, XTS_BLOCK_SIZE, T, iv);
+    encfunc(tweakctx, XTS_BLOCK_SIZE, (uint8_t *)&T, iv);
=20
     for (i =3D 0; i < lim; i++) {
-        xts_tweak_encdec(datactx, decfunc, src, dst, T);
+        xts_tweak_encdec(datactx, decfunc, src, dst, (uint8_t *)&T);
=20
         src +=3D XTS_BLOCK_SIZE;
         dst +=3D XTS_BLOCK_SIZE;
@@ -113,27 +118,27 @@ void xts_decrypt(const void *datactx,
=20
     /* if length is not a multiple of XTS_BLOCK_SIZE then */
     if (mo > 0) {
-        memcpy(CC, T, XTS_BLOCK_SIZE);
-        xts_mult_x(CC);
+        memcpy(&CC, &T, XTS_BLOCK_SIZE);
+        xts_mult_x((uint8_t *)&CC);
=20
         /* PP =3D tweak decrypt block m-1 */
-        xts_tweak_encdec(datactx, decfunc, src, PP, CC);
+        xts_tweak_encdec(datactx, decfunc, src, (uint8_t *)&PP, (uint8_t=
 *)&CC);
=20
         /* Pm =3D first length % XTS_BLOCK_SIZE bytes of PP */
         for (i =3D 0; i < mo; i++) {
-            CC[i] =3D src[XTS_BLOCK_SIZE + i];
-            dst[XTS_BLOCK_SIZE + i] =3D PP[i];
+            ((uint8_t *)&CC)[i] =3D src[XTS_BLOCK_SIZE + i];
+            dst[XTS_BLOCK_SIZE + i] =3D ((uint8_t *)&PP)[i];
         }
         for (; i < XTS_BLOCK_SIZE; i++) {
-            CC[i] =3D PP[i];
+            ((uint8_t *)&CC)[i] =3D ((uint8_t *)&PP)[i];
         }
=20
         /* Pm-1 =3D Tweak uncrypt CC */
-        xts_tweak_encdec(datactx, decfunc, CC, dst, T);
+        xts_tweak_encdec(datactx, decfunc, (uint8_t *)&CC, dst, (uint8_t=
 *)&T);
     }
=20
     /* Decrypt the iv back */
-    decfunc(tweakctx, XTS_BLOCK_SIZE, iv, T);
+    decfunc(tweakctx, XTS_BLOCK_SIZE, iv, (uint8_t *)&T);
 }
=20
=20
@@ -146,7 +151,7 @@ void xts_encrypt(const void *datactx,
                  uint8_t *dst,
                  const uint8_t *src)
 {
-    uint8_t PP[XTS_BLOCK_SIZE], CC[XTS_BLOCK_SIZE], T[XTS_BLOCK_SIZE];
+    xts_uint128 PP, CC, T;
     unsigned long i, m, mo, lim;
=20
     /* get number of blocks */
@@ -163,10 +168,10 @@ void xts_encrypt(const void *datactx,
     }
=20
     /* encrypt the iv */
-    encfunc(tweakctx, XTS_BLOCK_SIZE, T, iv);
+    encfunc(tweakctx, XTS_BLOCK_SIZE, (uint8_t *)&T, iv);
=20
     for (i =3D 0; i < lim; i++) {
-        xts_tweak_encdec(datactx, encfunc, src, dst, T);
+        xts_tweak_encdec(datactx, encfunc, src, dst, (uint8_t *)&T);
=20
         dst +=3D XTS_BLOCK_SIZE;
         src +=3D XTS_BLOCK_SIZE;
@@ -175,22 +180,22 @@ void xts_encrypt(const void *datactx,
     /* if length is not a multiple of XTS_BLOCK_SIZE then */
     if (mo > 0) {
         /* CC =3D tweak encrypt block m-1 */
-        xts_tweak_encdec(datactx, encfunc, src, CC, T);
+        xts_tweak_encdec(datactx, encfunc, src, (uint8_t *)&CC, (uint8_t=
 *)&T);
=20
         /* Cm =3D first length % XTS_BLOCK_SIZE bytes of CC */
         for (i =3D 0; i < mo; i++) {
-            PP[i] =3D src[XTS_BLOCK_SIZE + i];
-            dst[XTS_BLOCK_SIZE + i] =3D CC[i];
+            ((uint8_t *)&PP)[i] =3D src[XTS_BLOCK_SIZE + i];
+            dst[XTS_BLOCK_SIZE + i] =3D ((uint8_t *)&CC)[i];
         }
=20
         for (; i < XTS_BLOCK_SIZE; i++) {
-            PP[i] =3D CC[i];
+            ((uint8_t *)&PP)[i] =3D ((uint8_t *)&CC)[i];
         }
=20
         /* Cm-1 =3D Tweak encrypt PP */
-        xts_tweak_encdec(datactx, encfunc, PP, dst, T);
+        xts_tweak_encdec(datactx, encfunc, (uint8_t *)&PP, dst, (uint8_t=
 *)&T);
     }
=20
     /* Decrypt the iv back */
-    decfunc(tweakctx, XTS_BLOCK_SIZE, iv, T);
+    decfunc(tweakctx, XTS_BLOCK_SIZE, iv, (uint8_t *)&T);
 }
--=20
2.17.1
