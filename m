Received: from eggs.gnu.org ([2001:4830:134:3::10]:46776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ebjId-0004xn-EA
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 03:42:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ebjIa-0007Ro-7b
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 03:42:23 -0500
Received: from mga04.intel.com ([192.55.52.120]:53107)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1ebjIZ-0007RE-VR
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 03:42:20 -0500
Message-ID: <5A5F0CFD.5030204@intel.com>
Date: Wed, 17 Jan 2018 16:44:45 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <20180110161438.GA28096@stefanha-x1.localdomain>
	<dcb849d4-82fb-de8a-5e81-23d47026c9eb@redhat.com>
	<20180111152345.GA7353@stefanha-x1.localdomain>
	<86106573-422b-fe4c-ec15-dad0edf05880@redhat.com>
	<20180112101807.GE7356@stefanha-x1.localdomain>
	<a45c1da8-03e8-140f-725c-af0f31e3da62@redhat.com>
	<5A5C5F7D.8070403@intel.com>
	<6b618d06-0891-fb3b-b845-8beae5649b22@redhat.com>
	<5A5C85DD.10705@intel.com>
	<dffa9693-18d8-6bb9-e024-0f137624494d@redhat.com>
In-Reply-To: <dffa9693-18d8-6bb9-e024-0f137624494d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] vhost-pci and virtio-vhost-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org

On 01/16/2018 01:33 PM, Jason Wang wrote:
>
>
> On 2018年01月15日 18:43, Wei Wang wrote:
>> On 01/15/2018 04:34 PM, Jason Wang wrote:
>>>
>>>
>>> On 2018年01月15日 15:59, Wei Wang wrote:
>>>> On 01/15/2018 02:56 PM, Jason Wang wrote:
>>>>>
>>>>>
>>>>> On 2018年01月12日 18:18, Stefan Hajnoczi wrote:
>>>>>>
>>>>>
>>>>> I just fail understand why we can't do software defined network or 
>>>>> storage with exist virtio device/drivers (or are there any 
>>>>> shortcomings that force us to invent new infrastructure).
>>>>>
>>>>
>>>> Existing virtio-net works with a host central vSwitch, and it has 
>>>> the following disadvantages:
>>>> 1) long code/data path;
>>>> 2) poor scalability; and
>>>> 3) host CPU sacrifice
>>>
>>> Please show me the numbers.
>>
>> Sure. For 64B packet transmission between two VMs: vhost-user reports 
>> ~6.8Mpps, and vhost-pci reports ~11Mpps, which is ~1.62x faster.
>>
>
> This result is kind of incomplete. So still many questions left:
>
> - What's the configuration of the vhost-user?
> - What's the result of e.g 1500 byte?
> - You said it improves scalability, at least I can't get this 
> conclusion just from what you provide here
> - You suspect long code/data path, but no latency numbers to prove it
>

Had an offline meeting with Jason. The future discussion will be more 
focused on the design.

Here is a conclusion about more results we collected for 64B packet 
transmission, compared to ovs-dpdk (though we are comparing to ovs-dpdk 
here, but vhost-pci isn't meant to replace ovs-dpdk. It's for inter-VM 
communication, and packets going to the outside world will go from the 
traditional backend like ovs-dpdk):

1) 2VM communication: over 1.6x higher throughput;
2) 22% shorter latency;
3) in the 5-VM chain communication tests, vhost-pci shows ~6.5x higher 
throughput thanks to its better scalability

We'll provide 1500B test results later.

Best,
Wei
