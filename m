Received: from eggs.gnu.org ([2001:4830:134:3::10]:42666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ddG2Y-0002HL-Ro
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:19:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ddG2U-0004kM-6F
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:19:50 -0400
Received: from 3.mo7.mail-out.ovh.net ([46.105.34.113]:41378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ddG2T-0004jE-SF
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:19:46 -0400
Received: from player788.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 97E856711D
	for <qemu-devel@nongnu.org>; Thu,  3 Aug 2017 15:19:44 +0200 (CEST)
Date: Thu, 3 Aug 2017 15:19:40 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170803151940.03c4e557@bahia.lan>
In-Reply-To: <5777ef503c5c7f43f21981ed11c90fb7579ccfae.1501740002.git.sam.bobroff@au1.ibm.com>
References: <cover.1501740002.git.sam.bobroff@au1.ibm.com>
	<5777ef503c5c7f43f21981ed11c90fb7579ccfae.1501740002.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/=X1i5WD29TCud6sOrVzZujX";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 3/4] ppc: spapr: Rename
 cpu_dt_id to vcpu_id
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

--Sig_/=X1i5WD29TCud6sOrVzZujX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 3 Aug 2017 16:28:44 +1000
Sam Bobroff <sam.bobroff@au1.ibm.com> wrote:

> This field actually records the VCPU ID used by KVM and, although the
> value is also used in the device tree it is primarily the VCPU ID so
> rename it as such.
>=20
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> ---

With this patch applied, I still have:

$ git grep cpu_dt_id
target/ppc/cpu.h: * @cpu_dt_id: CPU index used in the device tree. KVM uses=
 this index too

With that fixed,

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/ppc.c                |  8 ++++----
>  hw/ppc/spapr.c              | 16 ++++++++--------
>  hw/ppc/spapr_hcall.c        |  4 ++--
>  hw/ppc/spapr_rtas.c         |  4 ++--
>  target/ppc/cpu.h            | 14 +++++++-------
>  target/ppc/kvm.c            |  2 +-
>  target/ppc/translate_init.c |  8 ++++----
>  7 files changed, 28 insertions(+), 28 deletions(-)
>=20
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index 224184d66d..4477d4ad89 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -1359,19 +1359,19 @@ void PPC_debug_write (void *opaque, uint32_t addr=
, uint32_t val)
>  }
> =20
>  /* CPU device-tree ID helpers */
> -int ppc_get_vcpu_dt_id(PowerPCCPU *cpu)
> +int ppc_get_vcpu_id(PowerPCCPU *cpu)
>  {
> -    return cpu->cpu_dt_id;
> +    return cpu->vcpu_id;
>  }
> =20
> -PowerPCCPU *ppc_get_vcpu_by_dt_id(int cpu_dt_id)
> +PowerPCCPU *ppc_get_cpu_by_vcpu_id(int vcpu_id)
>  {
>      CPUState *cs;
> =20
>      CPU_FOREACH(cs) {
>          PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> =20
> -        if (cpu->cpu_dt_id =3D=3D cpu_dt_id) {
> +        if (cpu->vcpu_id =3D=3D vcpu_id) {
>              return cpu;
>          }
>      }
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index f7a19720dc..83c77096a6 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -208,7 +208,7 @@ static int spapr_fixup_cpu_smt_dt(void *fdt, int offs=
et, PowerPCCPU *cpu,
>      int i, ret =3D 0;
>      uint32_t servers_prop[smt_threads];
>      uint32_t gservers_prop[smt_threads * 2];
> -    int index =3D ppc_get_vcpu_dt_id(cpu);
> +    int index =3D ppc_get_vcpu_id(cpu);
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
> -    int index =3D ppc_get_vcpu_dt_id(cpu);
> +    int index =3D ppc_get_vcpu_id(cpu);
>      uint32_t associativity[] =3D {cpu_to_be32(0x5),
>                                  cpu_to_be32(0x0),
>                                  cpu_to_be32(0x0),
> @@ -341,7 +341,7 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachine=
State *spapr)
>          PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>          CPUPPCState *env =3D &cpu->env;
>          DeviceClass *dc =3D DEVICE_GET_CLASS(cs);
> -        int index =3D ppc_get_vcpu_dt_id(cpu);
> +        int index =3D ppc_get_vcpu_id(cpu);
>          int compat_smt =3D MIN(smp_threads, ppc_compat_max_threads(cpu));
> =20
>          if ((index % smt) !=3D 0) {
> @@ -493,7 +493,7 @@ static void spapr_populate_cpu_dt(CPUState *cs, void =
*fdt, int offset,
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>      CPUPPCState *env =3D &cpu->env;
>      PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cs);
> -    int index =3D ppc_get_vcpu_dt_id(cpu);
> +    int index =3D ppc_get_vcpu_id(cpu);
>      uint32_t segs[] =3D {cpu_to_be32(28), cpu_to_be32(40),
>                         0xffffffff, 0xffffffff};
>      uint32_t tbfreq =3D kvm_enabled() ? kvmppc_get_tbfreq()
> @@ -626,7 +626,7 @@ static void spapr_populate_cpus_dt_node(void *fdt, sP=
APRMachineState *spapr)
>       */
>      CPU_FOREACH_REVERSE(cs) {
>          PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> -        int index =3D ppc_get_vcpu_dt_id(cpu);
> +        int index =3D ppc_get_vcpu_id(cpu);
>          DeviceClass *dc =3D DEVICE_GET_CLASS(cs);
>          int offset;
> =20
> @@ -2982,7 +2982,7 @@ static void *spapr_populate_hotplug_cpu_dt(CPUState=
 *cs, int *fdt_offset,
>  {
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>      DeviceClass *dc =3D DEVICE_GET_CLASS(cs);
> -    int id =3D ppc_get_vcpu_dt_id(cpu);
> +    int id =3D ppc_get_vcpu_id(cpu);
>      void *fdt;
>      int offset, fdt_size;
>      char *nodename;
> @@ -3390,9 +3390,9 @@ static void spapr_ics_resend(XICSFabric *dev)
>      ics_resend(spapr->ics);
>  }
> =20
> -static ICPState *spapr_icp_get(XICSFabric *xi, int cpu_dt_id)
> +static ICPState *spapr_icp_get(XICSFabric *xi, int vcpu_id)
>  {
> -    PowerPCCPU *cpu =3D ppc_get_vcpu_by_dt_id(cpu_dt_id);
> +    PowerPCCPU *cpu =3D ppc_get_cpu_by_vcpu_id(vcpu_id);
> =20
>      return cpu ? ICP(cpu->intc) : NULL;
>  }
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 07b3da8dc4..4ca233854a 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -999,7 +999,7 @@ static target_ulong h_register_vpa(PowerPCCPU *cpu, s=
PAPRMachineState *spapr,
>      CPUPPCState *tenv;
>      PowerPCCPU *tcpu;
> =20
> -    tcpu =3D ppc_get_vcpu_by_dt_id(procno);
> +    tcpu =3D ppc_get_cpu_by_vcpu_id(procno);
>      if (!tcpu) {
>          return H_PARAMETER;
>      }
> @@ -1431,7 +1431,7 @@ static target_ulong h_signal_sys_reset(PowerPCCPU *=
cpu,
> =20
>      } else {
>          /* Unicast */
> -        cs =3D CPU(ppc_get_vcpu_by_dt_id(target));
> +        cs =3D CPU(ppc_get_cpu_by_vcpu_id(target));
>          if (cs) {
>              run_on_cpu(cs, spapr_do_system_reset_on_cpu, RUN_ON_CPU_NULL=
);
>              return H_SUCCESS;
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 94a2799b99..626c06b375 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -104,7 +104,7 @@ static void rtas_query_cpu_stopped_state(PowerPCCPU *=
cpu_,
>      }
> =20
>      id =3D rtas_ld(args, 0);
> -    cpu =3D ppc_get_vcpu_by_dt_id(id);
> +    cpu =3D ppc_get_cpu_by_vcpu_id(id);
>      if (cpu !=3D NULL) {
>          if (CPU(cpu)->halted) {
>              rtas_st(rets, 1, 0);
> @@ -158,7 +158,7 @@ static void rtas_start_cpu(PowerPCCPU *cpu_, sPAPRMac=
hineState *spapr,
>      start =3D rtas_ld(args, 1);
>      r3 =3D rtas_ld(args, 2);
> =20
> -    cpu =3D ppc_get_vcpu_by_dt_id(id);
> +    cpu =3D ppc_get_cpu_by_vcpu_id(id);
>      if (cpu !=3D NULL) {
>          CPUState *cs =3D CPU(cpu);
>          CPUPPCState *env =3D &cpu->env;
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 6ee2a26a96..89f05542c6 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1199,7 +1199,7 @@ struct PowerPCCPU {
>      /*< public >*/
> =20
>      CPUPPCState env;
> -    int cpu_dt_id;
> +    int vcpu_id;
>      uint32_t compat_pvr;
>      PPCVirtualHypervisor *vhyp;
>      Object *intc;
> @@ -2514,22 +2514,22 @@ static inline bool lsw_reg_in_range(int start, in=
t nregs, int rx)
>  void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUPPCState *env);
> =20
>  /**
> - * ppc_get_vcpu_dt_id:
> + * ppc_get_vcpu_id:
>   * @cs: a PowerPCCPU struct.
>   *
>   * Returns a device-tree ID for a CPU.
>   */
> -int ppc_get_vcpu_dt_id(PowerPCCPU *cpu);
> +int ppc_get_vcpu_id(PowerPCCPU *cpu);
> =20
>  /**
> - * ppc_get_vcpu_by_dt_id:
> - * @cpu_dt_id: a device tree id
> + * ppc_get_cpu_by_vcpu_id:
> + * @vcpu_id: a VCPU ID
>   *
> - * Searches for a CPU by @cpu_dt_id.
> + * Searches for a CPU by @vcpu_id.
>   *
>   * Returns: a PowerPCCPU struct
>   */
> -PowerPCCPU *ppc_get_vcpu_by_dt_id(int cpu_dt_id);
> +PowerPCCPU *ppc_get_cpu_by_vcpu_id(int vcpu_id);
> =20
>  void ppc_maybe_bswap_register(CPUPPCState *env, uint8_t *mem_buf, int le=
n);
>  #endif /* PPC_CPU_H */
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 85713795de..7ccb350c5f 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -512,7 +512,7 @@ bool kvmppc_is_mem_backend_page_size_ok(const char *o=
bj_path)
> =20
>  unsigned long kvm_arch_vcpu_id(CPUState *cpu)
>  {
> -    return ppc_get_vcpu_dt_id(POWERPC_CPU(cpu));
> +    return ppc_get_vcpu_id(POWERPC_CPU(cpu));
>  }
> =20
>  /* e500 supports 2 h/w breakpoint and 2 watchpoint.
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index 01723bdfec..a80e9ffdf8 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -9828,14 +9828,14 @@ static void ppc_cpu_realizefn(DeviceState *dev, E=
rror **errp)
>      }
> =20
>  #if !defined(CONFIG_USER_ONLY)
> -    cpu->cpu_dt_id =3D (cs->cpu_index / smp_threads) * max_smt
> +    cpu->vcpu_id =3D (cs->cpu_index / smp_threads) * max_smt
>          + (cs->cpu_index % smp_threads);
> =20
> -    if (kvm_enabled() && !kvm_vcpu_id_is_valid(cpu->cpu_dt_id)) {
> -        error_setg(errp, "Can't create CPU with id %d in KVM", cpu->cpu_=
dt_id);
> +    if (kvm_enabled() && !kvm_vcpu_id_is_valid(cpu->vcpu_id)) {
> +        error_setg(errp, "Can't create CPU with id %d in KVM", cpu->vcpu=
_id);
>          error_append_hint(errp, "Adjust the number of cpus to %d "
>                            "or try to raise the number of threads per cor=
e\n",
> -                          cpu->cpu_dt_id * smp_threads / max_smt);
> +                          cpu->vcpu_id * smp_threads / max_smt);
>          goto unrealize;
>      }
>  #endif


--Sig_/=X1i5WD29TCud6sOrVzZujX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlmDIuwACgkQAvw66wEB28I0YgCfaPXUNBIHj5Yz5tqtNlUzn9XR
/TgAoKSI7DPfGu9vSPjVLmUuNXnAbZOG
=NNqf
-----END PGP SIGNATURE-----

--Sig_/=X1i5WD29TCud6sOrVzZujX--
