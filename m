Received: from eggs.gnu.org ([2001:4830:134:3::10]:37585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dehr1-0006Y3-QL
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 09:14:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dehqw-0005tq-76
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 09:13:55 -0400
Received: from 17.mo4.mail-out.ovh.net ([46.105.41.16]:53621)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dehqv-0005t6-TA
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 09:13:50 -0400
Received: from player694.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 16A928B999
	for <qemu-devel@nongnu.org>; Mon,  7 Aug 2017 15:13:48 +0200 (CEST)
Date: Mon, 7 Aug 2017 15:13:42 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170807151342.6e5a17a8@bahia.lan>
In-Reply-To: <2b5e13652c749b9ad2a519190396fe4160ac0dea.1502087564.git.sam.bobroff@au1.ibm.com>
References: <cover.1502087564.git.sam.bobroff@au1.ibm.com>
	<2b5e13652c749b9ad2a519190396fe4160ac0dea.1502087564.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/eqiBf6yCmTvA0O.1xVZyZ=N";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 1/1] ppc: spapr: Make VCPU ID
 handling private to SPAPR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

--Sig_/eqiBf6yCmTvA0O.1xVZyZ=N
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 7 Aug 2017 16:33:29 +1000
Sam Bobroff <sam.bobroff@au1.ibm.com> wrote:

> The concept of a VCPU ID that differs from the CPU's index
> (cpu->cpu_index) exists only within SPAPR machines so, move the
> functions ppc_get_vcpu_id() and ppc_get_cpu_by_vcpu_id() into spapr.c
> and rename them appropriately.
>=20
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> ---
> Changes in v2:
>=20
> * Re-arranged so that spapr_vcpu_id() calls kvm_arch_vcpu_id() rather tha=
n the
> other way around.
>=20

Better indeed! :)

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/ppc.c           | 21 ---------------------
>  hw/ppc/spapr.c         | 40 +++++++++++++++++++++++++++++++++-------
>  hw/ppc/spapr_hcall.c   |  4 ++--
>  hw/ppc/spapr_rtas.c    |  4 ++--
>  include/hw/ppc/spapr.h |  3 +++
>  target/ppc/cpu.h       | 18 ------------------
>  target/ppc/kvm.c       |  2 +-
>  7 files changed, 41 insertions(+), 51 deletions(-)
>=20
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index 4477d4ad89..f76886f4d3 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -1358,27 +1358,6 @@ void PPC_debug_write (void *opaque, uint32_t addr,=
 uint32_t val)
