Received: from eggs.gnu.org ([2001:4830:134:3::10]:43998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1g9rYV-0000c0-7X
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 08:56:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1g9rYP-0004Gp-BQ
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 08:56:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1g9rYP-0004EY-4C
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 08:56:01 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue,  9 Oct 2018 13:55:40 +0100
Message-Id: <20181009125541.24455-6-berrange@redhat.com>
In-Reply-To: <20181009125541.24455-1-berrange@redhat.com>
References: <20181009125541.24455-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 5/6] crypto: convert xts_mult_x to use
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

  Encrypt: 320 MB/s -> 460 MB/s
  Decrypt: 325 MB/s -> 485 MB/s

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 crypto/xts.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/crypto/xts.c b/crypto/xts.c
index f109c8a3ee..bba3280746 100644
--- a/crypto/xts.c
+++ b/crypto/xts.c
@@ -37,19 +37,17 @@ typedef struct {
         (D)->b =3D (S1)->b ^ (S2)->b;             \
     } while (0)
=20
-static void xts_mult_x(uint8_t *I)
+static void xts_mult_x(xts_uint128 *I)
 {
-    int x;
-    uint8_t t, tt;
+    uint64_t tt;
=20
-    for (x =3D t =3D 0; x < 16; x++) {
-        tt =3D I[x] >> 7;
-        I[x] =3D ((I[x] << 1) | t) & 0xFF;
-        t =3D tt;
-    }
-    if (tt) {
-        I[0] ^=3D 0x87;
+    tt =3D I->a >> 63;
+    I->a =3D I->a << 1;
+
+    if (I->b >> 63) {
+        I->a ^=3D 0x87;
     }
+    I->b =3D (I->b << 1) | tt;
 }
=20
=20
@@ -77,7 +75,7 @@ static void xts_tweak_encdec(const void *ctx,
     xts_uint128_xor(dst, dst, iv);
=20
     /* LFSR the tweak */
-    xts_mult_x((uint8_t *)iv);
+    xts_mult_x(iv);
 }
=20
=20
@@ -124,7 +122,7 @@ void xts_decrypt(const void *datactx,
     if (mo > 0) {
         xts_uint128 S, D;
         memcpy(&CC, &T, XTS_BLOCK_SIZE);
-        xts_mult_x((uint8_t *)&CC);
+        xts_mult_x(&CC);
=20
         /* PP =3D tweak decrypt block m-1 */
         memcpy(&S, src, XTS_BLOCK_SIZE);
--=20
2.17.1
