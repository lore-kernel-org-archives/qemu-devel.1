Received: from eggs.gnu.org ([2001:4830:134:3::10]:55552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cusFp-0000eO-Re
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 23:02:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cusFo-0000Ql-IX
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 23:02:05 -0400
Date: Mon, 3 Apr 2017 13:01:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170403030122.GB10997@umbus.fritz.box>
References: <20170401123741.38469-1-aik@ozlabs.ru>
	<20170401123741.38469-4-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
Content-Disposition: inline
In-Reply-To: <20170401123741.38469-4-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [RFC PATCH qemu v3 3/4] vfio/spapr: Add a notifier
 for PPC64 HV/PR KVM about new group attached to LIOBN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 01, 2017 at 11:37:40PM +1100, Alexey Kardashevskiy wrote:
> This implements a notification for a new IOMMU group attached to
> sPAPR's logical IO bus (LIOBN) to enable in-kernel TCE acceleration.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  include/hw/ppc/spapr.h        |  1 +
>  include/hw/vfio/vfio-common.h |  2 ++
>  hw/ppc/spapr_iommu.c          |  5 +++++
>  hw/vfio/common.c              | 10 ++++++++++
>  hw/vfio/spapr.c               | 31 +++++++++++++++++++++++++++++++
>  hw/vfio/trace-events          |  1 +
>  6 files changed, 50 insertions(+)
>=20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 6997ed7e98..8a1b32f89a 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -617,6 +617,7 @@ void spapr_tce_table_enable(sPAPRTCETable *tcet,
>                              uint32_t page_shift, uint64_t bus_offset,
>                              uint32_t nb_table);
>  void spapr_tce_table_disable(sPAPRTCETable *tcet);
> +int spapr_tce_get_fd(sPAPRTCETable *tcet);
>  void spapr_tce_set_need_vfio(sPAPRTCETable *tcet, bool need_vfio);
> =20
>  MemoryRegion *spapr_tce_get_iommu(sPAPRTCETable *tcet);
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 7a4135ae6f..b99f4af96e 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -175,6 +175,8 @@ extern const MemoryListener vfio_prereg_listener;
>  int vfio_spapr_create_window(VFIOContainer *container,
>                               MemoryRegionSection *section,
>                               hwaddr *pgsize);
> +int vfio_spapr_notify_kvm(int vfio_kvm_device_fd, int groupfd,
> +                          IOMMUMemoryRegion *iommumr);
>  int vfio_spapr_remove_window(VFIOContainer *container,
>                               hwaddr offset_within_address_space);
> =20
> diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
> index 5051110b9d..f7531a6408 100644
> --- a/hw/ppc/spapr_iommu.c
> +++ b/hw/ppc/spapr_iommu.c
> @@ -171,6 +171,11 @@ static void spapr_tce_notify_flag_changed(IOMMUMemor=
yRegion *iommu,
>      }
>  }
> =20
> +int spapr_tce_get_fd(sPAPRTCETable *tcet)
> +{
> +    return tcet->fd;
> +}
> +

I don't think this actually abstracts anything worthwhile.  The caller
needs the sPAPRTCETable definition anyway to use container_of(), so it
might as well just grab the field directly.

>  static int spapr_tce_table_post_load(void *opaque, int version_id)
>  {
>      sPAPRTCETable *tcet =3D SPAPR_TCE_TABLE(opaque);
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index e8188eb3d5..b94b29be15 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -440,6 +440,16 @@ static void vfio_listener_region_add(MemoryListener =
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
> +#endif
>          vfio_host_win_add(container, section->offset_within_address_spac=
e,
>                            section->offset_within_address_space +
>                            int128_get64(section->size) - 1, pgsize);
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index 551870d46b..6410438e62 100644
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
> @@ -188,6 +192,33 @@ int vfio_spapr_create_window(VFIOContainer *containe=
r,
>      return 0;
>  }
> =20
> +int vfio_spapr_notify_kvm(int vfio_kvm_device_fd, int groupfd,
> +                          IOMMUMemoryRegion *iommumr)
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
> +    sPAPRTCETable *tcet =3D container_of(iommumr, sPAPRTCETable, iommu);

This isn't safe.  The caller has verified that the host backend IOMMU
is sPAPR TCE, but you haven't verified that the *guest* IOMMU is TCE
based.  I suspect other details would prevent a TCG x86 machine with
VT-d running on a Power host from getting this far, but it's not good
to rely on that.

So, you need to explicitly verify that the guest IOMMU region really
is a PAPR TCE region.  The obvious way would be to continue your
QOMification and make sPAPRTCETable a subtype of IOMMUMemoryRegion,
rather than just including it by composition.

> +
> +    param.tablefd =3D spapr_tce_get_fd(tcet);
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

--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY4br/AAoJEGw4ysog2bOS2OwQAIH3OkEshWZKVT1MDO06VY+5
xwPhvaVnAWgeuVK8JJn73iXm3/QdPro4CfjcYCGtyDsyRNwn7R19fyfKSTMAoSq0
liG4NIN8R90Zu0FM8ChJgimPR7/LElNR7W17mP6aqARofxNA187/lHpw4Ardrzxz
p2YFk/CW9bi4d0kLKMG/skjqW2CVyiYEhufS1ojtHE4We0FPLCsPbFygPJQstqLi
kDIvNObFACeRCs0j5rD8ZIpsUgoPPM5PfQyvG20eAdR9f31/vRi35Xwl9mSwVSLf
5SfHlWSos5d73L8Ohd+w0Qlw8FzKoQkjTmdSZ4WCvo3+QSwyLhwW7FwzhWNzkQJL
tc3YYS7oXF4B/lYiW552ydn2fKDqjEu8AHcdxRpACGEG6F+7GtS8aRDgDy+W5Cv2
ikmWu6eUs6pKXtx5GeMdcrHnTof1xJikfLeN4qCjExLuBd8EHxZST3zumPPEv5Ls
KH52MT5oXS3V5Jkd/h6dlTyD43JfV6H49W64kGyKZFBW2oO5WhRP8Hr1CPjxHY30
tzEB7iIEqpw4K2XfcpOjZNq/CKW5HO5c3y+Zk5b6JYLTIzJqZcigJ6cYyF7nAcUN
gHgHhDsNW8ZwHv58iXDhrwGosbnFc8Mvvs5S1eFhZLINCW9vExiVR0D1eopoPwXH
aB0MLu3bfPHSDlgt7MMF
=xUUZ
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
