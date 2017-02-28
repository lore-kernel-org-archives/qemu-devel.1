Received: from eggs.gnu.org ([2001:4830:134:3::10]:39325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciVmX-00053D-08
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 19:36:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciVmV-00058q-KR
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 19:36:45 -0500
Date: Tue, 28 Feb 2017 11:12:21 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170228001221.GB17615@umbus.fritz.box>
References: <cover.1487829585.git.sam.bobroff@au1.ibm.com>
	<ca5b4ee7d0dc010a545e5ace603dcf019d8d0c02.1487829585.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XeYnZTu7hwE7l7sm"
Content-Disposition: inline
In-Reply-To: <ca5b4ee7d0dc010a545e5ace603dcf019d8d0c02.1487829585.git.sam.bobroff@au1.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 06/12] spapr: Add ibm,
 processor-radix-AP-encodings to the device tree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, sjitindarsingh@gmail.com


--XeYnZTu7hwE7l7sm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 23, 2017 at 04:59:59PM +1100, Sam Bobroff wrote:
> Use the new ioctl, KVM_PPC_GET_RMMU_INFO, to fetch radix MMU
> information from KVM and present the page encodings in the device tree
> under ibm,processor-radix-AP-encodings. This provides page size
> information to the guest which is necessary for it to use radix mode.
>=20
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> ---
> v2:
>=20
> * ppc_radix_page_info now kept in native format, conversion to BE done wh=
en adding to the device tree.
> * radix_page_info moved into the CPU class, cleaning up some code.

Looks pretty good, although I imaginge it will need a little rework to
rebase on top of the TCG radix stuff.  Also one comment below..

