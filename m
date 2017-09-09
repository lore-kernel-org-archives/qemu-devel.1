Received: from eggs.gnu.org ([2001:4830:134:3::10]:58748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqa7K-0000Vo-Tc
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 03:23:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqa7J-0005gD-T6
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 03:23:50 -0400
Date: Sat, 9 Sep 2017 17:02:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170909070212.GT2735@umbus.fritz.box>
References: <20170906082748.28520-1-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ScUgq5oMe+fJq4F1"
Content-Disposition: inline
In-Reply-To: <20170906082748.28520-1-nikunj@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: fix cores per chip for multiple
 cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org, bharata@linux.vnet.ibm.com, benh@kernel.crashing.org


--ScUgq5oMe+fJq4F1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 06, 2017 at 01:57:48PM +0530, Nikunj A Dadhania wrote:
> When the user does not provide the cpu topology, e.g. "-smp 4", machine f=
ails to
> initialize 4 cpus. Compute the chip per cores depending on the number of =
chips
> and smt threads.
>=20
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

I don't understand why simply treating smp_cores as cores per chip is wrong.

> ---
>  hw/ppc/pnv.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 9724719..3fbaafb 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -642,7 +642,7 @@ static void ppc_powernv_init(MachineState *machine)
>      MemoryRegion *ram;
>      char *fw_filename;
>      long fw_size;
> -    int i;
> +    int i, cores_per_chip;
>      char *chip_typename;
>      PCIBus *pbus;
>      bool has_gfx =3D false;
> @@ -710,6 +710,22 @@ static void ppc_powernv_init(MachineState *machine)
>      }
> =20
>      pnv->chips =3D g_new0(PnvChip *, pnv->num_chips);
> +
> +    /* If user has specified number of cores, use it. Otherwise, compute=
 it. */
> +    if (smp_cores !=3D 1) {
> +        cores_per_chip =3D smp_cores;
> +    } else {
> +        cores_per_chip =3D smp_cpus / (smp_threads * pnv->num_chips);
> +    }
> +
> +    if (smp_cpus !=3D (smp_threads * pnv->num_chips * cores_per_chip)) {
> +        error_report("cpu topology not balanced: "
> +                     "chips (%u) * cores (%u) * threads (%u) !=3D "
> +                     "number of cpus (%u)",
> +                     pnv->num_chips, cores_per_chip, smp_threads, smp_cp=
us);
> +        exit(1);
> +    }
> +
>      for (i =3D 0; i < pnv->num_chips; i++) {
>          char chip_name[32];
>          Object *chip =3D object_new(chip_typename);
> @@ -728,7 +744,7 @@ static void ppc_powernv_init(MachineState *machine)
>          object_property_add_child(OBJECT(pnv), chip_name, chip, &error_f=
atal);
>          object_property_set_int(chip, PNV_CHIP_HWID(i), "chip-id",
>                                  &error_fatal);
> -        object_property_set_int(chip, smp_cores, "nr-cores", &error_fata=
l);
> +        object_property_set_int(chip, cores_per_chip, "nr-cores", &error=
_fatal);
>          object_property_set_int(chip, 1, "num-phbs", &error_fatal);
>          object_property_set_bool(chip, true, "realized", &error_fatal);
>      }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ScUgq5oMe+fJq4F1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmzkfEACgkQbDjKyiDZ
s5IxqhAAvzYKXeYK/UAybUFtwWC/31y4wT9emXZ0jJjqY8bQM4O2X/y6jMcD2JZG
kRu3iEFepKuen6J8gDSuABvsMzgmrEBmwLl8u8QjZ5+mfIQLUJKci7pkcntJyIuj
IEEjvXlnzWKriZFgOSjHzvs5MartOoTP6b2kqgOH8owYj+JJvPZ1hxbzlVgwjy9C
PGaL1nCVvfl9ZPg1qC9xGS/dPslwIh2aFyhcVpfQeuJxGAd7hYrx0HwBmjWAFvzR
lBnn6G/s6dllAvVNcbUVwSJo+Wfx9c8mcv8BmMwfu4F+qb7y5z6zZBTX0PcMIV9h
UfEKr6ChvNRRwuzA4S3xi4dGDUrE8sb03d5ctKmhMQ+9PvuIg95i5f+vh9lUvKhh
Ooj2ZrdH3gu799Em4LjcVyiY7Xy0c2iv3e06PpTZUjuvQBa4UfBGf7djmUWk11qz
eUzd5GURNOBZtGXIgSL67xGqGfaOCW37jeYmQrpFS3dYLyucHTQOfKxR5uqimarX
M8u6n1km8RXMo8Deg1hffqfNVszDAPfB6HTGFI4KtGPJBrDFK5sXD5+uJXC2YPzF
AW0LkFQjgEZ/8TDI+biKIBZmqX1YV1KmUOfJyfjUuK/kKLDP6YD2mkukkFlPWHFk
YHkXtcpWf1S++IcJ9qZ1lHkbYRuaP89Zw2tPb4Zt6MWQjrMgTUI=
=Uuhv
-----END PGP SIGNATURE-----

--ScUgq5oMe+fJq4F1--
