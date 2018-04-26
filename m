Received: from eggs.gnu.org ([2001:4830:134:3::10]:38817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBY3c-0004zl-Oo
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 23:58:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBY3b-00082U-4D
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 23:58:56 -0400
Date: Thu, 26 Apr 2018 13:28:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180426032812.GD8800@umbus.fritz.box>
References: <20180419124331.3915-1-clg@kaod.org>
	<20180419124331.3915-3-clg@kaod.org>
	<20180423064408.GF19804@umbus.fritz.box>
	<ac69df02-8ee8-0506-36ac-83fdaccdca77@kaod.org>
	<20180424064119.GO19804@umbus.fritz.box>
	<0fb72eb1-d9b5-968b-137a-7d44af116530@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ylS2wUBXLOxYXZFQ"
Content-Disposition: inline
In-Reply-To: <0fb72eb1-d9b5-968b-137a-7d44af116530@kaod.org>
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


--ylS2wUBXLOxYXZFQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 24, 2018 at 10:11:27AM +0200, C=E9dric Le Goater wrote:
> On 04/24/2018 08:41 AM, David Gibson wrote:
> > On Mon, Apr 23, 2018 at 09:31:24AM +0200, C=E9dric Le Goater wrote:
> >> On 04/23/2018 08:44 AM, David Gibson wrote:
> >>> On Thu, Apr 19, 2018 at 02:42:58PM +0200, C=E9dric Le Goater wrote:
> >>>> The 'sent' status of the LSI interrupt source is modeled with the 'P'
> >>>> bit of the ESB and the assertion status of the source is maintained =
in
> >>>> an array under the main sPAPRXive object. The type of the source is
> >>>> stored in the same array for practical reasons.
> >>>>
> >>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >>>> ---
> >>>>  hw/intc/xive.c        | 54 ++++++++++++++++++++++++++++++++++++++++=
+++++++----
> >>>>  include/hw/ppc/xive.h | 16 +++++++++++++++
> >>>>  2 files changed, 66 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> >>>> index c70578759d02..060976077dd7 100644
> >>>> --- a/hw/intc/xive.c
> >>>> +++ b/hw/intc/xive.c
> >>>> @@ -104,6 +104,21 @@ static void xive_source_notify(XiveSource *xsrc=
, int srcno)
> >>>> =20
> >>>>  }
> >>>> =20
> >>>> +/*
> >>>> + * LSI interrupt sources use the P bit and a custom assertion flag
> >>>> + */
> >>>> +static bool xive_source_lsi_trigger(XiveSource *xsrc, uint32_t srcn=
o)
> >>>> +{
> >>>> +    uint8_t old_pq =3D xive_source_pq_get(xsrc, srcno);
> >>>> +
> >>>> +    if  (old_pq =3D=3D XIVE_ESB_RESET &&
> >>>> +         xsrc->status[srcno] & XIVE_STATUS_ASSERTED) {
> >>>> +        xive_source_pq_set(xsrc, srcno, XIVE_ESB_PENDING);
> >>>> +        return true;
> >>>> +    }
> >>>> +    return false;
> >>>> +}
> >>>> +
> >>>>  /* In a two pages ESB MMIO setting, even page is the trigger page, =
odd
> >>>>   * page is for management */
> >>>>  static inline bool xive_source_is_trigger_page(hwaddr addr)
> >>>> @@ -133,6 +148,13 @@ static uint64_t xive_source_esb_read(void *opaq=
ue, hwaddr addr, unsigned size)
> >>>>           */
> >>>>          ret =3D xive_source_pq_eoi(xsrc, srcno);
> >>>> =20
> >>>> +        /* If the LSI source is still asserted, forward a new source
> >>>> +         * event notification */
> >>>> +        if (xive_source_irq_is_lsi(xsrc, srcno)) {
> >>>> +            if (xive_source_lsi_trigger(xsrc, srcno)) {
> >>>> +                xive_source_notify(xsrc, srcno);
> >>>> +            }
> >>>> +        }
> >>>>          break;
> >>>> =20
> >>>>      case XIVE_ESB_GET:
> >>>> @@ -183,6 +205,14 @@ static void xive_source_esb_write(void *opaque,=
 hwaddr addr,
> >>>>           * notification
> >>>>           */
> >>>>          notify =3D xive_source_pq_eoi(xsrc, srcno);
> >>>> +
> >>>> +        /* LSI sources do not set the Q bit but they can still be
> >>>> +         * asserted, in which case we should forward a new source
> >>>> +         * event notification
> >>>> +         */
> >>>> +        if (xive_source_irq_is_lsi(xsrc, srcno)) {
> >>>> +            notify =3D xive_source_lsi_trigger(xsrc, srcno);
> >>>> +        }
> >>
> >> FYI, I have moved that common test under xive_source_pq_eoi()
> >=20
> > Ok.
> >=20
> >>>>          break;
> >>>> =20
> >>>>      default:
> >>>> @@ -216,8 +246,17 @@ static void xive_source_set_irq(void *opaque, i=
nt srcno, int val)
> >>>>      XiveSource *xsrc =3D XIVE_SOURCE(opaque);
> >>>>      bool notify =3D false;
> >>>> =20
> >>>> -    if (val) {
> >>>> -        notify =3D xive_source_pq_trigger(xsrc, srcno);
> >>>> +    if (xive_source_irq_is_lsi(xsrc, srcno)) {
> >>>> +        if (val) {
> >>>> +            xsrc->status[srcno] |=3D XIVE_STATUS_ASSERTED;
> >>>> +        } else {
> >>>> +            xsrc->status[srcno] &=3D ~XIVE_STATUS_ASSERTED;
> >>>> +        }
> >>>> +        notify =3D xive_source_lsi_trigger(xsrc, srcno);
> >>>> +    } else {
> >>>> +        if (val) {
> >>>> +            notify =3D xive_source_pq_trigger(xsrc, srcno);
> >>>> +        }
> >>>>      }
> >>>> =20
> >>>>      /* Forward the source event notification for routing */
> >>>> @@ -234,13 +273,13 @@ void xive_source_pic_print_info(XiveSource *xs=
rc, Monitor *mon)
> >>>>                     xsrc->offset, xsrc->offset + xsrc->nr_irqs - 1);
> >>>>      for (i =3D 0; i < xsrc->nr_irqs; i++) {
> >>>>          uint8_t pq =3D xive_source_pq_get(xsrc, i);
> >>>> -        uint32_t lisn =3D i  + xsrc->offset;
> >>>> =20
> >>>>          if (pq =3D=3D XIVE_ESB_OFF) {
> >>>>              continue;
> >>>>          }
> >>>> =20
> >>>> -        monitor_printf(mon, "  %4x %c%c\n", lisn,
> >>>> +        monitor_printf(mon, "  %4x %s %c%c\n", i + xsrc->offset,
> >>>> +                       xive_source_irq_is_lsi(xsrc, i) ? "LSI" : "M=
SI",
> >>>>                         pq & XIVE_ESB_VAL_P ? 'P' : '-',
> >>>>                         pq & XIVE_ESB_VAL_Q ? 'Q' : '-');
> >>>>      }
> >>>> @@ -249,6 +288,12 @@ void xive_source_pic_print_info(XiveSource *xsr=
c, Monitor *mon)
> >>>>  static void xive_source_reset(DeviceState *dev)
> >>>>  {
> >>>>      XiveSource *xsrc =3D XIVE_SOURCE(dev);
> >>>> +    int i;
> >>>> +
> >>>> +    /* Keep the IRQ type */
> >>>> +    for (i =3D 0; i < xsrc->nr_irqs; i++) {
> >>>> +        xsrc->status[i] &=3D ~XIVE_STATUS_ASSERTED;
> >>>> +    }
> >>>> =20
> >>>>      /* SBEs are initialized to 0b01 which corresponds to "ints off"=
 */
> >>>>      memset(xsrc->sbe, 0x55, xsrc->sbe_size);
> >>>> @@ -273,6 +318,7 @@ static void xive_source_realize(DeviceState *dev=
, Error **errp)
> >>>> =20
> >>>>      xsrc->qirqs =3D qemu_allocate_irqs(xive_source_set_irq, xsrc,
> >>>>                                       xsrc->nr_irqs);
> >>>> +    xsrc->status =3D g_malloc0(xsrc->nr_irqs);
> >>>> =20
> >>>>      /* Allocate the SBEs (State Bit Entry). 2 bits, so 4 entries pe=
r byte */
> >>>>      xsrc->sbe_size =3D DIV_ROUND_UP(xsrc->nr_irqs, 4);
> >>>> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> >>>> index d92a50519edf..0b76dd278d9b 100644
> >>>> --- a/include/hw/ppc/xive.h
> >>>> +++ b/include/hw/ppc/xive.h
> >>>> @@ -33,6 +33,9 @@ typedef struct XiveSource {
> >>>>      uint32_t     nr_irqs;
> >>>>      uint32_t     offset;
> >>>>      qemu_irq     *qirqs;
> >>>> +#define XIVE_STATUS_LSI         0x1
> >>>> +#define XIVE_STATUS_ASSERTED    0x2
> >>>> +    uint8_t      *status;
> >>>
> >>> I don't love the idea of mixing configuration information (STATUS_LSI)
> >>> with runtime state information (ASSERTED) in the same field.  Any
> >>> reason not to have these as parallel bitmaps.
> >>
> >> none. I can change that.=20
> >=20
> > Ok.
> >=20
> >>> Come to that.. is there a compelling reason to allow any individual
> >>> irq to be marked LSI or MSI, rather than using separate XiveSource
> >>> objects for MSIs and LSIs?
> >>
> >> yes. I would have preferred two distinct interrupt source objects but=
=20
> >> this is to be compatible with XICS, which uses only one. If we want
> >> to be able to change interrupt mode, the IRQ number space should be
> >> organized in the exact same way. Or we should change XICS also.
> >>
> >> Also, the change (a bitmap) is really small.
> >=20
> > Hrm, but since XIVE supports thousands of irqs, it could be quite a
> > large bitmap.
>=20
> Yes. The change is small, not the bitmap.
> =20
> > It's not impossible - in fact, not really even that hard - to change
> > the existing irq layout on xics.  It does need a new machine type
> > variant, of course.
>=20
> I did some work on that topic a while ago :
>=20
> 	https://patchwork.ozlabs.org/cover/836782/
>=20
> But we stopped exploring the idea. May be it was not the good approach.
> The PHBs LSIs would benefit from such a split though.

So, no, I don't think that was a good approach, but that doesn't mean
other ways of rearranging the irq numbers aren't ok.  The thing here
is that we don't want to think of an "irq allocator" - there are some
bits like that in there already, but they were always a mistake.

We have lots of irq space (both XICS and XIVE) so instead we should
come up with a static mapping of irqs to devices.


> >>>>      /* PQ bits */
> >>>>      uint8_t      *sbe;
> >>>
> >>> .. and come to that is there a reason to keep the ASSERTED bit in a
> >>> separate array from sbe?  AFAICT the actual 2-bit-per-irq layout is
> >>> never exposed to the guests.
> >>
> >> indeed. we always use the xive_source_pq_get/set() helpers to=20
> >> manipulate the PQ bits. So we could add an extra bit for the ASSERT=20
> >> without too much changes. Could also we put the type there or would=20
> >> you still prefer a bitmap ? =20
> >=20
> > I'd prefer the type (config information) be separate from the P, Q,
> > ASSERTED bits (state information).
>=20
> ok. So I will use the 'uint8_t *status' for P, Q, ASSERT, which leaves
> 5 bits available, but I don't think it is really worth the pain to=20
> optimize the size.

Sure.  I don't really care if it's packed or not.

> The sbe array will disappear and we will have=20
> a bitmap for the type.

We may or may not keep the type bitmap based on the discussion above,
but in any case this is a good step forward.

>=20
> Thanks,
>=20
> C.=20
>=20
> >>> Or, even re-use the Q bit for asserted in LSIs (but report it as
> >>> always 0 in the register read/write path).
> >>
> >> I would prefer to add extra status bits. It is easier to debug.
> >>
> >> Thanks,
> >>
> >> C.
> >>
> >>>> @@ -127,4 +130,17 @@ uint8_t xive_source_pq_set(XiveSource *xsrc, ui=
nt32_t srcno, uint8_t pq);
> >>>> =20
> >>>>  void xive_source_pic_print_info(XiveSource *xsrc, Monitor *mon);
> >>>> =20
> >>>> +static inline bool xive_source_irq_is_lsi(XiveSource *xsrc, uint32_=
t srcno)
> >>>> +{
> >>>> +    assert(srcno < xsrc->nr_irqs);
> >>>> +    return xsrc->status[srcno] & XIVE_STATUS_LSI;
> >>>> +}
> >>>> +
> >>>> +static inline void xive_source_irq_set(XiveSource *xsrc, uint32_t s=
rcno,
> >>>> +                                       bool lsi)
> >>>> +{
> >>>> +    assert(srcno < xsrc->nr_irqs);
> >>>> +    xsrc->status[srcno] |=3D lsi ? XIVE_STATUS_LSI : 0;
> >>>> +}
> >>>> +
> >>>>  #endif /* PPC_XIVE_H */
> >>>
> >>
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ylS2wUBXLOxYXZFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrhR0oACgkQbDjKyiDZ
s5Jv9BAA0b0eIRMIwStVt7LHgQJHGLm0btMmZzLmBobuvRjbzqd4wvo0yYFgsB46
OjWSd1uY/dZuyPwepXZ7EHQOx/WQypvTpT5V38X492JUTX0qOS/jRgn1hDwujx7X
QYhGgz9YfKKzADP/ET34k5VjeCERHDdA+mLjs0MsOkLMrmVuGDO6MqCLAZczk7gP
gt0wXfoZkjtsoKhyhmV2pXgGuu+nMhzWZYA5brHCtG14BPS8Y56DZR8EZ7cxPVLt
WyHgZPtYK2PkdtrDd8PNFfPj/lQYGveisywV++7cH2qi9ql4tbyBgI5i5BIopQs+
x+c0nPv3Jkc+YSvzjUINtmbgQtKWRKTPSV30OI/Z+ZkbKIW9pJiBituQkQha0iSU
GiZFGQkNC5tBLvdAkCMqg1kwWmqHVafD98HkvzOV3MuVthvJ9/ChZOsIFKmJj1F/
hk2CAOLH+71HDBSpBzACZ90Bo2tnZCtSRZSsXn/1U2X7WJZhm5dT8IIkDQRS2Sdt
zpCVP58yKB+A8azU/9v/Q6oYMqn8bnJfmZhzOUDHqRwEadA7N8F1Kqbew82/+U5i
BzejT4OBL9nb5x9ONMVl5Cjm/qBej4u4Uiuy8EthnSX6A0F2ikOR36PoAsvZ4HAf
FC6Xo/H+9QZ0d4HjYWI0DB5+R+2on6nHQZJLcCaheQRbiY2l1A4=
=XEMO
-----END PGP SIGNATURE-----

--ylS2wUBXLOxYXZFQ--
