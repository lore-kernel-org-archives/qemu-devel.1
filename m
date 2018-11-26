Received: from eggs.gnu.org ([2001:4830:134:3::10]:39505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gRBIL-0007iq-0t
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 02:27:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gRBIG-0005j8-Q2
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 02:27:00 -0500
Date: Mon, 26 Nov 2018 16:54:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181126055442.GI2251@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-7-clg@kaod.org>
	<20181122051302.GG10448@umbus.fritz.box>
	<14e8b331-0c33-b07e-01ca-a540852bea37@kaod.org>
	<20181123043611.GZ10448@umbus.fritz.box>
	<77c78ac1-d30c-b0ec-79af-d5a23085e39f@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="h22Fi9ANawrtbNPX"
Content-Disposition: inline
In-Reply-To: <77c78ac1-d30c-b0ec-79af-d5a23085e39f@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v5 06/36] ppc/xive: add support for the END
 Event State buffers
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


--h22Fi9ANawrtbNPX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 23, 2018 at 08:28:42AM +0100, C=E9dric Le Goater wrote:
> On 11/23/18 5:36 AM, David Gibson wrote:
> > On Thu, Nov 22, 2018 at 10:58:56PM +0100, C=E9dric Le Goater wrote:
> >> On 11/22/18 6:13 AM, David Gibson wrote:
> >>> On Fri, Nov 16, 2018 at 11:56:59AM +0100, C=E9dric Le Goater wrote:
> >>>> The Event Notification Descriptor also contains two Event State
> >>>> Buffers providing further coalescing of interrupts, one for the
> >>>> notification event (ESn) and one for the escalation events (ESe). A
> >>>> MMIO page is assigned for each to control the EOI through loads
> >>>> only. Stores are not allowed.
> >>>>
> >>>> The END ESBs are modeled through an object resembling the 'XiveSourc=
e'
> >>>> It is stateless as the END state bits are backed into the XiveEND
> >>>> structure under the XiveRouter and the MMIO accesses follow the same
> >>>> rules as for the standard source ESBs.
> >>>>
> >>>> END ESBs are not supported by the Linux drivers neither on OPAL nor =
on
> >>>> sPAPR. Nevetherless, it provides a mean to study the question in the
> >>>> future and validates a bit more the XIVE model.
> >>>>
> >>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >>>> ---
> >>>>  include/hw/ppc/xive.h |  20 ++++++
> >>>>  hw/intc/xive.c        | 160 +++++++++++++++++++++++++++++++++++++++=
++-
> >>>>  2 files changed, 178 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> >>>> index ce62aaf28343..24301bf2076d 100644
> >>>> --- a/include/hw/ppc/xive.h
> >>>> +++ b/include/hw/ppc/xive.h
> >>>> @@ -208,6 +208,26 @@ int xive_router_get_end(XiveRouter *xrtr, uint8=
_t end_blk, uint32_t end_idx,
> >>>>  int xive_router_set_end(XiveRouter *xrtr, uint8_t end_blk, uint32_t=
 end_idx,
> >>>>                          XiveEND *end);
> >>>> =20
> >>>> +/*
> >>>> + * XIVE END ESBs
> >>>> + */
> >>>> +
> >>>> +#define TYPE_XIVE_END_SOURCE "xive-end-source"
> >>>> +#define XIVE_END_SOURCE(obj) \
> >>>> +    OBJECT_CHECK(XiveENDSource, (obj), TYPE_XIVE_END_SOURCE)
> >>>
> >>> Is there a particular reason to make this a full QOM object, rather
> >>> than just embedding it in the XiveRouter?
> >>
> >> yes, it should probably be under the XiveRouter you are right because
> >> there is a direct link with the ENDT which is in the XiverRouter.=20
> >>
> >> But if I remove the chip_id field from the XiveRouter, it becomes a QOM
> >> interface. something to ponder.
> >=20
> > Huh?  I really don't understand what you're saying here.  What does
> > chip_id have to do with anything?
>=20
> I am quoting a comment of yours :
>=20
> 	> +/*
> 	> + * XIVE Router
> 	> + */
> 	> +
> 	> +typedef struct XiveRouter {
> 	> +    SysBusDevice    parent;
> 	> +
> 	> +    uint32_t        chip_id;
>=20
> 	I don't think this belongs in the base class.  The PowerNV specific
> 	variants will need it, but it doesn't make sense for the PAPR version.
>=20
>=20
> If we remove 'chip_id' from XiveRouter, it can become a QOM interface=20
> without state, like the XiveFabric is.

Hm, not really.  At this stage the object does't have any state, but
at least the pnv variants will have state for the registers which
point it to the EAST and ENDT, so a "real" object still makes more
sense than an interface.  If it were an interface it's not clear what
real object it would be attached to.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--h22Fi9ANawrtbNPX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlv7ip8ACgkQbDjKyiDZ
s5JnDQ//dsU2pbbA0c5/FsZlOmFNtYitg8LdqPLzsXM6HMcrLTDeEgpcw7d05EVe
yszuyJ3cLL78mGxePz2HW5TbbXwhPXo2Q+RT8s7U7gNqAv6pu5gnL4uT96BXSZBm
UKvaHBhbtyL0X1bAPJy2/QaRkQ7Wn+6JwUePUDo0L012TQ4tcLAbupDns/IZWjad
+Mue4Ei4i+3BOvOWQxn/pCb5MrtSABkBsj+NMuFG+LFnGz84LfSTebbzJLj7kh1m
4jTwe9hfowmFSL8hq56N9K0MhihHxURGmjOKts4iGAhbflbJAB6ozc+Zjv0fbI2v
CZR9IWlcIVo6V59C0i3c7Zry1Fo7kFqpbjIZ0xveGX/oc/ucSzjHrgx6upKb5PKR
TmvHlpfjA/Pi9M8cU5+xPSSUzObmNviygNEe2esCwMVhpyn18EvI1bu7TxuTNI5A
F+loc77nzcwF0SDOPO3m/8UlmJXvk7A9TRK7c7z5Sv/SKpbu4iQo4fcZnEN515S8
vy3REEHYWFpEo86YM8h+oCwZyIOU4vuzanqNiHE7nX7I6fbWM0g7lAql1NfknpQJ
p+c6KUkcUpMLcFjAC9Xuy9oV7IG5ieY+tkORGcVYP+3O1NSLO3t1YaO+wD+OuHBF
6omiWoO/YOHXDofUxJzCGOsH67UL4onxIISn/usMgUhXaPGyqEA=
=l0Zn
-----END PGP SIGNATURE-----

--h22Fi9ANawrtbNPX--
