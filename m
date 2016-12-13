Received: from eggs.gnu.org ([2001:4830:134:3::10]:49589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1cGfCL-000551-Um
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 00:00:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1cGfCI-0003ZD-Ur
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 00:00:18 -0500
Received: from mga11.intel.com ([192.55.52.93]:7032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kevin.tian@intel.com>)
	id 1cGfCI-0003Y4-Jw
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 00:00:14 -0500
From: "Tian, Kevin" <kevin.tian@intel.com>
Date: Tue, 13 Dec 2016 05:00:07 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190BB240A@SHSMSX103.ccr.corp.intel.com>
References: <1481089965-3888-1-git-send-email-peterx@redhat.com>
	<1481089965-3888-3-git-send-email-peterx@redhat.com>
	<20161211051011-mutt-send-email-mst@kernel.org>
	<20161212015602.GJ28693@pxdev.xzpeter.org>
	<20161212123544.2139b842@t450s.home>
In-Reply-To: <20161212123544.2139b842@t450s.home>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH for-2.9 2/2] intel_iommu: extend supported
 guest aw to 48 bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>, "famz@redhat.com" <famz@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

> From: Alex Williamson
> Sent: Tuesday, December 13, 2016 3:36 AM
>=20
> On Mon, 12 Dec 2016 10:01:15 +0800
> Peter Xu <peterx@redhat.com> wrote:
>=20
> > On Sun, Dec 11, 2016 at 05:13:45AM +0200, Michael S. Tsirkin wrote:
> > > On Wed, Dec 07, 2016 at 01:52:45PM +0800, Peter Xu wrote:
> > > > Previously vt-d codes only supports 39 bits iova address width. It =
won't
> > > > be hard to extend it to 48 bits.
> > > >
> > > > After enabling this, we should be able to map larger iova addresses=
.
> > > >
> > > > To check whether 48 bits aw is enabled, we can grep in the guest dm=
esg
> > > > with line: "dmar: Host address width 48" (previously it was 39).
> > > >
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > >
> > > I suspect we can't do this for old machine types.
> > > Need to behave in compatible ways.
> >
> > Sure. I can do that.
> >
> > Btw, is vt-d iommu still in experimental stage? I am just thinking
> > whether it'll be overkill we add lots of tunables before we have one
> > stable and mature vt-d emulation.
> >
> > > Also, is 48 always enough? 5 level with 57 bits
> > > is just around the corner.
> >
> > Please refer to the discussion with Jason - looks like vt-d spec
> > currently supports only 39/48 bits address width? Please correct if I
> > made a mistake.
> >
> > > And is it always supported? for things like vfio
> > > to work, don't we need to check what does host support?
> >
> > Hmm, yes, we should do that. But until now, we still don't have a
> > complete vfio support. IMHO we can postpone this issue until vfio is
> > fully supported.
>=20
> I'm not sure how the vIOMMU supporting 39 bits or 48 bits is directly
> relevant to vfio, we're not sharing page tables.  There is already a
> case today, without vIOMMU that you can make a guest which has more
> guest physical address space than the hardware IOMMU by overcommitting
> system memory.  Generally this quickly resolves itself when we start
> pinning pages since the physical address width of the IOMMU is
> typically the same as the physical address width of the host system
> (ie. we exhaust the host memory).  It is possible though that we could
> create a sparse memory VM that makes use of gfns beyond the physical
> IOMMU, with or without a vIOMMU.  You'll get an error from the mapping
> ioctl when this occurs and the VM will abort.  It's not typically an
> issue since the memory capacity of the host and the IOMMU physical
> address width really better align fairly well.  Thanks,
>=20
> Alex

Hi, Alex,

I have a different thought here regarding to w/ and w/o vIOMMU.

When there is no vIOMMU exposed, page pinning happens when=20
we assign a device. Exceeding physical IOMMU address weight=20
leads to failure of device assignment. It's just fine.

However when vIOMMU is exposed, guest IOVA programming=20
happens at run-time. If a IOVA happens to exceed physical address
width, aborting the VM looks unreasonable since there's nothing
wrong with guest's operation. We'd better provide a way to at least
notify guest about such error. Aligning vIOMMU address width to=20
pIOMMU allows us triggering a virtual IOMMU fault - with proper
error code to indicating such error condition to guest.

Thanks
Kevin
