Received: from eggs.gnu.org ([2001:4830:134:3::10]:44751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cEXzI-0007zL-3b
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 03:54:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cEXzD-0006v8-NU
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 03:54:04 -0500
Received: from [45.249.212.187] (port=2491 helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cEXzC-0006rT-Ic
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 03:53:59 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Wed, 7 Dec 2016 08:52:48 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA155BFA@DGGEMA505-MBX.china.huawei.com>
References: <1481099622-188132-1-git-send-email-longpeng2@huawei.com>
	<1481099622-188132-2-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1481099622-188132-2-git-send-email-longpeng2@huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH for-2.9 1/2] crypto: add 3des-ede support
 when using libgcrypt/nettle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: longpeng <longpeng2@huawei.com>, "berrange@redhat.com" <berrange@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Wubin (H)" <wu.wubin@huawei.com>, "Zhoujian (jay, Euler)" <jianjay.zhou@huawei.com>

> -----Original Message-----
> From: longpeng
> Sent: Wednesday, December 07, 2016 4:34 PM
> To: berrange@redhat.com; eblake@redhat.com; armbru@redhat.com;
> Gonglei (Arei)
> Cc: qemu-devel@nongnu.org; Wubin (H); Zhoujian (jay, Euler); longpeng
> Subject: [PATCH for-2.9 1/2] crypto: add 3des-ede support when using
> libgcrypt/nettle
>=20
> Libgcrypt and nettle support 3des-ede, so this patch add 3des-ede
> support when using libgcrypt or nettle.
>=20
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
>  crypto/cipher-gcrypt.c     |  6 ++++++
>  crypto/cipher-nettle.c     | 37
> +++++++++++++++++++++++++++++++++++++
>  crypto/cipher.c            |  7 +++++--
>  qapi/crypto.json           |  3 ++-
>  tests/test-crypto-cipher.c | 44
> ++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 94 insertions(+), 3 deletions(-)
>=20
> diff --git a/crypto/cipher-gcrypt.c b/crypto/cipher-gcrypt.c
> index c550db9..5dd0db1 100644
> --- a/crypto/cipher-gcrypt.c
> +++ b/crypto/cipher-gcrypt.c
> @@ -29,6 +29,7 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgorithm
> alg,
>  {
>      switch (alg) {
>      case QCRYPTO_CIPHER_ALG_DES_RFB:
> +    case QCRYPTO_CIPHER_ALG_3DES_EDE:
>      case QCRYPTO_CIPHER_ALG_AES_128:
>      case QCRYPTO_CIPHER_ALG_AES_192:
>      case QCRYPTO_CIPHER_ALG_AES_256:
> @@ -99,6 +100,10 @@ QCryptoCipher
> *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
>          gcryalg =3D GCRY_CIPHER_DES;
>          break;
>=20
> +    case QCRYPTO_CIPHER_ALG_3DES_EDE:
> +        gcryalg =3D GCRY_CIPHER_3DES;
> +        break;
> +
>      case QCRYPTO_CIPHER_ALG_AES_128:
>          gcryalg =3D GCRY_CIPHER_AES128;
>          break;
> @@ -200,6 +205,7 @@ QCryptoCipher
> *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
>          case QCRYPTO_CIPHER_ALG_TWOFISH_256:
>              ctx->blocksize =3D 16;
>              break;
> +        case QCRYPTO_CIPHER_ALG_3DES_EDE:
>          case QCRYPTO_CIPHER_ALG_CAST5_128:
>              ctx->blocksize =3D 8;
>              break;
> diff --git a/crypto/cipher-nettle.c b/crypto/cipher-nettle.c
> index cd094cd..0353b4d 100644
> --- a/crypto/cipher-nettle.c
> +++ b/crypto/cipher-nettle.c
> @@ -78,6 +78,18 @@ static void des_decrypt_native(cipher_ctx_t ctx,
> cipher_length_t length,
>      des_decrypt(ctx, length, dst, src);
>  }
>=20
> +static void des3_encrypt_native(cipher_ctx_t ctx, cipher_length_t length=
,
> +                                uint8_t *dst, const uint8_t *src)
> +{
> +    des3_encrypt(ctx, length, dst, src);
> +}
> +
> +static void des3_decrypt_native(cipher_ctx_t ctx, cipher_length_t length=
,
> +                                uint8_t *dst, const uint8_t *src)
> +{
> +    des3_decrypt(ctx, length, dst, src);
> +}
> +
>  static void cast128_encrypt_native(cipher_ctx_t ctx, cipher_length_t len=
gth,
>                                     uint8_t *dst, const uint8_t *src)
>  {
> @@ -140,6 +152,18 @@ static void des_decrypt_wrapper(const void *ctx,
> size_t length,
>      des_decrypt(ctx, length, dst, src);
>  }
>=20
> +static void des3_encrypt_wrapper(const void *ctx, size_t length,
> +                                uint8_t *dst, const uint8_t *src)
> +{
> +    des3_encrypt(ctx, length, dst, src);
> +}
> +
> +static void des3_decrypt_wrapper(const void *ctx, size_t length,
> +                                uint8_t *dst, const uint8_t *src)
> +{
> +    des3_decrypt(ctx, length, dst, src);
> +}
> +
>  static void cast128_encrypt_wrapper(const void *ctx, size_t length,
>                                      uint8_t *dst, const uint8_t *src)
>  {
> @@ -197,6 +221,7 @@ bool
> qcrypto_cipher_supports(QCryptoCipherAlgorithm alg,
>  {
>      switch (alg) {
>      case QCRYPTO_CIPHER_ALG_DES_RFB:
> +    case QCRYPTO_CIPHER_ALG_3DES_EDE:
>      case QCRYPTO_CIPHER_ALG_AES_128:
>      case QCRYPTO_CIPHER_ALG_AES_192:
>      case QCRYPTO_CIPHER_ALG_AES_256:
> @@ -270,6 +295,18 @@ QCryptoCipher
> *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
>          ctx->blocksize =3D DES_BLOCK_SIZE;
>          break;
>=20
> +    case QCRYPTO_CIPHER_ALG_3DES_EDE:
> +        ctx->ctx =3D g_new0(struct des3_ctx, 1);
> +        des3_set_key(ctx->ctx, key);
> +
> +        ctx->alg_encrypt_native =3D des3_encrypt_native;
> +        ctx->alg_decrypt_native =3D des3_decrypt_native;
> +        ctx->alg_encrypt_wrapper =3D des3_encrypt_wrapper;
> +        ctx->alg_decrypt_wrapper =3D des3_decrypt_wrapper;
> +
> +        ctx->blocksize =3D DES3_BLOCK_SIZE;
> +        break;
> +
>      case QCRYPTO_CIPHER_ALG_AES_128:
>      case QCRYPTO_CIPHER_ALG_AES_192:
>      case QCRYPTO_CIPHER_ALG_AES_256:
> diff --git a/crypto/cipher.c b/crypto/cipher.c
> index a9bca41..97147b1 100644
> --- a/crypto/cipher.c
> +++ b/crypto/cipher.c
> @@ -28,6 +28,7 @@ static size_t alg_key_len[QCRYPTO_CIPHER_ALG__MAX]
> =3D {
>      [QCRYPTO_CIPHER_ALG_AES_192] =3D 24,
>      [QCRYPTO_CIPHER_ALG_AES_256] =3D 32,
>      [QCRYPTO_CIPHER_ALG_DES_RFB] =3D 8,
> +    [QCRYPTO_CIPHER_ALG_3DES_EDE] =3D 24,
>      [QCRYPTO_CIPHER_ALG_CAST5_128] =3D 16,
>      [QCRYPTO_CIPHER_ALG_SERPENT_128] =3D 16,
>      [QCRYPTO_CIPHER_ALG_SERPENT_192] =3D 24,
> @@ -42,6 +43,7 @@ static size_t
> alg_block_len[QCRYPTO_CIPHER_ALG__MAX] =3D {
>      [QCRYPTO_CIPHER_ALG_AES_192] =3D 16,
>      [QCRYPTO_CIPHER_ALG_AES_256] =3D 16,
>      [QCRYPTO_CIPHER_ALG_DES_RFB] =3D 8,
> +    [QCRYPTO_CIPHER_ALG_3DES_EDE] =3D 8,
>      [QCRYPTO_CIPHER_ALG_CAST5_128] =3D 8,
>      [QCRYPTO_CIPHER_ALG_SERPENT_128] =3D 16,
>      [QCRYPTO_CIPHER_ALG_SERPENT_192] =3D 16,
> @@ -107,8 +109,9 @@
> qcrypto_cipher_validate_key_length(QCryptoCipherAlgorithm alg,
>      }
>=20
>      if (mode =3D=3D QCRYPTO_CIPHER_MODE_XTS) {
> -        if (alg =3D=3D QCRYPTO_CIPHER_ALG_DES_RFB) {
> -            error_setg(errp, "XTS mode not compatible with DES-RFB");
> +        if (alg =3D=3D QCRYPTO_CIPHER_ALG_DES_RFB
> +                || alg =3D=3D QCRYPTO_CIPHER_ALG_3DES_EDE) {
> +            error_setg(errp, "XTS mode not compatible with
> DES-RFB/3DES-EDE");
>              return false;
>          }
>          if (nkey % 2) {
> diff --git a/qapi/crypto.json b/qapi/crypto.json
> index 5c9d7d4..848b6cd 100644
> --- a/qapi/crypto.json
> +++ b/qapi/crypto.json
> @@ -63,6 +63,7 @@
>  # @aes-192: AES with 192 bit / 24 byte keys
>  # @aes-256: AES with 256 bit / 32 byte keys
>  # @des-rfb: RFB specific variant of single DES. Do not use except in VNC=
.
> +# @3des-ede: 3DES-EDE with 192 bit / 24 byte keys

Missing since 2.9 here.

>  # @cast5-128: Cast5 with 128 bit / 16 byte keys
>  # @serpent-128: Serpent with 128 bit / 16 byte keys
>  # @serpent-192: Serpent with 192 bit / 24 byte keys
> @@ -75,7 +76,7 @@
>  { 'enum': 'QCryptoCipherAlgorithm',
>    'prefix': 'QCRYPTO_CIPHER_ALG',
>    'data': ['aes-128', 'aes-192', 'aes-256',
> -           'des-rfb',
> +           'des-rfb', '3des-ede',
>             'cast5-128',
>             'serpent-128', 'serpent-192', 'serpent-256',
>             'twofish-128', 'twofish-192', 'twofish-256']}
> diff --git a/tests/test-crypto-cipher.c b/tests/test-crypto-cipher.c
> index 5d9e535..8874b61 100644
> --- a/tests/test-crypto-cipher.c
> +++ b/tests/test-crypto-cipher.c
> @@ -165,6 +165,50 @@ static QCryptoCipherTestData test_data[] =3D {
>              "ffd29f1bb5596ad94ea2d8e6196b7f09"
>              "30d8ed0bf2773af36dd82a6280c20926",
>      },
> +#if defined(CONFIG_NETTLE) || defined(CONFIG_GCRYPT)
> +    {
> +        /* Borrowed from linux-kernel crypto/testmgr.h */
> +        .path =3D "/crypto/cipher/3des-ede-cbc",
> +        .alg =3D QCRYPTO_CIPHER_ALG_3DES_EDE,
> +        .mode =3D QCRYPTO_CIPHER_MODE_CBC,
> +        .key =3D
> +            "e9c0ff2e760b6424444d995a12d640c0"
> +            "eac284e81495dbe8",
> +        .iv =3D
> +            "7d3388930f93b242",
> +        .plaintext =3D
> +            "6f54206f614d796e5320636565727374"
> +            "54206f6f4d206e612079655372637465"
> +            "20736f54206f614d796e532063656572"
> +            "737454206f6f4d206e61207965537263"
> +            "746520736f54206f614d796e53206365"
> +            "6572737454206f6f4d206e6120796553"
> +            "7263746520736f54206f614d796e5320"
> +            "63656572737454206f6f4d206e610a79",
> +        .ciphertext =3D
> +            "0e2db6973c5633f4671721c76e8ad549"
> +            "74b34905c51cd0ed12565c5396b6007d"
> +            "9048fcf58d2939cc8ad5351836234ed7"
> +            "76d1da0c9467bb048bf2036ca8cfb6ea"
> +            "226447aa8f7513bf9fc2c3f0c956c57a"
> +            "71632e897b1e12cae25fafd8a4f8c97a"
> +            "d6f92131624445a6d6bc5ad32d5443cc"
> +            "9ddea570e942458a6bfab19113b0d919",
> +    },
> +    {
> +        /* Borrowed from linux-kernel crypto/testmgr.h */
> +        .path =3D "/crypto/cipher/3des-ede-ecb",
> +        .alg =3D QCRYPTO_CIPHER_ALG_3DES_EDE,
> +        .mode =3D QCRYPTO_CIPHER_MODE_ECB,
> +        .key =3D
> +            "0123456789abcdef5555555555555555"
> +            "fedcba9876543210",
> +        .plaintext =3D
> +            "736f6d6564617461",
> +        .ciphertext =3D
> +            "18d748e563620572",
> +    },
> +#endif

Pls adds the CTR mode test case as well.

You'd better split the patch set into two patches so that Denial can take t=
his one.
and I can take the patch 2.

Thanks for your work.

-Gonglei

>      {
>          /* RFC 2144, Appendix B.1 */
>          .path =3D "/crypto/cipher/cast5-128",
> --
> 1.8.3.1
>=20
