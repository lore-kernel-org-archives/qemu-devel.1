Received: from eggs.gnu.org ([2001:4830:134:3::10]:36719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1fSu6V-00087e-5M
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 20:57:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1fSu6S-0008WU-2L
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 20:57:39 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2332 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arei.gonglei@huawei.com>)
	id 1fSu6R-0008Vl-FN
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 20:57:35 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Wed, 13 Jun 2018 00:57:11 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DB0185BF@dggeml511-mbx.china.huawei.com>
References: <cover.1528832686.git.alifm@linux.ibm.com>
	<dd7e90c5b3de6f98218908c7f57d9d0286089ad5.1528832686.git.alifm@linux.ibm.com>
In-Reply-To: <dd7e90c5b3de6f98218908c7f57d9d0286089ad5.1528832686.git.alifm@linux.ibm.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC v1 1/1] virtio-crypto: Allow disabling of
 cipher algorithms for virtio-crypto device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.ibm.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "mst@redhat.com" <mst@redhat.com>, longpeng <longpeng2@huawei.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "frankja@linux.ibm.com" <frankja@linux.ibm.com>


> -----Original Message-----
> From: Farhan Ali [mailto:alifm@linux.ibm.com]
> Sent: Wednesday, June 13, 2018 3:49 AM
> To: qemu-devel@nongnu.org
> Cc: mst@redhat.com; Gonglei (Arei) <arei.gonglei@huawei.com>; longpeng
> <longpeng2@huawei.com>; pasic@linux.ibm.com; borntraeger@de.ibm.com;
> frankja@linux.ibm.com; alifm@linux.ibm.com
> Subject: [RFC v1 1/1] virtio-crypto: Allow disabling of cipher algorithms=
 for
> virtio-crypto device
>=20
> The virtio-crypto driver currently propagates to the guest
> all the cipher algorithms that the backend cryptodev can
> support. But in certain cases where the guest has more
> performant mechanism to handle some algorithms, it would be
> useful to propagate only a subset of the algorithms.
>=20

It makes sense to me. E.g. current Intel CPU has the AES-NI instruction for=
 accelerating
AES algo. We don't need to propagate AES algos.

