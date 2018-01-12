Received: from eggs.gnu.org ([2001:4830:134:3::10]:54122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eZq5b-0007eo-Di
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 22:33:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eZq5Y-0001jC-3H
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 22:33:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eZq5X-0001i9-RH
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 22:33:04 -0500
References: <20180110161438.GA28096@stefanha-x1.localdomain>
	<dcb849d4-82fb-de8a-5e81-23d47026c9eb@redhat.com>
	<20180111152345.GA7353@stefanha-x1.localdomain>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <86106573-422b-fe4c-ec15-dad0edf05880@redhat.com>
Date: Fri, 12 Jan 2018 11:32:56 +0800
MIME-Version: 1.0
In-Reply-To: <20180111152345.GA7353@stefanha-x1.localdomain>
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
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: wei.w.wang@intel.com, qemu-devel@nongnu.org



On 2018=E5=B9=B401=E6=9C=8811=E6=97=A5 23:23, Stefan Hajnoczi wrote:
> On Thu, Jan 11, 2018 at 06:57:03PM +0800, Jason Wang wrote:
>>
>> On 2018=E5=B9=B401=E6=9C=8811=E6=97=A5 00:14, Stefan Hajnoczi wrote:
>>> Hi Wei,
>>> I wanted to summarize the differences between the vhost-pci and
>>> virtio-vhost-user approaches because previous discussions may have be=
en
>>> confusing.
>>>
>>> vhost-pci defines a new virtio device type for each vhost device type
>>> (net, scsi, blk).  It therefore requires a virtio device driver for e=
ach
>>> device type inside the slave VM.
>>>
>>> Adding a new device type requires:
>>> 1. Defining a new virtio device type in the VIRTIO specification.
>>> 3. Implementing a new QEMU device model.
>>> 2. Implementing a new virtio driver.
>>>
>>> virtio-vhost-user is a single virtio device that acts as a vhost-user
>>> protocol transport for any vhost device type.  It requires one virtio
>>> driver inside the slave VM and device types are implemented using
>>> existing vhost-user slave libraries (librte_vhost in DPDK and
>>> libvhost-user in QEMU).
>>>
>>> Adding a new device type to virtio-vhost-user involves:
>>> 1. Adding any new vhost-user protocol messages to the QEMU
>>>      virtio-vhost-user device model.
>>> 2. Adding any new vhost-user protocol messages to the vhost-user slav=
e
>>>      library.
>>> 3. Implementing the new device slave.
>>>
>>> The simplest case is when no new vhost-user protocol messages are
>>> required for the new device.  Then all that's needed for
>>> virtio-vhost-user is a device slave implementation (#3).  That slave
>>> implementation will also work with AF_UNIX because the vhost-user sla=
ve
>>> library hides the transport (AF_UNIX vs virtio-vhost-user).  Even
>>> better, if another person has already implemented that device slave t=
o
>>> use with AF_UNIX then no new code is needed for virtio-vhost-user
>>> support at all!
>>>
>>> If you compare this to vhost-pci, it would be necessary to design a n=
ew
>>> virtio device, implement it in QEMU, and implement the virtio driver.
>>> Much of virtio driver is more or less the same thing as the vhost-use=
r
>>> device slave but it cannot be reused because the vhost-user protocol
>>> isn't being used by the virtio device.  The result is a lot of
>>> duplication in DPDK and other codebases that implement vhost-user
>>> slaves.
>>>
>>> The way that vhost-pci is designed means that anyone wishing to suppo=
rt
>>> a new device type has to become a virtio device designer.  They need =
to
>>> map vhost-user protocol concepts to a new virtio device type.  This w=
ill
>>> be time-consuming for everyone involved (e.g. the developer, the VIRT=
IO
>>> community, etc).
>>>
>>> The virtio-vhost-user approach stays at the vhost-user protocol level=
 as
>>> much as possible.  This way there are fewer concepts that need to be
>>> mapped by people adding new device types.  As a result, it will allow
>>> virtio-vhost-user to keep up with AF_UNIX vhost-user and grow because
>>> it's easier to work with.
>>>
>>> What do you think?
>>>
>>> Stefan
>> So a question is what's the motivation here?
>>
>> Form what I'm understanding, vhost-pci tries to build a scalable V2V p=
rivate
>> datapath. But according to what you describe here, virito-vhost-user t=
ries
>> to make it possible to implement the device inside another VM. I under=
stand
>> the goal of vhost-pci could be done on top, but it looks to me it woul=
d then
>> rather similar to the design of Xen driver domain. So I can not figure=
 out
>> how it can be done in a high performance way.
> vhost-pci and virtio-vhost-user both have the same goal.  They allow
> a VM to implement a vhost device (net, scsi, blk, etc).

Looks not, if I read the code correctly, vhost-pci has a device=20
implementation in qemu, and in slave VM it only have a vhost-pci-net driv=
er.

> This allows
> software defined network or storage appliances running inside a VM to
> provide I/O services to other VMs.

Well, I think we can do it even with the existed virtio or whatever=20
other emulated device which should not be bounded to any specific kind=20
of device.=C2=A0 And what's more important, according to the kvm 2016 sli=
des=20
of vhost-pci, the motivation of vhost-pci is not building SDN but a=20
chain of VNFs. So bypassing the central vswitch through a private VM2VM=20
path does make sense. (Though whether or not vhost-pci is the best=20
choice is still questionable).

>   To the other VMs the devices look
> like regular virtio devices.
>
> I'm not sure I understand your reference to the Xen driver domain or
> performance.

So what proposed here is basically memory sharing and event notification=20
through eventfd, this model have been used by Xen for many years through=20
grant table and event channel. Xen use this to move the backend=20
implementation from dom0 to a driver domain which has direct access to=20
some hardwares. Consider the case of network, it can then implement xen=20
netback inside driver domain which can access hardware NIC directly.

This makes sense for Xen and for performance since driver domain=20
(backend) can access hardware directly and event was triggered through=20
lower overhead hypercall (or it can do busypolling). But for=20
virtio-vhost-user, unless you want SRIOV based solutions inside the=20
slave VM, I believe we won't want to go back to Xen since the hardware=20
virtualization can bring extra overheads.

>   Both vhost-pci and virtio-vhost-user work using shared
> memory access to the guest RAM of the other VM.  Therefore they can pol=
l
> virtqueues and avoid vmexit.  They do also support cross-VM interrupts,
> thanks to QEMU setting up irqfd/ioeventfd appropriately on the host.
>
> Stefan

So in conclusion, consider the complexity, I would suggest to figure out=20
whether or not this (either vhost-pci or virito-vhost-user) is really=20
required before moving ahead. E.g, for VM2VM direct network path, this=20
looks simply an issue of network topology instead of the problem of=20
device, so there's a lot of trick, for vhost-user one can easily image=20
to write an application (or use testpmd) to build a zerocopied VM2VM=20
datapath, isn't this not sufficient for the case?

Thanks
