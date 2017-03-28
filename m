Received: from eggs.gnu.org ([2001:4830:134:3::10]:51111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1csifu-0001Ee-BU
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 00:24:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1csifs-0008DX-Ef
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 00:24:06 -0400
Date: Tue, 28 Mar 2017 15:19:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170328041920.GC21068@umbus.fritz.box>
References: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
	<1490189568-167621-6-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WplhKdTI2c8ulnbP"
Content-Disposition: inline
In-Reply-To: <1490189568-167621-6-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 05/23] numa: move source of
 default CPUs to NUMA node mapping into boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org


--WplhKdTI2c8ulnbP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 22, 2017 at 02:32:30PM +0100, Igor Mammedov wrote:
> Originally CPU threads were by default assigned in
> round-robin fashion. However it was causing issues in
> guest since CPU threads from the same socket/core could
> be placed on different NUMA nodes.
> Commit fb43b73b (pc: fix default VCPU to NUMA node mapping)
> fixed it by grouping threads within a socket on the same node
> introducing cpu_index_to_socket_id() callback and commit
> 20bb648d (spapr: Fix default NUMA node allocation for threads)
> reused callback to fix similar issues for SPAPR machine
> even though socket doesn't make much sense there.
>=20
> As result QEMU ended up having 3 default distribution rules
> used by 3 targets /virt-arm, spapr, pc/.
>=20
> In effort of moving NUMA mapping for CPUs into possible_cpus,
> generalize default mapping in numa.c by making boards decide
> on default mapping and let them explicitly tell generic
> numa code to which node a CPU thread belongs to by replacing
> cpu_index_to_socket_id() with @cpu_index_to_instance_props()
> which provides default node_id assigned by board to specified
> cpu_index.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> Patch only moves source of default mapping to possible_cpus[]
> and leaves the rest of NUMA handling to numa_info[node_id].node_cpu
> bitmaps. It's up to follow up patches to replace bitmaps
> with possible_cpus[] internally.
> ---
>  include/hw/boards.h   |  8 ++++++--
>  include/sysemu/numa.h |  2 +-
>  hw/arm/virt.c         | 19 +++++++++++++++++--
>  hw/i386/pc.c          | 22 ++++++++++++++++------
>  hw/ppc/spapr.c        | 27 ++++++++++++++++++++-------
>  numa.c                | 15 +++++++++------
>  vl.c                  |  2 +-
>  7 files changed, 70 insertions(+), 25 deletions(-)
>=20
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 269d0ba..1dd0fde 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -74,7 +74,10 @@ typedef struct {
>   *    of HotplugHandler object, which handles hotplug operation
>   *    for a given @dev. It may return NULL if @dev doesn't require
>   *    any actions to be performed by hotplug handler.
> - * @cpu_index_to_socket_id:
> + * @cpu_index_to_instance_props:
> + *    used to provide @cpu_index to socket/core/thread number mapping, a=
llowing
> + *    legacy code to perform maping from cpu_index to topology properties
> + *    Returns: tuple of socket/core/thread ids given cpu_index belongs t=
o.
>   *    used to provide @cpu_index to socket number mapping, allowing
>   *    a machine to group CPU threads belonging to the same socket/package
>   *    Returns: socket number given cpu_index belongs to.
> @@ -138,7 +141,8 @@ struct MachineClass {
> =20
>      HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
>                                             DeviceState *dev);
> -    unsigned (*cpu_index_to_socket_id)(unsigned cpu_index);
> +    CpuInstanceProperties (*cpu_index_to_instance_props)(MachineState *m=
achine,
> +                                                         unsigned cpu_in=
dex);
>      const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine);
>  };
> =20
> diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
> index 8f09dcf..46ea6c7 100644
> --- a/include/sysemu/numa.h
> +++ b/include/sysemu/numa.h
> @@ -24,7 +24,7 @@ typedef struct node_info {
>  } NodeInfo;
> =20
>  extern NodeInfo numa_info[MAX_NODES];
> -void parse_numa_opts(MachineClass *mc);
> +void parse_numa_opts(MachineState *ms);
>  void numa_post_machine_init(void);
>  void query_numa_node_mem(uint64_t node_mem[]);
>  extern QemuOptsList qemu_numa_opts;
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 0cbcbc1..8748d25 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1554,6 +1554,16 @@ static void virt_set_gic_version(Object *obj, cons=
t char *value, Error **errp)
>      }
>  }
> =20
> +static CpuInstanceProperties
> +virt_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
> +{
> +    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
> +    const CPUArchIdList *possible_cpus =3D mc->possible_cpu_arch_ids(ms);
> +
> +    assert(cpu_index < possible_cpus->len);
> +    return possible_cpus->cpus[cpu_index].props;;
> +}
> +

