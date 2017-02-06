Received: from eggs.gnu.org ([2001:4830:134:3::10]:54003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1caYlw-0007Ga-NI
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 21:11:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1caYlv-0000ZQ-Az
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 21:11:16 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:33647)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1caYlt-0000Yw-RE
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 21:11:15 -0500
Date: Mon, 6 Feb 2017 13:10:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170206021055.GE17644@umbus.fritz.box>
References: <1486110164-13797-1-git-send-email-peterx@redhat.com>
	<1486110164-13797-3-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zaRBsRFn0XYhEU69"
Content-Disposition: inline
In-Reply-To: <1486110164-13797-3-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 02/18] vfio: introduce vfio_get_vaddr()
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


--zaRBsRFn0XYhEU69
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 03, 2017 at 04:22:28PM +0800, Peter Xu wrote:
> A cleanup for vfio_iommu_map_notify(). Now we will fetch vaddr even if
> the operation is unmap, but it won't hurt much.
>=20
> One thing to mention is that we need the RCU read lock to protect the
> whole translation and map/unmap procedure.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/vfio/common.c | 65 +++++++++++++++++++++++++++++++++++++++-----------=
------
>  1 file changed, 45 insertions(+), 20 deletions(-)
>=20
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 174f351..42c4790 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -294,54 +294,79 @@ static bool vfio_listener_skipped_section(MemoryReg=
ionSection *section)
>             section->offset_within_address_space & (1ULL << 63);
>  }
> =20
> -static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
> +/* Called with rcu_read_lock held.  */
> +static bool vfio_get_vaddr(IOMMUTLBEntry *iotlb, void **vaddr,
> +                           bool *read_only)
>  {
> -    VFIOGuestIOMMU *giommu =3D container_of(n, VFIOGuestIOMMU, n);
> -    VFIOContainer *container =3D giommu->container;
> -    hwaddr iova =3D iotlb->iova + giommu->iommu_offset;
>      MemoryRegion *mr;
>      hwaddr xlat;
>      hwaddr len =3D iotlb->addr_mask + 1;
> -    void *vaddr;
> -    int ret;
> -
> -    trace_vfio_iommu_map_notify(iotlb->perm =3D=3D IOMMU_NONE ? "UNMAP" =
: "MAP",
> -                                iova, iova + iotlb->addr_mask);
> -
> -    if (iotlb->target_as !=3D &address_space_memory) {
> -        error_report("Wrong target AS \"%s\", only system memory is allo=
wed",
> -                     iotlb->target_as->name ? iotlb->target_as->name : "=
none");
> -        return;
> -    }
> +    bool writable =3D iotlb->perm & IOMMU_WO;
> =20
>      /*
>       * The IOMMU TLB entry we have just covers translation through
>       * this IOMMU to its immediate target.  We need to translate
>       * it the rest of the way through to memory.
>       */
> -    rcu_read_lock();
>      mr =3D address_space_translate(&address_space_memory,
>                                   iotlb->translated_addr,
> -                                 &xlat, &len, iotlb->perm & IOMMU_WO);
> +                                 &xlat, &len, writable);
>      if (!memory_region_is_ram(mr)) {
>          error_report("iommu map to non memory area %"HWADDR_PRIx"",
>                       xlat);
> -        goto out;
> +        return false;
>      }
> +
>      /*
>       * Translation truncates length to the IOMMU page size,
>       * check that it did not truncate too much.
>       */
>      if (len & iotlb->addr_mask) {
>          error_report("iommu has granularity incompatible with target AS"=
);
> +        return false;
> +    }
> +
> +    *vaddr =3D memory_region_get_ram_ptr(mr) + xlat;
> +    *read_only =3D !writable || mr->readonly;
> +
> +    return true;
> +}
> +
> +static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
> +{
> +    VFIOGuestIOMMU *giommu =3D container_of(n, VFIOGuestIOMMU, n);
> +    VFIOContainer *container =3D giommu->container;
> +    hwaddr iova =3D iotlb->iova + giommu->iommu_offset;
> +    bool read_only;
> +    void *vaddr;
> +    int ret;
> +
> +    trace_vfio_iommu_map_notify(iotlb->perm =3D=3D IOMMU_NONE ? "UNMAP" =
: "MAP",
> +                                iova, iova + iotlb->addr_mask);
> +
> +    if (iotlb->target_as !=3D &address_space_memory) {
> +        error_report("Wrong target AS \"%s\", only system memory is allo=
wed",
> +                     iotlb->target_as->name ? iotlb->target_as->name : "=
none");
> +        return;
> +    }
> +
> +    rcu_read_lock();
> +
> +    if (!vfio_get_vaddr(iotlb, &vaddr, &read_only)) {
>          goto out;
>      }
> =20
>      if ((iotlb->perm & IOMMU_RW) !=3D IOMMU_NONE) {
> -        vaddr =3D memory_region_get_ram_ptr(mr) + xlat;
> +        /*
> +         * vaddr is only valid until rcu_read_unlock(). But after
> +         * vfio_dma_map has set up the mapping the pages will be
> +         * pinned by the kernel. This makes sure that the RAM backend
> +         * of vaddr will always be there, even if the memory object is
> +         * destroyed and its backing memory munmap-ed.
> +         */
>          ret =3D vfio_dma_map(container, iova,
>                             iotlb->addr_mask + 1, vaddr,
> -                           !(iotlb->perm & IOMMU_WO) || mr->readonly);
> +                           read_only);
>          if (ret) {
>              error_report("vfio_dma_map(%p, 0x%"HWADDR_PRIx", "
>                           "0x%"HWADDR_PRIx", %p) =3D %d (%m)",

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zaRBsRFn0XYhEU69
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYl9svAAoJEGw4ysog2bOS07YP/jVfmUpli9YoHsYtp1enRThY
/19v9NZlMK5toSv2Trp3FAY2gSg6e6YkzQ9G9ixpMkVV1SY0WmkIzptDF22nfB8i
Oes4O08N6qooKpoyytbk9RbC8N3rkWGsbgLMbXXqX8mjMGR69H+rot0p0HTCYyRI
EWO1hZ7p40KF7fOH9WvsdEf35J2J5YlO7UVkeP0V7dGQC2hLJtVAGn8h2hsizOXR
CZ7jtS5Y5e95FkUQ+Ud3atMhth79PCf3y7WjB4e3JoVtrSBYF6Wcv01KCLadW81a
COQ26abQ8gRPF1F7IQp/OnObG+K6WbRk0OfwQgHnZ3JkvHp+8TMR9YDJkBimbcnc
LdrZPJMsNkWboBUI6GBwIR41NRAnPggsRoljxSlPG582IIRdZWPfpjXfvZrZMxji
oNqc6gA0zDCI/C9eaTFW9Wbr5HuqZNip1iJ+eNq8Y9F5kPsRERDifQIJ9s5j6PQk
XeF1mp3kB877035Xlb5Sh9vURDIlviykvH0a298sJy148oeggG9TYsUo0y5jhc5q
P4lyDiLjaeDiZ2nV9FHY4fmAXSEGCE0LkiC7+Pi6BJy8XjkzLOKqXufKd0HwM+cF
fy22NmEWWvTyu/6q6QG6Cs7lRnmx7v8EKwNIYSUIDxUxHXVehaS4vxFmOpCn1sGz
7wNB/WL6LzgkB+JQzH02
=fZab
-----END PGP SIGNATURE-----

--zaRBsRFn0XYhEU69--
