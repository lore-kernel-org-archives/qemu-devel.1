Received: from eggs.gnu.org ([2001:4830:134:3::10]:33304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eayhJ-0006p1-4E
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 01:56:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eayhD-0006JX-4T
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 01:56:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eayhC-0006Iq-Rm
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 01:56:39 -0500
References: <20180110161438.GA28096@stefanha-x1.localdomain>
	<dcb849d4-82fb-de8a-5e81-23d47026c9eb@redhat.com>
	<20180111152345.GA7353@stefanha-x1.localdomain>
	<86106573-422b-fe4c-ec15-dad0edf05880@redhat.com>
	<20180112101807.GE7356@stefanha-x1.localdomain>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a45c1da8-03e8-140f-725c-af0f31e3da62@redhat.com>
Date: Mon, 15 Jan 2018 14:56:31 +0800
MIME-Version: 1.0
In-Reply-To: <20180112101807.GE7356@stefanha-x1.localdomain>
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



On 2018=E5=B9=B401=E6=9C=8812=E6=97=A5 18:18, Stefan Hajnoczi wrote:
>>>> Form what I'm understanding, vhost-pci tries to build a scalable V2V=
 private
>>>> datapath. But according to what you describe here, virito-vhost-user=
 tries
>>>> to make it possible to implement the device inside another VM. I und=
erstand
>>>> the goal of vhost-pci could be done on top, but it looks to me it wo=
uld then
>>>> rather similar to the design of Xen driver domain. So I can not figu=
re out
>>>> how it can be done in a high performance way.
>>> vhost-pci and virtio-vhost-user both have the same goal.  They allow
>>> a VM to implement a vhost device (net, scsi, blk, etc).
>> Looks not, if I read the code correctly, vhost-pci has a device
>> implementation in qemu, and in slave VM it only have a vhost-pci-net d=
river.
> You are right that the current "[PATCH v3 0/7] Vhost-pci for inter-VM
> communication" does not reach this goal yet.  The patch series focusses
> on a subset of vhost-user-net for poll mode drivers.
>
> But the goal is to eventually let VMs implement any vhost device type.
> Even if Wei, you, or I don't implement scsi, for example, someone else
> should be able to do it based on vhost-pci or virtio-vhost-user.
>
> Wei: Do you agree?
>
>>> This allows
>>> software defined network or storage appliances running inside a VM to
>>> provide I/O services to other VMs.
>> Well, I think we can do it even with the existed virtio or whatever ot=
her
>> emulated device which should not be bounded to any specific kind of de=
vice.
> Please explain the approach you have in mind.

I just fail understand why we can't do software defined network or=20
storage with exist virtio device/drivers (or are there any shortcomings=20
that force us to invent new infrastructure).

>
>> And what's more important, according to the kvm 2016 slides of vhost-p=
ci,
>> the motivation of vhost-pci is not building SDN but a chain of VNFs. S=
o
>> bypassing the central vswitch through a private VM2VM path does make s=
ense.
>> (Though whether or not vhost-pci is the best choice is still questiona=
ble).
> This is probably my fault.  Maybe my networking terminology is wrong.  =
I
> consider "virtual network functions" to be part of "software-defined
> networking" use cases.  I'm not implying there must be a central virtua=
l
> switch.
>
> To rephrase: vhost-pci enables exitless VM2VM communication.

The problem is, exitless is not what vhost-pci invents, it could be=20
achieved now when both sides are doing busypolling.

>
>>>    To the other VMs the devices look
>>> like regular virtio devices.
>>>
>>> I'm not sure I understand your reference to the Xen driver domain or
>>> performance.
>> So what proposed here is basically memory sharing and event notificati=
on
>> through eventfd, this model have been used by Xen for many years throu=
gh
>> grant table and event channel. Xen use this to move the backend
>> implementation from dom0 to a driver domain which has direct access to=
 some
>> hardwares. Consider the case of network, it can then implement xen net=
back
>> inside driver domain which can access hardware NIC directly.
>>
>> This makes sense for Xen and for performance since driver domain (back=
end)
>> can access hardware directly and event was triggered through lower ove=
rhead
>> hypercall (or it can do busypolling). But for virtio-vhost-user, unles=
s you
>> want SRIOV based solutions inside the slave VM, I believe we won't wan=
t to
>> go back to Xen since the hardware virtualization can bring extra overh=
eads.
> Okay, this point is about the NFV use case.  I can't answer that becaus=
e
> I'm not familiar with it.
>
> Even if the NFV use case is not ideal for VMs, there are many other use
> cases for VMs implementing vhost devices.  In the cloud the VM is the
> first-class object that users can manage.  They do not have the ability
> to run vhost-user processes on the host.  Therefore I/O appliances need
> to be able to run as VMs and vhost-pci (or virtio-vhost-user) solve tha=
t
> problem.

The question is why must use vhost-user? E.g in the case of SDN, you can=20
easily deploy an OVS instance with openflow inside a VM and it works=20
like a charm.

>
>>>    Both vhost-pci and virtio-vhost-user work using shared
>>> memory access to the guest RAM of the other VM.  Therefore they can p=
oll
>>> virtqueues and avoid vmexit.  They do also support cross-VM interrupt=
s,
>>> thanks to QEMU setting up irqfd/ioeventfd appropriately on the host.
>>>
>>> Stefan
>> So in conclusion, consider the complexity, I would suggest to figure o=
ut
>> whether or not this (either vhost-pci or virito-vhost-user) is really
>> required before moving ahead. E.g, for VM2VM direct network path, this=
 looks
>> simply an issue of network topology instead of the problem of device, =
so
>> there's a lot of trick, for vhost-user one can easily image to write a=
n
>> application (or use testpmd) to build a zerocopied VM2VM datapath, isn=
't
>> this not sufficient for the case?
> See above, I described the general cloud I/O appliance use case.
>
> Stefan

So I understand vhost-user could be used to build I/O appliance. What I=20
don't understand is, the advantages of using vhost-user or why we must=20
use it inside a guest.

Thanks