It seems a bit weird to have a machine specific hook to pull the
property information when one way or another it's coming from the
possible_cpus table, which is already constructed by a machine
specific hook.  Could we add a range or list of cpu_index values to
each possible_cpus entry instead, and have a generic lookup of the
right entry based on that?


>  static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
>  {
>      int n;
> @@ -1573,8 +1583,12 @@ static const CPUArchIdList *virt_possible_cpu_arch=
_ids(MachineState *ms)
>          ms->possible_cpus->cpus[n].props.has_thread_id =3D true;
>          ms->possible_cpus->cpus[n].props.thread_id =3D n;
> =20
> -        /* TODO: add 'has_node/node' here to describe
> -           to which node core belongs */
> +        /* default distribution of CPUs over NUMA nodes */
> +        if (nb_numa_nodes) {
> +            /* preset values but do not enable them i.e. 'has_node_id =
=3D false',
> +             * board will enable them if manual mapping wasn't present o=
n CLI */

I'm a little confused by this comment, since I don't see any board
code altering has_node_id.

> +            ms->possible_cpus->cpus[n].props.node_id =3D n % nb_numa_nod=
es;;
> +        }
>      }
>      return ms->possible_cpus;
>  }
> @@ -1596,6 +1610,7 @@ static void virt_machine_class_init(ObjectClass *oc=
, void *data)
>      /* We know we will never create a pre-ARMv7 CPU which needs 1K pages=
 */
