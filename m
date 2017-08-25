Received: from eggs.gnu.org ([2001:4830:134:3::10]:44362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dl80U-0003Dd-6f
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 02:22:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dl80Q-000102-AI
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 02:22:14 -0400
Date: Fri, 25 Aug 2017 16:21:53 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170825062153.GF2772@umbus.fritz.box>
References: <20170720072231.35054-1-aik@ozlabs.ru>
	<20170720072231.35054-3-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RE3pQJLXZi4fr8Xo"
Content-Disposition: inline
In-Reply-To: <20170720072231.35054-3-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu v4 2/3] vfio/spapr: Add a notifier for
 PPC64 HV/PR KVM about new group attached to LIOBN
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


--RE3pQJLXZi4fr8Xo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2017 at 05:22:30PM +1000, Alexey Kardashevskiy wrote:
> This implements a notification for a new IOMMU group attached to
> sPAPR's logical IO bus (LIOBN) to enable in-kernel TCE acceleration.
>=20
> This extends the TYPE_SPAPR_IOMMU_MEMORY_REGION class with a get_fd()
> callback which returns KVM fd associated with LIOBN, the notifier uses it
> to establish link between LIOBN and IOMMU group in the KVM.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>=20
> The practical reason for adding get_fd() as a callback is avoiding static
> linking to spapt_tce_get_fd(): hw/vfio/spapr.c compiles when
> CONFIG_SOFTMMU=3Dy to avoid multiple "ifdef PSERIES"'s in the rest
> of VFIO code but hw/ppc/spapr_iommu.c (where spapt_tce_get_fd() besides)
> compiles only when CONFIG_PSERIES=3Dy.

Ok.  Nonetheless I don't think the get_fd() method is a good idea.
First, it's basically an abstraction violation, exposing the region's
internal fd.  Second, it's a method which only plausibly has one
implementation which is rarely sensible.

What this comes down to is that the guest IOMMU mechanism needs
information about host vfio groups mapped - for an optimization in
this case.

So what would make sense to me is to put an "add_vfio_group" method
into IOMMUMemoryRegionClass (or even MemoryRegionClass).  In most
cases that will be NULL (=3D=3D no-op).  For the spapr IOMMU region, it
will (attempt to) connect the host group to the guest liobn.

