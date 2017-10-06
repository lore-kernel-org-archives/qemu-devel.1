Received: from eggs.gnu.org ([2001:4830:134:3::10]:36680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0JCj-0002M3-C9
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 23:21:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0JCg-0005DX-T0
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 23:21:37 -0400
Date: Fri, 6 Oct 2017 14:02:56 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171006030256.GF3260@umbus.fritz.box>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
	<1507220690-265042-5-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oPYnW2SrAqZUvu4n"
Content-Disposition: inline
In-Reply-To: <1507220690-265042-5-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/23] ppc: mpc8544ds/e500plat: use generic
 cpu_model parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "open list:ppce500" <qemu-ppc@nongnu.org>


--oPYnW2SrAqZUvu4n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2017 at 06:24:31PM +0200, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

Do you want me to queue the ppc patches here, or do you already have a
plan for that?

> ---
>  hw/ppc/e500.c      | 8 +-------
>  hw/ppc/e500plat.c  | 1 +
>  hw/ppc/mpc8544ds.c | 2 ++
>  3 files changed, 4 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index db0e49a..9178e70 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -803,11 +803,6 @@ void ppce500_init(MachineState *machine, PPCE500Para=
ms *params)
>      SysBusDevice *s;
>      PPCE500CCSRState *ccsr;
> =20
> -    /* Setup CPUs */
> -    if (machine->cpu_model =3D=3D NULL) {
> -        machine->cpu_model =3D "e500v2_v30";
> -    }
> -
>      irqs =3D g_malloc0(smp_cpus * sizeof(qemu_irq *));
>      irqs[0] =3D g_malloc0(smp_cpus * sizeof(qemu_irq) * OPENPIC_OUTPUT_N=
B);
>      for (i =3D 0; i < smp_cpus; i++) {
> @@ -815,8 +810,7 @@ void ppce500_init(MachineState *machine, PPCE500Param=
s *params)
>          CPUState *cs;
>          qemu_irq *input;
> =20
> -        cpu =3D POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU,
> -                                           machine->cpu_model));
> +        cpu =3D POWERPC_CPU(cpu_create(machine->cpu_type));
>          env =3D &cpu->env;
>          cs =3D CPU(cpu);
> =20
> diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
> index 94b4545..e59e80f 100644
> --- a/hw/ppc/e500plat.c
> +++ b/hw/ppc/e500plat.c
> @@ -64,6 +64,7 @@ static void e500plat_machine_init(MachineClass *mc)
>      mc->init =3D e500plat_init;
>      mc->max_cpus =3D 32;
>      mc->has_dynamic_sysbus =3D true;
> +    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("e500v2_v30");
>  }
> =20
>  DEFINE_MACHINE("ppce500", e500plat_machine_init)
> diff --git a/hw/ppc/mpc8544ds.c b/hw/ppc/mpc8544ds.c
> index 27b8289..1717953 100644
> --- a/hw/ppc/mpc8544ds.c
> +++ b/hw/ppc/mpc8544ds.c
> @@ -16,6 +16,7 @@
>  #include "sysemu/device_tree.h"
>  #include "hw/ppc/openpic.h"
>  #include "qemu/error-report.h"
> +#include "cpu.h"
> =20
>  static void mpc8544ds_fixup_devtree(PPCE500Params *params, void *fdt)
>  {
> @@ -55,6 +56,7 @@ static void ppce500_machine_init(MachineClass *mc)
>      mc->desc =3D "mpc8544ds";
>      mc->init =3D mpc8544ds_init;
>      mc->max_cpus =3D 15;
> +    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("e500v2_v30");
>  }
> =20
>  DEFINE_MACHINE("mpc8544ds", ppce500_machine_init)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--oPYnW2SrAqZUvu4n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnW8mAACgkQbDjKyiDZ
s5JVDQ/8CCbZdqziCPmfwiEUxRAt8/TTcFv65TVnEUEyaHSoSLTW1UeScPgYTefP
5POZK9EGfgGRhcvY9Y/Yt/ijlQtgziRV0cjaQsFJ7zqsA0981t4lb5QmNRMMxLtc
RBppUyy5cJm0iVAjEi4MNBsHJAnL069BsbUB+uEVi6cV21vZwywkwYf0su1cVfhj
igHaHjw88n+ZkUjpEIHMNCgi2cAGW8wBgWTDGGe2VHOEUmAu4eEhTrLOr51V/JQw
LJi8Mc3TAtudWZtDMwbllo6LxotjX/c+QkYhrmAI4c3qOeRaEjtnLXjDbxSOncN/
FXyRzK1wLPvdCRajLREHv2+59jzqSfxwUaEXjizWC61G5KvMA2/8AYssX/WwfI2S
amFiYeK50eyzpr2D4OnEZMFXJQyd+IWhwj7ch4W/UKCGscIC45vSFolmKfnnx27F
382yR503g3N+1r3MxAW/y2bMhEPPeOeSj2LJ61vbw1QWtbp2AMU1ZbMkdubBdBNA
FHzSo8Fu7SaYBkMYNisiJAg+j1mK6LL91ikfOUR2FgAcvddO3u301CKhJn9qnCl/
ppG9U5h3h61EdaHGWstEb5I9Jt+Gv/5j5KYQgc+zEseI50tvmW0CZRdra3s/gBTr
hlq2rcNP6ASh0/CWFmLVA7lVuxaUHilxT6CQOLxOKZpHwoh0s1c=
=coiu
-----END PGP SIGNATURE-----

--oPYnW2SrAqZUvu4n--
