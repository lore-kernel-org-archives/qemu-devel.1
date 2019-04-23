Received: from eggs.gnu.org ([209.51.188.92]:53696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hIutN-00011d-Gs
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 08:51:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hIueK-0007hT-NR
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 08:35:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1hIueK-0007dc-F8
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 08:35:48 -0400
Date: Tue, 23 Apr 2019 06:35:40 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190423063540.7ec83c31@x1.home>
In-Reply-To: <20190423103939.GF6022@redhat.com>
References: <20190419083258.19580-1-yan.y.zhao@intel.com>
	<20190419083505.19654-1-yan.y.zhao@intel.com>
	<20190423103939.GF6022@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] vfio/mdev: add version field as
 mandatory attribute for mdev device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>, intel-gvt-dev@lists.freedesktop.org, cjia@nvidia.com, kvm@vger.kernel.org, aik@ozlabs.ru, Zhengxiao.zx@alibaba-inc.com, shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, kwankhede@nvidia.com, eauger@redhat.com, yi.l.liu@intel.com, eskultet@redhat.com, ziye.yang@intel.com, mlevitsk@redhat.com, pasic@linux.ibm.com, libvir-list@redhat.com, arei.gonglei@huawei.com, felipe@nutanix.com, Ken.Xue@amd.com, kevin.tian@intel.com, dgilbert@redhat.com, zhenyuw@linux.intel.com, changpeng.liu@intel.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, zhi.a.wang@intel.com, jonathan.davies@nutanix.com, shaopeng.he@intel.com

On Tue, 23 Apr 2019 11:39:39 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Fri, Apr 19, 2019 at 04:35:04AM -0400, Yan Zhao wrote:
> > device version attribute in mdev sysfs is used by user space software
> > (e.g. libvirt) to query device compatibility for live migration of VFIO
> > mdev devices. This attribute is mandatory if a mdev device supports live
> > migration.
> >=20
> > It consists of two parts: common part and vendor proprietary part.
> > common part: 32 bit. lower 16 bits is vendor id and higher 16 bits
> >              identifies device type. e.g., for pci device, it is
> >              "pci vendor id" | (VFIO_DEVICE_FLAGS_PCI << 16).
> > vendor proprietary part: this part is varied in length. vendor driver c=
an
> >              specify any string to identify a device.
> >=20
> > When reading this attribute, it should show device version string of the
> > device of type <type-id>. If a device does not support live migration, =
it
> > should return errno.
> > When writing a string to this attribute, it returns errno for
> > incompatibility or returns written string length in compatibility case.
> > If a device does not support live migration, it always returns errno.
> >=20
> > For user space software to use:
> > 1.
> > Before starting live migration, user space software first reads source =
side
> > mdev device's version. e.g.
> > "#cat \
> > /sys/bus/pci/devices/0000\:00\:02.0/5ac1fb20-2bbf-4842-bb7e-36c58c3be9c=
d/mdev_type/version"
> > 00028086-193b-i915-GVTg_V5_4
> >=20
> > 2.
> > Then, user space software writes the source side returned version string
> > to device version attribute in target side, and checks the return value.
> > If a negative errno is returned in the target side, then mdev devices in
> > source and target sides are not compatible;
> > If a positive number is returned and it equals to the length of written
> > string, then the two mdev devices in source and target side are compati=
ble.
> > e.g.
> > (a) compatibility case
> > "# echo 00028086-193b-i915-GVTg_V5_4 >
> > /sys/bus/pci/devices/0000\:00\:02.0/882cc4da-dede-11e7-9180-078a62063ab=
1/mdev_type/version"
> >=20
> > (b) incompatibility case
> > "#echo 00028086-193b-i915-GVTg_V5_1 >
> > /sys/bus/pci/devices/0000\:00\:02.0/882cc4da-dede-11e7-9180-078a62063ab=
1/mdev_type/version"
> > -bash: echo: write error: Invalid argument =20
>=20
> What you have written here seems to imply that each mdev type is able to
> support many different versions at the same time. Writing a version into
> this sysfs file then chooses which of the many versions to actually use.

That's not actually what's being proposed here, reading the version
attribute provides an opaque string.  Writing the version attribute
from a different system reports whether that version string is
compatible for migration.  IOW, we're not creating a device of a given
version, we're only reporting if that version is compatible with this
mdev.  The version is intentionally opaque to allow vendor specific
nuances, therefore it's rather impractical create the sort of version
list requested below.

> This is good as it allows for live migration across driver software upgra=
des.
>=20
> A mgmt application may well want to know what versions are supported for =
an
> mdev type *before* starting a migration. A mgmt app can query all the 100=
's
> of hosts it knows and thus figure out which are valid to use as the target
> of a migration.
>=20
> IOW, we want to avoid the ever hitting the incompatibility case in the
> first place, by only choosing to migrate to a host that we know is going
> to be compatible.

This is provided, the migration source reports a version string which
can be queried against the version attribute on other hosts to insure
compatibility prior to migration.

> This would need some kind of way to report the full list of supported
> versions against the mdev supported types on the host.

This is not provided, matching versions are vendor specific.

