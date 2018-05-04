Received: from eggs.gnu.org ([2001:4830:134:3::10]:34844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fET8N-0003BZ-9y
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:19:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fET8J-0004Od-7j
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:19:55 -0400
Date: Fri, 4 May 2018 15:19:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180504051940.GW13229@umbus.fritz.box>
References: <20180419124331.3915-1-clg@kaod.org>
	<20180419124331.3915-8-clg@kaod.org>
	<20180426072501.GK8800@umbus.fritz.box>
	<312cdfe7-bc6b-3eed-588e-a71ce1385988@kaod.org>
	<20180503054534.GU13229@umbus.fritz.box>
	<cf8ab4bd-8704-aa3f-a4c2-5f459c7dddd4@kaod.org>
	<20180503062559.GW13229@umbus.fritz.box>
	<20cd899d-47be-f9a3-736b-bf3bcd10cfad@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SuGb6p5JEpzYJdwO"
Content-Disposition: inline
In-Reply-To: <20cd899d-47be-f9a3-736b-bf3bcd10cfad@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v3 07/35] spapr/xive: introduce the XIVE
 Event Queues
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


--SuGb6p5JEpzYJdwO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2018 at 04:37:29PM +0200, C=E9dric Le Goater wrote:
> On 05/03/2018 08:25 AM, David Gibson wrote:
> > On Thu, May 03, 2018 at 08:07:54AM +0200, C=E9dric Le Goater wrote:
> >> On 05/03/2018 07:45 AM, David Gibson wrote:
> >>> On Thu, Apr 26, 2018 at 11:48:06AM +0200, C=E9dric Le Goater wrote:
> >>>> On 04/26/2018 09:25 AM, David Gibson wrote:
> >>>>> On Thu, Apr 19, 2018 at 02:43:03PM +0200, C=E9dric Le Goater wrote:
> >>>>>> The Event Queue Descriptor (EQD) table is an internal table of the
> >>>>>> XIVE routing sub-engine. It specifies on which Event Queue the eve=
nt
> >>>>>> data should be posted when an exception occurs (later on pulled by=
 the
> >>>>>> OS) and which Virtual Processor to notify.
> >>>>>
> >>>>> Uhhh.. I thought the IVT said which queue and vp to notify, and the
> >>>>> EQD gave metadata for event queues.
> >>>>
> >>>> yes. the above poorly written. The Event Queue Descriptor contains t=
he
> >>>> guest address of the event queue in which the data is written. I wil=
l=20
> >>>> rephrase.     =20
> >>>>
> >>>> The IVT contains IVEs which indeed define for an IRQ which EQ to not=
ify=20
> >>>> and what data to push on the queue.=20
> >>>> =20
> >>>>>> The Event Queue is a much
> >>>>>> more complex structure but we start with a simple model for the sP=
APR
> >>>>>> machine.
> >>>>>>
> >>>>>> There is one XiveEQ per priority and these are stored under the XI=
VE
> >>>>>> virtualization presenter (sPAPRXiveNVT). EQs are simply indexed wi=
th :
> >>>>>>
> >>>>>>        (server << 3) | (priority & 0x7)
> >>>>>>
> >>>>>> This is not in the XIVE architecture but as the EQ index is never
> >>>>>> exposed to the guest, in the hcalls nor in the device tree, we are
> >>>>>> free to use what fits best the current model.
> >>>>
> >>>> This EQ indexing is important to notice because it will also show up=
=20
> >>>> in KVM to build the IVE from the KVM irq state.
> >>>
> >>> Ok, are you saying that while this combined EQ index will never appear
> >>> in guest <-> host interfaces,=20
> >>
> >> Indeed.
> >>
> >>> it might show up in qemu <-> KVM interfaces?
> >>
> >> Not directly but it is part of the IVE as the IVE_EQ_INDEX field. When
> >> dumped, it has to be built in some ways, compatible with the emulated=
=20
> >> mode in QEMU.=20
> >=20
> > Hrm.  But is the exact IVE contents visible to qemu (for a PAPR
> > guest)? =20
>=20
> The guest only uses hcalls which arguments are :
> =20
> 	- cpu numbers,
> 	- priority numbers from defined ranges,=20
> 	- logical interrupt numbers. =20
> 	- physical address of the EQ=20
>=20
> The visible parts for the guest of the IVE are the 'priority', the 'cpu',=
=20
> and the 'eisn', which is the effective IRQ number the guest is assigning=
=20
> to the source. The 'eisn" will be pushed in the EQ.

