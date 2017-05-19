Received: from eggs.gnu.org ([2001:4830:134:3::10]:35062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dBdO9-00075L-3s
	for qemu-devel@nongnu.org; Fri, 19 May 2017 04:35:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dBdO5-00069p-Q0
	for qemu-devel@nongnu.org; Fri, 19 May 2017 04:35:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1dBdO5-00069V-2x
	for qemu-devel@nongnu.org; Fri, 19 May 2017 04:35:53 -0400
References: <20170511123246.31308-1-maxime.coquelin@redhat.com>
	<20170511123246.31308-7-maxime.coquelin@redhat.com>
	<20170511203345-mutt-send-email-mst@kernel.org>
	<62516ce5-9d4c-d021-c4ab-a767c7f07b31@redhat.com>
	<20170513025938-mutt-send-email-mst@kernel.org>
	<9f030e52-60ec-0b42-e0d0-6158eebf99d4@redhat.com>
	<20170516181455-mutt-send-email-mst@kernel.org>
	<c59af526-a290-1f11-2d34-6fad817a03d1@redhat.com>
	<779cdcfc-80df-373a-e772-3b14cd49a2ff@redhat.com>
	<ae30fce9-04d4-18b2-1b4a-fec9772f163c@redhat.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <deb4f3fb-0cce-798f-aa1b-c184cceb6a27@redhat.com>
Date: Fri, 19 May 2017 10:35:42 +0200
MIME-Version: 1.0
In-Reply-To: <ae30fce9-04d4-18b2-1b4a-fec9772f163c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/6] spec/vhost-user spec: Add IOMMU support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: yuanhan.liu@linux.intel.com, qemu-devel@nongnu.org, peterx@redhat.com, marcandre.lureau@gmail.com, wexu@redhat.com, vkaplans@redhat.com, jfreiman@redhat.com



On 05/19/2017 08:48 AM, Jason Wang wrote:
>=20
>=20
> On 2017=E5=B9=B405=E6=9C=8817=E6=97=A5 22:10, Maxime Coquelin wrote:
>>
>>
>> On 05/17/2017 04:53 AM, Jason Wang wrote:
>>>
>>>
>>> On 2017=E5=B9=B405=E6=9C=8816=E6=97=A5 23:16, Michael S. Tsirkin wrot=
e:
>>>> On Mon, May 15, 2017 at 01:45:28PM +0800, Jason Wang wrote:
>>>>>
>>>>> On 2017=E5=B9=B405=E6=9C=8813=E6=97=A5 08:02, Michael S. Tsirkin wr=
ote:
>>>>>> On Fri, May 12, 2017 at 04:21:58PM +0200, Maxime Coquelin wrote:
>>>>>>> On 05/11/2017 08:25 PM, Michael S. Tsirkin wrote:
>>>>>>>> On Thu, May 11, 2017 at 02:32:46PM +0200, Maxime Coquelin wrote:
>>>>>>>>> This patch specifies and implements the master/slave communicat=
ion
>>>>>>>>> to support device IOTLB in slave.
>>>>>>>>>
>>>>>>>>> The vhost_iotlb_msg structure introduced for kernel backends is
>>>>>>>>> re-used, making the design close between the two backends.
>>>>>>>>>
>>>>>>>>> An exception is the use of the secondary channel to enable the
>>>>>>>>> slave to send IOTLB miss requests to the master.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
>>>>>>>>> ---
>>>>>>>>>     docs/specs/vhost-user.txt | 75=20
>>>>>>>>> +++++++++++++++++++++++++++++++++++++++++++++++
>>>>>>>>>     hw/virtio/vhost-user.c    | 31 ++++++++++++++++++++
>>>>>>>>>     2 files changed, 106 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/docs/specs/vhost-user.txt b/docs/specs/vhost-user.=
txt
>>>>>>>>> index 5fa7016..4a1f0c3 100644
>>>>>>>>> --- a/docs/specs/vhost-user.txt
>>>>>>>>> +++ b/docs/specs/vhost-user.txt
>>>>>>>>> @@ -97,6 +97,23 @@ Depending on the request type, payload can b=
e:
>>>>>>>>>        log offset: offset from start of supplied file descripto=
r
>>>>>>>>>            where logging starts (i.e. where guest address 0=20
>>>>>>>>> would be logged)
>>>>>>>>> + * An IOTLB message
>>>>>>>>> + ---------------------------------------------------------
>>>>>>>>> +   | iova | size | user address | permissions flags | type |
>>>>>>>>> + ---------------------------------------------------------
>>>>>>>>> +
>>>>>>>>> +   IOVA: a 64-bit guest I/O virtual address
>>>>>>>> guest -> VM
>>>>>>> Ok.
>>>>>>>
>>>>>>>>> +   Size: a 64-bit size
>>>>>>>> How do you specify "all memory"? give special meaning to size 0?
>>>>>>> Good point, it does not support all memory currently.
>>>>>>> It is not vhost-user specific, but general to the vhost=20
>>>>>>> implementation.
>>>>>> But iommu needs it to support passthrough.
>>>>> Probably not, we will just pass the mappings in vhost_memory_region=
 to
>>>>> vhost. Its memory_size is also a __u64.
>>>>>
>>>>> Thanks
>>>> That's different since that's chunks of qemu virtual memory.
>>>>
>>>> IOMMU maps IOVA to GPA.
>>>>
>>>
>>> But we're in fact cache IOVA -> HVA mapping in the remote IOTLB. When=
=20
>>> passthrough mode is enabled, IOVA =3D=3D GPA, so passing mappings in=20
>>> vhost_memory_region should be fine.
>>
>> Not sure this is a good idea, because when configured in passthrough,
>> QEMU will see the IOMMU as enabled, so the the VIRTIO_F_IOMMU_PLATFORM
>> feature will be negotiated if both guest and backend support it.
>> So how the backend will know whether it should directly pick the
>> translation directly into the vhost_memory_region, or translate it
>> through the device IOTLB?
>=20
> This no need for backend to know about this, since IOVA equals to GPA,=20
> vhost_memory_region stores IOVA -> HVA mapping. If we pass them, device=
=20
> IOTLB should work as usual?

Ok, I think there were a misunderstanding. I understood you said there
were no need to use the device IOTLB in this case.

>=20
>>
>> Maybe the solution would be for QEMU to wrap "all memory" IOTLB update=
s
>> & invalidations to vhost_memory_regions, since the backend won't anywa=
y
>> be able to perform accesses outside these regions?
>=20
> This is just what I mean, you can refer Peter's series. >
>>
>>> The only possible "issue" with "all memory" is if you can not use a=20
>>> single TLB invalidation to invalidate all caches in remote TLB.
>>
>> If needed, maybe we could introduce a new VHOST_IOTLB_INVALIDATE messa=
ge
>> type?
>> For older kernel backend that doesn't support it, -EINVAL will be
>> returned, so QEMU could handle it another way in this case.
>=20
> We could, but not sure it was really needed.

I meant VHOST_IOTLB_INVALIDATE_ALL, and yes, I'm not sure this is
needed. But this is an option we have it turns out to be at some point.

Thanks,
Maxime
