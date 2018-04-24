Received: from eggs.gnu.org ([2001:4830:134:3::10]:56729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fAsh5-0000AB-Nu
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 03:48:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fAsh2-0000Xb-Bq
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 03:48:55 -0400
Date: Tue, 24 Apr 2018 16:41:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180424064119.GO19804@umbus.fritz.box>
References: <20180419124331.3915-1-clg@kaod.org>
	<20180419124331.3915-3-clg@kaod.org>
	<20180423064408.GF19804@umbus.fritz.box>
	<ac69df02-8ee8-0506-36ac-83fdaccdca77@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yLaBmHMi4cq+C/u4"
Content-Disposition: inline
In-Reply-To: <ac69df02-8ee8-0506-36ac-83fdaccdca77@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v3 02/35] ppc/xive: add support for the LSI
 interrupt sources
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


--yLaBmHMi4cq+C/u4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 23, 2018 at 09:31:24AM +0200, C=E9dric Le Goater wrote:
> On 04/23/2018 08:44 AM, David Gibson wrote:
> > On Thu, Apr 19, 2018 at 02:42:58PM +0200, C=E9dric Le Goater wrote:
> >> The 'sent' status of the LSI interrupt source is modeled with the 'P'
> >> bit of the ESB and the assertion status of the source is maintained in
> >> an array under the main sPAPRXive object. The type of the source is
> >> stored in the same array for practical reasons.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >>  hw/intc/xive.c        | 54 ++++++++++++++++++++++++++++++++++++++++++=
+++++----
> >>  include/hw/ppc/xive.h | 16 +++++++++++++++
> >>  2 files changed, 66 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> >> index c70578759d02..060976077dd7 100644
> >> --- a/hw/intc/xive.c
> >> +++ b/hw/intc/xive.c
> >> @@ -104,6 +104,21 @@ static void xive_source_notify(XiveSource *xsrc, =
int srcno)
> >> =20
> >>  }
> >> =20
> >> +/*
> >> + * LSI interrupt sources use the P bit and a custom assertion flag
> >> + */
> >> +static bool xive_source_lsi_trigger(XiveSource *xsrc, uint32_t srcno)
> >> +{
> >> +    uint8_t old_pq =3D xive_source_pq_get(xsrc, srcno);
> >> +
> >> +    if  (old_pq =3D=3D XIVE_ESB_RESET &&
> >> +         xsrc->status[srcno] & XIVE_STATUS_ASSERTED) {
> >> +        xive_source_pq_set(xsrc, srcno, XIVE_ESB_PENDING);
> >> +        return true;
> >> +    }
> >> +    return false;
> >> +}
> >> +
> >>  /* In a two pages ESB MMIO setting, even page is the trigger page, odd
> >>   * page is for management */
> >>  static inline bool xive_source_is_trigger_page(hwaddr addr)
> >> @@ -133,6 +148,13 @@ static uint64_t xive_source_esb_read(void *opaque=
, hwaddr addr, unsigned size)
> >>           */
> >>          ret =3D xive_source_pq_eoi(xsrc, srcno);
> >> =20
> >> +        /* If the LSI source is still asserted, forward a new source
> >> +         * event notification */
> >> +        if (xive_source_irq_is_lsi(xsrc, srcno)) {
> >> +            if (xive_source_lsi_trigger(xsrc, srcno)) {
> >> +                xive_source_notify(xsrc, srcno);
> >> +            }
> >> +        }
> >>          break;
> >> =20
> >>      case XIVE_ESB_GET:
> >> @@ -183,6 +205,14 @@ static void xive_source_esb_write(void *opaque, h=
waddr addr,
> >>           * notification
> >>           */
> >>          notify =3D xive_source_pq_eoi(xsrc, srcno);
> >> +
> >> +        /* LSI sources do not set the Q bit but they can still be
> >> +         * asserted, in which case we should forward a new source
> >> +         * event notification
> >> +         */
> >> +        if (xive_source_irq_is_lsi(xsrc, srcno)) {
> >> +            notify =3D xive_source_lsi_trigger(xsrc, srcno);
> >> +        }
>=20
> FYI, I have moved that common test under xive_source_pq_eoi()

Ok.

> >>          break;
> >> =20
> >>      default:
> >> @@ -216,8 +246,17 @@ static void xive_source_set_irq(void *opaque, int=
 srcno, int val)
> >>      XiveSource *xsrc =3D XIVE_SOURCE(opaque);
> >>      bool notify =3D false;
> >> =20
> >> -    if (val) {
> >> -        notify =3D xive_source_pq_trigger(xsrc, srcno);
> >> +    if (xive_source_irq_is_lsi(xsrc, srcno)) {
> >> +        if (val) {
> >> +            xsrc->status[srcno] |=3D XIVE_STATUS_ASSERTED;
> >> +        } else {
> >> +            xsrc->status[srcno] &=3D ~XIVE_STATUS_ASSERTED;
> >> +        }
> >> +        notify =3D xive_source_lsi_trigger(xsrc, srcno);
> >> +    } else {
> >> +        if (val) {
> >> +            notify =3D xive_source_pq_trigger(xsrc, srcno);
> >> +        }
> >>      }
> >> =20
> >>      /* Forward the source event notification for routing */
> >> @@ -234,13 +273,13 @@ void xive_source_pic_print_info(XiveSource *xsrc=
, Monitor *mon)
> >>                     xsrc->offset, xsrc->offset + xsrc->nr_irqs - 1);
> >>      for (i =3D 0; i < xsrc->nr_irqs; i++) {
> >>          uint8_t pq =3D xive_source_pq_get(xsrc, i);
> >> -        uint32_t lisn =3D i  + xsrc->offset;
> >> =20
> >>          if (pq =3D=3D XIVE_ESB_OFF) {
> >>              continue;
> >>          }
> >> =20
> >> -        monitor_printf(mon, "  %4x %c%c\n", lisn,
> >> +        monitor_printf(mon, "  %4x %s %c%c\n", i + xsrc->offset,
> >> +                       xive_source_irq_is_lsi(xsrc, i) ? "LSI" : "MSI=
",
> >>                         pq & XIVE_ESB_VAL_P ? 'P' : '-',
> >>                         pq & XIVE_ESB_VAL_Q ? 'Q' : '-');
> >>      }
> >> @@ -249,6 +288,12 @@ void xive_source_pic_print_info(XiveSource *xsrc,=
 Monitor *mon)
> >>  static void xive_source_reset(DeviceState *dev)
> >>  {
> >>      XiveSource *xsrc =3D XIVE_SOURCE(dev);
> >> +    int i;
> >> +
> >> +    /* Keep the IRQ type */
> >> +    for (i =3D 0; i < xsrc->nr_irqs; i++) {
> >> +        xsrc->status[i] &=3D ~XIVE_STATUS_ASSERTED;
> >> +    }
> >> =20
> >>      /* SBEs are initialized to 0b01 which corresponds to "ints off" */
> >>      memset(xsrc->sbe, 0x55, xsrc->sbe_size);
> >> @@ -273,6 +318,7 @@ static void xive_source_realize(DeviceState *dev, =
Error **errp)
> >> =20
> >>      xsrc->qirqs =3D qemu_allocate_irqs(xive_source_set_irq, xsrc,
> >>                                       xsrc->nr_irqs);
> >> +    xsrc->status =3D g_malloc0(xsrc->nr_irqs);
> >> =20
> >>      /* Allocate the SBEs (State Bit Entry). 2 bits, so 4 entries per =
byte */
> >>      xsrc->sbe_size =3D DIV_ROUND_UP(xsrc->nr_irqs, 4);
> >> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> >> index d92a50519edf..0b76dd278d9b 100644
> >> --- a/include/hw/ppc/xive.h
> >> +++ b/include/hw/ppc/xive.h
> >> @@ -33,6 +33,9 @@ typedef struct XiveSource {
> >>      uint32_t     nr_irqs;
> >>      uint32_t     offset;
> >>      qemu_irq     *qirqs;
> >> +#define XIVE_STATUS_LSI         0x1
> >> +#define XIVE_STATUS_ASSERTED    0x2
> >> +    uint8_t      *status;
> >=20
> > I don't love the idea of mixing configuration information (STATUS_LSI)
> > with runtime state information (ASSERTED) in the same field.  Any
> > reason not to have these as parallel bitmaps.
>=20
> none. I can change that.=20

Ok.

> > Come to that.. is there a compelling reason to allow any individual
> > irq to be marked LSI or MSI, rather than using separate XiveSource
> > objects for MSIs and LSIs?
>=20
> yes. I would have preferred two distinct interrupt source objects but=20
> this is to be compatible with XICS, which uses only one. If we want
> to be able to change interrupt mode, the IRQ number space should be
> organized in the exact same way. Or we should change XICS also.
>=20
> Also, the change (a bitmap) is really small.

Hrm, but since XIVE supports thousands of irqs, it could be quite a
large bitmap.

It's not impossible - in fact, not really even that hard - to change
the existing irq layout on xics.  It does need a new machine type
variant, of course.

> >>      /* PQ bits */
> >>      uint8_t      *sbe;
> >=20
> > .. and come to that is there a reason to keep the ASSERTED bit in a
> > separate array from sbe?  AFAICT the actual 2-bit-per-irq layout is
> > never exposed to the guests.
>=20
> indeed. we always use the xive_source_pq_get/set() helpers to=20
> manipulate the PQ bits. So we could add an extra bit for the ASSERT=20
> without too much changes. Could also we put the type there or would=20
> you still prefer a bitmap ? =20

I'd prefer the type (config information) be separate from the P, Q,
ASSERTED bits (state information).

> > Or, even re-use the Q bit for asserted in LSIs (but report it as
> > always 0 in the register read/write path).
>=20
> I would prefer to add extra status bits. It is easier to debug.
>=20
> Thanks,
>=20
> C.
>=20
> >> @@ -127,4 +130,17 @@ uint8_t xive_source_pq_set(XiveSource *xsrc, uint=
32_t srcno, uint8_t pq);
> >> =20
> >>  void xive_source_pic_print_info(XiveSource *xsrc, Monitor *mon);
> >> =20
> >> +static inline bool xive_source_irq_is_lsi(XiveSource *xsrc, uint32_t =
srcno)
> >> +{
> >> +    assert(srcno < xsrc->nr_irqs);
> >> +    return xsrc->status[srcno] & XIVE_STATUS_LSI;
> >> +}
> >> +
> >> +static inline void xive_source_irq_set(XiveSource *xsrc, uint32_t src=
no,
> >> +                                       bool lsi)
> >> +{
> >> +    assert(srcno < xsrc->nr_irqs);
> >> +    xsrc->status[srcno] |=3D lsi ? XIVE_STATUS_LSI : 0;
> >> +}
> >> +
> >>  #endif /* PPC_XIVE_H */
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--yLaBmHMi4cq+C/u4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlre0Y0ACgkQbDjKyiDZ
s5JtnBAAr4msTLlP4PIpbeF1ePI/zQ5WN36Lve4+B1rOIyxRTElYcdI/JmXpcUqo
Y5zI06FCwXDOr3mnIO4BGHMc3hZqUmHL/pk8wNXTlbOFmlnuEPV6kguwriqtK4Ob
SOY3k7nEMbwuYlXF6hXgKYg8dt/GPJoOOj16f1UhYDgOtSnPRj++boEr8cwj5cJm
YUq3m2BZRuUhOulYXt8H0WEiOwhV0H07PKTWDkYfEhjGRoHc7O0tni1I+U/a+MK/
DhjwR2XLFeEvA8scXkLNT8niQNfL51dWUMlkEZCF4srz1m7qMWyT4NGlaffxZkmV
CGyTcjuIyna4O2aDi9JmsAg5L5N8sPSOgSk2bgLnfhVAqrWhEjUHsGJHdG7Y+0RI
j7W+4Ztd6lXnDA43A4Ih7hRNKAASKk3eHQcuMFPo8fBuC40Naxy0yH59TBJ77qmu
1LvCwGbKSKQ86HI+0dr85ydSRZ2Q8jj0eTnwkFNJ0T3gmJ4vvcPO2NboJ6Ynm533
/2tCUM/HPTrnKfjvc+O7VX1X4Jkdr2uH7IWUY6zq+9F85pUhjm9lTAaRQFspw4aM
2925a4KpnPZmEgA4AwRQNYKbnXf/mOimPcHP6puKnn8brNF6bT0AHXg0pQKhckLT
y1kxcxYTvy2k8Ule+SA4BjE6BcDNsiaWMqYJG9QZnSkbLjieRjY=
=l4DQ
-----END PGP SIGNATURE-----

--yLaBmHMi4cq+C/u4--
