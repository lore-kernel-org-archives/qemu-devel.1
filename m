Received: from eggs.gnu.org ([2001:4830:134:3::10]:39784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f6WbM-0000Px-GS
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 03:25:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f6WbJ-0001tu-Ax
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 03:25:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36034 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1f6WbJ-0001tV-6I
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 03:24:57 -0400
References: <20180411072027.5656-1-tiwei.bie@intel.com>
	<20180411161926-mutt-send-email-mst@kernel.org>
	<20180412011059.yywn73znjdip2cyv@debian>
	<20180412042724-mutt-send-email-mst@kernel.org>
	<20180412013942.egucc4isxkokta7z@debian>
	<20180412044404-mutt-send-email-mst@kernel.org>
	<1726abc8-92ff-420a-adbd-c08e9fa251d2@redhat.com>
	<20180412063824-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c6aec3eb-602e-1802-b7b8-800ebc77cb99@redhat.com>
Date: Thu, 12 Apr 2018 15:24:37 +0800
MIME-Version: 1.0
In-Reply-To: <20180412063824-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] vhost-user: introduce F_NEED_ALL_IOTLB
 protocol feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Tiwei Bie <tiwei.bie@intel.com>, cunming.liang@intel.com, qemu-devel@nongnu.org, peterx@redhat.com, zhihong.wang@intel.com, dan.daly@intel.com



On 2018=E5=B9=B404=E6=9C=8812=E6=97=A5 11:41, Michael S. Tsirkin wrote:
> On Thu, Apr 12, 2018 at 11:37:35AM +0800, Jason Wang wrote:
>>
>> On 2018=E5=B9=B404=E6=9C=8812=E6=97=A5 09:57, Michael S. Tsirkin wrote=
:
>>> On Thu, Apr 12, 2018 at 09:39:43AM +0800, Tiwei Bie wrote:
>>>> On Thu, Apr 12, 2018 at 04:29:29AM +0300, Michael S. Tsirkin wrote:
>>>>> On Thu, Apr 12, 2018 at 09:10:59AM +0800, Tiwei Bie wrote:
>>>>>> On Wed, Apr 11, 2018 at 04:22:21PM +0300, Michael S. Tsirkin wrote=
:
>>>>>>> On Wed, Apr 11, 2018 at 03:20:27PM +0800, Tiwei Bie wrote:
>>>>>>>> This patch introduces VHOST_USER_PROTOCOL_F_NEED_ALL_IOTLB
>>>>>>>> feature for vhost-user. By default, vhost-user backend needs
>>>>>>>> to query the IOTLBs from QEMU after meeting unknown IOVAs.
>>>>>>>> With this protocol feature negotiated, QEMU will provide all
>>>>>>>> the IOTLBs to vhost-user backend without waiting for the
>>>>>>>> queries from backend. This is helpful when using a hardware
>>>>>>>> accelerator which is not able to handle unknown IOVAs at the
>>>>>>>> vhost-user backend.
>>>>>>>>
>>>>>>>> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
>>>>>>> This is potentially a large amount of data to be sent
>>>>>>> on a socket.
>>>>>> If we take the hardware accelerator out of this picture, we
>>>>>> will find that it's actually a question of "pre-loading" vs
>>>>>> "lazy-loading". I think neither of them is perfect.
>>>>>>
>>>>>> For "pre-loading", as you said, we may have a tough starting.
>>>>>> But for "lazy-loading", we can't have a predictable performance.
>>>>>> A sudden, unexpected performance drop may happen at any time,
>>>>>> because we may meet an unknown IOVA at any time in this case.
>>>>> That's how hardware behaves too though. So we can expect guests
>>>>> to try to optimize locality.
>>>> The difference is that, the software implementation needs to
>>>> query the mappings via socket. And it's much slower..
>>> If you are proposing this new feature as an optimization,
>>> then I'd like to see numbers showing the performance gains.
>>>
>>> It's definitely possible to optimize things out.  Pre-loading isn't
>>> where I would start optimizing though.  For example, DPDK could have =
its
>>> own VTD emulation, then it could access guest memory directly.
>> Have vtd emulation in dpdk have many disadvantages:
>>
>> - vendor locked, can only work for intel
> I don't see what would prevent other vendors from doing the same.

Technically it can, two questions here:

- Shouldn't we keep vhost-user vendor/transport independent?
- Do we really prefer the split device model here, it means to implement=20
datapath in two places at least. Personally I prefer to keep all virt=20
stuffs inside qemu.

>
>> - duplication of codes and bugs
>> - a huge number of new message types needs to be invented
> Oh, just the flush I'd wager.

Not only flush, but also error reporting, context entry programming and=20
even PRS in the future. And we need a feature negotiation between them=20
like vhost to keep the compatibility for future features. This sounds=20
not good.

>
>> So I tend to go to a reverse way, link dpdk to qemu.
> Won't really help as people want to build software using dpdk.

Well I believe the main use case it vDPA which is hardware virtio=20
offload. For building software using dpdk like ovs-dpdk, it's another=20
interesting topic. We can seek solution other than linking dpdk to qemu,=20
e.g we can do all virtio and packet copy stuffs inside a qemu IOThread=20
and use another inter-process channel to communicate with OVS-dpdk (or=20
another virtio-user here). The key is to hide all virtualization details=20
from OVS-dpdk.

>
>
>>>
>>>>>> Once we meet an unknown IOVA, the backend's data path will need
>>>>>> to stop and query the mapping of the IOVA via the socket and
>>>>>> wait for the reply. And the latency is not negligible (sometimes
>>>>>> it's even unacceptable), especially in high performance network
>>>>>> case. So maybe it's better to make both of them available to
>>>>>> the vhost backend.
>>>>>>
>>>>>>> I had an impression that a hardware accelerator was using
>>>>>>> VFIO anyway. Given this, can't we have QEMU program
>>>>>>> the shadow IOMMU tables into VFIO directly?
>>>>>> I think it's a good idea! Currently, my concern about it is
>>>>>> that, the hardware device may not use IOMMU and it may have
>>>>>> its builtin address translation unit. And it will be a pain
>>>>>> for device vendors to teach VFIO to be able to work with the
>>>>>> builtin address translation unit.
>>>>> I think such drivers would have to interate with VFIO somehow.
>>>>> Otherwise, what is the plan for assigning such devices then?
>>>> Such devices are just for vhost data path acceleration.
>>> That's not true I think.  E.g. RDMA devices have an on-card MMU.
>>>
>>>> They have many available queue pairs, the switch logic
>>>> will be done among those queue pairs. And different queue
>>>> pairs will serve different VMs directly.
>>>>
>>>> Best regards,
>>>> Tiwei Bie
>>> The way I would do it is attach different PASID values to
>>> different queues. This way you can use the standard IOMMU
>>> to enforce protection.
>> So that's just shared virtual memory on host which can share iova addr=
ess
>> space between a specific queue pair and a process. I'm not sure how ha=
rd can
>> exist vhost-user backend to support this.
>>
>> Thanks
> That would be VFIO's job, nothing to do with vhost-user besides
> sharing the VFIO descriptor.

At least dpdk need to offload DMA mapping setup to qemu.

Thanks
