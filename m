Received: from eggs.gnu.org ([2001:4830:134:3::10]:36274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eRxnc-000789-Ru
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 05:10:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eRxnY-0006Ah-Jz
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 05:10:00 -0500
Received: from 1.mo177.mail-out.ovh.net ([178.33.107.143]:52068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eRxnY-00069k-Cu
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 05:09:56 -0500
Received: from player779.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id A864391EE3
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 11:09:54 +0100 (CET)
References: <20171209084338.29395-1-clg@kaod.org>
	<20171209084338.29395-3-clg@kaod.org>
	<20171220050947.GC5981@umbus.fritz.box>
	<1513815126.2743.34.camel@kernel.crashing.org>
	<6768575f-27e0-1277-3e7e-56ec44298e6a@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <106596f7-44eb-0cda-42fc-b552f6eb8dc6@kaod.org>
Date: Thu, 21 Dec 2017 11:09:48 +0100
MIME-Version: 1.0
In-Reply-To: <6768575f-27e0-1277-3e7e-56ec44298e6a@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 02/19] spapr: introduce a skeleton for
 the XIVE interrupt controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>

On 12/21/2017 10:16 AM, C=C3=A9dric Le Goater wrote:
> On 12/21/2017 01:12 AM, Benjamin Herrenschmidt wrote:
>> On Wed, 2017-12-20 at 16:09 +1100, David Gibson wrote:
>>>
>>> As you've suggested in yourself, I think we might need to more
>>> explicitly model the different components of the XIVE system.  As par=
t
>>> of that, I think you need to be clearer in this base skeleton about
>>> exactly what component your XIVE object represents.
>>>
>>> If the answer is "the overall thing" I suspect that's not what you
>>> want - I had one of those for XICs which proved to be a mistake
>>> (eventually replaced by the XICSFabric interface).
>>>
>>> Changing the model later isn't impossible, but doing so without
>>> breaking migration can be a real pain, so I think it's worth a
>>> reasonable effort to try and get it right initially.
>>
>> Note: we do need to speed things up a bit, as having exploitation mode
>> in KVM will significantly help with IPI performance among other things=
.
>>
>> I'm about ready to do the KVM bits. The one thing we need to discuss
>> and figure a good design for is how we map all those interrupt control
>> pages into qemu.
>>
>> Each interrupt (either PCIe pass-through or the "generic XIVE IPIs"
>> which are used for guest IPIs and for vio/virtio/emulated interrupts)
>> comes with a "control page" (ESB page) which needs to be mapped into
>> the guest, and the generic IPIs also come with a trigger page which
>> needs to be mapped into the guest for guest IPIs or OpenCAPI
>> interrupts, or just qemu for emulated devices.
>=20
> what about the OS TIMA page ? Do we trap the accesses in QEMU and
> forward them to KVM ? or do we use a similar mechanism.=20
>=20
>> Now that can be thousands of these critters. I certainly don't want to
>> create thousands of VMAs in qemu and even less thousands of memory
>> regions in KVM.
>=20
> we can provision one mapping per kvmppc_xive_src_block  maybe ? =20
>=20
>> So we need some kind of mechanism by wich a single large VMA gets
>> mmap'ed into qemu (or maybe a couple of these, but not too many) and
>> the interrupt pages can be assigned to slots in there and demand
>> faulted.
>=20
> Frederic has started to put in place a similar mecanism for OpenCAPI.
>=20
>> For the generic interrupts, this can probably be covered by KVM, addin=
g
>> some arch ioctls for allocating IPIs and mmap'ing that region etc...
>=20
> The KVM device has a ioctl handler :
>   =20
> 	struct kvm_device_ops {
>=20
> 		long (*ioctl)(struct kvm_device *dev, unsigned int ioctl,
> 			      unsigned long arg);
> 	};
>=20
> So a KVM device for the XIVE interrupt controller can implement a coupl=
e=20
> of extra calls for its need, like getting the VMA addresses, etc

or use set/get_attr.=20

I wonder if it would be possible to add a 'mmap' ops to kvm_device_fops=20
for the KVM_DEV_TYPE_XIVE device.=20

C.