>      mc->minimum_page_bits =3D 12;
>      mc->possible_cpu_arch_ids =3D virt_possible_cpu_arch_ids;
> +    mc->cpu_index_to_instance_props =3D virt_cpu_index_to_props;
>  }
> =20
>  static const TypeInfo virt_machine_info =3D {
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index d24388e..7031100 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -2245,12 +2245,14 @@ static void pc_machine_reset(void)
>      }
>  }
> =20
> -static unsigned pc_cpu_index_to_socket_id(unsigned cpu_index)
> +static CpuInstanceProperties
> +pc_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
>  {
> -    X86CPUTopoInfo topo;
> -    x86_topo_ids_from_idx(smp_cores, smp_threads, cpu_index,
> -                          &topo);
> -    return topo.pkg_id;
> +    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
> +    const CPUArchIdList *possible_cpus =3D mc->possible_cpu_arch_ids(ms);
> +
> +    assert(cpu_index < possible_cpus->len);
> +    return possible_cpus->cpus[cpu_index].props;;

Since the pc and arm version of this are basically identical, I wonder
if that should actually be the default implementation.  If we need it
at all.

>  }
> =20
>  static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
> @@ -2282,6 +2284,14 @@ static const CPUArchIdList *pc_possible_cpu_arch_i=
ds(MachineState *ms)
>          ms->possible_cpus->cpus[i].props.core_id =3D topo.core_id;
>          ms->possible_cpus->cpus[i].props.has_thread_id =3D true;
>          ms->possible_cpus->cpus[i].props.thread_id =3D topo.smt_id;
> +
> +        /* default distribution of CPUs over NUMA nodes */
> +        if (nb_numa_nodes) {
> +            /* preset values but do not enable them i.e. 'has_node_id =
=3D false',
> +             * board will enable them if manual mapping wasn't present o=
n CLI */
> +            ms->possible_cpus->cpus[i].props.node_id =3D
> +                topo.pkg_id % nb_numa_nodes;
> +        }
>      }
>      return ms->possible_cpus;
>  }
> @@ -2324,7 +2334,7 @@ static void pc_machine_class_init(ObjectClass *oc, =
void *data)
>      pcmc->acpi_data_size =3D 0x20000 + 0x8000;
>      pcmc->save_tsc_khz =3D true;
>      mc->get_hotplug_handler =3D pc_get_hotpug_handler;
> -    mc->cpu_index_to_socket_id =3D pc_cpu_index_to_socket_id;
> +    mc->cpu_index_to_instance_props =3D pc_cpu_index_to_props;
>      mc->possible_cpu_arch_ids =3D pc_possible_cpu_arch_ids;
>      mc->has_hotpluggable_cpus =3D true;
>      mc->default_boot_order =3D "cad";
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 6ee566d..9dcbbcc 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2921,11 +2921,18 @@ static HotplugHandler *spapr_get_hotplug_handler(=
MachineState *machine,
>      return NULL;
>  }
> =20
> -static unsigned spapr_cpu_index_to_socket_id(unsigned cpu_index)
> +static CpuInstanceProperties
> +spapr_cpu_index_to_props(MachineState *machine, unsigned cpu_index)
>  {
> -    /* Allocate to NUMA nodes on a "socket" basis (not that concept of
> -     * socket means much for the paravirtualized PAPR platform) */
> -    return cpu_index / smp_threads / smp_cores;
> +    CPUArchId *core_slot;
> +    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
> +    int core_id =3D cpu_index / smp_threads * smp_threads;

I don't think you need this.  AIUI the purpose of
spapr_find_cpu_slot() is that it already finds the right CPU slot from
a cpu_index, so you can just pass the cpu_index directly.

> +
> +    /* make sure possible_cpu are intialized */
> +    mc->possible_cpu_arch_ids(machine);
> +    core_slot =3D spapr_find_cpu_slot(machine, core_id, NULL);
> +    assert(core_slot);
> +    return core_slot->props;
>  }
> =20
>  static const CPUArchIdList *spapr_possible_cpu_arch_ids(MachineState *ma=
chine)
> @@ -2952,8 +2959,14 @@ static const CPUArchIdList *spapr_possible_cpu_arc=
h_ids(MachineState *machine)
>          machine->possible_cpus->cpus[i].arch_id =3D core_id;
>          machine->possible_cpus->cpus[i].props.has_core_id =3D true;
>          machine->possible_cpus->cpus[i].props.core_id =3D core_id;
> -        /* TODO: add 'has_node/node' here to describe
> -           to which node core belongs */
> +
> +        /* default distribution of CPUs over NUMA nodes */
> +        if (nb_numa_nodes) {
> +            /* preset values but do not enable them i.e. 'has_node_id =
=3D false',
> +             * board will enable them if manual mapping wasn't present o=
n CLI */
> +            machine->possible_cpus->cpus[i].props.node_id =3D
> +                core_id / smp_threads / smp_cores % nb_numa_nodes;
> +        }
>      }
>      return machine->possible_cpus;
>  }
> @@ -3076,7 +3089,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      hc->pre_plug =3D spapr_machine_device_pre_plug;
>      hc->plug =3D spapr_machine_device_plug;
>      hc->unplug =3D spapr_machine_device_unplug;
> -    mc->cpu_index_to_socket_id =3D spapr_cpu_index_to_socket_id;
> +    mc->cpu_index_to_instance_props =3D spapr_cpu_index_to_props;
>      mc->possible_cpu_arch_ids =3D spapr_possible_cpu_arch_ids;
>      hc->unplug_request =3D spapr_machine_device_unplug_request;
> =20
> diff --git a/numa.c b/numa.c
> index e01cb54..b6e71bc 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -294,9 +294,10 @@ static void validate_numa_cpus(void)
>      g_free(seen_cpus);
>  }
> =20
> -void parse_numa_opts(MachineClass *mc)
> +void parse_numa_opts(MachineState *ms)
>  {
>      int i;
> +    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
> =20
>      for (i =3D 0; i < MAX_NODES; i++) {
>          numa_info[i].node_cpu =3D bitmap_new(max_cpus);
> @@ -378,14 +379,16 @@ void parse_numa_opts(MachineClass *mc)
>           * rule grouping VCPUs by socket so that VCPUs from the same soc=
ket
>           * would be on the same node.
>           */
> +        if (!mc->cpu_index_to_instance_props) {
> +            error_report("default CPUs to NUMA node mapping isn't suppor=
ted");
> +            exit(1);
> +        }
>          if (i =3D=3D nb_numa_nodes) {
>              for (i =3D 0; i < max_cpus; i++) {
> -                unsigned node_id =3D i % nb_numa_nodes;
> -                if (mc->cpu_index_to_socket_id) {
> -                    node_id =3D mc->cpu_index_to_socket_id(i) % nb_numa_=
nodes;
> -                }
> +                CpuInstanceProperties props;
> +                props =3D mc->cpu_index_to_instance_props(ms, i);
> =20
> -                set_bit(i, numa_info[node_id].node_cpu);
> +                set_bit(i, numa_info[props.node_id].node_cpu);
>              }
>          }
> =20
> diff --git a/vl.c b/vl.c
> index 0b4ed52..5ffb9c3 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4498,7 +4498,7 @@ int main(int argc, char **argv, char **envp)
>      default_drive(default_floppy, snapshot, IF_FLOPPY, 0, FD_OPTS);
>      default_drive(default_sdcard, snapshot, IF_SD, 0, SD_OPTS);
> =20
> -    parse_numa_opts(machine_class);
> +    parse_numa_opts(current_machine);
> =20
>      if (qemu_opts_foreach(qemu_find_opts("mon"),
>                            mon_init_func, NULL, NULL)) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WplhKdTI2c8ulnbP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY2eRGAAoJEGw4ysog2bOSL2YP/1QnrDZRI6jc86yrCmqsivgh
Mstpsei3MQgan+FucF+sNZuUgTXOz6fUqUvsLH+g2k0vj7FbroJBAwHDGSzIH/jB
ZTE/hpYsXtkgZkS9dBLn3gN7z0A3EL4/D1U78Uw/RXRS4tzjiDztvqpbH/C3fvuF
+dhI4NWOyz1objKDKOr5iQfEvhVFbuc/hZTizR2LZLQYtM50wK2Smk5V6O2/Af3I
YLu2pCLghUetcUn7mnoIPB2klZj/o496dHHkjEYmWoo/A3NfRybC5apOV6ANynAt
DviYsv0+qCcY3Cd9hcUCKVbZ846Z74bBfnaJz2/UzOWaOqwFYb7t+1FEjmF2fmIN
mxRyrj/zc6fHf2RthCw2Bkvb9KYiC/8T1JCV3DSGBzh4BCwCiEFIA4mql1puHJXQ
/qRTgMCHY0DBINZqvpsPLQx4wHEx2qXy1LGStyinvDVg1EeuIgSMFY7bBK/Ehuck
Q9YyAWIvM9+TwKhBouAMr+ArAVkGf+g6fhKkwly3G7yrPpcgm+aZ72gO1r0ebBvA
PgyvJLG6+hsBh1q7DWH2318hKmAYJarAK2QPE5z5HXvgds9bnv//iJ+RbqJKUWVO
jTzD7MkwYOQAj79QEnWf6asVqpJsZTRfPJmk9FkHO4t9yikHJWOe6nCTLluUzOeK
LuyS2KBgyPZyX/EBQ94W
=U2D1
-----END PGP SIGNATURE-----

--WplhKdTI2c8ulnbP--
