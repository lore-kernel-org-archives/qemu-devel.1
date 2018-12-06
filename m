Received: from eggs.gnu.org ([2001:4830:134:3::10]:34260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gUr3M-0001gB-GM
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 05:38:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gUr16-0008Fv-7V
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 05:36:28 -0500
Date: Thu, 6 Dec 2018 10:36:03 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181206103603.GK29540@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181205144700.26563-1-vsementsov@virtuozzo.com>
	<20181205144700.26563-3-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181205144700.26563-3-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/5] crypto/block: refactor
 qcrypto_block_*crypt_helper functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

On Wed, Dec 05, 2018 at 05:46:57PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> qcrypto_block_encrypt_helper and qcrypto_block_decrypt_helper are
> almost identical, let's reduce code duplication and simplify further
> improvements.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  crypto/block.c | 81 +++++++++++++++++++-------------------------------
>  1 file changed, 31 insertions(+), 50 deletions(-)
> 
> diff --git a/crypto/block.c b/crypto/block.c
> index e59d1140fe..f4101f0841 100644
> --- a/crypto/block.c
> +++ b/crypto/block.c
> @@ -190,14 +190,21 @@ void qcrypto_block_free(QCryptoBlock *block)
>  }
>  
>  
> -int qcrypto_block_decrypt_helper(QCryptoCipher *cipher,
> -                                 size_t niv,
> -                                 QCryptoIVGen *ivgen,
> -                                 int sectorsize,
> -                                 uint64_t offset,
> -                                 uint8_t *buf,
> -                                 size_t len,
> -                                 Error **errp)
> +typedef int (*QCryptoCipherEncryptFunc)(QCryptoCipher *cipher,
> +                                        const void *in,
> +                                        void *out,
> +                                        size_t len,
> +                                        Error **errp);
> +
> +static int do_qcrypto_block_encrypt(QCryptoCipher *cipher,

Can we call this functuon 'encdec', since it is misleading to call
it just 'encrypt' when its used for decrypt too.

> +                                    size_t niv,
> +                                    QCryptoIVGen *ivgen,
> +                                    int sectorsize,
> +                                    uint64_t offset,
> +                                    uint8_t *buf,
> +                                    size_t len,
> +                                    QCryptoCipherEncryptFunc func,

And call this 'EncDecFunc' too

> +                                    Error **errp)
>  {
>      uint8_t *iv;
>      int ret = -1;
> @@ -226,8 +233,7 @@ int qcrypto_block_decrypt_helper(QCryptoCipher *cipher,
>          }
>  
>          nbytes = len > sectorsize ? sectorsize : len;
> -        if (qcrypto_cipher_decrypt(cipher, buf, buf,
> -                                   nbytes, errp) < 0) {
> +        if (func(cipher, buf, buf, nbytes, errp) < 0) {
>              goto cleanup;
>          }
>  
> @@ -243,7 +249,7 @@ int qcrypto_block_decrypt_helper(QCryptoCipher *cipher,
>  }
>  
>  
> -int qcrypto_block_encrypt_helper(QCryptoCipher *cipher,
> +int qcrypto_block_decrypt_helper(QCryptoCipher *cipher,
>                                   size_t niv,
>                                   QCryptoIVGen *ivgen,
>                                   int sectorsize,
> @@ -252,45 +258,20 @@ int qcrypto_block_encrypt_helper(QCryptoCipher *cipher,
>                                   size_t len,
>                                   Error **errp)
>  {
> -    uint8_t *iv;
> -    int ret = -1;
> -    uint64_t startsector = offset / sectorsize;
> -
> -    assert(QEMU_IS_ALIGNED(offset, sectorsize));
> -    assert(QEMU_IS_ALIGNED(len, sectorsize));
> -
> -    iv = niv ? g_new0(uint8_t, niv) : NULL;
> -
> -    while (len > 0) {
> -        size_t nbytes;
> -        if (niv) {
> -            if (qcrypto_ivgen_calculate(ivgen,
> -                                        startsector,
> -                                        iv, niv,
> -                                        errp) < 0) {
> -                goto cleanup;
> -            }
> -
> -            if (qcrypto_cipher_setiv(cipher,
> -                                     iv, niv,
> -                                     errp) < 0) {
> -                goto cleanup;
> -            }
> -        }
> -
> -        nbytes = len > sectorsize ? sectorsize : len;
> -        if (qcrypto_cipher_encrypt(cipher, buf, buf,
> -                                   nbytes, errp) < 0) {
> -            goto cleanup;
> -        }
> +    return do_qcrypto_block_encrypt(cipher, niv, ivgen, sectorsize, offset,
> +                                    buf, len, qcrypto_cipher_decrypt, errp);
> +}
>  
> -        startsector++;
> -        buf += nbytes;
> -        len -= nbytes;
> -    }
>  
> -    ret = 0;
> - cleanup:
> -    g_free(iv);
> -    return ret;
> +int qcrypto_block_encrypt_helper(QCryptoCipher *cipher,
> +                                 size_t niv,
> +                                 QCryptoIVGen *ivgen,
> +                                 int sectorsize,
> +                                 uint64_t offset,
> +                                 uint8_t *buf,
> +                                 size_t len,
> +                                 Error **errp)
> +{
> +    return do_qcrypto_block_encrypt(cipher, niv, ivgen, sectorsize, offset,
> +                                    buf, len, qcrypto_cipher_encrypt, errp);
>  }
> -- 
> 2.18.0
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
