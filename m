Received: from eggs.gnu.org ([209.51.188.92]:42368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1grzT3-0003Bd-Fj
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 01:16:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1grzT1-0004zn-MA
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 01:16:53 -0500
Date: Fri, 8 Feb 2019 16:36:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190208053554.GC12810@umbus.fritz.box>
References: <20190107183946.7230-1-clg@kaod.org>
	<20190107183946.7230-7-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZwgA9U+XZDXt4+m+"
Content-Disposition: inline
In-Reply-To: <20190107183946.7230-7-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 06/13] spapr/xive: fix migration of the
 XiveTCTX under TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--ZwgA9U+XZDXt4+m+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 07, 2019 at 07:39:39PM +0100, C=E9dric Le Goater wrote:
> When the thread interrupt management state is retrieved from the KVM
> VCPU, word2 is saved under the QEMU XIVE thread context to print out
> the OS CAM line under the QEMU monitor.
>=20
> This breaks the migration of a TCG guest (and with KVM when
> kernel_irqchip=3Doff) because the matching algorithm of the presenter
> relies on the OS CAM value. Fix with an extra reset of the thread
> contexts to restore the expected value.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Why is the CAM value you get from KVM different from the one you
expect in qemu?

> ---
>  hw/ppc/spapr_irq.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 233c97c5ecd9..ba27d9d8e972 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -363,7 +363,31 @@ static void spapr_irq_cpu_intc_create_xive(sPAPRMach=
ineState *spapr,
> =20
>  static int spapr_irq_post_load_xive(sPAPRMachineState *spapr, int versio=
n_id)
>  {
> -    return spapr_xive_post_load(spapr->xive, version_id);
> +    CPUState *cs;
> +    int ret;
> +
> +    ret =3D spapr_xive_post_load(spapr->xive, version_id);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    /*
> +     * When the states are collected from the KVM XIVE device, word2
> +     * of the XiveTCTX is set to print out the OS CAM line under the
> +     * QEMU monitor.
> +     *
> +     * This breaks the migration on a TCG guest (or on KVM with
> +     * kernel_irqchip=3Doff) because the matching algorithm of the
> +     * presenter relies on the OS CAM value. Fix with an extra reset
> +     * of the thread contexts to restore the expected value.
> +     */
> +    CPU_FOREACH(cs) {
> +        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +
> +        /* (TCG) Set the OS CAM line of the thread interrupt context. */
> +        spapr_xive_set_tctx_os_cam(cpu->tctx);
> +    }
> +    return 0;
>  }
> =20
>  static void spapr_irq_reset_xive(sPAPRMachineState *spapr, Error **errp)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZwgA9U+XZDXt4+m+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxdFToACgkQbDjKyiDZ
s5JydA//Xs2WXgBx0EZeDReuln+HcyKyuN/bwG8h3MZ3cBCW6jRE+bu8mReNoEiJ
v52lZAcoXNZzUrRf9p7aCqEiO3eUkH/mUuvfAnLfmIIMx0yukyAm/ZS+CZvvl1SQ
ZtS/ChG/0Bae72DLGA7zlAkuLH3gewjCS6HrrOK/4Lsg4zejo3UfADuujbmAytxv
wo+z3tDUyNItLFCA91Ny/yCkRrU4TxObXxvQuHzJhHH6WaaMhkEwZ9U91q9pMIP7
ERjRPGb+eJSA0emWQ/5oKYg0NJ/mk1Jxy3RI8xoqr7+0Ijvdo/SND//+Zbhuxtvg
dChnZe3ts9Wk2YGAJRjAeEQQCgJUuInrQ90Iv3e3gr5AZKBhiYzAbGEmubLdBE8X
VbS2OhOjzGb5hunhe3g1cZdWpQ2M6iqhObk3cH4GnNekqfoysoBD3lmZ8G54e2Ag
n8GeeXg9Dq2fXwnVnYfbA5v41yOsApVVUFfn+J/m8s4JGNP8K8q0D+EbPQDlJqgY
j+2jkPZT3iGoyhi3HpL0DQIM4mNQu4gRNi9HTdKOhiuGwpQWUpW7vyfN/T+fC7nT
UUO7rccGXsf/Kh+agVPNcOU/P81J/oZysD8wHAqObeErsakAn+OH+EtAajTbE0vh
j2VqBd+R9ugCKqPa4b5E4rDT/Gcg8y/ophzwgn5zwWTohXlHTGg=
=ybzv
-----END PGP SIGNATURE-----

--ZwgA9U+XZDXt4+m+--
