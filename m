Received: from eggs.gnu.org ([2001:4830:134:3::10]:36371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cc0ra-00065Q-VM
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:23:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cc0rZ-00024q-Bq
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:23:06 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:46663)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1cc0rY-00022t-Jy
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:23:05 -0500
Date: Fri, 10 Feb 2017 12:12:22 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170210011222.GA19188@umbus>
References: <1486456099-7345-1-git-send-email-peterx@redhat.com>
	<1486456099-7345-3-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <1486456099-7345-3-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 02/17] vfio: introduce vfio_get_vaddr()
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


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 07, 2017 at 04:28:04PM +0800, Peter Xu wrote:
> A cleanup for vfio_iommu_map_notify(). Now we will fetch vaddr even if
> the operation is unmap, but it won't hurt much.
>=20
> One thing to mention is that we need the RCU read lock to protect the
> whole translation and map/unmap procedure.
>=20
> Acked-by: Alex Williamson <alex.williamson@redhat.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Peter Xu <peterx@redhat.com>

So, I know I reviewed this already, but looking again I'm confused.

I'm not sure how the original code ever worked: if this is an unmap
(perm =3D=3D IOMMU_NONE), then I wouldn't even expect
iotlb->translated_addr to have a valid value, but we're passing it to
address_space_translate() and failing if it it doesn't give us
sensible results.

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

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYnRNzAAoJEGw4ysog2bOS2ssQAI30VYnX1DrFs0/KlD/TWd7o
GwDolGKfDqit18iex27axXhuV2Ucu4XsGeunNHj+hkbvE/31KI9JRUMw3LpOVuYG
Z2M4z1AsaJD8+H/tmjsdtV8TP37ncg8ZOZSdkz47RexemuDjWB/CF0/oYYknLBAq
IvwVhz68VLvA9u5+JLm+uZ/RJpNGabz/eEtB41T2EjBF0IbxT3yJPW9kdE/bzFai
k74pTfhXMPrHqu6MXWFvN404V49Vkj6iFIjEL/H+9hw05Wpa6BXDD668zx0W8MTp
mAZMlBySHnLhkgj6bKO+ellYNC/VQAtxTLQmJdzLbszZoJpIbbdsyiVLKvTi0LYP
FWJZxRhyWGPtLBzFbLwx5yVA8xJO5oCJgyigZE5AJuZkoGVBfvIi7UzceeHpigxQ
KIflsMNu6dv+e10pSWhVU+Az8xHPwk6faU+nns7OEO+bmhZBFL9cebjEQhCG0g2k
qHCmzj4pwHv9unVbsnBZWRSWhNNJTdK37bmkCNahWPO4kJ+6QfOjkUqN4EZpBkWJ
ksEr+kjVnH5IP4RKRaVcLkch35YAdpelU6VeKc2siTSg2nposiU+qrnK6+zLJUPC
wW+kfm0s9TsxM+V36xRIW4BCfqzdueKWB5h9r7gMY3s6f+19KNruLNZMzPfELren
kgu48n1NyyGkGWeefoU1
=F6LP
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
