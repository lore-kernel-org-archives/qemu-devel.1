Received: from eggs.gnu.org ([209.51.188.92]:46550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gnZIr-0005aI-UG
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 20:32:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gnZIq-00021S-2N
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 20:32:05 -0500
Date: Sat, 26 Jan 2019 15:29:12 +1300
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190126022912.GE22942@umbus>
References: <20190117075327.22194-1-clg@kaod.org>
	<20190117075327.22194-2-clg@kaod.org>
	<20190117091236.4d155637@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SWTRyWv/ijrBap1m"
Content-Disposition: inline
In-Reply-To: <20190117091236.4d155637@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 1/4] xive: add a get_tctx() method to the
 XiveRouter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--SWTRyWv/ijrBap1m
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 17, 2019 at 09:12:36AM +0100, Greg Kurz wrote:
65;5403;1c> On Thu, 17 Jan 2019 08:53:24 +0100
> C=E9dric Le Goater <clg@kaod.org> wrote:
>=20
> > It provides a mean to retrieve the XiveTCTX of a CPU. This will become
> > necessary with future changes which move the interrupt presenter
> > object pointers under the PowerPCCPU machine_data.
> >=20
> > The PowerNV machine has an extra requirement on TIMA accesses that
> > this new method addresses. The machine can perform indirect loads and
> > stores on the TIMA on behalf of another CPU. The PIR being defined in
> > the controller registers, we need a way to peek in the controller
> > model to find the PIR value.
> >=20
> > The XiveTCTX is moved above the XiveRouter definition to avoid forward
> > typedef declarations.
> >=20
> > Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> > ---
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>

Applied, thanks.

