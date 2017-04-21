Received: from eggs.gnu.org ([2001:4830:134:3::10]:56641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d1Xnq-00020g-K4
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:36:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d1Xnn-0003xO-DD
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:36:46 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3452
	helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d1Xnm-0003wT-Ge
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:36:43 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Fri, 21 Apr 2017 12:36:17 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA238B4D@DGGEMA505-MBS.china.huawei.com>
References: <1492392806-53720-1-git-send-email-longpeng2@huawei.com>
	<1492392806-53720-13-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1492392806-53720-13-git-send-email-longpeng2@huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 12/18] crypto: introduce some
 common functions for af_alg backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: longpeng <longpeng2@huawei.com>, "berrange@redhat.com" <berrange@redhat.com>
Cc: "Huangweidong (C)" <weidong.huang@huawei.com>, "armbru@redhat.com" <armbru@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


> -----Original Message-----
> From: longpeng
> Sent: Monday, April 17, 2017 9:33 AM
> To: berrange@redhat.com
> Cc: Gonglei (Arei); Huangweidong (C); armbru@redhat.com;
> eblake@redhat.com; mst@redhat.com; qemu-devel@nongnu.org; longpeng
> Subject: [PATCH v2 for-2.10 12/18] crypto: introduce some common function=
s
> for af_alg backend
>=20
> The AF_ALG socket family is the userspace interface for linux
> crypto API, this patch adds af_alg family support and some common
> functions for af_alg backend. It'll be used by afalg-backend crypto
> latter.
>=20
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
>  configure            |  21 ++++++++++
>  crypto/Makefile.objs |   1 +
>  crypto/afalg.c       | 115
> +++++++++++++++++++++++++++++++++++++++++++++++++++
>  crypto/afalgpriv.h   |  54 ++++++++++++++++++++++++
>  4 files changed, 191 insertions(+)
>  create mode 100644 crypto/afalg.c
>  create mode 100644 crypto/afalgpriv.h
>=20
> diff --git a/configure b/configure
> index be4d326..088e2de 100755
> --- a/configure
> +++ b/configure
> @@ -4741,6 +4741,23 @@ if compile_prog "" "" ; then
>      have_af_vsock=3Dyes
>  fi
>=20
> +##########################################
> +# check for usable AF_ALG environment
> +hava_af_alg=3Dno
> +cat > $TMPC << EOF
> +#include <errno.h>
> +#include <sys/types.h>
> +#include <sys/socket.h>
> +int main(void) {
> +    int sock;
> +    sock =3D socket(AF_ALG, SOCK_SEQPACKET, 0);
> +    return sock;
> +}
> +EOF
> +if compile_prog "" "" ; then
> +    have_af_alg=3Dyes
> +fi
> +
>  #################################################
>  # Sparc implicitly links with --relax, which is
>  # incompatible with -r, so --no-relax should be
> @@ -5771,6 +5788,10 @@ if test "$have_af_vsock" =3D "yes" ; then
>    echo "CONFIG_AF_VSOCK=3Dy" >> $config_host_mak
>  fi
>=20
> +if test "$have_af_alg" =3D "yes" ; then
> +  echo "CONFIG_AF_ALG=3Dy" >> $config_host_mak
> +fi
> +
>  if test "$have_sysmacros" =3D "yes" ; then
>    echo "CONFIG_SYSMACROS=3Dy" >> $config_host_mak
>  fi
> diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
> index 1f749f2..2be5a3a 100644
> --- a/crypto/Makefile.objs
> +++ b/crypto/Makefile.objs
> @@ -10,6 +10,7 @@ crypto-obj-$(if $(CONFIG_NETTLE),n,$(if
> $(CONFIG_GCRYPT_HMAC),n,y)) +=3D hmac-glib
>  crypto-obj-y +=3D aes.o
>  crypto-obj-y +=3D desrfb.o
>  crypto-obj-y +=3D cipher.o
> +crypto-obj-$(CONFIG_AF_ALG) +=3D afalg.o
>  crypto-obj-y +=3D tlscreds.o
>  crypto-obj-y +=3D tlscredsanon.o
>  crypto-obj-y +=3D tlscredsx509.o
> diff --git a/crypto/afalg.c b/crypto/afalg.c
> new file mode 100644
> index 0000000..72d668e
> --- /dev/null
> +++ b/crypto/afalg.c
> @@ -0,0 +1,115 @@
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
> +#include "qemu/osdep.h"
> +#include "qemu/cutils.h"
> +#include "qemu/sockets.h"
> +#include "qapi/error.h"
> +#include "afalgpriv.h"
> +
> +static bool
> +qcrypto_afalg_build_saddr(const char *type, const char *name,
> +                          struct sockaddr_alg *salg, Error **errp)
> +{
> +    memset(salg, 0, sizeof(*salg));

Why not initialize it in its caller?

> +    salg->salg_family =3D AF_ALG;
> +
> +    if (qemu_strnlen(type, SALG_TYPE_LEN_MAX) =3D=3D SALG_TYPE_LEN_MAX)
> {
> +        error_setg(errp, "Afalg type(%s) is larger than %d bytes",
> +                   type, SALG_TYPE_LEN_MAX);
> +        return false;
> +    }
> +
> +    if (qemu_strnlen(name, SALG_NAME_LEN_MAX) =3D=3D
> SALG_NAME_LEN_MAX) {
> +        error_setg(errp, "Afalg name(%s) is larger than %d bytes",
> +                   name, SALG_NAME_LEN_MAX);
> +        return false;
> +    }
> +
> +    pstrcpy((char *)salg->salg_type, SALG_TYPE_LEN_MAX, type);
> +    pstrcpy((char *)salg->salg_name, SALG_NAME_LEN_MAX, name);
> +
> +    return true;
> +}
> +
> +static int
> +qcrypto_afalg_socket_bind(const char *type, const char *name,
> +                          Error **errp)
> +{
> +    int sbind;
> +    struct sockaddr_alg salg;
> +
> +    if (!qcrypto_afalg_build_saddr(type, name, &salg, errp)) {
> +        return -1;
> +    }
> +
> +    sbind =3D qemu_socket(AF_ALG, SOCK_SEQPACKET, 0);
> +    if (sbind < 0) {
> +        error_setg_errno(errp, errno, "Failed to create socket");
> +        return -1;
> +    }
> +
> +    if (bind(sbind, (const struct sockaddr *)&salg, sizeof(salg)) !=3D 0=
) {
> +        error_setg_errno(errp, errno, "Failed to bind socket");
> +        closesocket(sbind);
> +        return -1;
> +    }
> +
> +    return sbind;
> +}
> +
> +QCryptoAFAlg *
> +qcrypto_afalg_comm_alloc(const char *type, const char *name,
> +                         Error **errp)
> +{
> +    QCryptoAFAlg *afalg =3D NULL;

A superfluous initialization.

> +
> +    afalg =3D g_new0(QCryptoAFAlg, 1);
> +    /* initilize crypto API socket */
> +    afalg->opfd =3D -1;
> +    afalg->tfmfd =3D qcrypto_afalg_socket_bind(type, name, errp);
> +    if (afalg->tfmfd =3D=3D -1) {
> +        goto error;
> +    }
> +
> +    afalg->opfd =3D qemu_accept(afalg->tfmfd, NULL, 0);
> +    if (afalg->opfd =3D=3D -1) {
> +        error_setg_errno(errp, errno, "Failed to accept socket");
> +        goto error;
> +    }
> +
> +    return afalg;
> +
> +error:
> +    qcrypto_afalg_comm_free(afalg);
> +    return NULL;
> +}
> +
> +void qcrypto_afalg_comm_free(QCryptoAFAlg *afalg)
> +{
> +    if (afalg) {
> +        if (afalg->msg) {
> +            g_free(afalg->msg->msg_control);
> +            g_free(afalg->msg);
> +        }
> +
> +        if (afalg->tfmfd !=3D -1) {
> +            closesocket(afalg->tfmfd);
> +        }
> +
> +        if (afalg->opfd !=3D -1) {
> +            closesocket(afalg->opfd);
> +        }
> +
> +        g_free(afalg);
> +    }
> +}
> diff --git a/crypto/afalgpriv.h b/crypto/afalgpriv.h
> new file mode 100644
> index 0000000..155130b
> --- /dev/null
> +++ b/crypto/afalgpriv.h
> @@ -0,0 +1,54 @@
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
> +
> +#ifndef QCRYPTO_AFALGPRIV_H
> +#define QCRYPTO_AFALGPRIV_H
> +
> +#include <linux/if_alg.h>
> +
> +#define SALG_TYPE_LEN_MAX 14
> +#define SALG_NAME_LEN_MAX 64
> +
> +typedef struct QCryptoAFAlg QCryptoAFAlg;
> +
> +struct QCryptoAFAlg {
> +    int tfmfd;
> +    int opfd;
> +    struct msghdr *msg;
> +    struct cmsghdr *cmsg;
> +};
> +
> +/**
> + * qcrypto_afalg_comm_alloc:
> + * @type: the type of crypto opeartion
> + * @name: the name of crypto opeartion

s/opeartion/operation/g


> + *
> + * Allocate a QCryptoAFAlg object and bind itself to
> + * a AF_ALG socket.
> + *
> + * Returns:
> + *  a new QCryptoAFAlg object, or NULL in error.
> + */
> +QCryptoAFAlg *
> +qcrypto_afalg_comm_alloc(const char *type, const char *name,
> +                         Error **errp);
> +
> +/**
> + * afalg_comm_free:
> + * @afalg: the QCryptoAFAlg object
> + *
> + * Free the @afalg.
> + */
> +void qcrypto_afalg_comm_free(QCryptoAFAlg *afalg);
> +
> +#endif
> --
> 1.8.3.1
>=20
