Received: from eggs.gnu.org ([2001:4830:134:3::10]:32858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dKh44-0007a5-WF
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 04:20:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dKh43-0007tl-5Z
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 04:20:40 -0400
Date: Tue, 13 Jun 2017 15:50:27 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170613075027.GA30171@umbus>
References: <20170608070351.1434-1-sjitindarsingh@gmail.com>
	<20170608070351.1434-2-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <20170608070351.1434-2-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] target/ppc: Implement large
 decrementer support for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, agraf@suse.de


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2017 at 05:03:47PM +1000, Suraj Jitindar Singh wrote:
> The large decrementer is an operating mode of the decrementer.
> The decrementer is normally a 32-bit register.
> When operating in large decrementer mode the decrementer is a d-bit
> register which is sign extended to 64-bits (where d is implementation
> dependant).
>=20
> Implement support for a TCG guest to use the decrementer in large
> decrementer mode. This means updating the decrementer access functions
> to accept larger values under the correct conditions.
>=20
> The operting mode of the decrementer is controlled by the LPCR_LD bit in
> the logical parition control register (LPCR).
>=20
> The operating mode of the hypervisor decrementer is dependant on the cpu
> model, >=3D POWER9 -> large hypervisor decrementer.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> ---
>  hw/ppc/ppc.c                | 81 +++++++++++++++++++++++++++++++--------=
------
>  target/ppc/cpu-qom.h        |  1 +
>  target/ppc/cpu.h            |  8 ++---
>  target/ppc/mmu-hash64.c     |  2 +-
>  target/ppc/translate.c      |  2 +-
>  target/ppc/translate_init.c |  3 ++
>  6 files changed, 67 insertions(+), 30 deletions(-)
>=20
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index 224184d..49c52ed 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -649,11 +649,11 @@ bool ppc_decr_clear_on_delivery(CPUPPCState *env)
>      return ((tb_env->flags & flags) =3D=3D PPC_DECR_UNDERFLOW_TRIGGERED);
>  }
> =20
> -static inline uint32_t _cpu_ppc_load_decr(CPUPPCState *env, uint64_t nex=
t)
> +static inline target_ulong _cpu_ppc_load_decr(CPUPPCState *env, uint64_t=
 next,
> +                                              bool large_decr)

I think this low-level internal function should always return the full
number of available bits.  It makes more sense to clamp to 32-bits in
the callers implementing the actual interfaces which require that.

