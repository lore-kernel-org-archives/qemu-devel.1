Received: from eggs.gnu.org ([209.51.188.92]:56696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtR2L-00034t-6K
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 00:55:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtQo2-0006eW-JY
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 00:40:32 -0500
Date: Tue, 12 Feb 2019 15:34:37 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190212043437.GK1884@umbus.fritz.box>
References: <20190128094625.4428-1-clg@kaod.org>
	<20190128094625.4428-4-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cEobB2knsyc5ebfU"
Content-Disposition: inline
In-Reply-To: <20190128094625.4428-4-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 03/19] xive: extend the XiveRouter
 get_tctx() method with the page offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--cEobB2knsyc5ebfU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 28, 2019 at 10:46:09AM +0100, C=E9dric Le Goater wrote:
> The PowerNV machine can perform indirect loads and stores on the TIMA
> on behalf of another CPU. The PIR of the CPU is controlled by a set of
> 4 registers, one per TIMA page. To know which page is being accessed,
> we need to inform the controller model of the operation offset.

This doesn't seem like the right place to handle this.  Shouldn't you
instead be passing a different CPUState in for "foreign" TCTX
accesses?

>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/ppc/xive.h |  4 ++--
>  hw/intc/spapr_xive.c  |  3 ++-
>  hw/intc/xive.c        | 12 +++++++-----
>  3 files changed, 11 insertions(+), 8 deletions(-)
>=20
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 04d54e8315f7..a1f5ea2d9143 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -352,7 +352,7 @@ typedef struct XiveRouterClass {
>                     XiveNVT *nvt);
>      int (*write_nvt)(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t nvt_idx,
>                       XiveNVT *nvt, uint8_t word_number);
> -    XiveTCTX *(*get_tctx)(XiveRouter *xrtr, CPUState *cs);
> +    XiveTCTX *(*get_tctx)(XiveRouter *xrtr, CPUState *cs, hwaddr offset);
>  } XiveRouterClass;
> =20
>  void xive_eas_pic_print_info(XiveEAS *eas, uint32_t lisn, Monitor *mon);
> @@ -367,7 +367,7 @@ int xive_router_get_nvt(XiveRouter *xrtr, uint8_t nvt=
_blk, uint32_t nvt_idx,
>                          XiveNVT *nvt);
>  int xive_router_write_nvt(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t nv=
t_idx,
>                            XiveNVT *nvt, uint8_t word_number);
> -XiveTCTX *xive_router_get_tctx(XiveRouter *xrtr, CPUState *cs);
> +XiveTCTX *xive_router_get_tctx(XiveRouter *xrtr, CPUState *cs, hwaddr of=
fset);
> =20
>  /*
>   * XIVE END ESBs
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index a0f5ff929447..c41ee96c4c84 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -391,7 +391,8 @@ static int spapr_xive_write_nvt(XiveRouter *xrtr, uin=
t8_t nvt_blk,
>      g_assert_not_reached();
>  }
> =20
> -static XiveTCTX *spapr_xive_get_tctx(XiveRouter *xrtr, CPUState *cs)
> +static XiveTCTX *spapr_xive_get_tctx(XiveRouter *xrtr, CPUState *cs,
> +                                     hwaddr offset)
>  {
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> =20
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index f5642f2338de..39dff557fadc 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -320,7 +320,8 @@ static const XiveTmOp *xive_tm_find_op(hwaddr offset,=
 unsigned size, bool write)
>  static void xive_tm_write(void *opaque, hwaddr offset,
>                            uint64_t value, unsigned size)
>  {
> -    XiveTCTX *tctx =3D xive_router_get_tctx(XIVE_ROUTER(opaque), current=
_cpu);
> +    XiveTCTX *tctx =3D xive_router_get_tctx(XIVE_ROUTER(opaque), current=
_cpu,
> +                                          offset);
>      const XiveTmOp *xto;
> =20
>      /*
> @@ -358,7 +359,8 @@ static void xive_tm_write(void *opaque, hwaddr offset,
> =20
>  static uint64_t xive_tm_read(void *opaque, hwaddr offset, unsigned size)
>  {
> -    XiveTCTX *tctx =3D xive_router_get_tctx(XIVE_ROUTER(opaque), current=
_cpu);
> +    XiveTCTX *tctx =3D xive_router_get_tctx(XIVE_ROUTER(opaque), current=
_cpu,
> +                                          offset);
>      const XiveTmOp *xto;
> =20
>      /*
> @@ -1134,11 +1136,11 @@ int xive_router_write_nvt(XiveRouter *xrtr, uint8=
_t nvt_blk, uint32_t nvt_idx,
>     return xrc->write_nvt(xrtr, nvt_blk, nvt_idx, nvt, word_number);
>  }
> =20
> -XiveTCTX *xive_router_get_tctx(XiveRouter *xrtr, CPUState *cs)
> +XiveTCTX *xive_router_get_tctx(XiveRouter *xrtr, CPUState *cs, hwaddr of=
fset)
>  {
>      XiveRouterClass *xrc =3D XIVE_ROUTER_GET_CLASS(xrtr);
> =20
> -    return xrc->get_tctx(xrtr, cs);
> +    return xrc->get_tctx(xrtr, cs, offset);
>  }
> =20
>  /*
> @@ -1234,7 +1236,7 @@ static bool xive_presenter_match(XiveRouter *xrtr, =
uint8_t format,
>       */
> =20
>      CPU_FOREACH(cs) {
> -        XiveTCTX *tctx =3D xive_router_get_tctx(xrtr, cs);
> +        XiveTCTX *tctx =3D xive_router_get_tctx(xrtr, cs, 0);
>          int ring;
> =20
>          /*

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cEobB2knsyc5ebfU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxiTNoACgkQbDjKyiDZ
s5LD3BAAoEYp8H7oDKflYD3zWKEAa8jg/EpHS11CbufaDFowhFVwUtu1F0csK+aN
H53c1dy8W4ja2DqP7BB/nR2RS4n6hvWGqKliPO/EzgWCYVzV5dKa3r0iBVG8kw2S
g0DVHFgucxK/Xzh5+lLcHKpfE1o83wJX/wEKaBNIEHoahmpbC4TN88nBR3B6xtIm
1dQaftp8Cj+uBRJdrETo1kNMtYXahokjuq3Ln35P7BfpQH86BrXusS8fva5jwTih
IW7GiLhN2nhBzLy8XEm6tuQ4pDKqOFw0vMev9VELM+6vgS+uAbopNBBXGVQH3Dav
460PxcBWjaBbUnRedGUheZZCW1vaJdCRGsc2jUPHw/vZl1ihgeK2VbdjFf9H6MXU
BiKosvCkn+eIXJzgmLHe5i8HUpojcoDzf2mziz9ILYIj3JrsG5bn9jdD3hgF1KW/
HG/pEX1vE7E13Y3ux7RqD6WHETBnIFmZ+mOoGt+Ez5M3HoRCeSX/zyprLtrsvFRe
KbUK8bfHNdlUU4oz33M8ksYr1uQ9C5sOoozcfboEifwdlDf4y8e3bqLxtqrpT5pn
rlOrdvQUYMlhQK9iGElhgTizCxcySJk5FGXGW28zN1Hh1cprKt82RK7BjyPEbbNg
c/UEArKHD8V2ZHK7iwDLlm1UUGmT/djmpjZzhltuZ/x8048yFZQ=
=tRoW
-----END PGP SIGNATURE-----

--cEobB2knsyc5ebfU--
