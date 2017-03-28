Received: from eggs.gnu.org ([2001:4830:134:3::10]:58307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1csjNs-0008PT-03
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 01:09:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1csjNq-0000Q2-Eg
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 01:09:31 -0400
Date: Tue, 28 Mar 2017 15:44:32 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170328044432.GE21068@umbus.fritz.box>
References: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
	<1490189568-167621-11-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k3qmt+ucFURmlhDS"
Content-Disposition: inline
In-Reply-To: <1490189568-167621-11-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 10/23] numa: mirror cpu to node
 mapping in MachineState::possible_cpus
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


--k3qmt+ucFURmlhDS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 22, 2017 at 02:32:35PM +0100, Igor Mammedov wrote:
> Introduce machine_set_cpu_numa_node() helper that stores
> node mapping for CPU in MachineState::possible_cpus.
> CPU and node it belongs to is specified by 'props' argument.
>=20
> Patch doesn't remove old way of storing mapping in
> numa_info[X].node_cpu as removing it at the same time
> makes patch rather big. Instead it just mirrors mapping
> in possible_cpus and follow up per target patches will
> switch to possible_cpus and numa_info[X].node_cpu will
> be removed once there isn't any users left.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/hw/boards.h |  2 ++
>  hw/core/machine.c   | 68 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  numa.c              |  8 +++++++
>  3 files changed, 78 insertions(+)
>=20
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 1dd0fde..40f30f1 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -42,6 +42,8 @@ bool machine_dump_guest_core(MachineState *machine);
>  bool machine_mem_merge(MachineState *machine);
>  void machine_register_compat_props(MachineState *machine);
>  HotpluggableCPUList *machine_query_hotpluggable_cpus(MachineState *machi=
ne);
> +void machine_set_cpu_numa_node(MachineState *machine,
> +                               CpuInstanceProperties *props, Error **err=
p);
> =20
>  /**
>   * CPUArchId:
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 0d92672..6ff0b45 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -388,6 +388,74 @@ HotpluggableCPUList *machine_query_hotpluggable_cpus=
(MachineState *machine)
>      return head;
>  }
> =20
> +void machine_set_cpu_numa_node(MachineState *machine,
> +                               CpuInstanceProperties *props, Error **err=
p)
> +{
> +    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
> +    bool match =3D false;
> +    int i;
> +
> +    if (!mc->possible_cpu_arch_ids) {
> +        error_setg(errp, "mapping of CPUs to NUMA node is not supported"=
);
> +        return;
> +    }
> +
> +    /* force board to initialize possible_cpus if it hasn't been done ye=
t */
> +    mc->possible_cpu_arch_ids(machine);
> +
> +    for (i =3D 0; i < machine->possible_cpus->len; i++) {
> +        CPUArchId *slot =3D &machine->possible_cpus->cpus[i];
> +
> +        /* reject unsupported by board properties */
> +        if (props->has_thread_id && !slot->props.has_thread_id) {
> +            error_setg(errp, "thread-id is not supported");
> +            return;
> +        }
> +
> +        if (props->has_core_id && !slot->props.has_core_id) {
> +            error_setg(errp, "core-id is not supported");
> +            return;
> +        }
> +
> +        if (props->has_socket_id && !slot->props.has_socket_id) {
> +            error_setg(errp, "socket-id is not supported");
> +            return;
> +        }
> +
> +        /* skip slots with explicit mismatch */
> +        if (props->has_thread_id && props->thread_id !=3D slot->props.th=
read_id) {
> +                continue;
> +        }
> +
> +        if (props->has_core_id && props->core_id !=3D slot->props.core_i=
d) {
> +                continue;
> +        }
> +
> +        if (props->has_socket_id && props->socket_id !=3D slot->props.so=
cket_id) {
> +                continue;
> +        }
> +
> +        /* reject assignment if slot is already assigned, for compatibil=
ity
> +         * of legacy cpu_index mapping with SPAPR core based mapping do =
not
> +         * error out if cpu thread and matched core have the same node-i=
d */
> +        if (slot->props.has_node_id &&
> +            slot->props.node_id !=3D props->node_id) {
> +            error_setg(errp, "CPU is already assigned to node-id: %" PRI=
d64,
> +                       slot->props.node_id);
> +            return;
> +        }
> +
> +        /* assign slot to node as it's matched '-numa cpu' key */
> +        match =3D true;
> +        slot->props.node_id =3D props->node_id;
> +        slot->props.has_node_id =3D props->has_node_id;
> +    }
> +
> +    if (!match) {
> +        error_setg(errp, "no match found");
> +    }
> +}
> +
>  static void machine_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
> diff --git a/numa.c b/numa.c
> index 24c596d..44057f1 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -169,6 +169,7 @@ static void numa_node_parse(MachineState *ms, NumaNod=
eOptions *node,
>          exit(1);
>      }
>      for (cpus =3D node->cpus; cpus; cpus =3D cpus->next) {
> +        CpuInstanceProperties props;
>          if (cpus->value >=3D max_cpus) {
>              error_setg(errp,
>                         "CPU index (%" PRIu16 ")"
> @@ -177,6 +178,10 @@ static void numa_node_parse(MachineState *ms, NumaNo=
deOptions *node,
>              return;
>          }
>          bitmap_set(numa_info[nodenr].node_cpu, cpus->value, 1);
> +        props =3D mc->cpu_index_to_instance_props(ms, cpus->value);
> +        props.node_id =3D nodenr;
> +        props.has_node_id =3D true;
> +        machine_set_cpu_numa_node(ms, &props, &error_fatal);
>      }
> =20
>      if (node->has_mem && node->has_memdev) {
> @@ -393,9 +398,12 @@ void parse_numa_opts(MachineState *ms)
>          if (i =3D=3D nb_numa_nodes) {
>              for (i =3D 0; i < max_cpus; i++) {
>                  CpuInstanceProperties props;
> +                /* fetch default mapping from board and enable it */
>                  props =3D mc->cpu_index_to_instance_props(ms, i);
> +                props.has_node_id =3D true;
> =20
>                  set_bit(i, numa_info[props.node_id].node_cpu);
> +                machine_set_cpu_numa_node(ms, &props, &error_fatal);
>              }
>          }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--k3qmt+ucFURmlhDS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY2eotAAoJEGw4ysog2bOS7+wP+wRgqrXF2p1jLLIwbVvvNh0E
/+XxVyAoeLMNKz+c3A/JTto59HvwnpNXN8AQ8NZla8mkNvrFrQIzEcRvDi73p333
X2dvs/ctNUYeEbk9YNts3ZJwNcHdAyO9e3g5tLix3TMtX4jveaYdRR9u4jxoTI0b
EZ5+HZ847ceCxu98XvX0uvkYsCYNEJW6OJ38yPZZ8yGM4So34KLeQI14LjfrcF4e
DcveuxgNzipCTMAZG4CE0quPrJwW+Pp3V6idUlbIkfKmUCY9RuuygU0aBJCyxFlQ
w384xUUs+V6KT3oGNcoby2LpmnwIb5z+9vbPJIep1+W2EjJGpDDqF+b84sTM2qyh
Xt0OuDiANIZyUfaZBjrNvCIGcHX5ZC4nCwAKr4ZOw93KOjuqbHKvuOUAsdE3jLUH
Cm8UwzjL/Bg7ASmxE2XuG0Li+ADxjcGeDnWyfT8HO0O+XM1ODViFN412XfzgV1Ro
Qfrhh7i3f5MmWkWbGwXjQTHuKDSrtj/InmXKPBTJkXgb+hYn1xsJdghqi3SlOw10
8vBRVEL3Q5CY8WZWWeBzrjDgkEnuJNB/la+wU7AcPOX4X6xrcZEZu7sVbF9BKr+T
D2mec9CpP6ysgVwfmF8hHBi7p3aXB0vN0nJUQ0Goi5IJxbcXaCmkcdjslSnzZxvA
YuvQHz6E6B1stp8lDOyw
=l973
-----END PGP SIGNATURE-----

--k3qmt+ucFURmlhDS--
