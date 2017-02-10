Received: from eggs.gnu.org ([2001:4830:134:3::10]:39495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cc17q-0000in-IH
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:39:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cc17k-0007d9-0R
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:39:50 -0500
Received: from ozlabs.org ([103.22.144.67]:41207)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1cc17j-0007cW-KO
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:39:47 -0500
Date: Fri, 10 Feb 2017 13:34:05 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170210023405.GD27610@umbus.fritz.box>
References: <1486456099-7345-1-git-send-email-peterx@redhat.com>
	<1486456099-7345-15-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ViWwB84N1zFtNiVD"
Content-Disposition: inline
In-Reply-To: <1486456099-7345-15-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 14/17] memory: add
 MemoryRegionIOMMUOps.replay() callback
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


--ViWwB84N1zFtNiVD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 07, 2017 at 04:28:16PM +0800, Peter Xu wrote:
> Originally we have one memory_region_iommu_replay() function, which is
> the default behavior to replay the translations of the whole IOMMU
> region. However, on some platform like x86, we may want our own replay
> logic for IOMMU regions. This patch add one more hook for IOMMUOps for
> the callback, and it'll override the default if set.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/exec/memory.h | 2 ++
>  memory.c              | 6 ++++++
>  2 files changed, 8 insertions(+)
>=20
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 0767888..30b2a74 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -191,6 +191,8 @@ struct MemoryRegionIOMMUOps {
>      void (*notify_flag_changed)(MemoryRegion *iommu,
>                                  IOMMUNotifierFlag old_flags,
>                                  IOMMUNotifierFlag new_flags);
> +    /* Set this up to provide customized IOMMU replay function */
> +    void (*replay)(MemoryRegion *iommu, IOMMUNotifier *notifier);
>  };
> =20
>  typedef struct CoalescedMemoryRange CoalescedMemoryRange;
> diff --git a/memory.c b/memory.c
> index 7a4f2f9..9c253cc 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1630,6 +1630,12 @@ void memory_region_iommu_replay(MemoryRegion *mr, =
IOMMUNotifier *n,
>      hwaddr addr, granularity;
>      IOMMUTLBEntry iotlb;
> =20
> +    /* If the IOMMU has its own replay callback, override */
> +    if (mr->iommu_ops->replay) {
> +        mr->iommu_ops->replay(mr, n);
> +        return;
> +    }
> +
>      granularity =3D memory_region_iommu_get_min_page_size(mr);
> =20
>      for (addr =3D 0; addr < memory_region_size(mr); addr +=3D granularit=
y) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ViWwB84N1zFtNiVD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYnSadAAoJEGw4ysog2bOSl7MQAJWpcTKsQAE1CQa+rMhNJTj2
n3sPgH5Bw3R/EvsWiNaXNn3/Ouc+N/GlJPch3D3VLxtzQ1D/GmYw/Rm19ouyseTk
XbxO9couJT4ZEsEvl5+mZqbtnF/KbIRFFIqQkhepDHNwVzvqgwh8sRrF8wp2VdQH
ZJHEs8H/BJ9LEcx51Cb1+sWovn5PyITJJlvOArEiu3r4Wlw29F5Abh8dg876w/hi
cfpBquVuBATiJAAwBtPptQ5Ld3mQiIAuW6TyRM2k80xAxDH68SaPKXM0OSYgloU1
oFZb9PF99i95Udia6e03SizNDWXMEaHaPReZ8m1uHAqFLxgErJQ2aZlrVvhOwPnu
wlYyNB20mvzwNm3dJXOOIZ50ccvyT/Zc2mr5mG5f1f8ikmRNIIOwKkWDVMs40Brl
gWqkGFaPI8//hcyY6WoLYhrCIiyz/PU1emge8fYtLCqwhBZBJudL7z7dlTGyPkaD
VGR2j/tFIoL4yxN2GEgvGjBeaMZUUVCAMejjUYELT+XS3F/831vpZX/d5xQvtMxc
Wg06D5tzTOd41BNhnpG93nJqUmhrAALAi/QMeGuaqmMDVmq//TvF+VzP1xyuluPl
A4Hb867wniYAnGm6p1uDgHlQcjG2g5MbdJXrA6BCKCt7LaXsUgZ3tzf27w8uV4CE
vDXyxpKTO8qt8pJ9Oqsd
=V7ZW
-----END PGP SIGNATURE-----

--ViWwB84N1zFtNiVD--
