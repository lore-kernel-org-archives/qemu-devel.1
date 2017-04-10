Received: from eggs.gnu.org ([2001:4830:134:3::10]:46278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cxWDE-0007PV-K8
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 06:06:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cxWDA-0003mk-OP
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 06:06:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cxWDA-0003mH-IX
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 06:06:16 -0400
Date: Mon, 10 Apr 2017 11:06:09 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170410100609.GF3655@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1491814833-62792-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1491814833-62792-1-git-send-email-longpeng2@huawei.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 11/19] crypto: hmac: add hmac
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

On Mon, Apr 10, 2017 at 05:00:33PM +0800, Longpeng(Mike) wrote:
> 1) makes the public APIs in hmac-nettle/gcrypt/glib static,
>    and rename them with "nettle/gcrypt/glib" prefix.
> 
> 2) introduces hmac framework, including QCryptoHmacDriver
>    and new public APIs.
> 
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
>  crypto/hmac-gcrypt.c  | 48 +++++++++++------------------------
>  crypto/hmac-glib.c    | 70 ++++++++++++++++++---------------------------------
>  crypto/hmac-nettle.c  | 49 +++++++++++-------------------------
>  crypto/hmac.c         | 39 ++++++++++++++++++++++++++++
>  include/crypto/hmac.h | 20 +++++++++++++++
>  5 files changed, 112 insertions(+), 114 deletions(-)
> 

> diff --git a/include/crypto/hmac.h b/include/crypto/hmac.h
> index 0d3acd7..6f63eb8 100644
> --- a/include/crypto/hmac.h
> +++ b/include/crypto/hmac.h
> @@ -14,12 +14,32 @@
>  
>  #include "qapi-types.h"
>  
> +typedef struct QCryptoHmacDriver QCryptoHmacDriver;
>  typedef struct QCryptoHmac QCryptoHmac;
> +
>  struct QCryptoHmac {
> +    QCryptoHmacDriver *driver;
>      QCryptoHashAlgorithm alg;
>      void *opaque;
>  };
>  
> +struct QCryptoHmacDriver {
> +    int (*hmac_bytesv)(QCryptoHmac *hmac,
> +                       const struct iovec *iov,
> +                       size_t niov,
> +                       uint8_t **result,
> +                       size_t *resultlen,
> +                       Error **errp);
> +
> +    void (*hmac_free)(QCryptoHmac *hmac);
> +};
> +
> +extern void *qcrypto_hmac_ctx_new(QCryptoHashAlgorithm alg,
> +                                  const uint8_t *key, size_t nkey,
> +                                  Error **errp);
> +extern QCryptoHmacDriver qcrypto_hmac_lib_driver;

Again, we want to have  a crypto/hmacpriv.h header file for this stuff.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
