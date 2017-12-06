Received: from eggs.gnu.org ([2001:4830:134:3::10]:40828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1eMWyi-0007ZJ-7K
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:31:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1eMWyh-00088u-5b
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:31:00 -0500
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Date: Wed, 6 Dec 2017 10:30:33 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA838622618@FRAEML521-MBX.china.huawei.com>
References: <1510622154-17224-1-git-send-email-zhuyijun@huawei.com>
	<1510622154-17224-2-git-send-email-zhuyijun@huawei.com>
	<20171114084735.68e87546@t450s.home>
	<5FC3163CFD30C246ABAA99954A238FA83845EDBF@FRAEML521-MBX.china.huawei.com>
	<20171115112513.3c035023@t450s.home>
	<5FC3163CFD30C246ABAA99954A238FA8384704C0@FRAEML521-MBX.china.huawei.com>
	<20171120085745.0147df5c@t450s.home>
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
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "eric.auger@redhat.com" <eric.auger@redhat.com>, Zhuyijun <zhuyijun@huawei.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Zhaoshenglong <zhaoshenglong@huawei.com>, Linuxarm <linuxarm@huawei.com>

Hi Alex,

> -----Original Message-----
> From: Shameerali Kolothum Thodi
> Sent: Monday, November 20, 2017 4:31 PM
> To: 'Alex Williamson' <alex.williamson@redhat.com>
> Cc: eric.auger@redhat.com; Zhuyijun <zhuyijun@huawei.com>; qemu-
> arm@nongnu.org; qemu-devel@nongnu.org; peter.maydell@linaro.org;
> Zhaoshenglong <zhaoshenglong@huawei.com>; Linuxarm
> <linuxarm@huawei.com>
> Subject: RE: [Qemu-devel] [RFC 1/5] hw/vfio: Add function for getting
> reserved_region of device iommu group
[...]
> > > > And sysfs is a good interface if the user wants to use it to
> > > > configure the VM in a way that's compatible with a device.  For
> > > > instance, in your case, a user could evaluate these reserved
> > > > regions across all devices in a system, or even across an entire
> > > > cluster, and instantiate the VM with a memory map compatible with
> > > > hotplugging any of those evaluated devices (QEMU implementation of
> allowing the user to do this TBD).
> > > > Having the vfio device evaluate these reserved regions only helps
> > > > in the cold-plug case.  So the proposed solution is limited in
> > > > scope and doesn't address similar needs on other platforms.  There
> > > > is value to verifying that a device's IOVA space is compatible
> > > > with a VM memory map and modifying the memory map on cold-plug or
> > > > rejecting the device on hot-plug, but isn't that why we have an
> > > > ioctl within vfio to expose information about the IOMMU?  Why take
> > > > the path of allowing QEMU to rummage through sysfs files outside
> > > > of vfio, implying additional security and access concerns, rather
> > > > than filling the gap within the vifo API?
> > >
> > > Thanks Alex for the explanation.
> > >
> > > I came across this patch[1] from Eric where he introduced the IOCTL
> > interface to
> > > retrieve the reserved regions. It looks like this can be reworked to
> > accommodate
> > > the above requirement.
> >
> > I don't think we need a new ioctl for this, nor do I think that
> > describing the holes is the correct approach.  The existing
> > VFIO_IOMMU_GET_INFO ioctl can be extended to support capability
> > chains, as we've done for VFIO_DEVICE_GET_REGION_INFO.
>=20
> Right, as far as I can see the above mentioned patch is doing exactly the=
 same,
> extending the VFIO_IOMMU_GET_INFO ioctl with capability chain.
>=20
> > IMO, we should try to
> > describe the available fixed IOVA regions which are available for
> > mapping rather than describing various holes within the address space
> > which are unavailable.  The latter method always fails to describe the
> > end of the mappable IOVA space and gets bogged down in trying to
> > classify the types of holes that might exist.  Thanks,
>=20

I was going through this and noticed that it is possible to have multiple=20
iommu domains associated with a container. If that's true, is it safe to
make the assumption that all the domains will have the same iova
geometry or not?

Thanks,
Shameer
