Received: from eggs.gnu.org ([2001:4830:134:3::10]:37849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbyUM-00006X-6U
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 18:50:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbyUK-0005Zp-Gm
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 18:50:58 -0500
Date: Fri, 10 Feb 2017 10:47:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170209234715.GG27610@umbus.fritz.box>
References: <1486638518-171446-1-git-send-email-imammedo@redhat.com>
	<1486638518-171446-7-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/Zw+/jwnNHcBRYYu"
Content-Disposition: inline
In-Reply-To: <1486638518-171446-7-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 6/7] spapr: reuse machine->possible_cpus
 instead of cores[]
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


--/Zw+/jwnNHcBRYYu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 09, 2017 at 12:08:37PM +0100, Igor Mammedov wrote:
> Replace SPAPR specific cores[] array with generic
> machine->possible_cpus and store core objects there.
> It makes cores bookkeeping similar to x86 cpus and
> will allow to unify similar code.
> It would allow to replace cpu_index based NUMA node
> mapping with iproperty based one (for -device created
> cores) since possible_cpus carries board defined
> topology/layout.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Apart from one type noted below,

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/hw/ppc/spapr.h |   1 -
>  hw/ppc/spapr.c         | 129 ++++++++++++++++++++++++++++++++++---------=
------
>  2 files changed, 90 insertions(+), 40 deletions(-)
>=20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index a2d8964..f9b17d8 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -94,7 +94,6 @@ struct sPAPRMachineState {
>      /*< public >*/
>      char *kvm_type;
>      MemoryHotplugState hotplug_memory;
> -    Object **cores;
>  };
> =20
>  #define H_SUCCESS         0
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 37cb338..8d039ae 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1751,13 +1751,28 @@ static void spapr_validate_node_memory(MachineSta=
te *machine, Error **errp)
>      }
>  }
> =20
> +/* find cpu slot in machine->possible_cpus by core_id */
> +static CPUArchId *spapr_find_cpu_slot(MachineState *ms, uint32_t id, int=
 *idx)
