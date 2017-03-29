Received: from eggs.gnu.org ([2001:4830:134:3::10]:44595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ct96n-0000uz-ES
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 04:37:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ct96k-0006F3-C1
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 04:37:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ct96k-0006Ev-6F
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 04:37:34 -0400
References: <93cb45b7-feca-9340-5fbe-3cc1e60d9e7e@redhat.com>
	<aa8f8830-9426-7cf5-ec99-363035315aa3@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <24333171-ada3-cfe8-647a-61dc6839144b@redhat.com>
Date: Wed, 29 Mar 2017 16:37:14 +0800
MIME-Version: 1.0
In-Reply-To: <aa8f8830-9426-7cf5-ec99-363035315aa3@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] issues of region cache and iommu reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu devel <qemu-devel@nongnu.org>, Cornelia Huck <cornelia.huck@de.ibm.com>



On 2017=E5=B9=B403=E6=9C=8829=E6=97=A5 16:09, Paolo Bonzini wrote:
>
> On 29/03/2017 10:00, Jason Wang wrote:
>>
>> 1) vtd was reset first
>>
>> 2) during the reset of virtio-net-pci #1, deletion of msix subregion
>> will cause a commit of all memory listeners
>>
>> 3) virito-net-pci #2's region cache will be update, but since vtd has
>> already been reset, it can't get a valid mappings here
>>
>> Any ideas on how to fix this? Need region cache be aware of IOMMU/IOTL=
B
>> state in this case? Or can we simply reset IOMMU as the last one?
> Something like this?
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 03592c5..73e69ac 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -176,6 +176,10 @@ err_used:
>       address_space_cache_destroy(&new->desc);
>   err_desc:
>       g_free(new);
> +    atomic_rcu_set(&vq->vring.caches, NULL);
> +    if (old) {
> +        call_rcu(old, virtio_free_region_cache, rcu);
> +    }
>   }
>
>   /* virt queue functions */
>
> Paolo

This looks a good fix but may not solve this issue completely. Depends=20
on the iova that guest uses, address_space_cache_init() may succeed even=20
in this case since vtd does a passthrough translation in this case.

Thanks
