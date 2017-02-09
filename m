Received: from eggs.gnu.org ([2001:4830:134:3::10]:37798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbyUJ-000064-Q2
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 18:50:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbyUH-0005Z3-Uu
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 18:50:55 -0500
Date: Fri, 10 Feb 2017 10:20:21 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170209232021.GB27610@umbus.fritz.box>
References: <1486638518-171446-1-git-send-email-imammedo@redhat.com>
	<1486638518-171446-2-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Content-Disposition: inline
In-Reply-To: <1486638518-171446-2-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/7] machine: move possible_cpus to
 MachineState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, ehabkost@redhat.com, drjones@redhat.com, Marcel Apfelbaum <marcel@redhat.com>


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 09, 2017 at 12:08:32PM +0100, Igor Mammedov wrote:
> so that it would be possible to reuse it with
> spapr/virt-aarch64 targets.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/hw/boards.h  |  1 +
>  include/hw/i386/pc.h |  1 -
>  hw/i386/pc.c         | 57 ++++++++++++++++++++++++++--------------------=
------
>  3 files changed, 30 insertions(+), 29 deletions(-)
>=20
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index ac891a8..64e8c07 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -178,6 +178,7 @@ struct MachineState {
>      char *initrd_filename;
>      const char *cpu_model;
>      AccelState *accelerator;
> +    CPUArchIdList *possible_cpus;
>  };
> =20
>  #define DEFINE_MACHINE(namestr, machine_initfn) \
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 079e8d9..d1f4554 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -73,7 +73,6 @@ struct PCMachineState {
>      /* CPU and apic information: */
>      bool apic_xrupt_override;
>      unsigned apic_id_limit;
> -    CPUArchIdList *possible_cpus;
>      uint16_t boot_cpus;
> =20
>      /* NUMA information: */
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index e3fcd51..cf2bec4 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -707,7 +707,8 @@ static void pc_build_smbios(PCMachineState *pcms)
>      size_t smbios_tables_len, smbios_anchor_len;
>      struct smbios_phys_mem_area *mem_array;
>      unsigned i, array_count;
> -    X86CPU *cpu =3D X86_CPU(pcms->possible_cpus->cpus[0].cpu);
> +    MachineState *ms =3D MACHINE(pcms);
> +    X86CPU *cpu =3D X86_CPU(ms->possible_cpus->cpus[0].cpu);
> =20
>      /* tell smbios about cpuid version and features */
>      smbios_set_cpuid(cpu->env.cpuid_version, cpu->env.features[FEAT_1_ED=
X]);
> @@ -1111,7 +1112,7 @@ static void pc_new_cpu(const char *typename, int64_=
t apic_id, Error **errp)
>  void pc_hot_add_cpu(const int64_t id, Error **errp)
>  {
>      ObjectClass *oc;
> -    PCMachineState *pcms =3D PC_MACHINE(qdev_get_machine());
> +    MachineState *ms =3D MACHINE(qdev_get_machine());
>      int64_t apic_id =3D x86_cpu_apic_id_from_index(id);
>      Error *local_err =3D NULL;
> =20
> @@ -1127,8 +1128,8 @@ void pc_hot_add_cpu(const int64_t id, Error **errp)
>          return;
>      }
> =20
> -    assert(pcms->possible_cpus->cpus[0].cpu); /* BSP is always present */
> -    oc =3D OBJECT_CLASS(CPU_GET_CLASS(pcms->possible_cpus->cpus[0].cpu));
> +    assert(ms->possible_cpus->cpus[0].cpu); /* BSP is always present */
> +    oc =3D OBJECT_CLASS(CPU_GET_CLASS(ms->possible_cpus->cpus[0].cpu));
>      pc_new_cpu(object_class_get_name(oc), apic_id, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
> @@ -1178,11 +1179,11 @@ void pc_cpus_init(PCMachineState *pcms)
>       * This is used for FW_CFG_MAX_CPUS. See comments on bochs_bios_init=
().
>       */
>      pcms->apic_id_limit =3D x86_cpu_apic_id_from_index(max_cpus - 1) + 1;
> -    pcms->possible_cpus =3D g_malloc0(sizeof(CPUArchIdList) +
> -                                    sizeof(CPUArchId) * max_cpus);
> +    machine->possible_cpus =3D g_malloc0(sizeof(CPUArchIdList) +
> +                                       sizeof(CPUArchId) * max_cpus);
>      for (i =3D 0; i < max_cpus; i++) {
> -        pcms->possible_cpus->cpus[i].arch_id =3D x86_cpu_apic_id_from_in=
dex(i);
> -        pcms->possible_cpus->len++;
> +        machine->possible_cpus->cpus[i].arch_id =3D x86_cpu_apic_id_from=
_index(i);
> +        machine->possible_cpus->len++;
>          if (i < smp_cpus) {
>              pc_new_cpu(typename, x86_cpu_apic_id_from_index(i), &error_f=
atal);
>          }
> @@ -1191,7 +1192,8 @@ void pc_cpus_init(PCMachineState *pcms)
> =20
>  static void pc_build_feature_control_file(PCMachineState *pcms)
>  {
> -    X86CPU *cpu =3D X86_CPU(pcms->possible_cpus->cpus[0].cpu);
> +    MachineState *ms =3D MACHINE(pcms);
> +    X86CPU *cpu =3D X86_CPU(ms->possible_cpus->cpus[0].cpu);
>      CPUX86State *env =3D &cpu->env;
>      uint32_t unused, ecx, edx;
>      uint64_t feature_control_bits =3D 0;
> @@ -1781,21 +1783,20 @@ static int pc_apic_cmp(const void *a, const void =
*b)
>  }
> =20
>  /* returns pointer to CPUArchId descriptor that matches CPU's apic_id
> - * in pcms->possible_cpus->cpus, if pcms->possible_cpus->cpus has no
> + * in ms->possible_cpus->cpus, if ms->possible_cpus->cpus has no
>   * entry corresponding to CPU's apic_id returns NULL.
>   */
> -static CPUArchId *pc_find_cpu_slot(PCMachineState *pcms, CPUState *cpu,
> -                                   int *idx)
> +static CPUArchId *pc_find_cpu_slot(MachineState *ms, CPUState *cpu, int =
*idx)
>  {
>      CPUClass *cc =3D CPU_GET_CLASS(cpu);
>      CPUArchId apic_id, *found_cpu;
> =20
>      apic_id.arch_id =3D cc->get_arch_id(CPU(cpu));
> -    found_cpu =3D bsearch(&apic_id, pcms->possible_cpus->cpus,
> -        pcms->possible_cpus->len, sizeof(*pcms->possible_cpus->cpus),
> +    found_cpu =3D bsearch(&apic_id, ms->possible_cpus->cpus,
> +        ms->possible_cpus->len, sizeof(*ms->possible_cpus->cpus),
>          pc_apic_cmp);
>      if (found_cpu && idx) {
> -        *idx =3D found_cpu - pcms->possible_cpus->cpus;
> +        *idx =3D found_cpu - ms->possible_cpus->cpus;
>      }
>      return found_cpu;
>  }
> @@ -1825,7 +1826,7 @@ static void pc_cpu_plug(HotplugHandler *hotplug_dev,
>          fw_cfg_modify_i16(pcms->fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
>      }
> =20
> -    found_cpu =3D pc_find_cpu_slot(pcms, CPU(dev), NULL);
> +    found_cpu =3D pc_find_cpu_slot(MACHINE(pcms), CPU(dev), NULL);
>      found_cpu->cpu =3D CPU(dev);
>  out:
>      error_propagate(errp, local_err);
> @@ -1838,7 +1839,7 @@ static void pc_cpu_unplug_request_cb(HotplugHandler=
 *hotplug_dev,
>      Error *local_err =3D NULL;
>      PCMachineState *pcms =3D PC_MACHINE(hotplug_dev);
> =20
> -    pc_find_cpu_slot(pcms, CPU(dev), &idx);
> +    pc_find_cpu_slot(MACHINE(pcms), CPU(dev), &idx);
>      assert(idx !=3D -1);
>      if (idx =3D=3D 0) {
>          error_setg(&local_err, "Boot CPU is unpluggable");
> @@ -1872,7 +1873,7 @@ static void pc_cpu_unplug_cb(HotplugHandler *hotplu=
g_dev,
>          goto out;
>      }
> =20
> -    found_cpu =3D pc_find_cpu_slot(pcms, CPU(dev), NULL);
> +    found_cpu =3D pc_find_cpu_slot(MACHINE(pcms), CPU(dev), NULL);
>      found_cpu->cpu =3D NULL;
>      object_unparent(OBJECT(dev));
> =20
> @@ -1930,13 +1931,15 @@ static void pc_cpu_pre_plug(HotplugHandler *hotpl=
ug_dev,
>          cpu->apic_id =3D apicid_from_topo_ids(smp_cores, smp_threads, &t=
opo);
>      }
> =20
> -    cpu_slot =3D pc_find_cpu_slot(pcms, CPU(dev), &idx);
> +    cpu_slot =3D pc_find_cpu_slot(MACHINE(pcms), CPU(dev), &idx);
>      if (!cpu_slot) {
> +        MachineState *ms =3D MACHINE(pcms);
> +
>          x86_topo_ids_from_apicid(cpu->apic_id, smp_cores, smp_threads, &=
topo);
>          error_setg(errp, "Invalid CPU [socket: %u, core: %u, thread: %u]=
 with"
>                    " APIC ID %" PRIu32 ", valid index range 0:%d",
>                     topo.pkg_id, topo.core_id, topo.smt_id, cpu->apic_id,
> -                   pcms->possible_cpus->len - 1);
> +                   ms->possible_cpus->len - 1);
>          return;
>      }
> =20
> @@ -2247,9 +2250,8 @@ static unsigned pc_cpu_index_to_socket_id(unsigned =
cpu_index)
> =20
>  static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *machi=
ne)
>  {
> -    PCMachineState *pcms =3D PC_MACHINE(machine);
> -    assert(pcms->possible_cpus);
> -    return pcms->possible_cpus;
> +    assert(machine->possible_cpus);
> +    return machine->possible_cpus;
>  }
> =20
>  static HotpluggableCPUList *pc_query_hotpluggable_cpus(MachineState *mac=
hine)
> @@ -2257,19 +2259,18 @@ static HotpluggableCPUList *pc_query_hotpluggable=
_cpus(MachineState *machine)
>      int i;
>      CPUState *cpu;
>      HotpluggableCPUList *head =3D NULL;
> -    PCMachineState *pcms =3D PC_MACHINE(machine);
>      const char *cpu_type;
> =20
> -    cpu =3D pcms->possible_cpus->cpus[0].cpu;
> +    cpu =3D machine->possible_cpus->cpus[0].cpu;
>      assert(cpu); /* BSP is always present */
>      cpu_type =3D object_class_get_name(OBJECT_CLASS(CPU_GET_CLASS(cpu)));
> =20
> -    for (i =3D 0; i < pcms->possible_cpus->len; i++) {
> +    for (i =3D 0; i < machine->possible_cpus->len; i++) {
>          X86CPUTopoInfo topo;
>          HotpluggableCPUList *list_item =3D g_new0(typeof(*list_item), 1);
>          HotpluggableCPU *cpu_item =3D g_new0(typeof(*cpu_item), 1);
>          CpuInstanceProperties *cpu_props =3D g_new0(typeof(*cpu_props), =
1);
> -        const uint32_t apic_id =3D pcms->possible_cpus->cpus[i].arch_id;
> +        const uint32_t apic_id =3D machine->possible_cpus->cpus[i].arch_=
id;
> =20
>          x86_topo_ids_from_apicid(apic_id, smp_cores, smp_threads, &topo);
> =20
> @@ -2283,7 +2284,7 @@ static HotpluggableCPUList *pc_query_hotpluggable_c=
pus(MachineState *machine)
>          cpu_props->thread_id =3D topo.smt_id;
>          cpu_item->props =3D cpu_props;
> =20
> -        cpu =3D pcms->possible_cpus->cpus[i].cpu;
> +        cpu =3D machine->possible_cpus->cpus[i].cpu;
>          if (cpu) {
>              cpu_item->has_qom_path =3D true;
>              cpu_item->qom_path =3D object_get_canonical_path(OBJECT(cpu)=
);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYnPk1AAoJEGw4ysog2bOS4ogQAJnloHJYwK4xaOLRMEEZU8f6
zL5glAQi4beOiktVjiZK+QUfv7lQMElFNTLU07ouzYkL1F82fo7PKJXn+mxigq8+
8uaXf35ixU0IoPVpxvs85wEjYpTZ0R9G3kA5cE6A0XUgA8P4uDiFaLxkWBay2A6J
bDuIGylmckVH64muYog79+Nj0G0AB/LGQGznY3PeXdrrSdLx068p/MThAFwvyItp
/hU6abBGImuMcLEnu1gD71G0N7Q+2WCQCLB4bPJalJbu/9J0M9xOJnZqC1rEXgd5
kyVD+t8Bdtsjpt70sffmPT+a405z5Mmthrj75txq0i4kq+rJo623OhkP7ByUujoR
536c3MpQPfPDf+FwHpSPcGChXSmF1wiSKOp3429QIPDRTlG+vg8bKAaOkvik0y4q
6rI4sZafs3+MO7ZGKxTtgu22vhx9PwffWDGgEG+reOTtwvp6E+N0avpiZLt2OR1S
9mNC9HCgzMKp5UmNMouJz9p6Af0ONLlsLAoABE5ZPwflTz2vTWB3M8Z5XFD6sx03
xf2xC8H+wmF+pYcW3E0OCOoAqd2iSlTcMACHbfiWWNfGUHFX//zidDuHlKE8o7Oa
JO7sznzTCNSTabZt+t055gOCBJzI5TISKx6OiWzBnmM5i+Ze0E3zwa0iQCbP56Ar
lAJD0d9S9RUydkQttSUM
=8Hcd
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--
