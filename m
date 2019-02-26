Received: from eggs.gnu.org ([209.51.188.92]:41555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyTFc-00075L-44
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 22:17:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyTFb-0006rf-50
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 22:17:48 -0500
Date: Tue, 26 Feb 2019 12:02:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190226010246.GG6872@umbus.fritz.box>
References: <20190222131322.26079-1-clg@kaod.org>
	<20190222131322.26079-8-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="reI/iBAAp9kzkmX4"
Content-Disposition: inline
In-Reply-To: <20190222131322.26079-8-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 07/13] spapr/xive: fix migration of the
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
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--reI/iBAAp9kzkmX4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2019 at 02:13:16PM +0100, C=E9dric Le Goater wrote:
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

As noted elsewhere, I'm not sure this is the right approach to fixing
this.  In any case this can be folded into the previous patch.

> ---
>  hw/ppc/spapr_irq.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 12ecca6264f3..3176098b9f7c 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -356,7 +356,31 @@ static void spapr_irq_cpu_intc_create_xive(sPAPRMach=
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
> +        spapr_xive_set_tctx_os_cam(spapr_cpu_state(cpu)->tctx);
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

--reI/iBAAp9kzkmX4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx0kDYACgkQbDjKyiDZ
s5KAuBAAvjKOoIeJCOLrPl9XFLyee7H3+9fwU5dx9KcByNG8J139m5apwkbQ0IFy
2x45Ow6Q5iid47T7lT5TFgA9LjDRBh4pnFKq4nsUKqRU2+2jr5udug4JhIf1TFHQ
1UackXHIPTUZBeO2XDDaFjLWLaK6nu/KZDz+KS+NP8z3vHf7NDX1SegrFbZhYuM8
oLfelNSUyERxf7oNN0PnBO+JOokZE6613yIJkyaJxQglPw/4th8HEkMdG9zvW5r6
R319LaYAt/83tWMuZGKNKbbWREEdXxSy+VNJj/RowizkgkroM3VCPHRCnv/VRjGO
BkQWvOwnt5ASiRCxBG11P6U/QJeAt7gVvEauB0IYNs9slCHRBsIHr7TSPRxwkf8d
gnLCURw8nC+fC5bca/VfTnGRLF0Ivr9SRcjeHWqn9TvDyz8SvbdIAdmc8q5LWw66
WEsHI+I+t6lNOfF4tXxQDbrVtYkNrbsvCCTPemVV5VJeDB6GVGQNm7bq0m/48zNb
S73xRuiZqoRoPHgyiVCFbwVyQjnytoib47wOBtHRF8e3y9lVvjhPzT1j3SwG27zY
LzxcfxW87qVSyLDn8UL9IbGdpOWiajQVr4zflDo2y8QD2KshPNIGTJLGxTKPexN0
yAuDgeDIyd2TCEuP2ggzavtZJ0/c30CYosF7KiE1FgzreHvUkY0=
=ddpL
-----END PGP SIGNATURE-----

--reI/iBAAp9kzkmX4--
