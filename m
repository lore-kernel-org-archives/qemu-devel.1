Received: from eggs.gnu.org ([2001:4830:134:3::10]:37404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gTzzn-0004yZ-N7
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 20:59:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gTzzk-000585-Ur
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 20:59:31 -0500
Date: Tue, 4 Dec 2018 12:54:19 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181204015419.GF1682@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-9-clg@kaod.org>
	<20181127234956.GR2251@umbus.fritz.box>
	<c16b55c5-8144-82bc-37f7-70427c6460a4@kaod.org>
	<20181129004718.GJ2251@umbus.fritz.box>
	<c6a8a8cf-3782-0d64-d4c9-68ee5f7d2e96@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Content-Disposition: inline
In-Reply-To: <c6a8a8cf-3782-0d64-d4c9-68ee5f7d2e96@kaod.org>
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


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 03, 2018 at 06:05:12PM +0100, C=E9dric Le Goater wrote:
> I forgot to reply to this one.
>=20
> On 11/29/18 1:47 AM, David Gibson wrote:
> > On Wed, Nov 28, 2018 at 11:59:58AM +0100, C=E9dric Le Goater wrote:
> >> On 11/28/18 12:49 AM, David Gibson wrote:
> >>> On Fri, Nov 16, 2018 at 11:57:01AM +0100, C=E9dric Le Goater wrote:
> >>>> The last sub-engine of the XIVE architecture is the Interrupt
> >>>> Virtualization Presentation Engine (IVPE). On HW, they share element=
s,
> >>>> the Power Bus interface (CQ), the routing table descriptors, and they
> >>>> can be combined in the same HW logic. We do the same in QEMU and
> >>>> combine both engines in the XiveRouter for simplicity.
> >>>
> >>> Ok, I'm not entirely convinced combining the IVPE and IVRE into a
> >>> single object is a good idea, but we can probably discuss that once
> >>> I've read further.
> >>
> >> We could introduce a simplified presenter for sPAPR but I am not even
> >> sure of that as it will get more complex if we support the EBB
> >> one day.

[snip]
> >>>> +static inline uint32_t xive_tctx_cam_line(uint8_t nvt_blk, uint32_t=
 nvt_idx)
> >>>> +{
> >>>> +    return (nvt_blk << 19) | nvt_idx;
> >>>
> >>> I'm guessing this formula is the standard way of combining the NVT
> >>> block and index into a single word? =20
> >>
> >> That number is the VP/NVT identifier which is written in the CAM value=
=2E=20
> >> The index is on 19 bits because of the NVT  definition in the END=20
> >> structure. It is being increased to 24 bits on Power10=20
> >>
> >>> If so, I think we should
> >>> standardize on passing a single word "nvt_id" around and only
> >>> splitting it when we need to use the block separately. =20
> >>
> >> This is really the only place where we concatenate the two NVT values,
> >> block and index.=20
> >=20
> > Hm, ok.  I know we don't model them (yet, maybe ever) but could
> > combined values appear in the PowerBUS messages that handle remote
> > notifications?
>=20
> They do.=20
> =20
> >>> Same goes for
> >>> the end_id, assuming there's a standard way of putting that into a
> >>> single word.  That will address the point I raised earlier about lisn
> >>> being passed around as a single word, but these later stage ids being
> >>> split.
> >>
> >> Hmm, I am not sure this is a good option. It is not how the PowerNV=20
> >> model would use it, skiboot is very much aware of these blocks and=20
> >> indexes and for remote accesses chips are identified using the block.=
=20
> >> I will take a look at it but I am not found of it. I can add helpers=
=20
> >> in some places though.   =20
> >=20
> > Hm, ok.  Do the block and index appear as an (effectively) single
> > field in the EAS?
>=20
> no. In all XIVE structures, block and index are always distinct.

Hm.  Distinct in what sense?  I get that the fields are labelled
separately in the documentation, but if the fields are adjacent, you
could equally well treat them as one.

> >>>> +    if (!match->tctx) {
> >>>> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: NVT %x/%x is not disp=
atched\n",
> >>>> +                      nvt_blk, nvt_idx);
> >>>> +        return false;
> >>>
> >>> Hmm.. this isn't actually an error isn't it? At least not for powernv
> >>
> >> It is on sPAPR, it would mean the END was configured with an unknow CP=
U.=20
> >=20
> > Right.
> >=20
> >> It is not error on PowerNV, when we support escalations.
> >>
> >>> - that just means the NVT isn't currently dispatched, so we'll need to
> >>> trigger the escalation interrupt. =20
> >>
> >> Yes.
> >>
> >>> Does this get changed later in the series?
> >>
> >> No.
> >=20
> > But this code is common to PAPR and powernv, yes, so it will need to?
>=20
> When we add support for escalations, yes, it will change. Would you rather
> use an error_report() until then ?

Ah, I guess leaving an error until we implement escalation makes
sense.  It shouldn't be LOG_GUEST_ERROR, though, the guest didn't do
anything wrong, and error_report() doesn't really make sense for the
same reason.

LOG_UNIMP, I guess?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwF3kgACgkQbDjKyiDZ
s5Jl6A/+MNmMmPVJddpOUfeQMQqHZhm051HfJLKqgtaCfX/eFoe3ewXABBPOGELr
FRIX7vjctDUNOMN2Te7pvkTXRc/4CE5qkZBs5XsfRVXghZq7k0XSgckRMP9EmCYd
MxLsH8JAnG1BpnZoYOHrC9HHpv1/iMPhpkAyi4CAzcOMShM9vPLJjfm4S0qN5UWb
4Jf0MxP1TbP1kjrVtrEzVsfb3TlFeSOqZp8+VX5yoor6aue5w2RGvY6zQ0tLGSN1
hFPbh5/slBNaNnFKtBx6GY1MEf8iKrzRF9HCxJXg5SLKtvtOC0LUdoG47mUB+V0n
AiPD78GMYg6ioP1nEsOvgigc8O/66k3tZ6lnvVCRVN59/VV1xYGXYE1P4tXdZgye
I3eSCyOInAaysEkK7RFcdqac/BO8oPMKbh83JxmjbMdIHWuRV+PlRcJUQ8FpCMlG
wFqF7Y6cQ9SJ8nJ3XyKg3q4UzEmkEPybyWafZgwQ65kcKS5ZGCimk0Qu7Q9ANhWV
Rqeb3knkbkGjGhWjrgVSezFZlZL66csClBgnU8WXlMe6plOIGVGTZADbVXnG/vQq
EOONvzQLvEs0MQXsSyMQM0UUUnRnk5JyYthIobkCogZOOLPpFbpGOx2N66tRgG/x
cXIHiJ4vmzYrYFYwONGgtNSXFAbkTRChmKYaf2vRN9Oo/FY5osY=
=z/oU
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--
