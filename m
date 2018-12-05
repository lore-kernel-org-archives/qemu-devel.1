Received: from eggs.gnu.org ([2001:4830:134:3::10]:52734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gUMWh-0003on-FG
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 21:03:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gUMWc-0004nH-WC
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 21:02:59 -0500
Date: Wed, 5 Dec 2018 12:40:50 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181205014050.GB28910@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-9-clg@kaod.org>
	<20181127234956.GR2251@umbus.fritz.box>
	<c16b55c5-8144-82bc-37f7-70427c6460a4@kaod.org>
	<20181129004718.GJ2251@umbus.fritz.box>
	<c6a8a8cf-3782-0d64-d4c9-68ee5f7d2e96@kaod.org>
	<20181204015419.GF1682@umbus.fritz.box>
	<419bb915-5fa6-a1da-fbe7-6261155d1791@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Content-Disposition: inline
In-Reply-To: <419bb915-5fa6-a1da-fbe7-6261155d1791@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v5 08/36] ppc/xive: introduce a simplified
 XIVE presenter
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


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 04, 2018 at 06:04:13PM +0100, C=E9dric Le Goater wrote:
> On 12/4/18 2:54 AM, David Gibson wrote:
> > On Mon, Dec 03, 2018 at 06:05:12PM +0100, C=E9dric Le Goater wrote:
> >> I forgot to reply to this one.
> >>
> >> On 11/29/18 1:47 AM, David Gibson wrote:
> >>> On Wed, Nov 28, 2018 at 11:59:58AM +0100, C=E9dric Le Goater wrote:
> >>>> On 11/28/18 12:49 AM, David Gibson wrote:
> >>>>> On Fri, Nov 16, 2018 at 11:57:01AM +0100, C=E9dric Le Goater wrote:
> >>>>>> The last sub-engine of the XIVE architecture is the Interrupt
> >>>>>> Virtualization Presentation Engine (IVPE). On HW, they share eleme=
nts,
> >>>>>> the Power Bus interface (CQ), the routing table descriptors, and t=
hey
> >>>>>> can be combined in the same HW logic. We do the same in QEMU and
> >>>>>> combine both engines in the XiveRouter for simplicity.
> >>>>>
> >>>>> Ok, I'm not entirely convinced combining the IVPE and IVRE into a
> >>>>> single object is a good idea, but we can probably discuss that once
> >>>>> I've read further.
> >>>>
> >>>> We could introduce a simplified presenter for sPAPR but I am not even
> >>>> sure of that as it will get more complex if we support the EBB
> >>>> one day.
> >=20
> > [snip]
> >>>>>> +static inline uint32_t xive_tctx_cam_line(uint8_t nvt_blk, uint32=
_t nvt_idx)
> >>>>>> +{
> >>>>>> +    return (nvt_blk << 19) | nvt_idx;
> >>>>>
> >>>>> I'm guessing this formula is the standard way of combining the NVT
> >>>>> block and index into a single word? =20
> >>>>
> >>>> That number is the VP/NVT identifier which is written in the CAM val=
ue.=20
> >>>> The index is on 19 bits because of the NVT  definition in the END=20
> >>>> structure. It is being increased to 24 bits on Power10=20
> >>>>
> >>>>> If so, I think we should
> >>>>> standardize on passing a single word "nvt_id" around and only
> >>>>> splitting it when we need to use the block separately. =20
> >>>>
> >>>> This is really the only place where we concatenate the two NVT value=
s,
> >>>> block and index.=20
> >>>
> >>> Hm, ok.  I know we don't model them (yet, maybe ever) but could
> >>> combined values appear in the PowerBUS messages that handle remote
> >>> notifications?
> >>
> >> They do.=20
> >> =20
> >>>>> Same goes for
> >>>>> the end_id, assuming there's a standard way of putting that into a
> >>>>> single word.  That will address the point I raised earlier about li=
sn
> >>>>> being passed around as a single word, but these later stage ids bei=
ng
> >>>>> split.
> >>>>
> >>>> Hmm, I am not sure this is a good option. It is not how the PowerNV=
=20
> >>>> model would use it, skiboot is very much aware of these blocks and=
=20
> >>>> indexes and for remote accesses chips are identified using the block=
=2E=20
> >>>> I will take a look at it but I am not found of it. I can add helpers=
=20
> >>>> in some places though.   =20
> >>>
> >>> Hm, ok.  Do the block and index appear as an (effectively) single
> >>> field in the EAS?
> >>
> >> no. In all XIVE structures, block and index are always distinct.
> >=20
> > Hm.  Distinct in what sense?  I get that the fields are labelled
> > separately in the documentation, but if the fields are adjacent, you
> > could equally well treat them as one.
>=20
> yes. Indeed. They are adjacent. The size of the index is subject to=20
> change in P10.=20

Ah, ok.  If the boundary might change in P10 that is indeed a reason
to keep them separate.

> I am not sure that treating them as one will be of any help because=20
> we need to extract them from their XIVE structure with the *_INDEX=20
> and *_BLOCK masks first. I will take a look. May be not in v6.

Ok.

> >>>>>> +    if (!match->tctx) {
> >>>>>> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: NVT %x/%x is not di=
spatched\n",
> >>>>>> +                      nvt_blk, nvt_idx);
> >>>>>> +        return false;
> >>>>>
> >>>>> Hmm.. this isn't actually an error isn't it? At least not for power=
nv
> >>>>
> >>>> It is on sPAPR, it would mean the END was configured with an unknow =
CPU.=20
> >>>
> >>> Right.
> >>>
> >>>> It is not error on PowerNV, when we support escalations.
> >>>>
> >>>>> - that just means the NVT isn't currently dispatched, so we'll need=
 to
> >>>>> trigger the escalation interrupt. =20
> >>>>
> >>>> Yes.
> >>>>
> >>>>> Does this get changed later in the series?
> >>>>
> >>>> No.
> >>>
> >>> But this code is common to PAPR and powernv, yes, so it will need to?
> >>
> >> When we add support for escalations, yes, it will change. Would you ra=
ther
> >> use an error_report() until then ?
> >=20
> > Ah, I guess leaving an error until we implement escalation makes
> > sense.  It shouldn't be LOG_GUEST_ERROR, though, the guest didn't do
> > anything wrong, and error_report() doesn't really make sense for the
> > same reason.
> >=20
> > LOG_UNIMP, I guess?
>=20
> OK. will do.
>=20
> Thanks,
>=20
> C.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwHLKIACgkQbDjKyiDZ
s5Iiqw/+JRMn8iKdXgsmUBWa/2VaCNhR9gbQL+YuY8ivq/s7q9uzVOxsBkJyRsK4
EGvN1NJZ8W03gFn9QeO8Uw7s+BkYRXuZr7VD3zOHCjTg4gtqDHKEalW/oRnHCMMj
bOvMZes2T31ub9vFjBT1VDHwrKhaeYH5ics6OHmsUbFhPW2l6QmQ6f+XhUSp0pj0
219rf3VUXVz2eN91iTGMFiJ8K4hu2YD4FDLykqTdtE6WOVjlELEs6OmoSbBT4ZHx
MQv/CJP7Mijh/sxKRCuSxugqOXc/AbF+Fa0v/pXeCkv4mqynZbg3grRYmr7bz/Ct
zHZeAkomfZaXEq9rT5BiBt6H122C7G09IqXwh7ehMDzTKD1yQZJClHyUv8FIRUPK
NIDVgyvOnIn+ZIb9iZjLrftGPmb6QYGDswE38cP4RJ0KGuK+AQNI81WU5hEAbqR5
AWvwqe1oQJdDQiA1Y/LZYYTuaDe1FCfdFQLt3XHZyr9ij5s4GYBXbmD+nTcFOrrY
hiaZfizy8oWw/PkGphe8y0LbluA3K+Wp83Yl5TWZpRgrcDsBu6ZUMOvHRR9/jHyO
owLaJXXYjZOSSIt7AMCqS1C6ADz+OebDYOeNLCHGbnhHjL3I8l0dPk1g5EVpk3Eg
pv7r5IaPCJGUuALQVGkifAnvOpxEqo4cWLBfFOJZV6iK0y/f7aQ=
=f3zL
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