> +{
> +    int index =3D id / smp_threads;
> +
> +    if (index >=3D ms->possible_cpus->len) {
> +        return NULL;
> +    }
> +    if (idx) {
> +        *idx =3D index;
> +    }
> +    return &ms->possible_cpus->cpus[index];
> +}
> +
>  static void spapr_init_cpus(sPAPRMachineState *spapr)
>  {
>      MachineState *machine =3D MACHINE(spapr);
>      MachineClass *mc =3D MACHINE_GET_CLASS(machine);
>      char *type =3D spapr_get_cpu_core_type(machine->cpu_model);
>      int smt =3D kvmppc_smt_threads();
> -    int spapr_max_cores, spapr_cores;
> +    const CPUArchIdList *possible_cpus;
> +    int boot_cores_nr =3D smp_cpus / smp_threads;;

Stray extra ';' above.

>      int i;
> =20
>      if (!type) {
> @@ -1765,6 +1780,7 @@ static void spapr_init_cpus(sPAPRMachineState *spap=
r)
>          exit(1);
>      }
> =20
> +    possible_cpus =3D mc->possible_cpu_arch_ids(machine);
>      if (mc->query_hotpluggable_cpus) {
>          if (smp_cpus % smp_threads) {
>              error_report("smp_cpus (%u) must be multiple of threads (%u)=
",
> @@ -1776,21 +1792,15 @@ static void spapr_init_cpus(sPAPRMachineState *sp=
apr)
>                           max_cpus, smp_threads);
>              exit(1);
>          }
> -
> -        spapr_max_cores =3D max_cpus / smp_threads;
> -        spapr_cores =3D smp_cpus / smp_threads;
>      } else {
>          if (max_cpus !=3D smp_cpus) {
>              error_report("This machine version does not support CPU hotp=
lug");
>              exit(1);
>          }
> -
> -        spapr_max_cores =3D QEMU_ALIGN_UP(smp_cpus, smp_threads) / smp_t=
hreads;
> -        spapr_cores =3D spapr_max_cores;
> +        boot_cores_nr =3D possible_cpus->len;
>      }
> =20
> -    spapr->cores =3D g_new0(Object *, spapr_max_cores);
> -    for (i =3D 0; i < spapr_max_cores; i++) {
> +    for (i =3D 0; i < possible_cpus->len; i++) {
>          int core_id =3D i * smp_threads;
> =20
>          if (mc->query_hotpluggable_cpus) {
> @@ -1802,7 +1812,7 @@ static void spapr_init_cpus(sPAPRMachineState *spap=
r)
>              qemu_register_reset(spapr_drc_reset, drc);
>          }
> =20
> -        if (i < spapr_cores) {
> +        if (i < boot_cores_nr) {
>              Object *core  =3D object_new(type);
>              int nr_threads =3D smp_threads;
> =20
> @@ -2491,10 +2501,11 @@ void *spapr_populate_hotplug_cpu_dt(CPUState *cs,=
 int *fdt_offset,
>  static void spapr_core_unplug(HotplugHandler *hotplug_dev, DeviceState *=
dev,
>                                Error **errp)
>  {
> -    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> +    MachineState *ms =3D MACHINE(qdev_get_machine());
>      CPUCore *cc =3D CPU_CORE(dev);
> +    CPUArchId *core_slot =3D spapr_find_cpu_slot(ms, cc->core_id, NULL);
> =20
> -    spapr->cores[cc->core_id / smp_threads] =3D NULL;
> +    core_slot->cpu =3D NULL;
>      object_unparent(OBJECT(dev));
>  }
> =20
> @@ -2510,19 +2521,24 @@ static
>  void spapr_core_unplug_request(HotplugHandler *hotplug_dev, DeviceState =
*dev,
>                                 Error **errp)
>  {
> -    CPUCore *cc =3D CPU_CORE(dev);
> -    int smt =3D kvmppc_smt_threads();
> -    int index =3D cc->core_id / smp_threads;
> -    sPAPRDRConnector *drc =3D
> -        spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_CPU, index * sm=
t);
> +    int index;
> +    sPAPRDRConnector *drc;
>      sPAPRDRConnectorClass *drck;
>      Error *local_err =3D NULL;
> +    CPUCore *cc =3D CPU_CORE(dev);
> +    int smt =3D kvmppc_smt_threads();
> =20
> +    if (!spapr_find_cpu_slot(MACHINE(hotplug_dev), cc->core_id, &index))=
 {
> +        error_setg(errp, "Unable to find CPU core with core-id: %d",
> +                   cc->core_id);
> +        return;
> +    }
>      if (index =3D=3D 0) {
>          error_setg(errp, "Boot CPU core may not be unplugged");
>          return;
>      }
> =20
> +    drc =3D spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_CPU, index =
* smt);
>      g_assert(drc);
> =20
>      drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> @@ -2547,11 +2563,17 @@ static void spapr_core_plug(HotplugHandler *hotpl=
ug_dev, DeviceState *dev,
>      Error *local_err =3D NULL;
>      void *fdt =3D NULL;
>      int fdt_offset =3D 0;
> -    int index =3D cc->core_id / smp_threads;
>      int smt =3D kvmppc_smt_threads();
> +    CPUArchId *core_slot;
> +    int index;
> =20
> +    core_slot =3D spapr_find_cpu_slot(MACHINE(hotplug_dev), cc->core_id,=
 &index);
> +    if (!core_slot) {
> +        error_setg(errp, "Unable to find CPU core with core-id: %d",
> +                   cc->core_id);
> +        return;
> +    }
>      drc =3D spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_CPU, index =
* smt);
> -    spapr->cores[index] =3D OBJECT(dev);
> =20
>      g_assert(drc || !mc->query_hotpluggable_cpus);
> =20
> @@ -2568,7 +2590,6 @@ static void spapr_core_plug(HotplugHandler *hotplug=
_dev, DeviceState *dev,
>          drck->attach(drc, dev, fdt, fdt_offset, !dev->hotplugged, &local=
_err);
>          if (local_err) {
>              g_free(fdt);
> -            spapr->cores[index] =3D NULL;
>              error_propagate(errp, local_err);
>              return;
>          }
> @@ -2590,6 +2611,7 @@ static void spapr_core_plug(HotplugHandler *hotplug=
_dev, DeviceState *dev,
>              drck->set_isolation_state(drc, SPAPR_DR_ISOLATION_STATE_UNIS=
OLATED);
>          }
>      }
> +    core_slot->cpu =3D OBJECT(dev);
>  }
> =20
>  static void spapr_core_pre_plug(HotplugHandler *hotplug_dev, DeviceState=
 *dev,
> @@ -2597,13 +2619,12 @@ static void spapr_core_pre_plug(HotplugHandler *h=
otplug_dev, DeviceState *dev,
>  {
>      MachineState *machine =3D MACHINE(OBJECT(hotplug_dev));
>      MachineClass *mc =3D MACHINE_GET_CLASS(hotplug_dev);
> -    sPAPRMachineState *spapr =3D SPAPR_MACHINE(OBJECT(hotplug_dev));
> -    int spapr_max_cores =3D max_cpus / smp_threads;
> -    int index;
>      Error *local_err =3D NULL;
>      CPUCore *cc =3D CPU_CORE(dev);
>      char *base_core_type =3D spapr_get_cpu_core_type(machine->cpu_model);
>      const char *type =3D object_get_typename(OBJECT(dev));
> +    CPUArchId *core_slot;
> +    int index;
> =20
>      if (dev->hotplugged && !mc->query_hotpluggable_cpus) {
>          error_setg(&local_err, "CPU hotplug not supported for this machi=
ne");
> @@ -2620,13 +2641,13 @@ static void spapr_core_pre_plug(HotplugHandler *h=
otplug_dev, DeviceState *dev,
>          goto out;
>      }
> =20
> -    index =3D cc->core_id / smp_threads;
> -    if (index < 0 || index >=3D spapr_max_cores) {
> +    core_slot =3D spapr_find_cpu_slot(MACHINE(hotplug_dev), cc->core_id,=
 &index);
> +    if (!core_slot) {
>          error_setg(&local_err, "core id %d out of range", cc->core_id);
>          goto out;
>      }
> =20
> -    if (spapr->cores[index]) {
> +    if (core_slot->cpu) {
>          error_setg(&local_err, "core %d already populated", cc->core_id);
>          goto out;
>      }
> @@ -2758,29 +2779,58 @@ static unsigned spapr_cpu_index_to_socket_id(unsi=
gned cpu_index)
>      return cpu_index / smp_threads / smp_cores;
>  }
> =20
> +static const CPUArchIdList *spapr_possible_cpu_arch_ids(MachineState *ma=
chine)
> +{
> +    int i;
> +    int spapr_max_cores =3D max_cpus / smp_threads;
> +    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
> +
> +    if (!mc->query_hotpluggable_cpus) {
> +        spapr_max_cores =3D QEMU_ALIGN_UP(smp_cpus, smp_threads) / smp_t=
hreads;
> +    }
> +    if (machine->possible_cpus) {
> +        assert(machine->possible_cpus->len =3D=3D spapr_max_cores);
> +        return machine->possible_cpus;
> +    }
> +
> +    machine->possible_cpus =3D g_malloc0(sizeof(CPUArchIdList) +
> +                             sizeof(CPUArchId) * spapr_max_cores);
> +    machine->possible_cpus->len =3D spapr_max_cores;
> +    for (i =3D 0; i < machine->possible_cpus->len; i++) {
> +        int core_id =3D i * smp_threads;
> +
> +        machine->possible_cpus->cpus[i].arch_id =3D core_id;
> +        machine->possible_cpus->cpus[i].props.has_core_id =3D true;
> +        machine->possible_cpus->cpus[i].props.core_id =3D core_id;
> +        /* TODO: add 'has_node/node' here to describe
> +           to which node core belongs */
> +    }
> +    return machine->possible_cpus;
> +}
> +
>  static HotpluggableCPUList *spapr_query_hotpluggable_cpus(MachineState *=
machine)
>  {
>      int i;
> +    Object *cpu;
>      HotpluggableCPUList *head =3D NULL;
> -    sPAPRMachineState *spapr =3D SPAPR_MACHINE(machine);
> -    int spapr_max_cores =3D max_cpus / smp_threads;
> +    const char *cpu_type;
> =20
> -    for (i =3D 0; i < spapr_max_cores; i++) {
> +    cpu =3D machine->possible_cpus->cpus[0].cpu;
> +    assert(cpu); /* Boot cpu is always present */
> +    cpu_type =3D object_get_typename(cpu);
> +    for (i =3D 0; i < machine->possible_cpus->len; i++) {
>          HotpluggableCPUList *list_item =3D g_new0(typeof(*list_item), 1);
>          HotpluggableCPU *cpu_item =3D g_new0(typeof(*cpu_item), 1);
> -        CpuInstanceProperties *cpu_props =3D g_new0(typeof(*cpu_props), =
1);
> =20
> -        cpu_item->type =3D spapr_get_cpu_core_type(machine->cpu_model);
> -        cpu_item->vcpus_count =3D smp_threads;
> -        cpu_props->has_core_id =3D true;
> -        cpu_props->core_id =3D i * smp_threads;
> -        /* TODO: add 'has_node/node' here to describe
> -           to which node core belongs */
> +        cpu_item->type =3D g_strdup(cpu_type);
> +        cpu_item->vcpus_count =3D smp_threads; // TODO: ??? generalize
> +        cpu_item->props =3D g_memdup(&machine->possible_cpus->cpus[i].pr=
ops,
> +                                   sizeof(*cpu_item->props));
> =20
> -        cpu_item->props =3D cpu_props;
> -        if (spapr->cores[i]) {
> +        cpu =3D machine->possible_cpus->cpus[i].cpu;
> +        if (cpu) {
>              cpu_item->has_qom_path =3D true;
> -            cpu_item->qom_path =3D object_get_canonical_path(spapr->core=
s[i]);
> +            cpu_item->qom_path =3D object_get_canonical_path(cpu);
>          }
>          list_item->value =3D cpu_item;
>          list_item->next =3D head;
> @@ -2872,6 +2922,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      hc->plug =3D spapr_machine_device_plug;
>      hc->unplug =3D spapr_machine_device_unplug;
>      mc->cpu_index_to_socket_id =3D spapr_cpu_index_to_socket_id;
> +    mc->possible_cpu_arch_ids =3D spapr_possible_cpu_arch_ids;
>      hc->unplug_request =3D spapr_machine_device_unplug_request;
> =20
>      smc->dr_lmb_enabled =3D true;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/Zw+/jwnNHcBRYYu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYnP+BAAoJEGw4ysog2bOSCF0P/Ap3xdXzqebohthzRyyI2CEG
qKodAQtrzHVJZpSuDHdlEHZ7Yc+VEsqWwYZjXV7iuN71UClAbUeILVvyCqdHnBlM
cnRxyJ0Gk+rWIHrVDAcuPa45imsMqs1TXqkCZx/d/vJPw62zWGzOeNi6AI0Fl5Cu
EuygExKJBsW0vDzz/+zLioNwWtZtLgndq/ylFiJdwpbH5O7Fsf4U+s/YJd+YT2hd
WUqqeau+wRqG/ZwMC1B1Mztl6L/D6mEaT0L/jnIdkcI1iN7xvm8XzJhSAG/5KOK8
AQjgFJjjjK0HJPwKlRAU7cBy6yQZtYtRPJuaMwEDyEfM2RZX5Y+rODUnjxuWBgn5
GrxzQecRCMW1vJ08Y2GnKiyEqXe3Sv0H+at/GfGZd8JlA6HHsmPQ6DEPAjZfjm9K
5SEBaGkG1T/VmapV7q7pH02Tu0B5gK9EbFD5ONizQHtQ8xvDSTezCa7Z1Yl3Opyh
utbcrvEqxGDG3YgNSt7tXA0OWkPHNw/qhqX8hLbMH8cfJAVKN+NHLbWQAuZ1i39y
3wzSlKffOgGafiDKplG81BYfgMG9VKpdmvPqk5BHjTqHtoSA2YeyEKZ2anwtaE1u
hrGaer8jXHjWGMVuzEg6CuBoNpfRItQyh1I/BCSoHD8sxwmwnvEGiS9qSwW9ft8f
8CwTVG6qC1kckfaw3tgV
=6NsZ
-----END PGP SIGNATURE-----

--/Zw+/jwnNHcBRYYu--