>  {
>      ppc_tb_t *tb_env =3D env->tb_env;
> -    uint32_t decr;
> -    int64_t diff;
> +    int64_t decr, diff;
> =20
>      diff =3D next - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>      if (diff >=3D 0) {
> @@ -663,12 +663,16 @@ static inline uint32_t _cpu_ppc_load_decr(CPUPPCSta=
te *env, uint64_t next)
>      }  else {
>          decr =3D -muldiv64(-diff, tb_env->decr_freq, NANOSECONDS_PER_SEC=
OND);
>      }
> -    LOG_TB("%s: %08" PRIx32 "\n", __func__, decr);
> +    LOG_TB("%s: %016" PRIx64 "\n", __func__, decr);
> =20
> -    return decr;
> +    /*
> +     * If large decrementer is enabled then the decrementer is signed ex=
tened
> +     * to 64 bits, otherwise it is a 32 bit value.
> +     */
> +    return large_decr ? decr : (uint32_t) decr;
>  }
> =20
> -uint32_t cpu_ppc_load_decr (CPUPPCState *env)
> +target_ulong cpu_ppc_load_decr (CPUPPCState *env)
>  {
>      ppc_tb_t *tb_env =3D env->tb_env;
> =20
> @@ -676,14 +680,16 @@ uint32_t cpu_ppc_load_decr (CPUPPCState *env)
>          return env->spr[SPR_DECR];
>      }
> =20
> -    return _cpu_ppc_load_decr(env, tb_env->decr_next);
> +    return _cpu_ppc_load_decr(env, tb_env->decr_next,
> +                              env->spr[SPR_LPCR] & LPCR_LD);
>  }
> =20
> -uint32_t cpu_ppc_load_hdecr (CPUPPCState *env)
> +target_ulong cpu_ppc_load_hdecr (CPUPPCState *env)
>  {
>      ppc_tb_t *tb_env =3D env->tb_env;
> =20
> -    return _cpu_ppc_load_decr(env, tb_env->hdecr_next);
> +    return _cpu_ppc_load_decr(env, tb_env->hdecr_next,
> +                              env->mmu_model & POWERPC_MMU_V3);
>  }
> =20
>  uint64_t cpu_ppc_load_purr (CPUPPCState *env)
> @@ -737,13 +743,20 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, u=
int64_t *nextp,
>                                   QEMUTimer *timer,
>                                   void (*raise_excp)(void *),
>                                   void (*lower_excp)(PowerPCCPU *),
> -                                 uint32_t decr, uint32_t value)
> +                                 target_ulong decr, target_ulong value,
> +                                 int decr_bits)
>  {
>      CPUPPCState *env =3D &cpu->env;
>      ppc_tb_t *tb_env =3D env->tb_env;
>      uint64_t now, next;
> =20
> -    LOG_TB("%s: %08" PRIx32 " =3D> %08" PRIx32 "\n", __func__,
> +    /* Truncate value to decr_width and sign extend for simplicity */
> +    value &=3D ((1ULL << decr_bits) - 1);
> +    if (value & (1ULL << (decr_bits - 1))) { /* Negative */
> +        value |=3D (0xFFFFFFFFULL << decr_bits);
> +    }
> +
> +    LOG_TB("%s: " TARGET_FMT_lx " =3D> " TARGET_FMT_lx "\n", __func__,
>                  decr, value);
> =20
>      if (kvm_enabled()) {
> @@ -765,15 +778,16 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, u=
int64_t *nextp,
>       * an edge interrupt, so raise it here too.
>       */
>      if ((value < 3) ||
> -        ((tb_env->flags & PPC_DECR_UNDERFLOW_LEVEL) && (value & 0x800000=
00)) ||
> -        ((tb_env->flags & PPC_DECR_UNDERFLOW_TRIGGERED) && (value & 0x80=
000000)
> -          && !(decr & 0x80000000))) {
> +        ((tb_env->flags & PPC_DECR_UNDERFLOW_LEVEL) && (value & (1ULL <<=
 decr_bits))) ||
> +        ((tb_env->flags & PPC_DECR_UNDERFLOW_TRIGGERED) && (value & (1UL=
L << decr_bits))
> +          && !(decr & (1ULL << decr_bits)))) {
>          (*raise_excp)(cpu);
>          return;
>      }
> =20
>      /* On MSB level based systems a 0 for the MSB stops interrupt delive=
ry */
> -    if (!(value & 0x80000000) && (tb_env->flags & PPC_DECR_UNDERFLOW_LEV=
EL)) {
> +    if (!(value & (1ULL << decr_bits)) && (tb_env->flags &
> +                                         PPC_DECR_UNDERFLOW_LEVEL)) {
>          (*lower_excp)(cpu);
>      }
> =20
> @@ -786,17 +800,24 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, u=
int64_t *nextp,
>      timer_mod(timer, next);
>  }
> =20
> -static inline void _cpu_ppc_store_decr(PowerPCCPU *cpu, uint32_t decr,
> -                                       uint32_t value)
> +static inline void _cpu_ppc_store_decr(PowerPCCPU *cpu, target_ulong dec=
r,
> +                                       target_ulong value)
>  {
>      ppc_tb_t *tb_env =3D cpu->env.tb_env;
> +    int bits =3D 32;
> +
> +    if (cpu->env.spr[SPR_LPCR] & LPCR_LD) {
> +        PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> +
> +        bits =3D pcc->large_decr_bits;
> +    }
> =20
>      __cpu_ppc_store_decr(cpu, &tb_env->decr_next, tb_env->decr_timer,
>                           tb_env->decr_timer->cb, &cpu_ppc_decr_lower, de=
cr,
> -                         value);
> +                         value, bits);
>  }
> =20
> -void cpu_ppc_store_decr (CPUPPCState *env, uint32_t value)
> +void cpu_ppc_store_decr (CPUPPCState *env, target_ulong value)
>  {
>      PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
> =20
> @@ -810,19 +831,26 @@ static void cpu_ppc_decr_cb(void *opaque)
>      cpu_ppc_decr_excp(cpu);
>  }
> =20
> -static inline void _cpu_ppc_store_hdecr(PowerPCCPU *cpu, uint32_t hdecr,
> -                                        uint32_t value)
> +static inline void _cpu_ppc_store_hdecr(PowerPCCPU *cpu, target_ulong hd=
ecr,
> +                                        target_ulong value)
>  {
>      ppc_tb_t *tb_env =3D cpu->env.tb_env;
> +    int bits =3D 32;
> +
> +    if (cpu->env.mmu_model & POWERPC_MMU_V3) {
> +        PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> +
> +        bits =3D pcc->large_decr_bits;

The pcc already knows if it is POWER9 or not, so you could just have
decr_bits in there unconditionally, and set it to 32 for pre-POWER9
CPUs.  Only for the non-HV decr do you need to runtime clamp.

> +    }
> =20
>      if (tb_env->hdecr_timer !=3D NULL) {
>          __cpu_ppc_store_decr(cpu, &tb_env->hdecr_next, tb_env->hdecr_tim=
er,
>                               tb_env->hdecr_timer->cb, &cpu_ppc_hdecr_low=
er,
> -                             hdecr, value);
> +                             hdecr, value, bits);
>      }
>  }
> =20
> -void cpu_ppc_store_hdecr (CPUPPCState *env, uint32_t value)
> +void cpu_ppc_store_hdecr (CPUPPCState *env, target_ulong value)
>  {
>      PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
> =20
> @@ -848,7 +876,9 @@ static void cpu_ppc_set_tb_clk (void *opaque, uint32_=
t freq)
>  {
>      CPUPPCState *env =3D opaque;
>      PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
> +    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
>      ppc_tb_t *tb_env =3D env->tb_env;
> +    int decr_bits =3D 32;
> =20
>      tb_env->tb_freq =3D freq;
>      tb_env->decr_freq =3D freq;
> @@ -857,7 +887,10 @@ static void cpu_ppc_set_tb_clk (void *opaque, uint32=
_t freq)
>       * it's not ready to handle it...
>       */
>      _cpu_ppc_store_decr(cpu, 0xFFFFFFFF, 0xFFFFFFFF);
> -    _cpu_ppc_store_hdecr(cpu, 0xFFFFFFFF, 0xFFFFFFFF);
> +    if (env->mmu_model & POWERPC_MMU_V3) {
> +        decr_bits =3D pcc->large_decr_bits;
> +    }
> +    _cpu_ppc_store_hdecr(cpu, (1 << decr_bits) - 1, (1 << decr_bits) - 1=
);
>      cpu_ppc_store_purr(cpu, 0x0000000000000000ULL);
>  }
> =20
> diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> index d0cf6ca..523979c 100644
> --- a/target/ppc/cpu-qom.h
> +++ b/target/ppc/cpu-qom.h
> @@ -198,6 +198,7 @@ typedef struct PowerPCCPUClass {
>      uint32_t l1_dcache_size, l1_icache_size;
>      const struct ppc_segment_page_sizes *sps;
>      struct ppc_radix_page_info *radix_page_info;
> +    uint32_t large_decr_bits;
>      void (*init_proc)(CPUPPCState *env);
>      int  (*check_pow)(CPUPPCState *env);
>      int (*handle_mmu_fault)(PowerPCCPU *cpu, vaddr eaddr, int rwx, int m=
mu_idx);
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 401e10e..f6e86b6 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1309,10 +1309,10 @@ uint32_t cpu_ppc_load_atbu (CPUPPCState *env);
>  void cpu_ppc_store_atbl (CPUPPCState *env, uint32_t value);
>  void cpu_ppc_store_atbu (CPUPPCState *env, uint32_t value);
>  bool ppc_decr_clear_on_delivery(CPUPPCState *env);
> -uint32_t cpu_ppc_load_decr (CPUPPCState *env);
> -void cpu_ppc_store_decr (CPUPPCState *env, uint32_t value);
> -uint32_t cpu_ppc_load_hdecr (CPUPPCState *env);
> -void cpu_ppc_store_hdecr (CPUPPCState *env, uint32_t value);
> +target_ulong cpu_ppc_load_decr (CPUPPCState *env);
> +void cpu_ppc_store_decr (CPUPPCState *env, target_ulong value);
> +target_ulong cpu_ppc_load_hdecr (CPUPPCState *env);
> +void cpu_ppc_store_hdecr (CPUPPCState *env, target_ulong value);
>  uint64_t cpu_ppc_load_purr (CPUPPCState *env);
>  uint32_t cpu_ppc601_load_rtcl (CPUPPCState *env);
>  uint32_t cpu_ppc601_load_rtcu (CPUPPCState *env);
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index 14d34e5..b1e1764 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -1081,7 +1081,7 @@ void helper_store_lpcr(CPUPPCState *env, target_ulo=
ng val)
>      case POWERPC_MMU_VER_3_00: /* P9 */
>          lpcr =3D val & (LPCR_VPM1 | LPCR_ISL | LPCR_KBV | LPCR_DPFD |
>                        (LPCR_PECE_U_MASK & LPCR_HVEE) | LPCR_ILE | LPCR_A=
IL |
> -                      LPCR_UPRT | LPCR_EVIRT | LPCR_ONL |
> +                      LPCR_UPRT | LPCR_EVIRT | LPCR_ONL | LPCR_LD |
>                        (LPCR_PECE_L_MASK & (LPCR_PDEE | LPCR_HDEE | LPCR_=
EEE |
>                        LPCR_DEE | LPCR_OEE)) | LPCR_MER | LPCR_GTSE | LPC=
R_TC |
>                        LPCR_HEIC | LPCR_LPES0 | LPCR_HVICE | LPCR_HDICE);
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index c0cd64d..ebe1fa5 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -7006,7 +7006,7 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, fpri=
ntf_function cpu_fprintf,
>  #if !defined(NO_TIMER_DUMP)
>      cpu_fprintf(f, "TB %08" PRIu32 " %08" PRIu64
>  #if !defined(CONFIG_USER_ONLY)
> -                " DECR %08" PRIu32
> +                " DECR " TARGET_FMT_lu
>  #endif
>                  "\n",
>                  cpu_ppc_load_tbu(env), cpu_ppc_load_tbl(env)
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index 56a0ab2..a0b2934 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -8995,6 +8995,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
>      /* segment page size remain the same */
>      pcc->sps =3D &POWER7_POWER8_sps;
>      pcc->radix_page_info =3D &POWER9_radix_page_info;
> +    pcc->large_decr_bits =3D 56;
>  #endif
>      pcc->excp_model =3D POWERPC_EXCP_POWER8;
>      pcc->bus_model =3D PPC_FLAGS_INPUT_POWER7;
> @@ -9047,6 +9048,8 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtualHy=
pervisor *vhyp)
>           * tables and guest translation shootdown by default
>           */
>          lpcr->default_value &=3D ~(LPCR_UPRT | LPCR_GTSE);
> +        /* Disable Large Decrementer by Default */
> +        lpcr->default_value &=3D ~LPCR_LD;
>          lpcr->default_value |=3D LPCR_PDEE | LPCR_HDEE | LPCR_EEE | LPCR=
_DEE |
>                                 LPCR_OEE;
>          break;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZP5lAAAoJEGw4ysog2bOS5oUP/ivMZqcSFgrYIEqNnxs0JQAC
Osun2YEFFdr0/5ofHk2RlT5K5sJmXUm6QA7JQLN9vve7q7UIN3J0zm45SRdODB9m
8ldMby5XG8RGZfa5AvAdjKKmf/HL/YIBuZfeJU54aR/uuZ5YfCUuMRcwQcV/8mSF
Kzcj72ncZpbHp11R7PSZJfykDUm198PXqt57dhcFZVwjlwS0ohY7FQ6obtyKsWKA
U0xuFCgyPXGz97s050M6I57sIj8PTsplkVHmbUHpabs13w6KCQM4RSRNpBbO8s6N
9Ny6m1ykjlTzKaWIkv5OixmwF/HIYACsi5f5ypcuzHz3JTX0johlqjjEU5roRSf9
QC8qEZ0Tn2MfxxA44/ui5+Rl8jBmhAaYnNPWXZofFwZFXIS56T1zuZge90n6heWm
Ppi+W4OOSu0XzT2oTQCSQ3IVdDqknsAYeMKPvbSPm2oFpE+rk7GnKggaJsFfgn2k
F31J+nuFVcLFnwVl+cdOX9B+UZoE5zVYmmdh925HclHD1G63UShHVVYf10nybAQa
QC1cW8yeC71JD1beCbxEZXoku2wIa6KP8CP0In/x5iBWa41+Nq6F+wOjPpXZ3WHc
hvJfH4XnlNk+wgJ1quj+sZRwcYXgN9Ml556rn2EuHCQP5Yz3i84xJZuCMVRbDrum
Lo9OhUNUOWbWpoJeLACy
=ojlm
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
