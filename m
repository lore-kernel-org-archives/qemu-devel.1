Received: from eggs.gnu.org ([2001:4830:134:3::10]:52535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1curxT-0004dC-6h
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 22:43:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1curxR-0005jr-T0
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 22:43:07 -0400
Date: Mon, 3 Apr 2017 12:18:56 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170403021856.GA12906@umbus.fritz.box>
References: <1490795611-4762-6-git-send-email-clg@kaod.org>
	<1490862500-26192-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <1490862500-26192-1-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v4.1 5/9] ppc/pnv: create the ICP object
 under PnvCore
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


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 30, 2017 at 10:28:20AM +0200, C=E9dric Le Goater wrote:
> Each thread of a core is linked to an ICP. This allocates a PnvICPState
> object before the PowerPCCPU object is realized and lets the XICSFabric
> do the store under the 'intc' backlink when xics_cpu_setup() is
> called.
>=20
> This modeling removes the need of maintaining an array of ICP objects
> under the PowerNV machine and also simplifies the XICSFabric icp_get()
> handler.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>=20
>  Changes since v4:
>=20
>  - moved the creation of PnvICPState object before the PowerPCCPU
>    object is realized to handle correctly errors.
> =20
>  Changes since v3:
>=20
>  - removed the array of ICP objects from under the PowerNV machine and
>    handled the allocation of the PnvICPState object for each thread
>    when the PowerPCCPU object is realized.
>=20
>  hw/ppc/pnv.c      |  2 ++
>  hw/ppc/pnv_core.c | 27 +++++++++++++++++++++++++--
>  2 files changed, 27 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 3fa722af82e6..9505ca7dc09a 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -691,6 +691,8 @@ static void pnv_chip_realize(DeviceState *dev, Error =
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
> index d79d530b4881..1b7ec70f033d 100644
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
> @@ -110,23 +111,37 @@ static const MemoryRegionOps pnv_core_xscom_ops =3D=
 {
>      .endianness =3D DEVICE_BIG_ENDIAN,
>  };
> =20
> -static void pnv_core_realize_child(Object *child, Error **errp)
> +static void pnv_core_realize_child(Object *child, XICSFabric *xi, Error =
**errp)
>  {
>      Error *local_err =3D NULL;
>      CPUState *cs =3D CPU(child);
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +    Object *obj;
> +
> +    obj =3D object_new(TYPE_PNV_ICP);
> +    object_property_add_child(OBJECT(cpu), "icp", obj, NULL);
> +    object_property_add_const_link(obj, "xics", OBJECT(xi), &error_abort=
);
> +    object_property_set_bool(obj, true, "realized", &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> =20
>      object_property_set_bool(child, true, "realized", &local_err);
>      if (local_err) {
> +        object_unparent(obj);
>          error_propagate(errp, local_err);
>          return;
>      }
> =20
>      powernv_cpu_init(cpu, &local_err);
>      if (local_err) {
> +        object_unparent(obj);
>          error_propagate(errp, local_err);
>          return;
>      }
> +
> +    xics_cpu_setup(xi, cpu, ICP(obj));
>  }
> =20
>  static void pnv_core_realize(DeviceState *dev, Error **errp)
> @@ -140,6 +155,14 @@ static void pnv_core_realize(DeviceState *dev, Error=
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
> @@ -160,7 +183,7 @@ static void pnv_core_realize(DeviceState *dev, Error =
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

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY4bENAAoJEGw4ysog2bOS4nwQAOcL7f2szXzIOX0h+WeItFk+
5/1LPVbwq+7gFGGCb1hAe8hWjdeDs1YEbGPeFZkkZMzKeFkpmXKyRRh7rT5WXOep
uMGvetkNXY5Xj4jQ9cUi1NktQKQjc6MLRTAwALC+UXw9TPr6ep7wfPZfw8B73h/8
XDFiBBHtvYiKUWmHGbVfrZ8OfNTps+WvkKhhdadqJCZMPWLrR9jgNA46ZbMoIDL7
rEzc/ZU34Ovt8L0CEwismyU2Jb61XmIudo9XCkaO6OdpEDz0PRnibF75C3DJGT7y
RdEfrtGdoIBeQKPnwO2ULHn3LNrurnxF0SHx25brXjFK4sb77JC63AlEa7MVt+yK
Ci7iPyS6HzCh9CxOow9Jjd5AyAJMEnxZvzpVIWY7IiMAidn6ZFafnKKe4NFEnBUh
pG9mRfyL1Z/jLaOWWlHep8fvYM1EvwAmOTJBFLUXwvADcBO5uXghbEWMtV7iX/OY
j72jdsGEY34CAxQAUktioREzmaIqWCngdmR3W3yikmQGjA26U/rt9edwDeNoPy5G
MZDSHkiY1if5hhM/cLLclzEC6iNtzbDVdtR6OhIvdu4VAFNX29uZG/fEHzhIMOiq
DPG6tnfZEelOaHTovbC6TMh3YbxT6PngRjlzSoxU4crgWDXNSF6MpNSvmOmfbYvh
C3PCZZmfGWDKtWeIML/H
=CTYE
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
