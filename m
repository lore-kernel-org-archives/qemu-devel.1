Received: from eggs.gnu.org ([2001:4830:134:3::10]:41820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f8FCj-00011O-Db
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 21:14:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f8FCh-0003Rd-1N
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 21:14:41 -0400
Date: Tue, 17 Apr 2018 11:14:27 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180417011427.GE20551@umbus.fritz.box>
References: <20180416085512.4011-1-bharata@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6e7ZaeXHKrTJCxdu"
Content-Disposition: inline
In-Reply-To: <20180416085512.4011-1-bharata@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3] spapr: Support ibm,
 dynamic-memory-v2 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, nfont@linux.vnet.ibm.com, mwb@linux.vnet.ibm.com, imammedo@redhat.com


--6e7ZaeXHKrTJCxdu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 16, 2018 at 02:25:12PM +0530, Bharata B Rao wrote:
> The new property ibm,dynamic-memory-v2 allows memory to be represented
> in a more compact manner in device tree.
>=20
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> ---
> v2 - https://lists.nongnu.org/archive/html/qemu-ppc/2018-04/msg00052.html
> Changes in v3:
> - Addressed David Gibson's review comments: use of CamelCase, separate
>   helper for populating drconf_cell queue entries, removed the user
>   configurability of drmem_v2 machine property.
> =20
>  docs/specs/ppc-spapr-hotplug.txt |  19 ++++
>  hw/ppc/spapr.c                   | 233 +++++++++++++++++++++++++++++++--=
------
>  include/hw/ppc/spapr.h           |   1 +
>  include/hw/ppc/spapr_ovec.h      |   1 +
>  4 files changed, 207 insertions(+), 47 deletions(-)
>=20
> diff --git a/docs/specs/ppc-spapr-hotplug.txt b/docs/specs/ppc-spapr-hotp=
lug.txt
> index f57e2a09c6..cc7833108e 100644
> --- a/docs/specs/ppc-spapr-hotplug.txt
> +++ b/docs/specs/ppc-spapr-hotplug.txt
> @@ -387,4 +387,23 @@ Each LMB list entry consists of the following elemen=
ts:
>  - A 32bit flags word. The bit at bit position 0x00000008 defines whether
>    the LMB is assigned to the the partition as of boot time.
> =20
> +ibm,dynamic-memory-v2
> +
> +This property describes the dynamically reconfigurable memory. This is
> +an alternate and newer way to describe dyanamically reconfigurable memor=
y.
> +It is a property encoded array that has an integer N (the number of
> +LMB set entries) followed by N LMB set entries. There is an LMB set entry
> +for each sequential group of LMBs that share common attributes.
> +
> +Each LMB set entry consists of the following elements:
> +
> +- Number of sequential LMBs in the entry represented by a 32bit integer.
> +- Logical address of the first LMB in the set encoded as a 64bit integer.
> +- DRC index of the first LMB in the set.
> +- Associativity list index that is used as an index into
> +  ibm,associativity-lookup-arrays property described earlier. This
> +  is used to retrieve the right associativity list to be used for all
> +  the LMBs in this set.
> +- A 32bit flags word that applies to all the LMBs in the set.
> +
>  [1] http://thread.gmane.org/gmane.linux.ports.ppc.embedded/75350/focus=
=3D106867
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 3ffadd6ac7..fe327f3c1b 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -669,63 +669,136 @@ static uint32_t spapr_pc_dimm_node(MemoryDeviceInf=
oList *list, ram_addr_t addr)
>      return -1;
>  }
> =20
> -/*
> - * Adds ibm,dynamic-reconfiguration-memory node.
> - * Refer to docs/specs/ppc-spapr-hotplug.txt for the documentation
> - * of this device tree node.
> - */
> -static int spapr_populate_drconf_memory(sPAPRMachineState *spapr, void *=
fdt)
> +struct sPAPRDrconfCellV2 {
> +     uint32_t seq_lmbs;
> +     uint64_t base_addr;
> +     uint32_t drc_index;
> +     uint32_t aa_index;
> +     uint32_t flags;
> +} __attribute__((packed));

Should be QEMU_PACKED to at least allow for the possibility of other compil=
ers.

> +
> +/* 6 uint32_t entries in sPAPRDrconfCellV2 */
> +#define SPAPR_NR_DRCONF_CELL_ENTRIES 6

Please use sizeof, as noted before.

