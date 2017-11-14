Received: from eggs.gnu.org ([2001:4830:134:3::10]:37295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eEdB2-0003d1-MB
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:31:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eEdAw-0005SC-HK
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:31:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eEdAw-0005RW-7b
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:30:58 -0500
Date: Tue, 14 Nov 2017 16:30:50 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171114163050.70c752bd@nial.brq.redhat.com>
In-Reply-To: <1510626841-9928-1-git-send-email-douly.fnst@cn.fujitsu.com>
References: <1510626841-9928-1-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6] NUMA: Enable adding NUMA node implicitly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Takao Indoh <indou.takao@jp.fujitsu.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Izumi Taku <izumi.taku@jp.fujitsu.com>, David Hildenbrand <david@redhat.com>, f4bug@amsat.org, Alistair Francis <alistair23@gmail.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Tue, 14 Nov 2017 10:34:01 +0800
Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:

> Linux and Windows need ACPI SRAT table to make memory hotplug work proper=
ly,
> however currently QEMU doesn't create SRAT table if numa options aren't p=
resent
> on CLI.
>=20
> Which breaks both linux and windows guests in certain conditions:
>  * Windows: won't enable memory hotplug without SRAT table at all
>  * Linux: if QEMU is started with initial memory all below 4Gb and no SRA=
T table
>    present, guest kernel will use nommu DMA ops, which breaks 32bit hw dr=
ivers
>    when memory is hotplugged and guest tries to use it with that drivers.
>=20
> Fix above issues by automatically creating a numa node when QEMU is start=
ed with
> memory hotplug enabled but without '-numa' options on CLI.
> (PS: auto-create numa node only for new machine types so not to break mig=
ration).
>=20
> Which would provide SRAT table to guests without explicit -numa options o=
n CLI
> and would allow:
>  * Windows: to enable memory hotplug
>  * Linux: switch to SWIOTLB DMA ops, to bounce DMA transfers to 32bit all=
ocated
>    buffers that legacy drivers/hw can handle.
>=20
> [Rewritten by Igor]
>=20
> Reported-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Alistair Francis <alistair23@gmail.com>
> Cc: Takao Indoh <indou.takao@jp.fujitsu.com>
> Cc: Izumi Taku <izumi.taku@jp.fujitsu.com>
> ---
> changelog V5 --> V6:
>   - rebase it to avoid building failure
>   - test again
> ---
>  hw/i386/pc.c        |  1 +
>  hw/i386/pc_piix.c   |  1 +
>  hw/i386/pc_q35.c    |  1 +
>  include/hw/boards.h |  1 +
>  numa.c              | 21 ++++++++++++++++++++-
>  vl.c                |  3 +--
>  6 files changed, 25 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index e11a65b..156501c 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -2325,6 +2325,7 @@ static void pc_machine_class_init(ObjectClass *oc, =
void *data)
>      mc->cpu_index_to_instance_props =3D pc_cpu_index_to_props;
>      mc->get_default_cpu_node_id =3D pc_get_default_cpu_node_id;
>      mc->possible_cpu_arch_ids =3D pc_possible_cpu_arch_ids;
> +    mc->auto_enable_numa_with_memhp =3D true;
>      mc->has_hotpluggable_cpus =3D true;
>      mc->default_boot_order =3D "cad";
>      mc->hot_add_cpu =3D pc_hot_add_cpu;
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index f79d5cb..5e47528 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -446,6 +446,7 @@ static void pc_i440fx_2_10_machine_options(MachineCla=
ss *m)
>      m->is_default =3D 0;
>      m->alias =3D NULL;
>      SET_MACHINE_COMPAT(m, PC_COMPAT_2_10);
> +    m->auto_enable_numa_with_memhp =3D false;
>  }
> =20
>  DEFINE_I440FX_MACHINE(v2_10, "pc-i440fx-2.10", NULL,
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index da3ea60..d606004 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -318,6 +318,7 @@ static void pc_q35_2_10_machine_options(MachineClass =
*m)
>      m->alias =3D NULL;
>      SET_MACHINE_COMPAT(m, PC_COMPAT_2_10);
>      m->numa_auto_assign_ram =3D numa_legacy_auto_assign_ram;
> +    m->auto_enable_numa_with_memhp =3D false;
>  }
> =20
>  DEFINE_Q35_MACHINE(v2_10, "pc-q35-2.10", NULL,
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 191a5b3..f1077f1 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -192,6 +192,7 @@ struct MachineClass {
>      bool ignore_memory_transaction_failures;
>      int numa_mem_align_shift;
>      const char **valid_cpu_types;
> +    bool auto_enable_numa_with_memhp;
>      void (*numa_auto_assign_ram)(MachineClass *mc, NodeInfo *nodes,
>                                   int nb_nodes, ram_addr_t size);
> =20
> diff --git a/numa.c b/numa.c
> index 8d78d95..7151b24 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -216,6 +216,7 @@ static void parse_numa_node(MachineState *ms, NumaNod=
eOptions *node,
>      }
>      numa_info[nodenr].present =3D true;
>      max_numa_nodeid =3D MAX(max_numa_nodeid, nodenr + 1);
> +    nb_numa_nodes++;
>  }
> =20
>  static void parse_numa_distance(NumaDistOptions *dist, Error **errp)
> @@ -282,7 +283,6 @@ static int parse_numa(void *opaque, QemuOpts *opts, E=
rror **errp)
>          if (err) {
>              goto end;
>          }
> -        nb_numa_nodes++;
>          break;
>      case NUMA_OPTIONS_TYPE_DIST:
>          parse_numa_distance(&object->u.dist, &err);
> @@ -433,6 +433,25 @@ void parse_numa_opts(MachineState *ms)
>          exit(1);
>      }
> =20
> +    /*
> +     * If memory hotplug is enabled (slots > 0) but without '-numa'
> +     * options explicitly on CLI, guestes will break.
s/guestes/guests/

> +     *
> +     *   Windows: won't enable memory hotplug without SRAT table at all
> +     *
> +     *   Linux: if QEMU is started with initial memory all below 4Gb
> +     *   and no SRAT table present, guest kernel will use nommu DMA ops,
> +     *   which breaks 32bit hw drivers when memory is hotplugged and
> +     *   guest tries to use it with that drivers.
> +     *
> +     * Enable NUMA implicitly by adding a new NUMA node automatically.
> +     */
> +    if (ms->ram_slots > 0 && nb_numa_nodes =3D=3D 0 &&
> +        mc->auto_enable_numa_with_memhp) {
> +            NumaNodeOptions node =3D { };
> +            parse_numa_node(ms, &node, NULL);
I get build break here:

numa.c:451:13: error: too few arguments to function =E2=80=98parse_numa_nod=
e=E2=80=99
             parse_numa_node(ms, &node, NULL);

> +    }
> +
>      assert(max_numa_nodeid <=3D MAX_NODES);
> =20
>      /* No support for sparse NUMA node IDs yet: */
> diff --git a/vl.c b/vl.c
> index ec29909..be332d1 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4675,8 +4675,6 @@ int main(int argc, char **argv, char **envp)
>      default_drive(default_floppy, snapshot, IF_FLOPPY, 0, FD_OPTS);
>      default_drive(default_sdcard, snapshot, IF_SD, 0, SD_OPTS);
> =20
> -    parse_numa_opts(current_machine);
> -
>      if (qemu_opts_foreach(qemu_find_opts("mon"),
>                            mon_init_func, NULL, NULL)) {
>          exit(1);
> @@ -4726,6 +4724,7 @@ int main(int argc, char **argv, char **envp)
>      current_machine->boot_order =3D boot_order;
>      current_machine->cpu_model =3D cpu_model;
> =20
> +    parse_numa_opts(current_machine);
> =20
>      /* parse features once if machine provides default cpu_type */
>      if (machine_class->default_cpu_type) {
