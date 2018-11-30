Received: from eggs.gnu.org ([2001:4830:134:3::10]:36852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gSXeP-00082v-6Z
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 20:31:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gSXeJ-0000eu-6d
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 20:31:24 -0500
Date: Fri, 30 Nov 2018 12:04:10 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181130010410.GE30479@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-7-clg@kaod.org>
	<20181122051302.GG10448@umbus.fritz.box>
	<390808b9-250e-e1ae-ea54-fcf47b309833@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cYtjc4pxslFTELvY"
Content-Disposition: inline
In-Reply-To: <390808b9-250e-e1ae-ea54-fcf47b309833@kaod.org>
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


--cYtjc4pxslFTELvY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 29, 2018 at 11:06:13PM +0100, C=E9dric Le Goater wrote:
> On 11/22/18 6:13 AM, David Gibson wrote:
> > On Fri, Nov 16, 2018 at 11:56:59AM +0100, C=E9dric Le Goater wrote:
> >> The Event Notification Descriptor also contains two Event State
> >> Buffers providing further coalescing of interrupts, one for the
> >> notification event (ESn) and one for the escalation events (ESe). A
> >> MMIO page is assigned for each to control the EOI through loads
> >> only. Stores are not allowed.
> >>
> >> The END ESBs are modeled through an object resembling the 'XiveSource'
> >> It is stateless as the END state bits are backed into the XiveEND
> >> structure under the XiveRouter and the MMIO accesses follow the same
> >> rules as for the standard source ESBs.
> >>
> >> END ESBs are not supported by the Linux drivers neither on OPAL nor on
> >> sPAPR. Nevetherless, it provides a mean to study the question in the
> >> future and validates a bit more the XIVE model.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >>  include/hw/ppc/xive.h |  20 ++++++
> >>  hw/intc/xive.c        | 160 +++++++++++++++++++++++++++++++++++++++++-
> >>  2 files changed, 178 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> >> index ce62aaf28343..24301bf2076d 100644
> >> --- a/include/hw/ppc/xive.h
> >> +++ b/include/hw/ppc/xive.h
> >> @@ -208,6 +208,26 @@ int xive_router_get_end(XiveRouter *xrtr, uint8_t=
 end_blk, uint32_t end_idx,
> >>  int xive_router_set_end(XiveRouter *xrtr, uint8_t end_blk, uint32_t e=
nd_idx,
> >>                          XiveEND *end);
> >> =20
> >> +/*
> >> + * XIVE END ESBs
> >> + */
> >> +
> >> +#define TYPE_XIVE_END_SOURCE "xive-end-source"
> >> +#define XIVE_END_SOURCE(obj) \
> >> +    OBJECT_CHECK(XiveENDSource, (obj), TYPE_XIVE_END_SOURCE)
> >=20
> > Is there a particular reason to make this a full QOM object, rather
> > than just embedding it in the XiveRouter?
>=20
> Coming back on this question because removing the chip_id from the
> router is a problem for the END triggering. At least with the current
> design. See below for the comment.
>=20
> >> +typedef struct XiveENDSource {
> >> +    SysBusDevice parent;
> >> +
> >> +    uint32_t        nr_ends;
> >> +
> >> +    /* ESB memory region */
> >> +    uint32_t        esb_shift;
> >> +    MemoryRegion    esb_mmio;
> >> +
> >> +    XiveRouter      *xrtr;
> >> +} XiveENDSource;
> >> +
> >>  /*
> >>   * For legacy compatibility, the exceptions define up to 256 different
> >>   * priorities. P9 implements only 9 levels : 8 active levels [0 - 7]
> >> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> >> index 9cb001e7b540..5a8882d47a98 100644
> >> --- a/hw/intc/xive.c
> >> +++ b/hw/intc/xive.c
> >> @@ -622,8 +622,18 @@ static void xive_router_end_notify(XiveRouter *xr=
tr, uint8_t end_blk,
> >>       * even futher coalescing in the Router
> >>       */
> >>      if (!(end.w0 & END_W0_UCOND_NOTIFY)) {
> >> -        qemu_log_mask(LOG_UNIMP, "XIVE: !UCOND_NOTIFY not implemented=
\n");
> >> -        return;
> >> +        uint8_t pq =3D GETFIELD(END_W1_ESn, end.w1);
> >> +        bool notify =3D xive_esb_trigger(&pq);
> >> +
> >> +        if (pq !=3D GETFIELD(END_W1_ESn, end.w1)) {
> >> +            end.w1 =3D SETFIELD(END_W1_ESn, end.w1, pq);
> >> +            xive_router_set_end(xrtr, end_blk, end_idx, &end);
> >> +        }
> >> +
> >> +        /* ESn[Q]=3D1 : end of notification */
> >> +        if (!notify) {
> >> +            return;
> >> +        }
> >>      }
> >> =20
> >>      /*
> >> @@ -706,6 +716,151 @@ void xive_eas_pic_print_info(XiveEAS *eas, uint3=
2_t lisn, Monitor *mon)
> >>                     (uint32_t) GETFIELD(EAS_END_DATA, eas->w));
> >>  }
> >> =20
> >> +/*
> >> + * END ESB MMIO loads
> >> + */
> >> +static uint64_t xive_end_source_read(void *opaque, hwaddr addr, unsig=
ned size)
> >> +{
> >> +    XiveENDSource *xsrc =3D XIVE_END_SOURCE(opaque);
> >> +    XiveRouter *xrtr =3D xsrc->xrtr;
> >> +    uint32_t offset =3D addr & 0xFFF;
> >> +    uint8_t end_blk;
> >> +    uint32_t end_idx;
> >> +    XiveEND end;
> >> +    uint32_t end_esmask;
> >> +    uint8_t pq;
> >> +    uint64_t ret =3D -1;
> >> +
> >> +    end_blk =3D xrtr->chip_id;
> >> +    end_idx =3D addr >> (xsrc->esb_shift + 1);
> >> +    if (xive_router_get_end(xrtr, end_blk, end_idx, &end)) {
>=20
> The current END accessors require a block identifier, hence xrtr->chip_id=
,=20
> but in this case, we don't really need it because we are using the ENDT=
=20
> local to the router/chip.=20

> I don't know how to handle simply this case without keeping chip_id :/

I don't really follow how chip_id is relevant here.  AFAICT the END
accessors take a block id and the back end is responsible for
interpreting them.  The ponwernv one will map it to chip id, but the
PAPR one can just ignore it or only use block 0.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cYtjc4pxslFTELvY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwAjIoACgkQbDjKyiDZ
s5K+Sw/+Kz1p9qVEEShDCY4EmEl1bm4gsijAXF2asExN3yZQ0CRNermqqnMi/5rS
UH86laddAn+nosOqDozK/MUQyWuMzQBwjAPCoDhMBybvISvTO6EfxzFaPDHjVkWw
p/SiZ7RdywKTtw7I5+WrBnZl/BIc1FU0LfZTcrCWbhgY5wi6xJxrqU7/+JXcL0wL
4J6jlb6F5f7gaZKHovBeCG4H1KL9ZgUeGZ3TnCERli7zCdjklb4XNLaY9gSKg39u
flGSu2ENyLgI66mVwo2jYYjKyDymWZUR1wV5ZIWZTZM4GLKx9PSlBVNQydJvGRvq
MXSd63RFxXPcDWbuENRRd8Chpo/WJG1EafBz9E704KgPod8Xz8psG/XoXp6mHVt9
GSnX1ZEeVPsfyU7BLtYFEhL1gMzTtEUXNTxEL/koWryRo5XbUevG+j8GtLIXfaFA
VLc4QuM/lShvBnqQTLM2uylNRh3J7TqecvfGnG9GUgi6C2Sxqfb52ZNal/JVKtz2
zQreWXMfLNkiNwdwWkeXxaZ7ovqT6gPoOw5KlfFIgKf55Q6GqQWMiOV1nxlVxw9s
AjoHKdywxK+PXWbMIw0F+DLzurMhUyDHGiea8NIYj6dKvSiY4W9SD+a7ILVKCZkD
YRNTe/nweY11pg7nfAa477NFmKt+a2U4oqw0ZprHr7emiLUuuaA=
=kAru
-----END PGP SIGNATURE-----

--cYtjc4pxslFTELvY--