>=20
> >  include/hw/ppc/xive.h | 57 ++++++++++++++++++++++---------------------
> >  hw/intc/spapr_xive.c  |  8 ++++++
> >  hw/intc/xive.c        | 16 +++++++-----
> >  3 files changed, 47 insertions(+), 34 deletions(-)
> >=20
> > diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> > index 5d31c801ee53..ec3bb2aae45a 100644
> > --- a/include/hw/ppc/xive.h
> > +++ b/include/hw/ppc/xive.h
> > @@ -294,6 +294,33 @@ static inline void xive_source_irq_set(XiveSource =
*xsrc, uint32_t srcno,
> > =20
> >  void xive_source_set_irq(void *opaque, int srcno, int val);
> > =20
> > +/*
> > + * XIVE Thread interrupt Management (TM) context
> > + */
> > +
> > +#define TYPE_XIVE_TCTX "xive-tctx"
> > +#define XIVE_TCTX(obj) OBJECT_CHECK(XiveTCTX, (obj), TYPE_XIVE_TCTX)
> > +
> > +/*
> > + * XIVE Thread interrupt Management register rings :
> > + *
> > + *   QW-0  User       event-based exception state
> > + *   QW-1  O/S        OS context for priority management, interrupt ac=
ks
> > + *   QW-2  Pool       hypervisor pool context for virtual processors d=
ispatched
> > + *   QW-3  Physical   physical thread context and security context
> > + */
> > +#define XIVE_TM_RING_COUNT      4
> > +#define XIVE_TM_RING_SIZE       0x10
> > +
> > +typedef struct XiveTCTX {
> > +    DeviceState parent_obj;
> > +
> > +    CPUState    *cs;
> > +    qemu_irq    output;
> > +
> > +    uint8_t     regs[XIVE_TM_RING_COUNT * XIVE_TM_RING_SIZE];
> > +} XiveTCTX;
> > +
> >  /*
> >   * XIVE Router
> >   */
> > @@ -324,6 +351,7 @@ typedef struct XiveRouterClass {
> >                     XiveNVT *nvt);
> >      int (*write_nvt)(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t nvt_i=
dx,
> >                       XiveNVT *nvt, uint8_t word_number);
> > +    XiveTCTX *(*get_tctx)(XiveRouter *xrtr, CPUState *cs);
> >  } XiveRouterClass;
> > =20
> >  void xive_eas_pic_print_info(XiveEAS *eas, uint32_t lisn, Monitor *mon=
);
> > @@ -338,7 +366,7 @@ int xive_router_get_nvt(XiveRouter *xrtr, uint8_t n=
vt_blk, uint32_t nvt_idx,
> >                          XiveNVT *nvt);
> >  int xive_router_write_nvt(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t =
nvt_idx,
> >                            XiveNVT *nvt, uint8_t word_number);
> > -
> > +XiveTCTX *xive_router_get_tctx(XiveRouter *xrtr, CPUState *cs);
> > =20
> >  /*
> >   * XIVE END ESBs
> > @@ -371,33 +399,6 @@ typedef struct XiveENDSource {
> >  void xive_end_pic_print_info(XiveEND *end, uint32_t end_idx, Monitor *=
mon);
> >  void xive_end_queue_pic_print_info(XiveEND *end, uint32_t width, Monit=
or *mon);
> > =20
> > -/*
> > - * XIVE Thread interrupt Management (TM) context
> > - */
> > -
> > -#define TYPE_XIVE_TCTX "xive-tctx"
> > -#define XIVE_TCTX(obj) OBJECT_CHECK(XiveTCTX, (obj), TYPE_XIVE_TCTX)
> > -
> > -/*
> > - * XIVE Thread interrupt Management register rings :
> > - *
> > - *   QW-0  User       event-based exception state
> > - *   QW-1  O/S        OS context for priority management, interrupt ac=
ks
> > - *   QW-2  Pool       hypervisor pool context for virtual processors d=
ispatched
> > - *   QW-3  Physical   physical thread context and security context
> > - */
> > -#define XIVE_TM_RING_COUNT      4
> > -#define XIVE_TM_RING_SIZE       0x10
> > -
> > -typedef struct XiveTCTX {
> > -    DeviceState parent_obj;
> > -
> > -    CPUState    *cs;
> > -    qemu_irq    output;
> > -
> > -    uint8_t     regs[XIVE_TM_RING_COUNT * XIVE_TM_RING_SIZE];
> > -} XiveTCTX;
> > -
> >  /*
> >   * XIVE Thread Interrupt Management Aera (TIMA)
> >   *
> > diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> > index d391177ab81f..136d872f16bc 100644
> > --- a/hw/intc/spapr_xive.c
> > +++ b/hw/intc/spapr_xive.c
> > @@ -390,6 +390,13 @@ static int spapr_xive_write_nvt(XiveRouter *xrtr, =
uint8_t nvt_blk,
> >      g_assert_not_reached();
> >  }
> > =20
> > +static XiveTCTX *spapr_xive_get_tctx(XiveRouter *xrtr, CPUState *cs)
> > +{
> > +    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> > +
> > +    return cpu->tctx;
> > +}
> > +
> >  static const VMStateDescription vmstate_spapr_xive_end =3D {
> >      .name =3D TYPE_SPAPR_XIVE "/end",
> >      .version_id =3D 1,
> > @@ -454,6 +461,7 @@ static void spapr_xive_class_init(ObjectClass *klas=
s, void *data)
> >      xrc->write_end =3D spapr_xive_write_end;
> >      xrc->get_nvt =3D spapr_xive_get_nvt;
> >      xrc->write_nvt =3D spapr_xive_write_nvt;
> > +    xrc->get_tctx =3D spapr_xive_get_tctx;
> >  }
> > =20
> >  static const TypeInfo spapr_xive_info =3D {
> > diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> > index 7f567a57d25a..2e9b8efd4342 100644
> > --- a/hw/intc/xive.c
> > +++ b/hw/intc/xive.c
> > @@ -320,8 +320,7 @@ static const XiveTmOp *xive_tm_find_op(hwaddr offse=
t, unsigned size, bool write)
> >  static void xive_tm_write(void *opaque, hwaddr offset,
> >                            uint64_t value, unsigned size)
> >  {
> > -    PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
> > -    XiveTCTX *tctx =3D cpu->tctx;
> > +    XiveTCTX *tctx =3D xive_router_get_tctx(XIVE_ROUTER(opaque), curre=
nt_cpu);
> >      const XiveTmOp *xto;
> > =20
> >      /*
> > @@ -359,8 +358,7 @@ static void xive_tm_write(void *opaque, hwaddr offs=
et,
> > =20
> >  static uint64_t xive_tm_read(void *opaque, hwaddr offset, unsigned siz=
e)
> >  {
> > -    PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
> > -    XiveTCTX *tctx =3D cpu->tctx;
> > +    XiveTCTX *tctx =3D xive_router_get_tctx(XIVE_ROUTER(opaque), curre=
nt_cpu);
> >      const XiveTmOp *xto;
> > =20
> >      /*
> > @@ -1107,6 +1105,13 @@ int xive_router_write_nvt(XiveRouter *xrtr, uint=
8_t nvt_blk, uint32_t nvt_idx,
> >     return xrc->write_nvt(xrtr, nvt_blk, nvt_idx, nvt, word_number);
> >  }
> > =20
> > +XiveTCTX *xive_router_get_tctx(XiveRouter *xrtr, CPUState *cs)
> > +{
> > +    XiveRouterClass *xrc =3D XIVE_ROUTER_GET_CLASS(xrtr);
> > +
> > +    return xrc->get_tctx(xrtr, cs);
> > +}
> > +
> >  /*
> >   * The thread context register words are in big-endian format.
> >   */
> > @@ -1182,8 +1187,7 @@ static bool xive_presenter_match(XiveRouter *xrtr=
, uint8_t format,
> >       */
> > =20
> >      CPU_FOREACH(cs) {
> > -        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> > -        XiveTCTX *tctx =3D cpu->tctx;
> > +        XiveTCTX *tctx =3D xive_router_get_tctx(xrtr, cs);
> >          int ring;
> > =20
> >          /*
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SWTRyWv/ijrBap1m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxLxfYACgkQbDjKyiDZ
s5JNrQ/+J4H05HntCASgvrhtVmbrsLFtlubtmSY3IU4MwOWts//L/SfVAIGIUsNK
okgxFEwK0bWK4NE9zo+leWxhyMy97fZtb7/BoIYQ1AAtO0T84OdcAueOoDMp3iQI
4UjePvzKWturzGmZ5zZTxfl44agYiEssNlFm+hBF/lW/sigS1DoM19+JaLWyz2Wo
XQttEEjTy0lIH3/uY1L4TCDNYu6cqteXKXQVT95mWz6CAFdnPjED6jwO8giTIRnY
T9pw9U3NLYLlGZilldl8V9RPfAY/gfo1WJdRKOPtkLmApE/FFQx+tg7D2ArjG6sc
nR3zx2yKLpI/mqRp9VxGVYXAkGQAmEA5yQNTQd4VN//9GEjJuUup9OB1IdMzeIT/
ezbiCcB6c9Yo18CRjImQwmtq3ZZ0jXbroFXm+Z8BEUuouAQA+vGmL0cj6mZMFss9
fh/jM1FQYPo2S5Xt18/pNbrU1SLtlYPFs8Psk/N6pRfTco2xpTFzk4JhQh278Zd1
MBBF4b1By2CxKngVFDcU7n5EQUiyGVbpk07wdsSVa7VLaDdvqaVFEZdY2VtWFwJ7
Lt1GYse+vRKt1K/FDIl5N/AdAdwWBiprRArPARI7lhBtd3u0ABCdJho8QNzWL2Ot
Y6nkiT+YoHFsnBkU50Vq7mW7WaR0N3vAxEiNrxQ7Lc5t2FPvOFM=
=zv/y
-----END PGP SIGNATURE-----

--SWTRyWv/ijrBap1m--
