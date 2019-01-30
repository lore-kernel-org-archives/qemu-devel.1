Received: from eggs.gnu.org ([209.51.188.92]:44767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1goyha-00022t-05
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 17:51:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1goyhY-0001Ie-9Y
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 17:51:25 -0500
Date: Thu, 31 Jan 2019 09:35:57 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190130223557.GB1771@umbus.fritz.box>
References: <1548858649-26208-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Content-Disposition: inline
In-Reply-To: <1548858649-26208-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/ppc: Move ppc40x_*reset() functions
 from ppc405_uc.c to ppc.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, yang.zhong@intel.com


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 30, 2019 at 03:30:49PM +0100, Thomas Huth wrote:
> Currently, it is not possible to build a QEMU binary without the
> ppc405_uc.c file, even if you do not want to have the embedded machines
> in the binary. This is bad since it's quite a bit of code and this code
> pulls in some more dependencies (e.g. via the usage of serial_mm_init())
> which would not be needed otherwise - especially with the upcoming
> Kconfig-style configuration system for QEMU.
>=20
> The only functions from this file which are really always required for
> linking are the ppc40x_*reset() functions, so move these functions to
> ppc.c, close to the ppc40x_set_irq() function that calls them. Now we
> can flag ppc405_uc.c and ppc4xx_devs.c with the CONFIG_PPC4XX config
> switch, too.
>=20
> And while we're at it, replace the printf()s in these ppc40x_*reset()
> functions with proper calls to qemu_log_mask().
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Applied, thanks.

> ---
>  hw/ppc/Makefile.objs |  3 +--
>  hw/ppc/ppc.c         | 56 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
>  hw/ppc/ppc405_uc.c   | 58 ----------------------------------------------=
------
>  3 files changed, 57 insertions(+), 60 deletions(-)
>=20
> diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
> index 4e0c1c0..1e753de 100644
> --- a/hw/ppc/Makefile.objs
> +++ b/hw/ppc/Makefile.objs
> @@ -13,8 +13,7 @@ obj-y +=3D spapr_pci_vfio.o
>  endif
>  obj-$(CONFIG_PSERIES) +=3D spapr_rtas_ddw.o
>  # PowerPC 4xx boards
> -obj-y +=3D ppc4xx_devs.o ppc405_uc.o
> -obj-$(CONFIG_PPC4XX) +=3D ppc4xx_pci.o ppc405_boards.o
> +obj-$(CONFIG_PPC4XX) +=3D ppc4xx_devs.o ppc4xx_pci.o ppc405_uc.o ppc405_=
boards.o
>  obj-$(CONFIG_PPC4XX) +=3D ppc440_bamboo.o ppc440_pcix.o ppc440_uc.o
>  obj-$(CONFIG_SAM460EX) +=3D sam460ex.o
>  # PReP
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index ec4be25..98b409f 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -310,6 +310,62 @@ void ppcPOWER7_irq_init(PowerPCCPU *cpu)
>  }
>  #endif /* defined(TARGET_PPC64) */
> =20
> +void ppc40x_core_reset(PowerPCCPU *cpu)
> +{
> +    CPUPPCState *env =3D &cpu->env;
> +    target_ulong dbsr;
> +
> +    qemu_log_mask(CPU_LOG_RESET, "Reset PowerPC core\n");
> +    cpu_interrupt(CPU(cpu), CPU_INTERRUPT_RESET);
> +    dbsr =3D env->spr[SPR_40x_DBSR];
> +    dbsr &=3D ~0x00000300;
> +    dbsr |=3D 0x00000100;
> +    env->spr[SPR_40x_DBSR] =3D dbsr;
> +}
> +
> +void ppc40x_chip_reset(PowerPCCPU *cpu)
> +{
> +    CPUPPCState *env =3D &cpu->env;
> +    target_ulong dbsr;
> +
> +    qemu_log_mask(CPU_LOG_RESET, "Reset PowerPC chip\n");
> +    cpu_interrupt(CPU(cpu), CPU_INTERRUPT_RESET);
> +    /* XXX: TODO reset all internal peripherals */
> +    dbsr =3D env->spr[SPR_40x_DBSR];
> +    dbsr &=3D ~0x00000300;
> +    dbsr |=3D 0x00000200;
> +    env->spr[SPR_40x_DBSR] =3D dbsr;
> +}
> +
> +void ppc40x_system_reset(PowerPCCPU *cpu)
> +{
> +    qemu_log_mask(CPU_LOG_RESET, "Reset PowerPC system\n");
> +    qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> +}
> +
> +void store_40x_dbcr0(CPUPPCState *env, uint32_t val)
> +{
> +    PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
> +
> +    switch ((val >> 28) & 0x3) {
> +    case 0x0:
> +        /* No action */
> +        break;
> +    case 0x1:
> +        /* Core reset */
> +        ppc40x_core_reset(cpu);
> +        break;
> +    case 0x2:
> +        /* Chip reset */
> +        ppc40x_chip_reset(cpu);
> +        break;
> +    case 0x3:
> +        /* System reset */
> +        ppc40x_system_reset(cpu);
> +        break;
> +    }
> +}
> +
>  /* PowerPC 40x internal IRQ controller */
>  static void ppc40x_set_irq(void *opaque, int pin, int level)
>  {
> diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
> index 8d3a797..3ae7f6d 100644
> --- a/hw/ppc/ppc405_uc.c
> +++ b/hw/ppc/ppc405_uc.c
> @@ -1156,64 +1156,6 @@ static void ppc4xx_gpt_init(hwaddr base, qemu_irq =
irqs[5])
>  }
> =20
>  /***********************************************************************=
******/
> -/* SPR */
> -void ppc40x_core_reset(PowerPCCPU *cpu)
> -{
> -    CPUPPCState *env =3D &cpu->env;
> -    target_ulong dbsr;
> -
> -    printf("Reset PowerPC core\n");
> -    cpu_interrupt(CPU(cpu), CPU_INTERRUPT_RESET);
> -    dbsr =3D env->spr[SPR_40x_DBSR];
> -    dbsr &=3D ~0x00000300;
> -    dbsr |=3D 0x00000100;
> -    env->spr[SPR_40x_DBSR] =3D dbsr;
> -}
> -
> -void ppc40x_chip_reset(PowerPCCPU *cpu)
> -{
> -    CPUPPCState *env =3D &cpu->env;
> -    target_ulong dbsr;
> -
> -    printf("Reset PowerPC chip\n");
> -    cpu_interrupt(CPU(cpu), CPU_INTERRUPT_RESET);
> -    /* XXX: TODO reset all internal peripherals */
> -    dbsr =3D env->spr[SPR_40x_DBSR];
> -    dbsr &=3D ~0x00000300;
> -    dbsr |=3D 0x00000200;
> -    env->spr[SPR_40x_DBSR] =3D dbsr;
> -}
> -
> -void ppc40x_system_reset(PowerPCCPU *cpu)
> -{
> -    printf("Reset PowerPC system\n");
> -    qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> -}
> -
> -void store_40x_dbcr0 (CPUPPCState *env, uint32_t val)
> -{
> -    PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
> -
> -    switch ((val >> 28) & 0x3) {
> -    case 0x0:
> -        /* No action */
> -        break;
> -    case 0x1:
> -        /* Core reset */
> -        ppc40x_core_reset(cpu);
> -        break;
> -    case 0x2:
> -        /* Chip reset */
> -        ppc40x_chip_reset(cpu);
> -        break;
> -    case 0x3:
> -        /* System reset */
> -        ppc40x_system_reset(cpu);
> -        break;
> -    }
> -}
> -
> -/***********************************************************************=
******/
>  /* PowerPC 405CR */
>  enum {
>      PPC405CR_CPC0_PLLMR  =3D 0x0B0,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxSJsoACgkQbDjKyiDZ
s5IHFhAAjEJJgzewjbcuhk+J8eQZK7jV4vfaTmnRT66ogyCq5zMfi2XklmOX6Dlh
HXnoA6XhiiyPSwGin1ez+OxbPLrRiIvtzeZ34b/36dNM7MwszKR7tJ5e8q7Yk1w4
B3BiHb2jdsXTnwnEZuissXQlJLPFMP7ug7ehOyIRVXzx+yxpYX7WN5QI01MXuvdS
h+NB8MF6eaJYo+LfzKvHofwDqrTcJUckMJWbLf1HbXCK8K7lt0XbbijLOYe7NMUb
jxpKkiNmGQytmaf8jECldKdBOVhS909rOwiILlo7gWRoK2SvJDHdF0HmxL/LnMTl
dvkrft8uhQLeHsEwr1Tu0GkF4n1gER39MMm9FyHP3Af64bV/hFZw4NqVaSYRSZ8+
bpLpKhvZ2ZlDMTSmYaQ06k1xaHDkfcg8plxQSVpOqmZPvYRZlZZDtJWztJySgrZ1
KGZ3Kt5rOhYk8muFiA/FugXSw0jgsAqxD7kybA/0/KMaKl1Pco6/S0manSgoHkEe
n78fDtDNQY0Z3McyqylYISAbN8RoESq3SG5QNv3iZUHJreJSaRdugM6o6w6wpA0p
EAsoPfd4RMrDw1wZHWgbe4rWn5G0mUElG9n51u0uWPpL9IOAivd2fLNKh9uaAzN5
AwO1Yq0EUimsmW4ZkiTOBADRYBmaO893IlbMAjPC51x+IVygd0M=
=JHWi
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--
