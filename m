Received: from eggs.gnu.org ([2001:4830:134:3::10]:33742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d0KRT-0006jE-LD
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 00:08:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d0KRQ-0000tT-G2
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 00:08:39 -0400
Received: from ozlabs.org ([103.22.144.67]:47539)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1d0KRQ-0000sq-4S
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 00:08:36 -0400
Date: Tue, 18 Apr 2017 14:08:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170418040807.GQ12235@umbus.fritz.box>
References: <1492428730-13438-1-git-send-email-peterx@redhat.com>
	<1492428730-13438-3-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i/CQJCAqWP/GQJtX"
Content-Disposition: inline
In-Reply-To: <1492428730-13438-3-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/7] memory: remove the last param in
 memory_region_iommu_replay()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Lan Tianyu <tianyu.lan@intel.com>, Jason Wang <jasowang@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--i/CQJCAqWP/GQJtX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 17, 2017 at 07:32:05PM +0800, Peter Xu wrote:
> We were always passing in that one as "false" to assume that's an read
> operation, and we also assume that IOMMU translation would always have
> that read permission. A better permission would be IOMMU_NONE since the
> replay is after all not a real read operation, but just a page table
> rebuilding process.
>=20
> CC: David Gibson <david@gibson.dropbear.id.au>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/vfio/common.c      | 2 +-
>  include/exec/memory.h | 5 +----
>  memory.c              | 8 +++-----
>  3 files changed, 5 insertions(+), 10 deletions(-)
>=20
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 6b33b9f..d008a4b 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -488,7 +488,7 @@ static void vfio_listener_region_add(MemoryListener *=
listener,
>          QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_next);
> =20
>          memory_region_register_iommu_notifier(giommu->iommu, &giommu->n);
> -        memory_region_iommu_replay(giommu->iommu, &giommu->n, false);
> +        memory_region_iommu_replay(giommu->iommu, &giommu->n);
> =20
>          return;
>      }
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 9047bf3..8721d53 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -731,11 +731,8 @@ void memory_region_register_iommu_notifier(MemoryReg=
ion *mr,
>   *
>   * @mr: the memory region to observe
>   * @n: the notifier to which to replay iommu mappings
> - * @is_write: Whether to treat the replay as a translate "write"
> - *     through the iommu
>   */
> -void memory_region_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n,
> -                                bool is_write);
> +void memory_region_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n);
> =20
>  /**
>   * memory_region_iommu_replay_all: replay existing IOMMU translations
> diff --git a/memory.c b/memory.c
> index 47dc107..6b2fdb7 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1620,12 +1620,10 @@ uint64_t memory_region_iommu_get_min_page_size(Me=
moryRegion *mr)
>      return TARGET_PAGE_SIZE;
>  }
> =20
> -void memory_region_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n,
> -                                bool is_write)
> +void memory_region_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n)
>  {
>      hwaddr addr, granularity;
>      IOMMUTLBEntry iotlb;
> -    IOMMUAccessFlags flag =3D is_write ? IOMMU_WO : IOMMU_RO;
> =20
>      /* If the IOMMU has its own replay callback, override */
>      if (mr->iommu_ops->replay) {
> @@ -1636,7 +1634,7 @@ void memory_region_iommu_replay(MemoryRegion *mr, I=
OMMUNotifier *n,
>      granularity =3D memory_region_iommu_get_min_page_size(mr);
> =20
>      for (addr =3D 0; addr < memory_region_size(mr); addr +=3D granularit=
y) {
> -        iotlb =3D mr->iommu_ops->translate(mr, addr, flag);
> +        iotlb =3D mr->iommu_ops->translate(mr, addr, IOMMU_NONE);
>          if (iotlb.perm !=3D IOMMU_NONE) {
>              n->notify(n, &iotlb);
>          }
> @@ -1654,7 +1652,7 @@ void memory_region_iommu_replay_all(MemoryRegion *m=
r)
>      IOMMUNotifier *notifier;
> =20
>      IOMMU_NOTIFIER_FOREACH(notifier, mr) {
> -        memory_region_iommu_replay(mr, notifier, false);
> +        memory_region_iommu_replay(mr, notifier);
>      }
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--i/CQJCAqWP/GQJtX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY9ZEnAAoJEGw4ysog2bOSln4P/AsGUqx7ZIzJOP2tTFbm8gxR
9zbaj8je+dYzfxlFZDNrRzgqNlkfbxcaqzf+dvQ0ElARkTqZs5Akrrm4eUtxCms2
xhzQq4rYOmkosH1HgrL/iARRO2FCJt9JBfz70rhRHPYW5vXryGQFVQFxwlb3V0Lx
zgIuodI6NmMkF+rUwl/+8h0oE3EAMHU2816XJuBsQCDXItG/Fel4M+rkuCT64+fa
86sQX+uMHxA2bP7gdIJJ+Nt32l98pKEPa4DqQ1Uw5Ccg0PisoRcO9YHI7uryt9RW
0GKsxfPA9WSI/OP8oRWNxuF/5ywmLZi79oVJ5OGfdSyjOQZ8nucaZvmLIv/91nWT
J7GIq2IHsKb4YnBI27cRsd6H7A90ANcUZhS2uTFHbCNxL7pR8EgwFVPSvAwEMIsU
PiVV7WeUBUXPDcaRM+yqXe0BWk7vI9OMrK3O7z7lWJ7I+4d0ZRCSFulNSF5XLBT0
vprVe5kj3lv/HiSmhKHPN2Wo8ydEMSg00gg4zB0IGPSyhwQjjyoZavOfZLUoVy7L
8N7rW3RBzoogjRX62b6k0h919gKhHrr3v1HSyH4eJ6on+Q4MyG8+2rEHzAaYmr9t
vOb23DaKnwdX4kFTgIor8UEaMTu0oAWRqNYbnIrUP6s5uZhTnxO5R6cRiW9/Cqub
q8roKO7RGX8b/J+DRV+G
=jynC
-----END PGP SIGNATURE-----

--i/CQJCAqWP/GQJtX--
