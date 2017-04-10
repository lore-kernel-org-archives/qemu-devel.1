Received: from eggs.gnu.org ([2001:4830:134:3::10]:48104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cxWMb-0001EU-Dw
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 06:16:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cxWMY-0006Mj-7B
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 06:16:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cxWMX-0006MY-UU
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 06:15:58 -0400
Date: Mon, 10 Apr 2017 11:15:52 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170410101552.GH3655@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1491814847-63240-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1491814847-63240-1-git-send-email-longpeng2@huawei.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 13/19] crypto: introduce some
 common functions for af_alg backend
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

On Mon, Apr 10, 2017 at 05:00:47PM +0800, Longpeng(Mike) wrote:
> This patch introduces some common functions for af_alg backend,
> they would be used in af_alg-backend cipher/hash/hmac latter.
> 
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
>  crypto/Makefile.objs        |  1 +
>  crypto/afalg-comm.c         | 71 +++++++++++++++++++++++++++++++++++++++++++++
>  include/crypto/afalg-comm.h | 61 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 133 insertions(+)
>  create mode 100644 crypto/afalg-comm.c
>  create mode 100644 include/crypto/afalg-comm.h
> 
> diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
> index 1f749f2..6f244a3 100644
> --- a/crypto/Makefile.objs
> +++ b/crypto/Makefile.objs
> @@ -10,6 +10,7 @@ crypto-obj-$(if $(CONFIG_NETTLE),n,$(if $(CONFIG_GCRYPT_HMAC),n,y)) += hmac-glib
>  crypto-obj-y += aes.o
>  crypto-obj-y += desrfb.o
>  crypto-obj-y += cipher.o
> +crypto-obj-$(CONFIG_AF_ALG) += afalg-comm.o
>  crypto-obj-y += tlscreds.o
>  crypto-obj-y += tlscredsanon.o
>  crypto-obj-y += tlscredsx509.o
> diff --git a/crypto/afalg-comm.c b/crypto/afalg-comm.c
> new file mode 100644
> index 0000000..27bc88c
> --- /dev/null
> +++ b/crypto/afalg-comm.c

Just calls this  crypto/afalg.c


> +void afalg_comm_format_type(AfalgSocketAddress *afalg,
> +                            const char *type)
> +{
> +    afalg->type = (char *)g_new0(int8_t, SALG_TYPE_LEN_MAX);
> +    pstrcpy(afalg->type, SALG_TYPE_LEN_MAX, type);
> +}

Needs an 'Error **errp' for reporting if 'type' is too long


> diff --git a/include/crypto/afalg-comm.h b/include/crypto/afalg-comm.h
> new file mode 100644
> index 0000000..b6b9464
> --- /dev/null
> +++ b/include/crypto/afalg-comm.h
> @@ -0,0 +1,61 @@
> +/*
> + * QEMU Crypto af_alg support
> + *
> + * Copyright (c) 2017 HUAWEI TECHNOLOGIES CO., LTD.
> + *
> + * Authors:
> + *    Longpeng(Mike) <longpeng2@huawei.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * (at your option) any later version.  See the COPYING file in the
> + * top-level directory.
> + */
> +#ifndef QCRYPTO_AFALG_H
> +#define QCRYPTO_AFALG_H
> +
> +#include "qapi-types.h"
> +
> +#ifndef SOL_ALG
> +#define SOL_ALG 279
> +#endif

This can be in the .c file as I don't se it used elsewhere.

> +
> +typedef struct QCryptoAfalg QCryptoAfalg;
> +struct QCryptoAfalg {

Name it 'QCryptoAFAlg'  since the letters 'af' are an abbreviation.

> +    int tfmfd;
> +    int opfd;
> +    struct msghdr *msg;
> +    struct cmsghdr *cmsg;
> +};
> +
> +
> +/**
> + * afalg_comm_format_type:
> + * @afalg: the AfalgSocketAddress object
> + * @type: the type of crypto alg.
> + *
> + * Set the type field of the @afalg according to @type.
> + */
> +void afalg_comm_format_type(AfalgSocketAddress *afalg,
> +                            const char *type);
> +
> +/**
> + * afalg_comm_alloc:
> + * @saddr: the SocketAddress object
> + *
> + * Allocate a QCryptoAfalg object and bind itself to
> + * a AF_ALG socket.
> + *
> + * Returns:
> + *  a new QCryptoAfalg object, or NULL in error.
> + */
> +QCryptoAfalg *afalg_comm_alloc(SocketAddress *saddr);
> +
> +/**
> + * afalg_comm_free:
> + * @afalg: the QCryptoAfalg object
> + *
> + * Free the @afalg.
> + */
> +void afalg_comm_free(QCryptoAfalg *afalg);
> +
> +#endif

This is all for internal use by the crypto/ code, so should be in a header
crypto/afalgpriv.h

> -- 
> 1.8.3.1
> 
> 

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
