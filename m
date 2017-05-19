Received: from eggs.gnu.org ([2001:4830:134:3::10]:53748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dBeb9-0002Ao-Ha
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:53:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dBeb6-0004Lg-DI
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:53:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dBeb6-0004LB-4N
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:53:24 -0400
References: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
	<a3f2cae3-5d3d-f620-4a8d-bb11470c0b08@redhat.com>
	<591AA65F.8080608@intel.com>
	<d6eb1d73-c791-b8d3-7ef3-a7653aef00d6@redhat.com>
	<7e1b48d5-83e6-a0ae-5d91-696d8db09d7c@redhat.com>
	<591D0EF5.9000807@intel.com>
	<d7df5484-7e08-4e1c-9e35-69d73858c736@redhat.com>
	<591EB435.4080109@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4aa88819-7d82-5172-0ccf-41211b416082@redhat.com>
Date: Fri, 19 May 2017 17:53:07 +0800
MIME-Version: 1.0
In-Reply-To: <591EB435.4080109@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [virtio-dev] Re: [virtio-dev] Re: [PATCH v2 00/16]
 Vhost-pci for inter-VM communication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>, stefanha@gmail.com, marcandre.lureau@gmail.com, mst@redhat.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org



On 2017=E5=B9=B405=E6=9C=8819=E6=97=A5 17:00, Wei Wang wrote:
> On 05/19/2017 11:10 AM, Jason Wang wrote:
>>
>>
>> On 2017=E5=B9=B405=E6=9C=8818=E6=97=A5 11:03, Wei Wang wrote:
>>> On 05/17/2017 02:22 PM, Jason Wang wrote:
>>>>
>>>>
>>>> On 2017=E5=B9=B405=E6=9C=8817=E6=97=A5 14:16, Jason Wang wrote:
>>>>>
>>>>>
>>>>> On 2017=E5=B9=B405=E6=9C=8816=E6=97=A5 15:12, Wei Wang wrote:
>>>>>>>>
>>>>>>>
>>>>>>> Hi:
>>>>>>>
>>>>>>> Care to post the driver codes too?
>>>>>>>
>>>>>> OK. It may take some time to clean up the driver code before post=20
>>>>>> it out. You can first
>>>>>> have a check of the draft at the repo here:
>>>>>> https://github.com/wei-w-wang/vhost-pci-driver
>>>>>>
>>>>>> Best,
>>>>>> Wei
>>>>>
>>>>> Interesting, looks like there's one copy on tx side. We used to=20
>>>>> have zerocopy support for tun for VM2VM traffic. Could you please=20
>>>>> try to compare it with your vhost-pci-net by:
>>>>>
>>> We can analyze from the whole data path - from VM1's network stack=20
>>> to send packets -> VM2's
>>> network stack to receive packets. The number of copies are actually=20
>>> the same for both.
>>
>> That's why I'm asking you to compare the performance. The only reason=20
>> for vhost-pci is performance. You should prove it.
>>
>>>
>>> vhost-pci: 1-copy happen in VM1's driver xmit(), which copes packets=20
>>> from its network stack to VM2's
>>> RX ring buffer. (we call it "zerocopy" because there is no=20
>>> intermediate copy between VMs)
>>> zerocopy enabled vhost-net: 1-copy happen in tun's recvmsg, which=20
>>> copies packets from VM1's TX ring
>>> buffer to VM2's RX ring buffer.
>>
>> Actually, there's a major difference here. You do copy in guest which=20
>> consumes time slice of vcpu thread on host. Vhost_net do this in its=20
>> own thread. So I feel vhost_net is even faster here, maybe I was wrong=
.
>>
>
> The code path using vhost_net is much longer - the Ping test shows=20
> that the zcopy based vhost_net reports around 0.237ms,
> while using vhost-pci it reports around 0.06 ms.
> For some environment issue, I can report the throughput number later.

Yes, vhost-pci should have better latency by design. But we should=20
measure pps or packet size other than 64 as well. I agree vhost_net has=20
bad latency, but this does not mean it could not be improved (just=20
because few people are working on improve this in the past), especially=20
we know the destination is another VM.

>
>>>
>>> That being said, we compared to vhost-user, instead of vhost_net,=20
>>> because vhost-user is the one
>>> that is used in NFV, which we think is a major use case for vhost-pci=
.
>>
>> If this is true, why not draft a pmd driver instead of a kernel one?=20
>
> Yes, that's right. There are actually two directions of the vhost-pci=20
> driver implementation - kernel driver
> and dpdk pmd. The QEMU side device patches are first posted out for=20
> discussion, because when the device
> part is ready, we will be able to have the related team work on the=20
> pmd driver as well. As usual, the pmd
> driver would give a much better throughput.

I think pmd should be easier for a prototype than kernel driver.

>
> So, I think at this stage we should focus on the device part review,=20
> and use the kernel driver to prove that
> the device part design and implementation is reasonable and functional.
>

Probably both.

>
>> And do you use virtio-net kernel driver to compare the performance?=20
>> If yes, has OVS dpdk optimized for kernel driver (I think not)?
>>
>
> We used the legacy OVS+DPDK.
> Another thing with the existing OVS+DPDK usage is its centralization=20
> property. With vhost-pci, we will be able to
> de-centralize the usage.
>

Right, so I think we should prove:

- For usage, prove or make vhost-pci better than existed share memory=20
based solution. (Or is virtio good at shared memory?)
- For performance, prove or make vhost-pci better than existed=20
centralized solution.

>> What's more important, if vhost-pci is faster, I think its kernel=20
>> driver should be also faster than virtio-net, no?
>
> Sorry about the confusion. We are actually not trying to use vhost-pci=20
> to replace virtio-net. Rather, vhost-pci
> can be viewed as another type of backend for virtio-net to be used in=20
> NFV (the communication channel is
> vhost-pci-net<->virtio_net).

My point is performance number is important for proving the correctness=20
for both design and engineering. If its slow, it has less interesting in=20
NFV.

Thanks

>
>
> Best,
> Wei
