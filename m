Received: from eggs.gnu.org ([2001:4830:134:3::10]:56305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cYPTq-0000nG-IX
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 22:51:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cYPTp-0001X2-Ey
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 22:51:42 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:57007)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1cYPTo-0001Un-7d
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 22:51:41 -0500
Date: Tue, 31 Jan 2017 14:35:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170131033500.GL14879@umbus.fritz.box>
References: <1485253571-19058-1-git-send-email-peterx@redhat.com>
	<1485253571-19058-4-git-send-email-peterx@redhat.com>
	<20170124093207.18444a86@t450s.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VBq/nvTu32OVLBUP"
Content-Disposition: inline
In-Reply-To: <20170124093207.18444a86@t450s.home>
Subject: Re: [Qemu-devel] [PATCH v5 03/18] vfio: allow to notify unmap for
 very large region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, bd.aviv@gmail.com


--VBq/nvTu32OVLBUP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 24, 2017 at 09:32:07AM -0700, Alex Williamson wrote:
> On Tue, 24 Jan 2017 18:25:56 +0800
> Peter Xu <peterx@redhat.com> wrote:
>=20
> > Linux vfio driver supports to do VFIO_IOMMU_UNMAP_DMA for a very big
> > region. This can be leveraged by QEMU IOMMU implementation to cleanup
> > existing page mappings for an entire iova address space (by notifying
> > with an IOTLB with extremely huge addr_mask). However current
> > vfio_iommu_map_notify() does not allow that. It make sure that all the
> > translated address in IOTLB is falling into RAM range.
> >=20
> > The check makes sense, but it should only be a sensible checker for
> > mapping operations, and mean little for unmap operations.
> >=20
> > This patch moves this check into map logic only, so that we'll get
> > faster unmap handling (no need to translate again), and also we can then
> > better support unmapping a very big region when it covers non-ram ranges
> > or even not-existing ranges.
> >=20
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  hw/vfio/common.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> > index ce55dff..4d90844 100644
> > --- a/hw/vfio/common.c
> > +++ b/hw/vfio/common.c
> > @@ -354,11 +354,10 @@ static void vfio_iommu_map_notify(IOMMUNotifier *=
n, IOMMUTLBEntry *iotlb)
> >          return;
> >      }
> > =20
> > -    if (!vfio_get_vaddr(iotlb, &vaddr, &read_only)) {
> > -        return;
> > -    }
> > -
> >      if ((iotlb->perm & IOMMU_RW) !=3D IOMMU_NONE) {
> > +        if (!vfio_get_vaddr(iotlb, &vaddr, &read_only)) {
> > +            return;
> > +        }
>=20
>=20
> David, is SPAPR going to freak out if it sees unmaps to ranges that
> extend beyond individual mappings, or perhaps include no mappings?
> This effectively allows unmapping the entire address space of the iommu
> in one pass, without validating or translating the backing.

Extending beyond an individual mapping will be fine.  However, if the
unmap extends beyond the extent of IOVAs mapped by a single TCE table,
then the unmap will fail (with ENXIO or EINVAL depending on whether
there's a problem with origin or only size).

With holidays I've lost the context of this thread, so I can't easily
find the whole patch series this relates to.  From your brief
description above it sounds likes it should be ok - a range covering
just the IOVA space (as long as that's actually correct for spapr tce)
should be ok.

>=20
> >          ret =3D vfio_dma_map(container, iova,
> >                             iotlb->addr_mask + 1, vaddr,
> >                             read_only);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VBq/nvTu32OVLBUP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYkAXiAAoJEGw4ysog2bOSRzoP/3Uwpkv1d7osp1S9hhheeHc3
dUTHuv4ai+Ls3i6MO+AhDTY0uYF8VOi6UCpzGv46Ujo3gruA8J9Kmy7hQmlNKS93
Yl5vuNYsP3vaYcwcnVTgNPHauyYqOEz6ZDjhPYAkzmyEwjVZcz42BWSWqIVmkmdE
3di2MbdFsls99FCk8DXte1nXUc2+tFlcqwykgIkDjf9cgz0Xeff9kjGr/yu+IxyW
Vltx2Mer+wo8YG13R/BtTrlyA4+3f6GvKZzhFIVYMKquVsYNO+ZnvbHF7L15EnTB
tIsV/wT0a0GpjRe4U2R3cdajCf7UP4UvChBX4X9Hd3lzlJ0jPmWizrWrjXNCiLtL
ceHVQzXA46XjOCZ7la7hDRMu3BqXU3nKtTN5gIc6hF1a+lKpq00HMMT996nEuelU
gjBjPQNwLh/5/DRW3GIDULsEnbWXrl4b6lu+Yusf04/+5hQIMiM+AQN1EClVLNml
euKH7E4mNxQNJTH9n6FeUQNTOOgsEuUjFjkbo2yYPzOXuzl+54VB9qrqNnLPo1IX
+rMXoZ5Krqopi5crWTiRNKwzhHao4qLrmsFS3s1nTeFhl+YnwHlY88qmiNKTgSz/
SJ4MtJoHPNzTX5SiTD9nLoQG47Ru7x1UKcc+2w2tlH8YBa8d9+FsS35Iy35IVXHR
FJaQJgLqtybpkduRB+BK
=OCLg
-----END PGP SIGNATURE-----

--VBq/nvTu32OVLBUP--