>=20
>  hw/ppc/spapr.c       | 12 ++++++++++++
>  include/sysemu/kvm.h |  1 +
>  target/ppc/cpu-qom.h |  1 +
>  target/ppc/cpu.h     |  4 ++++
>  target/ppc/kvm.c     | 27 +++++++++++++++++++++++++++
>  5 files changed, 45 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index cceb35f083..ca3812555f 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -409,6 +409,8 @@ static void spapr_populate_cpu_dt(CPUState *cs, void =
*fdt, int offset,
>      sPAPRDRConnector *drc;
>      sPAPRDRConnectorClass *drck;
>      int drc_index;
> +    uint32_t radix_AP_encodings[PPC_PAGE_SIZES_MAX_SZ];
> +    int i;
> =20
>      drc =3D spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_CPU, index);
>      if (drc) {
> @@ -494,6 +496,16 @@ static void spapr_populate_cpu_dt(CPUState *cs, void=
 *fdt, int offset,
>      _FDT(spapr_fixup_cpu_numa_dt(fdt, offset, cs));
> =20
>      _FDT(spapr_fixup_cpu_smt_dt(fdt, offset, cpu, compat_smt));
> +
> +    if (pcc->radix_page_info) {
> +        for (i =3D 0; i < pcc->radix_page_info->count; i++) {
> +            radix_AP_encodings[i] =3D cpu_to_be32(pcc->radix_page_info->=
entries[i]);
> +        }
> +        _FDT((fdt_setprop(fdt, offset, "ibm,processor-radix-AP-encodings=
",
> +                          radix_AP_encodings,
> +                          pcc->radix_page_info->count *
> +                          sizeof(radix_AP_encodings[0]))));
> +    }
>  }
> =20
>  static void spapr_populate_cpus_dt_node(void *fdt, sPAPRMachineState *sp=
apr)
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index 3045ee7678..01a8db1180 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -526,5 +526,6 @@ int kvm_set_one_reg(CPUState *cs, uint64_t id, void *=
source);
>   * Returns: 0 on success, or a negative errno on failure.
>   */
>  int kvm_get_one_reg(CPUState *cs, uint64_t id, void *target);
> +struct ppc_radix_page_info *kvm_get_radix_page_info(void);
>  int kvm_get_max_memslots(void);
>  #endif
> diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> index 4807f4d86c..0efb543912 100644
> --- a/target/ppc/cpu-qom.h
> +++ b/target/ppc/cpu-qom.h
> @@ -195,6 +195,7 @@ typedef struct PowerPCCPUClass {
>      int bfd_mach;
>      uint32_t l1_dcache_size, l1_icache_size;
>      const struct ppc_segment_page_sizes *sps;
> +    struct ppc_radix_page_info *radix_page_info;
>      void (*init_proc)(CPUPPCState *env);
>      int  (*check_pow)(CPUPPCState *env);
>      int (*handle_mmu_fault)(PowerPCCPU *cpu, vaddr eaddr, int rwx, int m=
mu_idx);
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index b559b67073..a6c8c5ff4c 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -934,6 +934,10 @@ struct ppc_segment_page_sizes {
>      struct ppc_one_seg_page_size sps[PPC_PAGE_SIZES_MAX_SZ];
>  };
> =20
> +struct ppc_radix_page_info {
> +    uint32_t count;
> +    uint32_t entries[PPC_PAGE_SIZES_MAX_SZ];
> +};
> =20
>  /***********************************************************************=
******/
>  /* The whole PowerPC CPU context */
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index d53ede8b4a..cf62a42c1f 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -48,6 +48,7 @@
>  #if defined(TARGET_PPC64)
>  #include "hw/ppc/spapr_cpu_core.h"
>  #endif
> +#include "sysemu/kvm_int.h"
> =20
>  //#define DEBUG_KVM
> =20
> @@ -329,6 +330,30 @@ static void kvm_get_smmu_info(PowerPCCPU *cpu, struc=
t kvm_ppc_smmu_info *info)
>      kvm_get_fallback_smmu_info(cpu, info);
>  }
> =20
> +struct ppc_radix_page_info *kvm_get_radix_page_info(void)
> +{
> +    KVMState *s =3D KVM_STATE(current_machine->accelerator);
> +    struct ppc_radix_page_info *radix_page_info;
> +    struct kvm_ppc_rmmu_info rmmu_info;
> +    int i;
> +
> +    if (!kvm_check_extension(s, KVM_CAP_PPC_MMU_RADIX)) {
> +        return NULL;
> +    }
> +    if (kvm_vm_ioctl(s, KVM_PPC_GET_RMMU_INFO, &rmmu_info)) {
> +        return NULL;
> +    }
> +    radix_page_info =3D g_malloc0(sizeof(*radix_page_info));
> +    radix_page_info->count =3D 0;
> +    for (i =3D 0; i < PPC_PAGE_SIZES_MAX_SZ; i++) {
> +        if (rmmu_info.ap_encodings[i]) {
> +            radix_page_info->entries[i] =3D rmmu_info.ap_encodings[i];
> +            radix_page_info->count++;
> +        }
> +    }
> +    return radix_page_info;
> +}
> +
>  static long gethugepagesize(const char *mem_path)
>  {
>      struct statfs fs;
> @@ -2379,6 +2404,8 @@ static void kvmppc_host_cpu_class_init(ObjectClass =
*oc, void *data)
>          pcc->l1_icache_size =3D icache_size;
>      }
> =20
> +    pcc->radix_page_info =3D kvm_enabled() ? kvm_get_radix_page_info() :=
 NULL;

This whole function is only called in the kvm case: no need to check
kvm_enabled() here.

>      /* Reason: kvmppc_host_cpu_initfn() dies when !kvm_enabled() */
>      dc->cannot_destroy_with_object_finalize_yet =3D true;
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--XeYnZTu7hwE7l7sm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYtMBlAAoJEGw4ysog2bOSxs0P/1y4pUG6v0CvTF7k3Mb8bT+n
OFvwhgx34Amzs61yH6FgSvEXDKKpSpHmaQ6hsNU7DqZb4PzZlVhq6wq5baGdM0/3
sebD2nDmi4OhdVnZU9GlF+NvQTxabGMRHJRZQLE606o0bGK8W68NwxlGCRVXfXUT
drmqfq3slC63tDmeAVjyZQPwFSQrHs8y4IQcixH301nJuXOPX6W9vPMR+HqnfUDM
dPJu7PaMLQlta4cj0ntS5DuADPH7PtdDXHweF65MbkNBTs9koJP8LzqIRZpzbpvu
4WIGSOE0jD1VZKdvPMj0SwEskBuik1+1lqEtw9KniEfcKdQMuJeyPb2cqn+i4r+n
On8WGDP+et64ipzMK+xitOJJyktrCpp8KNAvgcNIZlU+DRmbOh6G0AhFb5Q+XUr/
pmenGdvTWOQifgZk9vqGgQrcCenZfGTMBrFHYrWhKJOzoCkybiHS6ufqZiYRwq0h
o+IdCrVdyVzraOoL3hNJgVpUKrsROpPcUAAt7V0tzKxcdcQBs2f0b5PhtMPtE6e9
a4QbVdvMJrsRO1WcPmsD7qPOBGR5YWRx/IKnWJGXPUvHV6OJKfO8vTTlWWqHNe/2
hJJ+xY49wxiEvMQWomVFwt7Pr617IzE0JRFBXXxBkhCKEtUP8kyuTxIgHULOZE0b
MAP0i3ywjh19TSAj1hbd
=XPgS
-----END PGP SIGNATURE-----

--XeYnZTu7hwE7l7sm--
