Received: from eggs.gnu.org ([2001:4830:134:3::10]:36376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cc0rb-00065R-4c
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:23:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cc0rY-000249-1B
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:23:07 -0500
Received: from ozlabs.org ([103.22.144.67]:45243)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1cc0rX-00022u-KC
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:23:03 -0500
Date: Fri, 10 Feb 2017 12:13:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170210011307.GR27610@umbus.fritz.box>
References: <1486456099-7345-1-git-send-email-peterx@redhat.com>
	<1486456099-7345-4-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JB7KW7Ey7eB5HOHs"
Content-Disposition: inline
In-Reply-To: <1486456099-7345-4-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 03/17] vfio: allow to notify unmap for
 very large region
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


--JB7KW7Ey7eB5HOHs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 07, 2017 at 04:28:05PM +0800, Peter Xu wrote:
> Linux vfio driver supports to do VFIO_IOMMU_UNMAP_DMA for a very big
> region. This can be leveraged by QEMU IOMMU implementation to cleanup
> existing page mappings for an entire iova address space (by notifying
> with an IOTLB with extremely huge addr_mask). However current
> vfio_iommu_map_notify() does not allow that. It make sure that all the
> translated address in IOTLB is falling into RAM range.
>=20
> The check makes sense, but it should only be a sensible checker for
> mapping operations, and mean little for unmap operations.
>=20
> This patch moves this check into map logic only, so that we'll get
> faster unmap handling (no need to translate again), and also we can then
> better support unmapping a very big region when it covers non-ram ranges
> or even not-existing ranges.
>=20
> Acked-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Seems sensible of itself, except that I don't understand how we were
ever working before this.

> ---
>  hw/vfio/common.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 42c4790..f3ba9b9 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -352,11 +352,10 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n,=
 IOMMUTLBEntry *iotlb)
> =20
>      rcu_read_lock();
> =20
> -    if (!vfio_get_vaddr(iotlb, &vaddr, &read_only)) {
> -        goto out;
> -    }
> -
>      if ((iotlb->perm & IOMMU_RW) !=3D IOMMU_NONE) {
> +        if (!vfio_get_vaddr(iotlb, &vaddr, &read_only)) {
> +            goto out;
> +        }
>          /*
>           * vaddr is only valid until rcu_read_unlock(). But after
>           * vfio_dma_map has set up the mapping the pages will be

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--JB7KW7Ey7eB5HOHs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYnROiAAoJEGw4ysog2bOSabAP/1iEvTaDgiB4b3Z4qPqzSf18
aQWlRm5xD1NmcJVbWW38eEd+G0WsvOjI99vaIr3QgJCATizNHTSx1VkXsXKjPB0j
1CeVGtUNGvkGaCqPM5hCLXea/qz4X0+5AE2T+bOzjYizRyfZZVreyTq7bIQCHniu
Bk9IeD4dHoCAHMa133b+ecRl21MQKYTjLUv0jfXkNTW2ChwywxOHndveqVpsXJCB
6+K3LmnHWgZNE2ozY3PPOMi7amkoEI6fQ5pgYes7bzPhLo3ffQ68QZbv8xy6uZSj
n6ts3M5KIf6oTEcmtTRwwtJHOaWp6bBsal9LNOsSI035ulZYwwb7JOGOemxaPNvl
ofq7xjEhOs4SYe6RzCVPrNG/09b5hICL9syPjucDo4A1d2gBfVlsewHJP3CVTnGB
bU1reUC7SDo9aAxGTH7f43cVYFCB8UEI4xNpu57usa5FodPA6aQGMKXlwm0WTxHx
1wpCvUnzI75Czmhq5fDhmyKw2pCh6x+Mi0/bBFmJ45vqfE8MH0h/NV9X0pIVklt+
vW6RFsgB93ZG8ZiUNTdKMeIbU4wqNN6I5Rxd3sTi8ML7yRTCZsGxXw7yu0tz65gS
d92VenYWgi5aVqcrLNaymER1wT1aUwp/6E5222/qGeK+kMoVJfPxIaOjRT/D6uIt
d/OEfok7HcEMAFhK7NuQ
=F97f
-----END PGP SIGNATURE-----

--JB7KW7Ey7eB5HOHs--