> ---
>  include/hw/ppc/spapr.h        | 15 +++++++++++++++
>  include/hw/vfio/vfio-common.h |  2 ++
>  hw/ppc/spapr_iommu.c          | 10 ++++++++++
>  hw/vfio/common.c              | 10 ++++++++++
>  hw/vfio/spapr.c               | 39 +++++++++++++++++++++++++++++++++++++=
++
>  hw/vfio/trace-events          |  1 +
>  6 files changed, 77 insertions(+)
>=20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 2a303a705c..c1d37e6356 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -591,6 +591,7 @@ void spapr_load_rtas(sPAPRMachineState *spapr, void *=
fdt, hwaddr addr);
>  #define RTAS_EVENT_SCAN_RATE    1
> =20
>  typedef struct sPAPRTCETable sPAPRTCETable;
> +typedef struct sPAPRIOMMUMemoryRegionClass sPAPRIOMMUMemoryRegionClass;
> =20
>  #define TYPE_SPAPR_TCE_TABLE "spapr-tce-table"
>  #define SPAPR_TCE_TABLE(obj) \
> @@ -599,6 +600,12 @@ typedef struct sPAPRTCETable sPAPRTCETable;
>  #define TYPE_SPAPR_IOMMU_MEMORY_REGION "spapr-iommu-memory-region"
>  #define SPAPR_IOMMU_MEMORY_REGION(obj) \
>          OBJECT_CHECK(IOMMUMemoryRegion, (obj), TYPE_SPAPR_IOMMU_MEMORY_R=
EGION)
> +#define SPAPR_IOMMU_MEMORY_REGION_GET_CLASS(obj) \
> +        OBJECT_GET_CLASS(sPAPRIOMMUMemoryRegionClass, obj, \
> +                         TYPE_SPAPR_IOMMU_MEMORY_REGION)
> +#define SPAPR_IOMMU_MEMORY_REGION_CLASS(klass) \
> +        OBJECT_CLASS_CHECK(sPAPRIOMMUMemoryRegionClass, klass, \
> +                           TYPE_SPAPR_IOMMU_MEMORY_REGION)
> =20
>  struct sPAPRTCETable {
>      DeviceState parent;
> @@ -618,6 +625,14 @@ struct sPAPRTCETable {
>      QLIST_ENTRY(sPAPRTCETable) list;
>  };
> =20
> +struct sPAPRIOMMUMemoryRegionClass {
> +    /* private */
> +    IOMMUMemoryRegionClass parent_class;
> +
> +    /* public */
> +    int (*get_fd)(IOMMUMemoryRegion *iommu_mr);
> +};
> +
>  sPAPRTCETable *spapr_tce_find_by_liobn(target_ulong liobn);

To make sure I'm understanding correctly: the MR subclass here is
representing a guest-side property, yes?  It means that on the guest
side the IOMMU mappings are managed by the PAPR {GET,PUT}_TCE
interface.

>  struct sPAPREventLogEntry {
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index f3a2ac9fee..d245d3cecc 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -177,6 +177,8 @@ extern const MemoryListener vfio_prereg_listener;
>  int vfio_spapr_create_window(VFIOContainer *container,
>                               MemoryRegionSection *section,
>                               hwaddr *pgsize);
> +int vfio_spapr_notify_kvm(int vfio_kvm_device_fd, int groupfd,
> +                          IOMMUMemoryRegion *iommumr);
>  int vfio_spapr_remove_window(VFIOContainer *container,
>                               hwaddr offset_within_address_space);
> =20
> diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
> index 307dc3021e..82fca61a75 100644
> --- a/hw/ppc/spapr_iommu.c
> +++ b/hw/ppc/spapr_iommu.c
> @@ -171,6 +171,13 @@ static void spapr_tce_notify_flag_changed(IOMMUMemor=
yRegion *iommu,
>      }
>  }
> =20
> +static int spapr_tce_get_fd(IOMMUMemoryRegion *iommu_mr)
> +{
> +    sPAPRTCETable *tcet =3D container_of(iommu_mr, sPAPRTCETable, iommu);
> +
> +    return tcet->fd;

Does this have a well defined value if there's no KVM?

> +}
> +
>  static int spapr_tce_table_post_load(void *opaque, int version_id)
>  {
>      sPAPRTCETable *tcet =3D SPAPR_TCE_TABLE(opaque);
> @@ -631,16 +638,19 @@ static TypeInfo spapr_tce_table_info =3D {
>  static void spapr_iommu_memory_region_class_init(ObjectClass *klass, voi=
d *data)
>  {
>      IOMMUMemoryRegionClass *imrc =3D IOMMU_MEMORY_REGION_CLASS(klass);
> +    sPAPRIOMMUMemoryRegionClass *simrc =3D SPAPR_IOMMU_MEMORY_REGION_CLA=
SS(klass);
> =20
>      imrc->translate =3D spapr_tce_translate_iommu;
>      imrc->get_min_page_size =3D spapr_tce_get_min_page_size;
>      imrc->notify_flag_changed =3D spapr_tce_notify_flag_changed;
> +    simrc->get_fd =3D spapr_tce_get_fd;
>  }
> =20
>  static const TypeInfo spapr_iommu_memory_region_info =3D {
>      .parent =3D TYPE_IOMMU_MEMORY_REGION,
>      .name =3D TYPE_SPAPR_IOMMU_MEMORY_REGION,
>      .class_init =3D spapr_iommu_memory_region_class_init,
> +    .class_size =3D sizeof(sPAPRIOMMUMemoryRegionClass),
>  };
> =20
>  static void register_types(void)
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 7b2924c0ef..92f1f88ae8 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -454,6 +454,16 @@ static void vfio_listener_region_add(MemoryListener =
*listener,
>              goto fail;
>          }
> =20
> +#ifdef CONFIG_KVM
> +        if (kvm_enabled()) {
> +            VFIOGroup *group;
> +
> +            QLIST_FOREACH(group, &container->group_list, container_next)=
 {
> +                vfio_spapr_notify_kvm(vfio_kvm_device_fd, group->fd,
> +                                      IOMMU_MEMORY_REGION(section->mr));
> +            }
> +        }

So, here you're informing the region of the groups when the region is
mapped in.  But don't you similarly need to notify if a group is added
to an existing address space?  And won't you also need notifications
of groups/regions being removed?

> +#endif
>          vfio_host_win_add(container, section->offset_within_address_spac=
e,
>                            section->offset_within_address_space +
>                            int128_get64(section->size) - 1, pgsize);
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index 32fd6a9b54..2b9af75c03 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -15,8 +15,12 @@
> =20
>  #include "hw/vfio/vfio-common.h"
>  #include "hw/hw.h"
> +#include "hw/ppc/spapr.h"
>  #include "qemu/error-report.h"
>  #include "trace.h"
> +#ifdef CONFIG_KVM
> +#include "linux/kvm.h"
> +#endif
> =20
>  static bool vfio_prereg_listener_skipped_section(MemoryRegionSection *se=
ction)
>  {
> @@ -188,6 +192,41 @@ int vfio_spapr_create_window(VFIOContainer *containe=
r,
>      return 0;
>  }
> =20
> +int vfio_spapr_notify_kvm(int vfio_kvm_device_fd, int groupfd,
> +                          IOMMUMemoryRegion *iommu_mr)
> +{
> +#ifdef CONFIG_KVM
> +    struct kvm_vfio_spapr_tce param =3D {
> +        .groupfd =3D groupfd,
> +    };
> +    struct kvm_device_attr attr =3D {
> +        .group =3D KVM_DEV_VFIO_GROUP,
> +        .attr =3D KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE,
> +        .addr =3D (uint64_t)(unsigned long)&param,
> +    };
> +    IOMMUMemoryRegion *spapr_iommu_mr =3D SPAPR_IOMMU_MEMORY_REGION(iomm=
u_mr);

This will assert if you have a non-spapr guest IOMMU on a ppc host
(e.g. emulating an x86 with VT-d under TCG).

> +    sPAPRIOMMUMemoryRegionClass *simrc =3D
> +            SPAPR_IOMMU_MEMORY_REGION_GET_CLASS(spapr_iommu_mr);
> +
> +    if (!simrc->get_fd) {
> +        error_report("vfio: No get_fd defined for IOMMU MR");
> +        return -EFAULT;
> +    }
> +
> +    param.tablefd =3D simrc->get_fd(spapr_iommu_mr);
> +
> +    if (param.tablefd !=3D -1) {
> +        if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
> +            error_report("vfio: failed to setup fd %d for a group with f=
d %d: %s",
> +                         param.tablefd, param.groupfd, strerror(errno));
> +            return -errno;
> +        }
> +    }
> +    trace_vfio_spapr_notify_kvm(groupfd, param.tablefd);
> +#endif
> +    return 0;
> +}
> +
>  int vfio_spapr_remove_window(VFIOContainer *container,
>                               hwaddr offset_within_address_space)
>  {
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

--RE3pQJLXZi4fr8Xo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmfwf8ACgkQbDjKyiDZ
s5Jinw//VLLzMwQQE5s6zA0Mv4mSnoDztfslPq6VhmqO43PDA9tkXduoOLKmV/RR
eIUQ57W6+qaFSafy9QQMlMX33HhQ7ZZb/bNSG20A/mHeJ/Nf/eDtKvF5D02xFBvi
ucGYpVGQexyh71ajy/o4cjYBZCf2sNo3ctUKPrxhbdLPbsX63RNOHOmYCc0cdF1i
K2Bf+4wB/iHH/OSjm0ThacOpPLmbZwjINxDVUsZnYPhdIgDLQUMKTsrkN21hnqQj
XtiFoeuzZjsl3UmVPpMLx2NmiIDjq4dz0q7cMntILFrwIFff9maVqyyxregJt8PV
tsQx9XD+kanmBQoX/rnBT4V2kkbxoqa1c0L0Guxn9cQCU5Nd0FiRoxgxj4sQUaO4
5lkVguuqKLnmmF3O+P6VeEb9QOG8fskwkbnSvCYPwLN8uFcn49vjXPI34575Bxe7
AW3Ssx3GFRPuxZlK5HhYeFD6eXon+e1JCnh8Sk7r3bebECyy+DzjKSi7MB6VVtFN
djlHKKhH9W6bNWvs7cTkE3Nh1/Sy591HVsTxm4EL1MXIOShCmfOu9DoLcU+6ss9u
PC6GLXrBaWqijLFPAZBPlWD9zO2bAWyAe6heM3Xuy2D60jTT7KOvQ1f/7e/bCH6n
JoviifsSGRVyZSbY5gLnD9DMQUxAB2A+ORbB0PPYONLoG8s7iv4=
=9+IF
-----END PGP SIGNATURE-----

--RE3pQJLXZi4fr8Xo--
