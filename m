Received: from eggs.gnu.org ([2001:4830:134:3::10]:57907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dUuCy-0005fQ-Ry
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:24:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dUuCv-0005zS-2L
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:24:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dUuCu-0005z8-PP
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:24:00 -0400
Date: Tue, 11 Jul 2017 13:23:54 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170711122354.GK7116@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1499158630-75260-1-git-send-email-longpeng2@huawei.com>
	<1499158630-75260-14-git-send-email-longpeng2@huawei.com>
	<20170711122035.GJ7116@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170711122035.GJ7116@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 13/18] crypto: cipher: add afalg-backend
 cipher support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Cc: wangxinxin.wang@huawei.com, arei.gonglei@huawei.com, weidong.huang@huawei.com, qemu-devel@nongnu.org, longpeng.mike@gmail.com

On Tue, Jul 11, 2017 at 01:20:35PM +0100, Daniel P. Berrange wrote:
> On Tue, Jul 04, 2017 at 04:57:05PM +0800, Longpeng(Mike) wrote:
> > Adds afalg-backend cipher support: introduces some private APIs
> > firstly, and then intergrates them into qcrypto_cipher_afalg_driver.
> > 
> > Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> > ---
> >  crypto/Makefile.objs  |   1 +
> >  crypto/afalgpriv.h    |   9 ++
> >  crypto/cipher-afalg.c | 223 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  crypto/cipher.c       |  23 +++++-
> >  crypto/cipherpriv.h   |  16 ++++
> >  5 files changed, 268 insertions(+), 4 deletions(-)
> >  create mode 100644 crypto/cipher-afalg.c
> > 
> > diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
> > index 2be5a3a..d2e8fa8 100644
> > --- a/crypto/Makefile.objs
> > +++ b/crypto/Makefile.objs
> > @@ -11,6 +11,7 @@ crypto-obj-y += aes.o
> >  crypto-obj-y += desrfb.o
> >  crypto-obj-y += cipher.o
> >  crypto-obj-$(CONFIG_AF_ALG) += afalg.o
> > +crypto-obj-$(CONFIG_AF_ALG) += cipher-afalg.o
> >  crypto-obj-y += tlscreds.o
> >  crypto-obj-y += tlscredsanon.o
> >  crypto-obj-y += tlscredsx509.o
> > diff --git a/crypto/afalgpriv.h b/crypto/afalgpriv.h
> > index d21160c..a4a7b97 100644
> > --- a/crypto/afalgpriv.h
> > +++ b/crypto/afalgpriv.h
> > @@ -19,6 +19,15 @@
> >  #define SALG_TYPE_LEN_MAX 14
> >  #define SALG_NAME_LEN_MAX 64
> >  
> > +#ifndef SOL_ALG
> > +#define SOL_ALG 279
> > +#endif
> > +
> > +#define AFALG_TYPE_CIPHER "skcipher"
> > +
> > +#define ALG_OPTYPE_LEN 4
> > +#define ALG_MSGIV_LEN(len) (sizeof(struct af_alg_iv) + (len))
> > +
> >  typedef struct QCryptoAFAlg QCryptoAFAlg;
> >  
> >  struct QCryptoAFAlg {
> > diff --git a/crypto/cipher-afalg.c b/crypto/cipher-afalg.c
> > new file mode 100644
> > index 0000000..c5d1d5d
> > --- /dev/null
> > +++ b/crypto/cipher-afalg.c
> > @@ -0,0 +1,223 @@
> > +/*
> > + * QEMU Crypto af_alg-backend cipher support
> > + *
> > + * Copyright (c) 2017 HUAWEI TECHNOLOGIES CO., LTD.
> > + *
> > + * Authors:
> > + *    Longpeng(Mike) <longpeng2@huawei.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or
> > + * (at your option) any later version.  See the COPYING file in the
> > + * top-level directory.
> > + */
> > +#include "qemu/osdep.h"
> > +#include "qemu/sockets.h"
> > +#include "qemu-common.h"
> > +#include "qapi/error.h"
> > +#include "crypto/cipher.h"
> > +#include "cipherpriv.h"
> > +
> > +
> > +static char *
> > +qcrypto_afalg_cipher_format_name(QCryptoCipherAlgorithm alg,
> > +                                 QCryptoCipherMode mode,
> > +                                 Error **errp)
> > +{
> > +    char *name;
> > +    const char *alg_name;
> > +    const char *mode_name;
> > +
> > +    switch (alg) {
> > +    case QCRYPTO_CIPHER_ALG_AES_128:
> > +    case QCRYPTO_CIPHER_ALG_AES_192:
> > +    case QCRYPTO_CIPHER_ALG_AES_256:
> > +        alg_name = "aes";
> > +        break;
> > +    case QCRYPTO_CIPHER_ALG_CAST5_128:
> > +        alg_name = "cast5";
> > +        break;
> > +    case QCRYPTO_CIPHER_ALG_SERPENT_128:
> > +    case QCRYPTO_CIPHER_ALG_SERPENT_192:
> > +    case QCRYPTO_CIPHER_ALG_SERPENT_256:
> > +        alg_name = "serpent";
> > +        break;
> > +    case QCRYPTO_CIPHER_ALG_TWOFISH_128:
> > +    case QCRYPTO_CIPHER_ALG_TWOFISH_192:
> > +    case QCRYPTO_CIPHER_ALG_TWOFISH_256:
> > +        alg_name = "twofish";
> > +        break;
> > +
> > +    default:
> > +        error_setg(errp, "Unsupported cipher algorithm %d", alg);
> > +        return NULL;
> > +    }
> > +
> > +    mode_name = QCryptoCipherMode_lookup[mode];
> > +    name = g_strdup_printf("%s(%s)", mode_name, alg_name);
> > +
> > +    return name;
> > +}
> > +
> > +QCryptoAFAlg *
> > +qcrypto_afalg_cipher_ctx_new(QCryptoCipherAlgorithm alg,
> > +                             QCryptoCipherMode mode,
> > +                             const uint8_t *key,
> > +                             size_t nkey, Error **errp)
> > +{
> > +    QCryptoAFAlg *afalg;
> > +    size_t expect_niv;
> > +    char *name;
> > +
> > +    name = qcrypto_afalg_cipher_format_name(alg, mode, errp);
> > +    if (!name) {
> > +        return NULL;
> > +    }
> > +
> > +    afalg = qcrypto_afalg_comm_alloc(AFALG_TYPE_CIPHER, name, errp);
> > +    if (!afalg) {
> > +        g_free(name);
> > +        return NULL;
> > +    }
> > +    afalg->name = name;
> 
> How about moving the qcrypto_afalg_cipher_format_name() method into the
> afalg.c file. THen instead of passing 'name' into qcrypto_afalg_comm_alloc,
> you can just pass 'alg' & 'mode'.  Then qcrypto_afalg_comm_alloc can be
> responsible for setting afalg->name too.

Oh actually ignore this. I've just remembered that qcrypto_afalg_comm_alloc
method is used for multiple places, so we can't pass in alg & mode directly.

We can however make qcrypto_afalg_comm_alloc initializet he 'afalg->name'
field.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
