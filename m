Received: from eggs.gnu.org ([2001:4830:134:3::10]:60822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1fSIUw-0001aU-Jd
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 04:48:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1fSIUt-0002JR-I8
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 04:48:22 -0400
Received: from [45.249.212.255] (port=37119 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arei.gonglei@huawei.com>)
	id 1fSIUt-0002IR-46
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 04:48:19 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Mon, 11 Jun 2018 08:48:07 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DB015ABF@dggeml511-mbx.china.huawei.com>
References: <cover.1528462918.git.alifm@linux.ibm.com>
	<a9a06d82df69387bf1e66975b520d9049e9976e8.1528462918.git.alifm@linux.ibm.com>
In-Reply-To: <a9a06d82df69387bf1e66975b520d9049e9976e8.1528462918.git.alifm@linux.ibm.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC v1 2/2] crypto/virtio-crypto: Register an
 algo only if it's supported
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
> Subject: [RFC v1 2/2] crypto/virtio-crypto: Register an algo only if it's=
 supported
>=20
> From: Farhan Ali <alifm@linux.vnet.ibm.com>
>=20
> Register a crypto algo with the Linux crypto layer only if
> the algorithm is supported by the backend virtio-crypto
> device.
>=20
> Also route crypto requests to a virtio-crypto
> device, only if it can support the requested service and
> algorithm.
>=20
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  drivers/crypto/virtio/virtio_crypto_algs.c   | 110
> ++++++++++++++++++---------
>  drivers/crypto/virtio/virtio_crypto_common.h |  11 ++-
>  drivers/crypto/virtio/virtio_crypto_mgr.c    |  81 ++++++++++++++++++--
>  3 files changed, 158 insertions(+), 44 deletions(-)
>=20
> diff --git a/drivers/crypto/virtio/virtio_crypto_algs.c
> b/drivers/crypto/virtio/virtio_crypto_algs.c
> index ba190cf..fef112a 100644
> --- a/drivers/crypto/virtio/virtio_crypto_algs.c
> +++ b/drivers/crypto/virtio/virtio_crypto_algs.c
> @@ -49,12 +49,18 @@ struct virtio_crypto_sym_request {
>  	bool encrypt;
>  };
>=20
> +struct virtio_crypto_algo {
> +	uint32_t algonum;
> +	uint32_t service;
> +	unsigned int active_devs;
> +	struct crypto_alg algo;
> +};
> +
>  /*
>   * The algs_lock protects the below global virtio_crypto_active_devs
>   * and crypto algorithms registion.
>   */
>  static DEFINE_MUTEX(algs_lock);
> -static unsigned int virtio_crypto_active_devs;
>  static void virtio_crypto_ablkcipher_finalize_req(
>  	struct virtio_crypto_sym_request *vc_sym_req,
>  	struct ablkcipher_request *req,
> @@ -312,13 +318,19 @@ static int virtio_crypto_ablkcipher_setkey(struct
> crypto_ablkcipher *tfm,
>  					 unsigned int keylen)
>  {
>  	struct virtio_crypto_ablkcipher_ctx *ctx =3D crypto_ablkcipher_ctx(tfm)=
;
> +	uint32_t alg;
>  	int ret;
>=20
> +	ret =3D virtio_crypto_alg_validate_key(keylen, &alg);
> +	if (ret)
> +		return ret;
> +
>  	if (!ctx->vcrypto) {
>  		/* New key */
>  		int node =3D virtio_crypto_get_current_node();
>  		struct virtio_crypto *vcrypto =3D
> -				      virtcrypto_get_dev_node(node);
> +				      virtcrypto_get_dev_node(node,
> +				      VIRTIO_CRYPTO_SERVICE_CIPHER, alg);
>  		if (!vcrypto) {
>  			pr_err("virtio_crypto: Could not find a virtio device in the
> system\n");

We'd better change the above error message now. What about:
 " virtio_crypto: Could not find a virtio device in the system or unsupport=
ed algo" ?

Regards,
-Gonglei
