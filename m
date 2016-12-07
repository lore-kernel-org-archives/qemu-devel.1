Received: from eggs.gnu.org ([2001:4830:134:3::10]:54304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cEYf1-0006zK-OM
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 04:37:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cEYf0-00035x-BY
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 04:37:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cEYf0-00035j-3t
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 04:37:10 -0500
Date: Wed, 7 Dec 2016 09:37:02 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20161207093702.GD21167@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1481099622-188132-1-git-send-email-longpeng2@huawei.com>
	<1481099622-188132-2-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1481099622-188132-2-git-send-email-longpeng2@huawei.com>
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
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Cc: eblake@redhat.com, armbru@redhat.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org, wu.wubin@huawei.com, jianjay.zhou@huawei.com

On Wed, Dec 07, 2016 at 04:33:41PM +0800, Longpeng(Mike) wrote:
> Libgcrypt and nettle support 3des-ede, so this patch add 3des-ede
> support when using libgcrypt or nettle.
> 
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
>  crypto/cipher-gcrypt.c     |  6 ++++++
>  crypto/cipher-nettle.c     | 37 +++++++++++++++++++++++++++++++++++++
>  crypto/cipher.c            |  7 +++++--
>  qapi/crypto.json           |  3 ++-
>  tests/test-crypto-cipher.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 94 insertions(+), 3 deletions(-)
> 
> diff --git a/crypto/cipher-gcrypt.c b/crypto/cipher-gcrypt.c
> index c550db9..5dd0db1 100644
> --- a/crypto/cipher-gcrypt.c
> +++ b/crypto/cipher-gcrypt.c
> @@ -29,6 +29,7 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgorithm alg,
>  {
>      switch (alg) {
>      case QCRYPTO_CIPHER_ALG_DES_RFB:
> +    case QCRYPTO_CIPHER_ALG_3DES_EDE:
>      case QCRYPTO_CIPHER_ALG_AES_128:
>      case QCRYPTO_CIPHER_ALG_AES_192:
>      case QCRYPTO_CIPHER_ALG_AES_256:
> @@ -99,6 +100,10 @@ QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
>          gcryalg = GCRY_CIPHER_DES;
>          break;
>  
> +    case QCRYPTO_CIPHER_ALG_3DES_EDE:
> +        gcryalg = GCRY_CIPHER_3DES;
> +        break;
> +
>      case QCRYPTO_CIPHER_ALG_AES_128:
>          gcryalg = GCRY_CIPHER_AES128;
>          break;
> @@ -200,6 +205,7 @@ QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
>          case QCRYPTO_CIPHER_ALG_TWOFISH_256:
>              ctx->blocksize = 16;
>              break;
> +        case QCRYPTO_CIPHER_ALG_3DES_EDE:
>          case QCRYPTO_CIPHER_ALG_CAST5_128:
>              ctx->blocksize = 8;
>              break;
> diff --git a/crypto/cipher-nettle.c b/crypto/cipher-nettle.c
> index cd094cd..0353b4d 100644
> --- a/crypto/cipher-nettle.c
> +++ b/crypto/cipher-nettle.c
> @@ -78,6 +78,18 @@ static void des_decrypt_native(cipher_ctx_t ctx, cipher_length_t length,
>      des_decrypt(ctx, length, dst, src);
>  }
>  
> +static void des3_encrypt_native(cipher_ctx_t ctx, cipher_length_t length,
> +                                uint8_t *dst, const uint8_t *src)
> +{
> +    des3_encrypt(ctx, length, dst, src);
> +}
> +
> +static void des3_decrypt_native(cipher_ctx_t ctx, cipher_length_t length,
> +                                uint8_t *dst, const uint8_t *src)
> +{
> +    des3_decrypt(ctx, length, dst, src);
> +}
> +
>  static void cast128_encrypt_native(cipher_ctx_t ctx, cipher_length_t length,
>                                     uint8_t *dst, const uint8_t *src)
>  {
> @@ -140,6 +152,18 @@ static void des_decrypt_wrapper(const void *ctx, size_t length,
>      des_decrypt(ctx, length, dst, src);
>  }
>  
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
> @@ -197,6 +221,7 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgorithm alg,
>  {
>      switch (alg) {
>      case QCRYPTO_CIPHER_ALG_DES_RFB:
> +    case QCRYPTO_CIPHER_ALG_3DES_EDE:
>      case QCRYPTO_CIPHER_ALG_AES_128:
>      case QCRYPTO_CIPHER_ALG_AES_192:
>      case QCRYPTO_CIPHER_ALG_AES_256:
> @@ -270,6 +295,18 @@ QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
>          ctx->blocksize = DES_BLOCK_SIZE;
>          break;
>  
> +    case QCRYPTO_CIPHER_ALG_3DES_EDE:
> +        ctx->ctx = g_new0(struct des3_ctx, 1);
> +        des3_set_key(ctx->ctx, key);
> +
> +        ctx->alg_encrypt_native = des3_encrypt_native;
> +        ctx->alg_decrypt_native = des3_decrypt_native;
> +        ctx->alg_encrypt_wrapper = des3_encrypt_wrapper;
> +        ctx->alg_decrypt_wrapper = des3_decrypt_wrapper;
> +
> +        ctx->blocksize = DES3_BLOCK_SIZE;
> +        break;
> +
>      case QCRYPTO_CIPHER_ALG_AES_128:
>      case QCRYPTO_CIPHER_ALG_AES_192:
>      case QCRYPTO_CIPHER_ALG_AES_256:
> diff --git a/crypto/cipher.c b/crypto/cipher.c
> index a9bca41..97147b1 100644
> --- a/crypto/cipher.c
> +++ b/crypto/cipher.c
> @@ -28,6 +28,7 @@ static size_t alg_key_len[QCRYPTO_CIPHER_ALG__MAX] = {
>      [QCRYPTO_CIPHER_ALG_AES_192] = 24,
>      [QCRYPTO_CIPHER_ALG_AES_256] = 32,
>      [QCRYPTO_CIPHER_ALG_DES_RFB] = 8,
> +    [QCRYPTO_CIPHER_ALG_3DES_EDE] = 24,
>      [QCRYPTO_CIPHER_ALG_CAST5_128] = 16,
>      [QCRYPTO_CIPHER_ALG_SERPENT_128] = 16,
>      [QCRYPTO_CIPHER_ALG_SERPENT_192] = 24,
> @@ -42,6 +43,7 @@ static size_t alg_block_len[QCRYPTO_CIPHER_ALG__MAX] = {
>      [QCRYPTO_CIPHER_ALG_AES_192] = 16,
>      [QCRYPTO_CIPHER_ALG_AES_256] = 16,
>      [QCRYPTO_CIPHER_ALG_DES_RFB] = 8,
> +    [QCRYPTO_CIPHER_ALG_3DES_EDE] = 8,
>      [QCRYPTO_CIPHER_ALG_CAST5_128] = 8,
>      [QCRYPTO_CIPHER_ALG_SERPENT_128] = 16,
>      [QCRYPTO_CIPHER_ALG_SERPENT_192] = 16,
> @@ -107,8 +109,9 @@ qcrypto_cipher_validate_key_length(QCryptoCipherAlgorithm alg,
>      }
>  
>      if (mode == QCRYPTO_CIPHER_MODE_XTS) {
> -        if (alg == QCRYPTO_CIPHER_ALG_DES_RFB) {
> -            error_setg(errp, "XTS mode not compatible with DES-RFB");
> +        if (alg == QCRYPTO_CIPHER_ALG_DES_RFB
> +                || alg == QCRYPTO_CIPHER_ALG_3DES_EDE) {
> +            error_setg(errp, "XTS mode not compatible with DES-RFB/3DES-EDE");
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
>  # @des-rfb: RFB specific variant of single DES. Do not use except in VNC.
> +# @3des-ede: 3DES-EDE with 192 bit / 24 byte keys

Lets just call this '3des' as 'ede' is can be assumed, eg

    # @3des: 3DES (EDE) with 192 bit / 24 byte keys


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
