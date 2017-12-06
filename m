Received: from eggs.gnu.org ([2001:4830:134:3::10]:42287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eMNXA-0004cg-Nn
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 19:25:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eMNX8-0003MT-TD
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 19:25:56 -0500
Date: Wed, 6 Dec 2017 11:14:06 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171206001406.GP3057@umbus.fritz.box>
References: <1512488477-209071-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1LW0Rr0Uq98qh6Rv"
Content-Disposition: inline
In-Reply-To: <1512488477-209071-1-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2.12] spapr: replace numa_get_node() with
 lookup in pc-dimm list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de, ehabkost@redhat.com, qemu-ppc@nongnu.org


--1LW0Rr0Uq98qh6Rv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 04:41:17PM +0100, Igor Mammedov wrote:
> SPAPR is the last user of numa_get_node() and a bunch of
> supporting code to maintain numa_info[x].addr list.
>=20
> Get LMB node id from pc-dimm list, which allows to
> remove ~80LOC maintaining dynamic address range
> lookup list.
>=20
> It also removes pc-dimm dependency on numa_[un]set_mem_node_id()
> and makes pc-dimms a sole source of information about which
> node it belongs to and removes duplicate data from global
> numa_info.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> Beside making code simpler, my interest in simplification
> lies in allowing calling parse_numa_opts() multiple times,
> without complex cleanups in case NUMA config is changed
> since startup.
>=20
> PS:
> build tested only
> ---
>  include/sysemu/numa.h | 10 ------
>  hw/mem/pc-dimm.c      |  2 --
>  hw/ppc/spapr.c        | 29 +++++++++++++++-
>  numa.c                | 94 ---------------------------------------------=
------
>  4 files changed, 28 insertions(+), 107 deletions(-)

Applied to ppc-for-2.12.

It definitely seems like an improvement over what we have.  Looking
back at the DIMM list from QMP in the loop seems a little roundabout
though.  Maybe we'd be better stepping through the DIMMs, then
stepping through the LMBs within each DIMM, rather than just stepping
through the LMBs directly.


