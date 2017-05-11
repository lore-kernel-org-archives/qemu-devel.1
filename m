Received: from eggs.gnu.org ([2001:4830:134:3::10]:51635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d8pey-0006A6-P6
	for qemu-devel@nongnu.org; Thu, 11 May 2017 11:05:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d8pet-000487-PG
	for qemu-devel@nongnu.org; Thu, 11 May 2017 11:05:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d8pet-00047o-Ew
	for qemu-devel@nongnu.org; Thu, 11 May 2017 11:05:39 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4BEroXN028549
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 11:05:37 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2acnbj0hhq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 11:05:37 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Thu, 11 May 2017 16:05:33 +0100
Date: Thu, 11 May 2017 17:05:27 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <1494243504-127980-9-git-send-email-arei.gonglei@huawei.com>
References: <1494243504-127980-1-git-send-email-arei.gonglei@huawei.com>
	<1494243504-127980-9-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170511170527.5846a676.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [RFC v1 8/9] virtio-crypto: add host feature bits
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gonglei <arei.gonglei@huawei.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, weidong.huang@huawei.com, pasic@linux.vnet.ibm.com, stefanha@redhat.com, luonengjun@huawei.com, linqiangmin@huawei.com, xin.zeng@intel.com, wu.wubin@huawei.com

On Mon, 8 May 2017 19:38:23 +0800
Gonglei <arei.gonglei@huawei.com> wrote:

> We enable all feature bits acquiescently.
> 
> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> ---
>  hw/virtio/virtio-crypto.c         | 15 +++++++++++++++
>  include/hw/virtio/virtio-crypto.h |  1 +
>  2 files changed, 16 insertions(+)
> 
> diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
> index 5422f25..3dc0ff2 100644
> --- a/hw/virtio/virtio-crypto.c
> +++ b/hw/virtio/virtio-crypto.c
> @@ -1034,6 +1034,11 @@ static uint64_t virtio_crypto_get_features(VirtIODevice *vdev,
>                                             uint64_t features,
>                                             Error **errp)
>  {
> +    VirtIOCrypto *vcrypto = VIRTIO_CRYPTO(vdev);
> +
> +    /* Firstly sync all virtio-crypto possible supported features */
> +    features |= vcrypto->host_features;
> +
>      return features;
>  }
> 
> @@ -1144,6 +1149,16 @@ static const VMStateDescription vmstate_virtio_crypto = {
>  };
> 
>  static Property virtio_crypto_properties[] = {
> +    DEFINE_PROP_BIT("mux_mode", VirtIOCrypto, host_features,
> +                    VIRTIO_CRYPTO_F_MUX_MODE, true),
> +    DEFINE_PROP_BIT("cipher_stateless_mode", VirtIOCrypto, host_features,
> +                    VIRTIO_CRYPTO_F_CIPHER_STATELESS_MODE, true),
> +    DEFINE_PROP_BIT("hash_stateless_mode", VirtIOCrypto, host_features,
> +                    VIRTIO_CRYPTO_F_HASH_STATELESS_MODE, true),
> +    DEFINE_PROP_BIT("mac_stateless_mode", VirtIOCrypto, host_features,
> +                    VIRTIO_CRYPTO_F_MAC_STATELESS_MODE, true),
> +    DEFINE_PROP_BIT("aead_stateless_mode", VirtIOCrypto, host_features,
> +                    VIRTIO_CRYPTO_F_AEAD_STATELESS_MODE, true),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> 
> diff --git a/include/hw/virtio/virtio-crypto.h b/include/hw/virtio/virtio-crypto.h
> index 465ad20..30ea51d 100644
> --- a/include/hw/virtio/virtio-crypto.h
> +++ b/include/hw/virtio/virtio-crypto.h
> @@ -97,6 +97,7 @@ typedef struct VirtIOCrypto {
>      int multiqueue;
>      uint32_t curr_queues;
>      size_t config_size;
> +    uint32_t host_features;

I'd just make that 64 bits from the start.

>  } VirtIOCrypto;
> 
>  #endif /* _QEMU_VIRTIO_CRYPTO_H */

Don't you need some kind of compat handling?
