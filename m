Received: from eggs.gnu.org ([2001:4830:134:3::10]:60521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ebJsD-0003QR-OS
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 00:33:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ebJsA-0008ND-Ls
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 00:33:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ebJsA-0008N6-DB
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 00:33:22 -0500
References: <20180110161438.GA28096@stefanha-x1.localdomain>
	<dcb849d4-82fb-de8a-5e81-23d47026c9eb@redhat.com>
	<20180111152345.GA7353@stefanha-x1.localdomain>
	<86106573-422b-fe4c-ec15-dad0edf05880@redhat.com>
	<20180112101807.GE7356@stefanha-x1.localdomain>
	<a45c1da8-03e8-140f-725c-af0f31e3da62@redhat.com>
	<5A5C5F7D.8070403@intel.com>
	<6b618d06-0891-fb3b-b845-8beae5649b22@redhat.com>
	<5A5C85DD.10705@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <dffa9693-18d8-6bb9-e024-0f137624494d@redhat.com>
Date: Tue, 16 Jan 2018 13:33:13 +0800
MIME-Version: 1.0
In-Reply-To: <5A5C85DD.10705@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] vhost-pci and virtio-vhost-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org



On 2018=E5=B9=B401=E6=9C=8815=E6=97=A5 18:43, Wei Wang wrote:
> On 01/15/2018 04:34 PM, Jason Wang wrote:
>>
>>
>> On 2018=E5=B9=B401=E6=9C=8815=E6=97=A5 15:59, Wei Wang wrote:
>>> On 01/15/2018 02:56 PM, Jason Wang wrote:
>>>>
>>>>
>>>> On 2018=E5=B9=B401=E6=9C=8812=E6=97=A5 18:18, Stefan Hajnoczi wrote:
>>>>>
>>>>
>>>> I just fail understand why we can't do software defined network or=20
>>>> storage with exist virtio device/drivers (or are there any=20
>>>> shortcomings that force us to invent new infrastructure).
>>>>
>>>
>>> Existing virtio-net works with a host central vSwitch, and it has=20
>>> the following disadvantages:
>>> 1) long code/data path;
>>> 2) poor scalability; and
>>> 3) host CPU sacrifice
>>
>> Please show me the numbers.
>
> Sure. For 64B packet transmission between two VMs: vhost-user reports=20
> ~6.8Mpps, and vhost-pci reports ~11Mpps, which is ~1.62x faster.
>

This result is kind of incomplete. So still many questions left:

- What's the configuration of the vhost-user?
- What's the result of e.g 1500 byte?
- You said it improves scalability, at least I can't get this conclusion=20
just from what you provide here
- You suspect long code/data path, but no latency numbers to prove it

>
>>
>>>
>>> Vhost-pci solves the above issues by providing a point-to-point=20
>>> communication between VMs. No matter how the control path would look=20
>>> like finally, the key point is that the data path is P2P between VMs.
>>>
>>> Best,
>>> Wei
>>>
>>>
>>
>> Well, I think I've pointed out several times in the replies of=20
>> previous versions. Both vhost-pci-net and virtio-net is an ethernet=20
>> device, which is not tied to a central vswitch for sure. There're=20
>> just too many methods or tricks which can be used to build a point to=20
>> point data path.
>
>
> Could you please show an existing example that makes virtio-net work=20
> without a host vswitch/bridge?

For vhost-user, it's as simple as a testpmd which does io forwarding=20
between two vhost ports? For kernel, you can do even more tricks, tc,=20
bpf or whatever others.

> Could you also share other p2p data path solutions that you have in=20
> mind? Thanks.
>
>
> Best,
> Wei
>

So my point stands still: both vhost-pci-net and virtio-net are ethernet=20
devices, any ethernet device can connect to each other directly without=20
switch. Saying virtio-net can not connect to each other directly without=20
a switch obviously make no sense, it's a network topology issue for=20
sure. Even if it was not a typical setup or configuration, extending the=20
exist backends is 1st choice unless you can prove there're any design=20
limitations of exist solutions.

Thanks