>=20
> diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
> index 5c6df28..b354521 100644
> --- a/include/sysemu/numa.h
> +++ b/include/sysemu/numa.h
> @@ -10,17 +10,10 @@
>  extern int nb_numa_nodes;   /* Number of NUMA nodes */
>  extern bool have_numa_distance;
> =20
> -struct numa_addr_range {
> -    ram_addr_t mem_start;
> -    ram_addr_t mem_end;
> -    QLIST_ENTRY(numa_addr_range) entry;
> -};
> -
>  struct node_info {
>      uint64_t node_mem;
>      struct HostMemoryBackend *node_memdev;
>      bool present;
> -    QLIST_HEAD(, numa_addr_range) addr; /* List to store address ranges =
*/
>      uint8_t distance[MAX_NODES];
>  };
> =20
> @@ -33,9 +26,6 @@ extern NodeInfo numa_info[MAX_NODES];
>  void parse_numa_opts(MachineState *ms);
>  void query_numa_node_mem(NumaNodeMem node_mem[]);
>  extern QemuOptsList qemu_numa_opts;
> -void numa_set_mem_node_id(ram_addr_t addr, uint64_t size, uint32_t node);
> -void numa_unset_mem_node_id(ram_addr_t addr, uint64_t size, uint32_t nod=
e);
> -uint32_t numa_get_node(ram_addr_t addr, Error **errp);
>  void numa_legacy_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
>                                   int nb_nodes, ram_addr_t size);
>  void numa_default_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index 66eace5..6e74b61 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -109,7 +109,6 @@ void pc_dimm_memory_plug(DeviceState *dev, MemoryHotp=
lugState *hpms,
> =20
>      memory_region_add_subregion(&hpms->mr, addr - hpms->base, mr);
>      vmstate_register_ram(vmstate_mr, dev);
> -    numa_set_mem_node_id(addr, memory_region_size(mr), dimm->node);
> =20
>  out:
>      error_propagate(errp, local_err);
> @@ -122,7 +121,6 @@ void pc_dimm_memory_unplug(DeviceState *dev, MemoryHo=
tplugState *hpms,
>      PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
>      MemoryRegion *vmstate_mr =3D ddc->get_vmstate_memory_region(dimm);
> =20
> -    numa_unset_mem_node_id(dimm->addr, memory_region_size(mr), dimm->nod=
e);
>      memory_region_del_subregion(&hpms->mr, mr);
>      vmstate_unregister_ram(vmstate_mr, dev);
>  }
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 9efddea..8de0b5b 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -641,6 +641,26 @@ static void spapr_populate_cpus_dt_node(void *fdt, s=
PAPRMachineState *spapr)
> =20
>  }
> =20
> +static uint32_t spapr_pc_dimm_node(MemoryDeviceInfoList *list, ram_addr_=
t addr)
> +{
> +    MemoryDeviceInfoList *info;
> +
> +    for (info =3D list; info; info =3D info->next) {
> +        MemoryDeviceInfo *value =3D info->value;
> +
> +        if (value && value->type =3D=3D MEMORY_DEVICE_INFO_KIND_DIMM) {
> +            PCDIMMDeviceInfo *pcdimm_info =3D value->u.dimm.data;
> +
> +            if (pcdimm_info->addr >=3D addr &&
> +                addr < (pcdimm_info->addr + pcdimm_info->size)) {
> +                return pcdimm_info->node;
> +            }
> +        }
> +    }
> +
> +    return -1;
> +}
> +
>  /*
>   * Adds ibm,dynamic-reconfiguration-memory node.
>   * Refer to docs/specs/ppc-spapr-hotplug.txt for the documentation
> @@ -658,6 +678,7 @@ static int spapr_populate_drconf_memory(sPAPRMachineS=
tate *spapr, void *fdt)
>                         lmb_size;
>      uint32_t *int_buf, *cur_index, buf_len;
>      int nr_nodes =3D nb_numa_nodes ? nb_numa_nodes : 1;
> +    MemoryDeviceInfoList *dimms =3D NULL;
> =20
>      /*
>       * Don't create the node if there is no hotpluggable memory
> @@ -692,6 +713,11 @@ static int spapr_populate_drconf_memory(sPAPRMachine=
State *spapr, void *fdt)
>          goto out;
>      }
> =20
> +    if (hotplug_lmb_start) {
> +        MemoryDeviceInfoList **prev =3D &dimms;
> +        qmp_pc_dimm_device_list(qdev_get_machine(), &prev);
> +    }
> +
>      /* ibm,dynamic-memory */
>      int_buf[0] =3D cpu_to_be32(nr_lmbs);
>      cur_index++;
> @@ -709,7 +735,7 @@ static int spapr_populate_drconf_memory(sPAPRMachineS=
tate *spapr, void *fdt)
>              dynamic_memory[1] =3D cpu_to_be32(addr & 0xffffffff);
>              dynamic_memory[2] =3D cpu_to_be32(spapr_drc_index(drc));
>              dynamic_memory[3] =3D cpu_to_be32(0); /* reserved */
> -            dynamic_memory[4] =3D cpu_to_be32(numa_get_node(addr, NULL));
> +            dynamic_memory[4] =3D cpu_to_be32(spapr_pc_dimm_node(dimms, =
addr));
>              if (memory_region_present(get_system_memory(), addr)) {
>                  dynamic_memory[5] =3D cpu_to_be32(SPAPR_LMB_FLAGS_ASSIGN=
ED);
>              } else {
> @@ -732,6 +758,7 @@ static int spapr_populate_drconf_memory(sPAPRMachineS=
tate *spapr, void *fdt)
> =20
>          cur_index +=3D SPAPR_DR_LMB_LIST_ENTRY_SIZE;
>      }
> +    qapi_free_MemoryDeviceInfoList(dimms);
>      ret =3D fdt_setprop(fdt, offset, "ibm,dynamic-memory", int_buf, buf_=
len);
>      if (ret < 0) {
>          goto out;
> diff --git a/numa.c b/numa.c
> index 7151b24..98fa9a4 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -55,92 +55,6 @@ int nb_numa_nodes;
>  bool have_numa_distance;
>  NodeInfo numa_info[MAX_NODES];
> =20
> -void numa_set_mem_node_id(ram_addr_t addr, uint64_t size, uint32_t node)
> -{
> -    struct numa_addr_range *range;
> -
> -    /*
> -     * Memory-less nodes can come here with 0 size in which case,
> -     * there is nothing to do.
> -     */
> -    if (!size) {
> -        return;
> -    }
> -
> -    range =3D g_malloc0(sizeof(*range));
> -    range->mem_start =3D addr;
> -    range->mem_end =3D addr + size - 1;
> -    QLIST_INSERT_HEAD(&numa_info[node].addr, range, entry);
> -}
> -
> -void numa_unset_mem_node_id(ram_addr_t addr, uint64_t size, uint32_t nod=
e)
> -{
> -    struct numa_addr_range *range, *next;
> -
> -    QLIST_FOREACH_SAFE(range, &numa_info[node].addr, entry, next) {
> -        if (addr =3D=3D range->mem_start && (addr + size - 1) =3D=3D ran=
ge->mem_end) {
> -            QLIST_REMOVE(range, entry);
> -            g_free(range);
> -            return;
> -        }
> -    }
> -}
> -
> -static void numa_set_mem_ranges(void)
> -{
> -    int i;
> -    ram_addr_t mem_start =3D 0;
> -
> -    /*
> -     * Deduce start address of each node and use it to store
> -     * the address range info in numa_info address range list
> -     */
> -    for (i =3D 0; i < nb_numa_nodes; i++) {
> -        numa_set_mem_node_id(mem_start, numa_info[i].node_mem, i);
> -        mem_start +=3D numa_info[i].node_mem;
> -    }
> -}
> -
> -/*
> - * Check if @addr falls under NUMA @node.
> - */
> -static bool numa_addr_belongs_to_node(ram_addr_t addr, uint32_t node)
> -{
> -    struct numa_addr_range *range;
> -
> -    QLIST_FOREACH(range, &numa_info[node].addr, entry) {
> -        if (addr >=3D range->mem_start && addr <=3D range->mem_end) {
> -            return true;
> -        }
> -    }
> -    return false;
> -}
> -
> -/*
> - * Given an address, return the index of the NUMA node to which the
> - * address belongs to.
> - */
> -uint32_t numa_get_node(ram_addr_t addr, Error **errp)
> -{
> -    uint32_t i;
> -
> -    /* For non NUMA configurations, check if the addr falls under node 0=
 */
> -    if (!nb_numa_nodes) {
> -        if (numa_addr_belongs_to_node(addr, 0)) {
> -            return 0;
> -        }
> -    }
> -
> -    for (i =3D 0; i < nb_numa_nodes; i++) {
> -        if (numa_addr_belongs_to_node(addr, i)) {
> -            return i;
> -        }
> -    }
> -
> -    error_setg(errp, "Address 0x" RAM_ADDR_FMT " doesn't belong to any "
> -                "NUMA node", addr);
> -    return -1;
> -}
> =20
>  static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
>                              Error **errp)
> @@ -497,12 +411,6 @@ void parse_numa_opts(MachineState *ms)
>              exit(1);
>          }
> =20
> -        for (i =3D 0; i < nb_numa_nodes; i++) {
> -            QLIST_INIT(&numa_info[i].addr);
> -        }
> -
> -        numa_set_mem_ranges();
> -
>          /* QEMU needs at least all unique node pair distances to build
>           * the whole NUMA distance table. QEMU treats the distance table
>           * as symmetric by default, i.e. distance A->B =3D=3D distance B=
->A.
> @@ -522,8 +430,6 @@ void parse_numa_opts(MachineState *ms)
>              /* Validation succeeded, now fill in any missing distances. =
*/
>              complete_init_numa_distance();
>          }
> -    } else {
> -        numa_set_mem_node_id(0, ram_size, 0);
>      }
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1LW0Rr0Uq98qh6Rv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlonNksACgkQbDjKyiDZ
s5Lt+BAA4mMpcPm0o4BFGtwf+5c0KRf8LR0B3qDZR4UA/nV/SRHJXLueyDhBbDWB
+pYAJvo3os90sRP1+t6HvX663Rx86kcjgLJ8rpHoOeucbo2e722toqWG0kKmSwL9
z9y1r4wRFUHGgOE3JpSgtRB43LUFKLlJ7vGKkpFxF3BMLIk4qjhlhpdOnKQskFeL
eVBfessKovsjB81GvRJRg+12B4zD6hjCrwTPVA/Q9bOvqP5nYp64sQM3qpKi0Swb
prhkHXTrpcX7baEsQ3NQ6TpKfE97Yw1uGo1UulCJmvBLGcNcGS9IpZlgBUA5Qf82
jqOddEprXhqmyBd0s8+WCYQr4ViXKSQepOpP+yNFqE12gtXH3L4XlLh+Gscj2OmR
0A0neihz+9SJJQNkrnjmuY3MxEwLAVTPWn8xKQdb71d1uhtRLffNVrnu0U9uVp7Y
LHa2b5GhqxNSk0/O5GKfV0nszSmTuXAB4S/ZI0urT7HAkg7AdQkLniZN5FZDWCfl
DIauc/W0sTgdc51oIDPQqCv7Di/HH4cSlvyu3AEqmDrIai610RrXr6Vzi4CExinp
C8XELn1cekJB18rZHscT/5fUgWg5FyDIeIjhuAOlC2wR/AuP8X7iqxKSoLuVrbQs
IpG5N8E7xZpPJ5uTMArtW7w1zC7Y1zfXS2UhKfwrcTzp5JSKmkU=
=YBfT
-----END PGP SIGNATURE-----

--1LW0Rr0Uq98qh6Rv--
