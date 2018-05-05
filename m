Received: from eggs.gnu.org ([2001:4830:134:3::10]:35129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fEosZ-0002FB-8J
	for qemu-devel@nongnu.org; Sat, 05 May 2018 00:33:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fEosX-0002XF-M7
	for qemu-devel@nongnu.org; Sat, 05 May 2018 00:33:03 -0400
Date: Sat, 5 May 2018 14:29:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180505042944.GL13229@umbus.fritz.box>
References: <20180419124331.3915-1-clg@kaod.org>
	<20180419124331.3915-8-clg@kaod.org>
	<20180426072501.GK8800@umbus.fritz.box>
	<312cdfe7-bc6b-3eed-588e-a71ce1385988@kaod.org>
	<20180503054534.GU13229@umbus.fritz.box>
	<cf8ab4bd-8704-aa3f-a4c2-5f459c7dddd4@kaod.org>
	<20180503062559.GW13229@umbus.fritz.box>
	<20cd899d-47be-f9a3-736b-bf3bcd10cfad@kaod.org>
	<20180504051940.GW13229@umbus.fritz.box>
	<9cc1092b-6312-aa6c-1fcd-8e6e7756aab7@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2HnjjwBZJnP787BF"
Content-Disposition: inline
In-Reply-To: <9cc1092b-6312-aa6c-1fcd-8e6e7756aab7@kaod.org>
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


--2HnjjwBZJnP787BF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2018 at 03:29:02PM +0200, C=E9dric Le Goater wrote:
> On 05/04/2018 07:19 AM, David Gibson wrote:
> > On Thu, May 03, 2018 at 04:37:29PM +0200, C=E9dric Le Goater wrote:
> >> On 05/03/2018 08:25 AM, David Gibson wrote:
> >>> On Thu, May 03, 2018 at 08:07:54AM +0200, C=E9dric Le Goater wrote:
> >>>> On 05/03/2018 07:45 AM, David Gibson wrote:
> >>>>> On Thu, Apr 26, 2018 at 11:48:06AM +0200, C=E9dric Le Goater wrote:
> >>>>>> On 04/26/2018 09:25 AM, David Gibson wrote:
> >>>>>>> On Thu, Apr 19, 2018 at 02:43:03PM +0200, C=E9dric Le Goater wrot=
e:
> >>>>>>>> The Event Queue Descriptor (EQD) table is an internal table of t=
he
> >>>>>>>> XIVE routing sub-engine. It specifies on which Event Queue the e=
vent
> >>>>>>>> data should be posted when an exception occurs (later on pulled =
by the
> >>>>>>>> OS) and which Virtual Processor to notify.
> >>>>>>>
> >>>>>>> Uhhh.. I thought the IVT said which queue and vp to notify, and t=
he
> >>>>>>> EQD gave metadata for event queues.
> >>>>>>
> >>>>>> yes. the above poorly written. The Event Queue Descriptor contains=
 the
> >>>>>> guest address of the event queue in which the data is written. I w=
ill=20
> >>>>>> rephrase.     =20
> >>>>>>
> >>>>>> The IVT contains IVEs which indeed define for an IRQ which EQ to n=
otify=20
> >>>>>> and what data to push on the queue.=20
> >>>>>> =20
> >>>>>>>> The Event Queue is a much
> >>>>>>>> more complex structure but we start with a simple model for the =
sPAPR
> >>>>>>>> machine.
> >>>>>>>>
> >>>>>>>> There is one XiveEQ per priority and these are stored under the =
XIVE
> >>>>>>>> virtualization presenter (sPAPRXiveNVT). EQs are simply indexed =
with :
> >>>>>>>>
> >>>>>>>>        (server << 3) | (priority & 0x7)
> >>>>>>>>
> >>>>>>>> This is not in the XIVE architecture but as the EQ index is never
> >>>>>>>> exposed to the guest, in the hcalls nor in the device tree, we a=
re
> >>>>>>>> free to use what fits best the current model.
> >>>>>>
> >>>>>> This EQ indexing is important to notice because it will also show =
up=20
> >>>>>> in KVM to build the IVE from the KVM irq state.
> >>>>>
> >>>>> Ok, are you saying that while this combined EQ index will never app=
ear
> >>>>> in guest <-> host interfaces,=20
> >>>>
> >>>> Indeed.
> >>>>
> >>>>> it might show up in qemu <-> KVM interfaces?
> >>>>
> >>>> Not directly but it is part of the IVE as the IVE_EQ_INDEX field. Wh=
en
> >>>> dumped, it has to be built in some ways, compatible with the emulate=
d=20
> >>>> mode in QEMU.=20
> >>>
> >>> Hrm.  But is the exact IVE contents visible to qemu (for a PAPR
> >>> guest)? =20
> >>
> >> The guest only uses hcalls which arguments are :
> >> =20
> >> 	- cpu numbers,
> >> 	- priority numbers from defined ranges,=20
> >> 	- logical interrupt numbers. =20
> >> 	- physical address of the EQ=20
> >>
> >> The visible parts for the guest of the IVE are the 'priority', the 'cp=
u',=20
> >> and the 'eisn', which is the effective IRQ number the guest is assigni=
ng=20
> >> to the source. The 'eisn" will be pushed in the EQ.
> >=20
> > Ok.
> >=20
> >> The IVE EQ index is not visible.
> >=20
> > Good.
> >=20
> >>> I would have thought the qemu <-> KVM interfaces would have
> >>> abstracted this the same way the guest <-> KVM interfaces do.  > Or i=
s there a reason not to?
> >>
> >> It is practical to dump 64bit IVEs directly from KVM into the QEMU=20
> >> internal structures because it fits the emulated mode without doing=20
> >> any translation ... This might be seen as a shortcut. You will tell=20
> >> me when you reach the KVM part.  =20
> >=20
> > Ugh.. exposing to qemu the raw IVEs sounds like a bad idea to me.
>=20
> You definitely need to in QEMU in emulation mode. The whole routing=20
> relies on it.=20

I'm not exactly sure what you mean by "emulation mode" here.  Above,
I'm talking specifically about a KVM HV, PAPR guest.

> > When we migrate, we're going to have to assign the guest (server,
> > priority) tuples to host EQ indicies, and I think it makes more sense
> > to do that in KVM and hide the raw indices from qemu than to have qemu
> > mangle them explicitly on migration.
>=20
> We will need some mangling mechanism for the KVM ioctls saving and
> restoring state. This is very similar to XICS.=20
> =20
> >>>>>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >>>>>>>
> >>>>>>> Is the EQD actually modifiable by a guest?  Or are the settings o=
f the
> >>>>>>> EQs fixed by PAPR?
> >>>>>>
> >>>>>> The guest uses the H_INT_SET_QUEUE_CONFIG hcall to define the addr=
ess
> >>>>>> of the event queue for a couple prio/server.
> >>>>>
> >>>>> Ok, so the EQD can be modified by the guest.  In which case we need=
 to
