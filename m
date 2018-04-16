Received: from eggs.gnu.org ([2001:4830:134:3::10]:37953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f7vli-0004Bo-RS
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 00:29:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f7vle-0002iY-RX
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 00:29:30 -0400
Date: Mon, 16 Apr 2018 14:26:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180416042605.GC20551@umbus.fritz.box>
References: <20171209084338.29395-1-clg@kaod.org>
	<20171209084338.29395-3-clg@kaod.org>
	<20171220050947.GC5981@umbus.fritz.box>
	<3f2d34d0-9ba0-1321-a6bd-55546c67c8c7@kaod.org>
	<20180412050707.GK9425@umbus.fritz.box>
	<2737e5a4-8859-4790-b368-afef253225cf@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rQ2U398070+RC21q"
Content-Disposition: inline
In-Reply-To: <2737e5a4-8859-4790-b368-afef253225cf@kaod.org>
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
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg Kurz <groug@kaod.org>


--rQ2U398070+RC21q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 12, 2018 at 10:18:11AM +0200, C=E9dric Le Goater wrote:
> On 04/12/2018 07:07 AM, David Gibson wrote:
> > On Wed, Dec 20, 2017 at 08:38:41AM +0100, C=E9dric Le Goater wrote:
> >> On 12/20/2017 06:09 AM, David Gibson wrote:
> >>> On Sat, Dec 09, 2017 at 09:43:21AM +0100, C=E9dric Le Goater wrote:
> >>>> With the POWER9 processor comes a new interrupt controller called
> >>>> XIVE. It is composed of three sub-engines :
> >>>>
> >>>>   - Interrupt Virtualization Source Engine (IVSE). These are in PHBs,
> >>>>     in the main controller for the IPIS and in the PSI host
> >>>>     bridge. They are configured to feed the IVRE with events.
> >>>>
> >>>>   - Interrupt Virtualization Routing Engine (IVRE). Their job is to
> >>>>     match an event source with a Notification Virtualization Target
> >>>>     (NVT), a priority and an Event Queue (EQ) to determine if a
> >>>>     Virtual Processor can handle the event.
> >>>>
> >>>>   - Interrupt Virtualization Presentation Engine (IVPE). It maintains
> >>>>     the interrupt state of each hardware thread and present the
> >>>>     notification as an external exception.
> >>>>
> >>>> Each of the engines uses a set of internal tables to redirect
> >>>> exceptions from event sources to CPU threads. The first table we
> >>>> introduce is the Interrupt Virtualization Entry (IVE) table, part of
> >>>> the virtualization engine in charge of routing events. It associates
> >>>> event sources (IRQ numbers) to event queues which will forward, or
> >>>> not, the event notification to the presentation controller.
> >>>>
> >>>> The XIVE model is designed to make use of the full range of the IRQ
> >>>> number space and does not use an offset like the XICS mode does.
> >>>> Hence, the IVE table is directly indexed by the IRQ number.
> >>>>
> >>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >>>
> >>> As you've suggested in yourself, I think we might need to more
> >>> explicitly model the different components of the XIVE system.  As part
> >>> of that, I think you need to be clearer in this base skeleton about
> >>> exactly what component your XIVE object represents.
> >=20
> > Sorry it's been so long since I looked at these.
>=20
> That's fine. I have been working on a XIVE device model for the PowerNV
> machine and KVM support for the pseries. I have a better understanding
> of the overall picture.
>=20
> The patchset has not changed much so we can still discuss on this
> basis without me flooding the mailing list.
>=20
> >> ok. The base skeleton is the IVRE, the central engine handling=20
> >> the routing.=20
> >>
> >>> If the answer is "the overall thing"=20
> >>
> >> Yes, it is more or less that currently.=20
> >>
> >> The sPAPRXive object models the source engine and the routing=20
> >> engine in one object.
> >=20
> > Yeah, I suspect we don't want that.  Although it might seem simpler in
> > the spapr case, at least at first glance, I think it will cause us
> > problems later.  At the very least, it's likely to make it harder to
> > share code between the spapr and powernv case.  I think it will also
> > make for more confusion about exactly what things belong where.
>=20
> I tend to agree.=20
>=20
> We need to clarify (a bit) what is in the XIVE interrupt controller=20
> silicon, and how XIVE works. The XIVE device models for spapr and=20
> powernv should be very close as the differences are small. KVM support=20
> should be built on the spapr model.
>=20
> There are 3 different sub-engines in the XIVE interrupt controller
> device :
>=20
> * IVSE (XiveSource model)
>=20
>   interrupt sources, which expose their PQ bits through ESB MMIO pages=20
>   (there are different levels of support depending on HW revision)=20
>=20
>   The XIVE interrupt controller has a set of internal sources for=20
>   IPIs and CAPI like interrupts.

Ok.  IIUC in hardware there's one of these in each PHB, plus maybe one
or two others.  Is that right?

>=20
> * IVRE (No real model)
>=20
>   in the middle, doing the routing of source event notification to
>   (cpu) targets. It relies on internal tables which are stored in=20
>   the hypervisor/QEMU/KVM for the spapr machine and in the VM RAM=20
>   for the powernv machine.

What does VM RAM mean in the powernv context?

>   Configuration updates of the XIVE tables are done through hcalls=20
>   on spapr and with MMIOs on the IC regs on powernv. On the latter,
>   the changes are flushed backed in the VM RAM.=20
>=20
> * IVPE (XiveNVT)
>=20
>   set of registers for interrupt management at the CPU level. Exposed
>   in a specific MMIO region called the TIMA.

Ok.

> The XIVE tables are :
>=20
> * IVT
>=20
>   associate an interrupt source number with an event queue. the data
>   to be pushed in the queue is stored there also.

Ok, so there would be one of these tables for each IVRE, with one
entry for each source managed by that IVSE, yes?

Do the XIVE IPIs have entries here, or do they bypass this?

> * EQDT:
>=20
>   describes the queues in the OS RAM, also contains a set of flags,
>   a virtual target, etc.

So on real hardware this would be global, yes?  And it would be
consulted by the IVRE?

For guests, we'd expect one table per-guest?  How would those be
integrated with the host table?

> * VPDT:
>=20
>   describe the virtual targets, which can have different natures,
>   a lpar, a cpu. This is for powernv, spapr does not have this=20
>   concept.

Ok  On hardware that would also be global and consulted by the IVRE,
yes?

Under PAPR, I'm guessing the concept is missing because it essentially
has a fixed contents: an entry for each vcpu and maybe one for the
lpar as a whole?

> So, the idea behind the sPAPRXive object is to model a XIVE interrupt
> controller device. It contains today :

Yeah, what a "XIVE interrupt controller device" is not really clear to
me.  If it's something that is necessarily global, I think you'll be
better off making it a machine-interface rather than a distinct
object.

>=20
>  - an internal source block for all interrupts : IPIs and virtual=20
>    device interrupts. In the IRQ number space, the IPIs are below
>    4096 and the device interrupts above, which keeps compatibility=20
>    with XICS. This is important to be able to change interrupt mode.
>=20
>    PowerNV has different source blocks, like for P8.
>=20
>  - a routing engine, which is limited to the IVT. This is a shortcut=20
>    and it might be better to introduce a specific object. Anyhow, this=20
>    is a state to capture.

Ok.  It sounds like this is roughly the equivalent of the XICSFabric,
and likewise would probably be better handled by an interface on the
machine rather than a distinct object.  But I'm not clear enough to be
certain of that yet.

>    In the current version I am working on, the XiveFabric interface is
>    more complex :
>=20
> 	typedef struct XiveFabricClass {
> 	    InterfaceClass parent;
> 	    XiveIVE *(*get_ive)(XiveFabric *xf, uint32_t lisn);

This does an IVT lookup, I take it?

> 	    XiveNVT *(*get_nvt)(XiveFabric *xf, uint32_t server);

This one a VPDT lookup, yes?

> 	    XiveEQ  *(*get_eq)(XiveFabric *xf, uint32_t eq_idx);

And this one an EQDT lookup?

> 	} XiveFabricClass;
>=20
>    It helps in making the routing algorithm independent of the model.=20
>    I hope to make powernv converge and use it.
>=20
>  - a set of MMIOs for the TIMA. They model the presenter engine.=20
>    current_cpu is used to retrieve the NVT object, which holds the=20
>    registers for interrupt management. =20

Right.  Now the TIMA is local to a target/server not an EQ, right?

I guess we need at least one of these per-vcpu.  Do we also need an
lpar-global, or other special ones?

> The EQs are stored under the NVT. This saves us an unnecessary EQDT=20
> table. But we could add one under the XIVE device model.

I'm not sure of the distinction you're drawing between the NVT and the
XIVE device mode.

[snip]

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--rQ2U398070+RC21q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrUJdsACgkQbDjKyiDZ
s5If3A/6Aons//FAaDgw9yNDSE2+xFpKO/aJTekkWTKGneosetVOF1ZAnSAdyVLB
ygPiCEeyXXiEW1otlvfxSzxEnL4pveK61DDIIrJlWniCh5Hv1GPxQDprP1mEgMKU
mAs36rrttKEQYiqmMuCq84dQo8dIOt017PU27Mr+I7uvfJQr6+eXFSkPDV7+AYlJ
JdbaBqQACVzs7yrwvySc/xJatFJcyNW0+RtzM0R+JgU6JZ4NaMwgLOHDJNtS0zhd
xX4hD7ryanFe0ZyMU3CcjuiFHSfIHF4hs/vyzBgF0m+zBzDul7qnYDS+beHaKb3Y
OfVEvf+YS6R11QNdd17U/md198+POa0tV+ZfWWzz4fjCENzc5PgnFKOxqLbqHKcu
bjODKPCb+fa7KnF2+EvkBs0EotH1tWLqn5318YnpOgjBS7e9XXlIXOKjZMrq84kC
sK/Ofo6Pw1LEBfRh4QHyAEAS87hEn7qcK9Hkd+BMvkehDYsEJW12Vtig4ZlD8d+l
lXPipPF9eN1H6TCz91EjDYkWkbRSGbVUYSqwfOi/NPGTpEMiaEPfkclNxdSQnRlS
2gYemJTREUE4Mjci0wxNIZwaQa/BZvQa/deuTD/HM9lMoJEBZjhLmihTZ5mTRfQz
vu4ZrjE96R761blpDvCPFZRa7OutzwWvOlbXj0TbPLhmy1KEeVw=
=lxpr
-----END PGP SIGNATURE-----

--rQ2U398070+RC21q--
