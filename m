Received: from eggs.gnu.org ([2001:4830:134:3::10]:53269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1dScvR-00009U-C6
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 01:32:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1dScvO-0001vD-7h
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 01:32:33 -0400
Received: from mga06.intel.com ([134.134.136.31]:49144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kevin.tian@intel.com>)
	id 1dScvN-0001uz-UJ
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 01:32:30 -0400
From: "Tian, Kevin" <kevin.tian@intel.com>
Date: Wed, 5 Jul 2017 05:32:24 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190D257F9@SHSMSX101.ccr.corp.intel.com>
References: <1493201525-14418-1-git-send-email-yi.l.liu@intel.com>
	<1493201525-14418-8-git-send-email-yi.l.liu@intel.com>
	<20170512155843.5abeb4bd@t450s.home> <20170514105507.GB22110@gmail.com>
In-Reply-To: <20170514105507.GB22110@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC PATCH 7/8] VFIO: Add new IOCTL for IOMMU TLB
 invalidate propagation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@linux.intel.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Raj, Ashok" <ashok.raj@intel.com>, "Pan,
	Jacob jun" <jacob.jun.pan@intel.com>, "Lan, Tianyu" <tianyu.lan@intel.com>, "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>

> From: Liu, Yi L [mailto:yi.l.liu@linux.intel.com]
> Sent: Sunday, May 14, 2017 6:55 PM
>=20
> On Fri, May 12, 2017 at 03:58:43PM -0600, Alex Williamson wrote:
> > On Wed, 26 Apr 2017 18:12:04 +0800
> > "Liu, Yi L" <yi.l.liu@intel.com> wrote:
> >
> > > From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
> > >
> > > This patch adds VFIO_IOMMU_TLB_INVALIDATE to propagate IOMMU
> TLB
> > > invalidate request from guest to host.
> > >
> > > In the case of SVM virtualization on VT-d, host IOMMU driver has
> > > no knowledge of caching structure updates unless the guest
> > > invalidation activities are passed down to the host. So a new
> > > IOCTL is needed to propagate the guest cache invalidation through
> > > VFIO.
> > >
> > > Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> > > ---
> > >  include/uapi/linux/vfio.h | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >
> > > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > > index 6b97987..50c51f8 100644
> > > --- a/include/uapi/linux/vfio.h
> > > +++ b/include/uapi/linux/vfio.h
> > > @@ -564,6 +564,15 @@ struct vfio_device_svm {
> > >
> > >  #define VFIO_IOMMU_SVM_BIND_TASK	_IO(VFIO_TYPE, VFIO_BASE +
> 22)
> > >
> > > +/* For IOMMU TLB Invalidation Propagation */
> > > +struct vfio_iommu_tlb_invalidate {
> > > +	__u32	argsz;
> > > +	__u32	length;
> > > +	__u8	data[];
> > > +};
> > > +
> > > +#define VFIO_IOMMU_TLB_INVALIDATE	_IO(VFIO_TYPE, VFIO_BASE +
> 23)
> >
> > I'm kind of wondering why this isn't just a new flag bit on
> > vfio_device_svm, the data structure is so similar.  Of course data
> > needs to be fully specified in uapi.
>=20
> Hi Alex,
>=20
> For this part, it depends on using opaque structure or not. The following
> link mentioned it in [Open] session.
>=20
> http://www.spinics.net/lists/kvm/msg148798.html
>=20
> If we pick the full opaque solution for iommu tlb invalidate propagation.
> Then I may add a flag bit on vfio_device_svm and also add definition in
> uapi as you suggested.
>=20

there is another benefit to keep it as a separate command. For now
we only need to invalidate 1st level translation (GVA->GPA) for SVM,
since 1st level page table is provided by guest while directly walked
by IOMMU. It's possible some vendor may also choose to implement
a nested 2nd level translation (e.g. GIOVA->GPA->HPA) then hardware
can directly walk guest GIOVA page table thus explicit invalidation is
also required. We'd better not to limit invalidation interface with=20
svm structure.

Thanks
Kevin
