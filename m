Received: from eggs.gnu.org ([209.51.188.92]:48026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1hJqGy-0006IS-0O
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 22:07:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1hJqGv-0001YQ-Su
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 22:07:32 -0400
Received: from mga07.intel.com ([134.134.136.100]:13826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
	id 1hJqGv-0001NS-JI
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 22:07:29 -0400
Date: Thu, 25 Apr 2019 22:01:45 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
Message-ID: <20190426020145.GB24375@joy-OptiPlex-7040>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20190419083258.19580-1-yan.y.zhao@intel.com>
	<20190419083505.19654-1-yan.y.zhao@intel.com>
	<20190423103939.GF6022@redhat.com>
	<3E673A9E-90B1-4A2F-AAAE-E76174AF1B6D@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3E673A9E-90B1-4A2F-AAAE-E76174AF1B6D@redhat.com>
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
To: Christophe de Dinechin <dinechin@redhat.com>
Cc: =?iso-8859-1?Q?=22Daniel_P=2E_Berrang=E9=22?= <berrange@redhat.com>, "intel-gvt-dev@lists.freedesktop.org" <intel-gvt-dev@lists.freedesktop.org>, "cjia@nvidia.com" <cjia@nvidia.com>, KVM list <kvm@vger.kernel.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, "Zhengxiao.zx@alibaba-inc.com" <Zhengxiao.zx@alibaba-inc.com>, "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Kirti Wankhede <kwankhede@nvidia.com>, "eauger@redhat.com" <eauger@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Erik Skultety <eskultet@redhat.com>, "Yang, Ziye" <ziye.yang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, "libvir-list@redhat.com" <libvir-list@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "felipe@nutanix.com" <felipe@nutanix.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, Alex Williamson <alex.williamson@redhat.com>, "Liu, Changpeng" <changpeng.liu@intel.com>, Cornelia Huck <cohuck@redhat.com>, open list <linux-kernel@vger.kernel.org>, "Wang, Zhi A" <zhi.a.wang@intel.com>, "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "He, Shaopeng" <shaopeng.he@intel.com>

On Wed, Apr 24, 2019 at 05:10:43PM +0800, Christophe de Dinechin wrote:
> 
> 
> > On 23 Apr 2019, at 12:39, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > 
> > On Fri, Apr 19, 2019 at 04:35:04AM -0400, Yan Zhao wrote:
> >> device version attribute in mdev sysfs is used by user space software
> >> (e.g. libvirt) to query device compatibility for live migration of VFIO
> >> mdev devices. This attribute is mandatory if a mdev device supports live
> >> migration.
> >> 
> >> It consists of two parts: common part and vendor proprietary part.
> >> common part: 32 bit. lower 16 bits is vendor id and higher 16 bits
> >>             identifies device type. e.g., for pci device, it is
> >>             "pci vendor id" | (VFIO_DEVICE_FLAGS_PCI << 16).
> >> vendor proprietary part: this part is varied in length. vendor driver can
> >>             specify any string to identify a device.
> >> 
> >> When reading this attribute, it should show device version string of the
> >> device of type <type-id>. If a device does not support live migration, it
> >> should return errno.
> >> When writing a string to this attribute, it returns errno for
> >> incompatibility or returns written string length in compatibility case.
> >> If a device does not support live migration, it always returns errno.
> >> 
> >> For user space software to use:
> >> 1.
> >> Before starting live migration, user space software first reads source side
> >> mdev device's version. e.g.
> >> "#cat \
> >> /sys/bus/pci/devices/0000\:00\:02.0/5ac1fb20-2bbf-4842-bb7e-36c58c3be9cd/mdev_type/version"
> >> 00028086-193b-i915-GVTg_V5_4
> >> 
> >> 2.
> >> Then, user space software writes the source side returned version string
> >> to device version attribute in target side, and checks the return value.
> >> If a negative errno is returned in the target side, then mdev devices in
> >> source and target sides are not compatible;
> >> If a positive number is returned and it equals to the length of written
> >> string, then the two mdev devices in source and target side are compatible.
> >> e.g.
> >> (a) compatibility case
> >> "# echo 00028086-193b-i915-GVTg_V5_4 >
> >> /sys/bus/pci/devices/0000\:00\:02.0/882cc4da-dede-11e7-9180-078a62063ab1/mdev_type/version"
> >> 
> >> (b) incompatibility case
> >> "#echo 00028086-193b-i915-GVTg_V5_1 >
> >> /sys/bus/pci/devices/0000\:00\:02.0/882cc4da-dede-11e7-9180-078a62063ab1/mdev_type/version"
> >> -bash: echo: write error: Invalid argument
> > 
> > What you have written here seems to imply that each mdev type is able to
> > support many different versions at the same time. Writing a version into
> > this sysfs file then chooses which of the many versions to actually use.
> > 
> > This is good as it allows for live migration across driver software upgrades.
> > 
> > A mgmt application may well want to know what versions are supported for an
> > mdev type *before* starting a migration. A mgmt app can query all the 100's
> > of hosts it knows and thus figure out which are valid to use as the target
> > of a migration.
> > 
> > IOW, we want to avoid the ever hitting the incompatibility case in the
> > first place, by only choosing to migrate to a host that we know is going
> > to be compatible.
> > 
> > This would need some kind of way to report the full list of supported
> > versions against the mdev supported types on the host.
> > 
> > 
> >> 3. if two mdev devices are compatible, user space software can start
> >> live migration, and vice versa.
> >> 
> >> Note: if a mdev device does not support live migration, it either does
> >> not provide a version attribute, or always returns errno when its version
> >> attribute is read/written.
> >> 
> >> Cc: Alex Williamson <alex.williamson@redhat.com>
> >> Cc: Erik Skultety <eskultet@redhat.com>
> >> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >> Cc: Cornelia Huck <cohuck@redhat.com>
> >> Cc: "Tian, Kevin" <kevin.tian@intel.com>
> >> Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
> >> Cc: "Wang, Zhi A" <zhi.a.wang@intel.com>
> >> Cc: Neo Jia <cjia@nvidia.com>
> >> Cc: Kirti Wankhede <kwankhede@nvidia.com>
> >> 
> >> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> >> ---
> >> Documentation/vfio-mediated-device.txt | 36 ++++++++++++++++++++++++++
> >> samples/vfio-mdev/mbochs.c             | 17 ++++++++++++
> >> samples/vfio-mdev/mdpy.c               | 16 ++++++++++++
> >> samples/vfio-mdev/mtty.c               | 16 ++++++++++++
> >> 4 files changed, 85 insertions(+)
> >> 
> >> diff --git a/Documentation/vfio-mediated-device.txt b/Documentation/vfio-mediated-device.txt
> >> index c3f69bcaf96e..bc28471c0667 100644
> >> --- a/Documentation/vfio-mediated-device.txt
> >> +++ b/Documentation/vfio-mediated-device.txt
> >> @@ -202,6 +202,7 @@ Directories and files under the sysfs for Each Physical Device
> >>   |     |   |--- available_instances
> >>   |     |   |--- device_api
> >>   |     |   |--- description
> >> +  |     |   |--- version
> >>   |     |   |--- [devices]
> >>   |     |--- [<type-id>]
> >>   |     |   |--- create
> >> @@ -209,6 +210,7 @@ Directories and files under the sysfs for Each Physical Device
> >>   |     |   |--- available_instances
> >>   |     |   |--- device_api
> >>   |     |   |--- description
> >> +  |     |   |--- version
> >>   |     |   |--- [devices]
> >>   |     |--- [<type-id>]
> >>   |          |--- create
> >> @@ -216,6 +218,7 @@ Directories and files under the sysfs for Each Physical Device
> >>   |          |--- available_instances
> >>   |          |--- device_api
> >>   |          |--- description
> >> +  |          |--- version
> >>   |          |--- [devices]
> >> 
> >> * [mdev_supported_types]
> >> @@ -225,6 +228,8 @@ Directories and files under the sysfs for Each Physical Device
> >>   [<type-id>], device_api, and available_instances are mandatory attributes
> >>   that should be provided by vendor driver.
> >> 
> >> +  version is a mandatory attribute if a mdev device supports live migration.
> >> +
> >> * [<type-id>]
> >> 
> >>   The [<type-id>] name is created by adding the device driver string as a prefix
> >> @@ -246,6 +251,35 @@ Directories and files under the sysfs for Each Physical Device
> >>   This attribute should show the number of devices of type <type-id> that can be
> >>   created.
> >> 
> >> +* version
> >> +
> >> +  This attribute is rw. It is used to check whether two devices are compatible
> >> +  for live migration. If this attribute is missing, then the corresponding mdev
> >> +  device is regarded as not supporting live migration.
> >> +
> >> +  It consists of two parts: common part and vendor proprietary part.
> >> +  common part: 32 bit. lower 16 bits is vendor id and higher 16 bits identifies
> >> +               device type. e.g., for pci device, it is
> >> +               "pci vendor id" | (VFIO_DEVICE_FLAGS_PCI << 16).
> >> +  vendor proprietary part: this part is varied in length. vendor driver can
> >> +               specify any string to identify a device.
> >> +
> >> +  When reading this attribute, it should show device version string of the device
> >> +  of type <type-id>. If a device does not support live migration, it should
> >> +  return errno.
> >> +  When writing a string to this attribute, it returns errno for incompatibility
> >> +  or returns written string length in compatibility case. If a device does not
> >> +  support live migration, it always returns errno.
> >> +
> >> +  for example.
> >> +  # cat \
> >> + /sys/bus/pci/devices/0000\:00\:02.0/mdev_supported_types/i915-GVTg_V5_2/version
> >> +  00028086-193b-i915-GVTg_V5_2
> >> +
> >> +  #echo 00028086-193b-i915-GVTg_V5_2 > \
> >> + /sys/bus/pci/devices/0000\:00\:02.0/mdev_supported_types/i915-GVTg_V5_4/version
> >> + -bash: echo: write error: Invalid argument
> >> +
> > 
> > IIUC this path is against the physical device. IOW, the mgmt app would have
> > to first write to the "version" file to choose a version, and then write to
> > the "create" file to actually create an virtual device. This has the obvious
> > concurrency problem if multiple devices are being created at the same time
> > and distinct versions for each device are required. There would need to be
> > a locking scheme defined to ensure safety.
> > 
> > Wouldn't it be better if we can pass the desired version when we write to
> > the "create" file, so that we avoid any concurrent usage problems. "version"
> > could be just a read-only file with a *list* of supported versions.
> > 
> > eg
> > 
> >  $ cat /sys/bus/pci/devices/0000\:00\:02.0/mdev_supported_types/i915-GVTg_V5_4/version
> >  5.0
> >  5.1
> >  5.2
> > 
> >  $ echo "83b8f4f2-509f-382f-3c1e-e6bfe0fa1001;version=5.2" >
> >      /sys/devices/virtual/mtty/mtty/mdev_supported_types/mtty-2/create
> > 
> 
> I read Alex’s comment that creating an mdev with a specific version is not the intent here. However…
> 
> - If the goal is just to check compatibility with migration data, then I think the name should be more explicit, e.g. migration_version instead of version. Otherwise, I read the intent the way Daniel did.
>
hi Christophe,
you are right, this "version" is not for creating mdev device. It is to
describe a mdev clearly (therefore it may include information about an mdev's parent device).
As a result, it can be leveraged by migration -- before starting migration,
user space software can check if two mdev devices are compatible for migration.
(of course, this check is shifting to vendor driver by writing one mdev's version
string to another mdev's version node and checking the result).
Compared to renaming it to migration_version, I would like to describe its usage
more clearly in doc.

Thanks for your input:)

Yan


> - If we want to provide a list of versions and make it possible to create instances based on a version, I would rather use a directory structure for that, i.e. (replacing cat with ls):
> 
> $ ls /sys/bus/pci/devices/0000\:00\:02.0/mdev_supported_types/i915-GVTg_V5_4/version
>  5.0
>  5.1
>  5.2
> 
> where each version is a directory that has its own available_instances, device_api, description, create, …
> 
> $ echo 83b8f4f2-509f-382f-3c1e-e6bfe0fa1001 > /sys/bus/pci/devices/0000\:00\:02.0/mdev_supported_types/i915-GVTg_V5_4/version/5.1/create
> 
> In addition to not having the problem of two consecutive writes to distinct files, I can imagine contrived cases where available_instances might depend on the version…
> 
> 
> Thanks
> Christophe
> 
> > 
> > Regards,
> > Daniel
> > -- 
> > |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> > |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> > |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 