>      }
>  }
> =20
> -/* CPU device-tree ID helpers */
> -int ppc_get_vcpu_id(PowerPCCPU *cpu)
> -{
> -    return cpu->vcpu_id;
> -}
> -
> -PowerPCCPU *ppc_get_cpu_by_vcpu_id(int vcpu_id)
> -{
> -    CPUState *cs;
> -
> -    CPU_FOREACH(cs) {
> -        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> -
> -        if (cpu->vcpu_id =3D=3D vcpu_id) {
> -            return cpu;
> -        }
> -    }
> -
> -    return NULL;
> -}
> -
>  void ppc_cpu_parse_features(const char *cpu_model)
>  {
>      CPUClass *cc;
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index d6c9b3e334..d31e6d2c0d 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -208,7 +208,7 @@ static int spapr_fixup_cpu_smt_dt(void *fdt, int offs=
et, PowerPCCPU *cpu,
>      int i, ret =3D 0;
>      uint32_t servers_prop[smt_threads];
>      uint32_t gservers_prop[smt_threads * 2];
> -    int index =3D ppc_get_vcpu_id(cpu);
> +    int index =3D spapr_vcpu_id(cpu);
> =20
>      if (cpu->compat_pvr) {
>          ret =3D fdt_setprop_cell(fdt, offset, "cpu-version", cpu->compat=
_pvr);
> @@ -237,7 +237,7 @@ static int spapr_fixup_cpu_smt_dt(void *fdt, int offs=
et, PowerPCCPU *cpu,
> =20
>  static int spapr_fixup_cpu_numa_dt(void *fdt, int offset, PowerPCCPU *cp=
u)
>  {
> -    int index =3D ppc_get_vcpu_id(cpu);
> +    int index =3D spapr_vcpu_id(cpu);
>      uint32_t associativity[] =3D {cpu_to_be32(0x5),
>                                  cpu_to_be32(0x0),
>                                  cpu_to_be32(0x0),
> @@ -341,7 +341,7 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachine=
State *spapr)
>          PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>          CPUPPCState *env =3D &cpu->env;
>          DeviceClass *dc =3D DEVICE_GET_CLASS(cs);
> -        int index =3D ppc_get_vcpu_id(cpu);
> +        int index =3D spapr_vcpu_id(cpu);
>          int compat_smt =3D MIN(smp_threads, ppc_compat_max_threads(cpu));
> =20
>          if ((index % smt) !=3D 0) {
> @@ -493,7 +493,7 @@ static void spapr_populate_cpu_dt(CPUState *cs, void =
*fdt, int offset,
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>      CPUPPCState *env =3D &cpu->env;
>      PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cs);
> -    int index =3D ppc_get_vcpu_id(cpu);
> +    int index =3D spapr_vcpu_id(cpu);
>      uint32_t segs[] =3D {cpu_to_be32(28), cpu_to_be32(40),
>                         0xffffffff, 0xffffffff};
>      uint32_t tbfreq =3D kvm_enabled() ? kvmppc_get_tbfreq()
> @@ -626,7 +626,7 @@ static void spapr_populate_cpus_dt_node(void *fdt, sP=
APRMachineState *spapr)
>       */
>      CPU_FOREACH_REVERSE(cs) {
>          PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> -        int index =3D ppc_get_vcpu_id(cpu);
> +        int index =3D spapr_vcpu_id(cpu);
>          DeviceClass *dc =3D DEVICE_GET_CLASS(cs);
>          int offset;
> =20
> @@ -2982,7 +2982,7 @@ static void *spapr_populate_hotplug_cpu_dt(CPUState=
 *cs, int *fdt_offset,
>  {
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>      DeviceClass *dc =3D DEVICE_GET_CLASS(cs);
> -    int id =3D ppc_get_vcpu_id(cpu);
> +    int id =3D spapr_vcpu_id(cpu);
>      void *fdt;
>      int offset, fdt_size;
>      char *nodename;
> @@ -3392,7 +3392,7 @@ static void spapr_ics_resend(XICSFabric *dev)
> =20
>  static ICPState *spapr_icp_get(XICSFabric *xi, int vcpu_id)
>  {
> -    PowerPCCPU *cpu =3D ppc_get_cpu_by_vcpu_id(vcpu_id);
> +    PowerPCCPU *cpu =3D spapr_find_cpu(vcpu_id);
> =20
>      return cpu ? ICP(cpu->intc) : NULL;
>  }
> @@ -3412,6 +3412,32 @@ static void spapr_pic_print_info(InterruptStatsPro=
vider *obj,
>      ics_pic_print_info(spapr->ics, mon);
>  }
> =20
> +int spapr_vcpu_id(PowerPCCPU *cpu)
> +{
> +    CPUState *cs =3D CPU(cpu);
> +
> +    if (kvm_enabled()) {
> +        return kvm_arch_vcpu_id(cs);
> +    } else {
> +        return cs->cpu_index;
> +    }
> +}
> +
> +PowerPCCPU *spapr_find_cpu(int vcpu_id)
> +{
> +    CPUState *cs;
> +
> +    CPU_FOREACH(cs) {
> +        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +
> +        if (cpu->vcpu_id =3D=3D vcpu_id) {
> +            return cpu;
> +        }
> +    }
> +
> +    return NULL;
> +}
> +
>  static void spapr_machine_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 4ca233854a..7cf0993800 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -999,7 +999,7 @@ static target_ulong h_register_vpa(PowerPCCPU *cpu, s=
PAPRMachineState *spapr,
>      CPUPPCState *tenv;
>      PowerPCCPU *tcpu;
> =20
> -    tcpu =3D ppc_get_cpu_by_vcpu_id(procno);
> +    tcpu =3D spapr_find_cpu(procno);
>      if (!tcpu) {
>          return H_PARAMETER;
>      }
> @@ -1431,7 +1431,7 @@ static target_ulong h_signal_sys_reset(PowerPCCPU *=
cpu,
> =20
>      } else {
>          /* Unicast */
> -        cs =3D CPU(ppc_get_cpu_by_vcpu_id(target));
> +        cs =3D CPU(spapr_find_cpu(target));
>          if (cs) {
>              run_on_cpu(cs, spapr_do_system_reset_on_cpu, RUN_ON_CPU_NULL=
);
>              return H_SUCCESS;
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 626c06b375..cdf0b607a0 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -104,7 +104,7 @@ static void rtas_query_cpu_stopped_state(PowerPCCPU *=
cpu_,
>      }
> =20
>      id =3D rtas_ld(args, 0);
> -    cpu =3D ppc_get_cpu_by_vcpu_id(id);
> +    cpu =3D spapr_find_cpu(id);
>      if (cpu !=3D NULL) {
>          if (CPU(cpu)->halted) {
>              rtas_st(rets, 1, 0);
> @@ -158,7 +158,7 @@ static void rtas_start_cpu(PowerPCCPU *cpu_, sPAPRMac=
hineState *spapr,
>      start =3D rtas_ld(args, 1);
>      r3 =3D rtas_ld(args, 2);
> =20
> -    cpu =3D ppc_get_cpu_by_vcpu_id(id);
> +    cpu =3D spapr_find_cpu(id);
>      if (cpu !=3D NULL) {
>          CPUState *cs =3D CPU(cpu);
>          CPUPPCState *env =3D &cpu->env;
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 2a303a705c..86c982cf2c 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -704,4 +704,7 @@ void spapr_do_system_reset_on_cpu(CPUState *cs, run_o=
n_cpu_data arg);
> =20
>  #define HTAB_SIZE(spapr)        (1ULL << ((spapr)->htab_shift))
> =20
> +int spapr_vcpu_id(PowerPCCPU *cpu);
> +PowerPCCPU *spapr_find_cpu(int vcpu_id);
> +
>  #endif /* HW_SPAPR_H */
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 2a3594dea5..abc729f029 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -2513,23 +2513,5 @@ static inline bool lsw_reg_in_range(int start, int=
 nregs, int rx)
> =20
>  void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUPPCState *env);
> =20
> -/**
> - * ppc_get_vcpu_id:
> - * @cs: a PowerPCCPU struct.
> - *
> - * Returns a device-tree ID for a CPU.
> - */
> -int ppc_get_vcpu_id(PowerPCCPU *cpu);
> -
> -/**
> - * ppc_get_cpu_by_vcpu_id:
> - * @vcpu_id: a VCPU ID
> - *
> - * Searches for a CPU by @vcpu_id.
> - *
> - * Returns: a PowerPCCPU struct
> - */
> -PowerPCCPU *ppc_get_cpu_by_vcpu_id(int vcpu_id);
> -
>  void ppc_maybe_bswap_register(CPUPPCState *env, uint8_t *mem_buf, int le=
n);
>  #endif /* PPC_CPU_H */
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 7ccb350c5f..5b2abee4da 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -512,7 +512,7 @@ bool kvmppc_is_mem_backend_page_size_ok(const char *o=
bj_path)
> =20
>  unsigned long kvm_arch_vcpu_id(CPUState *cpu)
>  {
> -    return ppc_get_vcpu_id(POWERPC_CPU(cpu));
> +    return POWERPC_CPU(cpu)->vcpu_id;
>  }
> =20
>  /* e500 supports 2 h/w breakpoint and 2 watchpoint.


--Sig_/eqiBf6yCmTvA0O.1xVZyZ=N
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlmIZ4cACgkQAvw66wEB28IACQCfaNxcGbMxM0D1AItyVBUHgSJ8
Q64AoICJqXd+w/6qFebKwAE0AwmLxMcS
=3D6s
-----END PGP SIGNATURE-----

--Sig_/eqiBf6yCmTvA0O.1xVZyZ=N--
