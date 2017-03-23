Received: from eggs.gnu.org ([2001:4830:134:3::10]:45972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cquEu-0001ru-HA
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 00:20:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cquEr-0005o8-7I
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 00:20:44 -0400
Date: Thu, 23 Mar 2017 15:18:18 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170323041818.GK19078@umbus.fritz.box>
References: <1489674912-21942-1-git-send-email-clg@kaod.org>
	<1489674912-21942-8-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9RxwyT9MtfFuvYYZ"
Content-Disposition: inline
In-Reply-To: <1489674912-21942-8-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 7/8] ppc/pnv: link the CPUs to the
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


--9RxwyT9MtfFuvYYZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 16, 2017 at 03:35:11PM +0100, C=E9dric Le Goater wrote:
> This assigns the ICPState object to the CPU using the PIR number for
> lookups before calling the XICS layer to finish the job.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/pnv.c      |  2 ++
>  hw/ppc/pnv_core.c | 20 ++++++++++++++++----
>  2 files changed, 18 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 6ff01c3b84d5..9c239932fb3a 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -714,6 +714,8 @@ static void pnv_chip_realize(DeviceState *dev, Error =
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
> index d79d530b4881..6ec1c9c0a831 100644
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
> +    cpu->icp =3D xics_icp_get(xi, pir->default_value);
> +    xics_cpu_setup(xi, cpu);
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

--9RxwyT9MtfFuvYYZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY00yKAAoJEGw4ysog2bOSy+oQALVwcnnQ7q38X0UA+74vbnpm
0oKNtO7IWYQ/tRUoVGBT7Nsz5FINDZ73zSqMcpA+jbPfCZmWYtVgyUFr5nIXBS3Z
xdd7SgtffHxpw2Wo3BUzlEnZ7f3RyNCsUfpW04a6M9v9OpT7T92Gz3DM+L68Npoz
6JhI/WZ/EvvMbkGK1bkpHVG7u34LuvX5pURwtfHFf5KJ2U1RFs8Nje/DQ6AdWuzK
vu9sihP+7Eh2hYC4Uz8NCdQ5ARmcQz7PbIp4QXY4hT9NJnvzAPv2u8ElytPpaWhg
nwKZLiSkfRzNvNXAm5lqv9D5ZfrX8V0RlpAjMR/g3jTL5s0NB3vHSXDNtLtOy9Bc
RsHy0im62qftWhEb8fJbqK/h1uYqqryV3dx+dYmcDU6QI7zxDDXFgnB0hATkndip
vl0APabxaIL613VF4SJVWGCNI60tf4lPr/nlRPBycLm9myBFauX64jsS+uZohBfa
HqGjpD4fQoUT7l1n5x4Js/hPP1uZFNlLYjKzALWsjkQfWGF4aM4DTk7wU8Sd79P2
UK2Vu3fL8BYlYvBfx2mfE46e3P5pojch9vfTYjrweEL3gBzN/NuaK6iLMU0locYe
8vblDcSibbYsZGwsWrDx/NoinIF/JH7rWddPRLiQzTkSXjzEeU6HIHMQmQIQan+I
c08894AYQq3brs2XNKcX
=hAj5
-----END PGP SIGNATURE-----

--9RxwyT9MtfFuvYYZ--
