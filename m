Received: from eggs.gnu.org ([2001:4830:134:3::10]:40225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d53Td-00075b-1R
	for qemu-devel@nongnu.org; Mon, 01 May 2017 01:02:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d53TZ-0006qm-Uh
	for qemu-devel@nongnu.org; Mon, 01 May 2017 01:02:25 -0400
Received: from ozlabs.org ([103.22.144.67]:38081)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1d53TZ-0006pu-4y
	for qemu-devel@nongnu.org; Mon, 01 May 2017 01:02:21 -0400
Date: Mon, 1 May 2017 14:58:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170501045822.GM13773@umbus.fritz.box>
References: <1493285660-4470-1-git-send-email-peterx@redhat.com>
	<1493285660-4470-7-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wAI/bQb0EMvlZCHl"
Content-Disposition: inline
In-Reply-To: <1493285660-4470-7-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 6/8] memory: introduce AddressSpaceOps
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


--wAI/bQb0EMvlZCHl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 27, 2017 at 05:34:18PM +0800, Peter Xu wrote:
> This is something similar to MemoryRegionOps, it's just for address
> spaces to store arch-specific hooks.
>=20
> The first hook I would like to introduce is iommu_get().
>=20
> For systems that have IOMMUs, we will create a special address space per
> device which is different from system default address space for
> it (please refer to pci_device_iommu_address_space()). Normally when
> that happens, there will be one specific IOMMU (or say, translation
> unit) stands right behind that new address space.
>=20
> This iommu_get() fetches that guy behind the address space. Here, the
> guy is defined as IOMMUObject, which is currently a (void *). In the
> future, maybe we can make it a better definition, but imho it's good
> enough for now, considering it's arch-dependent.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>

This doesn't make sense to me.  It would be entirely possible for a
single address space to have different regions mapped by different
IOMMUs.  Or some regions mapped by IOMMUs and others direct mapped to
a device or memory block.

> ---
>  include/exec/memory.h | 30 ++++++++++++++++++++++++++++++
>  memory.c              |  8 ++++++++
>  2 files changed, 38 insertions(+)
>=20
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index e5707b3..0b0b58b 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -183,6 +183,15 @@ struct MemoryRegionOps {
>      const MemoryRegionMmio old_mmio;
>  };
> =20
> +/*
> + * This stands for an IOMMU unit. Normally it should be exactly the
> + * IOMMU device, however this can also be actually anything which is
> + * related to that translation unit. What it is should be totally
> + * arch-dependent. Maybe one day we can have something better than a
> + * (void *) here.
> + */
> +typedef void *IOMMUObject;
> +
>  typedef struct MemoryRegionIOMMUOps MemoryRegionIOMMUOps;
> =20
>  struct MemoryRegionIOMMUOps {
> @@ -282,6 +291,19 @@ struct MemoryListener {
>  };
> =20
>  /**
> + * AddressSpaceOps: callbacks structure for address space specific opera=
tions
> + *
> + * @iommu_get: returns an IOMMU object that backs the address space.
> + *             Normally this should be NULL for generic address
> + *             spaces, and it's only used when there is one
> + *             translation unit behind this address space.
> + */
> +struct AddressSpaceOps {
> +    IOMMUObject *(*iommu_get)(AddressSpace *as);
> +};
> +typedef struct AddressSpaceOps AddressSpaceOps;
> +
> +/**
>   * AddressSpace: describes a mapping of addresses to #MemoryRegion objec=
ts
>   */
>  struct AddressSpace {
> @@ -302,6 +324,7 @@ struct AddressSpace {
>      MemoryListener dispatch_listener;
>      QTAILQ_HEAD(memory_listeners_as, MemoryListener) listeners;
>      QTAILQ_ENTRY(AddressSpace) address_spaces_link;
> +    AddressSpaceOps as_ops;
>  };
> =20
>  /**
> @@ -1800,6 +1823,13 @@ address_space_write_cached(MemoryRegionCache *cach=
e, hwaddr addr,
>      address_space_write(cache->as, cache->xlat + addr, MEMTXATTRS_UNSPEC=
IFIED, buf, len);
>  }
> =20
> +/**
> + * address_space_iommu_get: Get the backend IOMMU for the address space
> + *
> + * @as: the address space to fetch IOMMU from
> + */
> +IOMMUObject *address_space_iommu_get(AddressSpace *as);
> +
>  #endif
> =20
>  #endif
> diff --git a/memory.c b/memory.c
> index 6af523e..6aaad45 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -2500,6 +2500,14 @@ void address_space_destroy(AddressSpace *as)
>      call_rcu(as, do_address_space_destroy, rcu);
>  }
> =20
> +IOMMUObject *address_space_iommu_get(AddressSpace *as)
> +{
> +    if (!as->as_ops.iommu_get) {
> +        return NULL;
> +    }
> +    return as->as_ops.iommu_get(as);
> +}
> +
>  static const char *memory_region_type(MemoryRegion *mr)
>  {
>      if (memory_region_is_ram_device(mr)) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--wAI/bQb0EMvlZCHl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZBsBuAAoJEGw4ysog2bOSbL0P/iQ5C4c7afgou+cALnhHD/cG
KvqlOu7K5bqmtdb4ddXutiNhKgN2d/T8WoO0FV1CB3Pm9qJf+36B9pHSZsRUC4h/
USd9gZcAf/Cs09FWkSPnuNk0i8daUbV9kjPMAsVsS/2A/3tTyJ9z6nMfbEB37Ctr
+khtEmR7ULKl4MVRsuzNi576jn32B74jz5Hv73znLa5nNQEJE+LHxkRzTPpYDTbw
/ETWeUFB+kV67fg2FlskOtrjnNFhiFLBrdcO4y241w11DzViz0oj+dUMPJUM/l84
kTLHSJaHOmF8aAwnl7msy5RqUpENCeiChE93gN0EO9qu/G1sN9TWWEi9MksYU13h
IfPgSfdDwVkIKxxoBtDTSUC9e7aDNyKqxEyhNvUF/+DkZ9EeoI51xnvxFroXlFKS
0OaqVYoMS6xnC+lfo0OwXcH3mspgCkUG4gt+cxJCH55JLx7R46Y+LV13rRAAoVsA
zV6Nm137mZ7vI6O+2pwP/7pFWDEpBSmWImfO9ad1sB2GKCrbVd7MYdKCV25Hk78w
yDwnJHkOZsf8MgCGsj09ktUhRtnapVQaKeG46+VmV8UIbjM/LTe55YKF6vBlwRaa
fHpDRuuTKVIi8vaOIcxhovSqj11NHOJ0LXVGlRh0kXNSxnIVL5rmT5tHCRKklFL4
jCb6ORtH1IWc/Ty+oGBD
=OTxk
-----END PGP SIGNATURE-----

--wAI/bQb0EMvlZCHl--
