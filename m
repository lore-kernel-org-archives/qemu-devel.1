Received: from eggs.gnu.org ([2001:4830:134:3::10]:40559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dAp6E-0004DY-Ou
	for qemu-devel@nongnu.org; Tue, 16 May 2017 22:54:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dAp6B-0003fn-NZ
	for qemu-devel@nongnu.org; Tue, 16 May 2017 22:54:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dAp6B-0003fE-EW
	for qemu-devel@nongnu.org; Tue, 16 May 2017 22:54:03 -0400
References: <20170511123246.31308-1-maxime.coquelin@redhat.com>
	<20170511123246.31308-7-maxime.coquelin@redhat.com>
	<20170511203345-mutt-send-email-mst@kernel.org>
	<62516ce5-9d4c-d021-c4ab-a767c7f07b31@redhat.com>
	<20170513025938-mutt-send-email-mst@kernel.org>
	<9f030e52-60ec-0b42-e0d0-6158eebf99d4@redhat.com>
	<20170516181455-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c59af526-a290-1f11-2d34-6fad817a03d1@redhat.com>
Date: Wed, 17 May 2017 10:53:44 +0800
MIME-Version: 1.0
In-Reply-To: <20170516181455-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: yuanhan.liu@linux.intel.com, qemu-devel@nongnu.org, peterx@redhat.com, Maxime Coquelin <maxime.coquelin@redhat.com>, marcandre.lureau@gmail.com, wexu@redhat.com, vkaplans@redhat.com, jfreiman@redhat.com



On 2017=E5=B9=B405=E6=9C=8816=E6=97=A5 23:16, Michael S. Tsirkin wrote:
> On Mon, May 15, 2017 at 01:45:28PM +0800, Jason Wang wrote:
>>
>> On 2017=E5=B9=B405=E6=9C=8813=E6=97=A5 08:02, Michael S. Tsirkin wrote=
:
>>> On Fri, May 12, 2017 at 04:21:58PM +0200, Maxime Coquelin wrote:
>>>> On 05/11/2017 08:25 PM, Michael S. Tsirkin wrote:
>>>>> On Thu, May 11, 2017 at 02:32:46PM +0200, Maxime Coquelin wrote:
>>>>>> This patch specifies and implements the master/slave communication
>>>>>> to support device IOTLB in slave.
>>>>>>
>>>>>> The vhost_iotlb_msg structure introduced for kernel backends is
>>>>>> re-used, making the design close between the two backends.
>>>>>>
>>>>>> An exception is the use of the secondary channel to enable the
>>>>>> slave to send IOTLB miss requests to the master.
>>>>>>
>>>>>> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
>>>>>> ---
>>>>>>     docs/specs/vhost-user.txt | 75 +++++++++++++++++++++++++++++++=
++++++++++++++++
>>>>>>     hw/virtio/vhost-user.c    | 31 ++++++++++++++++++++
>>>>>>     2 files changed, 106 insertions(+)
>>>>>>
>>>>>> diff --git a/docs/specs/vhost-user.txt b/docs/specs/vhost-user.txt
>>>>>> index 5fa7016..4a1f0c3 100644
>>>>>> --- a/docs/specs/vhost-user.txt
>>>>>> +++ b/docs/specs/vhost-user.txt
>>>>>> @@ -97,6 +97,23 @@ Depending on the request type, payload can be:
>>>>>>        log offset: offset from start of supplied file descriptor
>>>>>>            where logging starts (i.e. where guest address 0 would =
be logged)
>>>>>> + * An IOTLB message
>>>>>> +   ---------------------------------------------------------
>>>>>> +   | iova | size | user address | permissions flags | type |
>>>>>> +   ---------------------------------------------------------
>>>>>> +
>>>>>> +   IOVA: a 64-bit guest I/O virtual address
>>>>> guest -> VM
>>>> Ok.
>>>>
>>>>>> +   Size: a 64-bit size
>>>>> How do you specify "all memory"? give special meaning to size 0?
>>>> Good point, it does not support all memory currently.
>>>> It is not vhost-user specific, but general to the vhost implementati=
on.
>>> But iommu needs it to support passthrough.
>> Probably not, we will just pass the mappings in vhost_memory_region to
>> vhost. Its memory_size is also a __u64.
>>
>> Thanks
> That's different since that's chunks of qemu virtual memory.
>
> IOMMU maps IOVA to GPA.
>

But we're in fact cache IOVA -> HVA mapping in the remote IOTLB. When=20
passthrough mode is enabled, IOVA =3D=3D GPA, so passing mappings in=20
vhost_memory_region should be fine.

The only possible "issue" with "all memory" is if you can not use a=20
single TLB invalidation to invalidate all caches in remote TLB. But this=20
is only theoretical problem since it only happen when we have a 1 byte=20
mapping [2^64 - 1, 2^64) cached in remote TLB. Consider:

- E.g intel IOMMU has a range limitation for invalidation (1G currently)
- Looks like all existed IOMMU use page aligned mappings

It was probably not a big issue. And for safety we could use two=20
invalidations to make sure all caches were flushed remotely. Or just=20
change the protocol from start, size to start, end. Vhost-kernel is=20
probably too late for this change, but I'm still not quite sure it is=20
worthwhile.

Thanks
