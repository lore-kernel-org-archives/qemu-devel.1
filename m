Received: from eggs.gnu.org ([2001:4830:134:3::10]:34427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8dSa-0007PE-Rd
	for qemu-devel@nongnu.org; Wed, 10 May 2017 22:04:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8dSX-0002yB-OJ
	for qemu-devel@nongnu.org; Wed, 10 May 2017 22:04:08 -0400
Received: from ozlabs.org ([103.22.144.67]:52779)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1d8dSX-0002x5-3s
	for qemu-devel@nongnu.org; Wed, 10 May 2017 22:04:05 -0400
Date: Thu, 11 May 2017 11:56:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170511015637.GF14408@umbus.fritz.box>
References: <1494403315-12760-1-git-send-email-peterx@redhat.com>
	<1494403315-12760-5-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tmoQ0UElFV5VgXgH"
Content-Disposition: inline
In-Reply-To: <1494403315-12760-5-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 04/12] memory: fix
 address_space_get_iotlb_entry()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, yi.l.liu@intel.com, Marcel Apfelbaum <marcel@redhat.com>, Lan Tianyu <tianyu.lan@intel.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--tmoQ0UElFV5VgXgH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 10, 2017 at 04:01:47PM +0800, Peter Xu wrote:
> This function has an assumption that we will definitely call translate()
> once (or say, the addr will be located inside one IOMMU memory region),
> otherwise an empty IOTLB will be returned. Nevertheless, this is not
> what we want. When there is no IOMMU memory region, we should build up a
> static mapping for the caller, instead of an invalid IOTLB.
>=20
> We won't trigger this path before VT-d passthrough mode. When
> passthrough mode for a vhost device is setup, VT-d is possible to
> disable the IOMMU region for that device. Without current patch, we'll
> get a vhost boot failure, and it'll be failed over to virtio userspace
> mode.

This doesn't look right to me.  You're assuming the target is
address_space_memory, which might not be the case - and you should be
able to check from the MR you do hit.  Furthermore it doesn't look
like you're accounting for the trivial translation if the section's
offset in the address space is different from its offset in the MR.

I think for the fallback path you're going to want something based on
address_space_translate() instead.

> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Jason Wang <jasowang@redhat.com>
> CC: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  exec.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>=20
> diff --git a/exec.c b/exec.c
> index 072de5d..5cfdacd 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -463,12 +463,13 @@ address_space_translate_internal(AddressSpaceDispat=
ch *d, hwaddr addr, hwaddr *x
>  }
> =20
>  /* Called from RCU critical section */
> -IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr add=
r,
> +IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr iov=
a,
>                                              bool is_write)
>  {
>      IOMMUTLBEntry iotlb =3D {0};
>      MemoryRegionSection *section;
>      MemoryRegion *mr;
> +    hwaddr addr =3D iova, psize;
> =20
>      for (;;) {
>          AddressSpaceDispatch *d =3D atomic_rcu_read(&as->dispatch);
> @@ -478,6 +479,23 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressS=
pace *as, hwaddr addr,
>          mr =3D section->mr;
> =20
>          if (!mr->iommu_ops) {
> +            /*
> +             * We didn't translate() but reached here. It possibly
> +             * means it's a static mapping. If so (it should be RAM),
> +             * we set the IOTLB up.
> +             */
> +            if (!iotlb.target_as && memory_region_is_ram(mr) &&
> +                !memory_region_is_rom(mr)) {
> +                psize =3D mr->ram_block->page_size;
> +                iova &=3D ~(psize - 1);
> +                iotlb =3D (IOMMUTLBEntry) {
> +                    .target_as =3D &address_space_memory,
> +                    .iova =3D iova,
> +                    .translated_addr =3D iova,
> +                    .addr_mask =3D psize - 1,
> +                    .perm =3D IOMMU_RW,
> +                };
> +            }
>              break;
>          }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tmoQ0UElFV5VgXgH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZE8TVAAoJEGw4ysog2bOS8RAP/RQDaI4VqLMwGZi1cwSFspd4
vqzAUX/xB7uZ/YF+Noe2VKI1keCnLehBSa3aFTQjczrlWuF6wvL3YEClBuo4479f
+Oiq484uD4HWCHhiJa1aFZExJrt7QNKcjiu8C4PkKS/NPMBJO0lLrYokuF+sTu9g
UnugtiKlLCbuoKTYjGNyoYPWTRV+XOQl5UKw5Zzl15e+iIXs3yGh2akVjVciUHRp
3pRG+hxVrVVoXW/Z6zHij+b3/IbWwNzYjs2DcBjnXDAlr7N4edvCky8lSUFY9uEw
im3bnwc6kV1Ftfey0Pf09xQAmUtVldu4r7b61OIEi+FA5Gjrhq8XgldzBCH8++re
6gy6JOCZiZUtOq+ajrMTGafA5ZY696/0vVVNkKU5JMrCMXoIHwZPYz9cWkwl+yiy
ApGe1nXd7fvmMXWcOZwSDV3cypFBQw7anu5gZjW1mo1JBR/B375pA5KMpPrBCJ51
yT7kwOuj7FmxDDiGAYIpU4RCRO4IvEXijFTbGK8UK212E2wvDItroVsiB98hsucE
V3f9J2/d0T3R4HlOVX45AKa7c5RwhmfodLvHrpWRPwxRau95BpBjEo8Zb7VeEeKY
sZrWeLJc7i6w6Q9Mp52imC7yvFpGK79RX2q7+HW5RkS4Hf++qB3MHGNI6AEutQbZ
rJqK9vzIEoWcqXzsKGiq
=50sy
-----END PGP SIGNATURE-----

--tmoQ0UElFV5VgXgH--
