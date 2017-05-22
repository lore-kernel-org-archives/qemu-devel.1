Received: from eggs.gnu.org ([2001:4830:134:3::10]:49283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dCczd-0005Mp-7V
	for qemu-devel@nongnu.org; Sun, 21 May 2017 22:22:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dCcza-0007yG-3s
	for qemu-devel@nongnu.org; Sun, 21 May 2017 22:22:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dCczZ-0007y0-RB
	for qemu-devel@nongnu.org; Sun, 21 May 2017 22:22:42 -0400
References: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
	<a3f2cae3-5d3d-f620-4a8d-bb11470c0b08@redhat.com>
	<591AA65F.8080608@intel.com>
	<d6eb1d73-c791-b8d3-7ef3-a7653aef00d6@redhat.com>
	<7e1b48d5-83e6-a0ae-5d91-696d8db09d7c@redhat.com>
	<591D0EF5.9000807@intel.com>
	<d7df5484-7e08-4e1c-9e35-69d73858c736@redhat.com>
	<20170519194544-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0dfa00a2-7e22-f8b9-4ddb-a6dc5aa09fcc@redhat.com>
Date: Mon, 22 May 2017 10:22:31 +0800
MIME-Version: 1.0
In-Reply-To: <20170519194544-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, stefanha@gmail.com, qemu-devel@nongnu.org, Wei Wang <wei.w.wang@intel.com>, marcandre.lureau@gmail.com, pbonzini@redhat.com



On 2017=E5=B9=B405=E6=9C=8820=E6=97=A5 00:49, Michael S. Tsirkin wrote:
> On Fri, May 19, 2017 at 11:10:33AM +0800, Jason Wang wrote:
>>
>> On 2017=E5=B9=B405=E6=9C=8818=E6=97=A5 11:03, Wei Wang wrote:
>>> On 05/17/2017 02:22 PM, Jason Wang wrote:
>>>>
>>>> On 2017=E5=B9=B405=E6=9C=8817=E6=97=A5 14:16, Jason Wang wrote:
>>>>>
>>>>> On 2017=E5=B9=B405=E6=9C=8816=E6=97=A5 15:12, Wei Wang wrote:
>>>>>>> Hi:
>>>>>>>
>>>>>>> Care to post the driver codes too?
>>>>>>>
>>>>>> OK. It may take some time to clean up the driver code before
>>>>>> post it out. You can first
>>>>>> have a check of the draft at the repo here:
>>>>>> https://github.com/wei-w-wang/vhost-pci-driver
>>>>>>
>>>>>> Best,
>>>>>> Wei
>>>>> Interesting, looks like there's one copy on tx side. We used to
>>>>> have zerocopy support for tun for VM2VM traffic. Could you
>>>>> please try to compare it with your vhost-pci-net by:
>>>>>
>>> We can analyze from the whole data path - from VM1's network stack to
>>> send packets -> VM2's
>>> network stack to receive packets. The number of copies are actually t=
he
>>> same for both.
>> That's why I'm asking you to compare the performance. The only reason =
for
>> vhost-pci is performance. You should prove it.
>>
>>> vhost-pci: 1-copy happen in VM1's driver xmit(), which copes packets
>>> from its network stack to VM2's
>>> RX ring buffer. (we call it "zerocopy" because there is no intermedia=
te
>>> copy between VMs)
>>> zerocopy enabled vhost-net: 1-copy happen in tun's recvmsg, which cop=
ies
>>> packets from VM1's TX ring
>>> buffer to VM2's RX ring buffer.
>> Actually, there's a major difference here. You do copy in guest which
>> consumes time slice of vcpu thread on host. Vhost_net do this in its o=
wn
>> thread. So I feel vhost_net is even faster here, maybe I was wrong.
> Yes but only if you have enough CPUs. The point of vhost-pci
> is to put the switch in a VM and scale better with # of VMs.

Does the overall performance really increase? I suspect the only thing=20
vhost-pci gains here is probably scheduling cost and copying in guest=20
should be slower than doing it in host.

>
>>> That being said, we compared to vhost-user, instead of vhost_net,
>>> because vhost-user is the one
>>> that is used in NFV, which we think is a major use case for vhost-pci=
.
>> If this is true, why not draft a pmd driver instead of a kernel one? A=
nd do
>> you use virtio-net kernel driver to compare the performance? If yes, h=
as OVS
>> dpdk optimized for kernel driver (I think not)?
>>
>> What's more important, if vhost-pci is faster, I think its kernel driv=
er
>> should be also faster than virtio-net, no?
> If you have a vhost CPU per VCPU and can give a host CPU to each using
> that will be faster.  But not everyone has so many host CPUs.

If the major use case is NFV, we should have sufficient CPU resources I=20
believe?

Thanks

>
>
>>>
>>>>> - make sure zerocopy is enabled for vhost_net
>>>>> - comment skb_orphan_frags() in tun_net_xmit()
>>>>>
>>>>> Thanks
>>>>>
>>>> You can even enable tx batching for tun by ethtool -C tap0 rx-frames
>>>> N. This will greatly improve the performance according to my test.
>>>>
>>> Thanks, but would this hurt latency?
>>>
>>> Best,
>>> Wei
>> I don't see this in my test.
>>
>> Thanks
