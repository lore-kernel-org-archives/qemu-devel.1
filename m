Received: from eggs.gnu.org ([2001:4830:134:3::10]:40270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d53Tf-00075x-22
	for qemu-devel@nongnu.org; Mon, 01 May 2017 01:02:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d53Td-0006tQ-Lf
	for qemu-devel@nongnu.org; Mon, 01 May 2017 01:02:27 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:52107)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1d53Tc-0006rG-Tb
	for qemu-devel@nongnu.org; Mon, 01 May 2017 01:02:25 -0400
Date: Mon, 1 May 2017 14:56:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170501045624.GL13773@umbus.fritz.box>
References: <1493285660-4470-1-git-send-email-peterx@redhat.com>
	<1493285660-4470-6-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hTKW8p8tUZ/8vLMe"
Content-Disposition: inline
In-Reply-To: <1493285660-4470-6-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 5/8] memory: rename *iommu_notifier*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, Paolo Bonzini <pbonzini@redhat.com>, kevin.tian@intel.com, yi.l.liu@intel.com, Jason Wang <jasowang@redhat.com>, Alex Williamson <alex.williamson@redhat.com>


--hTKW8p8tUZ/8vLMe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 27, 2017 at 05:34:17PM +0800, Peter Xu wrote:
> Renaming *iommu_notifiers* into *iotlb_notifiers*. Again, let's reserve
> the iommu_notifier keyword to the notifiers that will be for per-iommu,
> and let the old per-mr notifier be iotlb_notifiers.

As with the previous patch, I really don't see that "iotlb" is an
clearer than "iommu" here.  This is notifying of changes in mapping on
an IOMMU region.  There may or may not be an IOTLB of some sort
involved.


