Received: from eggs.gnu.org ([208.118.235.92]:53823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1geugK-0003Xj-Tx
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 23:32:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1geugG-0005bZ-L0
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 23:32:32 -0500
Date: Thu, 3 Jan 2019 14:58:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190103035851.GS10853@umbus.fritz.box>
References: <20190102055743.5052-1-clg@kaod.org>
	<20190102055743.5052-5-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="p2u4WfPhYOuYlOsk"
Content-Disposition: inline
In-Reply-To: <20190102055743.5052-5-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 04/10] spapr/xive: simplify the sPAPR IRQ
 qirq method for XIVE
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


--p2u4WfPhYOuYlOsk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 02, 2019 at 06:57:37AM +0100, C=E9dric Le Goater wrote:
> The qirq routines of the XiveSource and the sPAPRXive model are only
> used under the sPAPR IRQ backend. Simplify the overall call stack and
> gather all the code under spapr_qirq_xive(). It will ease future
> changes.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Seems a good clean up in its own right, so I've applied.

> ---
>  include/hw/ppc/spapr_xive.h |  1 -
>  include/hw/ppc/xive.h       |  6 ------
>  hw/intc/spapr_xive.c        | 14 --------------
>  hw/ppc/spapr_irq.c          | 12 +++++++++++-
>  4 files changed, 11 insertions(+), 22 deletions(-)
>=20
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index 728735dbcfbe..9ee524fdb218 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -40,7 +40,6 @@ typedef struct sPAPRXive {
>  bool spapr_xive_irq_claim(sPAPRXive *xive, uint32_t lisn, bool lsi);
>  bool spapr_xive_irq_free(sPAPRXive *xive, uint32_t lisn);
>  void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon);
> -qemu_irq spapr_xive_qirq(sPAPRXive *xive, uint32_t lisn);
> =20
>  typedef struct sPAPRMachineState sPAPRMachineState;
> =20
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 18cd114eb244..b05fe88b5b82 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -278,12 +278,6 @@ uint8_t xive_source_esb_set(XiveSource *xsrc, uint32=
_t srcno, uint8_t pq);
>  void xive_source_pic_print_info(XiveSource *xsrc, uint32_t offset,
>                                  Monitor *mon);
> =20
> -static inline qemu_irq xive_source_qirq(XiveSource *xsrc, uint32_t srcno)
> -{
> -    assert(srcno < xsrc->nr_irqs);
> -    return xsrc->qirqs[srcno];
> -}
> -
>  static inline bool xive_source_irq_is_lsi(XiveSource *xsrc, uint32_t src=
no)
>  {
>      assert(srcno < xsrc->nr_irqs);
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 0e39c90cbd07..eea28337e807 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -488,20 +488,6 @@ bool spapr_xive_irq_free(sPAPRXive *xive, uint32_t l=
isn)
>      return true;
>  }
> =20
> -qemu_irq spapr_xive_qirq(sPAPRXive *xive, uint32_t lisn)
> -{
> -    XiveSource *xsrc =3D &xive->source;
> -
> -    if (lisn >=3D xive->nr_irqs) {
> -        return NULL;
> -    }
> -
> -    /* The sPAPR machine/device should have claimed the IRQ before */
> -    assert(xive_eas_is_valid(&xive->eat[lisn]));
> -
> -    return xive_source_qirq(xsrc, lisn);
> -}
> -
>  /*
>   * XIVE hcalls
>   *
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 50e767120d21..b875065ef86b 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -294,7 +294,17 @@ static void spapr_irq_free_xive(sPAPRMachineState *s=
papr, int irq, int num)
> =20
>  static qemu_irq spapr_qirq_xive(sPAPRMachineState *spapr, int irq)
>  {
> -    return spapr_xive_qirq(spapr->xive, irq);
> +    sPAPRXive *xive =3D spapr->xive;
> +    XiveSource *xsrc =3D &xive->source;
> +
> +    if (irq >=3D xive->nr_irqs) {
> +        return NULL;
> +    }
> +
> +    /* The sPAPR machine/device should have claimed the IRQ before */
> +    assert(xive_eas_is_valid(&xive->eat[irq]));
> +
> +    return xsrc->qirqs[irq];
>  }
> =20
>  static void spapr_irq_print_info_xive(sPAPRMachineState *spapr,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--p2u4WfPhYOuYlOsk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwtiHsACgkQbDjKyiDZ
s5KcIQ/5AchlyhcOAlcQwwZMST9rHjZDquouX7/G2kQ1mQ9FdZXCGB6+YN5p8KEI
7RyNteSA6uIKTEX/Dw9i6dE/YI76//t3DRoTCtPUFg/4vLXu2lomHyrxPKXao7iC
ao+tGENd1+9jIDUvVEixiJ8DtcC6UakhyVPpPjr0hdwNxOVrIs8y7DAWOE4ANeBm
taS/61FsVbfiFPJflvKzU8s6dwJ5Lg998v/1WNhebeFHau4UyZS3lA5pILn61TkQ
TNXfcIJP73KHs60TtP2eeZjeef0PxJEWJo7CYVsCHgkQQbgM8IZ4Jqx9CljikFCJ
TrEVykDAGcJpzQb6CNIVnAnfZVmaJ4/XPA5gfGLzkBLUJj2ij8c3a4SVdhNXGKyH
nb77QXQazfgCG75Cpw6Dpoi8aEqAQkj9DTBcI6KrSaT4p2K59rpXGzAhASRn4UKl
isrbU09LMHzsXS7q7+T0xd959g8pQY/U0KrbB+KBfj/Fg21a9WNwMJDZOX/QErox
oF+VD0xFfGaoVu2dii2DmSy69G3LueAKGMxRTh3PQmeG0mTEJfxw9UzgTIVmEK+1
XwTwQLidV3PYsF+fkD/Q9iPJiAwP/jbsy3qSrL6NOZq4YAob9zUKSFY0QA8RKvfP
exIHwsGPr/6H9lcNz8lmwRhcuxdhH8A1NjVVDO2Bgo3yOXt6roI=
=PFQH
-----END PGP SIGNATURE-----

--p2u4WfPhYOuYlOsk--
