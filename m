Received: from eggs.gnu.org ([2001:4830:134:3::10]:40991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fECvc-00005p-Rn
	for qemu-devel@nongnu.org; Thu, 03 May 2018 08:01:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fECvX-0001n7-0P
	for qemu-devel@nongnu.org; Thu, 03 May 2018 08:01:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43040 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fECvW-0001mr-R7
	for qemu-devel@nongnu.org; Thu, 03 May 2018 08:01:34 -0400
Date: Thu, 3 May 2018 20:01:20 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180503120120.GG29580@xz-mi>
References: <20180427095527.GE13269@xz-mi> <20180427114029.GF13269@xz-mi>
	<AADFC41AFE54684AB9EE6CBC0274A5D19113D318@SHSMSX101.ccr.corp.intel.com>
	<20180503060442.GB2378@xz-mi>
	<547a97a1-0ac0-21b2-af00-036b795b06cc@redhat.com>
	<20180503072828.GA29580@xz-mi>
	<8cbed1d0-1f4e-db6d-bd83-1042f724827a@redhat.com>
	<20180503075302.GC29580@xz-mi>
	<f933ba4d-a025-7c94-69c6-d21f408eb729@redhat.com>
	<20180503095359.GE29580@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180503095359.GE29580@xz-mi>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/10] intel-iommu: maintain per-device
 iova ranges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: Jintack Lim <jintack@cs.columbia.edu>, "Tian, Kevin" <kevin.tian@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Alex Williamson <alex.williamson@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On Thu, May 03, 2018 at 05:53:59PM +0800, Peter Xu wrote:
> On Thu, May 03, 2018 at 05:22:03PM +0800, Jason Wang wrote:
> >=20
> >=20
> > On 2018=E5=B9=B405=E6=9C=8803=E6=97=A5 15:53, Peter Xu wrote:
> > > On Thu, May 03, 2018 at 03:43:35PM +0800, Jason Wang wrote:
> > > >=20
> > > > On 2018=E5=B9=B405=E6=9C=8803=E6=97=A5 15:28, Peter Xu wrote:
> > > > > On Thu, May 03, 2018 at 03:20:11PM +0800, Jason Wang wrote:
> > > > > > On 2018=E5=B9=B405=E6=9C=8803=E6=97=A5 14:04, Peter Xu wrote:
> > > > > > > IMHO the guest can't really detect this, but it'll found th=
at the
> > > > > > > device is not working functionally if it's doing something =
like what
> > > > > > > Jason has mentioned.
> > > > > > >=20
> > > > > > > Actually now I have had an idea if we really want to live w=
ell even
> > > > > > > with Jason's example: maybe we'll need to identify PSI/DSI.=
  For DSI,
> > > > > > > we don't remap for mapped pages; for PSI, we unmap and rema=
p the
> > > > > > > mapped pages.  That'll complicate the stuff a bit, but it s=
hould
> > > > > > > satisfy all the people.
> > > > > > >=20
> > > > > > > Thanks,
> > > > > > So it looks like there will be still unnecessary unamps.
> > > > > Could I ask what do you mean by "unecessary unmaps"?
> > > > It's for "for PSI, we unmap and remap the mapped pages". So for t=
he first
> > > > "unmap" how do you know it was really necessary without knowing t=
he state of
> > > > current shadow page table?
> > > I don't.  Could I just unmap it anyway?  Say, now the guest _modifi=
ed_
> > > the PTE already.  Yes I think it's following the spec, but it is
> > > really _unsafe_.  We can know that from what it has done already.
> > > Then I really think a unmap+map would be good enough for us...  Aft=
er
> > > all that behavior can cause DMA error even on real hardwares.  It c=
an
> > > never tell.
> >=20
> > I mean for following case:
> >=20
> > 1) guest maps A1 (iova) to XXX
> > 2) guest maps A2 (A1 + 4K) (iova) to YYY
> > 3) guest maps A3 (A1 + 8K) (iova) to ZZZ
> > 4) guest unmaps A2 and A2, for reducing the number of PSIs, it can
> > invalidate A1 with a range of 2M
> >=20
> > If this is allowed by spec, looks like A1 will be unmaped and mapped.
>=20
> My follow-up patch won't survive with this one but the original patch
> will work.
>=20
> Jason and I discussed a bit on IRC on this matter.  Here's the
> conclusion we got: for now we use my original patch (which solves
> everything except PTE modifications).  We mark that modify-PTE problem
> as TODO. Then at least we can have the nested device assignment work
> well on known OSs first.

Here just to mention that we actually have no way to emulate a PTE
modification procedure.  The problem is that we can never atomically
modify a PTE on the host with Linux, either via VFIO interface or even
directly using IOMMU API in kernel.  To be more specific to our use
case - VFIO provides VFIO_IOMMU_MAP_DMA and VFIO_IOMMU_UNMAP_DMA, but
it never provides VFIO_IOMMU_MODIFY_DMA to modify a PTE atomically.
It means that even if we know the PTE has changed, then we can only
unmap it and remap.  It'll still have the same "invalid window"
problem we have discussed since during unmap and remap the page is
invalid (while from guest POV it should never, since the PTE
modification is atomic).

--=20
Peter Xu
