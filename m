Received: from eggs.gnu.org ([2001:4830:134:3::10]:50670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fAkuR-00084N-1e
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 19:30:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fAkuP-0001EN-Mj
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 19:30:11 -0400
Date: Tue, 24 Apr 2018 09:29:30 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180423232930.GJ19804@umbus.fritz.box>
References: <20180423165126.15441-1-david@redhat.com>
	<20180423165126.15441-11-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HSQ3hISbU3Um6hch"
Content-Disposition: inline
In-Reply-To: <20180423165126.15441-11-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 10/11] spapr: rename "hotplug memory"
 terminology to "device memory"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Alexander Graf <agraf@suse.de>


--HSQ3hISbU3Um6hch
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 23, 2018 at 06:51:25PM +0200, David Hildenbrand wrote:
> Let's make it clear at relevant places that we are dealing with device
> memory. That it can be used for memory hotplug is just a special case.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/spapr.c         | 28 ++++++++++++++--------------
>  include/hw/ppc/spapr.h |  4 ++--
>  2 files changed, 16 insertions(+), 16 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 8ecb716f72..a32b88e41d 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -681,7 +681,7 @@ static int spapr_populate_drconf_memory(sPAPRMachineS=
tate *spapr, void *fdt)
>      int ret, i, offset;
>      uint64_t lmb_size =3D SPAPR_MEMORY_BLOCK_SIZE;
>      uint32_t prop_lmb_size[] =3D {0, cpu_to_be32(lmb_size)};
> -    uint32_t hotplug_lmb_start =3D machine->device_memory->base / lmb_si=
ze;
> +    uint32_t device_lmb_start =3D machine->device_memory->base / lmb_siz=
e;
>      uint32_t nr_lmbs =3D (machine->device_memory->base +
>                         memory_region_size(&machine->device_memory->mr)) /
>                         lmb_size;
> @@ -690,7 +690,7 @@ static int spapr_populate_drconf_memory(sPAPRMachineS=
tate *spapr, void *fdt)
>      MemoryDeviceInfoList *dimms =3D NULL;
> =20
>      /*
> -     * Don't create the node if there is no hotpluggable memory
> +     * Don't create the node if there is no device memory
>       */
>      if (machine->ram_size =3D=3D machine->maxram_size) {
>          return 0;
> @@ -722,7 +722,7 @@ static int spapr_populate_drconf_memory(sPAPRMachineS=
tate *spapr, void *fdt)
>          goto out;
>      }
> =20
> -    if (hotplug_lmb_start) {
> +    if (device_lmb_start) {
>          dimms =3D qmp_memory_device_list();
>      }
> =20
> @@ -733,7 +733,7 @@ static int spapr_populate_drconf_memory(sPAPRMachineS=
tate *spapr, void *fdt)
>          uint64_t addr =3D i * lmb_size;
>          uint32_t *dynamic_memory =3D cur_index;
> =20
> -        if (i >=3D hotplug_lmb_start) {
> +        if (i >=3D device_lmb_start) {
>              sPAPRDRConnector *drc;
> =20
>              drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_LMB, i);
> @@ -752,7 +752,7 @@ static int spapr_populate_drconf_memory(sPAPRMachineS=
tate *spapr, void *fdt)
>          } else {
>              /*
>               * LMB information for RMA, boot time RAM and gap b/n RAM and
> -             * hotplug memory region -- all these are marked as reserved
> +             * device memory region -- all these are marked as reserved
>               * and as having no valid DRC.
>               */
>              dynamic_memory[0] =3D cpu_to_be32(addr >> 32);
> @@ -903,11 +903,11 @@ static void spapr_dt_rtas(sPAPRMachineState *spapr,=
 void *fdt)
>      GString *hypertas =3D g_string_sized_new(256);
>      GString *qemu_hypertas =3D g_string_sized_new(256);
>      uint32_t refpoints[] =3D { cpu_to_be32(0x4), cpu_to_be32(0x4) };
> -    uint64_t max_hotplug_addr =3D MACHINE(spapr)->device_memory->base +
> +    uint64_t max_device_addr =3D MACHINE(spapr)->device_memory->base +
>          memory_region_size(&MACHINE(spapr)->device_memory->mr);
>      uint32_t lrdr_capacity[] =3D {
> -        cpu_to_be32(max_hotplug_addr >> 32),
> -        cpu_to_be32(max_hotplug_addr & 0xffffffff),
> +        cpu_to_be32(max_device_addr >> 32),
> +        cpu_to_be32(max_device_addr & 0xffffffff),
>          0, cpu_to_be32(SPAPR_MEMORY_BLOCK_SIZE),
>          cpu_to_be32(max_cpus / smp_threads),
>      };
> @@ -2531,7 +2531,7 @@ static void spapr_machine_init(MachineState *machin=
e)
> =20
>      /* initialize device memory address space */
>      if (machine->ram_size < machine->maxram_size) {
> -        ram_addr_t hotplug_mem_size =3D machine->maxram_size - machine->=
ram_size;
> +        ram_addr_t device_mem_size =3D machine->maxram_size - machine->r=
am_size;
>          /*
>           * Limit the number of hotpluggable memory slots to half the num=
ber
>           * slots that KVM supports, leaving the other half for PCI and o=
ther
> @@ -2551,9 +2551,9 @@ static void spapr_machine_init(MachineState *machin=
e)
>          }
> =20
>          machine->device_memory->base =3D ROUND_UP(machine->ram_size,
> -                                              SPAPR_HOTPLUG_MEM_ALIGN);
> +                                                SPAPR_DEVICE_MEM_ALIGN);
>          memory_region_init(&machine->device_memory->mr, OBJECT(spapr),
> -                           "hotplug-memory", hotplug_mem_size);
> +                           "device-memory", device_mem_size);
>          memory_region_add_subregion(sysmem, machine->device_memory->base,
>                                      &machine->device_memory->mr);
>      }
> @@ -4154,11 +4154,11 @@ static void phb_placement_2_7(sPAPRMachineState *=
spapr, uint32_t index,
>      hwaddr phb0_base, phb_base;
>      int i;
> =20
> -    /* Do we have hotpluggable memory? */
> +    /* Do we have device memory? */
>      if (MACHINE(spapr)->maxram_size > ram_top) {
>          /* Can't just use maxram_size, because there may be an
> -         * alignment gap between normal and hotpluggable memory
> -         * regions */
> +         * alignment gap between normal and device memory regions
> +         */
>          ram_top =3D MACHINE(spapr)->device_memory->base +
>              memory_region_size(&MACHINE(spapr)->device_memory->mr);
>      }
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 56ff02d32a..3388750fc7 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -747,8 +747,8 @@ int spapr_rng_populate_dt(void *fdt);
>   */
>  #define SPAPR_MAX_RAM_SLOTS     32
> =20
> -/* 1GB alignment for hotplug memory region */
> -#define SPAPR_HOTPLUG_MEM_ALIGN (1ULL << 30)
> +/* 1GB alignment for device memory region */
> +#define SPAPR_DEVICE_MEM_ALIGN (1ULL << 30)
> =20
>  /*
>   * Number of 32 bit words in each LMB list entry in ibm,dynamic-memory

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HSQ3hISbU3Um6hch
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrebFgACgkQbDjKyiDZ
s5KtsQ//djyYLOaxTBJaTIfd51qHyNcA/gu1GV5EHnO5olg2atVXqci3ReLa8Zz0
yoIj84GM41ld5aPWYSxClaQsBn0J+/8wJR2GDZuPofe+dnIS5sNT5rTZH0GfBtr/
yPE1FSe5fjRb34xJ0afbp7TCWcAZki7SeWMHBtxzcutSU+kRdu7xz50kyql2zCax
0Idrdh3YlcSsUcQhQ1nK8FNLVelraRKAkmkdCieF/3CJwgBXAXaY8i9rgOUOqwM2
8Y8LoUPl19V7aovSflpqRKMAZ7lSx77J3nZygWc1S6q/kUdYHEDtnziwndhXtcVB
UsDrd36zJQnRCHlGgGjSK4hmnIRgrirV8aanh7+US5ry06VkIGDOlnAWynb8LTp6
Oxj75i8STKLsJwhlO73ugIg3Nk9rk84K4X3bwhyvSinpSXM2J89SvJASzoKAPwFU
PLz00acX9egAAXzvDBFpEgb+dOG4AZs1S9N5WTPlHVu/hTwEDq8l1XzEE4b6P0Am
JRwxEwqhxOEDwsSq1Sae5d8ZioBKgmWdDH42mMM4kWOBmbYRIDv06InGckyj9nW8
5mXmQI/kTNptp816b3XJ0vu0Vkbjc3o/DYuVYOQQmw/91fKRU7o4jwT5B3yMZhHk
JaPs5XAUMSo/j5xhRZqQ0q2cU1IAieJqgc36n6Ju+zwOxPsgX90=
=LbrD
-----END PGP SIGNATURE-----

--HSQ3hISbU3Um6hch--
