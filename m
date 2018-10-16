Received: from eggs.gnu.org ([2001:4830:134:3::10]:44832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gCMIA-0002x7-W4
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:09:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gCMI8-0006Lq-M0
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:09:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gCMI7-0006Hn-2B
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:09:31 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue, 16 Oct 2018 11:09:15 +0100
Message-Id: <20181016100918.21030-6-berrange@redhat.com>
In-Reply-To: <20181016100918.21030-1-berrange@redhat.com>
References: <20181016100918.21030-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 5/8] crypto: convert xts_mult_x to use
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

  Encrypt: 355 MB/s -> 545 MB/s
  Decrypt: 362 MB/s -> 568 MB/s

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 crypto/xts.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/crypto/xts.c b/crypto/xts.c
index 2e3430672c..56c0e4e6ed 100644
--- a/crypto/xts.c
+++ b/crypto/xts.c
@@ -24,6 +24,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/bswap.h"
 #include "crypto/xts.h"
=20
 typedef union {
@@ -39,19 +40,33 @@ static inline void xts_uint128_xor(xts_uint128 *D,
     D->u[1] =3D S1->u[1] ^ S2->u[1];
 }
=20
-static void xts_mult_x(uint8_t *I)
+static inline void xts_uint128_cpu_to_les(xts_uint128 *v)
 {
-    int x;
-    uint8_t t, tt;
+    cpu_to_le64s(&v->u[0]);
+    cpu_to_le64s(&v->u[1]);
+}
=20
-    for (x =3D t =3D 0; x < 16; x++) {
-        tt =3D I[x] >> 7;
-        I[x] =3D ((I[x] << 1) | t) & 0xFF;
-        t =3D tt;
-    }
-    if (tt) {
-        I[0] ^=3D 0x87;
+static inline void xts_uint128_le_to_cpus(xts_uint128 *v)
+{
+    le64_to_cpus(&v->u[0]);
+    le64_to_cpus(&v->u[1]);
+}
+
+static void xts_mult_x(xts_uint128 *I)
+{
+    uint64_t tt;
+
+    xts_uint128_cpu_to_les(I);
+
+    tt =3D I->u[0] >> 63;
+    I->u[0] =3D I->u[0] << 1;
+
+    if (I->u[1] >> 63) {
+        I->u[0] ^=3D 0x87;
     }
+    I->u[1] =3D (I->u[1] << 1) | tt;
+
+    xts_uint128_le_to_cpus(I);
 }
=20
=20
@@ -79,7 +94,7 @@ static void xts_tweak_encdec(const void *ctx,
     xts_uint128_xor(dst, dst, iv);
=20
     /* LFSR the tweak */
-    xts_mult_x(iv->b);
+    xts_mult_x(iv);
 }
=20
=20
@@ -134,7 +149,7 @@ void xts_decrypt(const void *datactx,
     if (mo > 0) {
         xts_uint128 S, D;
         memcpy(&CC, &T, XTS_BLOCK_SIZE);
-        xts_mult_x(CC.b);
+        xts_mult_x(&CC);
=20
         /* PP =3D tweak decrypt block m-1 */
         memcpy(&S, src, XTS_BLOCK_SIZE);
--=20
2.17.2
