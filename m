Received: from eggs.gnu.org ([2001:4830:134:3::10]:39076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dBdkA-0004T4-6c
	for qemu-devel@nongnu.org; Fri, 19 May 2017 04:58:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dBdk7-0004ee-3b
	for qemu-devel@nongnu.org; Fri, 19 May 2017 04:58:42 -0400
Received: from mga11.intel.com ([192.55.52.93]:33677)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dBdk6-0004dQ-QF
	for qemu-devel@nongnu.org; Fri, 19 May 2017 04:58:39 -0400
Message-ID: <591EB435.4080109@intel.com>
Date: Fri, 19 May 2017 17:00:37 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
	<a3f2cae3-5d3d-f620-4a8d-bb11470c0b08@redhat.com>
	<591AA65F.8080608@intel.com>
	<d6eb1d73-c791-b8d3-7ef3-a7653aef00d6@redhat.com>
	<7e1b48d5-83e6-a0ae-5d91-696d8db09d7c@redhat.com>
	<591D0EF5.9000807@intel.com>
	<d7df5484-7e08-4e1c-9e35-69d73858c736@redhat.com>
In-Reply-To: <d7df5484-7e08-4e1c-9e35-69d73858c736@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
To: Jason Wang <jasowang@redhat.com>, stefanha@gmail.com, marcandre.lureau@gmail.com, mst@redhat.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org

On 05/19/2017 11:10 AM, Jason Wang wrote:
>
>
> On 2017年05月18日 11:03, Wei Wang wrote:
>> On 05/17/2017 02:22 PM, Jason Wang wrote:
>>>
>>>
>>> On 2017年05月17日 14:16, Jason Wang wrote:
>>>>
>>>>
>>>> On 2017年05月16日 15:12, Wei Wang wrote:
>>>>>>>
>>>>>>
>>>>>> Hi:
>>>>>>
>>>>>> Care to post the driver codes too?
>>>>>>
>>>>> OK. It may take some time to clean up the driver code before post 
>>>>> it out. You can first
>>>>> have a check of the draft at the repo here:
>>>>> https://github.com/wei-w-wang/vhost-pci-driver
>>>>>
>>>>> Best,
>>>>> Wei
>>>>
>>>> Interesting, looks like there's one copy on tx side. We used to 
>>>> have zerocopy support for tun for VM2VM traffic. Could you please 
>>>> try to compare it with your vhost-pci-net by:
>>>>
>> We can analyze from the whole data path - from VM1's network stack to 
>> send packets -> VM2's
>> network stack to receive packets. The number of copies are actually 
>> the same for both.
>
> That's why I'm asking you to compare the performance. The only reason 
> for vhost-pci is performance. You should prove it.
>
>>
>> vhost-pci: 1-copy happen in VM1's driver xmit(), which copes packets 
>> from its network stack to VM2's
>> RX ring buffer. (we call it "zerocopy" because there is no 
>> intermediate copy between VMs)
>> zerocopy enabled vhost-net: 1-copy happen in tun's recvmsg, which 
>> copies packets from VM1's TX ring
>> buffer to VM2's RX ring buffer.
>
> Actually, there's a major difference here. You do copy in guest which 
> consumes time slice of vcpu thread on host. Vhost_net do this in its 
> own thread. So I feel vhost_net is even faster here, maybe I was wrong.
>

The code path using vhost_net is much longer - the Ping test shows that 
the zcopy based vhost_net reports around 0.237ms,
while using vhost-pci it reports around 0.06 ms.
For some environment issue, I can report the throughput number later.

>>
>> That being said, we compared to vhost-user, instead of vhost_net, 
>> because vhost-user is the one
>> that is used in NFV, which we think is a major use case for vhost-pci.
>
> If this is true, why not draft a pmd driver instead of a kernel one? 

Yes, that's right. There are actually two directions of the vhost-pci 
driver implementation - kernel driver
and dpdk pmd. The QEMU side device patches are first posted out for 
discussion, because when the device
part is ready, we will be able to have the related team work on the pmd 
driver as well. As usual, the pmd
driver would give a much better throughput.

So, I think at this stage we should focus on the device part review, and 
use the kernel driver to prove that
the device part design and implementation is reasonable and functional.


> And do you use virtio-net kernel driver to compare the performance? If 
> yes, has OVS dpdk optimized for kernel driver (I think not)?
>

We used the legacy OVS+DPDK.
Another thing with the existing OVS+DPDK usage is its centralization 
property. With vhost-pci, we will be able to
de-centralize the usage.

> What's more important, if vhost-pci is faster, I think its kernel 
> driver should be also faster than virtio-net, no?

Sorry about the confusion. We are actually not trying to use vhost-pci 
to replace virtio-net. Rather, vhost-pci
can be viewed as another type of backend for virtio-net to be used in 
NFV (the communication channel is
vhost-pci-net<->virtio_net).


Best,
Wei
