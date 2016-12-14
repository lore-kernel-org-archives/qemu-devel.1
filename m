Received: from eggs.gnu.org ([2001:4830:134:3::10]:36975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cHBdt-0001Np-UZ
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:38:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cHBdq-0004RD-0n
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:38:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38263)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1cHBdp-0004Qv-No
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:38:49 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBEFZic5045114
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 10:38:47 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27b8t28f6j-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 10:38:47 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 15:38:42 -0000
References: <1481716249-185392-1-git-send-email-arei.gonglei@huawei.com>
	<1481716249-185392-2-git-send-email-arei.gonglei@huawei.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 16:38:33 +0100
MIME-Version: 1.0
In-Reply-To: <1481716249-185392-2-git-send-email-arei.gonglei@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <bcf62fa0-8fc9-daaf-ea7b-e09eb83b593a@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v7 1/1] crypto: add virtio-crypto driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gonglei <arei.gonglei@huawei.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, linux-crypto@vger.kernel.org
Cc: weidong.huang@huawei.com, claudio.fontana@huawei.com, mst@redhat.com, luonengjun@huawei.com, hanweidong@huawei.com, xin.zeng@intel.com, xuquan8@huawei.com, wanzongshun@huawei.com, stefanha@redhat.com, jianjay.zhou@huawei.com, cornelia.huck@de.ibm.com, longpeng2@huawei.com, arei.gonglei@hotmail.com, davem@davemloft.net, wu.wubin@huawei.com, herbert@gondor.apana.org.au



On 12/14/2016 12:50 PM, Gonglei wrote:
> diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
> new file mode 100644
> index 0000000..c0854a1
> --- /dev/null
> +++ b/drivers/crypto/virtio/virtio_crypto_core.c
> @@ -0,0 +1,474 @@
[..]
> +
> +static void virtcrypto_dataq_callback(struct virtqueue *vq)
> +{
> +	struct virtio_crypto *vcrypto = vq->vdev->priv;
> +	struct virtio_crypto_request *vc_req;
> +	unsigned long flags;
> +	unsigned int len;
> +	struct ablkcipher_request *ablk_req;
> +	int error;
> +
> +	spin_lock_irqsave(&vcrypto->lock, flags);

Would it make sense to use a per virtqueue lock
like in virtio_blk for example instead of locking on the whole
device? OK, it seems you use only one dataqueue, so it
may not be that relevant.

> +	do {
> +		virtqueue_disable_cb(vq);
> +		while ((vc_req = virtqueue_get_buf(vq, &len)) != NULL) {
> +			if (vc_req->type == VIRTIO_CRYPTO_SYM_OP_CIPHER) {
> +				switch (vc_req->status) {
> +				case VIRTIO_CRYPTO_OK:
> +					error = 0;
> +					break;
> +				case VIRTIO_CRYPTO_INVSESS:
> +				case VIRTIO_CRYPTO_ERR:
> +					error = -EINVAL;
> +					break;
> +				case VIRTIO_CRYPTO_BADMSG:
> +					error = -EBADMSG;
> +					break;
> +				default:
> +					error = -EIO;
> +					break;
> +				}
> +				ablk_req = vc_req->ablkcipher_req;
> +				virtcrypto_clear_request(vc_req);
> +
> +				spin_unlock_irqrestore(&vcrypto->lock, flags);
> +				/* Finish the encrypt or decrypt process */
> +				ablk_req->base.complete(&ablk_req->base, error);
> +				spin_lock_irqsave(&vcrypto->lock, flags);
> +			}
> +		}
> +	} while (!virtqueue_enable_cb(vq));
> +	spin_unlock_irqrestore(&vcrypto->lock, flags);
> +}
