Received: from eggs.gnu.org ([2001:4830:134:3::10]:40819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ct4gA-0004Pz-TS
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 23:53:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ct4g9-0003kY-9R
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 23:53:51 -0400
Date: Wed, 29 Mar 2017 14:53:36 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170329035336.GT21068@umbus.fritz.box>
References: <20170328090530.20052-1-aik@ozlabs.ru>
	<20170328090530.20052-4-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yypaS3FvPkEUiGyo"
Content-Disposition: inline
In-Reply-To: <20170328090530.20052-4-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [RFC PATCH qemu 3/3] vfio: Enable in-kernel
 acceleration via VFIO KVM device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>


--yypaS3FvPkEUiGyo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 28, 2017 at 08:05:30PM +1100, Alexey Kardashevskiy wrote:
> This enables in-kernel acceleration of TCE update requests via
> VFIO KVM device.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  include/hw/vfio/vfio-common.h |  1 +
>  target/ppc/kvm_ppc.h          |  6 ++++++
>  hw/ppc/spapr_iommu.c          |  4 ++++
>  hw/vfio/common.c              | 13 +++++++++++++
>  hw/vfio/spapr.c               | 26 ++++++++++++++++++++++++++
>  target/ppc/kvm.c              |  7 ++++++-
>  hw/vfio/trace-events          |  1 +
>  7 files changed, 57 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index c582de18c9..ee8c96cc4a 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -175,6 +175,7 @@ extern const MemoryListener vfio_prereg_listener;
>  int vfio_spapr_create_window(VFIOContainer *container,
>                               MemoryRegionSection *section,
>                               hwaddr *pgsize);
> +int vfio_spapr_notify_kvm(int vfio_kvm_device_fd, int groupfd, int table=
fd);
>  int vfio_spapr_remove_window(VFIOContainer *container,
>                               hwaddr offset_within_address_space);
> =20
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index f48243d13f..ce7327a4e0 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -46,6 +46,7 @@ void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t =
page_shift,
>  int kvmppc_remove_spapr_tce(void *table, int pfd, uint32_t window_size);
>  int kvmppc_reset_htab(int shift_hint);
>  uint64_t kvmppc_rma_size(uint64_t current_size, unsigned int hash_shift);
> +bool kvmppc_has_cap_spapr_vfio(void);
>  #endif /* !CONFIG_USER_ONLY */
>  bool kvmppc_has_cap_epr(void);
>  int kvmppc_define_rtas_kernel_token(uint32_t token, const char *function=
);
> @@ -216,6 +217,11 @@ static inline bool kvmppc_is_mem_backend_page_size_o=
k(char *obj_path)
>      return true;
>  }
> =20
> +static inline bool kvmppc_has_cap_spapr_vfio(void)
> +{
> +    return false;
> +}
> +
>  #endif /* !CONFIG_USER_ONLY */
> =20
>  static inline bool kvmppc_has_cap_epr(void)
> diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
> index b61c8f053e..fc23d81645 100644
> --- a/hw/ppc/spapr_iommu.c
> +++ b/hw/ppc/spapr_iommu.c
> @@ -293,6 +293,10 @@ void spapr_tce_set_need_vfio(sPAPRTCETable *tcet, bo=
ol need_vfio)
> =20
>      tcet->need_vfio =3D need_vfio;
> =20
> +    if (!need_vfio || (tcet->fd !=3D -1 && kvmppc_has_cap_spapr_vfio()))=
 {
> +        return;
> +    }
> +
>      oldtable =3D tcet->table;
> =20
>      tcet->table =3D spapr_tce_alloc_table(tcet->liobn,
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index c75c7594d5..9aaf861904 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -440,6 +440,19 @@ static void vfio_listener_region_add(MemoryListener =
*listener,
>              goto fail;
>          }
> =20
> +#ifdef CONFIG_KVM
> +        if (kvm_enabled() && section->mr->iommu_ops->get_fd) {
> +            VFIOGroup *group;
> +            int tablefd =3D  section->mr->iommu_ops->get_fd(section->mr);
> +
> +            if (tablefd !=3D -1) {
> +                QLIST_FOREACH(group, &container->group_list, container_n=
ext) {
> +                    vfio_spapr_notify_kvm(vfio_kvm_device_fd,
> +                                          group->fd, tablefd);

This is only going to make sense if we have both PAPR-style TCE tables
on the guest and TCE-based IOMMU backend on the host.  In which case
wouldn't it make more sense to explicitly verify that, and upcast,
rather than adding a new vaguely-specified get_fd hook.

> +                }
> +            }
> +        }
> +#endif
>          vfio_host_win_add(container, section->offset_within_address_spac=
e,
>                            section->offset_within_address_space +
>                            int128_get64(section->size) - 1, pgsize);
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index 4409bcc0d7..dffef3bd5f 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -17,6 +17,9 @@
>  #include "hw/hw.h"
>  #include "qemu/error-report.h"
>  #include "trace.h"
> +#ifdef CONFIG_KVM
> +#include "linux/kvm.h"
> +#endif
> =20
>  static bool vfio_prereg_listener_skipped_section(MemoryRegionSection *se=
ction)
>  {
> @@ -187,6 +190,29 @@ int vfio_spapr_create_window(VFIOContainer *containe=
r,
>      return 0;
>  }
> =20
> +int vfio_spapr_notify_kvm(int vfio_kvm_device_fd, int groupfd, int table=
fd)
> +{
> +#ifdef CONFIG_KVM
> +    struct kvm_vfio_spapr_tce param =3D {
> +        .groupfd =3D groupfd,
> +        .tablefd =3D tablefd
> +    };
> +    struct kvm_device_attr attr =3D {
> +        .group =3D KVM_DEV_VFIO_GROUP,
> +        .attr =3D KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE,
> +        .addr =3D (uint64_t)(unsigned long)&param,
> +    };
> +
> +    if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
> +        error_report("vfio: failed to setup fd %d for a group with fd %d=
: %s",
> +                     param.tablefd, param.groupfd, strerror(errno));
> +        return -errno;
> +    }
> +    trace_vfio_spapr_notify_kvm(groupfd, tablefd);
> +#endif
> +    return 0;
> +}
> +
>  int vfio_spapr_remove_window(VFIOContainer *container,
>                               hwaddr offset_within_address_space)
>  {
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 560ce655c7..bca5fe7329 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -131,7 +131,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>      cap_spapr_tce =3D kvm_check_extension(s, KVM_CAP_SPAPR_TCE);
>      cap_spapr_tce_64 =3D kvm_check_extension(s, KVM_CAP_SPAPR_TCE_64);
>      cap_spapr_multitce =3D kvm_check_extension(s, KVM_CAP_SPAPR_MULTITCE=
);
> -    cap_spapr_vfio =3D false;
> +    cap_spapr_vfio =3D kvm_check_extension(s, KVM_CAP_SPAPR_TCE_VFIO);
>      cap_one_reg =3D kvm_check_extension(s, KVM_CAP_ONE_REG);
>      cap_hior =3D kvm_check_extension(s, KVM_CAP_PPC_HIOR);
>      cap_epr =3D kvm_check_extension(s, KVM_CAP_PPC_EPR);
> @@ -2416,6 +2416,11 @@ bool kvmppc_has_cap_mmu_hash_v3(void)
>      return cap_mmu_hash_v3;
>  }
> =20
> +bool kvmppc_has_cap_spapr_vfio(void)
> +{
> +    return cap_spapr_vfio;
> +}
> +
>  static PowerPCCPUClass *ppc_cpu_get_family_class(PowerPCCPUClass *pcc)
>  {
>      ObjectClass *oc =3D OBJECT_CLASS(pcc);
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 2561c6d31a..084a92f7c2 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -123,3 +123,4 @@ vfio_prereg_register(uint64_t va, uint64_t size, int =
ret) "va=3D%"PRIx64" size=3D%"P
>  vfio_prereg_unregister(uint64_t va, uint64_t size, int ret) "va=3D%"PRIx=
64" size=3D%"PRIx64" ret=3D%d"
>  vfio_spapr_create_window(int ps, uint64_t ws, uint64_t off) "pageshift=
=3D0x%x winsize=3D0x%"PRIx64" offset=3D0x%"PRIx64
>  vfio_spapr_remove_window(uint64_t off) "offset=3D%"PRIx64
> +vfio_spapr_notify_kvm(int groupfd, int tablefd) "Attached groupfd %d to =
liobn fd %d"

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--yypaS3FvPkEUiGyo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY2y/AAAoJEGw4ysog2bOSaScQAMm+qspAKiSd7Q4yraIr2ila
xiL/isYraQnyuDnSxivTNFfB5UK+OxM7bhu2f2JqVXRcfG83vXDpTEf/4iQKf1SR
5ArK2OHVYPkpqQkiAHSFCbzUjqvU+IyimTLuupDQ+3gK/xhNOgyH1Q2Wjz1go+R6
ICVegbV+F1wth6eZRhK2i1j+RfrrJeAJndFiBHPRC50Evd76gcM2CMBPMcxG/ruW
lkIWxKtWz9YM+l2HbqAHlaAHXEWEVWdqH+GGCUjKzfLTXTrOyh9D9krXjXJBHdg8
8yJGhqPFZX66V+oVKJiakIOJbxN3xt2O6Wk92z/tqaXs6BJfc2IMf1vgGCMdGiDn
3rvjms1knb02eMuNBlurz/TufFFdcZ7cQX9LXzzeeUUpnIan1ns41mEAiW9PDXbH
n0aLbLusfO26ZZ8fKpPoAFGEdhfNBuTm/I9rxsNiDJmuBzkXEQZwQ5sqD+cQAfmq
QU2sX1+oY1eQwsFZX887sUhhVS/EfoYzR0MSVGD90GWd8e3h5eRPpjja5fGoGr2C
ClLGwERp4Pc9JQcm6ZrQ4ipFk93knbOa6fsYF7RW++Yk4p/nZlTnaZ2N+/+Gr1tD
QEXtG7vwCi8J3ORW562+EFRrx1euFavGycA/3SKDmuC03Hpsx8GbOWuKmUNF+lX3
Cfql/AKqtE8Wzxv5KAUu
=5XzK
-----END PGP SIGNATURE-----

--yypaS3FvPkEUiGyo--
