Received: from eggs.gnu.org ([2001:4830:134:3::10]:35975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dkplH-0004rG-8c
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:53:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dkplG-0005uC-Fh
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:53:19 -0400
Received: from mail-ua0-x243.google.com ([2607:f8b0:400c:c08::243]:34862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dkplG-0005ty-B0
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:53:18 -0400
Received: by mail-ua0-x243.google.com with SMTP id c3so925023uae.2
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 03:53:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1503564371-26090-10-git-send-email-armbru@redhat.com>
References: <1503564371-26090-1-git-send-email-armbru@redhat.com>
	<1503564371-26090-10-git-send-email-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 24 Aug 2017 12:53:17 +0200
Message-ID: <CAJ+F1CKTfjghAJxfU2FiSC3sd5ZzygDSLyEH5iOERR7k8_=aSA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Thu, Aug 24, 2017 at 10:46 AM, Markus Armbruster <armbru@redhat.com> wro=
te:
> Cc: "Daniel P. Berrange" <berrange@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  crypto/block-luks.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
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
> @@ -265,39 +266,33 @@ qcrypto_block_luks_cipher_alg_lookup(QCryptoCipherA=
lgorithm alg,
>   * make that function emit a more friendly error message */
>  static int qcrypto_block_luks_name_lookup(const char *name,
>                                            const char *const *map,
> -                                          size_t maplen,
>                                            const char *type,
>                                            Error **errp)
>  {
> -    size_t i;
> -    for (i =3D 0; i < maplen; i++) {
> -        if (g_str_equal(map[i], name)) {
> -            return i;
> -        }
> -    }
> +    int ret =3D qapi_enum_parse(map, name, -1, NULL);
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
>  #define qcrypto_block_luks_cipher_mode_lookup(name, errp)               =
\
>      qcrypto_block_luks_name_lookup(name,                                =
\
>                                     QCryptoCipherMode_lookup,            =
\
> -                                   QCRYPTO_CIPHER_MODE__MAX,            =
\
>                                     "Cipher mode",                       =
\
>                                     errp)
>
>  #define qcrypto_block_luks_hash_name_lookup(name, errp)                 =
\
>      qcrypto_block_luks_name_lookup(name,                                =
\
>                                     QCryptoHashAlgorithm_lookup,         =
\
> -                                   QCRYPTO_HASH_ALG__MAX,               =
\
>                                     "Hash algorithm",                    =
\
>                                     errp)
>
>  #define qcrypto_block_luks_ivgen_name_lookup(name, errp)                =
\
>      qcrypto_block_luks_name_lookup(name,                                =
\
>                                     QCryptoIVGenAlgorithm_lookup,        =
\
> -                                   QCRYPTO_IVGEN_ALG__MAX,              =
\
>                                     "IV generator",                      =
\
>                                     errp)
>
> --
> 2.7.5
>
>



--=20
Marc-Andr=C3=A9 Lureau
