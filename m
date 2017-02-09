Received: from eggs.gnu.org ([2001:4830:134:3::10]:37823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbyUL-00006C-Fg
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 18:50:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbyUH-0005Yk-K0
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 18:50:57 -0500
Date: Fri, 10 Feb 2017 10:33:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170209233304.GF27610@umbus.fritz.box>
References: <1486638518-171446-1-git-send-email-imammedo@redhat.com>
	<1486638518-171446-6-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/QKKmeG/X/bPShih"
Content-Disposition: inline
In-Reply-To: <1486638518-171446-6-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/7] change CPUArchId.cpu type to Object*
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


--/QKKmeG/X/bPShih
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 09, 2017 at 12:08:36PM +0100, Igor Mammedov wrote:
> so it could be reused for SPAPR cores as well
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/hw/boards.h | 2 +-
>  hw/acpi/cpu.c       | 2 +-
>  hw/i386/pc.c        | 8 ++++----
>  3 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 4023b38..60209df 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -51,7 +51,7 @@ void machine_register_compat_props(MachineState *machin=
e);
>  typedef struct {
>      uint64_t arch_id;
>      CpuInstanceProperties props;
> -    struct CPUState *cpu;
> +    Object *cpu;
>  } CPUArchId;
> =20
>  /**
> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> index 6017ca0..8c719d3 100644
> --- a/hw/acpi/cpu.c
> +++ b/hw/acpi/cpu.c
> @@ -198,7 +198,7 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object *ow=
ner,
>      state->dev_count =3D id_list->len;
>      state->devs =3D g_new0(typeof(*state->devs), state->dev_count);
>      for (i =3D 0; i < id_list->len; i++) {
> -        state->devs[i].cpu =3D  id_list->cpus[i].cpu;
> +        state->devs[i].cpu =3D  CPU(id_list->cpus[i].cpu);
>          state->devs[i].arch_id =3D id_list->cpus[i].arch_id;
>      }
>      memory_region_init_io(&state->ctrl_reg, owner, &cpu_hotplug_ops, sta=
te,
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index ec6dded..afaae15 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1824,7 +1824,7 @@ static void pc_cpu_plug(HotplugHandler *hotplug_dev,
>      }
> =20
>      found_cpu =3D pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, NULL);
> -    found_cpu->cpu =3D CPU(dev);
> +    found_cpu->cpu =3D OBJECT(dev);
>  out:
>      error_propagate(errp, local_err);
>  }
> @@ -2282,13 +2282,13 @@ static const CPUArchIdList *pc_possible_cpu_arch_=
ids(MachineState *ms)
>  static HotpluggableCPUList *pc_query_hotpluggable_cpus(MachineState *mac=
hine)
>  {
>      int i;
> -    CPUState *cpu;
> +    Object *cpu;
>      HotpluggableCPUList *head =3D NULL;
>      const char *cpu_type;
> =20
>      cpu =3D machine->possible_cpus->cpus[0].cpu;
>      assert(cpu); /* BSP is always present */
> -    cpu_type =3D object_class_get_name(OBJECT_CLASS(CPU_GET_CLASS(cpu)));
> +    cpu_type =3D object_get_typename(cpu);
> =20
>      for (i =3D 0; i < machine->possible_cpus->len; i++) {
>          HotpluggableCPUList *list_item =3D g_new0(typeof(*list_item), 1);
> @@ -2302,7 +2302,7 @@ static HotpluggableCPUList *pc_query_hotpluggable_c=
pus(MachineState *machine)
>          cpu =3D machine->possible_cpus->cpus[i].cpu;
>          if (cpu) {
>              cpu_item->has_qom_path =3D true;
> -            cpu_item->qom_path =3D object_get_canonical_path(OBJECT(cpu)=
);
> +            cpu_item->qom_path =3D object_get_canonical_path(cpu);
>          }
> =20
>          list_item->value =3D cpu_item;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/QKKmeG/X/bPShih
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYnPwvAAoJEGw4ysog2bOSYEMP/0Bosg6IlCjYPeWa7C2rzklC
JjAuDRQoLRDBcvHz24s32ivEGCBINsA5U2GMjLMWXR/DLroxRWvo2d0i+pggRC/s
qRmDm/zFCPyMDdVY2QH0jq3sWoWaE5VikZHUFPt9/7nkt6B6Ne93uIic4uS+rBLS
Ql1JZr7BdDj/N0F4fTCQ3vZGyXer6ikvITpudYrbuphFnmOUj2ecV1xLR/mBi5HL
+vYjzUgr5EllF1cfxC+zZdrF7tNoVhA2nMVmWvwoAMOTe1hgGx3SQ6YmJ/ME7ODW
Azs07wkrVkdv6N0jYxU6qPWWZh5l1onOYyhdk7UGotWbGMS0h69loGrCr1hfDSnl
Fjl0OgkrOdr3OImJ4WmSmEhTpAn9Q1OAroEOOz1B8/QsYJfp4WwMFr++mVjDq58x
CV6JNOUOUxHD+e/QgiaOT/b0LneYwuNFsrUqHd2TZ81wqYeYyYAQoa2xsvSpq1dg
/SL8CYse0F0R3xGwOrsms9b3CM/cQJBR1zxS3k0Z1ojwrN9YGmerng+aesmJxAyx
xE2qKDYWK4wIFehHhHbGT2POo1t4h6yZyrk/q9RouNLsJ4FBcKK3h+NterxzNCGv
x/vC/EA5l+s7ehcsxuU6nTgZrpoh8m+CkHz9aapaJGKmTCJXlals06+saRfYSzFB
fmMd8I/0Sbg2E0yLM5pb
=u9cg
-----END PGP SIGNATURE-----

--/QKKmeG/X/bPShih--
