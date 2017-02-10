Received: from eggs.gnu.org ([2001:4830:134:3::10]:39492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cc17q-0000iS-5y
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:39:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cc17h-0007cF-Jp
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:39:49 -0500
Received: from ozlabs.org ([103.22.144.67]:36701)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1cc17g-0007aT-VK
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:39:45 -0500
Date: Fri, 10 Feb 2017 13:29:34 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170210022934.GZ27610@umbus.fritz.box>
References: <1486456099-7345-1-git-send-email-peterx@redhat.com>
	<1486456099-7345-11-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/cFG30PKHi9lwv6o"
Content-Disposition: inline
In-Reply-To: <1486456099-7345-11-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 10/17] memory: add section range info
 for IOMMU notifier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, alex.williamson@redhat.com, bd.aviv@gmail.com


--/cFG30PKHi9lwv6o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 07, 2017 at 04:28:12PM +0800, Peter Xu wrote:
> In this patch, IOMMUNotifier.{start|end} are introduced to store section
> information for a specific notifier. When notification occurs, we not
> only check the notification type (MAP|UNMAP), but also check whether the
> notified iova range overlaps with the range of specific IOMMU notifier,
> and skip those notifiers if not in the listened range.
>=20
> When removing an region, we need to make sure we removed the correct
> VFIOGuestIOMMU by checking the IOMMUNotifier.start address as well.
>=20
> Suggested-by: David Gibson <david@gibson.dropbear.id.au>
> Acked-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/vfio/common.c      | 12 +++++++++---
>  hw/virtio/vhost.c     |  4 ++--
>  include/exec/memory.h | 19 ++++++++++++++++++-
>  memory.c              |  9 +++++++++
>  4 files changed, 38 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index f3ba9b9..6b33b9f 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -478,8 +478,13 @@ static void vfio_listener_region_add(MemoryListener =
*listener,
>          giommu->iommu_offset =3D section->offset_within_address_space -
>                                 section->offset_within_region;
>          giommu->container =3D container;
> -        giommu->n.notify =3D vfio_iommu_map_notify;
> -        giommu->n.notifier_flags =3D IOMMU_NOTIFIER_ALL;
> +        llend =3D int128_add(int128_make64(section->offset_within_region=
),
> +                           section->size);
> +        llend =3D int128_sub(llend, int128_one());
> +        iommu_notifier_init(&giommu->n, vfio_iommu_map_notify,
> +                            IOMMU_NOTIFIER_ALL,
> +                            section->offset_within_region,
> +                            int128_get64(llend));
>          QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_next);
> =20
>          memory_region_register_iommu_notifier(giommu->iommu, &giommu->n);
> @@ -550,7 +555,8 @@ static void vfio_listener_region_del(MemoryListener *=
listener,
>          VFIOGuestIOMMU *giommu;
> =20
>          QLIST_FOREACH(giommu, &container->giommu_list, giommu_next) {
> -            if (giommu->iommu =3D=3D section->mr) {
> +            if (giommu->iommu =3D=3D section->mr &&
> +                giommu->n.start =3D=3D section->offset_within_region) {
>                  memory_region_unregister_iommu_notifier(giommu->iommu,
>                                                          &giommu->n);
>                  QLIST_REMOVE(giommu, giommu_next);
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index febe519..ccf8b2e 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1244,8 +1244,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *op=
aque,
>          .priority =3D 10
>      };
> =20
> -    hdev->n.notify =3D vhost_iommu_unmap_notify;
> -    hdev->n.notifier_flags =3D IOMMU_NOTIFIER_UNMAP;
> +    iommu_notifier_init(&hdev->n, vhost_iommu_unmap_notify,
> +                        IOMMU_NOTIFIER_UNMAP, 0, ~0ULL);
> =20
>      if (hdev->migration_blocker =3D=3D NULL) {
>          if (!(hdev->features & (0x1ULL << VHOST_F_LOG_ALL))) {
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 987f925..805a88a 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -77,13 +77,30 @@ typedef enum {
> =20
>  #define IOMMU_NOTIFIER_ALL (IOMMU_NOTIFIER_MAP | IOMMU_NOTIFIER_UNMAP)
> =20
> +struct IOMMUNotifier;
> +typedef void (*IOMMUNotify)(struct IOMMUNotifier *notifier,
> +                            IOMMUTLBEntry *data);
> +
>  struct IOMMUNotifier {
> -    void (*notify)(struct IOMMUNotifier *notifier, IOMMUTLBEntry *data);
> +    IOMMUNotify notify;
>      IOMMUNotifierFlag notifier_flags;
> +    /* Notify for address space range start <=3D addr <=3D end */
> +    hwaddr start;
> +    hwaddr end;
>      QLIST_ENTRY(IOMMUNotifier) node;
>  };
>  typedef struct IOMMUNotifier IOMMUNotifier;
> =20
> +static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
> +                                       IOMMUNotifierFlag flags,
> +                                       hwaddr start, hwaddr end)
> +{
> +    n->notify =3D fn;
> +    n->notifier_flags =3D flags;
> +    n->start =3D start;
> +    n->end =3D end;
> +}
> +
>  /* New-style MMIO accessors can indicate that the transaction failed.
>   * A zero (MEMTX_OK) response means success; anything else is a failure
>   * of some kind. The memory subsystem will bitwise-OR together results
> diff --git a/memory.c b/memory.c
> index 6c58373..4900bbf 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1610,6 +1610,7 @@ void memory_region_register_iommu_notifier(MemoryRe=
gion *mr,
> =20
>      /* We need to register for at least one bitfield */
>      assert(n->notifier_flags !=3D IOMMU_NOTIFIER_NONE);
> +    assert(n->start <=3D n->end);
>      QLIST_INSERT_HEAD(&mr->iommu_notify, n, node);
>      memory_region_update_iommu_notify_flags(mr);
>  }
> @@ -1671,6 +1672,14 @@ void memory_region_notify_iommu(MemoryRegion *mr,
>      }
> =20
>      QLIST_FOREACH(iommu_notifier, &mr->iommu_notify, node) {
> +        /*
> +         * Skip the notification if the notification does not overlap
> +         * with registered range.
> +         */
> +        if (iommu_notifier->start > entry.iova + entry.addr_mask + 1 ||
> +            iommu_notifier->end < entry.iova) {
> +            continue;
> +        }
>          if (iommu_notifier->notifier_flags & request_flags) {
>              iommu_notifier->notify(iommu_notifier, &entry);
>          }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/cFG30PKHi9lwv6o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYnSWOAAoJEGw4ysog2bOS7WsQANBQEJRF/lDWeaoo4sJVF4IO
5e/2mDIHTKV397ZcueMt1VQsHQFpOlFTTN8KW8PAj2JDsbibYUUelZvs+RLKcfik
fyJ1Ij97LQHbktSz4bDbYJgY86NKPiO/UIQ8zpLA5Spk1AURD5ryIKeasOH0xpSu
eblYqXOuxefeCp05pQH3xMwDBWWT58c1yqYYIlJ3QnkcPwQZNZMu2VCLBpAF4cS+
IHEBhUrNKM/B+jhHFOb7vzXXdpzZtP12R4ZOZbeSSnjVzxRYvcupHsVifs5ytXK0
bjHnIecn7lwhi67JXdTPW7VYziFQOwQzL0DvGPmE6Xl08v5qgqH2M5YqIMFB7+wF
/souO5fRQ87nLh2CTthXItfqcP9VMyO99fRdFxF8/gMl20UnJLlqNaQjqSvxqtws
dzG2go2H64Nagyydh3dG2kCqJr7RP4+qaHGg+05dokrDD4DJcR5SDgAChnGnp5Ib
AfWiviJgw3WKLw22wps7B5kKRoum0Y8eawxMY50DqGz55rDNRTDWR0Sy5wBNQjZ/
ImgWFhOBKwFHmUWDuakNCEXhZLcgjhjQDr/0Q/dr/ZGP7BfG9BKoJK0oYyc8dV3q
j9GsH/peTxD05URjF7wqBQjt1PtoZI/oAT9uaes+wJxI4KTvw85ace7tDw/4JwlA
ej4nMIU6d8JpA53J1XY6
=cvsI
-----END PGP SIGNATURE-----

--/cFG30PKHi9lwv6o--
