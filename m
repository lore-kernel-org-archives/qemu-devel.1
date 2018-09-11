Received: from eggs.gnu.org ([2001:4830:134:3::10]:44025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fzY16-0001kN-Ml
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 22:03:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fzXrP-0007dM-3I
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 21:53:02 -0400
Date: Tue, 11 Sep 2018 11:48:21 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180911014821.GE7978@umbus.fritz.box>
References: <20180910110222.8162-1-clg@kaod.org>
	<20180910110222.8162-2-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gDGSpKKIBgtShtf+"
Content-Disposition: inline
In-Reply-To: <20180910110222.8162-2-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 1/3] spapr: introduce a spapr_irq class
 'nr_msis' attribute
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>


--gDGSpKKIBgtShtf+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 10, 2018 at 01:02:20PM +0200, C=E9dric Le Goater wrote:
11;rgb:ffff/ffff/ffff> The number of MSI interrupts a sPAPR machine can all=
ocate is in direct
> relation with the number of interrupts of the sPAPRIrq backend. Define
> statically this value at the sPAPRIrq class level.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/ppc/spapr_irq.h | 1 +
>  hw/ppc/spapr_irq.c         | 9 +++++++--
>  2 files changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index 0e98c4474bb2..650f810ad2aa 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -31,6 +31,7 @@ void spapr_irq_msi_reset(sPAPRMachineState *spapr);
> =20
>  typedef struct sPAPRIrq {
>      uint32_t    nr_irqs;
> +    uint32_t    nr_msis;
> =20
>      void (*init)(sPAPRMachineState *spapr, Error **errp);
>      int (*claim)(sPAPRMachineState *spapr, int irq, bool lsi, Error **er=
rp);
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 0cbb5dd39368..d369ac96f5cd 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -99,7 +99,7 @@ static void spapr_irq_init_xics(sPAPRMachineState *spap=
r, Error **errp)
> =20
>      /* Initialize the MSI IRQ allocator. */
>      if (!SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
> -        spapr_irq_msi_init(spapr, XICS_IRQ_BASE + nr_irqs - SPAPR_IRQ_MS=
I);
> +        spapr_irq_msi_init(spapr, smc->irq->nr_msis);
>      }
> =20
>      if (kvm_enabled()) {
> @@ -195,8 +195,13 @@ static void spapr_irq_print_info_xics(sPAPRMachineSt=
ate *spapr, Monitor *mon)
>      ics_pic_print_info(spapr->ics, mon);
>  }
> =20
> +#define SPAPR_IRQ_XICS_NR_IRQS     XICS_IRQS_SPAPR
> +#define SPAPR_IRQ_XICS_NR_MSIS     \
> +    (XICS_IRQ_BASE + SPAPR_IRQ_XICS_NR_IRQS - SPAPR_IRQ_MSI)

Uh.. I'm not quite understanding how XICS_IRQ_BASE gets into this.

>  sPAPRIrq spapr_irq_xics =3D {
> -    .nr_irqs     =3D XICS_IRQS_SPAPR,
> +    .nr_irqs     =3D SPAPR_IRQ_XICS_NR_IRQS,
> +    .nr_msis     =3D SPAPR_IRQ_XICS_NR_MSIS,
> =20
>      .init        =3D spapr_irq_init_xics,
>      .claim       =3D spapr_irq_claim_xics,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gDGSpKKIBgtShtf+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluXHuUACgkQbDjKyiDZ
s5KSYxAAkqcD7ZWyv1RKFA7HmcvbQ3EYbBU2rKlmZ6eq0fwoGVG00yl3Ox6VxCfJ
jpzPdlN8Tm0OllUrPOfPczRarWUg4GKeWOA3MLnkBC1XWmxkWXrhrtPvGIAiDMyv
coIdNqfBxY6bgenUDwaTzdt/wJWsDbShesnL5NpIPXLzetnnGEzlEFBIimCBhnVw
YE+K6OhpbYYjKhHH7GdeFVg2ciel5awVTRSewgZnQjYMMNsJJkRRWukV5tSsxEkc
RH4UoAgQGmEhm4H4tpuJefKrwLuv7WcvclueRcNIYLt0ApKO3cmEbF2yO+rdevEs
fBBH3byrf4QQVkKC9RhR41a4fO5CFm2/RhmLdQolwieAdE4GdURhsV11LSrVb8/t
ZHFncKr5l+U6IK6w4Ub2QDwBrbxOKCsOS96DfFE0eexuoMh1VYb64D5pN/bqUkhe
1fctRmL2hsylO9PVVWgFFZU1PUesxzsDKxUuvU/kVt3QSruZawIQoQ+iOXt+IYDC
EsbalcZMUlWZBoWkv30QOKMtBjTm2IUflyU4+UKX77aBu3gU8HPZpnINqarMrEq+
W/wcezgmDqPbepoqU5Xn7sp7B7VZzEvCisSxHUqvC1SDyMLBY5xLHVCDJmrjtJYQ
JT3dciEjPm9a8R4Y33JRl9C8OkvDIPJjIAG5YEG+Jnz0rXtu1dM=
=GPBY
-----END PGP SIGNATURE-----

--gDGSpKKIBgtShtf+--
