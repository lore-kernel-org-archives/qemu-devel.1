Received: from eggs.gnu.org ([2001:4830:134:3::10]:38781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ehcZP-0000nR-Fg
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:44:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ehcZL-0002cR-0r
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:44:03 -0500
Received: from 2.mo69.mail-out.ovh.net ([178.33.251.80]:35419)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ehcZK-0002Uj-NG
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:43:58 -0500
Received: from player699.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 3D3EA56C2B
	for <qemu-devel@nongnu.org>; Fri,  2 Feb 2018 15:43:49 +0100 (CET)
References: <20180131082749.1803-1-clg@kaod.org>
	<20180131082749.1803-2-clg@kaod.org>
	<1517538846.2332.14.camel@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <3fa95252-fab0-160d-73fd-b29356cc418c@kaod.org>
Date: Fri, 2 Feb 2018 15:43:43 +0100
MIME-Version: 1.0
In-Reply-To: <1517538846.2332.14.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] target/ppc: add basic support for PTCR
 on POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 02/02/2018 03:34 AM, Suraj Jitindar Singh wrote:
> On Wed, 2018-01-31 at 09:27 +0100, C=C3=A9dric Le Goater wrote:
>> The Partition Table Control Register (PTCR) is a hypervisor
>> privileged
>> SPR. It contains the host real address of the Partition Table and its
>> size.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>  target/ppc/cpu.h            |  2 ++
>>  target/ppc/helper.h         |  1 +
>>  target/ppc/misc_helper.c    | 12 ++++++++++++
>>  target/ppc/mmu-hash64.h     |  6 ++++++
>>  target/ppc/mmu_helper.c     | 28 ++++++++++++++++++++++++++++
>>  target/ppc/translate.c      |  3 +++
>>  target/ppc/translate_init.c | 18 ++++++++++++++++++
>>  7 files changed, 70 insertions(+)
>>
>> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
>> index 9f8cbbe7aa4d..53061229a0a8 100644
>> --- a/target/ppc/cpu.h
>> +++ b/target/ppc/cpu.h
>> @@ -1314,6 +1314,7 @@ int ppc_cpu_handle_mmu_fault(CPUState *cpu,
>> vaddr address, int size, int rw,
>> =20
>>  #if !defined(CONFIG_USER_ONLY)
>>  void ppc_store_sdr1 (CPUPPCState *env, target_ulong value);
>> +void ppc_store_ptcr(CPUPPCState *env, target_ulong value);
>>  #endif /* !defined(CONFIG_USER_ONLY) */
>>  void ppc_store_msr (CPUPPCState *env, target_ulong value);
>> =20
>> @@ -1605,6 +1606,7 @@ void ppc_compat_add_property(Object *obj, const
>> char *name,
>>  #define SPR_BOOKE_GIVOR13     (0x1BC)
>>  #define SPR_BOOKE_GIVOR14     (0x1BD)
>>  #define SPR_TIR               (0x1BE)
>> +#define SPR_PTCR              (0x1D0)
>>  #define SPR_BOOKE_SPEFSCR     (0x200)
>>  #define SPR_Exxx_BBEAR        (0x201)
>>  #define SPR_Exxx_BBTAR        (0x202)
>> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
>> index 5b739179b8b5..19453c68138a 100644
>> --- a/target/ppc/helper.h
>> +++ b/target/ppc/helper.h
>> @@ -709,6 +709,7 @@ DEF_HELPER_FLAGS_1(load_601_rtcu,
>> TCG_CALL_NO_RWG, tl, env)
>>  #if !defined(CONFIG_USER_ONLY)
>>  #if defined(TARGET_PPC64)
>>  DEF_HELPER_FLAGS_1(load_purr, TCG_CALL_NO_RWG, tl, env)
>> +DEF_HELPER_2(store_ptcr, void, env, tl)
>>  #endif
>>  DEF_HELPER_2(store_sdr1, void, env, tl)
>>  DEF_HELPER_2(store_pidr, void, env, tl)
>> diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
>> index 0e4217821b8e..8c8cba5cc6f1 100644
>> --- a/target/ppc/misc_helper.c
>> +++ b/target/ppc/misc_helper.c
>> @@ -88,6 +88,18 @@ void helper_store_sdr1(CPUPPCState *env,
>> target_ulong val)
>>      }
>>  }
>> =20
>> +#if defined(TARGET_PPC64)
>> +void helper_store_ptcr(CPUPPCState *env, target_ulong val)
>> +{
>> +    PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
>> +
>> +    if (env->spr[SPR_PTCR] !=3D val) {
>> +        ppc_store_ptcr(env, val);
>> +        tlb_flush(CPU(cpu));
>> +    }
>> +}
>> +#endif /* defined(TARGET_PPC64) */
>> +
>>  void helper_store_pidr(CPUPPCState *env, target_ulong val)
>>  {
>>      PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
>> diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
>> index d297b97d3773..4fb00ac17abb 100644
>> --- a/target/ppc/mmu-hash64.h
>> +++ b/target/ppc/mmu-hash64.h
>> @@ -98,6 +98,12 @@ void ppc_hash64_update_rmls(CPUPPCState *env);
>>  #define HPTE64_V_1TB_SEG        0x4000000000000000ULL
>>  #define HPTE64_V_VRMA_MASK      0x4001ffffff000000ULL
>> =20
>> +/*
>> + * Partition table definitions
>> + */
>> +#define PTCR_PTAB               0x0FFFFFFFFFFFF000ULL /* Partition
>> Table Base */
>> +#define PTCR_PTAS               0x000000000000001FULL /* Partition
>> Table Size */
>> +
>=20
> s/PTCR_PTAB/PTCR_PATB
> s/PTCR_PTAS/PTCR_PATS
> To match the ISA?

yes. My bad.

>>  static inline hwaddr ppc_hash64_hpt_base(PowerPCCPU *cpu)
>>  {
>>      return cpu->env.spr[SPR_SDR1] & SDR_64_HTABORG;
>> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
>> index 16ef5acaa28f..b1e660a4d16a 100644
>> --- a/target/ppc/mmu_helper.c
>> +++ b/target/ppc/mmu_helper.c
>> @@ -2029,6 +2029,34 @@ void ppc_store_sdr1(CPUPPCState *env,
>> target_ulong value)
>>      env->spr[SPR_SDR1] =3D value;
>>  }
>> =20
>> +#if defined(TARGET_PPC64)
>> +void ppc_store_ptcr(CPUPPCState *env, target_ulong value)
>> +{
>> +    PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
>> +    qemu_log_mask(CPU_LOG_MMU, "%s: " TARGET_FMT_lx "\n", __func__,
>> value);
>> +
>> +    assert(!cpu->vhyp);
>> +
>> +    if (env->mmu_model & POWERPC_MMU_V3) {
>> +        target_ulong ptcr_mask =3D PTCR_PTAB | PTCR_PTAS;
>> +        target_ulong ptas =3D value & PTCR_PTAS;
>> +
>> +        if (value & ~ptcr_mask) {
>> +            error_report("Invalid bits 0x"TARGET_FMT_lx" set in
>> PTCR",
>> +                         value & ~ptcr_mask);
>> +            value &=3D ptcr_mask;
>> +        }
>> +        if (ptas > 28) {
>> +            error_report("Invalid PTAS 0x" TARGET_FMT_lx" stored in
>> PTCR",
>> +                         ptas);
>> +            return;
>> +        }
>> +    }
>=20
> Should we throw some error if the ptcr is being accessed on a non-
> power9 machine?

The SPR is only added for POWER9 processor. We should be fine.

Thanks,

C.=20

>=20
>> +    env->spr[SPR_PTCR] =3D value;
>> +}
>> +
>> +#endif /* defined(TARGET_PPC64) */
>> +
>>  /* Segment registers load and store */
>>  target_ulong helper_load_sr(CPUPPCState *env, target_ulong sr_num)
>>  {
>> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
>> index 4132f67bb1f7..c2e6e3072799 100644
>> --- a/target/ppc/translate.c
>> +++ b/target/ppc/translate.c
>> @@ -7130,6 +7130,9 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f,
>> fprintf_function cpu_fprintf,
>>          if (env->spr_cb[SPR_SDR1].name) { /* SDR1 Exists */
>>              cpu_fprintf(f, " SDR1 " TARGET_FMT_lx " ", env-
>>> spr[SPR_SDR1]);
>>          }
>> +        if (env->spr_cb[SPR_PTCR].name) { /* PTCR Exists */
>> +            cpu_fprintf(f, " PTCR " TARGET_FMT_lx " ", env-
>>> spr[SPR_PTCR]);
>> +        }
>>          cpu_fprintf(f, "  DAR " TARGET_FMT_lx "  DSISR "
>> TARGET_FMT_lx "\n",
>>                      env->spr[SPR_DAR], env->spr[SPR_DSISR]);
>>          break;
>> diff --git a/target/ppc/translate_init.c
>> b/target/ppc/translate_init.c
>> index 55c99c97e377..a6eaa74244ca 100644
>> --- a/target/ppc/translate_init.c
>> +++ b/target/ppc/translate_init.c
>> @@ -417,6 +417,11 @@ static void spr_write_hior(DisasContext *ctx,
>> int sprn, int gprn)
>>      tcg_gen_st_tl(t0, cpu_env, offsetof(CPUPPCState, excp_prefix));
>>      tcg_temp_free(t0);
>>  }
>> +static void spr_write_ptcr(DisasContext *ctx, int sprn, int gprn)
>> +{
>> +    gen_helper_store_ptcr(cpu_env, cpu_gpr[gprn]);
>> +}
>> +
>>  #endif
>>  #endif
>> =20
>> @@ -8164,6 +8169,18 @@ static void gen_spr_power8_rpr(CPUPPCState
>> *env)
>>  #endif
>>  }
>> =20
>> +/* Page Table */
>> +static void gen_spr_power9_ptcr(CPUPPCState *env)
>> +{
>> +#if !defined(CONFIG_USER_ONLY)
>> +    spr_register_hv(env, SPR_PTCR, "PTCR",
>> +                    SPR_NOACCESS, SPR_NOACCESS,
>> +                    SPR_NOACCESS, SPR_NOACCESS,
>> +                    &spr_read_generic, &spr_write_ptcr,
>> +                    0x00000000);
>> +#endif
>> +}
>> +
>>  static void init_proc_book3s_common(CPUPPCState *env)
>>  {
>>      gen_spr_ne_601(env);
>> @@ -8756,6 +8773,7 @@ static void init_proc_POWER9(CPUPPCState *env)
>>      gen_spr_power8_ic(env);
>>      gen_spr_power8_book4(env);
>>      gen_spr_power8_rpr(env);
>> +    gen_spr_power9_ptcr(env);
>> =20
>>      /* POWER9 Specific registers */
>>      spr_register_kvm(env, SPR_TIDR, "TIDR", NULL, NULL,