Ok.

> The IVE EQ index is not visible.

Good.

> > I would have thought the qemu <-> KVM interfaces would have
> > abstracted this the same way the guest <-> KVM interfaces do.  > Or is =
there a reason not to?
>=20
> It is practical to dump 64bit IVEs directly from KVM into the QEMU=20
> internal structures because it fits the emulated mode without doing=20
> any translation ... This might be seen as a shortcut. You will tell=20
> me when you reach the KVM part.  =20

Ugh.. exposing to qemu the raw IVEs sounds like a bad idea to me.
When we migrate, we're going to have to assign the guest (server,
priority) tuples to host EQ indicies, and I think it makes more sense
to do that in KVM and hide the raw indices from qemu than to have qemu
mangle them explicitly on migration.

> >>>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >>>>>
> >>>>> Is the EQD actually modifiable by a guest?  Or are the settings of =
the
> >>>>> EQs fixed by PAPR?
> >>>>
> >>>> The guest uses the H_INT_SET_QUEUE_CONFIG hcall to define the address
> >>>> of the event queue for a couple prio/server.
> >>>
> >>> Ok, so the EQD can be modified by the guest.  In which case we need to
> >>> work out what object owns it, since it'll need to migrate it.
> >>
> >> Indeed. The EQD are CPU related as there is one EQD per couple (cpu,=
=20
> >> priority). The KVM patchset dumps/restores the eight XiveEQ struct=20
> >> using per cpu ioctls. The EQ in the OS RAM is marked dirty at that
> >> stage.
> >=20
> > To make sure I'm clear: for PAPR there's a strict relationship between
> > EQD and CPU (one EQD for each (cpu, priority) tuple). =20
>=20
> Yes.
>=20
> > But for powernv that's not the case, right? =20
>=20
> It is.

Uh.. I don't think either of us phrased that well, I'm still not sure
which way you're answering that.

> > AIUI the mapping of EQs to cpus was configurable, is that right?
>=20
> Each cpu has 8 EQD. Same for virtual cpus.

Hmm.. but is that 8 EQD per cpu something built into the hardware, or
just a convention of how the host kernel and OPAL operate?

>=20
> I am not sure what you understood before ? It is surely something
> I wrote, my XIVE understanding is still making progress.
>=20
>=20
> C.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SuGb6p5JEpzYJdwO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrr7WkACgkQbDjKyiDZ
s5LLxhAArDrWzMWVbspFpW0knF0SQP40tH8YiXkzmXdQFsfyCyUZzbj2qthlyZYm
DdgoIz9NfbFN8dgJiT7YUA2EPtgoFeIVO1f7+P075dwl/Mk9+NwXrtpR+ysJ3wD1
m+cji/LKBG5sUshXLZ+3omd/CHBW3xFA0ZLWOkCg4e3kxNH6un/zTj08e313inGY
cA8PlYoo80KTeiDqvEDrdSJodDyo7TPZAyEEJUHBvdnzMB5Q+31hehXVsC15SoYf
ePftGCNR2/psxg6vbnPIU6qTUF79LqqjEPEOwr/Hkf7WYkQXzI5X+4bB5sMWARG9
gT1YByG+UaZLCtPoAtkk93YXVJYmSi6lxlDBEIPRWp554F92FOZ1eWO5u+ub5/bG
4BugAuUCX6RRwRq9LdAWmoIxNBFEewVju7e/L1hxme4bZXHNnVuNYShwdnstuchS
H3AGvTWL+GGfwUxvlRqj8oWTicyrgNqKbrLhrGQnHRBuxSpZjQKNHYZj0Tlou5R2
qcz16dmMY10peFpLeDg4nGZynqisRD6JdeC4OqKKydeTvmlFMSO/Cf2eFnYTXT2O
Tcwnnb76OxeUf3jz4DjtQVd8Lek1tjn3g9VFT2mbXDfgV/FOznkzjmy+Hg37mPmV
d1ILlv3iSTtAHuA5g69WcDm1I5umUjDuSaugPrj8oIS5PBixLnk=
=d3A7
-----END PGP SIGNATURE-----

--SuGb6p5JEpzYJdwO--
