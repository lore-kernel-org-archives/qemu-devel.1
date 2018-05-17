Received: from eggs.gnu.org ([2001:4830:134:3::10]:41010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fJAKx-0007ZU-Cg
	for qemu-devel@nongnu.org; Thu, 17 May 2018 00:16:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fJAKs-0005xK-DT
	for qemu-devel@nongnu.org; Thu, 17 May 2018 00:16:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47434 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fJAKs-0005wn-7v
	for qemu-devel@nongnu.org; Thu, 17 May 2018 00:16:14 -0400
Date: Thu, 17 May 2018 12:16:08 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180517041608.GO9089@xz-mi>
References: <20180504030811.28111-1-peterx@redhat.com>
	<20180516063009.GG9089@xz-mi>
	<ab9ca375-76e3-baa8-9e60-40a73e9a354a@redhat.com>
	<20180517024544.GK9089@xz-mi> <20180516213941.7c3edfdb@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180516213941.7c3edfdb@w520.home>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/10] intel-iommu: nested vIOMMU,
 cleanups, bug fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, Tian Kevin <kevin.tian@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>

On Wed, May 16, 2018 at 09:39:41PM -0600, Alex Williamson wrote:
> On Thu, 17 May 2018 10:45:44 +0800
> Peter Xu <peterx@redhat.com> wrote:
>=20
> > On Wed, May 16, 2018 at 09:57:40PM +0800, Jason Wang wrote:
> > >=20
> > >=20
> > > On 2018=E5=B9=B405=E6=9C=8816=E6=97=A5 14:30, Peter Xu wrote: =20
> > > > On Fri, May 04, 2018 at 11:08:01AM +0800, Peter Xu wrote: =20
> > > > > v2:
> > > > > - fix patchew code style warnings
> > > > > - interval tree: postpone malloc when inserting; simplify node =
remove
> > > > >    a bit where proper [Jason]
> > > > > - fix up comment and commit message for iommu lock patch [Kevin=
]
> > > > > - protect context cache too using the iommu lock [Kevin, Jason]
> > > > > - add vast comment in patch 8 to explain the modify-PTE problem
> > > > >    [Jason, Kevin] =20
> > > > We can hold a bit on reviewing this series.  Jintack reported a s=
cp
> > > > DMAR issue that might happen even with L1 guest with this series,=
 and
> > > > the scp can stall after copied tens or hundreds of MBs randomly. =
 I'm
> > > > still investigating the problem.  This problem should be related =
to
> > > > deferred flushing of VT-d kernel driver, since the problem will g=
o
> > > > away if we use "intel_iommu=3Don,strict".  However I'm still tryi=
ng to
> > > > figure out what's the thing behind the scene even with that defer=
red
> > > > flushing feature. =20
> > >=20
> > > I vaguely remember recent upstream vfio support delayed flush, mayb=
e it's
> > > related. =20
> >=20
> > I'm a bit confused on why vfio is related to the deferred flushing.
> > Could you provide a pointer for this?
>=20
> Perhaps referring to this:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D6bd06f5a486c06023a618a86e8153b91d26f75f4
>=20
> Rather than calling iommu_unmap() for each chunk of a mapping we'll
> make multiple calls to iommu_unmap_fast() and flush with
> iommu_tlb_sync() to defer and batch the hardware flushing.  Thanks,

Thanks for the link!

It seems to be a good performance enhancement for vfio, but it might
not related to current problem.

My latest clue shows that the issue is possibly caused by replaying
each IOMMU region twice on a single DSI.  For example, when we get one
DSI we'll actually call vtd_page_walk() twice (the IOMMU region is
splitted by the MSI region 0xfeeXXXXX, so we have two notifiers for
each vfio-pci device now... and memory_region_iommu_replay_all will
call vtd_page_walk twice). So that confused the IOVA tree a bit. I'll
verify that and see how I can fix it up.

(PS: it seems that in above patch unmapped_region_cnt is not needed in
 vfio_unmap_unpin considering that we already have
 unmapped_region_list there?  If that's correct, then we can remove
 all the references too, e.g. we don't need to pass in unmapped_cnt
 into unmap_unpin_fast as well.)

Thanks,

--=20
Peter Xu
