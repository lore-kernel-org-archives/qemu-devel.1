Received: from eggs.gnu.org ([2001:4830:134:3::10]:55469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dBYJZ-0004gt-VS
	for qemu-devel@nongnu.org; Thu, 18 May 2017 23:11:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dBYJS-0008ME-L9
	for qemu-devel@nongnu.org; Thu, 18 May 2017 23:10:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dBYJS-0008G5-1F
	for qemu-devel@nongnu.org; Thu, 18 May 2017 23:10:46 -0400
References: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
	<a3f2cae3-5d3d-f620-4a8d-bb11470c0b08@redhat.com>
	<591AA65F.8080608@intel.com>
	<d6eb1d73-c791-b8d3-7ef3-a7653aef00d6@redhat.com>
	<7e1b48d5-83e6-a0ae-5d91-696d8db09d7c@redhat.com>
	<591D0EF5.9000807@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d7df5484-7e08-4e1c-9e35-69d73858c736@redhat.com>
Date: Fri, 19 May 2017 11:10:33 +0800
MIME-Version: 1.0
In-Reply-To: <591D0EF5.9000807@intel.com>
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



On 2017=E5=B9=B405=E6=9C=8818=E6=97=A5 11:03, Wei Wang wrote:
> On 05/17/2017 02:22 PM, Jason Wang wrote:
>>
>>
>> On 2017=E5=B9=B405=E6=9C=8817=E6=97=A5 14:16, Jason Wang wrote:
>>>
>>>
>>> On 2017=E5=B9=B405=E6=9C=8816=E6=97=A5 15:12, Wei Wang wrote:
>>>>>>
>>>>>
>>>>> Hi:
>>>>>
>>>>> Care to post the driver codes too?
>>>>>
>>>> OK. It may take some time to clean up the driver code before post=20
>>>> it out. You can first
>>>> have a check of the draft at the repo here:
>>>> https://github.com/wei-w-wang/vhost-pci-driver
>>>>
>>>> Best,
>>>> Wei
>>>
>>> Interesting, looks like there's one copy on tx side. We used to have=20
>>> zerocopy support for tun for VM2VM traffic. Could you please try to=20
>>> compare it with your vhost-pci-net by:
>>>
> We can analyze from the whole data path - from VM1's network stack to=20
> send packets -> VM2's
> network stack to receive packets. The number of copies are actually=20
> the same for both.

That's why I'm asking you to compare the performance. The only reason=20
for vhost-pci is performance. You should prove it.

>
> vhost-pci: 1-copy happen in VM1's driver xmit(), which copes packets=20
> from its network stack to VM2's
> RX ring buffer. (we call it "zerocopy" because there is no=20
> intermediate copy between VMs)
> zerocopy enabled vhost-net: 1-copy happen in tun's recvmsg, which=20
> copies packets from VM1's TX ring
> buffer to VM2's RX ring buffer.

Actually, there's a major difference here. You do copy in guest which=20
consumes time slice of vcpu thread on host. Vhost_net do this in its own=20
thread. So I feel vhost_net is even faster here, maybe I was wrong.

>
> That being said, we compared to vhost-user, instead of vhost_net,=20
> because vhost-user is the one
> that is used in NFV, which we think is a major use case for vhost-pci.

If this is true, why not draft a pmd driver instead of a kernel one? And=20
do you use virtio-net kernel driver to compare the performance? If yes,=20
has OVS dpdk optimized for kernel driver (I think not)?

What's more important, if vhost-pci is faster, I think its kernel driver=20
should be also faster than virtio-net, no?

>
>
>>> - make sure zerocopy is enabled for vhost_net
>>> - comment skb_orphan_frags() in tun_net_xmit()
>>>
>>> Thanks
>>>
>>
>> You can even enable tx batching for tun by ethtool -C tap0 rx-frames=20
>> N. This will greatly improve the performance according to my test.
>>
>
> Thanks, but would this hurt latency?
>
> Best,
> Wei

I don't see this in my test.

Thanks