> > 3. if two mdev devices are compatible, user space software can start
> > live migration, and vice versa.
> >=20
> > Note: if a mdev device does not support live migration, it either does
> > not provide a version attribute, or always returns errno when its versi=
on
> > attribute is read/written.
> >=20
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: Erik Skultety <eskultet@redhat.com>
> > Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > Cc: Cornelia Huck <cohuck@redhat.com>
> > Cc: "Tian, Kevin" <kevin.tian@intel.com>
> > Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
> > Cc: "Wang, Zhi A" <zhi.a.wang@intel.com>
> > Cc: Neo Jia <cjia@nvidia.com>
> > Cc: Kirti Wankhede <kwankhede@nvidia.com>
> >=20
> > Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> > ---
> >  Documentation/vfio-mediated-device.txt | 36 ++++++++++++++++++++++++++
> >  samples/vfio-mdev/mbochs.c             | 17 ++++++++++++
> >  samples/vfio-mdev/mdpy.c               | 16 ++++++++++++
> >  samples/vfio-mdev/mtty.c               | 16 ++++++++++++
> >  4 files changed, 85 insertions(+)
> >=20
> > diff --git a/Documentation/vfio-mediated-device.txt b/Documentation/vfi=
o-mediated-device.txt
> > index c3f69bcaf96e..bc28471c0667 100644
> > --- a/Documentation/vfio-mediated-device.txt
> > +++ b/Documentation/vfio-mediated-device.txt
> > @@ -202,6 +202,7 @@ Directories and files under the sysfs for Each Phys=
ical Device
> >    |     |   |--- available_instances
> >    |     |   |--- device_api
> >    |     |   |--- description
> > +  |     |   |--- version
> >    |     |   |--- [devices]
> >    |     |--- [<type-id>]
> >    |     |   |--- create
> > @@ -209,6 +210,7 @@ Directories and files under the sysfs for Each Phys=
ical Device
> >    |     |   |--- available_instances
> >    |     |   |--- device_api
> >    |     |   |--- description
> > +  |     |   |--- version
> >    |     |   |--- [devices]
> >    |     |--- [<type-id>]
> >    |          |--- create
> > @@ -216,6 +218,7 @@ Directories and files under the sysfs for Each Phys=
ical Device
> >    |          |--- available_instances
> >    |          |--- device_api
> >    |          |--- description
> > +  |          |--- version
> >    |          |--- [devices]
> > =20
> >  * [mdev_supported_types]
> > @@ -225,6 +228,8 @@ Directories and files under the sysfs for Each Phys=
ical Device
> >    [<type-id>], device_api, and available_instances are mandatory attri=
butes
> >    that should be provided by vendor driver.
> > =20
> > +  version is a mandatory attribute if a mdev device supports live migr=
ation.
> > +
> >  * [<type-id>]
> > =20
> >    The [<type-id>] name is created by adding the device driver string a=
s a prefix
> > @@ -246,6 +251,35 @@ Directories and files under the sysfs for Each Phy=
sical Device
> >    This attribute should show the number of devices of type <type-id> t=
hat can be
> >    created.
> > =20
> > +* version
> > +
> > +  This attribute is rw. It is used to check whether two devices are co=
mpatible
> > +  for live migration. If this attribute is missing, then the correspon=
ding mdev
> > +  device is regarded as not supporting live migration.
> > +
> > +  It consists of two parts: common part and vendor proprietary part.
> > +  common part: 32 bit. lower 16 bits is vendor id and higher 16 bits i=
dentifies
> > +               device type. e.g., for pci device, it is
> > +               "pci vendor id" | (VFIO_DEVICE_FLAGS_PCI << 16).
> > +  vendor proprietary part: this part is varied in length. vendor drive=
r can
> > +               specify any string to identify a device.
> > +
> > +  When reading this attribute, it should show device version string of=
 the device
> > +  of type <type-id>. If a device does not support live migration, it s=
hould
> > +  return errno.
> > +  When writing a string to this attribute, it returns errno for incomp=
atibility
> > +  or returns written string length in compatibility case. If a device =
does not
> > +  support live migration, it always returns errno.
> > +
> > +  for example.
> > +  # cat \
> > + /sys/bus/pci/devices/0000\:00\:02.0/mdev_supported_types/i915-GVTg_V5=
_2/version
> > +  00028086-193b-i915-GVTg_V5_2
> > +
> > +  #echo 00028086-193b-i915-GVTg_V5_2 > \
> > + /sys/bus/pci/devices/0000\:00\:02.0/mdev_supported_types/i915-GVTg_V5=
_4/version
> > + -bash: echo: write error: Invalid argument
> > + =20
>=20
> IIUC this path is against the physical device. IOW, the mgmt app would ha=
ve
> to first write to the "version" file to choose a version, and then write =
to
> the "create" file to actually create an virtual device. This has the obvi=
ous
> concurrency problem if multiple devices are being created at the same time
> and distinct versions for each device are required. There would need to be
> a locking scheme defined to ensure safety.

"Create a device of a given version" is not an intended feature of this
interface aiui.  Writing the version attribute only indicates
migration compatibility with a binary result.
=20
> Wouldn't it be better if we can pass the desired version when we write to
> the "create" file, so that we avoid any concurrent usage problems. "versi=
on"
> could be just a read-only file with a *list* of supported versions.
>=20
> eg
>=20
>   $ cat /sys/bus/pci/devices/0000\:00\:02.0/mdev_supported_types/i915-GVT=
g_V5_4/version
>   5.0
>   5.1
>   5.2
>=20
>   $ echo "83b8f4f2-509f-382f-3c1e-e6bfe0fa1001;version=3D5.2" >
>       /sys/devices/virtual/mtty/mtty/mdev_supported_types/mtty-2/create

This is reminiscent of the proposed aggregation support, but again,
this sort of feature is not intended here.  It's no expected that any
vendor driver would support creating device types of different
versions, but they may support migration from different versions.
Thanks,

Alex
