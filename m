Received: from eggs.gnu.org ([2001:4830:134:3::10]:50498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ctPbj-0002KE-HU
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 22:14:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ctPbf-0003pS-H8
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 22:14:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ctPbf-0003oH-93
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 22:14:35 -0400
References: <93cb45b7-feca-9340-5fbe-3cc1e60d9e7e@redhat.com>
	<aa8f8830-9426-7cf5-ec99-363035315aa3@redhat.com>
	<20170329104511.6dfa132c.cornelia.huck@de.ibm.com>
	<da3b6453-650d-5f57-bab6-0b7b4b86d664@redhat.com>
	<20170329133911.10581d99.cornelia.huck@de.ibm.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <60fa3a1a-a346-c6db-96aa-6e438db84ef0@redhat.com>
Date: Thu, 30 Mar 2017 10:14:25 +0800
MIME-Version: 1.0
In-Reply-To: <20170329133911.10581d99.cornelia.huck@de.ibm.com>
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
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu devel <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>



On 2017=E5=B9=B403=E6=9C=8829=E6=97=A5 19:39, Cornelia Huck wrote:
> On Wed, 29 Mar 2017 17:18:00 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>
>> On 2017=E5=B9=B403=E6=9C=8829=E6=97=A5 16:45, Cornelia Huck wrote:
>>> On Wed, 29 Mar 2017 10:09:10 +0200
>>> Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>
>>>> On 29/03/2017 10:00, Jason Wang wrote:
>>>>> 1) vtd was reset first
>>>>>
>>>>> 2) during the reset of virtio-net-pci #1, deletion of msix subregio=
n
>>>>> will cause a commit of all memory listeners
>>>>>
>>>>> 3) virito-net-pci #2's region cache will be update, but since vtd h=
as
>>>>> already been reset, it can't get a valid mappings here
>>>>>
>>>>> Any ideas on how to fix this? Need region cache be aware of IOMMU/I=
OTLB
>>>>> state in this case? Or can we simply reset IOMMU as the last one?
>>>> Something like this?
>>>>
>>>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>>>> index 03592c5..73e69ac 100644
>>>> --- a/hw/virtio/virtio.c
>>>> +++ b/hw/virtio/virtio.c
>>>> @@ -176,6 +176,10 @@ err_used:
>>>>        address_space_cache_destroy(&new->desc);
>>>>    err_desc:
>>>>        g_free(new);
>>>> +    atomic_rcu_set(&vq->vring.caches, NULL);
>>>> +    if (old) {
>>>> +        call_rcu(old, virtio_free_region_cache, rcu);
>>>> +    }
>>> Maybe I'm just confused here, but isn't ->broken enough to prevent
>>> further accesses?
>> Looks not (e.g virtio_queue_update_used_idx() that was called by vhost=
).
> We probably should take care that we don't do things like that for
> broken devices. But that ties into the virtio_error() discussion, and
> we probably want to revisit that in that context.

Yes, but the issue here is, the device should not be treated as broken=20
since it does nothing wrong.

>
>> We only have pfn check for all helpers now.
> So we'll assert() after that change?

I think we don't want assert too, since it was a indicator of bug somewhe=
re.

>
>>> And a reset will unset both ->broken and the caches
>>> anyway? What am I missing?
>> Yes, but is it good to store invalid or even wrong mappings in the cac=
he?
> Not really; but I'd like to see ->broken as a kind of master indicator
> "this device does not work, do not trust/use anything until it has been
> reset".
>

Then I guess we probably check broken for all exported helpers like what=20
we did for gfn.

Thanks
