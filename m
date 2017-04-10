Received: from eggs.gnu.org ([2001:4830:134:3::10]:45284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cxWBf-0006U4-SN
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 06:04:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cxWBc-0002yO-Qi
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 06:04:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cxWBc-0002xz-LB
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 06:04:40 -0400
Date: Mon, 10 Apr 2017 11:04:34 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170410100434.GE3655@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1491814793-56832-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1491814793-56832-1-git-send-email-longpeng2@huawei.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 06/19] crypto: hash: add hash
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

On Mon, Apr 10, 2017 at 04:59:53PM +0800, Longpeng(Mike) wrote:
> 1) makes the public APIs in hash-nettle/gcrypt/glib static,
>    and rename them with "nettle/gcrypt/glib" prefix.
> 
> 2) introduces hash framework, including QCryptoHashDriver
>    and new public APIs.
> 
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
>  crypto/hash-gcrypt.c  | 17 +++++++++++------
>  crypto/hash-glib.c    | 17 +++++++++++------
>  crypto/hash-nettle.c  | 17 +++++++++++------
>  crypto/hash.c         | 12 ++++++++++++
>  include/crypto/hash.h | 12 ++++++++++++
>  5 files changed, 57 insertions(+), 18 deletions(-)
> 

> diff --git a/include/crypto/hash.h b/include/crypto/hash.h
> index ca3267f..00b764e 100644
> --- a/include/crypto/hash.h
> +++ b/include/crypto/hash.h
> @@ -25,6 +25,18 @@
>  
>  /* See also "QCryptoHashAlgorithm" defined in qapi/crypto.json */
>  
> +typedef struct QCryptoHashDriver QCryptoHashDriver;
> +struct QCryptoHashDriver {
> +    int (*hash_bytesv)(QCryptoHashAlgorithm alg,
> +                       const struct iovec *iov,
> +                       size_t niov,
> +                       uint8_t **result,
> +                       size_t *resultlen,
> +                       Error **errp);
> +};
> +
> +extern QCryptoHashDriver qcrypto_hash_lib_driver;

This should be in a crypto/hashpriv.h header file, since again it is not
something we want exposed.


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
