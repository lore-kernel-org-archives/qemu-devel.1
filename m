Received: from eggs.gnu.org ([2001:4830:134:3::10]:44064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBtR9-0006Jm-TR
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 22:48:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBtR8-0008BZ-C0
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 22:48:39 -0400
Date: Fri, 27 Apr 2018 12:43:47 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180427024347.GM8800@umbus.fritz.box>
References: <20180419124331.3915-1-clg@kaod.org>
	<20180419124331.3915-3-clg@kaod.org>
	<20180423064408.GF19804@umbus.fritz.box>
	<ac69df02-8ee8-0506-36ac-83fdaccdca77@kaod.org>
	<20180424064119.GO19804@umbus.fritz.box>
	<0fb72eb1-d9b5-968b-137a-7d44af116530@kaod.org>
	<20180426032812.GD8800@umbus.fritz.box>
	<9c1bbe54-bdbf-ba1b-29b9-bd5df31b0f07@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XlS4q8O07AKt4+K1"
Content-Disposition: inline
In-Reply-To: <9c1bbe54-bdbf-ba1b-29b9-bd5df31b0f07@kaod.org>
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


--XlS4q8O07AKt4+K1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 26, 2018 at 02:16:06PM +0200, C=E9dric Le Goater wrote:
> On 04/26/2018 05:28 AM, David Gibson wrote:
> > On Tue, Apr 24, 2018 at 10:11:27AM +0200, C=E9dric Le Goater wrote:
> >> On 04/24/2018 08:41 AM, David Gibson wrote:
> >>> On Mon, Apr 23, 2018 at 09:31:24AM +0200, C=E9dric Le Goater wrote:
> >>>> On 04/23/2018 08:44 AM, David Gibson wrote:
> >>>>> On Thu, Apr 19, 2018 at 02:42:58PM +0200, C=E9dric Le Goater wrote:
> >>>>>> The 'sent' status of the LSI interrupt source is modeled with the =
'P'
> >>>>>> bit of the ESB and the assertion status of the source is maintaine=
d in
> >>>>>> an array under the main sPAPRXive object. The type of the source is
> >>>>>> stored in the same array for practical reasons.
> >>>>>>
> >>>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >>>>>> ---
> >>>>>>  hw/intc/xive.c        | 54 ++++++++++++++++++++++++++++++++++++++=
+++++++++----
> >>>>>>  include/hw/ppc/xive.h | 16 +++++++++++++++
> >>>>>>  2 files changed, 66 insertions(+), 4 deletions(-)
> >>>>>>
> >>>>>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> >>>>>> index c70578759d02..060976077dd7 100644
> >>>>>> --- a/hw/intc/xive.c
> >>>>>> +++ b/hw/intc/xive.c
> >>>>>> @@ -104,6 +104,21 @@ static void xive_source_notify(XiveSource *xs=
rc, int srcno)
> >>>>>> =20
> >>>>>>  }
> >>>>>> =20
> >>>>>> +/*
> >>>>>> + * LSI interrupt sources use the P bit and a custom assertion flag
> >>>>>> + */
> >>>>>> +static bool xive_source_lsi_trigger(XiveSource *xsrc, uint32_t sr=
cno)
> >>>>>> +{
> >>>>>> +    uint8_t old_pq =3D xive_source_pq_get(xsrc, srcno);
> >>>>>> +
> >>>>>> +    if  (old_pq =3D=3D XIVE_ESB_RESET &&
> >>>>>> +         xsrc->status[srcno] & XIVE_STATUS_ASSERTED) {
> >>>>>> +        xive_source_pq_set(xsrc, srcno, XIVE_ESB_PENDING);
> >>>>>> +        return true;
> >>>>>> +    }
> >>>>>> +    return false;
> >>>>>> +}
> >>>>>> +
> >>>>>>  /* In a two pages ESB MMIO setting, even page is the trigger page=
, odd
> >>>>>>   * page is for management */
> >>>>>>  static inline bool xive_source_is_trigger_page(hwaddr addr)
> >>>>>> @@ -133,6 +148,13 @@ static uint64_t xive_source_esb_read(void *op=
aque, hwaddr addr, unsigned size)
> >>>>>>           */
> >>>>>>          ret =3D xive_source_pq_eoi(xsrc, srcno);
> >>>>>> =20
> >>>>>> +        /* If the LSI source is still asserted, forward a new sou=
rce
> >>>>>> +         * event notification */
> >>>>>> +        if (xive_source_irq_is_lsi(xsrc, srcno)) {
> >>>>>> +            if (xive_source_lsi_trigger(xsrc, srcno)) {
> >>>>>> +                xive_source_notify(xsrc, srcno);
> >>>>>> +            }
> >>>>>> +        }
> >>>>>>          break;
> >>>>>> =20
> >>>>>>      case XIVE_ESB_GET:
> >>>>>> @@ -183,6 +205,14 @@ static void xive_source_esb_write(void *opaqu=
e, hwaddr addr,
> >>>>>>           * notification
> >>>>>>           */
> >>>>>>          notify =3D xive_source_pq_eoi(xsrc, srcno);
> >>>>>> +
> >>>>>> +        /* LSI sources do not set the Q bit but they can still be
> >>>>>> +         * asserted, in which case we should forward a new source
> >>>>>> +         * event notification
> >>>>>> +         */
> >>>>>> +        if (xive_source_irq_is_lsi(xsrc, srcno)) {
> >>>>>> +            notify =3D xive_source_lsi_trigger(xsrc, srcno);
> >>>>>> +        }
> >>>>
> >>>> FYI, I have moved that common test under xive_source_pq_eoi()
> >>>
> >>> Ok.
> >>>
> >>>>>>          break;
> >>>>>> =20
> >>>>>>      default:
> >>>>>> @@ -216,8 +246,17 @@ static void xive_source_set_irq(void *opaque,=
 int srcno, int val)
> >>>>>>      XiveSource *xsrc =3D XIVE_SOURCE(opaque);
> >>>>>>      bool notify =3D false;
> >>>>>> =20
> >>>>>> -    if (val) {
> >>>>>> -        notify =3D xive_source_pq_trigger(xsrc, srcno);
> >>>>>> +    if (xive_source_irq_is_lsi(xsrc, srcno)) {
> >>>>>> +        if (val) {
> >>>>>> +            xsrc->status[srcno] |=3D XIVE_STATUS_ASSERTED;
> >>>>>> +        } else {
> >>>>>> +            xsrc->status[srcno] &=3D ~XIVE_STATUS_ASSERTED;
> >>>>>> +        }
> >>>>>> +        notify =3D xive_source_lsi_trigger(xsrc, srcno);
> >>>>>> +    } else {
> >>>>>> +        if (val) {
> >>>>>> +            notify =3D xive_source_pq_trigger(xsrc, srcno);
> >>>>>> +        }
> >>>>>>      }
> >>>>>> =20
> >>>>>>      /* Forward the source event notification for routing */
> >>>>>> @@ -234,13 +273,13 @@ void xive_source_pic_print_info(XiveSource *=
xsrc, Monitor *mon)
> >>>>>>                     xsrc->offset, xsrc->offset + xsrc->nr_irqs - 1=
);
> >>>>>>      for (i =3D 0; i < xsrc->nr_irqs; i++) {
> >>>>>>          uint8_t pq =3D xive_source_pq_get(xsrc, i);
> >>>>>> -        uint32_t lisn =3D i  + xsrc->offset;
> >>>>>> =20
> >>>>>>          if (pq =3D=3D XIVE_ESB_OFF) {
> >>>>>>              continue;
> >>>>>>          }
> >>>>>> =20
> >>>>>> -        monitor_printf(mon, "  %4x %c%c\n", lisn,
> >>>>>> +        monitor_printf(mon, "  %4x %s %c%c\n", i + xsrc->offset,
> >>>>>> +                       xive_source_irq_is_lsi(xsrc, i) ? "LSI" : =
"MSI",
> >>>>>>                         pq & XIVE_ESB_VAL_P ? 'P' : '-',
> >>>>>>                         pq & XIVE_ESB_VAL_Q ? 'Q' : '-');
> >>>>>>      }
> >>>>>> @@ -249,6 +288,12 @@ void xive_source_pic_print_info(XiveSource *x=
src, Monitor *mon)
> >>>>>>  static void xive_source_reset(DeviceState *dev)
> >>>>>>  {
> >>>>>>      XiveSource *xsrc =3D XIVE_SOURCE(dev);
> >>>>>> +    int i;
> >>>>>> +
> >>>>>> +    /* Keep the IRQ type */
> >>>>>> +    for (i =3D 0; i < xsrc->nr_irqs; i++) {
> >>>>>> +        xsrc->status[i] &=3D ~XIVE_STATUS_ASSERTED;
> >>>>>> +    }
> >>>>>> =20
> >>>>>>      /* SBEs are initialized to 0b01 which corresponds to "ints of=
f" */
> >>>>>>      memset(xsrc->sbe, 0x55, xsrc->sbe_size);
> >>>>>> @@ -273,6 +318,7 @@ static void xive_source_realize(DeviceState *d=
ev, Error **errp)
> >>>>>> =20
> >>>>>>      xsrc->qirqs =3D qemu_allocate_irqs(xive_source_set_irq, xsrc,
> >>>>>>                                       xsrc->nr_irqs);
> >>>>>> +    xsrc->status =3D g_malloc0(xsrc->nr_irqs);
> >>>>>> =20
> >>>>>>      /* Allocate the SBEs (State Bit Entry). 2 bits, so 4 entries =
per byte */
> >>>>>>      xsrc->sbe_size =3D DIV_ROUND_UP(xsrc->nr_irqs, 4);
> >>>>>> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> >>>>>> index d92a50519edf..0b76dd278d9b 100644
> >>>>>> --- a/include/hw/ppc/xive.h
> >>>>>> +++ b/include/hw/ppc/xive.h
> >>>>>> @@ -33,6 +33,9 @@ typedef struct XiveSource {
> >>>>>>      uint32_t     nr_irqs;
> >>>>>>      uint32_t     offset;
> >>>>>>      qemu_irq     *qirqs;
> >>>>>> +#define XIVE_STATUS_LSI         0x1
> >>>>>> +#define XIVE_STATUS_ASSERTED    0x2
> >>>>>> +    uint8_t      *status;
> >>>>>
> >>>>> I don't love the idea of mixing configuration information (STATUS_L=
SI)
> >>>>> with runtime state information (ASSERTED) in the same field.  Any
> >>>>> reason not to have these as parallel bitmaps.
> >>>>
> >>>> none. I can change that.=20
> >>>
> >>> Ok.
> >>>
> >>>>> Come to that.. is there a compelling reason to allow any individual
> >>>>> irq to be marked LSI or MSI, rather than using separate XiveSource
> >>>>> objects for MSIs and LSIs?
> >>>>
> >>>> yes. I would have preferred two distinct interrupt source objects bu=
t=20
> >>>> this is to be compatible with XICS, which uses only one. If we want
> >>>> to be able to change interrupt mode, the IRQ number space should be
> >>>> organized in the exact same way. Or we should change XICS also.
> >>>>
> >>>> Also, the change (a bitmap) is really small.
> >>>
> >>> Hrm, but since XIVE supports thousands of irqs, it could be quite a
> >>> large bitmap.
> >>
> >> Yes. The change is small, not the bitmap.
> >> =20
> >>> It's not impossible - in fact, not really even that hard - to change
> >>> the existing irq layout on xics.  It does need a new machine type
> >>> variant, of course.
> >>
> >> I did some work on that topic a while ago :
> >>
> >> 	https://patchwork.ozlabs.org/cover/836782/
> >>
> >> But we stopped exploring the idea. May be it was not the good approach.
> >> The PHBs LSIs would benefit from such a split though.
> >=20
> > So, no, I don't think that was a good approach, but that doesn't mean
> > other ways of rearranging the irq numbers aren't ok.  The thing here
> > is that we don't want to think of an "irq allocator" - there are some
> > bits like that in there already, but they were always a mistake.
> >=20
> > We have lots of irq space (both XICS and XIVE) so instead we should
> > come up with a static mapping of irqs to devices.
>=20
> yes. I would prefer that also.=20
>=20
> We could change the spapr_irq_alloc() routine to get a block of=20
> IRQs in the range defined for a device family, and use a device=20
> id to offset in that family range ? Here are some figures :
>=20
> device family        block size  max devices =20
>=20
> EVENT_CLASS_EPOW              1           1 =20
> EVENT_CLASS_HOT_PLUG          1           1  =20
> VIO_VSCSI                     1          10 =20
> VIO_LLAN                      1          10 =20
> VIO_VTY                       1           5 =20
>                      =20
> PCI/PHB                    1024           5 =20

No, I'm thinking we should eliminate spapr_irq_alloc() entirely.
Well, ok, not entirely, we'll still need it for the old machine
types.  But remove it's use for the current machine type completely.

Instead we have an explicit map of ranges for various purposes.  The
one-off things like EPOW and HOTPLUG can have plain constant values.
PCI LSIs will be calculated as something like PCI_IRQ_BASE + <phb
index>*4 + <irq pin>.  The VIO devices we handle as VIO_BASE + <reg
value> or something.

MSIs will still need some sort of allocation, but we can do that
within a range set aside for them.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--XlS4q8O07AKt4+K1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrijmMACgkQbDjKyiDZ
s5L+7xAAq9kTnMaqTUpa25dRdZAaCJz54UGvHFS15+Q3DyeDl/6JWSmVY7tMSPce
tOKCzpfdJ14K3BMW6lDrhRfOdpm1HEGVwJUM6h2gQsvOLWbos6iQrZyhCQXffbu9
V+9WtaRLFb0Y5w/lsL3oYnUv7UJ5Gnrlg/3wp5FmKxnSVCIbJqgKdE711ahIf0Hs
lQlOo5OZk62IFA9z9xbAVlSr/Md2ip/2TnQhyJYN3GN6EoWJAgw2R2z/l/eho3wK
KjEHZbo6ZFwixg5l2SbNhBnAxHC/p2Jxr0nCH9hM2dl/T1p9h17ziOinkwmB9xGu
ntvVFf2QvLxk9eZed5LSl6hEUuhXdNfaBlFBMj+O8UySmUdGOko/53h7yotehzg/
uBSEJcz4SdqL1/44o7Q6bfynatQYTTEnAXKxvlMQ3pD1COCmFcFgEqNZaKF9NwQp
UwfigxBtwYr1/xJhzb59cO/r9Yqn8vn1FL8uXufKAFZBpy+ZSXp3btkDZHSUJNS9
WKc/lDty7nbcjYKHhcCBgxAEVX2X6BZrDHycz0iPDWbgiO6bCbIl/2J8T8fVarFf
aHxL5OjEJZIEEobbYiNiwXByBESYcyYZGxev9bxKaOm+23flRLCMGnsCYtCHy9pl
Rps6ioLla+H0S3baA904OW/r8yVFPLK2dlfzdaYq/aUqNGe608w=
=JJCg
-----END PGP SIGNATURE-----

--XlS4q8O07AKt4+K1--
