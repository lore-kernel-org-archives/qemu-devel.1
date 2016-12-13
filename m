Received: from eggs.gnu.org ([2001:4830:134:3::10]:42932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cGjTu-00015i-Tu
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 04:34:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cGjTr-0005X9-6E
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 04:34:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cGjTr-0005Wf-0s
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 04:34:39 -0500
Date: Tue, 13 Dec 2016 09:34:31 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20161213093431.GD12730@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1481612513-28556-1-git-send-email-longpeng2@huawei.com>
	<1481612513-28556-5-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1481612513-28556-5-git-send-email-longpeng2@huawei.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 v3 4/6] crypto: support HMAC
 algorithms based on glibc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Cc: wu.wubin@huawei.com, jianjay.zhou@huawei.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org

On Tue, Dec 13, 2016 at 03:01:51PM +0800, Longpeng(Mike) wrote:
> This patch add glibc-backed HMAC algorithms support

s/glibc/glib/  and also in $SUBJECT

> diff --git a/crypto/hmac-glib.c b/crypto/hmac-glib.c
> index 3e2a933..f07c841 100644
> --- a/crypto/hmac-glib.c
> +++ b/crypto/hmac-glib.c
> @@ -16,8 +16,40 @@
>  #include "qapi/error.h"
>  #include "crypto/hmac.h"
>  
> +static int qcrypto_hmac_alg_map[QCRYPTO_HASH_ALG__MAX] = {
> +/* Support for HMAC Algos has been added in GLib 2.30 */
> +#if GLIB_CHECK_VERSION(2, 30, 0)
> +    [QCRYPTO_HASH_ALG_MD5] = G_CHECKSUM_MD5,
> +    [QCRYPTO_HASH_ALG_SHA1] = G_CHECKSUM_SHA1,
> +    [QCRYPTO_HASH_ALG_SHA256] = G_CHECKSUM_SHA256,
> +#else
> +    [QCRYPTO_HASH_ALG_MD5] = -1,
> +    [QCRYPTO_HASH_ALG_SHA1] = -1,
> +    [QCRYPTO_HASH_ALG_SHA256] = -1,
> +#endif
> +/* Support for HMAC SHA-512 in GLib 2.42 */
> +#if GLIB_CHECK_VERSION(2, 42, 0)
> +    [QCRYPTO_HASH_ALG_SHA512] = G_CHECKSUM_SHA512,
> +#else
> +    [QCRYPTO_HASH_ALG_SHA512] = -1,
> +#endif
> +    [QCRYPTO_HASH_ALG_SHA224] = -1,
> +    [QCRYPTO_HASH_ALG_SHA384] = -1,
> +    [QCRYPTO_HASH_ALG_RIPEMD160] = -1,
> +};

As mentioned in reply to the build failure - the 2.30.0 check
will have to surround the entire file...

> +
> +typedef struct QCryptoHmacGlib QCryptoHmacGlib;
> +struct QCryptoHmacGlib {
> +    GHmac *ghmac;

...otherwise this triggers failure due to missing typedefs.


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
