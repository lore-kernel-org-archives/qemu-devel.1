Received: from eggs.gnu.org ([2001:4830:134:3::10]:51768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1eGkjJ-00030Z-LQ
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 06:59:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1eGkjI-0004vQ-20
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 06:59:13 -0500
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Date: Mon, 20 Nov 2017 11:58:43 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA8384704C0@FRAEML521-MBX.china.huawei.com>
References: <1510622154-17224-1-git-send-email-zhuyijun@huawei.com>
	<1510622154-17224-2-git-send-email-zhuyijun@huawei.com>
	<20171114084735.68e87546@t450s.home>
	<5FC3163CFD30C246ABAA99954A238FA83845EDBF@FRAEML521-MBX.china.huawei.com>
	<20171115112513.3c035023@t450s.home>
In-Reply-To: <20171115112513.3c035023@t450s.home>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC 1/5] hw/vfio: Add function for getting
 reserved_region of device iommu group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>
Cc: Zhuyijun <zhuyijun@huawei.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Zhaoshenglong <zhaoshenglong@huawei.com>, Linuxarm <linuxarm@huawei.com>



> -----Original Message-----
> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: Wednesday, November 15, 2017 6:25 PM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: Zhuyijun <zhuyijun@huawei.com>; qemu-arm@nongnu.org; qemu-
> devel@nongnu.org; eric.auger@redhat.com; peter.maydell@linaro.org;
> Zhaoshenglong <zhaoshenglong@huawei.com>
> Subject: Re: [Qemu-devel] [RFC 1/5] hw/vfio: Add function for getting
> reserved_region of device iommu group
>=20
> On Wed, 15 Nov 2017 09:49:41 +0000
> Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com> wrote:
>=20
> > Hi Alex,
> >
> > > -----Original Message-----
> > > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > > Sent: Tuesday, November 14, 2017 3:48 PM
> > > To: Zhuyijun <zhuyijun@huawei.com>
> > > Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> > > eric.auger@redhat.com; peter.maydell@linaro.org; Shameerali Kolothum
> > > Thodi <shameerali.kolothum.thodi@huawei.com>; Zhaoshenglong
> > > <zhaoshenglong@huawei.com>
> > > Subject: Re: [Qemu-devel] [RFC 1/5] hw/vfio: Add function for getting
> > > reserved_region of device iommu group
> > >
> > > On Tue, 14 Nov 2017 09:15:50 +0800
> > > <zhuyijun@huawei.com> wrote:
> > >
> > > > From: Zhu Yijun <zhuyijun@huawei.com>
> > > >
> > > > With kernel 4.11, iommu/smmu will populate the MSI IOVA reserved
> > > > window and PCI reserved window which has to be excluded from Guest
> iova
> > > allocations.
> > > >
> > > > However, If it falls within the Qemu default virtual memory address
> > > > space, then reserved regions may get allocated for a Guest VF DMA i=
ova
> > > > and it will fail.
> > > >
> > > > So get those reserved regions in this patch and create some holes i=
n
> > > > the Qemu ram address in next patchset.
> > > >
> > > > Signed-off-by: Zhu Yijun <zhuyijun@huawei.com>
> > > > ---
> > > >  hw/vfio/common.c              | 67
> > > +++++++++++++++++++++++++++++++++++++++++++
> > > >  hw/vfio/pci.c                 |  2 ++
> > > >  hw/vfio/platform.c            |  2 ++
> > > >  include/exec/memory.h         |  7 +++++
> > > >  include/hw/vfio/vfio-common.h |  3 ++
> > > >  5 files changed, 81 insertions(+)
> > >
> > > I generally prefer the vfio interface to be more self sufficient, if =
there are
> > > regions the IOMMU cannot map, we should be describing those via
> capabilities
> > > on the container through the vfio interface.  If we're just scraping =
together
> > > things from sysfs, the user can just as easily do that and provide an=
 explicit
> > > memory map for the VM taking the devices into account.
> >
> > Ok. I was under the impression that the purpose of introducing the
> > /sys/kernel/iommu_groups/reserved_regions was to get the IOVA regions
> > that are reserved(MSI or non-mappable) for Qemu or other apps to
> > make use of.  I think this was introduced as part of the "KVM/MSI passt=
hrough
> > support on ARM" patch series. And if I remember correctly, Eric had
> > an approach where the user space can retrieve all the reserved regions
> through
> > the VFIO_IOMMU_GET_INFO ioctl and later this idea was replaced with the
> > sysfs interface.
> >
> > May be I am missing something here.
>=20
> And sysfs is a good interface if the user wants to use it to configure
> the VM in a way that's compatible with a device.  For instance, in your
> case, a user could evaluate these reserved regions across all devices in
> a system, or even across an entire cluster, and instantiate the VM with
> a memory map compatible with hotplugging any of those evaluated
> devices (QEMU implementation of allowing the user to do this TBD).
> Having the vfio device evaluate these reserved regions only helps in
> the cold-plug case.  So the proposed solution is limited in scope and
> doesn't address similar needs on other platforms.  There is value to
> verifying that a device's IOVA space is compatible with a VM memory map
> and modifying the memory map on cold-plug or rejecting the device on
> hot-plug, but isn't that why we have an ioctl within vfio to expose
> information about the IOMMU?  Why take the path of allowing QEMU to
> rummage through sysfs files outside of vfio, implying additional
> security and access concerns, rather than filling the gap within the
> vifo API? =20

Thanks Alex for the explanation.=20

I came across this patch[1] from Eric where he introduced the IOCTL interfa=
ce to
retrieve the reserved regions. It looks like this can be reworked to accomm=
odate=20
the above requirement.

Hi Eric,

Please let us know if you have any plans to respin this patch or else we ca=
n take a
look at this and do the rework if it is Ok.

Thanks,
Shameer=20

1. https://lists.linuxfoundation.org/pipermail/iommu/2016-November/019002.h=
tml
