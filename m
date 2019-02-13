Received: from eggs.gnu.org ([209.51.188.92]:59756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtlvq-0003Dt-Kn
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 23:13:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtlvp-00058z-4a
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 23:13:58 -0500
Date: Wed, 13 Feb 2019 12:25:45 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190213012544.GS1884@umbus.fritz.box>
References: <20190212214827.30543-1-lvivier@redhat.com>
	<20190212214827.30543-2-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4ZVTVymsHR1TEBjP"
Content-Disposition: inline
In-Reply-To: <20190212214827.30543-2-lvivier@redhat.com>
Subject: Re: [Qemu-devel] [RFC 1/4] numa,
 spapr: add thread-id in the possible_cpus list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>


--4ZVTVymsHR1TEBjP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 12, 2019 at 10:48:24PM +0100, Laurent Vivier wrote:
> spapr_possible_cpu_arch_ids() counts only cores, and so
> the number of available CPUs is the number of vCPU divided
> by smp_threads.
>=20
> ... -smp 4,maxcpus=3D8,cores=3D2,threads=3D2,sockets=3D2 -numa node,cpus=
=3D0,cpus=3D1 \
>                                                  -numa node,cpus=3D3,cpus=
=3D4 \
>                                                  -numa node -numa node
>=20
> This generates (info hotpluggable-cpus)
>=20
>   node-id: 0 core-id: 0 thread-id: 0 [thread-id: 1]
>   node-id: 0 core-id: 6 thread-id: 0 [thread-id: 1]
>   node-id: 1 core-id: 2 thread-id: 0 [thread-id: 1]
>   node-id: 1 core-id: 4 thread-id: 0 [thread-id: 1]
>=20
> And this command line generates the following error:
>=20
>   CPU(s) not present in any NUMA nodes: CPU 3 [core-id: 6]
>=20
> That is wrong because CPU 3 [core-id: 6] is assigned to node-id 0
> Moreover "cpus=3D4" is not valid, because it means core-id 8 but
> maxcpus is 8.
>=20
> With this patch we have now:
>=20
>   node-id: 0 core-id: 0 thread-id: 0
>   node-id: 0 core-id: 0 thread-id: 1
>   node-id: 0 core-id: 1 thread-id: 0
>   node-id: 1 core-id: 1 thread-id: 1
>   node-id: 0 core-id: 2 thread-id: 1
>   node-id: 1 core-id: 2 thread-id: 0
>   node-id: 0 core-id: 3 thread-id: 1
>   node-id: 0 core-id: 3 thread-id: 0

I'm afraid this is not the right solution.  The point of the
hotpluggable cpus table is that it has exactly one entry for each
hotpluggable unit.  For PAPR that's a core, not a thread.

So, the problem is with how the NUMA configuration code is
interpreting possible-cpus, not how the machine is building the table.

> CPUs 0 (core-id: 0 thread-id: 0) and 1 (core-id: 0 thread-id: 1) are
> correctly assigned to node-id 0, CPUs 3 (core-id: 1 thread-id: 1) and
>  4 (core-id: 2 thread-id: 0) are correctly assigned to node-id 1.
> All other CPUs are assigned to node-id 0 by default.
>=20
> And the error message is also correct:
>=20
>   CPU(s) not present in any NUMA nodes: CPU 2 [core-id: 1, thread-id: 0],=
 \
>                                         CPU 5 [core-id: 2, thread-id: 1],=
 \
>                                         CPU 6 [core-id: 3, thread-id: 0],=
 \
>                                         CPU 7 [core-id: 3, thread-id: 1]
>=20
> Fixes: ec78f8114bc4 ("numa: use possible_cpus for not mapped CPUs check")
> Cc: imammedo@redhat.com
>=20
> Before commit ec78f8114bc4, output was correct:
>=20
>   CPU(s) not present in any NUMA nodes: 2 5 6 7
>=20
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  hw/ppc/spapr.c | 33 +++++++++++++--------------------
>  1 file changed, 13 insertions(+), 20 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 332cba89d425..7196ba09da34 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2404,15 +2404,13 @@ static void spapr_validate_node_memory(MachineSta=
te *machine, Error **errp)
>  /* find cpu slot in machine->possible_cpus by core_id */
>  static CPUArchId *spapr_find_cpu_slot(MachineState *ms, uint32_t id, int=
 *idx)
>  {
> -    int index =3D id / smp_threads;
> -
> -    if (index >=3D ms->possible_cpus->len) {
> +    if (id >=3D ms->possible_cpus->len) {
>          return NULL;
>      }
>      if (idx) {
> -        *idx =3D index;
> +        *idx =3D id;
>      }
> -    return &ms->possible_cpus->cpus[index];
> +    return &ms->possible_cpus->cpus[id];
>  }
> =20
>  static void spapr_set_vsmt_mode(sPAPRMachineState *spapr, Error **errp)
> @@ -2514,7 +2512,7 @@ static void spapr_init_cpus(sPAPRMachineState *spap=
r)
>              error_report("This machine version does not support CPU hotp=
lug");
>              exit(1);
>          }
> -        boot_cores_nr =3D possible_cpus->len;
> +        boot_cores_nr =3D possible_cpus->len / smp_threads;
>      }
> =20
>      if (smc->pre_2_10_has_unused_icps) {
> @@ -2528,7 +2526,7 @@ static void spapr_init_cpus(sPAPRMachineState *spap=
r)
>          }
>      }
> =20
> -    for (i =3D 0; i < possible_cpus->len; i++) {
> +    for (i =3D 0; i < possible_cpus->len / smp_threads; i++) {
>          int core_id =3D i * smp_threads;
> =20
>          if (mc->has_hotpluggable_cpus) {
> @@ -3795,21 +3793,16 @@ spapr_cpu_index_to_props(MachineState *machine, u=
nsigned cpu_index)
> =20
>  static int64_t spapr_get_default_cpu_node_id(const MachineState *ms, int=
 idx)
>  {
> -    return idx / smp_cores % nb_numa_nodes;
> +    return idx / (smp_cores * smp_threads) % nb_numa_nodes;
>  }
> =20
>  static const CPUArchIdList *spapr_possible_cpu_arch_ids(MachineState *ma=
chine)
>  {
>      int i;
>      const char *core_type;
> -    int spapr_max_cores =3D max_cpus / smp_threads;
> -    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
> =20
> -    if (!mc->has_hotpluggable_cpus) {
> -        spapr_max_cores =3D QEMU_ALIGN_UP(smp_cpus, smp_threads) / smp_t=
hreads;
> -    }
>      if (machine->possible_cpus) {
> -        assert(machine->possible_cpus->len =3D=3D spapr_max_cores);
> +        assert(machine->possible_cpus->len =3D=3D max_cpus);
>          return machine->possible_cpus;
>      }
> =20
> @@ -3820,16 +3813,16 @@ static const CPUArchIdList *spapr_possible_cpu_ar=
ch_ids(MachineState *machine)
>      }
> =20
>      machine->possible_cpus =3D g_malloc0(sizeof(CPUArchIdList) +
> -                             sizeof(CPUArchId) * spapr_max_cores);
> -    machine->possible_cpus->len =3D spapr_max_cores;
> +                             sizeof(CPUArchId) * max_cpus);
> +    machine->possible_cpus->len =3D max_cpus;
>      for (i =3D 0; i < machine->possible_cpus->len; i++) {
> -        int core_id =3D i * smp_threads;
> -
>          machine->possible_cpus->cpus[i].type =3D core_type;
>          machine->possible_cpus->cpus[i].vcpus_count =3D smp_threads;
> -        machine->possible_cpus->cpus[i].arch_id =3D core_id;
> +        machine->possible_cpus->cpus[i].arch_id =3D i;
>          machine->possible_cpus->cpus[i].props.has_core_id =3D true;
> -        machine->possible_cpus->cpus[i].props.core_id =3D core_id;
> +        machine->possible_cpus->cpus[i].props.core_id =3D i / smp_thread=
s;
> +        machine->possible_cpus->cpus[i].props.has_thread_id =3D true;
> +        machine->possible_cpus->cpus[i].props.thread_id =3D i % smp_thre=
ads;
>      }
>      return machine->possible_cpus;
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4ZVTVymsHR1TEBjP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxjchYACgkQbDjKyiDZ
s5Im+A/+NtePU5hUyed9y/jtyUZJLnOCISb/o6Yo3S3xxgNSEiq8h0Itk3XBiyEy
FxoF011MeguYx7QMifXR3kSNwMEXrfO1eXyRZ/dumQHqJdFZx1J1NLs9E7hsWrwi
FVXx/rgiWmozn/g4VBopZP3o3fhqYvw0cmqIhPtCms/Sz8O0yX8yWPQI2PtrCfFS
Lw8QdTZ2v0aaYJo3DrSCLe1RMxTG1iK9W1AAnQBfVxW59Lb3crzNSVFBooVgUFqt
qv+6x87RIyHMacPD/Rlf2go7t1Hmg8Im00BMwhoQJl9PEoEHuhUkk8k74rkYE6xH
8FZwiM4qzIcXrKg4wqH2Kc8AEzbEZNpXLndBypzJJRSNVZ1mAAoz/vhXWgo2FYc6
8B83RBnaa94ZiigewWcngPgM8+Tc2ceTv4PFt6B6Ky1rX6Apk0x0/5FJA8Z2ejqS
uPm0EpPob4Xy44DXj1J8dDIPvxIwh1aZzCoqRpK8h7zCS9hWQmE1tRFub/xqUZvM
Mp1EM6/2gy8OfwtfR0QTgzg0uxog1+++8L0lN5hiTnSE7THVk/cvwb1lJxXiAMI7
IeDTBNsY9dz2XX3c7B8aF59XjE9UCzn3xpnOi/xKGnxOLwfC2BEo4la3rBqUj8Rp
C6aso3e18Oxg26VMORNhdIyWR5ib+Qnx3Dh/gEz2e9RpI+oCg4Y=
=lH7r
-----END PGP SIGNATURE-----

--4ZVTVymsHR1TEBjP--