> >>>>> work out what object owns it, since it'll need to migrate it.
> >>>>
> >>>> Indeed. The EQD are CPU related as there is one EQD per couple (cpu,=
=20
> >>>> priority). The KVM patchset dumps/restores the eight XiveEQ struct=
=20
> >>>> using per cpu ioctls. The EQ in the OS RAM is marked dirty at that
> >>>> stage.
> >>>
> >>> To make sure I'm clear: for PAPR there's a strict relationship between
> >>> EQD and CPU (one EQD for each (cpu, priority) tuple). =20
> >>
> >> Yes.
> >>
> >>> But for powernv that's not the case, right? =20
> >>
> >> It is.
> >=20
> > Uh.. I don't think either of us phrased that well, I'm still not sure
> > which way you're answering that.
>=20
> there's a strict relationship between EQD and CPU (one EQD for each (cpu,=
 priority) tuple) in spapr and in powernv.

For powernv that seems to be contradicted by what you say below.
AFAICT there might be a strict association at the host kernel or even
the OPAL level, but not at the hardware level.

> >>> AIUI the mapping of EQs to cpus was configurable, is that right?
> >>
> >> Each cpu has 8 EQD. Same for virtual cpus.
> >=20
> > Hmm.. but is that 8 EQD per cpu something built into the hardware, or
> > just a convention of how the host kernel and OPAL operate?
>=20
> It's not in the HW, it is used by the HW to route the notification.=20
> The EQD contains the EQ characteristics :
>=20
> * functional bits :
>   - valid bit
>   - enqueue bit, to update OS in RAM EQ or not
>   - unconditional notification
>   - backlog
>   - escalation
>   - ...
> * OS EQ fields=20
>   - physical address
>   - entry index
>   - toggle bit
> * NVT fields
>   - block/chip
>   - index
> * etc.
>=20
> It's a big structure : 8 words.

