Received: from eggs.gnu.org ([2001:4830:134:3::10]:46587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gUrIw-0005xe-4C
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 05:54:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gUrIr-0008Lb-90
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 05:54:48 -0500
Date: Thu, 6 Dec 2018 10:54:30 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181206105430.GN29540@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181205144700.26563-1-vsementsov@virtuozzo.com>
	<20181205144700.26563-6-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181205144700.26563-6-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v2 5/5] crypto: support multiple threads
 accessing one QCryptoBlock
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

On Wed, Dec 05, 2018 at 05:47:00PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> The two thing that should be handled are cipher and ivgen. For ivgen
> the solution is just mutex, as iv calculations should not be long in
> comparison with encryption/decryption. And for cipher let's just keep
> per-thread ciphers.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  crypto/blockpriv.h        |  16 ++++-
>  include/crypto/block.h    |   3 +
>  block/crypto.c            |   1 +
>  block/qcow.c              |   2 +-
>  block/qcow2.c             |   4 +-
>  crypto/block-luks.c       |  25 +++----
>  crypto/block-qcow.c       |  20 +++---
>  crypto/block.c            | 146 +++++++++++++++++++++++++++++++++-----
>  tests/test-crypto-block.c |   3 +
>  9 files changed, 176 insertions(+), 44 deletions(-)
> 
> diff --git a/crypto/blockpriv.h b/crypto/blockpriv.h
> index e9fe3e5687..86dae49210 100644
> --- a/crypto/blockpriv.h
> +++ b/crypto/blockpriv.h
> @@ -22,6 +22,7 @@
>  #define QCRYPTO_BLOCKPRIV_H
>  
>  #include "crypto/block.h"
> +#include "qemu/thread.h"
>  
>  typedef struct QCryptoBlockDriver QCryptoBlockDriver;
>  
> @@ -31,8 +32,12 @@ struct QCryptoBlock {
>      const QCryptoBlockDriver *driver;
>      void *opaque;
>  
> -    QCryptoCipher *cipher;
> +    QCryptoCipher **ciphers;
> +    int n_ciphers;
> +    int n_free_ciphers;

size_t for both of these since they're effectively array indexes.

>      QCryptoIVGen *ivgen;
> +    QemuMutex mutex;
> +
>      QCryptoHashAlgorithm kdfhash;
>      size_t niv;
>      uint64_t payload_offset; /* In bytes */
> @@ -46,6 +51,7 @@ struct QCryptoBlockDriver {
>                  QCryptoBlockReadFunc readfunc,
>                  void *opaque,
>                  unsigned int flags,
> +                int n_threads,

unsigned int, and more below which I won't repeat...


> diff --git a/include/crypto/block.h b/include/crypto/block.h
> index cd18f46d56..866a89b06a 100644
> --- a/include/crypto/block.h
> +++ b/include/crypto/block.h
> @@ -75,6 +75,8 @@ typedef enum {
>   * @readfunc: callback for reading data from the volume
>   * @opaque: data to pass to @readfunc
>   * @flags: bitmask of QCryptoBlockOpenFlags values
> + * @n_threads: prepare block to multi tasking with up to
> + *             @n_threads threads

The description is a little awkward, Lets say

  @n_threads: allow concurrent I/O from up to @n_threads threads


> diff --git a/crypto/block-luks.c b/crypto/block-luks.c
> index bbffd80fff..41fb0aa2e7 100644
> --- a/crypto/block-luks.c
> +++ b/crypto/block-luks.c
> @@ -863,7 +863,7 @@ qcrypto_block_luks_open(QCryptoBlock *block,
>  
>   fail:
>      g_free(masterkey);
> -    qcrypto_cipher_free(block->cipher);
> +    qcrypto_block_free_cipher(block);
>      qcrypto_ivgen_free(block->ivgen);
>      g_free(luks);
>      g_free(password);
> @@ -888,6 +888,7 @@ qcrypto_block_luks_create(QCryptoBlock *block,
>                            void *opaque,
>                            Error **errp)
>  {
> +    int ret;
>      QCryptoBlockLUKS *luks;
>      QCryptoBlockCreateOptionsLUKS luks_opts;
>      Error *local_err = NULL;
> @@ -1030,11 +1031,11 @@ qcrypto_block_luks_create(QCryptoBlock *block,
>  
>  
>      /* Setup the block device payload encryption objects */
> -    block->cipher = qcrypto_cipher_new(luks_opts.cipher_alg,
> -                                       luks_opts.cipher_mode,
> -                                       masterkey, luks->header.key_bytes,
> -                                       errp);
> -    if (!block->cipher) {
> +    ret = qcrypto_block_init_cipher(block, luks_opts.cipher_alg,
> +                                    luks_opts.cipher_mode,
> +                                    masterkey, luks->header.key_bytes,
> +                                    1, errp);
> +    if (ret < 0) {

No need for ret, since we're only using it for a failure check. Just
put the method call in the if ().

> diff --git a/crypto/block.c b/crypto/block.c
> index 3edd9ec251..43426268e6 100644
> --- a/crypto/block.c
> +++ b/crypto/block.c
> @@ -52,10 +52,13 @@ QCryptoBlock *qcrypto_block_open(QCryptoBlockOpenOptions *options,
>                                   QCryptoBlockReadFunc readfunc,
>                                   void *opaque,
>                                   unsigned int flags,
> +                                 int n_threads,
>                                   Error **errp)
>  {
>      QCryptoBlock *block = g_new0(QCryptoBlock, 1);
>  
> +    qemu_mutex_init(&block->mutex);

We need a corresponding qemu_mutex_destroy() when free'ing the QCryptoBlock.

> @@ -148,12 +154,94 @@ int qcrypto_block_encrypt(QCryptoBlock *block,
>  
>  QCryptoCipher *qcrypto_block_get_cipher(QCryptoBlock *block)
>  {
> -    return block->cipher;
> +    /* ivgen should be accessed under mutex. However, this function is used only
> +     * in test with one thread, so it's enough to assert it here:
> +     */

Comment is wrong since this is about ciphers, not ivgen.

> +    assert(block->n_ciphers <= 1);
> +    return block->ciphers ? block->ciphers[0] : NULL;
>  }
>  
>  
> +static QCryptoCipher *qcrypto_block_pop_cipher(QCryptoBlock *block)
> +{
> +    QCryptoCipher *cipher;
> +
> +    qemu_mutex_lock(&block->mutex);
> +
> +    assert(block->n_free_ciphers > 0);
> +    block->n_free_ciphers--;
> +    cipher = block->ciphers[block->n_free_ciphers];
> +
> +    qemu_mutex_unlock(&block->mutex);
> +
> +    return cipher;
> +}
> +
> +
> +static void qcrypto_block_push_cipher(QCryptoBlock *block,
> +                                      QCryptoCipher *cipher)
> +{
> +    qemu_mutex_lock(&block->mutex);
> +
> +    assert(block->n_free_ciphers < block->n_ciphers);
> +    block->ciphers[block->n_free_ciphers] = cipher;
> +    block->n_free_ciphers++;
> +
> +    qemu_mutex_unlock(&block->mutex);
> +}
> +
> +
> +int qcrypto_block_init_cipher(QCryptoBlock *block,
> +                              QCryptoCipherAlgorithm alg,
> +                              QCryptoCipherMode mode,
> +                              const uint8_t *key, size_t nkey,
> +                              int n_threads, Error **errp)
> +{
> +    int i;

size_t for loop indexes

> +
> +    assert(!block->ciphers && !block->n_ciphers && !block->n_free_ciphers);
> +
> +    block->ciphers = g_new0(QCryptoCipher *, n_threads);
> +
> +    for (i = 0; i < n_threads; i++) {
> +        block->ciphers[i] = qcrypto_cipher_new(alg, mode, key, nkey, errp);
> +        if (!block->ciphers[i]) {
> +            qcrypto_block_free_cipher(block);
> +            return -1;
> +        }
> +        block->n_ciphers++;
> +        block->n_free_ciphers++;
> +    }
> +
> +    return 0;
> +}


> @@ -199,6 +287,7 @@ typedef int (*QCryptoCipherEncryptFunc)(QCryptoCipher *cipher,
>  static int do_qcrypto_cipher_encrypt(QCryptoCipher *cipher,
>                                       size_t niv,
>                                       QCryptoIVGen *ivgen,
> +                                     QemuMutex *ivgen_mutex,
>                                       int sectorsize,
>                                       uint64_t offset,
>                                       uint8_t *buf,
> @@ -218,10 +307,15 @@ static int do_qcrypto_cipher_encrypt(QCryptoCipher *cipher,
>      while (len > 0) {
>          size_t nbytes;
>          if (niv) {
> -            if (qcrypto_ivgen_calculate(ivgen,
> -                                        startsector,
> -                                        iv, niv,
> -                                        errp) < 0) {
> +            if (ivgen_mutex) {
> +                qemu_mutex_lock(ivgen_mutex);
> +            }
> +            ret = qcrypto_ivgen_calculate(ivgen, startsector, iv, niv, errp);
> +            if (ivgen_mutex) {
> +                qemu_mutex_unlock(ivgen_mutex);
> +            }

I think we should just make  ivgen_mutex compulsory....

> +
> +            if (ret < 0) {
>                  goto cleanup;
>              }
>  
> @@ -258,8 +352,9 @@ int qcrypto_cipher_decrypt_helper(QCryptoCipher *cipher,
>                                    size_t len,
>                                    Error **errp)
>  {
> -    return do_qcrypto_cipher_encrypt(cipher, niv, ivgen, sectorsize, offset,
> -                                     buf, len, qcrypto_cipher_decrypt, errp);
> +    return do_qcrypto_cipher_encrypt(cipher, niv, ivgen, NULL, sectorsize,
> +                                     offset, buf, len, qcrypto_cipher_decrypt,
> +                                     errp);
>  }
>  
>  
> @@ -272,11 +367,11 @@ int qcrypto_cipher_encrypt_helper(QCryptoCipher *cipher,
>                                    size_t len,
>                                    Error **errp)
>  {
> -    return do_qcrypto_cipher_encrypt(cipher, niv, ivgen, sectorsize, offset,
> -                                     buf, len, qcrypto_cipher_encrypt, errp);
> +    return do_qcrypto_cipher_encrypt(cipher, niv, ivgen, NULL, sectorsize,
> +                                     offset, buf, len, qcrypto_cipher_encrypt,
> +                                     errp);
>  }

...and get the mutex passed into these functions, as its easier to just
know the ivgen is always protected, and not have to trace back the callpath
to see if the usage is safe.

>  
> -
>  int qcrypto_block_decrypt_helper(QCryptoBlock *block,
>                                   int sectorsize,
>                                   uint64_t offset,
> @@ -284,11 +379,17 @@ int qcrypto_block_decrypt_helper(QCryptoBlock *block,
>                                   size_t len,
>                                   Error **errp)
>  {
> -    return do_qcrypto_cipher_encrypt(block->cipher, block->niv, block->ivgen,
> -                                     sectorsize, offset, buf, len,
> -                                     qcrypto_cipher_decrypt, errp);
> -}
> +    int ret;
> +    QCryptoCipher *cipher = qcrypto_block_pop_cipher(block);
> +
> +    ret = do_qcrypto_cipher_encrypt(cipher, block->niv, block->ivgen,
> +                                    &block->mutex, sectorsize, offset, buf, len,
> +                                    qcrypto_cipher_decrypt, errp);
> +
> +    qcrypto_block_push_cipher(block, cipher);
>  
> +    return ret;
> +}
>  
>  int qcrypto_block_encrypt_helper(QCryptoBlock *block,
>                                   int sectorsize,
> @@ -297,7 +398,14 @@ int qcrypto_block_encrypt_helper(QCryptoBlock *block,
>                                   size_t len,
>                                   Error **errp)
>  {
> -    return do_qcrypto_cipher_encrypt(block->cipher, block->niv, block->ivgen,
> -                                     sectorsize, offset, buf, len,
> -                                     qcrypto_cipher_encrypt, errp);
> +    int ret;
> +    QCryptoCipher *cipher = qcrypto_block_pop_cipher(block);
> +
> +    ret = do_qcrypto_cipher_encrypt(cipher, block->niv, block->ivgen,
> +                                    &block->mutex, sectorsize, offset, buf, len,
> +                                    qcrypto_cipher_encrypt, errp);
> +
> +    qcrypto_block_push_cipher(block, cipher);
> +
> +    return ret;
>  }

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
