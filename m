Received: from eggs.gnu.org ([2001:4830:134:3::10]:40223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d53Td-00075Z-19
	for qemu-devel@nongnu.org; Mon, 01 May 2017 01:02:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d53TZ-0006qq-Uk
	for qemu-devel@nongnu.org; Mon, 01 May 2017 01:02:25 -0400
Received: from ozlabs.org ([103.22.144.67]:39625)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1d53TZ-0006pt-4u
	for qemu-devel@nongnu.org; Mon, 01 May 2017 01:02:21 -0400
Date: Mon, 1 May 2017 14:53:35 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170501045335.GJ13773@umbus.fritz.box>
References: <1493285660-4470-1-git-send-email-peterx@redhat.com>
	<1493285660-4470-4-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lYetfuAxy9ic4HK3"
Content-Disposition: inline
In-Reply-To: <1493285660-4470-4-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 3/8] memory: rename
 iommu_notifier_init()
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


--lYetfuAxy9ic4HK3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 27, 2017 at 05:34:15PM +0800, Peter Xu wrote:
> It's new name is iommu_mr_notifier_init(). Again, literal changes only.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>

Again, I think this could be folded with the previous two patches.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

I also note that these patches will conflict with Alexey's proposed
changes to make IOMMU MR's a QOM subtype of the ordinary MR (thus
removing some of the MR specific fields from other MRs.

> ---
>  hw/vfio/common.c      | 8 ++++----
>  hw/virtio/vhost.c     | 8 ++++----
>  include/exec/memory.h | 7 ++++---
>  3 files changed, 12 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index bd113b7..6b3953b 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -481,10 +481,10 @@ static void vfio_listener_region_add(MemoryListener=
 *listener,
>          llend =3D int128_add(int128_make64(section->offset_within_region=
),
>                             section->size);
>          llend =3D int128_sub(llend, int128_one());
> -        iommu_notifier_init(&giommu->n, vfio_iommu_map_notify,
> -                            IOMMU_MR_EVENT_ALL,
> -                            section->offset_within_region,
> -                            int128_get64(llend));
> +        iommu_mr_notifier_init(&giommu->n, vfio_iommu_map_notify,
> +                               IOMMU_MR_EVENT_ALL,
> +                               section->offset_within_region,
> +                               int128_get64(llend));
>          QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_next);
> =20
>          memory_region_register_iommu_notifier(giommu->iommu, &giommu->n);
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 81a8aea..7449cf8 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -746,10 +746,10 @@ static void vhost_iommu_region_add(MemoryListener *=
listener,
>      end =3D int128_add(int128_make64(section->offset_within_region),
>                       section->size);
>      end =3D int128_sub(end, int128_one());
> -    iommu_notifier_init(&iommu->n, vhost_iommu_unmap_notify,
> -                        IOMMU_MR_EVENT_UNMAP,
> -                        section->offset_within_region,
> -                        int128_get64(end));
> +    iommu_mr_notifier_init(&iommu->n, vhost_iommu_unmap_notify,
> +                           IOMMU_MR_EVENT_UNMAP,
> +                           section->offset_within_region,
> +                           int128_get64(end));
>      iommu->mr =3D section->mr;
>      iommu->iommu_offset =3D section->offset_within_address_space -
>                            section->offset_within_region;
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 6be0c02..8d8dcb2 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -93,9 +93,10 @@ struct IOMMUMRNotifier {
>  };
>  typedef struct IOMMUMRNotifier IOMMUMRNotifier;
> =20
> -static inline void iommu_notifier_init(IOMMUMRNotifier *n, IOMMUNotify f=
n,
> -                                       IOMMUMREventFlags flags,
> -                                       hwaddr start, hwaddr end)
> +static inline void iommu_mr_notifier_init(IOMMUMRNotifier *n,
> +                                          IOMMUNotify fn,
> +                                          IOMMUMREventFlags flags,
> +                                          hwaddr start, hwaddr end)
>  {
>      n->notify =3D fn;
>      n->notifier_flags =3D flags;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--lYetfuAxy9ic4HK3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZBr9PAAoJEGw4ysog2bOSeLcP/2Z05w8m0Ep/ksyAMeRi/r6N
snMC0nS3OIzNulLkqAtsXy9M5kYtirA2Tqrj0IENMuoQ1i1oog3t5uBk2wZP2cB6
1/Q3cv79L037I1L7OA5K1Q1cdgcErQcu7tk6bXeomxoqr5hN/3/MYpnjtiaDtCmb
YQO19xCh8oQJ022EofocVH2i15v5dER3Stb/Oj507R5nn3sREhEF6B7A1yTTG2lL
PWjV1uCpejpBmgu8zdYDYDUJvhQp6QvGzWqMAGm2ClX7q0nEESontqVfXvvj7tc4
STkJZPvoyJZAQw44T8ya2S/vf6QJKZCyqtNfXfsAZqXuAW7H3ESCd/czXhSHGyf0
NBLMHgUmOSDttS7sftvp+GjBju/uz5XgVf+MyFeKJaQCDsp6CrtyoTo/gRuLsp2n
QU3qCLPJJPJrCP+Atla+7aKnIXHZGmR8sSS3g2/34LtfCbyYZ+V6QMty+3jOrRXI
yfMDbI3rR38DEIjz6C1q0kJz3bMKztT5ySFrTrjva4Lxrdw7tLvqbJrrgHDKJgYr
fL9ohxAhAJGXX1dnP+sgjIoVWvUlQow3P5ouPCJsnknSOpzJnSOAzu+gAt/ECKVt
rRdiA+v5E2X76UK+eAGbEzCIWXTYhFKU4QKgvrPtdCvl4bVD54JFt0ERQuWEBczu
oLDvLRbdt8nqPno2xkd2
=vwfn
-----END PGP SIGNATURE-----

--lYetfuAxy9ic4HK3--
