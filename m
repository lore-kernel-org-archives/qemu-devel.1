Received: from eggs.gnu.org ([2001:4830:134:3::10]:34343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fEom0-0001C4-Jn
	for qemu-devel@nongnu.org; Sat, 05 May 2018 00:26:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fEolx-0007oB-CV
	for qemu-devel@nongnu.org; Sat, 05 May 2018 00:26:16 -0400
Date: Sat, 5 May 2018 14:26:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180505042604.GJ13229@umbus.fritz.box>
References: <20180419124331.3915-1-clg@kaod.org>
	<20180419124331.3915-5-clg@kaod.org>
	<20180424065131.GQ19804@umbus.fritz.box>
	<5def5bbb-9842-0121-e889-014ba88fd4c5@kaod.org>
	<20180426042002.GF8800@umbus.fritz.box>
	<660d1e36-b269-0202-7ac5-570479bb4083@kaod.org>
	<20180503052205.GQ13229@umbus.fritz.box>
	<a671a058-ab56-6a97-d172-7fa22dca1f25@kaod.org>
	<20180504033325.GR13229@umbus.fritz.box>
	<504aeada-4eb9-3969-a3a0-a0e03d9d19b8@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qWV9ymU6UYcl1Snp"
Content-Disposition: inline
In-Reply-To: <504aeada-4eb9-3969-a3a0-a0e03d9d19b8@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v3 04/35] spapr/xive: introduce a XIVE
 interrupt controller for sPAPR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--qWV9ymU6UYcl1Snp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2018 at 03:05:08PM +0200, C=E9dric Le Goater wrote:
> On 05/04/2018 05:33 AM, David Gibson wrote:
> > On Thu, May 03, 2018 at 06:50:09PM +0200, C=E9dric Le Goater wrote:
> >> On 05/03/2018 07:22 AM, David Gibson wrote:
> >>> On Thu, Apr 26, 2018 at 12:43:29PM +0200, C=E9dric Le Goater wrote:
> >>>> On 04/26/2018 06:20 AM, David Gibson wrote:
> >>>>> On Tue, Apr 24, 2018 at 11:46:04AM +0200, C=E9dric Le Goater wrote:
> >>>>>> On 04/24/2018 08:51 AM, David Gibson wrote:
> >>>>>>> On Thu, Apr 19, 2018 at 02:43:00PM +0200, C=E9dric Le Goater wrot=
e:
> >>>>>>>> sPAPRXive is a model for the XIVE interrupt controller device of=
 the
> >>>>>>>> sPAPR machine. It holds the routing XIVE table, the Interrupt
> >>>>>>>> Virtualization Entry (IVE) table which associates interrupt sour=
ce
> >>>>>>>> numbers with targets.
> >>>>>>>>
> >>>>>>>> Also extend the XiveFabric with an accessor to the IVT. This wil=
l be
> >>>>>>>> needed by the routing algorithm.
> >>>>>>>>
> >>>>>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >>>>>>>> ---
> >>>>>>>>
> >>>>>>>>  May be should introduce a XiveRouter model to hold the IVT. To =
be
> >>>>>>>>  discussed.
> >>>>>>>
> >>>>>>> Yeah, maybe.  Am I correct in thinking that on pnv there could be=
 more
> >>>>>>> than one XiveRouter?
> >>>>>>
> >>>>>> There is only one, the main IC.=20
> >>>>>
> >>>>> Ok, that's what I thought originally.  In that case some of the stu=
ff
> >>>>> in the patches really doesn't make sense to me.
> >>>>
> >>>> well, there is one IC per chip on powernv, but we haven't reach that=
 part
> >>>> yet.
> >>>
> >>> Hmm.  There's some things we can delay dealing with, but I don't think
> >>> this is one of them.  I think we need to understand how multichip is
> >>> going to work in order to come up with a sane architecture.  Otherwise
> >>> I fear we'll end up with something that we either need to horribly
> >>> bastardize for multichip, or have to rework things dramatically
> >>> leading to migration nightmares.
> >>
> >> So, it is all controlled by MMIO, so we should be fine on that part.=
=20
> >> As for the internal tables, they are all configured by firmware, using
> >> a chip identifier (block). I need to check how the remote XIVE are=20
> >> accessed. I think this is by MMIO.=20
> >=20
> > Right, but for powernv we execute OPAL inside the VM, rather than
> > emulating its effects.  So we still need to model the actual hardware
> > interfaces.  OPAL hides the details from the kernel, but not from us
> > on the other side.
>=20
> Yes. This is the case in the current model. I took a look today and
> I have a few fixes for the MMIO layout for P9 chips which I will send.
>=20
> As for XIVE, the model needs to be a little more  complex to support=20
> VSD_MODE_FORWARD tables which describe how to forward a notification
> to another XIVE IC on another chip. They contain an address on which=20
> to load, This is another hop in the notification chain. =20

Ah, ok.  So is that mode and address configured in the (bare metal)
IVT as well?  Or is that a different piece of configuration?

