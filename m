Received: from eggs.gnu.org ([2001:4830:134:3::10]:45711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gTdwx-0004AK-3O
	for qemu-devel@nongnu.org; Sun, 02 Dec 2018 21:27:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gTdwt-0007ov-Td
	for qemu-devel@nongnu.org; Sun, 02 Dec 2018 21:27:07 -0500
Date: Mon, 3 Dec 2018 12:14:06 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181203011406.GP30479@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-7-clg@kaod.org>
	<20181122051302.GG10448@umbus.fritz.box>
	<390808b9-250e-e1ae-ea54-fcf47b309833@kaod.org>
	<20181130010410.GE30479@umbus.fritz.box>
	<d8ba2082-625f-b547-47af-416148c04e9c@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QKpLca3blcvhMJ0W"
Content-Disposition: inline
In-Reply-To: <d8ba2082-625f-b547-47af-416148c04e9c@kaod.org>
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


--QKpLca3blcvhMJ0W
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 30, 2018 at 07:41:33AM +0100, C=E9dric Le Goater wrote:
> On 11/30/18 2:04 AM, David Gibson wrote:
> > On Thu, Nov 29, 2018 at 11:06:13PM +0100, C=E9dric Le Goater wrote:
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
> >> Coming back on this question because removing the chip_id from the
> >> router is a problem for the END triggering. At least with the current
> >> design. See below for the comment.
> >>
> >>>> +typedef struct XiveENDSource {
> >>>> +    SysBusDevice parent;
> >>>> +
> >>>> +    uint32_t        nr_ends;
> >>>> +
> >>>> +    /* ESB memory region */
> >>>> +    uint32_t        esb_shift;
> >>>> +    MemoryRegion    esb_mmio;
> >>>> +
> >>>> +    XiveRouter      *xrtr;
> >>>> +} XiveENDSource;
> >>>> +
> >>>>  /*
> >>>>   * For legacy compatibility, the exceptions define up to 256 differ=
ent
> >>>>   * priorities. P9 implements only 9 levels : 8 active levels [0 - 7]
> >>>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> >>>> index 9cb001e7b540..5a8882d47a98 100644
> >>>> --- a/hw/intc/xive.c
> >>>> +++ b/hw/intc/xive.c
> >>>> @@ -622,8 +622,18 @@ static void xive_router_end_notify(XiveRouter *=
xrtr, uint8_t end_blk,
> >>>>       * even futher coalescing in the Router
> >>>>       */
> >>>>      if (!(end.w0 & END_W0_UCOND_NOTIFY)) {
> >>>> -        qemu_log_mask(LOG_UNIMP, "XIVE: !UCOND_NOTIFY not implement=
ed\n");
> >>>> -        return;
> >>>> +        uint8_t pq =3D GETFIELD(END_W1_ESn, end.w1);
> >>>> +        bool notify =3D xive_esb_trigger(&pq);
> >>>> +
> >>>> +        if (pq !=3D GETFIELD(END_W1_ESn, end.w1)) {
> >>>> +            end.w1 =3D SETFIELD(END_W1_ESn, end.w1, pq);
> >>>> +            xive_router_set_end(xrtr, end_blk, end_idx, &end);
> >>>> +        }
> >>>> +
> >>>> +        /* ESn[Q]=3D1 : end of notification */
> >>>> +        if (!notify) {
> >>>> +            return;
> >>>> +        }
> >>>>      }
> >>>> =20
> >>>>      /*
> >>>> @@ -706,6 +716,151 @@ void xive_eas_pic_print_info(XiveEAS *eas, uin=
t32_t lisn, Monitor *mon)
> >>>>                     (uint32_t) GETFIELD(EAS_END_DATA, eas->w));
> >>>>  }
> >>>> =20
> >>>> +/*
> >>>> + * END ESB MMIO loads
> >>>> + */
> >>>> +static uint64_t xive_end_source_read(void *opaque, hwaddr addr, uns=
igned size)
> >>>> +{
> >>>> +    XiveENDSource *xsrc =3D XIVE_END_SOURCE(opaque);
> >>>> +    XiveRouter *xrtr =3D xsrc->xrtr;
> >>>> +    uint32_t offset =3D addr & 0xFFF;
> >>>> +    uint8_t end_blk;
> >>>> +    uint32_t end_idx;
> >>>> +    XiveEND end;
> >>>> +    uint32_t end_esmask;
> >>>> +    uint8_t pq;
> >>>> +    uint64_t ret =3D -1;
> >>>> +
> >>>> +    end_blk =3D xrtr->chip_id;
> >>>> +    end_idx =3D addr >> (xsrc->esb_shift + 1);
> >>>> +    if (xive_router_get_end(xrtr, end_blk, end_idx, &end)) {
> >>
> >> The current END accessors require a block identifier, hence xrtr->chip=
_id,=20
> >> but in this case, we don't really need it because we are using the END=
T=20
> >> local to the router/chip.=20
> >=20
> >> I don't know how to handle simply this case without keeping chip_id :/
> >=20
> > I don't really follow how chip_id is relevant here.  AFAICT the END
> > accessors take a block id and the back end is responsible for
> > interpreting them.  The ponwernv one will map it to chip id, but the
> > PAPR one can just ignore it or only use block 0.
>=20
> Yes. But the block value comes from the xrtr->chip_id today, on PAPR and
> PowerNV, even if it's block 0.=20
>=20
> What I could do is add a "chip-id" property to XiveENDSource possibly.

This still seems wrong for the PAPR model.  Why can't you configure
the end_block value directly in the Xive components, then just set it
equal to the chip_id when you build the powernv machine?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--QKpLca3blcvhMJ0W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwEg10ACgkQbDjKyiDZ
s5IlxxAA07UD8GMO7hZFHyb2zPPuKIebcCZHPHuSoRwMeTIeF+k6MctEJ7kHAoXN
KEanCEV5FO3HKgXv8uZ45DzkXth97wwwYBQxkqTkksONTfQmcs0bb8V/RYww9PZN
PgFGy4ht2PeRwxf5Xyo6G3Ajn5IKGrlcKsRJm8W8vIr6fuqmTk0mn2MFPc+4k2xa
2hNzwjZiNjhasYicOAKe/jxnItfWekTf8OsBrNEhw0bqYbkysLtOLRMBhK1NZkKH
S0JI5jJEQrwn247w0l7VChYBNxXZfHIFHt1uZN6tukNa6KrckeW2vDb099Lc04zn
EtyafWm62cZKSX4evLFKRsK+KgaxuNAPtTgv0K2S7sggf6U/KWxYclq+lpEGKEFo
w4ET8lbVddwovxVZB5XHALyROe8ASEwLPW5S5Xk8tUVNY7qBxU/73OgZtHQoTSg/
WvdKKUTFsCCvyELDnWU2+Bw7y/b5V1DUaRH5JN/UAbU09Pr6X5yGsffdBLegF9Ga
QTiC1O3NZRujzbCoT6BQLRDxobNhFrSGJtOpCmY2bxMhow7ifIlW0004JQXOGdFG
qzLGVdUIHarR4U+e2+vgudtDrIByu+SWXzVZX5jVQu7mCCrYi1LeJygITRYm29A4
WkrcT+Dz3BSko/E/gZIjxr6DdRyQWBtyjJ87GNddG6aVzxYk96s=
=iZAz
-----END PGP SIGNATURE-----

--QKpLca3blcvhMJ0W--
