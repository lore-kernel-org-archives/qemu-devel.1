Received: from eggs.gnu.org ([2001:4830:134:3::10]:37095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fJ9lj-0007uR-3H
	for qemu-devel@nongnu.org; Wed, 16 May 2018 23:39:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fJ9lg-0000PA-0B
	for qemu-devel@nongnu.org; Wed, 16 May 2018 23:39:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fJ9lf-0000OX-Qq
	for qemu-devel@nongnu.org; Wed, 16 May 2018 23:39:51 -0400
Date: Wed, 16 May 2018 21:39:41 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180516213941.7c3edfdb@w520.home>
In-Reply-To: <20180517024544.GK9089@xz-mi>
References: <20180504030811.28111-1-peterx@redhat.com>
	<20180516063009.GG9089@xz-mi>
	<ab9ca375-76e3-baa8-9e60-40a73e9a354a@redhat.com>
	<20180517024544.GK9089@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
To: Peter Xu <peterx@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, Tian Kevin <kevin.tian@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>

On Thu, 17 May 2018 10:45:44 +0800
Peter Xu <peterx@redhat.com> wrote:

> On Wed, May 16, 2018 at 09:57:40PM +0800, Jason Wang wrote:
> >=20
> >=20
> > On 2018=E5=B9=B405=E6=9C=8816=E6=97=A5 14:30, Peter Xu wrote: =20
> > > On Fri, May 04, 2018 at 11:08:01AM +0800, Peter Xu wrote: =20
> > > > v2:
> > > > - fix patchew code style warnings
> > > > - interval tree: postpone malloc when inserting; simplify node remo=
ve
> > > >    a bit where proper [Jason]
> > > > - fix up comment and commit message for iommu lock patch [Kevin]
> > > > - protect context cache too using the iommu lock [Kevin, Jason]
> > > > - add vast comment in patch 8 to explain the modify-PTE problem
> > > >    [Jason, Kevin] =20
> > > We can hold a bit on reviewing this series.  Jintack reported a scp
> > > DMAR issue that might happen even with L1 guest with this series, and
> > > the scp can stall after copied tens or hundreds of MBs randomly.  I'm
> > > still investigating the problem.  This problem should be related to
> > > deferred flushing of VT-d kernel driver, since the problem will go
> > > away if we use "intel_iommu=3Don,strict".  However I'm still trying to
> > > figure out what's the thing behind the scene even with that deferred
> > > flushing feature. =20
> >=20
> > I vaguely remember recent upstream vfio support delayed flush, maybe it=
's
> > related. =20
>=20
> I'm a bit confused on why vfio is related to the deferred flushing.
> Could you provide a pointer for this?

Perhaps referring to this:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D6bd06f5a486c06023a618a86e8153b91d26f75f4

Rather than calling iommu_unmap() for each chunk of a mapping we'll
make multiple calls to iommu_unmap_fast() and flush with
iommu_tlb_sync() to defer and batch the hardware flushing.  Thanks,

Alex
