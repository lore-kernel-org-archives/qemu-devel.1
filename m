Received: from eggs.gnu.org ([209.51.188.92]:42989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtNG9-0007XY-4U
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 20:53:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtNG5-0000N3-OD
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 20:53:14 -0500
Date: Tue, 12 Feb 2019 12:06:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190212010643.GG1884@umbus.fritz.box>
References: <20190107183946.7230-1-clg@kaod.org>
	<20190107183946.7230-13-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="m972NQjnE83KvVa/"
Content-Disposition: inline
In-Reply-To: <20190107183946.7230-13-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 12/13] spapr/xics: ignore the lower 4K in
 the IRQ number space
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


--m972NQjnE83KvVa/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 07, 2019 at 07:39:45PM +0100, C=E9dric Le Goater wrote:
> The IRQ number space of the XIVE and XICS interrupt mode are aligned
> when using the dual interrupt mode for the machine. This means that
> the ICS offset is set to zero in QEMU and that the KVM XICS device
> should be informed of this new value. Unfortunately, there is now way
> to do so and KVM still maintains the XICS_IRQ_BASE (0x1000) offset.
>=20
> Ignore the lower 4K which are not used under the XICS interrupt
> mode. These IRQ numbers are only claimed by XIVE for the CPU IPIs.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/intc/xics_kvm.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index 651bbfdf6966..1d21ff217b82 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -238,6 +238,15 @@ static void ics_get_kvm_state(ICSState *ics)
>      for (i =3D 0; i < ics->nr_irqs; i++) {
>          ICSIRQState *irq =3D &ics->irqs[i];
> =20
> +        /*
> +         * The KVM XICS device considers that the IRQ numbers should
> +         * start at XICS_IRQ_BASE (0x1000). Ignore the lower 4K
> +         * numbers (only claimed by XIVE for the CPU IPIs).
> +         */
> +        if (i + ics->offset < XICS_IRQ_BASE) {
> +            continue;
> +        }
> +

This seems bogus to me.  The guest-visible irq numbers need to line up
between xics and xive mode, yes, but that doesn't mean we need to keep
around a great big array of unused array of ICS irq states, even in
TCG mode.

>          kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOURCES,
>                            i + ics->offset, &state, false, &error_fatal);
> =20
> @@ -303,6 +312,15 @@ static int ics_set_kvm_state(ICSState *ics, int vers=
ion_id)
>          ICSIRQState *irq =3D &ics->irqs[i];
>          int ret;
> =20
> +        /*
> +         * The KVM XICS device considers that the IRQ numbers should
> +         * start at XICS_IRQ_BASE (0x1000). Ignore the lower 4K
> +         * numbers (only claimed by XIVE for the CPU IPIs).
> +         */
> +        if (i + ics->offset < XICS_IRQ_BASE) {
> +            continue;
> +        }
> +
>          state =3D irq->server;
>          state |=3D (uint64_t)(irq->saved_priority & KVM_XICS_PRIORITY_MA=
SK)
>              << KVM_XICS_PRIORITY_SHIFT;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--m972NQjnE83KvVa/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxiHCIACgkQbDjKyiDZ
s5J8sQ//dtOFLsdG/ztUSbGRqIh3Aao3hpOmvr2Vhp7+/y9kQEolv5uFkEokwXoM
d0t0/G6z8k31rVbAOt9HKAkQoiB6j0F6KT2pPPa6rp1Fk6tRzTvclIQcDwRCQI3O
m/5AEq43lnFd0riW+evz+kE8u4rYi3XjCL00X7zCLwFSIJn+H0ZmwhydptSdq/QY
469jy+WaCnufDx/5RukVMS/XocwH3xOWleBUAFHkOBDzNR4sIIjHfPqXBQTxW97+
0k/EkbfOYJ3BgKM6Zr0L0H4P8oqWLLHZqkxgq70wzFH6I7SZXeGhiaC9usukDOLm
d22wP6P/EHb7qipvRB6eXkMWUN6IfXZRODoq1sZS/zAnfLJtwqpkipVm9l1c+iSL
ncna/YF1izS8oFawqgXeah69nVUiEuwLuZN29dzQqA1sgeUFdCecExTSe/lqBfqY
0os4LQcmR1f2q9Lo1MwD2wTp7bqxwr3LRzxjtRTzi9qJNm4tlP17f9PZ/9oKI+8u
YQq9hi8BGVwwN7ebGoE2NJxBDDFVcwgi35rI75tzQDavKWXbwoYZwAMa2iBovdun
wJz9Y6I29qmxQvhfjpg7BchH4rLgoCNSApIcyrXSQnx0bvjZ2PZqkVRk/tJ22Adx
IF8Q6oFxk8qhUkmy27wunhRm5eu7DR1MOPJkEABBhP1Ay/Cd1Pc=
=wwGD
-----END PGP SIGNATURE-----

--m972NQjnE83KvVa/--
