Received: from eggs.gnu.org ([2001:4830:134:3::10]:42116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f9OKW-0007G1-Lg
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 01:11:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f9OKR-0004UU-MZ
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 01:11:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54498 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f9OKR-0004Tk-IS
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 01:11:23 -0400
Date: Fri, 20 Apr 2018 13:11:06 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180420051106.GC873@xz-mi>
References: <20180418045121.14233-1-peterx@redhat.com>
	<d550eb50-c9e3-838a-ac9a-4a998375572b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d550eb50-c9e3-838a-ac9a-4a998375572b@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] intel-iommu: send PSI always when
 notify_unmap set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Eric Auger <eric.auger@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Alexander Witte <alexander.witte@baicanada.com>, Jintack Lim <jintack@cs.columbia.edu>

On Fri, Apr 20, 2018 at 12:57:13PM +0800, Jason Wang wrote:
>=20
>=20
> On 2018=E5=B9=B404=E6=9C=8818=E6=97=A5 12:51, Peter Xu wrote:
> > During IOVA page table walk, there is a special case when:
> >=20
> > - notify_unmap is set, meanwhile
> > - entry is invalid
> >=20
> > In the past, we skip the entry always.  This is not correct.  We shou=
ld
> > send UNMAP notification to registered notifiers in this case.  Otherw=
ise
> > some stall pages will still be mapped in the host even if L1 guest
>=20
> You mean 'stale' here?

Ah, yes.

>=20
> > unmapped them already.
>=20
> It looks like some IOTLB invalidation were missed? If not, the page sho=
uld
> be unmaped during invalidation.

I'm afraid it's not the same problem, and that's why I think we need
two fixes.

Even if the guest sends the correct invalidations, it's still possible
that QEMU skips the PSI with current code.

>=20
> >=20
> > Without this patch, nested device assignment to L2 guests might dump
> > some errors like:
> >=20
> > qemu-system-x86_64: VFIO_MAP_DMA: -17
> > qemu-system-x86_64: vfio_dma_map(0x557305420c30, 0xad000, 0x1000,
> >                      0x7f89a920d000) =3D -17 (File exists)
> >=20
> > To fix this, we need to apply this patch to L1 QEMU (L2 QEMU is not
> > affected by this problem).
> >=20
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >=20
> > To test nested assignment, one also needs to apply below patchset:
> > https://lkml.org/lkml/2018/4/18/5
>=20
> Have a quick glance at it, looks like there's no need for this patch is=
 we
> had that kernel patch applied.

Even if guest kernel applies above fix, QEMU might still drop some of
the PSIs.  Above error messages were captured with kernel patches
applied already (otherwise we see no error messages, we directly miss
them from guest).

Thanks,

--=20
Peter Xu
