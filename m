Received: from eggs.gnu.org ([2001:4830:134:3::10]:39055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gUr53-0004NF-Fu
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 05:40:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gUr4y-0005qX-W7
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 05:40:29 -0500
Date: Thu, 6 Dec 2018 10:39:14 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181206103914.GL29540@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181205144700.26563-1-vsementsov@virtuozzo.com>
	<20181205144700.26563-4-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181205144700.26563-4-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/5] crypto/block: rename
 qcrypto_block_*crypt_helper
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

On Wed, Dec 05, 2018 at 05:46:58PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Rename qcrypto_block_*crypt_helper to qcrypto_cipher_*crypt_helper, as
> it's not about QCryptoBlock. This is needed to introduce
> qcrypto_block_*crypt_helper in the next commit, which will have
> QCryptoBlock pointer and than will be able to use additional fields of
> it, which in turn will be used to implement thread-safe QCryptoBlock
> operations.

The naming convention I'm following is that methods defined in a file
should all use the name of the file as their prefix. Hence everything
in crypto/block.* should be named with a qcrypto_block_ prefix

> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  crypto/blockpriv.h  | 34 +++++++++++++-------------
>  crypto/block-luks.c | 44 +++++++++++++++++-----------------
>  crypto/block-qcow.c | 16 ++++++-------
>  crypto/block.c      | 58 ++++++++++++++++++++++-----------------------
>  4 files changed, 76 insertions(+), 76 deletions(-)
> 
> diff --git a/crypto/blockpriv.h b/crypto/blockpriv.h
> index 41840abcec..347a7c010a 100644
> --- a/crypto/blockpriv.h
> +++ b/crypto/blockpriv.h
> @@ -78,22 +78,22 @@ struct QCryptoBlockDriver {
>  };
>  
>  
> -int qcrypto_block_decrypt_helper(QCryptoCipher *cipher,
> -                                 size_t niv,
> -                                 QCryptoIVGen *ivgen,
> -                                 int sectorsize,
> -                                 uint64_t offset,
> -                                 uint8_t *buf,
> -                                 size_t len,
> -                                 Error **errp);
> -
> -int qcrypto_block_encrypt_helper(QCryptoCipher *cipher,
> -                                 size_t niv,
> -                                 QCryptoIVGen *ivgen,
> -                                 int sectorsize,
> -                                 uint64_t offset,
> -                                 uint8_t *buf,
> -                                 size_t len,
> -                                 Error **errp);
> +int qcrypto_cipher_decrypt_helper(QCryptoCipher *cipher,
> +                                  size_t niv,
> +                                  QCryptoIVGen *ivgen,
> +                                  int sectorsize,
> +                                  uint64_t offset,
> +                                  uint8_t *buf,
> +                                  size_t len,
> +                                  Error **errp);
> +
> +int qcrypto_cipher_encrypt_helper(QCryptoCipher *cipher,
> +                                  size_t niv,
> +                                  QCryptoIVGen *ivgen,
> +                                  int sectorsize,
> +                                  uint64_t offset,
> +                                  uint8_t *buf,
> +                                  size_t len,
> +                                  Error **errp);

Rather than dropping 'block' from the method name, just add
'cipher'. eg

  qcrypto_block_cipher_decrypt_helper
  qcrypto_block_cipher_encrypt_helper


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
