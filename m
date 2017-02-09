Received: from eggs.gnu.org ([2001:4830:134:3::10]:37785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbyUI-000060-JX
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 18:50:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbyUH-0005Yh-JZ
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 18:50:54 -0500
Date: Fri, 10 Feb 2017 10:26:29 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170209232629.GD27610@umbus.fritz.box>
References: <1486638518-171446-1-git-send-email-imammedo@redhat.com>
	<1486638518-171446-4-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NtwzykIc2mflq5ck"
Content-Disposition: inline
In-Reply-To: <1486638518-171446-4-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/7] pc: calculate topology only once when
 possible_cpus is initialised
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


--NtwzykIc2mflq5ck
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 09, 2017 at 12:08:34PM +0100, Igor Mammedov wrote:
> Fill in CpuInstanceProperties once at board init time and
> just copy them whenever query_hotpluggable_cpus() is called.
> It will keep topology info always available without need
> to recalculate it every time it's needed.
> Considering it has NUMA node id, it will be used to keep
> NUMA node to cpu mapping instead of numa_info[i].node_cpu
> bitmasks.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/hw/boards.h |  2 ++
>  hw/i386/pc.c        | 24 ++++++++++++------------
>  2 files changed, 14 insertions(+), 12 deletions(-)
>=20
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 64e8c07..4023b38 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -46,9 +46,11 @@ void machine_register_compat_props(MachineState *machi=
ne);
>   * CPUArchId:
>   * @arch_id - architecture-dependent CPU ID of present or possible CPU
>   * @cpu - pointer to corresponding CPU object if it's present on NULL ot=
herwise
> + * @props - CPU object properties, initialized by board
>   */
>  typedef struct {
>      uint64_t arch_id;
> +    CpuInstanceProperties props;
>      struct CPUState *cpu;
>  } CPUArchId;
> =20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index a6cfc97..f03a555 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -2262,7 +2262,17 @@ static const CPUArchIdList *pc_possible_cpu_arch_i=
ds(MachineState *ms)
>                                    sizeof(CPUArchId) * max_cpus);
>      ms->possible_cpus->len =3D max_cpus;
>      for (i =3D 0; i < ms->possible_cpus->len; i++) {
> +        X86CPUTopoInfo topo;
> +
>          ms->possible_cpus->cpus[i].arch_id =3D x86_cpu_apic_id_from_inde=
x(i);
> +        x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
> +                                 smp_cores, smp_threads, &topo);
> +        ms->possible_cpus->cpus[i].props.has_socket_id =3D true;
> +        ms->possible_cpus->cpus[i].props.socket_id =3D topo.pkg_id;
> +        ms->possible_cpus->cpus[i].props.has_core_id =3D true;
> +        ms->possible_cpus->cpus[i].props.core_id =3D topo.core_id;
> +        ms->possible_cpus->cpus[i].props.has_thread_id =3D true;
> +        ms->possible_cpus->cpus[i].props.thread_id =3D topo.smt_id;
>      }
>      return ms->possible_cpus;
>  }
> @@ -2279,23 +2289,13 @@ static HotpluggableCPUList *pc_query_hotpluggable=
_cpus(MachineState *machine)
>      cpu_type =3D object_class_get_name(OBJECT_CLASS(CPU_GET_CLASS(cpu)));
> =20
>      for (i =3D 0; i < machine->possible_cpus->len; i++) {
> -        X86CPUTopoInfo topo;
>          HotpluggableCPUList *list_item =3D g_new0(typeof(*list_item), 1);
>          HotpluggableCPU *cpu_item =3D g_new0(typeof(*cpu_item), 1);
> -        CpuInstanceProperties *cpu_props =3D g_new0(typeof(*cpu_props), =
1);
> -        const uint32_t apic_id =3D machine->possible_cpus->cpus[i].arch_=
id;
> -
> -        x86_topo_ids_from_apicid(apic_id, smp_cores, smp_threads, &topo);
> =20
>          cpu_item->type =3D g_strdup(cpu_type);
>          cpu_item->vcpus_count =3D 1;
> -        cpu_props->has_socket_id =3D true;
> -        cpu_props->socket_id =3D topo.pkg_id;
> -        cpu_props->has_core_id =3D true;
> -        cpu_props->core_id =3D topo.core_id;
> -        cpu_props->has_thread_id =3D true;
> -        cpu_props->thread_id =3D topo.smt_id;
> -        cpu_item->props =3D cpu_props;
> +        cpu_item->props =3D g_memdup(&machine->possible_cpus->cpus[i].pr=
ops,
> +                                   sizeof(*cpu_item->props));
> =20
>          cpu =3D machine->possible_cpus->cpus[i].cpu;
>          if (cpu) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NtwzykIc2mflq5ck
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYnPqlAAoJEGw4ysog2bOSVSMP/ib8WUq+KBfU1VgBhAFfA5Zq
8kGKs+AmFR9OkgDTU/V7gg2hr97XX25AnI2Hyu/BgjIECtORh5zdrC+OdzDJYaGQ
55K94Ao0f++LRIJXdmwmgxkM/FAC0RHQZBJfxgECEz1MgR9+mlV3oN/qoa7sc1rt
YyZ+3D3eIl39CyHVTC/RsFETHJPIKjN0yd27aSoBNeXffh+8Yk/MRijEifwcOVkV
xboxZm4X3Krbcr7avtcCeSXs+CN0gh+Vw8qvHx918ks2lU01K4CSESWpISXLQqVY
lcR/lpES/oAH8Ub0xiPAxVhoPi+f0HlInrwialfOD+UrjSlDEZCG6d+uDq8Mea0w
p2rXuXg2PYkyjWr7yfn59Zvv7S9OtKMVf7iWM25bmjumWojnylT+0YcFf9yBt/of
r92LyobzvlI6NKu/lqidQ5dODpk56ys4xEacKtTtFYgumhNQHyqlNYuHsSuW57Aj
fBDpqPaFGVV4jNW77JldujA0M3h+XwoM42qmLZC13yVXRPHRwHGIZVI5SZ29fiKa
DrLTGki13a1xuuJyKzKaEFd9favyBWHwsMAn7NKIivCKQdv5EZB9radJL13i2HMq
1HTpnshl7B0/xxsreWOeraAQ5lTIgRGWWycqDgNQ2sSgLczA/6xMBnRyobWpAyio
omr4Ar20FG2NJZafoGOM
=jnt0
-----END PGP SIGNATURE-----

--NtwzykIc2mflq5ck--
