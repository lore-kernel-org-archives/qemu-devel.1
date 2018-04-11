Received: from eggs.gnu.org ([2001:4830:134:3::10]:52673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f67e8-0005lg-8p
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 00:46:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f67e4-0006Qw-Ai
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 00:46:12 -0400
Date: Wed, 11 Apr 2018 14:45:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180411044558.GC2124@umbus.fritz.box>
References: <20180409062538.1095-1-bharata@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UPT3ojh+0CqEDtpF"
Content-Disposition: inline
In-Reply-To: <20180409062538.1095-1-bharata@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2] spapr: Support ibm,
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


--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 09, 2018 at 11:55:38AM +0530, Bharata B Rao wrote:
> The new property ibm,dynamic-memory-v2 allows memory to be represented
> in a more compact manner in device tree.
>=20
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> ---
> v1: https://lists.nongnu.org/archive/html/qemu-devel/2018-03/msg01788.html
> Changes in v1:
> - Minor cleanups in the error paths
> - Rebased on top of ppc-for-2.13
>=20
>  docs/specs/ppc-spapr-hotplug.txt |  19 +++
>  hw/ppc/spapr.c                   | 257 ++++++++++++++++++++++++++++++++-=
------
>  include/hw/ppc/spapr.h           |   1 +
>  include/hw/ppc/spapr_ovec.h      |   1 +
>  4 files changed, 233 insertions(+), 45 deletions(-)



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
> index 3ffadd6ac7..4a24fac38c 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -669,63 +669,139 @@ static uint32_t spapr_pc_dimm_node(MemoryDeviceInf=
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
> +struct of_drconf_cell_v2 {

qemu convention is to use CamelCase for types.

> +     uint32_t seq_lmbs;
> +     uint64_t base_addr;
> +     uint32_t drc_index;
> +     uint32_t aa_index;
> +     uint32_t flags;
> +} __attribute__((packed));
> +
> +#define SPAPR_DRCONF_CELL_SIZE 6

Define this using a sizeof() for safety.

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
> +    typedef struct drconf_cell_queue {
> +        struct of_drconf_cell_v2 cell;
> +        QSIMPLEQ_ENTRY(drconf_cell_queue) entry;
> +    } drconf_cell_queue;

Likewise CamelCase here.

> +    QSIMPLEQ_HEAD(, drconf_cell_queue) drconf_queue
> +        =3D QSIMPLEQ_HEAD_INITIALIZER(drconf_queue);
> +    drconf_cell_queue *elem, *next;
> +    MemoryDeviceInfoList *info;
> =20
> -    /*
> -     * Don't create the node if there is no hotpluggable memory
> -     */
> -    if (machine->ram_size =3D=3D machine->maxram_size) {
> -        return 0;
> -    }
> +    /* Entry to cover RAM and the gap area */
> +    elem =3D g_malloc0(sizeof(drconf_cell_queue));

Please use sizeof(*elem) - it's more robust in case you need to change
types around.

> +    elem->cell.seq_lmbs =3D cpu_to_be32(nr_boot_lmbs);
> +    elem->cell.base_addr =3D cpu_to_be64(0);
> +    elem->cell.drc_index =3D cpu_to_be32(0);
> +    elem->cell.aa_index =3D cpu_to_be32(-1);
> +    elem->cell.flags =3D cpu_to_be32(SPAPR_LMB_FLAGS_RESERVED |
> +                                   SPAPR_LMB_FLAGS_DRC_INVALID);

A helper for allocating, populating and queuing a new element might be
useful.

> +    QSIMPLEQ_INSERT_TAIL(&drconf_queue, elem, entry);
> +    nr_entries++;
> +
> +    cur_addr =3D spapr->hotplug_memory.base;
> +    for (info =3D dimms; info; info =3D info->next) {
> +        PCDIMMDeviceInfo *di =3D info->value->u.dimm.data;
> +
> +        addr =3D di->addr;
> +        size =3D di->size;
> +        node =3D di->node;
> +
> +        /* Entry for hot-pluggable area */
> +        if (cur_addr < addr) {
> +            drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_LMB, cur_addr / lmb_s=
ize);
> +            g_assert(drc);
> =20
> -    /*
> -     * Allocate enough buffer size to fit in ibm,dynamic-memory
> -     * or ibm,associativity-lookup-arrays
> -     */
> -    buf_len =3D MAX(nr_lmbs * SPAPR_DR_LMB_LIST_ENTRY_SIZE + 1, nr_nodes=
 * 4 + 2)
> -              * sizeof(uint32_t);
> -    cur_index =3D int_buf =3D g_malloc0(buf_len);
> +            elem =3D g_malloc0(sizeof(drconf_cell_queue));
> +            elem->cell.seq_lmbs =3D cpu_to_be32((addr - cur_addr) / lmb_=
size);
> +            elem->cell.base_addr =3D cpu_to_be64(cur_addr);
> +            elem->cell.drc_index =3D cpu_to_be32(spapr_drc_index(drc));
> +            elem->cell.aa_index =3D cpu_to_be32(-1);
> +            elem->cell.flags =3D cpu_to_be32(0);
> +            QSIMPLEQ_INSERT_TAIL(&drconf_queue, elem, entry);
> +            nr_entries++;
> +        }
> =20
> -    offset =3D fdt_add_subnode(fdt, 0, "ibm,dynamic-reconfiguration-memo=
ry");
> +        /* Entry for DIMM */
> +        drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_LMB, addr / lmb_size);
> +        g_assert(drc);
> =20
> -    ret =3D fdt_setprop(fdt, offset, "ibm,lmb-size", prop_lmb_size,
> -                    sizeof(prop_lmb_size));
> -    if (ret < 0) {
> -        goto out;
> +        elem =3D g_malloc0(sizeof(drconf_cell_queue));
> +        elem->cell.seq_lmbs =3D cpu_to_be32(size / lmb_size);
> +        elem->cell.base_addr =3D cpu_to_be64(addr);
> +        elem->cell.drc_index =3D cpu_to_be32(spapr_drc_index(drc));
> +        elem->cell.aa_index =3D cpu_to_be32(node);
> +        elem->cell.flags =3D cpu_to_be32(SPAPR_LMB_FLAGS_ASSIGNED);
> +        QSIMPLEQ_INSERT_TAIL(&drconf_queue, elem, entry);
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
> +
> +        elem =3D g_malloc0(sizeof(drconf_cell_queue));
> +        elem->cell.seq_lmbs =3D cpu_to_be32((mem_end - cur_addr) / lmb_s=
ize);
> +        elem->cell.base_addr =3D cpu_to_be64(cur_addr);
> +        elem->cell.drc_index =3D cpu_to_be32(spapr_drc_index(drc));
> +        elem->cell.aa_index =3D cpu_to_be32(-1);
> +        elem->cell.flags =3D cpu_to_be32(0);
> +        QSIMPLEQ_INSERT_TAIL(&drconf_queue, elem, entry);
> +        nr_entries++;
>      }
> =20
> -    ret =3D fdt_setprop_cell(fdt, offset, "ibm,memory-preservation-time"=
, 0x0);
> -    if (ret < 0) {
> -        goto out;
> +    buf_len =3D (nr_entries * SPAPR_DRCONF_CELL_SIZE + 1) * sizeof(uint3=
2_t);
> +    int_buf =3D cur_index =3D g_malloc0(buf_len);
> +    int_buf[0] =3D cpu_to_be32(nr_entries);
> +    cur_index++;
> +    QSIMPLEQ_FOREACH_SAFE(elem, &drconf_queue, entry, next) {
> +        memcpy(cur_index, &elem->cell,
> +               SPAPR_DRCONF_CELL_SIZE * sizeof(uint32_t));
> +        cur_index +=3D SPAPR_DRCONF_CELL_SIZE;
> +        QSIMPLEQ_REMOVE(&drconf_queue, elem, drconf_cell_queue, entry);
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
> =20
> -    /* ibm,dynamic-memory */
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
> +
> +    /*
> +     * Allocate enough buffer size to fit in ibm,dynamic-memory
> +     */
> +    buf_len =3D (nr_lmbs * SPAPR_DR_LMB_LIST_ENTRY_SIZE + 1) * sizeof(ui=
nt32_t);
> +    cur_index =3D int_buf =3D g_malloc0(buf_len);
>      int_buf[0] =3D cpu_to_be32(nr_lmbs);
>      cur_index++;
>      for (i =3D 0; i < nr_lmbs; i++) {
> @@ -765,13 +841,71 @@ static int spapr_populate_drconf_memory(sPAPRMachin=
eState *spapr, void *fdt)
> =20
>          cur_index +=3D SPAPR_DR_LMB_LIST_ENTRY_SIZE;
>      }
> -    qapi_free_MemoryDeviceInfoList(dimms);
>      ret =3D fdt_setprop(fdt, offset, "ibm,dynamic-memory", int_buf, buf_=
len);
> +    g_free(int_buf);
> +    if (ret < 0) {
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
> +        goto out;
> +    }
> +
> +    ret =3D fdt_setprop_cell(fdt, offset, "ibm,memory-flags-mask", 0xff);
> +    if (ret < 0) {
> +        goto out;
> +    }
> +
> +    ret =3D fdt_setprop_cell(fdt, offset, "ibm,memory-preservation-time"=
, 0x0);
> +    if (ret < 0) {
> +        goto out;
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
>      if (ret < 0) {
>          goto out;
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
> @@ -788,8 +922,9 @@ static int spapr_populate_drconf_memory(sPAPRMachineS=
tate *spapr, void *fdt)
>      }
>      ret =3D fdt_setprop(fdt, offset, "ibm,associativity-lookup-arrays", =
int_buf,
>              (cur_index - int_buf) * sizeof(uint32_t));
> -out:
>      g_free(int_buf);
> +
> +out:

No point to this label if all you do after is a plain return - you can
just use return directly instead of gotos.

>      return ret;
>  }
> =20
> @@ -2500,6 +2635,11 @@ static void spapr_machine_init(MachineState *machi=
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
> @@ -2907,12 +3047,27 @@ static void spapr_set_vsmt(Object *obj, Visitor *=
v, const char *name,
>      visit_type_uint32(v, name, (uint32_t *)opaque, errp);
>  }
> =20
> +static bool spapr_get_drmem_v2(Object *obj, Error **errp)
> +{
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> +
> +    return spapr->use_ibm_dynamic_memory_v2;
> +}
> +
> +static void spapr_set_drmem_v2(Object *obj, bool value, Error **errp)
> +{
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> +
> +    spapr->use_ibm_dynamic_memory_v2 =3D value;
> +}
> +
>  static void spapr_instance_init(Object *obj)
>  {
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> =20
>      spapr->htab_fd =3D -1;
>      spapr->use_hotplug_event_source =3D true;
> +    spapr->use_ibm_dynamic_memory_v2 =3D true;
>      object_property_add_str(obj, "kvm-type",
>                              spapr_get_kvm_type, spapr_set_kvm_type, NULL=
);
>      object_property_set_description(obj, "kvm-type",
> @@ -2927,6 +3082,15 @@ static void spapr_instance_init(Object *obj)
>                                      " place of standard EPOW events when=
 possible"
>                                      " (required for memory hot-unplug su=
pport)",
>                                      NULL);
> +    object_property_add_bool(obj, "drmem-v2",
> +                             spapr_get_drmem_v2,
> +                             spapr_set_drmem_v2,
> +                             NULL);
> +    object_property_set_description(obj, "ibm-dynamic-memory-v2",
> +                                    "Use ibm-dynamic-memory-v2 represent=
ation"
> +                                    " in place of ibm-dynamic-memory whe=
n"
> +                                    " possible",
> +                                    NULL);

I don't really see any point to making this a user configurable
option.  Why not just always enable it if the guest says it can
support it.

>      ppc_compat_add_property(obj, "max-cpu-compat", &spapr->max_compat_pv=
r,
>                              "Maximum permitted CPU compatibility mode",
> @@ -4042,7 +4206,10 @@ DEFINE_SPAPR_MACHINE(2_12_sxxm, "2.12-sxxm", false=
);
> =20
>  static void spapr_machine_2_11_instance_options(MachineState *machine)
>  {
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(machine);
> +
>      spapr_machine_2_12_instance_options(machine);
> +    spapr->use_ibm_dynamic_memory_v2 =3D false;
>  }
> =20
>  static void spapr_machine_2_11_class_options(MachineClass *mc)
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

--UPT3ojh+0CqEDtpF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrNkwQACgkQbDjKyiDZ
s5I5DxAAo4X+vOocT9C7ey4H/malXPkJXd0u4ObE4YfKiYdBcnJwUDkyJfwtzjBw
5co/uRkfCifOHf35xZCxXkE2vUHOTmkxY8TuWhDlu1CvJxrrKCjCKO/Tgooy9Scj
dcJxnI5rPsWGa57qOsIJQ0Td49h7delxynAy42FqA4QZhcWgJnMiHf2KWM2CGVva
mt+V5iPCl3qS+yoMOQao0PWanKIDMkHPBkOayeOzFyW/h7YyA9ed2xsnZL24hk7T
poblPOmbDBoZ6/tL/iX6x2tbdlnOLLGI72/o0yeaIGFN5fmf4W5S8H/EOSkC7wPV
2HbLHAtjfJUgipvkTLn2gSip80VcHc0uRF+LiMtAhHt40ro0PoiSrLatakUfoVRp
EqAKz7f0rdnnVIC/QnKo39S4aHube/jYMHuRIXnP9oX3MblzX1B/CjVSHRceV7pz
LjfHeJ+fXmvp7F/Vs1j2nOm1egqZ19mozjDn/994itHbwsObjlrSTuygqjEDvUfb
5NkIkvtBgPB4pQmeSBRCUVu96hrq4SHrl+AWXaWXEfE3PVYtY3noGgolLuK4cxok
70DKex9CR2q384IBGJnzom7mefG6M1Br6YmDFKlulOvr6iDLonKsfbuGrf7AZ+Lz
/6iN8sV/H3KijNrLCjaWlCwWfYfCcCbOuV5kjSP0MIvoqPonKpY=
=ZtKI
-----END PGP SIGNATURE-----

--UPT3ojh+0CqEDtpF--