>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/vfio/common.c      |  6 +++---
>  hw/virtio/vhost.c     |  4 ++--
>  include/exec/memory.h |  8 ++++----
>  memory.c              | 20 ++++++++++----------
>  4 files changed, 19 insertions(+), 19 deletions(-)
>=20
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 6b3953b..7b639ea 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -487,7 +487,7 @@ static void vfio_listener_region_add(MemoryListener *=
listener,
>                                 int128_get64(llend));
>          QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_next);
> =20
> -        memory_region_register_iommu_notifier(giommu->iommu, &giommu->n);
> +        memory_region_register_iotlb_notifier(giommu->iommu, &giommu->n);
>          memory_region_iommu_replay(giommu->iommu, &giommu->n, false);
> =20
>          return;
> @@ -557,7 +557,7 @@ static void vfio_listener_region_del(MemoryListener *=
listener,
>          QLIST_FOREACH(giommu, &container->giommu_list, giommu_next) {
>              if (giommu->iommu =3D=3D section->mr &&
>                  giommu->n.start =3D=3D section->offset_within_region) {
> -                memory_region_unregister_iommu_notifier(giommu->iommu,
> +                memory_region_unregister_iotlb_notifier(giommu->iommu,
>                                                          &giommu->n);
>                  QLIST_REMOVE(giommu, giommu_next);
>                  g_free(giommu);
> @@ -1147,7 +1147,7 @@ static void vfio_disconnect_container(VFIOGroup *gr=
oup)
>          QLIST_REMOVE(container, next);
> =20
>          QLIST_FOREACH_SAFE(giommu, &container->giommu_list, giommu_next,=
 tmp) {
> -            memory_region_unregister_iommu_notifier(giommu->iommu, &giom=
mu->n);
> +            memory_region_unregister_iotlb_notifier(giommu->iommu, &giom=
mu->n);
>              QLIST_REMOVE(giommu, giommu_next);
>              g_free(giommu);
>          }
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 7449cf8..a1e03ed 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -754,7 +754,7 @@ static void vhost_iommu_region_add(MemoryListener *li=
stener,
>      iommu->iommu_offset =3D section->offset_within_address_space -
>                            section->offset_within_region;
>      iommu->hdev =3D dev;
> -    memory_region_register_iommu_notifier(section->mr, &iommu->n);
> +    memory_region_register_iotlb_notifier(section->mr, &iommu->n);
>      QLIST_INSERT_HEAD(&dev->iommu_list, iommu, iommu_next);
>      /* TODO: can replay help performance here? */
>  }
> @@ -773,7 +773,7 @@ static void vhost_iommu_region_del(MemoryListener *li=
stener,
>      QLIST_FOREACH(iommu, &dev->iommu_list, iommu_next) {
>          if (iommu->mr =3D=3D section->mr &&
>              iommu->n.start =3D=3D section->offset_within_region) {
> -            memory_region_unregister_iommu_notifier(iommu->mr,
> +            memory_region_unregister_iotlb_notifier(iommu->mr,
>                                                      &iommu->n);
>              QLIST_REMOVE(iommu, iommu_next);
>              g_free(iommu);
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 09188a6..e5707b3 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -708,7 +708,7 @@ void memory_region_notify_iotlb_one(IOMMUMRNotifier *=
notifier,
>                                      IOMMUTLBEntry *entry);
> =20
>  /**
> - * memory_region_register_iommu_notifier: register a notifier for change=
s to
> + * memory_region_register_iotlb_notifier: register a notifier for change=
s to
>   * IOMMU translation entries.
>   *
>   * @mr: the memory region to observe
> @@ -716,7 +716,7 @@ void memory_region_notify_iotlb_one(IOMMUMRNotifier *=
notifier,
>   *     pointer to an #IOMMUTLBEntry as the opaque value; the pointer
>   *     ceases to be valid on exit from the notifier.
>   */
> -void memory_region_register_iommu_notifier(MemoryRegion *mr,
> +void memory_region_register_iotlb_notifier(MemoryRegion *mr,
>                                             IOMMUMRNotifier *n);
> =20
>  /**
> @@ -741,14 +741,14 @@ void memory_region_iommu_replay(MemoryRegion *mr, I=
OMMUMRNotifier *n,
>  void memory_region_iommu_replay_all(MemoryRegion *mr);
> =20
>  /**
> - * memory_region_unregister_iommu_notifier: unregister a notifier for
> + * memory_region_unregister_iotlb_notifier: unregister a notifier for
>   * changes to IOMMU translation entries.
>   *
>   * @mr: the memory region which was observed and for which notity_stoppe=
d()
>   *      needs to be called
>   * @n: the notifier to be removed.
>   */
> -void memory_region_unregister_iommu_notifier(MemoryRegion *mr,
> +void memory_region_unregister_iotlb_notifier(MemoryRegion *mr,
>                                               IOMMUMRNotifier *n);
> =20
>  /**
> diff --git a/memory.c b/memory.c
> index c6532e4..6af523e 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1581,10 +1581,10 @@ bool memory_region_is_logging(MemoryRegion *mr, u=
int8_t client)
>  static void memory_region_update_iommu_notify_flags(MemoryRegion *mr)
>  {
>      IOMMUMREventFlags flags =3D IOMMU_MR_EVENT_NONE;
> -    IOMMUMRNotifier *iommu_notifier;
> +    IOMMUMRNotifier *iotlb_notifier;
> =20
> -    IOMMU_NOTIFIER_FOREACH(iommu_notifier, mr) {
> -        flags |=3D iommu_notifier->notifier_flags;
> +    IOMMU_NOTIFIER_FOREACH(iotlb_notifier, mr) {
> +        flags |=3D iotlb_notifier->notifier_flags;
>      }
> =20
>      if (flags !=3D mr->iommu_notify_flags &&
> @@ -1596,11 +1596,11 @@ static void memory_region_update_iommu_notify_fla=
gs(MemoryRegion *mr)
>      mr->iommu_notify_flags =3D flags;
>  }
> =20
> -void memory_region_register_iommu_notifier(MemoryRegion *mr,
> +void memory_region_register_iotlb_notifier(MemoryRegion *mr,
>                                             IOMMUMRNotifier *n)
>  {
>      if (mr->alias) {
> -        memory_region_register_iommu_notifier(mr->alias, n);
> +        memory_region_register_iotlb_notifier(mr->alias, n);
>          return;
>      }
> =20
> @@ -1657,11 +1657,11 @@ void memory_region_iommu_replay_all(MemoryRegion =
*mr)
>      }
>  }
> =20
> -void memory_region_unregister_iommu_notifier(MemoryRegion *mr,
> +void memory_region_unregister_iotlb_notifier(MemoryRegion *mr,
>                                               IOMMUMRNotifier *n)
>  {
>      if (mr->alias) {
> -        memory_region_unregister_iommu_notifier(mr->alias, n);
> +        memory_region_unregister_iotlb_notifier(mr->alias, n);
>          return;
>      }
>      QLIST_REMOVE(n, node);
> @@ -1696,12 +1696,12 @@ void memory_region_notify_iotlb_one(IOMMUMRNotifi=
er *notifier,
>  void memory_region_notify_iotlb(MemoryRegion *mr,
>                                  IOMMUTLBEntry entry)
>  {
> -    IOMMUMRNotifier *iommu_notifier;
> +    IOMMUMRNotifier *iotlb_notifier;
> =20
>      assert(memory_region_is_iommu(mr));
> =20
> -    IOMMU_NOTIFIER_FOREACH(iommu_notifier, mr) {
> -        memory_region_notify_iotlb_one(iommu_notifier, &entry);
> +    IOMMU_NOTIFIER_FOREACH(iotlb_notifier, mr) {
> +        memory_region_notify_iotlb_one(iotlb_notifier, &entry);
>      }
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hTKW8p8tUZ/8vLMe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZBr/3AAoJEGw4ysog2bOS/cIP/2/QWnYknCK68P/hbunO7/9+
OJllHlLhME1gTtxe5HhOSBApKiw8D97h68JMnDhsB/cyjZL4xvL92U0bD5EjAp+a
JCAEhOT2YIQxcKgoXxAlopZnQgtDGFhiRytW/aDI+71FXLF5HUFnFHKUaBWe2H7C
YEKyphUYAEJ4kbkpiyqgXRjGKgMVqMNFj92RE+X7IDGiQoXoMGeaqpos3FZ7CpMH
eUj0u1hKli5sQmhfabeLW7qgsTO/j3qcn7/bDgksRn15CwKKb0SENZJ07Mhs2ofy
WKY4JmzC7+VIIkveQZDx7FxoJOJ/W8a6beLj6BOC2v7tVRq9aWQNDn79digDVr/v
x7rZebLvGrdTzxpN/VDGkVd9jXAB9CvHqsRJavE+c/nN+uLM9lPnP39J62RK1aQM
B+sdBTHfucf9GOIp+LwgdTpjfNqH5wxjGeSZl+Jfhk/LDprBPt/YiI6k5EYngnPs
QpO8yZGHcSGu8iuKb07TIWcLhjRMtZMsTREPy7B4Bh6nbWLYwX6PkP9k0Ns4Bmgg
jYCPmwBgJKNVBO30rkb/u22CI1bxWb/ntMcqn32lmCW+YeeTVKZi0Vm9UB3xluOC
s+dgB8CwF42qahUrf6S5TFEypKZ0+QU5cCTdP+2jgnWDlSAgzptr+fDNTfDQWchP
x2if47VEQQT7HuRG7MaH
=30qx
-----END PGP SIGNATURE-----

--hTKW8p8tUZ/8vLMe--