Ok.  So yeah, the cpu association of the EQ is there in the NVT
fields, not baked into the hardware.

> The EQD table is allocated by OPAL/skiboot and fed to the HW for
> its use. The OS powernv uses OPAL calls  configure the EQD with its=20
> needs :=20
>=20
> int64_t opal_xive_set_queue_info(uint64_t vp, uint32_t prio,
> 				 uint64_t qpage,
> 				 uint64_t qsize,
> 				 uint64_t qflags);
>=20
>=20
> sPAPR uses an hcall :
>=20
> static long plpar_int_set_queue_config(unsigned long flags,
> 				       unsigned long target,
> 				       unsigned long priority,
> 				       unsigned long qpage,
> 				       unsigned long qsize)
>=20
>=20
> but it is translated in an OPAL call in KVM.
>=20
> C.
>=20
> =20
> > =20
> >>
> >> I am not sure what you understood before ? It is surely something
> >> I wrote, my XIVE understanding is still making progress.
> >>
> >>
> >> C.
> >>
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2HnjjwBZJnP787BF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrtMzgACgkQbDjKyiDZ
s5L0GQ//fFiBAYq+4SsM2B7zCT/VlzZSAImqvRL5Y+05K0WPZ9aDx92+bNhgU6E4
lDcEv2H8rWEXdgBAnQ0DRZpf81uJGwPc5dLiXGbme3JXLrPOXtieMtWEMJW5GPtL
SjMp0TJGQG1/Ns32We7jLScfgWj43dwq4F/3bvT5mlpICH/kYc8jqkJbPojNjkkS
bPzQ3xJq4+TeTiSVoDWTW/GQIKxbXmLkipB1SZKhl3VD7Ythb1MHB0NF/AQcnX6E
zQ3jBVMNFCMB5jfzOmUMyBX0+t2hqOXfCYCkAASnRmrgNHg+HAwaVxE+a6VOwZfU
QJxU+jDDuZGZPp2/zmqv5iHLxuSt2QEYBD0h6LAj9CraE7IIMg7nj72ZIYOfvb3e
BIjuyAHxWthDrr7crarrxp8OfnmNBLjjAaSP3i6hFOyR2p0aHasfPOADEF88GU5w
XSGNRuenXGr42irhSt1iKnL5t3FxjAD+A4eUT4uhuv9nkca/5dZpEBIiUB7xbwGx
tK6cVnGLbuod/XjEpckVaNmsgpVoYSPxVuNdFhjtRIcFWDy0Fjv6W+sF9qKNOrEa
4ADxJLpejn3XTHg+NvHPdtg3+LI7ok7d+QXRfgsgZgURsfBCf4Z6IZhbpFWVVzTE
j/2YpYf1IuRuwv9VQassTzSoDHQ0ItF9yBNWnyVIjc6/A4P+Lfc=
=bMZ0
-----END PGP SIGNATURE-----

--2HnjjwBZJnP787BF--
