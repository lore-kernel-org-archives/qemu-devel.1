Received: from eggs.gnu.org ([2001:4830:134:3::10]:53558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dmePQ-0002Y3-6v
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 07:10:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dmePM-000431-Vg
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 07:10:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dmePM-00042Y-MT
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 07:10:12 -0400
Date: Tue, 29 Aug 2017 12:10:04 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170829111004.GH3783@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1503564371-26090-1-git-send-email-armbru@redhat.com>
	<1503564371-26090-10-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1503564371-26090-10-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 09/16] crypto: Use qapi_enum_parse() in
 qcrypto_block_luks_name_lookup()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

On Thu, Aug 24, 2017 at 10:46:04AM +0200, Markus Armbruster wrote:
> Cc: "Daniel P. Berrange" <berrange@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  crypto/block-luks.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)

Acked-by: Daniel P. Berrange <berrange@redhat.com>

> 
> diff --git a/crypto/block-luks.c b/crypto/block-luks.c
> index afb8543..c3cacdb 100644
> --- a/crypto/block-luks.c
> +++ b/crypto/block-luks.c
> @@ -20,6 +20,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> +#include "qapi/util.h"
>  #include "qemu/bswap.h"
>  
>  #include "crypto/block-luks.h"
> @@ -265,39 +266,33 @@ qcrypto_block_luks_cipher_alg_lookup(QCryptoCipherAlgorithm alg,
>   * make that function emit a more friendly error message */
>  static int qcrypto_block_luks_name_lookup(const char *name,
>                                            const char *const *map,
> -                                          size_t maplen,
>                                            const char *type,
>                                            Error **errp)
>  {
> -    size_t i;
> -    for (i = 0; i < maplen; i++) {
> -        if (g_str_equal(map[i], name)) {
> -            return i;
> -        }
> -    }
> +    int ret = qapi_enum_parse(map, name, -1, NULL);
>  
> -    error_setg(errp, "%s %s not supported", type, name);
> -    return 0;
> +    if (ret < 0) {
> +        error_setg(errp, "%s %s not supported", type, name);
> +        return 0;
> +    }
> +    return ret;
>  }
>  
>  #define qcrypto_block_luks_cipher_mode_lookup(name, errp)               \
>      qcrypto_block_luks_name_lookup(name,                                \
>                                     QCryptoCipherMode_lookup,            \
> -                                   QCRYPTO_CIPHER_MODE__MAX,            \
>                                     "Cipher mode",                       \
>                                     errp)
>  
>  #define qcrypto_block_luks_hash_name_lookup(name, errp)                 \
>      qcrypto_block_luks_name_lookup(name,                                \
>                                     QCryptoHashAlgorithm_lookup,         \
> -                                   QCRYPTO_HASH_ALG__MAX,               \
>                                     "Hash algorithm",                    \
>                                     errp)
>  
>  #define qcrypto_block_luks_ivgen_name_lookup(name, errp)                \
>      qcrypto_block_luks_name_lookup(name,                                \
>                                     QCryptoIVGenAlgorithm_lookup,        \
> -                                   QCRYPTO_IVGEN_ALG__MAX,              \
>                                     "IV generator",                      \
>                                     errp)
>  
> -- 
> 2.7.5
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
