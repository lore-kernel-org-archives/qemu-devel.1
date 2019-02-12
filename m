Received: from eggs.gnu.org ([209.51.188.92]:38098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtPiu-0004pM-VJ
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:31:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtPis-0003rD-Tb
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:31:08 -0500
Date: Tue, 12 Feb 2019 13:28:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190212022816.GJ1884@umbus.fritz.box>
References: <154943058200.27958.11497653677605446596.stgit@lep8c.aus.stglabs.ibm.com>
	<154943079488.27958.9812294887340963535.stgit@lep8c.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NqSa+Xr3J/G6Hhls"
Content-Disposition: inline
In-Reply-To: <154943079488.27958.9812294887340963535.stgit@lep8c.aus.stglabs.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 4/4] spapr: Add Hcalls to support PAPR
 NVDIMM device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, xiaoguangrong.eric@gmail.com, mst@redhat.com, bharata@linux.ibm.com, qemu-ppc@nongnu.org, vaibhav@linux.ibm.com, imammedo@redhat.com


--NqSa+Xr3J/G6Hhls
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 05, 2019 at 11:26:41PM -0600, Shivaprasad G Bhat wrote:
> This patch implements few of the necessary hcalls for the nvdimm support.
>=20
> PAPR semantics is such that each NVDIMM device is comprising of multiple
> SCM(Storage Class Memory) blocks. The guest requests the hypervisor to bi=
nd
> each of the SCM blocks of the NVDIMM device using hcalls. There can be
> SCM block unbind requests in case of driver errors or unplug(not supporte=
d now)
> use cases. The NVDIMM label read/writes are done through hcalls.
>=20
> Since each virtual NVDIMM device is divided into multiple SCM blocks, the=
 bind,
> unbind, and queries using hcalls on those blocks can come independently. =
This
> doesn't fit well into the qemu device semantics, where the map/unmap are =
done
> at the (whole)device/object level granularity. The patch doesnt actually
> bind/unbind on hcalls but let it happen at the object_add/del phase itself
> instead.
>=20
> The guest kernel makes bind/unbind requests for the virtual NVDIMM device=
 at the
> region level granularity. Without interleaving, each virtual NVDIMM devic=
e is
> presented as separate region. There is no way to configure the virtual NV=
DIMM
> interleaving for the guests today. So, there is no way a partial bind/unb=
ind
> request can come for the vNVDIMM in a hcall for a subset of SCM blocks of=
 a
> virtual NVDIMM. Hence it is safe to do bind/unbind everything during the
> object_add/del.

Hrm.  I don't entirely follow the above, but implementing something
that doesn't really match the PAPR model seems like it could lead to
problems.

