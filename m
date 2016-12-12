Received: from eggs.gnu.org ([2001:4830:134:3::10]:60091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cGNr0-0000qa-MM
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:29:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cGNqw-0000Vv-Ve
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:29:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cGNqw-0000Vh-Mj
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:29:02 -0500
Date: Mon, 12 Dec 2016 10:28:56 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20161212102856.GF15611@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1481530092-20240-1-git-send-email-longpeng2@huawei.com>
	<1481530092-20240-7-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1481530092-20240-7-git-send-email-longpeng2@huawei.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 v2 6/7] crypto: support HMAC
 algorithms based on nettle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Cc: eblake@redhat.com, armbru@redhat.com, stefanha@redhat.com, wu.wubin@huawei.com, jianjay.zhou@huawei.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org

On Mon, Dec 12, 2016 at 04:08:11PM +0800, Longpeng(Mike) wrote:
> This patch add nettle-backed HMAC algorithms support
> 
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
>  crypto/hmac-nettle.c | 118 +++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 115 insertions(+), 3 deletions(-)
> 
> diff --git a/crypto/hmac-nettle.c b/crypto/hmac-nettle.c
> index 7a9cd2e..a082bc0 100644
> --- a/crypto/hmac-nettle.c
> +++ b/crypto/hmac-nettle.c
> @@ -15,9 +15,66 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "crypto/hmac.h"
> +#include <nettle/hmac.h>
> +
> +typedef void (*qcrypto_nettle_hmac_setkey)(void *ctx,
> +        size_t key_length, const uint8_t *key);
> +
> +typedef void (*qcrypto_nettle_hmac_update)(void *ctx,
> +        size_t length, const uint8_t *data);
> +
> +typedef void (*qcrypto_nettle_hmac_digest)(void *ctx,
> +        size_t length, uint8_t *digest);
> +
> +typedef struct QCryptoHmacNettle QCryptoHmacNettle;
> +struct QCryptoHmacNettle {
> +    union qcrypto_nettle_hmac_ctx {
> +        struct hmac_md5_ctx md5_ctx;
> +        struct hmac_sha1_ctx sha1_ctx;
> +        struct hmac_sha256_ctx sha256_ctx;
> +        struct hmac_sha512_ctx sha512_ctx;
> +    } u;
> +};
> +
> +struct qcrypto_nettle_hmac_alg {
> +    qcrypto_nettle_hmac_setkey setkey;
> +    qcrypto_nettle_hmac_update update;
> +    qcrypto_nettle_hmac_digest digest;
> +    size_t len;
> +} qcrypto_hmac_alg_map[QCRYPTO_HMAC_ALG__MAX] = {
> +    [QCRYPTO_HMAC_ALG_MD5] = {
> +        .setkey = (qcrypto_nettle_hmac_setkey)hmac_md5_set_key,
> +        .update = (qcrypto_nettle_hmac_update)hmac_md5_update,
> +        .digest = (qcrypto_nettle_hmac_digest)hmac_md5_digest,
> +        .len = MD5_DIGEST_SIZE,
> +    },
> +    [QCRYPTO_HMAC_ALG_SHA1] = {
> +        .setkey = (qcrypto_nettle_hmac_setkey)hmac_sha1_set_key,
> +        .update = (qcrypto_nettle_hmac_update)hmac_sha1_update,
> +        .digest = (qcrypto_nettle_hmac_digest)hmac_sha1_digest,
> +        .len = SHA1_DIGEST_SIZE,
> +    },
> +    [QCRYPTO_HMAC_ALG_SHA256] = {
> +        .setkey = (qcrypto_nettle_hmac_setkey)hmac_sha256_set_key,
> +        .update = (qcrypto_nettle_hmac_update)hmac_sha256_update,
> +        .digest = (qcrypto_nettle_hmac_digest)hmac_sha256_digest,
> +        .len = SHA256_DIGEST_SIZE,
> +    },
> +    [QCRYPTO_HMAC_ALG_SHA512] = {
> +        .setkey = (qcrypto_nettle_hmac_setkey)hmac_sha512_set_key,
> +        .update = (qcrypto_nettle_hmac_update)hmac_sha512_update,
> +        .digest = (qcrypto_nettle_hmac_digest)hmac_sha512_digest,
> +        .len = SHA512_DIGEST_SIZE,
> +    },
> +};

Can you implement all 7 hash algorithms supported by QEMU.


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