> >> I haven't looked at multichip XIVE support but I am not too worried as=
=20
> >> the framework is already in place for the machine.
> >> =20
> >>>>>>> If we did have a XiveRouter, I'm not sure we'd need the XiveFabric
> >>>>>>> interface, possibly its methods could just be class methods of
> >>>>>>> XiveRouter.
> >>>>>>
> >>>>>> Yes. We could introduce a XiveRouter to share the ivt table betwee=
n=20
> >>>>>> the sPAPRXive and the PnvXIVE models, the interrupt controllers of
> >>>>>> the machines. Methods would provide way to get the ivt/eq/nvt
> >>>>>> objects required for routing. I need to add a set_eq() to push the
> >>>>>> EQ data.
> >>>>>
> >>>>> Hrm.  Well, to add some more clarity, let's say the XiveRouter is t=
he
> >>>>> object which owns the IVT. =20
> >>>>
> >>>> OK. that would be a model with some state and not an interface.
> >>>
> >>> Yes.  For papr variant it would have the whole IVT contents as its
> >>> state.  For the powernv, just the registers telling it where to find
> >>> the IVT in RAM.
> >>>
> >>>>> It may or may not do other stuff as well.
> >>>>
> >>>> Its only task would be to do the final event routing: get the IVE,
> >>>> get the EQ, push the EQ DATA in the OS event queue, notify the CPU.
> >>>
> >>> That seems like a lot of steps.  Up to push the EQ DATA, certainly.
> >>> And I guess it'll have to ping an NVT somehow, but I'm not sure it
> >>> should know about CPUs as such.
> >>
> >> For PowerNV, the concept could be generalized, yes. An NVT can=20
> >> contain the interrupt state of a logical server but the common=20
> >> case is baremetal without guests for QEMU and so we have a NVT=20
> >> per cpu.=20
> >=20
> > Hmm.  We eventually want to support a kernel running guests under
> > qemu/powernv though, right? =20
>=20
> arg. an emulated hypervisor ! OK let's say this is a long term goal :)=20
>=20
> > So even if we don't allow it right now,
> > we don't want allowing that to require major surgery to our
> > architecture.
>=20
> That I agree on.=20
>=20
> >> PowerNV will have some limitation but we can make it better than=20
> >> today for sure. It boots.
> >>
> >> We can improve some of the NVT notification process, the way NVT=20
> >> are matched eventually. may be support remote engines if the
> >> NVT is not local. I have not looked at the details.
> >>
> >>> I'm not sure at this stage what should own the EQD table.
> >>
> >> The EQDT is in RAM.
> >=20
> > Not for spapr, it's not. =20
>=20
> yeah ok. It's in QEMU/KVM.
>=20
> > And even when it is in RAM, something needs
> > to own the register that gives its base address.
>=20
> It's more complex than registers on powernv. There is a procedure
> to define the XIVE tables using XIVE table descriptors which contain
> their characteristics, size, indirect vs. indirect, local vs remote.
> OPAL/skiboot defines all these to configure the HW, and the model
> necessarily needs to support the same interface. This is the case
> for a single chip.

Ah, ok.  So there's some sort of IVTD.  Also in RAM?  Eventually there
must be a register giving the base address of the IVTD, yes?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qWV9ymU6UYcl1Snp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrtMlwACgkQbDjKyiDZ
s5LdGRAAtkjvaA7mK2JGdjLwn+VYpvdXwSmtj08W1rXC80o4xz4wFmMvsonE+xQi
RwXfkja1h8O8d2qPsT4qPLnQUdE0YDqpaX6YC1WUDn9Wi5NdYBVqJjOIdvrblIDX
2/KO4HXFFvUCh6q+4MsSbozfNYuGXC5pO3Rggl6nL6v+mtYmJgX5C80C6W/ye1S0
2QW3oZ8u1J8HLQJsbVZnktN0oc3ZeL3kWHMFi4yQfVP2PdOuB7osD01d2ZPlM8fA
v3eHsNVDeqlhY4IvpEokRTkKubpbIUBkAINEy0a6k+0+J4kDQK8eDd0yjdutaURT
BQnBvZL+ciqCMoGdzP5OhNDbLipzW8459zyIS+ff4uLKI0pueCf+CKBl9L6tH263
YQoT9HtZWhFyyGKy9NpmR3cF5AnELQuMDOP3hUY5j9odWahG0wx83TT8bAUBcVAf
G1gtdWORfNc8gcCOGj5/xBlS/vlKzKi4YEACUbeXYkolsHW/+WMSfGvUQ5pvGJyL
20aHiccydeHfma0JGNM11NzpGPI5lFiG82JMfbaLVKDpcpmW/BpSNxLEKLxVnT7n
+V1V4/eRPwu8GLedBu/Ab1ZqOG4eG0+d+VWpVU2LEmxRmAqv486ByQPEMwlXSxxG
76Frj5ShfULoRn6rJ3SNBnIkltbciUnQI/bLxz/WS8DBdKRTUdk=
=3an+
-----END PGP SIGNATURE-----

--qWV9ymU6UYcl1Snp--
