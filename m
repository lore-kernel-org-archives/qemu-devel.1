Received: from eggs.gnu.org ([2001:4830:134:3::10]:39662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fEAwM-0005Ah-IS
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:54:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fEAwH-0001ms-K6
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:54:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44358 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fEAwH-0001mm-EC
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:54:13 -0400
Date: Thu, 3 May 2018 17:53:59 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180503095359.GE29580@xz-mi>
References: <AADFC41AFE54684AB9EE6CBC0274A5D19113C1C9@SHSMSX101.ccr.corp.intel.com>
	<20180427095527.GE13269@xz-mi> <20180427114029.GF13269@xz-mi>
	<AADFC41AFE54684AB9EE6CBC0274A5D19113D318@SHSMSX101.ccr.corp.intel.com>
	<20180503060442.GB2378@xz-mi>
	<547a97a1-0ac0-21b2-af00-036b795b06cc@redhat.com>
	<20180503072828.GA29580@xz-mi>
	<8cbed1d0-1f4e-db6d-bd83-1042f724827a@redhat.com>
	<20180503075302.GC29580@xz-mi>
	<f933ba4d-a025-7c94-69c6-d21f408eb729@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f933ba4d-a025-7c94-69c6-d21f408eb729@redhat.com>
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

On Thu, May 03, 2018 at 05:22:03PM +0800, Jason Wang wrote:
>=20
>=20
> On 2018=E5=B9=B405=E6=9C=8803=E6=97=A5 15:53, Peter Xu wrote:
> > On Thu, May 03, 2018 at 03:43:35PM +0800, Jason Wang wrote:
> > >=20
> > > On 2018=E5=B9=B405=E6=9C=8803=E6=97=A5 15:28, Peter Xu wrote:
> > > > On Thu, May 03, 2018 at 03:20:11PM +0800, Jason Wang wrote:
> > > > > On 2018=E5=B9=B405=E6=9C=8803=E6=97=A5 14:04, Peter Xu wrote:
> > > > > > IMHO the guest can't really detect this, but it'll found that=
 the
> > > > > > device is not working functionally if it's doing something li=
ke what
> > > > > > Jason has mentioned.
> > > > > >=20
> > > > > > Actually now I have had an idea if we really want to live wel=
l even
> > > > > > with Jason's example: maybe we'll need to identify PSI/DSI.  =
For DSI,
> > > > > > we don't remap for mapped pages; for PSI, we unmap and remap =
the
> > > > > > mapped pages.  That'll complicate the stuff a bit, but it sho=
uld
> > > > > > satisfy all the people.
> > > > > >=20
> > > > > > Thanks,
> > > > > So it looks like there will be still unnecessary unamps.
> > > > Could I ask what do you mean by "unecessary unmaps"?
> > > It's for "for PSI, we unmap and remap the mapped pages". So for the=
 first
> > > "unmap" how do you know it was really necessary without knowing the=
 state of
> > > current shadow page table?
> > I don't.  Could I just unmap it anyway?  Say, now the guest _modified=
_
> > the PTE already.  Yes I think it's following the spec, but it is
> > really _unsafe_.  We can know that from what it has done already.
> > Then I really think a unmap+map would be good enough for us...  After
> > all that behavior can cause DMA error even on real hardwares.  It can
> > never tell.
>=20
> I mean for following case:
>=20
> 1) guest maps A1 (iova) to XXX
> 2) guest maps A2 (A1 + 4K) (iova) to YYY
> 3) guest maps A3 (A1 + 8K) (iova) to ZZZ
> 4) guest unmaps A2 and A2, for reducing the number of PSIs, it can
> invalidate A1 with a range of 2M
>=20
> If this is allowed by spec, looks like A1 will be unmaped and mapped.

My follow-up patch won't survive with this one but the original patch
will work.

Jason and I discussed a bit on IRC on this matter.  Here's the
conclusion we got: for now we use my original patch (which solves
everything except PTE modifications).  We mark that modify-PTE problem
as TODO. Then at least we can have the nested device assignment work
well on known OSs first.

--=20
Peter Xu
