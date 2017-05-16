Received: from eggs.gnu.org ([2001:4830:134:3::10]:46601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAUCA-00050j-7W
	for qemu-devel@nongnu.org; Tue, 16 May 2017 00:34:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAUC6-0002qm-SR
	for qemu-devel@nongnu.org; Tue, 16 May 2017 00:34:50 -0400
Date: Tue, 16 May 2017 14:30:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170516043003.GD30022@umbus.fritz.box>
References: <149484833874.20089.4164801378197848306.stgit@bahia.lan>
	<149484835694.20089.2114938170632779266.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tNQTSEo8WG/FKZ8E"
Content-Disposition: inline
In-Reply-To: <149484835694.20089.2114938170632779266.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 1/6] ppc/xics: simplify prototype of
 xics_spapr_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Cedric Le Goater <clg@kaod.org>


--tNQTSEo8WG/FKZ8E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2017 at 01:39:16PM +0200, Greg Kurz wrote:
> This function only does hypercall and RTAS-call registration, and thus
> never returns an error. This patch adapt the prototype to reflect that.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-2.10, thanks.

> ---
>  hw/intc/xics_spapr.c  |    3 +--
>  hw/ppc/spapr.c        |    2 +-
>  include/hw/ppc/xics.h |    2 +-
>  3 files changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> index f05308b897f2..d98ea8b13068 100644
> --- a/hw/intc/xics_spapr.c
> +++ b/hw/intc/xics_spapr.c
> @@ -229,7 +229,7 @@ static void rtas_int_on(PowerPCCPU *cpu, sPAPRMachine=
State *spapr,
>      rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>  }
> =20
> -int xics_spapr_init(sPAPRMachineState *spapr, Error **errp)
> +void xics_spapr_init(sPAPRMachineState *spapr)
>  {
>      /* Registration of global state belongs into realize */
>      spapr_rtas_register(RTAS_IBM_SET_XIVE, "ibm,set-xive", rtas_set_xive=
);
> @@ -243,7 +243,6 @@ int xics_spapr_init(sPAPRMachineState *spapr, Error *=
*errp)
>      spapr_register_hypercall(H_XIRR_X, h_xirr_x);
>      spapr_register_hypercall(H_EOI, h_eoi);
>      spapr_register_hypercall(H_IPOLL, h_ipoll);
> -    return 0;
>  }
> =20
>  #define ICS_IRQ_FREE(ics, srcno)   \
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 1b7cadab0cdf..abfb99b71b7d 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -139,7 +139,7 @@ static void xics_system_init(MachineState *machine, i=
nt nr_irqs, Error **errp)
>      }
> =20
>      if (!spapr->ics) {
> -        xics_spapr_init(spapr, errp);
> +        xics_spapr_init(spapr);
>          spapr->icp_type =3D TYPE_ICP;
>          spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_SIMPLE, nr_irqs,=
 errp);
>      }
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 05e6acbb3533..d6cb51f3ad5d 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -206,6 +206,6 @@ void icp_resend(ICPState *ss);
>  typedef struct sPAPRMachineState sPAPRMachineState;
> =20
>  int xics_kvm_init(sPAPRMachineState *spapr, Error **errp);
> -int xics_spapr_init(sPAPRMachineState *spapr, Error **errp);
> +void xics_spapr_init(sPAPRMachineState *spapr);
> =20
>  #endif /* XICS_H */
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tNQTSEo8WG/FKZ8E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZGoBLAAoJEGw4ysog2bOS/nkQALYi6AE3VbPcByZ3P8ZQHgzV
XBUv/jK4q8ljMnBY1vGV8/GjLTIOJvCE70SiUjYNuMgnCaUrKr/z80K3W2xyLRDo
sAUms4Yb+b84cIIYK8D8GKuZ+LS9ZQq4iPSStYmmrBLiW5biWHPPR1W0d83Wdb2F
xWE92xF0iPwX63essAgy2XQoZ5KtPNI+GUgAfZdSGcxdQzgiFer0gL2AR7zKqp3S
IF48cgkZfUlj5o18CquKb+bj3+8PVIN2JybEnsuEbLCZtz0+pPy/H5+JWulnC4np
dwL4+PRSG34ydLomMIrEOSWMkoUSizq88nLO8H2cGm/MZIG1eW0AgknX9yG5HT2S
LldV3qPzHgJWsXXs25R6aV6X9xPt7JNyUy6/q8IRx9t/6zclddnKt+wS5HmtSi4X
Er4ONwIWUWdAfP77eM5GZa6UkKDNqfymlaVY5wGQlezkWYZFTAWtOiWqV7qXTzmp
yrRQc0OLpofNsHONPzYdqs58/wfddjqmp/9CP5vXl5ktZT0Ya9/yXTbHpsbZ/P9g
AP6gXTDC2QB6fVVoi5RzgxZV0zqdRyDi/WqWQq254bPiVwxqsyZFWABoQavhJp0Y
BI+WCJYYjX4FM9MtGzg9398aBLxTEILf0JCFm7wS8VSKn9a7QhG7HTAW/fj4T7B0
jL2r0Ed2DE8wQMih35J/
=KsRO
-----END PGP SIGNATURE-----

--tNQTSEo8WG/FKZ8E--
