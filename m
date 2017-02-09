Received: from eggs.gnu.org ([2001:4830:134:3::10]:46955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbzF8-0002Jl-0a
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 19:39:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbzF6-00065O-75
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 19:39:18 -0500
Date: Fri, 10 Feb 2017 10:53:39 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170209235339.GH27610@umbus.fritz.box>
References: <1486638518-171446-1-git-send-email-imammedo@redhat.com>
	<1486638518-171446-8-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BXr400anF0jyguTS"
Content-Disposition: inline
In-Reply-To: <1486638518-171446-8-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 7/7] machine: unify
 [pc_|spapr_]query_hotpluggable_cpus() callbacks
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


--BXr400anF0jyguTS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 09, 2017 at 12:08:38PM +0100, Igor Mammedov wrote:
> All callbacks FOO_query_hotpluggable_cpus() are practically
> the same except of setting vcpus_count to different values.
> Convert them to a generic machine_query_hotpluggable_cpus()
> callback by moving vcpus_count initialization to per machine
> specific callback possible_cpu_arch_ids().
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

It seems to be sensible to go further after this and remove the
query_hotpluggable_cpus callback from the MachineClass entirely,
replacing it with just a boolean 'cpu_hotplug_allowed'.

> ---
>  include/hw/boards.h |  3 +++
>  hw/core/machine.c   | 31 +++++++++++++++++++++++++++++++
>  hw/i386/pc.c        | 36 ++----------------------------------
>  hw/ppc/spapr.c      | 34 ++--------------------------------
>  4 files changed, 38 insertions(+), 66 deletions(-)
>=20
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 60209df..9040dbb 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -41,15 +41,18 @@ int machine_phandle_start(MachineState *machine);
>  bool machine_dump_guest_core(MachineState *machine);
>  bool machine_mem_merge(MachineState *machine);
>  void machine_register_compat_props(MachineState *machine);
> +HotpluggableCPUList *machine_query_hotpluggable_cpus(MachineState *machi=
ne);
> =20
>  /**
>   * CPUArchId:
>   * @arch_id - architecture-dependent CPU ID of present or possible CPU
>   * @cpu - pointer to corresponding CPU object if it's present on NULL ot=
herwise
>   * @props - CPU object properties, initialized by board
> + * #vcpus_count - number of threads provided by @cpu object
>   */
>  typedef struct {
>      uint64_t arch_id;
> +    int64_t vcpus_count;
>      CpuInstanceProperties props;
>      Object *cpu;
>  } CPUArchId;
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index b0fd91f..0699750 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -357,6 +357,37 @@ static void machine_init_notify(Notifier *notifier, =
void *data)
>      foreach_dynamic_sysbus_device(error_on_sysbus_device, NULL);
>  }
> =20
> +HotpluggableCPUList *machine_query_hotpluggable_cpus(MachineState *machi=
ne)
> +{
> +    int i;
> +    Object *cpu;
> +    HotpluggableCPUList *head =3D NULL;
> +    const char *cpu_type;
> +
> +    cpu =3D machine->possible_cpus->cpus[0].cpu;
> +    assert(cpu); /* Boot cpu is always present */
> +    cpu_type =3D object_get_typename(cpu);
> +    for (i =3D 0; i < machine->possible_cpus->len; i++) {
> +        HotpluggableCPUList *list_item =3D g_new0(typeof(*list_item), 1);
> +        HotpluggableCPU *cpu_item =3D g_new0(typeof(*cpu_item), 1);
> +
> +        cpu_item->type =3D g_strdup(cpu_type);
> +        cpu_item->vcpus_count =3D machine->possible_cpus->cpus[i].vcpus_=
count;
> +        cpu_item->props =3D g_memdup(&machine->possible_cpus->cpus[i].pr=
ops,
> +                                   sizeof(*cpu_item->props));
> +
> +        cpu =3D machine->possible_cpus->cpus[i].cpu;
> +        if (cpu) {
> +            cpu_item->has_qom_path =3D true;
> +            cpu_item->qom_path =3D object_get_canonical_path(cpu);
> +        }
> +        list_item->value =3D cpu_item;
> +        list_item->next =3D head;
> +        head =3D list_item;
> +    }
> +    return head;
> +}
> +
>  static void machine_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index afaae15..548628f 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -2266,6 +2266,7 @@ static const CPUArchIdList *pc_possible_cpu_arch_id=
s(MachineState *ms)
>      for (i =3D 0; i < ms->possible_cpus->len; i++) {
>          X86CPUTopoInfo topo;
> =20
> +        ms->possible_cpus->cpus[i].vcpus_count =3D 1;
>          ms->possible_cpus->cpus[i].arch_id =3D x86_cpu_apic_id_from_inde=
x(i);
>          x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
>                                   smp_cores, smp_threads, &topo);
> @@ -2279,39 +2280,6 @@ static const CPUArchIdList *pc_possible_cpu_arch_i=
ds(MachineState *ms)
>      return ms->possible_cpus;
>  }
> =20
> -static HotpluggableCPUList *pc_query_hotpluggable_cpus(MachineState *mac=
hine)
> -{
> -    int i;
> -    Object *cpu;
> -    HotpluggableCPUList *head =3D NULL;
> -    const char *cpu_type;
> -
> -    cpu =3D machine->possible_cpus->cpus[0].cpu;
> -    assert(cpu); /* BSP is always present */
> -    cpu_type =3D object_get_typename(cpu);
> -
> -    for (i =3D 0; i < machine->possible_cpus->len; i++) {
> -        HotpluggableCPUList *list_item =3D g_new0(typeof(*list_item), 1);
> -        HotpluggableCPU *cpu_item =3D g_new0(typeof(*cpu_item), 1);
> -
> -        cpu_item->type =3D g_strdup(cpu_type);
> -        cpu_item->vcpus_count =3D 1;
> -        cpu_item->props =3D g_memdup(&machine->possible_cpus->cpus[i].pr=
ops,
> -                                   sizeof(*cpu_item->props));
> -
> -        cpu =3D machine->possible_cpus->cpus[i].cpu;
> -        if (cpu) {
> -            cpu_item->has_qom_path =3D true;
> -            cpu_item->qom_path =3D object_get_canonical_path(cpu);
> -        }
> -
> -        list_item->value =3D cpu_item;
> -        list_item->next =3D head;
> -        head =3D list_item;
> -    }
> -    return head;
> -}
> -
>  static void x86_nmi(NMIState *n, int cpu_index, Error **errp)
>  {
>      /* cpu index isn't used */
> @@ -2352,7 +2320,7 @@ static void pc_machine_class_init(ObjectClass *oc, =
void *data)
>      mc->get_hotplug_handler =3D pc_get_hotpug_handler;
>      mc->cpu_index_to_socket_id =3D pc_cpu_index_to_socket_id;
>      mc->possible_cpu_arch_ids =3D pc_possible_cpu_arch_ids;
> -    mc->query_hotpluggable_cpus =3D pc_query_hotpluggable_cpus;
> +    mc->query_hotpluggable_cpus =3D machine_query_hotpluggable_cpus;
>      mc->default_boot_order =3D "cad";
>      mc->hot_add_cpu =3D pc_hot_add_cpu;
>      mc->max_cpus =3D 255;
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 8d039ae..3c4d632 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2799,6 +2799,7 @@ static const CPUArchIdList *spapr_possible_cpu_arch=
_ids(MachineState *machine)
>      for (i =3D 0; i < machine->possible_cpus->len; i++) {
>          int core_id =3D i * smp_threads;
> =20
> +        machine->possible_cpus->cpus[i].vcpus_count =3D smp_threads;
>          machine->possible_cpus->cpus[i].arch_id =3D core_id;
>          machine->possible_cpus->cpus[i].props.has_core_id =3D true;
>          machine->possible_cpus->cpus[i].props.core_id =3D core_id;
> @@ -2808,37 +2809,6 @@ static const CPUArchIdList *spapr_possible_cpu_arc=
h_ids(MachineState *machine)
>      return machine->possible_cpus;
>  }
> =20
> -static HotpluggableCPUList *spapr_query_hotpluggable_cpus(MachineState *=
machine)
> -{
> -    int i;
> -    Object *cpu;
> -    HotpluggableCPUList *head =3D NULL;
> -    const char *cpu_type;
> -
> -    cpu =3D machine->possible_cpus->cpus[0].cpu;
> -    assert(cpu); /* Boot cpu is always present */
> -    cpu_type =3D object_get_typename(cpu);
> -    for (i =3D 0; i < machine->possible_cpus->len; i++) {
> -        HotpluggableCPUList *list_item =3D g_new0(typeof(*list_item), 1);
> -        HotpluggableCPU *cpu_item =3D g_new0(typeof(*cpu_item), 1);
> -
> -        cpu_item->type =3D g_strdup(cpu_type);
> -        cpu_item->vcpus_count =3D smp_threads; // TODO: ??? generalize
> -        cpu_item->props =3D g_memdup(&machine->possible_cpus->cpus[i].pr=
ops,
> -                                   sizeof(*cpu_item->props));
> -
> -        cpu =3D machine->possible_cpus->cpus[i].cpu;
> -        if (cpu) {
> -            cpu_item->has_qom_path =3D true;
> -            cpu_item->qom_path =3D object_get_canonical_path(cpu);
> -        }
> -        list_item->value =3D cpu_item;
> -        list_item->next =3D head;
> -        head =3D list_item;
> -    }
> -    return head;
> -}
> -
>  static void spapr_phb_placement(sPAPRMachineState *spapr, uint32_t index,
>                                  uint64_t *buid, hwaddr *pio,
>                                  hwaddr *mmio32, hwaddr *mmio64,
> @@ -2927,7 +2897,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
> =20
>      smc->dr_lmb_enabled =3D true;
>      smc->tcg_default_cpu =3D "POWER8";
> -    mc->query_hotpluggable_cpus =3D spapr_query_hotpluggable_cpus;
> +    mc->query_hotpluggable_cpus =3D machine_query_hotpluggable_cpus;
>      fwc->get_dev_path =3D spapr_get_fw_dev_path;
>      nc->nmi_monitor_handler =3D spapr_nmi;
>      smc->phb_placement =3D spapr_phb_placement;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--BXr400anF0jyguTS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYnQEDAAoJEGw4ysog2bOSw88QALNzH5QRSAeWqFADQ929iXPb
cdQTpKgjlbV+klZKF4sn+nkag0wRtjcf9lPp4X8ams7mPnZ6fqU1dXDaVAHy17EV
NznMTWkGze3RXzsF8F3fHCa5jfI4tZpQJsAS0N7hZk2Sta3EJi0KdPdWxwVQi2yc
d8zDNEFtcbuhIkkLAn4qttiu9ISykOjDzj1DE5warjqG473evhYKSrEfdFLSzBfc
/hleEutWCZo9cIJP2qEMprhSFqqeW6s00/06QTfbR1X4aAzPXVM+1Vyo2PTFP4mJ
PlR09EQWbcm9GHkuhTkbVj5P3MSVB14b+iygnlr/jWIG4KRWzVeeLu5wLbCNZBdx
ckFVLPyYjaGaOZlxoF942lRZItoW4ltU4olm6TAhwnUf+0IN/muG1uSfH4PMdJii
qEQeN69tKcufiDMHs4pGmzf++DclysAF/WHYUiVI2kNUEKovjhcusN2pfF37/oh2
JBDyU3uBXg3smvdzgWR5gBgzOYLQ1OuoL06KhYTsrc21F8ELmr6w3NfqU+0EMmOh
Fk5jVvOFkfeXxSH1/jyj9kPx2eqlvdATgRImRAapxL9e2yjzK0Dg15FV4tiWyDkd
VyykB6NlD1PzUdK3NwiXO97NM2j3iSBBVtalNjI93PsTNmPqUHGSjdtBLWZbrG/U
crHJgdzV1cdrjGMoOT2M
=mVUI
-----END PGP SIGNATURE-----

--BXr400anF0jyguTS--
