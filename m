Received: from eggs.gnu.org ([2001:4830:134:3::10]:54094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ct62D-0001vW-Ow
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 01:20:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ct629-0005lk-Ql
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 01:20:41 -0400
Date: Wed, 29 Mar 2017 16:20:23 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170329052023.GA21068@umbus.fritz.box>
References: <1490686352-24017-1-git-send-email-clg@kaod.org>
	<1490686352-24017-8-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="opqKFQYYH8F8WaoB"
Content-Disposition: inline
In-Reply-To: <1490686352-24017-8-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v3 7/8] ppc/pnv: link the CPUs to the
 machine XICSFabric
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


--opqKFQYYH8F8WaoB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 28, 2017 at 09:32:31AM +0200, C=E9dric Le Goater wrote:
> This assigns the ICPState object to the CPU using the PIR number for
> lookups before calling the XICS layer to finish the job.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/pnv.c      |  2 ++
>  hw/ppc/pnv_core.c | 20 ++++++++++++++++----
>  2 files changed, 18 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index e441b8ac1cad..ae894834892f 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -711,6 +711,8 @@ static void pnv_chip_realize(DeviceState *dev, Error =
**errp)
>          object_property_set_int(OBJECT(pnv_core),
>                                  pcc->core_pir(chip, core_hwid),
>                                  "pir", &error_fatal);
> +        object_property_add_const_link(OBJECT(pnv_core), "xics",
> +                                       qdev_get_machine(), &error_fatal);
>          object_property_set_bool(OBJECT(pnv_core), true, "realized",
>                                   &error_fatal);
>          object_unref(OBJECT(pnv_core));
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index d79d530b4881..a5e9614dac7d 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -25,6 +25,7 @@
>  #include "hw/ppc/pnv.h"
>  #include "hw/ppc/pnv_core.h"
>  #include "hw/ppc/pnv_xscom.h"
> +#include "hw/ppc/xics.h"
> =20
>  static void powernv_cpu_reset(void *opaque)
>  {
> @@ -43,7 +44,7 @@ static void powernv_cpu_reset(void *opaque)
>      env->msr |=3D MSR_HVB; /* Hypervisor mode */
>  }
> =20
> -static void powernv_cpu_init(PowerPCCPU *cpu, Error **errp)
> +static void powernv_cpu_init(PowerPCCPU *cpu, XICSFabric *xi, Error **er=
rp)
>  {
>      CPUPPCState *env =3D &cpu->env;
>      int core_pir;
> @@ -63,6 +64,9 @@ static void powernv_cpu_init(PowerPCCPU *cpu, Error **e=
rrp)
>      cpu_ppc_tb_init(env, PNV_TIMEBASE_FREQ);
> =20
>      qemu_register_reset(powernv_cpu_reset, cpu);
> +
> +    cpu->icp =3D OBJECT(xics_icp_get(xi, pir->default_value));
> +    xics_cpu_setup(xi, cpu);

Hmm.. seems like xics_cpu_setup() should probably set the cpu->icp link..

>  }
> =20
>  /*
> @@ -110,7 +114,7 @@ static const MemoryRegionOps pnv_core_xscom_ops =3D {
>      .endianness =3D DEVICE_BIG_ENDIAN,
>  };
> =20
> -static void pnv_core_realize_child(Object *child, Error **errp)
> +static void pnv_core_realize_child(Object *child, XICSFabric *xi, Error =
**errp)
>  {
>      Error *local_err =3D NULL;
>      CPUState *cs =3D CPU(child);
> @@ -122,7 +126,7 @@ static void pnv_core_realize_child(Object *child, Err=
or **errp)
>          return;
>      }
> =20
> -    powernv_cpu_init(cpu, &local_err);
> +    powernv_cpu_init(cpu, xi, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
> @@ -140,6 +144,14 @@ static void pnv_core_realize(DeviceState *dev, Error=
 **errp)
>      void *obj;
>      int i, j;
>      char name[32];
> +    Object *xi;
> +
> +    xi =3D object_property_get_link(OBJECT(dev), "xics", &local_err);
> +    if (!xi) {
> +        error_setg(errp, "%s: required link 'xics' not found: %s",
> +                   __func__, error_get_pretty(local_err));
> +        return;
> +    }
> =20
>      pc->threads =3D g_malloc0(size * cc->nr_threads);
>      for (i =3D 0; i < cc->nr_threads; i++) {
> @@ -160,7 +172,7 @@ static void pnv_core_realize(DeviceState *dev, Error =
**errp)
>      for (j =3D 0; j < cc->nr_threads; j++) {
>          obj =3D pc->threads + j * size;
> =20
> -        pnv_core_realize_child(obj, &local_err);
> +        pnv_core_realize_child(obj, XICS_FABRIC(xi), &local_err);
>          if (local_err) {
>              goto err;
>          }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--opqKFQYYH8F8WaoB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY20QXAAoJEGw4ysog2bOSKLUP/3lDUPb8ouECEJW4zVFQ1IKe
jFbMpl9l/xj32LJB2FtZWtpadHBJd3ZzHUl0Kx7zD6GY4tVWs227blnloczDfAvH
dMAYyJdtD0Rk5iwFc29sLSzGXY6yb8zRrksO3zPE1zfFEOTJyJlCbtuOWu6AxEYp
HNhQDlwySDuJpDjkGEFKdmpdNIwp20RFJYnryAyrOqECxUBXOdDgZ4ChT3roRwS5
VhUk6cyCR/yDC3WqlWXvWL0WvosyXdLTt7Ultu8zUW801ho0oZhOK1Gu12OfnoeG
Fn5vSj+v1v5qLBSapdiXhnxpArRmUPgGMGSV8NG3s+noZCqE2fEHCTGbcmTqIi2V
y2VSvvR9kuHrz8BiPeMWpIL5waXgG0PH/yqdK3KHfSzljP0RdjD5uzFLlBHfqkz5
kf5yXESqgjH8UXsTdIjheOdgNbBK70VljEQDmg7IxapVFObW2aWe1k7Y7nRJk+k/
E9sR3zYEVzDgqmP4W5oNFux3PF4Mf8tnbmtrCiOTZ0Vbe90Or3m6/bpgqdRcsPAa
8OX4vSko88Y0NOjnQzGIIs4gomEzNtL9CyqpFjk/f5Try7dVbXsaNfSpJqyZnYqT
UTGArHuJGfSvxm4pJU3sKl6ykOdqquaT/sbj3m7nWQwkBk0xlbyRf+6/Ys+3oPYz
v9gT80TDHtn0dIc1hFxa
=nKE2
-----END PGP SIGNATURE-----

--opqKFQYYH8F8WaoB--
