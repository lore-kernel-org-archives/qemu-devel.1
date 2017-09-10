Received: from eggs.gnu.org ([2001:4830:134:3::10]:49471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqsmp-0006TB-KB
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 23:19:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqsmo-0004Hn-ER
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 23:19:55 -0400
Date: Sun, 10 Sep 2017 13:19:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170910031942.GZ2735@umbus.fritz.box>
References: <20170908143344.12960-1-clg@kaod.org>
	<20170908143344.12960-4-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nktOf83SvqltY3iw"
Content-Disposition: inline
In-Reply-To: <20170908143344.12960-4-clg@kaod.org>
Subject: Re: [Qemu-devel] [RFC PATCH 3/3] spapr: generate a CAS reset for
 the XIVE exploitation mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>


--nktOf83SvqltY3iw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 08, 2017 at 04:33:44PM +0200, C=E9dric Le Goater wrote:
> When the platform and the guest agree on using the XIVE exploitation
> mode for interrupts, the "interrupt-controller" node needs to reflect
> the change and the device tree needs an update.
>=20
> Reseting the guest after the CAS negotiation makes this change
> possible, as the device tree is built at reset time. We use the
> 'ov5_cas' field to check which interrupt model was negotiated before
> reset and populate the tree accordingly.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Looks reasonable, though I'm not going to apply it until we actually
have something to go..

> ---
>  hw/ppc/spapr.c       | 6 +++++-
>  hw/ppc/spapr_hcall.c | 6 ++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 3e3ff1fbc988..be467ab61ad0 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1073,7 +1073,11 @@ static void *spapr_build_fdt(sPAPRMachineState *sp=
apr,
>      _FDT(fdt_setprop_cell(fdt, 0, "#size-cells", 2));
> =20
>      /* /interrupt controller */
> -    spapr_dt_xics(xics_max_server_number(), fdt, PHANDLE_XICP);
> +    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
> +        spapr_dt_xics(xics_max_server_number(), fdt, PHANDLE_XICP);
> +    } else {
> +        /* populate device tree for XIVE */ ;

=2E. here.

> +    }
> =20
>      ret =3D spapr_populate_memory(spapr, fdt);
>      if (ret < 0) {
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 92f1e21358b8..ba00b8d3fdd6 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1613,6 +1613,12 @@ static target_ulong h_client_architecture_support(=
PowerPCCPU *cpu,
>              (spapr_h_cas_compose_response(spapr, args[1], args[2],
>                                            ov5_updates) !=3D 0);
>      }
> +
> +    /* We need to rebuild the device tree for XIVE, generate a reset */
> +    if (!spapr->cas_reboot) {
> +        spapr->cas_reboot =3D spapr_ovec_test(ov5_updates, OV5_XIVE_EXPL=
OIT);
> +    }

At some point we may well want to make XIVE exploitation the default
for POWER9 guests, but that's a detail easily adjusted later.

>      spapr_ovec_cleanup(ov5_updates);
> =20
>      if (spapr->cas_reboot) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nktOf83SvqltY3iw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm0r04ACgkQbDjKyiDZ
s5KcSg/+Iv9O5NFxTyDFGRjmlwbDdy61HBqYZ8CXhHA1bDnxQL/LAMPvtWP5rUos
Us3YuEnNi+F8keDw3WjOL395u5x3f4pVc0MpW7zoMAwPpLtoa4Lrl38aUnq7/xDQ
nTpnuEy7EECfqBgqlL8ZNP7ajMN2ZapPtb4z9NqwXSfnySwyT5/ziEX+eoTJu+Cs
CVe7lNf4b0O4olGgrIuZeLpaNcnnY38tKqzw4WvQ0y9T+PMGFHDzZAuluu1uu+NA
EoDgLe5r2cLOdGiKZzpqDnVAvCjFAo43b0mI9dyAxrzc5JBuBF2OvpCZJrLJwft6
54WEDm+XQS5fHuA10RPY8VGMmWRYmpnvbP1vKFpzOvurADKGwWz1rrzLYE9IfBH/
U71WNWLF5n7Y9TTWd0aywu7A0Q9kv0Xa2LbWZAa5I/1xcEfzyTz8jIivSscjB1xH
RfNpafTtsITxBS/JkDohf6pE2qxrpGB2UNgxqP7+wX0TuUFsI4zx+ZWxFa0drWeC
oDkHTtKivSDbzrct+eABiLWNO09Cmivjn0aLYt/dixLglbfUBH0m8/tBX+nT0OGx
Ymp18ysoLkFubTE0UoJERHHJ6pnb0GcQOKp1MvdLltn5uoQbpiAJ/fTEx1Q9N2ad
REveD3pf87dUJ34XoJyUm3sbRFyZKFA3zhPf8ho0ysLURT+iPxk=
=B6uG
-----END PGP SIGNATURE-----

--nktOf83SvqltY3iw--
