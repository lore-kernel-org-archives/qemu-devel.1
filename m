Received: from eggs.gnu.org ([2001:4830:134:3::10]:53764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cJhzv-0004lt-I4
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 09:36:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cJhzr-0006dL-FQ
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 09:36:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cJhzr-0006d1-95
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 09:35:59 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed, 21 Dec 2016 14:35:35 +0000
Message-Id: <20161221143541.9260-2-berrange@redhat.com>
In-Reply-To: <20161221143541.9260-1-berrange@redhat.com>
References: <20161221143541.9260-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 1/7] cipher: fix leak on initialization error
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