> +
> +typedef struct DrconfCellQueue {
> +    struct sPAPRDrconfCellV2 cell;
> +    QSIMPLEQ_ENTRY(DrconfCellQueue) entry;
> +} DrconfCellQueue;
> +
> +QSIMPLEQ_HEAD(, DrconfCellQueue) drconf_queue
> +    =3D QSIMPLEQ_HEAD_INITIALIZER(drconf_queue);
> +
> +static void spapr_add_drconf_cell(uint32_t seq_lmbs, uint64_t base_addr,
> +                                  uint32_t drc_index, uint32_t aa_index,
> +                                  uint32_t flags)
> +{
> +    DrconfCellQueue *elem;
> +
> +    elem =3D g_malloc0(sizeof(*elem));
> +    elem->cell.seq_lmbs =3D cpu_to_be32(seq_lmbs);
> +    elem->cell.base_addr =3D cpu_to_be64(base_addr);
> +    elem->cell.drc_index =3D cpu_to_be32(drc_index);
> +    elem->cell.aa_index =3D cpu_to_be32(aa_index);
> +    elem->cell.flags =3D cpu_to_be32(flags);
> +    QSIMPLEQ_INSERT_TAIL(&drconf_queue, elem, entry);

Don't use a global, pass the queue as a parameter.  Or alternatively
have the helper just return the allocated and initialized element to
add to the queue in the caller.

> +}
> +
> +/* ibm,dynamic-memory-v2 */
> +static int spapr_populate_drmem_v2(sPAPRMachineState *spapr, void *fdt,
> +                                   int offset, MemoryDeviceInfoList *dim=
ms)
>  {
> -    MachineState *machine =3D MACHINE(spapr);
> -    int ret, i, offset;
> -    uint64_t lmb_size =3D SPAPR_MEMORY_BLOCK_SIZE;
> -    uint32_t prop_lmb_size[] =3D {0, cpu_to_be32(lmb_size)};
> -    uint32_t hotplug_lmb_start =3D spapr->hotplug_memory.base / lmb_size;
> -    uint32_t nr_lmbs =3D (spapr->hotplug_memory.base +
> -                       memory_region_size(&spapr->hotplug_memory.mr)) /
> -                       lmb_size;
>      uint32_t *int_buf, *cur_index, buf_len;
> -    int nr_nodes =3D nb_numa_nodes ? nb_numa_nodes : 1;
> -    MemoryDeviceInfoList *dimms =3D NULL;
> +    int ret;
> +    uint64_t lmb_size =3D SPAPR_MEMORY_BLOCK_SIZE;
> +    uint64_t addr, cur_addr, size;
> +    uint32_t nr_boot_lmbs =3D (spapr->hotplug_memory.base / lmb_size);
> +    uint64_t mem_end =3D spapr->hotplug_memory.base +
> +                       memory_region_size(&spapr->hotplug_memory.mr);
> +    uint32_t node, nr_entries =3D 0;
> +    sPAPRDRConnector *drc;
> +    DrconfCellQueue *elem, *next;
> +    MemoryDeviceInfoList *info;
> =20
> -    /*
> -     * Don't create the node if there is no hotpluggable memory
> -     */
> -    if (machine->ram_size =3D=3D machine->maxram_size) {
> -        return 0;
> -    }
> +    /* Entry to cover RAM and the gap area */
> +    spapr_add_drconf_cell(nr_boot_lmbs, 0, 0, -1,
> +                         SPAPR_LMB_FLAGS_RESERVED |
> +                         SPAPR_LMB_FLAGS_DRC_INVALID);
> +    nr_entries++;
> =20
> -    /*
> -     * Allocate enough buffer size to fit in ibm,dynamic-memory
> -     * or ibm,associativity-lookup-arrays
> -     */
> -    buf_len =3D MAX(nr_lmbs * SPAPR_DR_LMB_LIST_ENTRY_SIZE + 1, nr_nodes=
 * 4 + 2)
> -              * sizeof(uint32_t);
> -    cur_index =3D int_buf =3D g_malloc0(buf_len);
> +    cur_addr =3D spapr->hotplug_memory.base;
> +    for (info =3D dimms; info; info =3D info->next) {
> +        PCDIMMDeviceInfo *di =3D info->value->u.dimm.data;
> =20
> -    offset =3D fdt_add_subnode(fdt, 0, "ibm,dynamic-reconfiguration-memo=
ry");
> +        addr =3D di->addr;
> +        size =3D di->size;
> +        node =3D di->node;
> =20
> -    ret =3D fdt_setprop(fdt, offset, "ibm,lmb-size", prop_lmb_size,
> -                    sizeof(prop_lmb_size));
> -    if (ret < 0) {
> -        goto out;
> +        /* Entry for hot-pluggable area */
> +        if (cur_addr < addr) {
> +            drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_LMB, cur_addr / lmb_s=
ize);
> +            g_assert(drc);
> +            spapr_add_drconf_cell((addr - cur_addr) / lmb_size,
> +                                       cur_addr, spapr_drc_index(drc),
> +                                       -1, 0);
> +            nr_entries++;
> +        }
> +
> +        /* Entry for DIMM */
> +        drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_LMB, addr / lmb_size);
> +        g_assert(drc);
> +        spapr_add_drconf_cell(size / lmb_size, addr, spapr_drc_index(drc=
),
> +                                   node, SPAPR_LMB_FLAGS_ASSIGNED);
> +        nr_entries++;
> +        cur_addr =3D addr + size;
>      }
> =20
> -    ret =3D fdt_setprop_cell(fdt, offset, "ibm,memory-flags-mask", 0xff);
> -    if (ret < 0) {
> -        goto out;
> +    /* Entry for remaining hotpluggable area */
> +    if (cur_addr < mem_end) {
> +        drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_LMB, cur_addr / lmb_size);
> +        g_assert(drc);
> +        spapr_add_drconf_cell((mem_end - cur_addr) / lmb_size, cur_addr,
> +                             spapr_drc_index(drc), -1, 0);
> +        nr_entries++;
>      }
> =20
> -    ret =3D fdt_setprop_cell(fdt, offset, "ibm,memory-preservation-time"=
, 0x0);
> -    if (ret < 0) {
> -        goto out;
> +    buf_len =3D (nr_entries * SPAPR_NR_DRCONF_CELL_ENTRIES + 1) *
> +              sizeof(uint32_t);
> +    int_buf =3D cur_index =3D g_malloc0(buf_len);
> +    int_buf[0] =3D cpu_to_be32(nr_entries);
> +    cur_index++;
> +    QSIMPLEQ_FOREACH_SAFE(elem, &drconf_queue, entry, next) {
> +        memcpy(cur_index, &elem->cell,
> +               SPAPR_NR_DRCONF_CELL_ENTRIES * sizeof(uint32_t));
> +        cur_index +=3D SPAPR_NR_DRCONF_CELL_ENTRIES;
> +        QSIMPLEQ_REMOVE(&drconf_queue, elem, DrconfCellQueue, entry);
> +        g_free(elem);
>      }
> =20
> -    if (hotplug_lmb_start) {
> -        dimms =3D qmp_pc_dimm_device_list();
> +    ret =3D fdt_setprop(fdt, offset, "ibm,dynamic-memory-v2", int_buf, b=
uf_len);
> +    g_free(int_buf);
> +    if (ret < 0) {
> +        return -1;
>      }
> +    return 0;
> +}
> +
> +/* ibm,dynamic-memory */
> +static int spapr_populate_drmem_v1(sPAPRMachineState *spapr, void *fdt,
> +                                   int offset, MemoryDeviceInfoList *dim=
ms)
> +{
> +    int i, ret;
> +    uint64_t lmb_size =3D SPAPR_MEMORY_BLOCK_SIZE;
> +    uint32_t hotplug_lmb_start =3D spapr->hotplug_memory.base / lmb_size;
> +    uint32_t nr_lmbs =3D (spapr->hotplug_memory.base +
> +                       memory_region_size(&spapr->hotplug_memory.mr)) /
> +                       lmb_size;
> +    uint32_t *int_buf, *cur_index, buf_len;
> =20
> -    /* ibm,dynamic-memory */
> +    /*
> +     * Allocate enough buffer size to fit in ibm,dynamic-memory
> +     */
> +    buf_len =3D (nr_lmbs * SPAPR_DR_LMB_LIST_ENTRY_SIZE + 1) * sizeof(ui=
nt32_t);
> +    cur_index =3D int_buf =3D g_malloc0(buf_len);
>      int_buf[0] =3D cpu_to_be32(nr_lmbs);
>      cur_index++;
>      for (i =3D 0; i < nr_lmbs; i++) {
> @@ -765,13 +838,71 @@ static int spapr_populate_drconf_memory(sPAPRMachin=
eState *spapr, void *fdt)
> =20
>          cur_index +=3D SPAPR_DR_LMB_LIST_ENTRY_SIZE;
>      }
> -    qapi_free_MemoryDeviceInfoList(dimms);
>      ret =3D fdt_setprop(fdt, offset, "ibm,dynamic-memory", int_buf, buf_=
len);
> +    g_free(int_buf);
>      if (ret < 0) {
> -        goto out;
> +        return -1;
> +    }
> +    return 0;
> +}
> +
> +/*
> + * Adds ibm,dynamic-reconfiguration-memory node.
> + * Refer to docs/specs/ppc-spapr-hotplug.txt for the documentation
> + * of this device tree node.
> + */
> +static int spapr_populate_drconf_memory(sPAPRMachineState *spapr, void *=
fdt)
> +{
> +    MachineState *machine =3D MACHINE(spapr);
> +    int ret, i, offset;
> +    uint64_t lmb_size =3D SPAPR_MEMORY_BLOCK_SIZE;
> +    uint32_t prop_lmb_size[] =3D {0, cpu_to_be32(lmb_size)};
> +    uint32_t *int_buf, *cur_index, buf_len;
> +    int nr_nodes =3D nb_numa_nodes ? nb_numa_nodes : 1;
> +    MemoryDeviceInfoList *dimms =3D NULL;
> +
> +    /*
> +     * Don't create the node if there is no hotpluggable memory
> +     */
> +    if (machine->ram_size =3D=3D machine->maxram_size) {
> +        return 0;
> +    }
> +
> +    offset =3D fdt_add_subnode(fdt, 0, "ibm,dynamic-reconfiguration-memo=
ry");
> +
> +    ret =3D fdt_setprop(fdt, offset, "ibm,lmb-size", prop_lmb_size,
> +                    sizeof(prop_lmb_size));
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    ret =3D fdt_setprop_cell(fdt, offset, "ibm,memory-flags-mask", 0xff);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    ret =3D fdt_setprop_cell(fdt, offset, "ibm,memory-preservation-time"=
, 0x0);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    /* ibm,dynamic-memory or ibm,dynamic-memory-v2 */
> +    dimms =3D qmp_pc_dimm_device_list();
> +    if (spapr_ovec_test(spapr->ov5_cas, OV5_DRMEM_V2)) {
> +        ret =3D spapr_populate_drmem_v2(spapr, fdt, offset, dimms);
> +    } else {
> +        ret =3D spapr_populate_drmem_v1(spapr, fdt, offset, dimms);
> +    }
> +    qapi_free_MemoryDeviceInfoList(dimms);
> +
> +    if (ret < 0) {
> +        return ret;
>      }
> =20
>      /* ibm,associativity-lookup-arrays */
> +    buf_len =3D (nr_nodes * 4 + 2) * sizeof(uint32_t);
> +    cur_index =3D int_buf =3D g_malloc0(buf_len);
> +
>      cur_index =3D int_buf;
>      int_buf[0] =3D cpu_to_be32(nr_nodes);
>      int_buf[1] =3D cpu_to_be32(4); /* Number of entries per associativit=
y list */
> @@ -788,8 +919,8 @@ static int spapr_populate_drconf_memory(sPAPRMachineS=
tate *spapr, void *fdt)
>      }
>      ret =3D fdt_setprop(fdt, offset, "ibm,associativity-lookup-arrays", =
int_buf,
>              (cur_index - int_buf) * sizeof(uint32_t));
> -out:
>      g_free(int_buf);
> +
>      return ret;
>  }
> =20
> @@ -2500,6 +2631,11 @@ static void spapr_machine_init(MachineState *machi=
ne)
>          spapr_ovec_set(spapr->ov5, OV5_HPT_RESIZE);
>      }
> =20
> +    /* advertise support for ibm,dyamic-memory-v2 */
> +    if (spapr->use_ibm_dynamic_memory_v2) {
> +        spapr_ovec_set(spapr->ov5, OV5_DRMEM_V2);
> +    }
> +
>      /* init CPUs */
>      spapr_init_cpus(spapr);
> =20
> @@ -2913,6 +3049,7 @@ static void spapr_instance_init(Object *obj)
> =20
>      spapr->htab_fd =3D -1;
>      spapr->use_hotplug_event_source =3D true;
> +    spapr->use_ibm_dynamic_memory_v2 =3D true;
>      object_property_add_str(obj, "kvm-type",
>                              spapr_get_kvm_type, spapr_set_kvm_type, NULL=
);
>      object_property_set_description(obj, "kvm-type",
> @@ -2927,7 +3064,6 @@ static void spapr_instance_init(Object *obj)
>                                      " place of standard EPOW events when=
 possible"
>                                      " (required for memory hot-unplug su=
pport)",
>                                      NULL);
> -
>      ppc_compat_add_property(obj, "max-cpu-compat", &spapr->max_compat_pv=
r,
>                              "Maximum permitted CPU compatibility mode",
>                              &error_fatal);
> @@ -4006,7 +4142,10 @@ DEFINE_SPAPR_MACHINE(2_13, "2.13", true);
> =20
>  static void spapr_machine_2_12_instance_options(MachineState *machine)
>  {
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(machine);
> +
>      spapr_machine_2_13_instance_options(machine);
> +    spapr->use_ibm_dynamic_memory_v2 =3D false;
>  }
> =20
>  static void spapr_machine_2_12_class_options(MachineClass *mc)
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index d60b7c6d7a..5e044c44af 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -149,6 +149,7 @@ struct sPAPRMachineState {
>      sPAPROptionVector *ov5;         /* QEMU-supported option vectors */
>      sPAPROptionVector *ov5_cas;     /* negotiated (via CAS) option vecto=
rs */
>      uint32_t max_compat_pvr;
> +    bool use_ibm_dynamic_memory_v2;

TBH, I'm not really sure we even need to adjust this by machine type.

> =20
>      /* Migration state */
>      int htab_save_index;
> diff --git a/include/hw/ppc/spapr_ovec.h b/include/hw/ppc/spapr_ovec.h
> index bf25e5d954..0f2d8d715d 100644
> --- a/include/hw/ppc/spapr_ovec.h
> +++ b/include/hw/ppc/spapr_ovec.h
> @@ -51,6 +51,7 @@ typedef struct sPAPROptionVector sPAPROptionVector;
>  #define OV5_FORM1_AFFINITY      OV_BIT(5, 0)
>  #define OV5_HP_EVT              OV_BIT(6, 5)
>  #define OV5_HPT_RESIZE          OV_BIT(6, 7)
> +#define OV5_DRMEM_V2            OV_BIT(22, 0)
>  #define OV5_XIVE_BOTH           OV_BIT(23, 0)
>  #define OV5_XIVE_EXPLOIT        OV_BIT(23, 1) /* 1=3Dexploitation 0=3Dle=
gacy */
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6e7ZaeXHKrTJCxdu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrVSnEACgkQbDjKyiDZ
s5KsZRAAnqaH8sX0eX12cy4Yxzm6edD92RB/RMUiEJyMYi7uWO1XD71uublHWMXg
N48PCSzPrU+91Lz1nvsBecQE6aXu2ANUdSM5E8EenLCPJ4cg2We8ELbkMr9fK18q
UQTApQcNUdWqB5aDSGYWxGfPMyFcbguHsVsttoLzxqF2RyhxylUByLxJv39JCItr
RWiNkTK9MzXZWOUmjgoNcSI72Pform0T70lL1mVIMTWdwKn4hmZznTAOEr1yuY6S
qmMRx/rzPiLUHk6OBVlM+sRHMXHqUOhOCwY7SV9rmFI79ADPs7hqfT0kkNMJGm6U
wgBwyHX9Tk78xYOGIa/zw9mSLFPnROY3fJdGKD49K1XgM9Btwz2p7nhM4ULCy5O9
AKQmsbekVysl4ZHSpChjca3m8FM0h+ovA0le1cqsYPOfTfiqdGqFVRPSLhDBDuMY
CJ4iPPSxmPBP6FVBBIfFpCWbKIsBDZUcbCZfUVT6UEy9BcJ5EdQQMfsDGT8n9FYe
JOcLYZm8+YTsA8uYf5XOBVOfXTIdFYR/3s4OOnwLIyEOxTDVIVgW1y/cZTfjKgKD
UItugeB1oOTOl2HbK2zVNOocJRml/rqBtiq+nHSH+oWLARw0e2YK518oCxNgJD4N
WxJEsoej7vedITo0+qDNzPTuWO3+d3Fo+C0/+PruGKp9rz0Qhtk=
=k70p
-----END PGP SIGNATURE-----

--6e7ZaeXHKrTJCxdu--
