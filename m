Received: from eggs.gnu.org ([2001:4830:134:3::10]:41261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1fSGbD-0003lg-R5
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 02:46:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1fSGbA-0000eO-Op
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 02:46:43 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2330 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arei.gonglei@huawei.com>)
	id 1fSGbA-0000Zb-Br
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 02:46:40 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Mon, 11 Jun 2018 06:43:01 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DB015842@dggeml511-mbx.china.huawei.com>
References: <cover.1528462918.git.alifm@linux.ibm.com>
	<e0fe84d1df4e0c2c88d7d29f94d621c988c22194.1528462918.git.alifm@linux.ibm.com>
In-Reply-To: <e0fe84d1df4e0c2c88d7d29f94d621c988c22194.1528462918.git.alifm@linux.ibm.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC v1 1/2] crypto/virtio-crypto: Read crypto
 services and algorithm masks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Cc: "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, longpeng <longpeng2@huawei.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "frankja@linux.ibm.com" <frankja@linux.ibm.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>


> -----Original Message-----
> From: Farhan Ali [mailto:alifm@linux.ibm.com]
> Sent: Saturday, June 09, 2018 3:09 AM
> To: linux-kernel@vger.kernel.org; kvm@vger.kernel.org
> Cc: mst@redhat.com; qemu-devel@nongnu.org; Gonglei (Arei)
> <arei.gonglei@huawei.com>; longpeng <longpeng2@huawei.com>;
> pasic@linux.ibm.com; frankja@linux.ibm.com; borntraeger@de.ibm.com;
> alifm@linux.ibm.com
> Subject: [RFC v1 1/2] crypto/virtio-crypto: Read crypto services and algo=
rithm
> masks
>=20
> Read the crypto services and algorithm masks which provides
> information about the services and algorithms supported by
> virtio-crypto backend.
>=20
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  drivers/crypto/virtio/virtio_crypto_common.h | 14 ++++++++++++++
>  drivers/crypto/virtio/virtio_crypto_core.c   | 29
> ++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+)
>=20
> diff --git a/drivers/crypto/virtio/virtio_crypto_common.h
> b/drivers/crypto/virtio/virtio_crypto_common.h
> index 66501a5..05eca12e 100644
> --- a/drivers/crypto/virtio/virtio_crypto_common.h
> +++ b/drivers/crypto/virtio/virtio_crypto_common.h
> @@ -55,6 +55,20 @@ struct virtio_crypto {
>  	/* Number of queue currently used by the driver */
>  	u32 curr_queue;
>=20
> +	/*
> +	 * Specifies the services mask which the device support,
> +	 * see VIRTIO_CRYPTO_SERVICE_* above
> +	 */

Pls update the above comments. Except that:

Acked-by: Gonglei <arei.gonglei@huawei.com>

> +	u32 crypto_services;
> +
> +	/* Detailed algorithms mask */
> +	u32 cipher_algo_l;
> +	u32 cipher_algo_h;
> +	u32 hash_algo;
> +	u32 mac_algo_l;
> +	u32 mac_algo_h;
> +	u32 aead_algo;
> +
>  	/* Maximum length of cipher key */
>  	u32 max_cipher_key_len;
>  	/* Maximum length of authenticated key */
> diff --git a/drivers/crypto/virtio/virtio_crypto_core.c
> b/drivers/crypto/virtio/virtio_crypto_core.c
> index 8332698..8f745f2 100644
> --- a/drivers/crypto/virtio/virtio_crypto_core.c
> +++ b/drivers/crypto/virtio/virtio_crypto_core.c
> @@ -303,6 +303,13 @@ static int virtcrypto_probe(struct virtio_device *vd=
ev)
>  	u32 max_data_queues =3D 0, max_cipher_key_len =3D 0;
>  	u32 max_auth_key_len =3D 0;
>  	u64 max_size =3D 0;
> +	u32 cipher_algo_l =3D 0;
> +	u32 cipher_algo_h =3D 0;
> +	u32 hash_algo =3D 0;
> +	u32 mac_algo_l =3D 0;
> +	u32 mac_algo_h =3D 0;
> +	u32 aead_algo =3D 0;
> +	u32 crypto_services =3D 0;
>=20
>  	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
>  		return -ENODEV;
> @@ -339,6 +346,20 @@ static int virtcrypto_probe(struct virtio_device *vd=
ev)
>  		max_auth_key_len, &max_auth_key_len);
>  	virtio_cread(vdev, struct virtio_crypto_config,
>  		max_size, &max_size);
> +	virtio_cread(vdev, struct virtio_crypto_config,
> +		crypto_services, &crypto_services);
> +	virtio_cread(vdev, struct virtio_crypto_config,
> +		cipher_algo_l, &cipher_algo_l);
> +	virtio_cread(vdev, struct virtio_crypto_config,
> +		cipher_algo_h, &cipher_algo_h);
> +	virtio_cread(vdev, struct virtio_crypto_config,
> +		hash_algo, &hash_algo);
> +	virtio_cread(vdev, struct virtio_crypto_config,
> +		mac_algo_l, &mac_algo_l);
> +	virtio_cread(vdev, struct virtio_crypto_config,
> +		mac_algo_h, &mac_algo_h);
> +	virtio_cread(vdev, struct virtio_crypto_config,
> +		aead_algo, &aead_algo);
>=20
>  	/* Add virtio crypto device to global table */
>  	err =3D virtcrypto_devmgr_add_dev(vcrypto);
> @@ -358,6 +379,14 @@ static int virtcrypto_probe(struct virtio_device *vd=
ev)
>  	vcrypto->max_cipher_key_len =3D max_cipher_key_len;
>  	vcrypto->max_auth_key_len =3D max_auth_key_len;
>  	vcrypto->max_size =3D max_size;
> +	vcrypto->crypto_services =3D crypto_services;
> +	vcrypto->cipher_algo_l =3D cipher_algo_l;
> +	vcrypto->cipher_algo_h =3D cipher_algo_h;
> +	vcrypto->mac_algo_l =3D mac_algo_l;
> +	vcrypto->mac_algo_h =3D mac_algo_h;
> +	vcrypto->hash_algo =3D hash_algo;
> +	vcrypto->aead_algo =3D aead_algo;
> +
>=20
>  	dev_info(&vdev->dev,
>  		"max_queues: %u, max_cipher_key_len: %u, max_auth_key_len: %u,
> max_size 0x%llx\n",
> --
> 2.7.4