>=20
> The kernel today is not using the hcalls - h_scm_mem_query, h_scm_mem_cle=
ar,
> h_scm_query_logical_mem_binding and h_scm_query_block_mem_binding. They a=
re just
> stubs in this patch.
>=20
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> ---
>  hw/ppc/spapr_hcall.c   |  230 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/ppc/spapr.h |   12 ++-
>  2 files changed, 240 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 17bcaa3822..40553e80d6 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -3,11 +3,13 @@
>  #include "sysemu/hw_accel.h"
>  #include "sysemu/sysemu.h"
>  #include "qemu/log.h"
> +#include "qemu/range.h"
>  #include "qemu/error-report.h"
>  #include "cpu.h"
>  #include "exec/exec-all.h"
>  #include "helper_regs.h"
>  #include "hw/ppc/spapr.h"
> +#include "hw/ppc/spapr_drc.h"
>  #include "hw/ppc/spapr_cpu_core.h"
>  #include "mmu-hash64.h"
>  #include "cpu-models.h"
> @@ -16,6 +18,7 @@
>  #include "hw/ppc/spapr_ovec.h"
>  #include "mmu-book3s-v3.h"
>  #include "hw/mem/memory-device.h"
> +#include "hw/mem/nvdimm.h"
> =20
>  struct LPCRSyncState {
>      target_ulong value;
> @@ -1808,6 +1811,222 @@ static target_ulong h_update_dt(PowerPCCPU *cpu, =
sPAPRMachineState *spapr,
>      return H_SUCCESS;
>  }
> =20
> +static target_ulong h_scm_read_metadata(PowerPCCPU *cpu,
> +                                        sPAPRMachineState *spapr,
> +                                        target_ulong opcode,
> +                                        target_ulong *args)
> +{
> +    uint32_t drc_index =3D args[0];
> +    uint64_t offset =3D args[1];
> +    uint8_t numBytesToRead =3D args[2];

This will truncate the argument to 8 bits _before_ you validate it,
which doesn't seem like what you want.

> +    sPAPRDRConnector *drc =3D spapr_drc_by_index(drc_index);
> +    NVDIMMDevice *nvdimm =3D NULL;
> +    NVDIMMClass *ddc =3D NULL;
> +
> +    if (numBytesToRead !=3D 1 && numBytesToRead !=3D 2 &&
> +        numBytesToRead !=3D 4 && numBytesToRead !=3D 8) {
> +        return H_P3;
> +    }
> +
> +    if (offset & (numBytesToRead - 1)) {
> +        return H_P2;
> +    }
> +
> +    if (drc && spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PMEM) {
> +        return H_PARAMETER;
> +    }
> +
> +    nvdimm =3D NVDIMM(drc->dev);
> +    ddc =3D NVDIMM_GET_CLASS(nvdimm);
> +
> +    ddc->read_label_data(nvdimm, &args[0], numBytesToRead, offset);

Hm.  Is this the only way to access the label data, or is it also
mapped into the guest visible address space?  I ask because some of
the calculations you made about size+label_size in an earlier patch
seemed to suggest it was part of the address space.

> +    return H_SUCCESS;
> +}
> +
> +
> +static target_ulong h_scm_write_metadata(PowerPCCPU *cpu,
> +                                         sPAPRMachineState *spapr,
> +                                         target_ulong opcode,
> +                                         target_ulong *args)
> +{
> +    uint32_t drc_index =3D args[0];
> +    uint64_t offset =3D args[1];
> +    uint64_t data =3D args[2];
> +    int8_t numBytesToWrite =3D args[3];
> +    sPAPRDRConnector *drc =3D spapr_drc_by_index(drc_index);
> +    NVDIMMDevice *nvdimm =3D NULL;
> +    DeviceState *dev =3D NULL;
> +    NVDIMMClass *ddc =3D NULL;
> +
> +    if (numBytesToWrite !=3D 1 && numBytesToWrite !=3D 2 &&
> +        numBytesToWrite !=3D 4 && numBytesToWrite !=3D 8) {
> +        return H_P4;
> +    }
> +
> +    if (offset & (numBytesToWrite - 1)) {
> +        return H_P2;
> +    }
> +
> +    if (drc && spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PMEM) {
> +        return H_PARAMETER;
> +    }
> +
> +    dev =3D drc->dev;
> +    nvdimm =3D NVDIMM(dev);
> +    if (offset >=3D nvdimm->label_size) {
> +        return H_P3;
> +    }
> +
> +    ddc =3D NVDIMM_GET_CLASS(nvdimm);
> +
> +    ddc->write_label_data(nvdimm, &data, numBytesToWrite, offset);
> +
> +    return H_SUCCESS;
> +}
> +
> +static target_ulong h_scm_bind_mem(PowerPCCPU *cpu, sPAPRMachineState *s=
papr,
> +                                        target_ulong opcode,
> +                                        target_ulong *args)
> +{
> +    uint32_t drc_index =3D args[0];
> +    uint64_t starting_index =3D args[1];
> +    uint64_t no_of_scm_blocks_to_bind =3D args[2];
> +    uint64_t target_logical_mem_addr =3D args[3];
> +    uint64_t continue_token =3D args[4];
> +    uint64_t size;
> +    uint64_t total_no_of_scm_blocks;
> +
> +    sPAPRDRConnector *drc =3D spapr_drc_by_index(drc_index);
> +    hwaddr addr;
> +    DeviceState *dev =3D NULL;
> +    PCDIMMDevice *dimm =3D NULL;
> +    Error *local_err =3D NULL;
> +
> +    if (drc && spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PMEM) {
> +        return H_PARAMETER;
> +    }
> +
> +    dev =3D drc->dev;
> +    dimm =3D PC_DIMM(dev);
> +
> +    size =3D object_property_get_uint(OBJECT(dimm),
> +                                    PC_DIMM_SIZE_PROP, &local_err);
> +    if (local_err) {
> +        error_report_err(local_err);
> +        return H_PARAMETER;

This should probably be H_HARDWARE, no?  The error isn't caused by one
of the parameters.

> +    }
> +
> +    total_no_of_scm_blocks =3D size / SPAPR_MINIMUM_SCM_BLOCK_SIZE;
> +
> +    if (starting_index > total_no_of_scm_blocks) {
> +        return H_P2;
> +    }
> +
> +    if ((starting_index + no_of_scm_blocks_to_bind) >
> total_no_of_scm_blocks) {

You should probably have a check for integer overflow here as well,
just to be thorough.

> +        return H_P3;
> +    }
> +
> +    /* Currently qemu assigns the address. */
> +    if (target_logical_mem_addr !=3D 0xffffffffffffffff) {
> +        return H_OVERLAP;
> +    }
> +
> +    /*
> +     * Currently continue token should be zero qemu has already bound
> +     * everything and this hcall doesnt return H_BUSY.
> +     */
> +    if (continue_token > 0) {
> +        return H_P5;
> +    }
> +
> +    /* NB : Already bound, Return target logical address in R4 */
> +    addr =3D object_property_get_uint(OBJECT(dimm),
> +                                    PC_DIMM_ADDR_PROP, &local_err);
> +    if (local_err) {
> +        error_report_err(local_err);
> +        return H_PARAMETER;
> +    }
> +
> +    args[1] =3D addr;
> +
> +    return H_SUCCESS;
> +}
> +
> +static target_ulong h_scm_unbind_mem(PowerPCCPU *cpu, sPAPRMachineState =
*spapr,
> +                                        target_ulong opcode,
> +                                        target_ulong *args)
> +{
> +    uint64_t starting_scm_logical_addr =3D args[0];
> +    uint64_t no_of_scm_blocks_to_unbind =3D args[1];
> +    uint64_t size_to_unbind;
> +    uint64_t continue_token =3D args[2];
> +    Range as =3D range_empty;
> +    GSList *dimms =3D NULL;
> +    bool valid =3D false;
> +
> +    size_to_unbind =3D no_of_scm_blocks_to_unbind * SPAPR_MINIMUM_SCM_BL=
OCK_SIZE;
> +
> +    /* Check if starting_scm_logical_addr is block aligned */
> +    if (!QEMU_IS_ALIGNED(starting_scm_logical_addr,
> +                         SPAPR_MINIMUM_SCM_BLOCK_SIZE)) {
> +        return H_PARAMETER;
> +    }
> +
> +    range_init_nofail(&as, starting_scm_logical_addr, size_to_unbind);
> +
> +    dimms =3D nvdimm_get_device_list();
> +    for (; dimms; dimms =3D dimms->next) {
> +        NVDIMMDevice *nvdimm =3D dimms->data;
> +        Range tmp;
> +        int size =3D object_property_get_int(OBJECT(nvdimm), PC_DIMM_SIZ=
E_PROP,
> +                                           NULL);
> +        int addr =3D object_property_get_int(OBJECT(nvdimm), PC_DIMM_ADD=
R_PROP,
> +                                           NULL);
> +        range_init_nofail(&tmp, addr, size);
> +
> +        if (range_contains_range(&tmp, &as)) {
> +            valid =3D true;
> +            break;
> +        }
> +    }
> +
> +    if (!valid) {
> +        return H_P2;
> +    }
> +
> +    if (continue_token > 0) {
> +        return H_P3;
> +    }
> +
> +    /*NB : dont do anything, let object_del take care of this for now. */
> +
> +    return H_SUCCESS;
> +}
> +
> +static target_ulong h_scm_query_block_mem_binding(PowerPCCPU *cpu,
> +                                                  sPAPRMachineState *spa=
pr,
> +                                                  target_ulong opcode,
> +                                                  target_ulong *args)
> +{
> +    return H_SUCCESS;
> +}
> +
> +static target_ulong h_scm_query_logical_mem_binding(PowerPCCPU *cpu,
> +                                                    sPAPRMachineState *s=
papr,
> +                                                    target_ulong opcode,
> +                                                    target_ulong *args)
> +{
> +    return H_SUCCESS;
> +}
> +
> +static target_ulong h_scm_mem_query(PowerPCCPU *cpu, sPAPRMachineState *=
spapr,
> +                                        target_ulong opcode,
> +                                        target_ulong *args)
> +{
> +    return H_SUCCESS;
> +}
> +
>  static spapr_hcall_fn papr_hypercall_table[(MAX_HCALL_OPCODE / 4) + 1];
>  static spapr_hcall_fn kvmppc_hypercall_table[KVMPPC_HCALL_MAX - KVMPPC_H=
CALL_BASE + 1];
> =20
> @@ -1907,6 +2126,17 @@ static void hypercall_register_types(void)
>      /* qemu/KVM-PPC specific hcalls */
>      spapr_register_hypercall(KVMPPC_H_RTAS, h_rtas);
> =20
> +    /* qemu/scm specific hcalls */
> +    spapr_register_hypercall(H_SCM_READ_METADATA, h_scm_read_metadata);
> +    spapr_register_hypercall(H_SCM_WRITE_METADATA, h_scm_write_metadata);
> +    spapr_register_hypercall(H_SCM_BIND_MEM, h_scm_bind_mem);
> +    spapr_register_hypercall(H_SCM_UNBIND_MEM, h_scm_unbind_mem);
> +    spapr_register_hypercall(H_SCM_QUERY_BLOCK_MEM_BINDING,
> +                             h_scm_query_block_mem_binding);
> +    spapr_register_hypercall(H_SCM_QUERY_LOGICAL_MEM_BINDING,
> +                             h_scm_query_logical_mem_binding);
> +    spapr_register_hypercall(H_SCM_MEM_QUERY, h_scm_mem_query);
> +
>      /* ibm,client-architecture-support support */
>      spapr_register_hypercall(KVMPPC_H_CAS, h_client_architecture_support=
);
> =20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 21a9709afe..28249567f4 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -268,6 +268,7 @@ struct sPAPRMachineState {
>  #define H_P7              -60
>  #define H_P8              -61
>  #define H_P9              -62
> +#define H_OVERLAP         -68
>  #define H_UNSUPPORTED_FLAG -256
>  #define H_MULTI_THREADS_ACTIVE -9005
> =20
> @@ -473,8 +474,15 @@ struct sPAPRMachineState {
>  #define H_INT_ESB               0x3C8
>  #define H_INT_SYNC              0x3CC
>  #define H_INT_RESET             0x3D0
> -
> -#define MAX_HCALL_OPCODE        H_INT_RESET
> +#define H_SCM_READ_METADATA     0x3E4
> +#define H_SCM_WRITE_METADATA     0x3E8
> +#define H_SCM_BIND_MEM          0x3EC
> +#define H_SCM_UNBIND_MEM        0x3F0
> +#define H_SCM_QUERY_BLOCK_MEM_BINDING 0x3F4
> +#define H_SCM_QUERY_LOGICAL_MEM_BINDING 0x3F8
> +#define H_SCM_MEM_QUERY         0x3FC
> +
> +#define MAX_HCALL_OPCODE        H_SCM_MEM_QUERY
> =20
>  /* The hcalls above are standardized in PAPR and implemented by pHyp
>   * as well.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NqSa+Xr3J/G6Hhls
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxiLz4ACgkQbDjKyiDZ
s5JvtA//T+4EY8fnKl5mm1akXIrv1arbkGYbnbONG3oJc2/LOkMvgENcgKdnfjdf
rO/EePtxUo+Sv1R9Hg0+/nSIJc9HzLUwgEC+i64aRVmSGrPoDVc9nxDWsLPEAtR4
+Kas5vlf6LW2uBZRnPfUEzzUOP7wBnKQAM1VGyGbm2mhfplWd4kYA5tpfCKL9ROB
esmYTBVD2AlsChKs2x9W/dZNCyB9TEhRsBUd89LIBlMI8xGhskcAnIbrmTd4pOr6
EOcmAqVfjmRdiLfHqt2Ek6IhmZlifkAa9bE19lKsPbKpULZQ6tTX9cjtYiU1g2tr
WzEhAA1yjA+OjGuDw69TraWFYRXeUaOMWIm2TN8rNtjRr6uAXYX4ZpiCP+LGznhm
522Zp9dcE6HY197gLGAjOgwsQSP8iLpWYXYoDafOYqbgw+CF/wx+4vUNRoYgc0PY
bVlU5Jo4bnkfElnSN8IwYmy6+vXKdtIDICqnex5logHdq4u9FdbgEcPS6SUoHyQd
Gf5T3nf7TQ4RVMuDXCZpffNMagAypT4OpJQkAHMrt/gNVTJ0k8lqOgIjDX1BIiJY
GfC3jMK/ujMS4ebVPodm75uuWYsVF2/hn75nnSbHmBo1DbqWv6g6TXKp7Pljrf+H
mWXdOurltdYksbdPrwi47eXi4Ou4z6BEIxnkS/NKy9zwZB91rtM=
=yRWO
-----END PGP SIGNATURE-----

--NqSa+Xr3J/G6Hhls--
