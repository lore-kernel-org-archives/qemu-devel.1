Received: from eggs.gnu.org ([2001:4830:134:3::10]:53192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ct9bh-0000By-FG
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 05:09:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ct9bc-0003iS-B2
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 05:09:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ct9bc-0003ha-4v
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 05:09:28 -0400
References: <93cb45b7-feca-9340-5fbe-3cc1e60d9e7e@redhat.com>
	<aa8f8830-9426-7cf5-ec99-363035315aa3@redhat.com>
	<24333171-ada3-cfe8-647a-61dc6839144b@redhat.com>
	<59720527-123d-de99-7066-7c9d392b1a42@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2286dd90-c63b-d4ac-4212-f43c4a1ed8f8@redhat.com>
Date: Wed, 29 Mar 2017 17:09:15 +0800
MIME-Version: 1.0
In-Reply-To: <59720527-123d-de99-7066-7c9d392b1a42@redhat.com>
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



On 2017=E5=B9=B403=E6=9C=8829=E6=97=A5 16:41, Paolo Bonzini wrote:
>
> On 29/03/2017 10:37, Jason Wang wrote:
>>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>>> index 03592c5..73e69ac 100644
>>> --- a/hw/virtio/virtio.c
>>> +++ b/hw/virtio/virtio.c
>>> @@ -176,6 +176,10 @@ err_used:
>>>        address_space_cache_destroy(&new->desc);
>>>    err_desc:
>>>        g_free(new);
>>> +    atomic_rcu_set(&vq->vring.caches, NULL);
>>> +    if (old) {
>>> +        call_rcu(old, virtio_free_region_cache, rcu);
>>> +    }
>>>    }
>>>
>>>    /* virt queue functions */
>>>
>>> Paolo
>> This looks a good fix but may not solve this issue completely. Depends
>> on the iova that guest uses, address_space_cache_init() may succeed ev=
en
>> in this case since vtd does a passthrough translation in this case.
> Can you explain this more?
>
> Paolo

Yes.  In this case, virtio-net-pci is not reset, but vtd has been reset.=20
So virtio-net-pci will still try to use the iova of ring to setup the=20
cache but now vtd treat iova as gpa since dmar has been disabled during=20
reset. (E.g In my test with Linux driver, desc map succeed but used fail.=
)

Thanks
