Received: from eggs.gnu.org ([209.51.188.92]:35890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gymL3-0007BX-LN
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 18:40:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gymKx-0006W1-Im
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 18:40:41 -0500
Date: Wed, 27 Feb 2019 10:39:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190226233916.GW6872@umbus.fritz.box>
References: <20190226030531.9932-1-sjitindarsingh@gmail.com>
	<20190226030531.9932-2-sjitindarsingh@gmail.com>
	<20190226035326.GL6872@umbus.fritz.box>
	<1551223685.2210.11.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iJhwK4DKf9Unwzgv"
Content-Disposition: inline
In-Reply-To: <1551223685.2210.11.camel@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH 2/4] target/ppc: Implement large
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
Cc: qemu-ppc@nongnu.org, clg@kaod.org, qemu-devel@nongnu.org


--iJhwK4DKf9Unwzgv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 27, 2019 at 10:28:05AM +1100, Suraj Jitindar Singh wrote:
> On Tue, 2019-02-26 at 14:53 +1100, David Gibson wrote:
> > On Tue, Feb 26, 2019 at 02:05:29PM +1100, Suraj Jitindar Singh wrote:
> > > Prior to POWER9 the decrementer was a 32-bit register which
> > > decremented
> > > with each tick of the timebase. From POWER9 onwards the decrementer
> > > can
> > > be set to operate in a mode called large decrementer where it acts
> > > as a
> > > n-bit decrementing register which is visible as a 64-bit register,
> > > that
> > > is the value of the decrementer is sign extended to 64 bits (where
> > > n is
> > > implementation dependant).
> > >=20
> > > The mode in which the decrementer operates is controlled by the
> > > LPCR_LD
> > > bit in the logical paritition control register (LPCR).
> > >=20
> > > > From POWER9 onwards the HDEC (hypervisor decrementer) was
> > > > enlarged to
> > >=20
> > > h-bits, also sign extended to 64 bits (where h is implementation
> > > dependant). Note this isn't configurable and is always enabled.
> > >=20
> > > For TCG we allow the user to configure a custom large decrementer
> > > size,
> > > so long as it's at least 32 and less than the size of the HDEC (the
> > > restrictions imposed by the ISA).
> > >=20
> > > Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> > > Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> > > ---
> > >  hw/ppc/ppc.c                    | 78 ++++++++++++++++++++++++++++-
> > > ------------
> > >  hw/ppc/spapr.c                  |  8 +++++
> > >  hw/ppc/spapr_caps.c             | 38 +++++++++++++++++++-
> > >  target/ppc/cpu-qom.h            |  1 +
> > >  target/ppc/cpu.h                | 11 +++---
> > >  target/ppc/mmu-hash64.c         |  2 +-
> > >  target/ppc/translate.c          |  2 +-
> > >  target/ppc/translate_init.inc.c |  1 +
> > >  8 files changed, 109 insertions(+), 32 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> > > index d1e3d4cd20..853afeed6a 100644
> > > --- a/hw/ppc/ppc.c
> > > +++ b/hw/ppc/ppc.c
> > > @@ -744,10 +744,10 @@ bool ppc_decr_clear_on_delivery(CPUPPCState
> > > *env)
> > >      return ((tb_env->flags & flags) =3D=3D
> > > PPC_DECR_UNDERFLOW_TRIGGERED);
> > >  }
> > > =20
> > > -static inline uint32_t _cpu_ppc_load_decr(CPUPPCState *env,
> > > uint64_t next)
> > > +static inline uint64_t _cpu_ppc_load_decr(CPUPPCState *env,
> > > uint64_t next)
> >=20
> > Hrm.  Given how we use this - and how muldiv64 works, wouldn't it
> > make
> > more sense to have it return int64_t (i.e. signed).
>=20
> I mean, functionally it's the same. So sure
>=20
> >=20
> > >  {
> > >      ppc_tb_t *tb_env =3D env->tb_env;
> > > -    uint32_t decr;
> > > +    uint64_t decr;
> > >      int64_t diff;
> > > =20
> > >      diff =3D next - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> > > @@ -758,27 +758,42 @@ static inline uint32_t
> > > _cpu_ppc_load_decr(CPUPPCState *env, uint64_t next)
> > >      }  else {
> > >          decr =3D -muldiv64(-diff, tb_env->decr_freq,
> > > NANOSECONDS_PER_SECOND);
> > >      }
> > > -    LOG_TB("%s: %08" PRIx32 "\n", __func__, decr);
> > > +    LOG_TB("%s: %016" PRIx64 "\n", __func__, decr);
> > > =20
> > >      return decr;
> > >  }
> > > =20
> > > -uint32_t cpu_ppc_load_decr (CPUPPCState *env)
> > > +target_ulong cpu_ppc_load_decr (CPUPPCState *env)
> > >  {
> > >      ppc_tb_t *tb_env =3D env->tb_env;
> > > +    uint64_t decr;
> > > =20
> > >      if (kvm_enabled()) {
> > >          return env->spr[SPR_DECR];
> > >      }
> > > =20
> > > -    return _cpu_ppc_load_decr(env, tb_env->decr_next);
> > > +    decr =3D _cpu_ppc_load_decr(env, tb_env->decr_next);
> > > +
> > > +    /*
> > > +     * If large decrementer is enabled then the decrementer is
> > > signed extened
> > > +     * to 64 bits, otherwise it is a 32 bit value.
> > > +     */
> > > +    if (env->spr[SPR_LPCR] & LPCR_LD)
> > > +        return decr;
> > > +    return (uint32_t) decr;
> > >  }
> > > =20
> > > -uint32_t cpu_ppc_load_hdecr (CPUPPCState *env)
> > > +target_ulong cpu_ppc_load_hdecr (CPUPPCState *env)
> > >  {
> > >      ppc_tb_t *tb_env =3D env->tb_env;
> > > +    uint64_t decr;
> > > =20
> > > -    return _cpu_ppc_load_decr(env, tb_env->hdecr_next);
> > > +    decr =3D  _cpu_ppc_load_decr(env, tb_env->hdecr_next);
> > > +
> > > +    /* If POWER9 or later then hdecr is sign extended to 64 bits
> > > otherwise 32 */
> > > +    if (env->mmu_model & POWERPC_MMU_3_00)
> >=20
> > You already have a pcc->hdecr_bits.  Wouldn't it make more sense to
> > check against that than the cpu model directly?
>=20
> The end result is the same since P9 is the only one with hdecr_bits
> defined. So I'll change it if you prefer.

I prefer - this way it would need changing again when we get a second
cpu with large hdecr.

>=20
> >=20
> > > +        return decr;
> > > +    return (uint32_t) decr;
> > >  }
> > > =20
> > >  uint64_t cpu_ppc_load_purr (CPUPPCState *env)
> > > @@ -832,13 +847,21 @@ static void __cpu_ppc_store_decr(PowerPCCPU
> > > *cpu, uint64_t *nextp,
> > >                                   QEMUTimer *timer,
> > >                                   void (*raise_excp)(void *),
> > >                                   void (*lower_excp)(PowerPCCPU *),
> > > -                                 uint32_t decr, uint32_t value)
> > > +                                 target_ulong decr, target_ulong
> > > value,
> > > +                                 int nr_bits)
> > >  {
> > >      CPUPPCState *env =3D &cpu->env;
> > >      ppc_tb_t *tb_env =3D env->tb_env;
> > >      uint64_t now, next;
> > > +    bool negative;
> > > +
> > > +    /* Truncate value to decr_width and sign extend for simplicity
> > > */
> > > +    value &=3D ((1ULL << nr_bits) - 1);
> > > +    negative =3D !!(value & (1ULL << (nr_bits - 1)));
> >=20
> > Could you simplify this by just using
> > 	negative =3D (int64_t)decr < 0;
> > before you mask?  Or would that be wrong in some edge case or other?
>=20
> Value might not be a 64 bit number. It could be 56 bits for example
> where the 56th bit being set would indicate that it's negative. So we
> need to explicitly check as far as I can tell, unless I've missed
> something.

Ah, I thought the incoming value would already be sign-extended to
64-bits, but maybe not.

> Casting it to a (int64_t) would only make it negative if the 64th bit
> was set correct?
>=20
> But on a 56 bit decrementer you could load -1 as:
> 0x00FFFFFFFFFFFFFF
> Which when cast to a (int64_t) wouldn't be negative.

Ok.

>=20
> >=20
> > > +    if (negative)
> > > +        value |=3D (0xFFFFFFFFULL << nr_bits);
> > > =20
> > > -    LOG_TB("%s: %08" PRIx32 " =3D> %08" PRIx32 "\n", __func__,
> > > +    LOG_TB("%s: " TARGET_FMT_lx " =3D> " TARGET_FMT_lx "\n",
> > > __func__,
> > >                  decr, value);
> > > =20
> > >      if (kvm_enabled()) {
> > > @@ -860,15 +883,15 @@ static void __cpu_ppc_store_decr(PowerPCCPU
> > > *cpu, uint64_t *nextp,
> > >       * an edge interrupt, so raise it here too.
> > >       */
> > >      if ((value < 3) ||
> > > -        ((tb_env->flags & PPC_DECR_UNDERFLOW_LEVEL) && (value &
> > > 0x80000000)) ||
> > > -        ((tb_env->flags & PPC_DECR_UNDERFLOW_TRIGGERED) && (value
> > > & 0x80000000)
> > > -          && !(decr & 0x80000000))) {
> > > +        ((tb_env->flags & PPC_DECR_UNDERFLOW_LEVEL) && negative)
> > > ||
> > > +        ((tb_env->flags & PPC_DECR_UNDERFLOW_TRIGGERED) &&
> > > negative
> > > +          && !(decr & (1ULL << (nr_bits - 1))))) {
> > >          (*raise_excp)(cpu);
> > >          return;
> > >      }
> > > =20
> > >      /* On MSB level based systems a 0 for the MSB stops interrupt
> > > delivery */
> > > -    if (!(value & 0x80000000) && (tb_env->flags &
> > > PPC_DECR_UNDERFLOW_LEVEL)) {
> > > +    if (!negative && (tb_env->flags & PPC_DECR_UNDERFLOW_LEVEL)) {
> > >          (*lower_excp)(cpu);
> > >      }
> > > =20
> > > @@ -881,21 +904,24 @@ static void __cpu_ppc_store_decr(PowerPCCPU
> > > *cpu, uint64_t *nextp,
> > >      timer_mod(timer, next);
> > >  }
> > > =20
> > > -static inline void _cpu_ppc_store_decr(PowerPCCPU *cpu, uint32_t
> > > decr,
> > > -                                       uint32_t value)
> > > +static inline void _cpu_ppc_store_decr(PowerPCCPU *cpu,
> > > target_ulong decr,
> > > +                                       target_ulong value, int
> > > nr_bits)
> > >  {
> > >      ppc_tb_t *tb_env =3D cpu->env.tb_env;
> > > =20
> > >      __cpu_ppc_store_decr(cpu, &tb_env->decr_next, tb_env-
> > > >decr_timer,
> > >                           tb_env->decr_timer->cb,
> > > &cpu_ppc_decr_lower, decr,
> > > -                         value);
> > > +                         value, nr_bits);
> > >  }
> > > =20
> > > -void cpu_ppc_store_decr (CPUPPCState *env, uint32_t value)
> > > +void cpu_ppc_store_decr (CPUPPCState *env, target_ulong value)
> > >  {
> > >      PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
> > > +    int nr_bits =3D 32;
> > > +    if ((env->spr[SPR_LPCR] & LPCR_LD) && (env->large_decr_bits >
> > > 32))
> > > +        nr_bits =3D env->large_decr_bits;
> >=20
> > This would be simpler if you initialized large_decr_bits to 32 on
> > cpus that don't have large decr, wouldn't it?
>=20
> Correct, will do.
>=20
> >=20
> > > =20
> > > -    _cpu_ppc_store_decr(cpu, cpu_ppc_load_decr(env), value);
> > > +    _cpu_ppc_store_decr(cpu, cpu_ppc_load_decr(env), value,
> > > nr_bits);
> > >  }
> > > =20
> > >  static void cpu_ppc_decr_cb(void *opaque)
> > > @@ -905,23 +931,25 @@ static void cpu_ppc_decr_cb(void *opaque)
> > >      cpu_ppc_decr_excp(cpu);
> > >  }
> > > =20
> > > -static inline void _cpu_ppc_store_hdecr(PowerPCCPU *cpu, uint32_t
> > > hdecr,
> > > -                                        uint32_t value)
> > > +static inline void _cpu_ppc_store_hdecr(PowerPCCPU *cpu,
> > > target_ulong hdecr,
> > > +                                        target_ulong value, int
> > > nr_bits)
> > >  {
> > >      ppc_tb_t *tb_env =3D cpu->env.tb_env;
> > > =20
> > >      if (tb_env->hdecr_timer !=3D NULL) {
> > >          __cpu_ppc_store_decr(cpu, &tb_env->hdecr_next, tb_env-
> > > >hdecr_timer,
> > >                               tb_env->hdecr_timer->cb,
> > > &cpu_ppc_hdecr_lower,
> > > -                             hdecr, value);
> > > +                             hdecr, value, nr_bits);
> > >      }
> > >  }
> > > =20
> > > -void cpu_ppc_store_hdecr (CPUPPCState *env, uint32_t value)
> > > +void cpu_ppc_store_hdecr (CPUPPCState *env, target_ulong value)
> > >  {
> > >      PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
> > > +    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> > > +    int nr_bits =3D (pcc->hdecr_bits > 32) ? pcc->hdecr_bits : 32;
> >=20
> > Similarly with hdecr_bits.
>=20
> Yep
>=20
> >=20
> > > -    _cpu_ppc_store_hdecr(cpu, cpu_ppc_load_hdecr(env), value);
> > > +    _cpu_ppc_store_hdecr(cpu, cpu_ppc_load_hdecr(env), value,
> > > nr_bits);
> > >  }
> > > =20
> > >  static void cpu_ppc_hdecr_cb(void *opaque)
> > > @@ -951,8 +979,8 @@ static void cpu_ppc_set_tb_clk (void *opaque,
> > > uint32_t freq)
> > >       * if a decrementer exception is pending when it enables
> > > msr_ee at startup,
> > >       * it's not ready to handle it...
> > >       */
> > > -    _cpu_ppc_store_decr(cpu, 0xFFFFFFFF, 0xFFFFFFFF);
> > > -    _cpu_ppc_store_hdecr(cpu, 0xFFFFFFFF, 0xFFFFFFFF);
> > > +    _cpu_ppc_store_decr(cpu, 0xFFFFFFFF, 0xFFFFFFFF, 32);
> > > +    _cpu_ppc_store_hdecr(cpu, 0xFFFFFFFF, 0xFFFFFFFF, 32);
> > >      cpu_ppc_store_purr(cpu, 0x0000000000000000ULL);
> > >  }
> > > =20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index acf62a2b9f..966bc74e68 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -557,6 +557,14 @@ static void spapr_populate_cpu_dt(CPUState
> > > *cs, void *fdt, int offset,
> > >                            pcc->radix_page_info->count *
> > >                            sizeof(radix_AP_encodings[0]))));
> > >      }
> > > +
> > > +    /*
> > > +     * We set this property to let the guest know that it can use
> > > the large
> > > +     * decrementer and its width in bits.
> > > +     */
> > > +    if (env->large_decr_bits)
> > > +        _FDT((fdt_setprop_u32(fdt, offset, "ibm,dec-bits",
> > > +                              env->large_decr_bits)));
> > >  }
> > > =20
> > >  static void spapr_populate_cpus_dt_node(void *fdt,
> > > sPAPRMachineState *spapr)
> > > diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> > > index 1545a02729..44542fdbb2 100644
> > > --- a/hw/ppc/spapr_caps.c
> > > +++ b/hw/ppc/spapr_caps.c
> > > @@ -421,8 +421,43 @@ static void
> > > cap_nested_kvm_hv_apply(sPAPRMachineState *spapr,
> > >  static void cap_large_decr_apply(sPAPRMachineState *spapr,
> > >                                   uint8_t val, Error **errp)
> > >  {
> > > -    if (val)
> > > +    PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
> > > +    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> > > +
> > > +    if (!val)
> > > +        return; /* Disabled by default */
> > > +
> > > +    if (tcg_enabled()) {
> > > +        if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_00, 0,
> > > +                              spapr->max_compat_pvr)) {
> >=20
> > IIUC this is strictly redundant with the check against hdecr_bits,
> > yes, but will  result in a more helpful error message.  Is that
> > right?
>=20
> The error message will be more useful.
> Also if I go and set hdecr_bits to 32 as suggested above the P9 check
> is required because otherwise you could set a 32 bit large decr on
> P7/P8.
>=20
> >=20
> > > +            error_setg(errp,
> > > +                "Large decrementer only supported on POWER9, try
> > > -cpu POWER9");
> > > +            return;
> > > +        }
> > > +        if ((val < 32) || (val > pcc->hdecr_bits)) {
> > > +            error_setg(errp,
> > > +                "Large decrementer size unsupported, try -cap-
> > > large-decr=3D%d",
> > > +                pcc->hdecr_bits);
> > > +            return;
> > > +        }
> > > +    } else {
> > >          error_setg(errp, "No large decrementer support, try cap-
> > > large-decr=3D0");
> > > +    }
> > > +}
> > > +
> > > +static void cap_large_decr_cpu_apply(sPAPRMachineState *spapr,
> > > +                                     PowerPCCPU *cpu,
> > > +                                     uint8_t val, Error **errp)
> > > +{
> > > +    CPUPPCState *env =3D &cpu->env;
> > > +    target_ulong lpcr =3D env->spr[SPR_LPCR];
> > > +
> > > +    if (val)
> > > +        lpcr |=3D LPCR_LD;
> > > +    else
> > > +        lpcr &=3D ~LPCR_LD;
> > > +    ppc_store_lpcr(cpu, lpcr);
> > > +    env->large_decr_bits =3D val;
> > >  }
> > > =20
> > >  sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] =3D {
> > > @@ -511,6 +546,7 @@ sPAPRCapabilityInfo
> > > capability_table[SPAPR_CAP_NUM] =3D {
> > >          .set =3D spapr_cap_set_uint8,
> > >          .type =3D "int",
> > >          .apply =3D cap_large_decr_apply,
> > > +        .cpu_apply =3D cap_large_decr_cpu_apply,
> > >      },
> > >  };
> > > =20
> > > diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> > > index ae51fe754e..cced705e30 100644
> > > --- a/target/ppc/cpu-qom.h
> > > +++ b/target/ppc/cpu-qom.h
> > > @@ -190,6 +190,7 @@ typedef struct PowerPCCPUClass {
> > >  #endif
> > >      const PPCHash64Options *hash64_opts;
> > >      struct ppc_radix_page_info *radix_page_info;
> > > +    uint32_t hdecr_bits;
> > >      void (*init_proc)(CPUPPCState *env);
> > >      int  (*check_pow)(CPUPPCState *env);
> > >      int (*handle_mmu_fault)(PowerPCCPU *cpu, vaddr eaddr, int rwx,
> > > int mmu_idx);
> > > diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> > > index 26604ddf98..8da333e9da 100644
> > > --- a/target/ppc/cpu.h
> > > +++ b/target/ppc/cpu.h
> > > @@ -1171,6 +1171,9 @@ struct CPUPPCState {
> > >      uint32_t tm_vscr;
> > >      uint64_t tm_dscr;
> > >      uint64_t tm_tar;
> > > +
> > > +    /* Large Decrementer */
> > > +    int large_decr_bits;
> > >  };
> > > =20
> > >  #define SET_FIT_PERIOD(a_, b_, c_, d_)          \
> > > @@ -1321,10 +1324,10 @@ uint32_t cpu_ppc_load_atbu (CPUPPCState
> > > *env);
> > >  void cpu_ppc_store_atbl (CPUPPCState *env, uint32_t value);
> > >  void cpu_ppc_store_atbu (CPUPPCState *env, uint32_t value);
> > >  bool ppc_decr_clear_on_delivery(CPUPPCState *env);
> > > -uint32_t cpu_ppc_load_decr (CPUPPCState *env);
> > > -void cpu_ppc_store_decr (CPUPPCState *env, uint32_t value);
> > > -uint32_t cpu_ppc_load_hdecr (CPUPPCState *env);
> > > -void cpu_ppc_store_hdecr (CPUPPCState *env, uint32_t value);
> > > +target_ulong cpu_ppc_load_decr (CPUPPCState *env);
> > > +void cpu_ppc_store_decr (CPUPPCState *env, target_ulong value);
> > > +target_ulong cpu_ppc_load_hdecr (CPUPPCState *env);
> > > +void cpu_ppc_store_hdecr (CPUPPCState *env, target_ulong value);
> > >  uint64_t cpu_ppc_load_purr (CPUPPCState *env);
> > >  uint32_t cpu_ppc601_load_rtcl (CPUPPCState *env);
> > >  uint32_t cpu_ppc601_load_rtcu (CPUPPCState *env);
> > > diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> > > index c431303eff..a2b1ec5040 100644
> > > --- a/target/ppc/mmu-hash64.c
> > > +++ b/target/ppc/mmu-hash64.c
> > > @@ -1109,7 +1109,7 @@ void ppc_store_lpcr(PowerPCCPU *cpu,
> > > target_ulong val)
> > >      case POWERPC_MMU_3_00: /* P9 */
> > >          lpcr =3D val & (LPCR_VPM1 | LPCR_ISL | LPCR_KBV | LPCR_DPFD
> > > |
> > >                        (LPCR_PECE_U_MASK & LPCR_HVEE) | LPCR_ILE |
> > > LPCR_AIL |
> > > -                      LPCR_UPRT | LPCR_EVIRT | LPCR_ONL | LPCR_HR
> > > |
> > > +                      LPCR_UPRT | LPCR_EVIRT | LPCR_ONL | LPCR_HR
> > > | LPCR_LD |
> > >                        (LPCR_PECE_L_MASK & (LPCR_PDEE | LPCR_HDEE |
> > > LPCR_EEE |
> > >                        LPCR_DEE | LPCR_OEE)) | LPCR_MER | LPCR_GTSE
> > > | LPCR_TC |
> > >                        LPCR_HEIC | LPCR_LPES0 | LPCR_HVICE |
> > > LPCR_HDICE);
> > > diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> > > index 819221f246..b156be4d98 100644
> > > --- a/target/ppc/translate.c
> > > +++ b/target/ppc/translate.c
> > > @@ -7417,7 +7417,7 @@ void ppc_cpu_dump_state(CPUState *cs, FILE
> > > *f, fprintf_function cpu_fprintf,
> > >  #if !defined(NO_TIMER_DUMP)
> > >      cpu_fprintf(f, "TB %08" PRIu32 " %08" PRIu64
> > >  #if !defined(CONFIG_USER_ONLY)
> > > -                " DECR %08" PRIu32
> > > +                " DECR " TARGET_FMT_lu
> > >  #endif
> > >                  "\n",
> > >                  cpu_ppc_load_tbu(env), cpu_ppc_load_tbl(env)
> > > diff --git a/target/ppc/translate_init.inc.c
> > > b/target/ppc/translate_init.inc.c
> > > index 58542c0fe0..4e0bf1f47a 100644
> > > --- a/target/ppc/translate_init.inc.c
> > > +++ b/target/ppc/translate_init.inc.c
> > > @@ -8926,6 +8926,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void
> > > *data)
> > >      /* segment page size remain the same */
> > >      pcc->hash64_opts =3D &ppc_hash64_opts_POWER7;
> > >      pcc->radix_page_info =3D &POWER9_radix_page_info;
> > > +    pcc->hdecr_bits =3D 56;
> > >  #endif
> > >      pcc->excp_model =3D POWERPC_EXCP_POWER9;
> > >      pcc->bus_model =3D PPC_FLAGS_INPUT_POWER9;
> >=20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--iJhwK4DKf9Unwzgv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx1ziQACgkQbDjKyiDZ
s5KxjBAAg/sFajMNXeyi7g6Ck7Ck4O1ou5YzCnRsAVT37J7HNgN6s7LXcBoYYZUb
Cv8ddhQxNHDEeTeCw/3t2oIaQKQxc+9Tr9uhvWkhlaKc9uqudXHc35CdKjCLEVim
zVyaxpWKA4yB1GanfypeNwAYs/4WQ2dwYQrpcfTQZ5moqjLPJhBD8h+5mnbq1+KS
Evw/HxWYYnHjrrL7JJ9ayms0vWOajvifR6xmeHWtJnlFNPFZRNqD7MMAXLPPyU24
WAUdZOz7IVGX5vhJ3EmbImrQwy05q5ewDJ8r0yURAI4ccFK8vfS7InpwMzUGN4yl
y2J/vcaiuRRgvur6op3ZI4wgAEa6H5eZsF+7gGR1/KETQWhnJrL/a2GwTNiJJDGT
KOY+Q2TgLoIvs8ZAyRjnsnjVrDs6WojUjYmfqLRNnD6WNYcDa7sEqAOEvyXUyH54
kBrZBwLpzk3IKaeKDZrt9N3yEEtfUDjf4powuYe1K+aM/I4RBJ+/OXfEm7wut7Ao
GN6a/VkW+L9pwzTVfrVsIxpLBQNQSoUWemS3wukmHCH7maRUhuQWDhyqLpsUOUq5
tvv5hRm06F9T9B8UxIVEygiAmIjNs9xwJKjdgsIceKLklNV5JtTH/014OWXl/3yJ
aD9I/q+Uue2Ca71MA8ciiLDVSLGxQdkfpjAT5PJdTnqsufMJ97E=
=NPvi
-----END PGP SIGNATURE-----

--iJhwK4DKf9Unwzgv--
