Received: from eggs.gnu.org ([2001:4830:134:3::10]:36568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cK0ub-0004h4-Gg
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 05:47:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cK0ua-00068M-IW
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 05:47:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cK0ua-000683-CH
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 05:47:48 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 22 Dec 2016 10:47:33 +0000
Message-Id: <20161222104740.19606-2-berrange@redhat.com>
In-Reply-To: <20161222104740.19606-1-berrange@redhat.com>
References: <20161222104740.19606-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 1/8] cipher: fix leak on initialization error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

On error path, ctx may be leaked. Assign ctx earlier, and call
qcrypto_cipher_free() on error.

Spotted thanks to ASAN.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 crypto/cipher-nettle.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/crypto/cipher-nettle.c b/crypto/cipher-nettle.c
index cd094cd..5798910 100644
--- a/crypto/cipher-nettle.c
+++ b/crypto/cipher-nettle.c
@@ -254,6 +254,7 @@ QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgori=
thm alg,
     cipher->mode =3D mode;
=20
     ctx =3D g_new0(QCryptoCipherNettle, 1);
+    cipher->opaque =3D ctx;
=20
     switch (alg) {
     case QCRYPTO_CIPHER_ALG_DES_RFB:
@@ -384,13 +385,11 @@ QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgo=
rithm alg,
     }
=20
     ctx->iv =3D g_new0(uint8_t, ctx->blocksize);
-    cipher->opaque =3D ctx;
=20
     return cipher;
=20
  error:
-    g_free(cipher);
-    g_free(ctx);
+    qcrypto_cipher_free(cipher);
     return NULL;
 }
=20
--=20
2.9.3