> This patch adds support for disabling the cipher
> algorithms of the backend cryptodev.
>=20
> eg:
>  -object cryptodev-backend-builtin,id=3Dcryptodev0
>  -device virtio-crypto-ccw,id=3Dcrypto0,cryptodev=3Dcryptodev0,cipher-aes=
-cbc=3Doff
>=20
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>=20
> Please note this patch is not complete, and there are TODOs to handle
> for other types of algorithms such Hash, AEAD and MAC algorithms.
>=20
> This is mainly intended to get some feedback on the design approach
> from the community.
>=20
>=20
>  hw/virtio/virtio-crypto.c         | 46
> ++++++++++++++++++++++++++++++++++++---
>  include/hw/virtio/virtio-crypto.h |  3 +++
>  2 files changed, 46 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
> index 9a9fa49..4aed9ca 100644
> --- a/hw/virtio/virtio-crypto.c
> +++ b/hw/virtio/virtio-crypto.c
> @@ -754,12 +754,22 @@ static void virtio_crypto_reset(VirtIODevice *vdev)
>  static void virtio_crypto_init_config(VirtIODevice *vdev)
>  {
>      VirtIOCrypto *vcrypto =3D VIRTIO_CRYPTO(vdev);
> +    uint32_t user_crypto_services =3D (1u <<
> VIRTIO_CRYPTO_SERVICE_CIPHER) |
> +                                    (1u <<
> VIRTIO_CRYPTO_SERVICE_HASH) |
> +                                    (1u <<
> VIRTIO_CRYPTO_SERVICE_AEAD) |
> +                                    (1u <<
> VIRTIO_CRYPTO_SERVICE_MAC);
> +
> +    if (vcrypto->user_cipher_algo_l & (1u << VIRTIO_CRYPTO_NO_CIPHER)) {
> +        vcrypto->user_cipher_algo_l =3D 1u << VIRTIO_CRYPTO_NO_CIPHER;
> +        vcrypto->user_cipher_algo_h =3D 0;
> +        user_crypto_services &=3D ~(1u <<
> VIRTIO_CRYPTO_SERVICE_CIPHER);
> +    }
>=20
> -    vcrypto->conf.crypto_services =3D
> +    vcrypto->conf.crypto_services =3D user_crypto_services &
>                       vcrypto->conf.cryptodev->conf.crypto_services;
> -    vcrypto->conf.cipher_algo_l =3D
> +    vcrypto->conf.cipher_algo_l =3D vcrypto->user_cipher_algo_l &
>                       vcrypto->conf.cryptodev->conf.cipher_algo_l;
> -    vcrypto->conf.cipher_algo_h =3D
> +    vcrypto->conf.cipher_algo_h =3D vcrypto->user_cipher_algo_h &
>                       vcrypto->conf.cryptodev->conf.cipher_algo_h;
>      vcrypto->conf.hash_algo =3D vcrypto->conf.cryptodev->conf.hash_algo;
>      vcrypto->conf.mac_algo_l =3D vcrypto->conf.cryptodev->conf.mac_algo_=
l;
> @@ -853,6 +863,34 @@ static const VMStateDescription
> vmstate_virtio_crypto =3D {
>  static Property virtio_crypto_properties[] =3D {
>      DEFINE_PROP_LINK("cryptodev", VirtIOCrypto, conf.cryptodev,
>                       TYPE_CRYPTODEV_BACKEND, CryptoDevBackend
> *),
> +    DEFINE_PROP_BIT("no-cipher", VirtIOCrypto, user_cipher_algo_l,
> +                    VIRTIO_CRYPTO_CIPHER_ARC4, false),

s/ VIRTIO_CRYPTO_CIPHER_ARC4/VIRTIO_CRYPTO_NO_CIPHER/

> +    DEFINE_PROP_BIT("cipher-arc4", VirtIOCrypto, user_cipher_algo_l,
> +                    VIRTIO_CRYPTO_CIPHER_ARC4, false),
> +    DEFINE_PROP_BIT("cipher-aes-ecb", VirtIOCrypto, user_cipher_algo_l,
> +                    VIRTIO_CRYPTO_CIPHER_AES_ECB, false),
> +    DEFINE_PROP_BIT("cipher-aes-cbc", VirtIOCrypto, user_cipher_algo_l,
> +                    VIRTIO_CRYPTO_CIPHER_AES_CBC, false),
> +    DEFINE_PROP_BIT("cipher-aes-ctr", VirtIOCrypto, user_cipher_algo_l,
> +                    VIRTIO_CRYPTO_CIPHER_AES_CTR, false),
> +    DEFINE_PROP_BIT("cipher-des-ecb", VirtIOCrypto, user_cipher_algo_l,
> +                    VIRTIO_CRYPTO_CIPHER_DES_ECB, false),
> +    DEFINE_PROP_BIT("cipher-3des-ecb", VirtIOCrypto, user_cipher_algo_l,
> +                    VIRTIO_CRYPTO_CIPHER_3DES_ECB, false),
> +    DEFINE_PROP_BIT("cipher-3des-cbc", VirtIOCrypto, user_cipher_algo_l,
> +                    VIRTIO_CRYPTO_CIPHER_3DES_CBC, false),
> +    DEFINE_PROP_BIT("cipher-3des-ctr", VirtIOCrypto, user_cipher_algo_l,
> +                    VIRTIO_CRYPTO_CIPHER_3DES_CTR, false),
> +    DEFINE_PROP_BIT("cipher-kasumi-f8", VirtIOCrypto, user_cipher_algo_l=
,
> +                    VIRTIO_CRYPTO_CIPHER_KASUMI_F8, false),
> +    DEFINE_PROP_BIT("cipher-snow3g-uea2", VirtIOCrypto,
> user_cipher_algo_l,
> +                    VIRTIO_CRYPTO_CIPHER_SNOW3G_UEA2, false),
> +    DEFINE_PROP_BIT("cipher-aes-f8", VirtIOCrypto, user_cipher_algo_l,
> +                    VIRTIO_CRYPTO_CIPHER_AES_F8, false),
> +    DEFINE_PROP_BIT("cipher-aes-xts", VirtIOCrypto, user_cipher_algo_l,
> +                    VIRTIO_CRYPTO_CIPHER_AES_XTS, false),
> +    DEFINE_PROP_BIT("cipher-zuc-eea3", VirtIOCrypto, user_cipher_algo_l,
> +                    VIRTIO_CRYPTO_CIPHER_ZUC_EEA3, false),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>=20
We'd better keep all algorithms enabled by default. So pls s/false/true/g.

Thanks,
-Gonglei=20

> @@ -974,6 +1012,8 @@ static void virtio_crypto_instance_init(Object *obj)
>       * Can be overriden with virtio_crypto_set_config_size.
>       */
>      vcrypto->config_size =3D sizeof(struct virtio_crypto_config);
> +    vcrypto->user_cipher_algo_l =3D ~VIRTIO_CRYPTO_NO_CIPHER - 1;
> +    vcrypto->user_cipher_algo_h =3D ~VIRTIO_CRYPTO_NO_CIPHER;
>  }
>=20
>  static const TypeInfo virtio_crypto_info =3D {
> diff --git a/include/hw/virtio/virtio-crypto.h b/include/hw/virtio/virtio=
-crypto.h
> index ca3a049..c5bb684 100644
> --- a/include/hw/virtio/virtio-crypto.h
> +++ b/include/hw/virtio/virtio-crypto.h
> @@ -97,6 +97,9 @@ typedef struct VirtIOCrypto {
>      uint32_t curr_queues;
>      size_t config_size;
>      uint8_t vhost_started;
> +
> +    uint32_t user_cipher_algo_l;
> +    uint32_t user_cipher_algo_h;
>  } VirtIOCrypto;
>=20
>  #endif /* _QEMU_VIRTIO_CRYPTO_H */
> --
> 2.7.4
