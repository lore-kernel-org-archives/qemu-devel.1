Received: from eggs.gnu.org ([2001:4830:134:3::10]:43873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1eEuKh-0004GB-Ps
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 04:50:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1eEuKY-0002Ar-BL
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 04:50:11 -0500
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Date: Wed, 15 Nov 2017 09:49:41 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83845EDBF@FRAEML521-MBX.china.huawei.com>
References: <1510622154-17224-1-git-send-email-zhuyijun@huawei.com>
	<1510622154-17224-2-git-send-email-zhuyijun@huawei.com>
	<20171114084735.68e87546@t450s.home>
In-Reply-To: <20171114084735.68e87546@t450s.home>
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
To: Alex Williamson <alex.williamson@redhat.com>, Zhuyijun <zhuyijun@huawei.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Zhaoshenglong <zhaoshenglong@huawei.com>

Hi Alex,

> -----Original Message-----
> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: Tuesday, November 14, 2017 3:48 PM
> To: Zhuyijun <zhuyijun@huawei.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; Shameerali Kolothum
> Thodi <shameerali.kolothum.thodi@huawei.com>; Zhaoshenglong
> <zhaoshenglong@huawei.com>
> Subject: Re: [Qemu-devel] [RFC 1/5] hw/vfio: Add function for getting
> reserved_region of device iommu group
>=20
> On Tue, 14 Nov 2017 09:15:50 +0800
> <zhuyijun@huawei.com> wrote:
>=20
> > From: Zhu Yijun <zhuyijun@huawei.com>
> >
> > With kernel 4.11, iommu/smmu will populate the MSI IOVA reserved
> > window and PCI reserved window which has to be excluded from Guest iova
> allocations.
> >
> > However, If it falls within the Qemu default virtual memory address
> > space, then reserved regions may get allocated for a Guest VF DMA iova
> > and it will fail.
> >
> > So get those reserved regions in this patch and create some holes in
> > the Qemu ram address in next patchset.
> >
> > Signed-off-by: Zhu Yijun <zhuyijun@huawei.com>
> > ---
> >  hw/vfio/common.c              | 67
> +++++++++++++++++++++++++++++++++++++++++++
> >  hw/vfio/pci.c                 |  2 ++
> >  hw/vfio/platform.c            |  2 ++
> >  include/exec/memory.h         |  7 +++++
> >  include/hw/vfio/vfio-common.h |  3 ++
> >  5 files changed, 81 insertions(+)
>=20
> I generally prefer the vfio interface to be more self sufficient, if ther=
e are
> regions the IOMMU cannot map, we should be describing those via capabilit=
ies
> on the container through the vfio interface.  If we're just scraping toge=
ther
> things from sysfs, the user can just as easily do that and provide an exp=
licit
> memory map for the VM taking the devices into account.=20

Ok. I was under the impression that the purpose of introducing the=20
/sys/kernel/iommu_groups/reserved_regions was to get the IOVA regions=20
that are reserved(MSI or non-mappable) for Qemu or other apps to
make use of.  I think this was introduced as part of the "KVM/MSI passthrou=
gh
support on ARM" patch series. And if I remember correctly, Eric had=20
an approach where the user space can retrieve all the reserved regions thro=
ugh
the VFIO_IOMMU_GET_INFO ioctl and later this idea was replaced with the=20
sysfs interface.

May be I am missing something here.

> Of course having a
> device associated with a restricted memory map that conflicts with the de=
fault
> memory map for the VM implies that you can never support hot-add of such
> devices.

True.  Hot-add and migration will have issues on these platforms.

Thanks,
Shameer
