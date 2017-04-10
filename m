Received: from eggs.gnu.org ([2001:4830:134:3::10]:44990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cxWAs-00061R-Ke
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 06:03:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cxWAo-0002p6-Vo
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 06:03:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cxWAo-0002ou-QD
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 06:03:50 -0400
Date: Mon, 10 Apr 2017 11:03:45 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170410100345.GD3655@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1491814786-60036-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1491814786-60036-1-git-send-email-longpeng2@huawei.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 05/19] crypto: cipher: add cipher
 driver framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Cc: xuquan8@huawei.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org

On Mon, Apr 10, 2017 at 04:59:46PM +0800, Longpeng(Mike) wrote:
> 1) makes the public APIs in cipher-nettle/gcrypt/builtin static,
>    and rename them with "nettle/gcrypt/builtin" prefix.
> 
> 2) introduces cipher framework, including QCryptoCipherDriver
>    and new public APIs.
> 
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
>  crypto/cipher-builtin.c | 59 +++++++++++++++++--------------------------------
>  crypto/cipher-gcrypt.c  | 58 +++++++++++++++++-------------------------------
>  crypto/cipher-nettle.c  | 59 +++++++++++++++++--------------------------------
>  crypto/cipher.c         | 59 +++++++++++++++++++++++++++++++++++++++++++++++++
>  include/crypto/cipher.h | 22 ++++++++++++++++++
>  5 files changed, 141 insertions(+), 116 deletions(-)
> 

> diff --git a/include/crypto/cipher.h b/include/crypto/cipher.h
> index bec9f41..32b6065 100644
> --- a/include/crypto/cipher.h
> +++ b/include/crypto/cipher.h
> @@ -23,6 +23,7 @@
>  
>  #include "qapi-types.h"
>  
> +typedef struct QCryptoCipherDriver QCryptoCipherDriver;
>  typedef struct QCryptoCipher QCryptoCipher;
>  
>  /* See also "QCryptoCipherAlgorithm" and "QCryptoCipherMode"
> @@ -76,7 +77,28 @@ typedef struct QCryptoCipher QCryptoCipher;
>   *
>   */
>  
> +struct QCryptoCipherDriver {
> +    int (*cipher_encrypt)(QCryptoCipher *cipher,
> +                          const void *in,
> +                          void *out,
> +                          size_t len,
> +                          Error **errp);
> +
> +    int (*cipher_decrypt)(QCryptoCipher *cipher,
> +                          const void *in,
> +                          void *out,
> +                          size_t len,
> +                          Error **errp);
> +
> +    int (*cipher_setiv)(QCryptoCipher *cipher,
> +                        const uint8_t *iv, size_t niv,
> +                        Error **errp);
> +
> +    void (*cipher_free)(QCryptoCipher *cipher);
> +};

Please put this in a crypto/cipherpriv.h header file, since it is
not something we want to expose to the rest of QEMU source code.


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
