Received: from eggs.gnu.org ([2001:4830:134:3::10]:58940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1eS9kM-0001n4-Ky
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 17:55:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1eS9kJ-0004d8-GG
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 17:55:26 -0500
Message-ID: <1513896817.2743.63.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 22 Dec 2017 09:53:37 +1100
In-Reply-To: <6768575f-27e0-1277-3e7e-56ec44298e6a@kaod.org>
References: <20171209084338.29395-1-clg@kaod.org>
	<20171209084338.29395-3-clg@kaod.org>
	<20171220050947.GC5981@umbus.fritz.box>
	<1513815126.2743.34.camel@kernel.crashing.org>
	<6768575f-27e0-1277-3e7e-56ec44298e6a@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>

On Thu, 2017-12-21 at 10:16 +0100, C=C3=A9dric Le Goater wrote:
> On 12/21/2017 01:12 AM, Benjamin Herrenschmidt wrote:
> > On Wed, 2017-12-20 at 16:09 +1100, David Gibson wrote:
> > >=20
> > > As you've suggested in yourself, I think we might need to more
> > > explicitly model the different components of the XIVE system.  As p=
art
> > > of that, I think you need to be clearer in this base skeleton about
> > > exactly what component your XIVE object represents.
> > >=20
> > > If the answer is "the overall thing" I suspect that's not what you
> > > want - I had one of those for XICs which proved to be a mistake
> > > (eventually replaced by the XICSFabric interface).
> > >=20
> > > Changing the model later isn't impossible, but doing so without
> > > breaking migration can be a real pain, so I think it's worth a
> > > reasonable effort to try and get it right initially.
> >=20
> > Note: we do need to speed things up a bit, as having exploitation mod=
e
> > in KVM will significantly help with IPI performance among other thing=
s.
> >=20
> > I'm about ready to do the KVM bits. The one thing we need to discuss
> > and figure a good design for is how we map all those interrupt contro=
l
> > pages into qemu.
> >=20
> > Each interrupt (either PCIe pass-through or the "generic XIVE IPIs"
> > which are used for guest IPIs and for vio/virtio/emulated interrupts)
> > comes with a "control page" (ESB page) which needs to be mapped into
> > the guest, and the generic IPIs also come with a trigger page which
> > needs to be mapped into the guest for guest IPIs or OpenCAPI
> > interrupts, or just qemu for emulated devices.
>=20
> what about the OS TIMA page ? Do we trap the accesses in QEMU and
> forward them to KVM ? or do we use a similar mechanism.=20

No, no, we'll have an mmap facility for it in kvm but it worries me
less as there's only one of these and there's little damage qemu can do
having access to it :)
>=20
> > Now that can be thousands of these critters. I certainly don't want t=
o
> > create thousands of VMAs in qemu and even less thousands of memory
> > regions in KVM.
>=20
> we can provision one mapping per kvmppc_xive_src_block  maybe ? =20

Maybe. Last I looked KVM walk of memory regions was linear though. Mind
you it's not a huge deal if the guest RAM is always in the first
entries.

> > So we need some kind of mechanism by wich a single large VMA gets
> > mmap'ed into qemu (or maybe a couple of these, but not too many) and
> > the interrupt pages can be assigned to slots in there and demand
> > faulted.
>=20
> Frederic has started to put in place a similar mecanism for OpenCAPI.

I know, though he made it rather OpenCAPI specific which is going to be
"interesting" when it comes to virtualizing OpenCAPI...

> > For the generic interrupts, this can probably be covered by KVM, addi=
ng
> > some arch ioctls for allocating IPIs and mmap'ing that region etc...
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
>=20
> > For pass-through, it's trickier, we don't want to mmap each irqfd
> > individually for the above reason, so we want to "link" them to KVM. =
We
> > don't want to allow qemu to take control of any arbitrary interrupt i=
n
> > the system though, so it has to related to the ownership of the irqfd
> > coming from vfio.
> >=20
> > OpenCAPI I suspect will be its own can of worms...
> >=20
> > Also, have we decided how the process of switching between XICS and
> > XIVE will work vs. CAS ?=20
>=20
> That's how it is described in the architecture. The current choice is
> to create both XICS and XIVE objects and choose at CAS which one to
> use. It relies today on the capability of the pseries machine to=20
> allocate IRQ numbers for both interrupt controller backends. These
> patches have been merged in QEMU.
>=20
> A change of interrupt mode results in a reset. The device tree is=20
> populated accordingly and the ICPs are switched for the model in=20
> use.=20

For KVM we need to only instanciate one of them though.

> > And how that will interact with KVM ?=20
>=20
> I expect we will do the same, which is to create two KVM devices to=20
> be able to handle both interrupt controller backends depending on the=20
> mode negotiated by the guest. =20

That will be an ungodly mess, I'd rather we only instanciate the right
one.

> > I was
> > thinking the kernel would implement a different KVM device type, ie
> > the "emulated XICS" would remain KVM_DEV_TYPE_XICS and XIVE would be
> > KVM_DEV_TYPE_XIVE.
>=20
> yes. it makes sense. The new device will have a lot in common with the=20
> KVM_DEV_TYPE_XICS using kvm_xive_ops.

Ben.
