Received: from eggs.gnu.org ([2001:4830:134:3::10]:43775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eRA6t-0003eK-7P
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 00:06:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eRA6r-0004wl-RB
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 00:06:35 -0500
Date: Tue, 19 Dec 2017 16:05:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171219050512.GO4786@umbus.fritz.box>
References: <cover.1511731946.git.mdavidsaver@gmail.com>
	<9eb62eb9ad147fef563d259f24c1891b4b2e8511.1511731946.git.mdavidsaver@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="keoAwTxaagou87Dg"
Content-Disposition: inline
In-Reply-To: <9eb62eb9ad147fef563d259f24c1891b4b2e8511.1511731946.git.mdavidsaver@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 14/17] e500: split mpc8544ds specific
 initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>
Cc: Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--keoAwTxaagou87Dg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 26, 2017 at 03:59:12PM -0600, Michael Davidsaver wrote:
> split off the remaining board specific parts
> of e500_init() as mpc85xx_init() which
> will be used by the existing
> mpc8544ds and generic e500 boards.
>=20
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>

Looks good, but will need a rebase.

> ---
>  hw/ppc/e500.c      | 49 ++++++++++++++++++++++++++++++++-----------------
>  hw/ppc/e500.h      |  3 ++-
>  hw/ppc/e500plat.c  |  2 +-
>  hw/ppc/mpc8544ds.c |  2 +-
>  4 files changed, 36 insertions(+), 20 deletions(-)
>=20
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index b0c8495aef..0ac7cdf6a1 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -690,7 +690,32 @@ static void ppce500_power_off(void *opaque, int line=
, int on)
>      }
>  }
> =20
> -void ppce500_init(MachineState *machine, PPCE500Params *params)
> +
> +void ppce500_init(MachineState *machine, uint32_t decrementer_freq)
> +{
> +    int i;
> +    for (i =3D 0; i < smp_cpus; i++) {
> +        PowerPCCPU *cpu;
> +        CPUState *cs;
> +        CPUPPCState *env;
> +
> +        cpu =3D POWERPC_CPU(cpu_create(machine->cpu_type));
> +        env =3D &cpu->env;
> +        cs =3D CPU(cpu);
> +
> +        if (env->mmu_model !=3D POWERPC_MMU_BOOKE206) {
> +            error_report("MMU model %i not supported by this machine.",
> +                         env->mmu_model);
> +            exit(1);
> +        }
> +
> +        env->spr_cb[SPR_BOOKE_PIR].default_value =3D cs->cpu_index =3D i;
> +
> +        ppc_booke_timers_init(cpu, decrementer_freq, PPC_TIMER_E500);
> +    }
> +}
> +
> +void mpc85xx_init(MachineState *machine, PPCE500Params *params)
>  {
>      MemoryRegion *address_space_mem =3D get_system_memory();
>      MemoryRegion *ram =3D g_new(MemoryRegion, 1);
> @@ -716,31 +741,21 @@ void ppce500_init(MachineState *machine, PPCE500Par=
ams *params)
>      CPUPPCState *firstenv =3D NULL;
>      MemoryRegion *ccsr_addr_space;
>      SysBusDevice *s;
> +    CPUState *cs;
> =20
> -    for (i =3D 0; i < smp_cpus; i++) {
> +    ppce500_init(machine, 400000000);
> +
> +    CPU_FOREACH(cs) {
>          PowerPCCPU *cpu;
> -        CPUState *cs;
> =20
> -        cpu =3D POWERPC_CPU(cpu_create(machine->cpu_type));
> +        cpu =3D POWERPC_CPU(cs);
>          env =3D &cpu->env;
> -        cs =3D CPU(cpu);
> =20
> -        if (env->mmu_model !=3D POWERPC_MMU_BOOKE206) {
> -            fprintf(stderr, "MMU model %i not supported by this machine.=
\n",
> -                env->mmu_model);
> -            exit(1);
> -        }
> =20
> +        /* Register reset handler */
>          if (!firstenv) {
>              firstenv =3D env;
> -        }
> =20
> -        env->spr_cb[SPR_BOOKE_PIR].default_value =3D cs->cpu_index =3D i;
> -
> -        ppc_booke_timers_init(cpu, 400000000, PPC_TIMER_E500);
> -
> -        /* Register reset handler */
> -        if (!i) {
>              /* Primary CPU */
>              struct boot_info *boot_info;
>              boot_info =3D g_malloc0(sizeof(struct boot_info));
> diff --git a/hw/ppc/e500.h b/hw/ppc/e500.h
> index 70ba1d8f4f..350be17462 100644
> --- a/hw/ppc/e500.h
> +++ b/hw/ppc/e500.h
> @@ -24,7 +24,8 @@ typedef struct PPCE500Params {
>      hwaddr spin_base;
>  } PPCE500Params;
> =20
> -void ppce500_init(MachineState *machine, PPCE500Params *params);
> +void ppce500_init(MachineState *machine, uint32_t decrementer_freq);
> +void mpc85xx_init(MachineState *machine, PPCE500Params *params);
> =20
>  hwaddr booke206_page_size_to_tlb(uint64_t size);
> =20
> diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
> index e59e80fb9e..103efc68c2 100644
> --- a/hw/ppc/e500plat.c
> +++ b/hw/ppc/e500plat.c
> @@ -55,7 +55,7 @@ static void e500plat_init(MachineState *machine)
>          params.mpic_version =3D OPENPIC_MODEL_FSL_MPIC_20;
>      }
> =20
> -    ppce500_init(machine, &params);
> +    mpc85xx_init(machine, &params);
>  }
> =20
>  static void e500plat_machine_init(MachineClass *mc)
> diff --git a/hw/ppc/mpc8544ds.c b/hw/ppc/mpc8544ds.c
> index 1717953ec7..7de4ed8ae2 100644
> --- a/hw/ppc/mpc8544ds.c
> +++ b/hw/ppc/mpc8544ds.c
> @@ -47,7 +47,7 @@ static void mpc8544ds_init(MachineState *machine)
>          exit(1);
>      }
> =20
> -    ppce500_init(machine, &params);
> +    mpc85xx_init(machine, &params);
>  }
> =20
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--keoAwTxaagou87Dg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlo4nggACgkQbDjKyiDZ
s5KR3BAAkHgn4AH6iEmBisqAhX1+iq0d2STLAd3KupWIjQQJdbdd/XAuNRXzbAvL
jDFCkvdoE2mLt6kL4QTDpNtF6Rnh3+QeggMMzYpCAHzO6/QcmwcFLOYWVjjlasWT
X5u6ZWuSv43MGMFgmchDpqaDUgaBx0oDx9BVatbELeNFpRC1SRpTRLDNX0hWk3Lv
iZrPQKVjia2di7r/zA+N1ns7M15nczc0u10T4DGMU4fovdsJ27rw49zehgpJuHO7
PQBg3XA0S64CUUvEIx4+VUQmkit20X7k/w9HJ0yzCBeuTydxfunU44Zw+4b6QtXm
0TVBdbORo95WtlVRfTgBy/tT2QAw7Arl4H8CDwKy5XxdfOUQrevM/ys2Rw+vRDp4
iZRD5mBXf2GhZBBslMiFkUO1YGuDlkUOS11CiqXTn7GhnkJizi1y6M+Xyw/o6PvQ
CS8nNLZszLtjIisY4JSOX569gQjnOL6EtWtA9OOogmKEv3MEajqvPWsXdUNc/RRo
kDjMht/Z1hwXI0uoY21Bs05mU4g5THnx3nukV3xMTodkyS1ztoFlOLuwpBvlkd7B
XWH1Xh5mho7452JlaL6ljW/CbpmarVpTbYitDo7og0yYwhggzm9SgZbjT2CGC77q
lXBJgXX2CORIcdl4GHgQRpbwuDCpUbp//uE4+8fu6KPQQcnykNc=
=z6KP
-----END PGP SIGNATURE-----

--keoAwTxaagou87Dg--
