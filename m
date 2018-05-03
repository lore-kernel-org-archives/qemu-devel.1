Received: from eggs.gnu.org ([2001:4830:134:3::10]:42207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE7hQ-00035O-PY
	for qemu-devel@nongnu.org; Thu, 03 May 2018 02:26:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE7hM-0004SQ-Ts
	for qemu-devel@nongnu.org; Thu, 03 May 2018 02:26:40 -0400
Date: Thu, 3 May 2018 16:25:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180503062559.GW13229@umbus.fritz.box>
References: <20180419124331.3915-1-clg@kaod.org>
	<20180419124331.3915-8-clg@kaod.org>
	<20180426072501.GK8800@umbus.fritz.box>
	<312cdfe7-bc6b-3eed-588e-a71ce1385988@kaod.org>
	<20180503054534.GU13229@umbus.fritz.box>
	<cf8ab4bd-8704-aa3f-a4c2-5f459c7dddd4@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JkgDhDyNm4zanevS"
Content-Disposition: inline
In-Reply-To: <cf8ab4bd-8704-aa3f-a4c2-5f459c7dddd4@kaod.org>
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


--JkgDhDyNm4zanevS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2018 at 08:07:54AM +0200, C=E9dric Le Goater wrote:
> On 05/03/2018 07:45 AM, David Gibson wrote:
> > On Thu, Apr 26, 2018 at 11:48:06AM +0200, C=E9dric Le Goater wrote:
> >> On 04/26/2018 09:25 AM, David Gibson wrote:
> >>> On Thu, Apr 19, 2018 at 02:43:03PM +0200, C=E9dric Le Goater wrote:
> >>>> The Event Queue Descriptor (EQD) table is an internal table of the
> >>>> XIVE routing sub-engine. It specifies on which Event Queue the event
> >>>> data should be posted when an exception occurs (later on pulled by t=
he
> >>>> OS) and which Virtual Processor to notify.
> >>>
> >>> Uhhh.. I thought the IVT said which queue and vp to notify, and the
> >>> EQD gave metadata for event queues.
> >>
> >> yes. the above poorly written. The Event Queue Descriptor contains the
> >> guest address of the event queue in which the data is written. I will=
=20
> >> rephrase.     =20
> >>
> >> The IVT contains IVEs which indeed define for an IRQ which EQ to notif=
y=20
> >> and what data to push on the queue.=20
> >> =20
> >>>> The Event Queue is a much
> >>>> more complex structure but we start with a simple model for the sPAPR
> >>>> machine.
> >>>>
> >>>> There is one XiveEQ per priority and these are stored under the XIVE
> >>>> virtualization presenter (sPAPRXiveNVT). EQs are simply indexed with=
 :
> >>>>
> >>>>        (server << 3) | (priority & 0x7)
> >>>>
> >>>> This is not in the XIVE architecture but as the EQ index is never
> >>>> exposed to the guest, in the hcalls nor in the device tree, we are
> >>>> free to use what fits best the current model.
> >>
> >> This EQ indexing is important to notice because it will also show up=
=20
> >> in KVM to build the IVE from the KVM irq state.
> >=20
> > Ok, are you saying that while this combined EQ index will never appear
> > in guest <-> host interfaces,=20
>=20
> Indeed.
>=20
> > it might show up in qemu <-> KVM interfaces?
>=20
> Not directly but it is part of the IVE as the IVE_EQ_INDEX field. When
> dumped, it has to be built in some ways, compatible with the emulated=20
> mode in QEMU.=20

Hrm.  But is the exact IVE contents visible to qemu (for a PAPR
guest)?  I would have thought the qemu <-> KVM interfaces would have
abstracted this the same way the guest <-> KVM interfaces do.  Or is
there a reason not to?

> >>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >>>
> >>> Is the EQD actually modifiable by a guest?  Or are the settings of the
> >>> EQs fixed by PAPR?
> >>
> >> The guest uses the H_INT_SET_QUEUE_CONFIG hcall to define the address
> >> of the event queue for a couple prio/server.
> >=20
> > Ok, so the EQD can be modified by the guest.  In which case we need to
> > work out what object owns it, since it'll need to migrate it.
>=20
> Indeed. The EQD are CPU related as there is one EQD per couple (cpu,=20
> priority). The KVM patchset dumps/restores the eight XiveEQ struct=20
> using per cpu ioctls. The EQ in the OS RAM is marked dirty at that
> stage.

To make sure I'm clear: for PAPR there's a strict relationship between
EQD and CPU (one EQD for each (cpu, priority) tuple).  But for powernv
that's not the case, right?  AIUI the mapping of EQs to cpus was
configurable, is that right?


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--JkgDhDyNm4zanevS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrqq3cACgkQbDjKyiDZ
s5LQ8A//T7WQOZhlESkKW2fg+e6qfrg6qft13lgXXkludOkF9L+iZ1zyznQA9KZA
4N7PymQlm4nWMcmrzSIfatti37va+94uCgnL3LT+3UgeFDgIZ9JsuIrCOmQUTFba
Gup2Nv6idPosdSSDuGiSbS37QlhfKjRNV4mv4KRk9UXpKyDn5GHMmfjotulUBySG
6fqn/dYkN+3nwjINqQ6BtGlyKBhBkI42fUjy9PIGZkrrtWtCfolDfN+0RriNMIC4
sKzIJlUksdIS4nttENWeC2I0dtpEIOkIu5AemzfH4Ptb0HiLxwCht78BUOoa8cpV
Schpv0C1Qhh3W5G9BDBMIhnyNYTSmNil7yGwYin3kdimN9bnwZs08RE73g7D+Szo
BaH2VrKUDX1wk66IQloGI5UFPpudyUsw+2rNTroV6vDXjXlFn8B8iPlLiABe0Rr8
AFpQL7biBaVRvQ2mOwZiOazaHJ70gU+wVh+nCKuP4G1gHlFHepI+1mfEEz1beAdv
iP30EO9ZPvJasKef8uTv2o1ziEG/3+6VADzpx2IjFm8gviO6tBWXJQZM3fqoliHp
WSemX3EanvBNXu2R472nhz1DX+bWp2KhrDMeTjlj5ii/4OTeCLQa1CIiviEfOxXX
Brol94f4gmNL1/lNkj5mUuykqZ8Cw7s36gabTKHrmsDXqwi4tak=
=URay
-----END PGP SIGNATURE-----

--JkgDhDyNm4zanevS--
