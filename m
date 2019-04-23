Received: from eggs.gnu.org ([209.51.188.92]:53729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hIsqF-0002gb-Bl
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:40:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hIsqD-0001t5-M0
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:39:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hIsqD-0001qR-CX
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:39:57 -0400
Date: Tue, 23 Apr 2019 11:39:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190423103939.GF6022@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190419083258.19580-1-yan.y.zhao@intel.com>
	<20190419083505.19654-1-yan.y.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190419083505.19654-1-yan.y.zhao@intel.com>
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
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: intel-gvt-dev@lists.freedesktop.org, cjia@nvidia.com, kvm@vger.kernel.org, aik@ozlabs.ru, Zhengxiao.zx@alibaba-inc.com, shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, kwankhede@nvidia.com, eauger@redhat.com, yi.l.liu@intel.com, eskultet@redhat.com, ziye.yang@intel.com, mlevitsk@redhat.com, pasic@linux.ibm.com, libvir-list@redhat.com, arei.gonglei@huawei.com, felipe@nutanix.com, Ken.Xue@amd.com, kevin.tian@intel.com, dgilbert@redhat.com, zhenyuw@linux.intel.com, alex.williamson@redhat.com, changpeng.liu@intel.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, zhi.a.wang@intel.com, jonathan.davies@nutanix.com, shaopeng.he@intel.com

On Fri, Apr 19, 2019 at 04:35:04AM -0400, Yan Zhao wrote:
> device version attribute in mdev sysfs is used by user space software
> (e.g. libvirt) to query device compatibility for live migration of VFIO
> mdev devices. This attribute is mandatory if a mdev device supports live
> migration.
> 
> It consists of two parts: common part and vendor proprietary part.
> common part: 32 bit. lower 16 bits is vendor id and higher 16 bits
>              identifies device type. e.g., for pci device, it is
>              "pci vendor id" | (VFIO_DEVICE_FLAGS_PCI << 16).
> vendor proprietary part: this part is varied in length. vendor driver can
>              specify any string to identify a device.
> 
> When reading this attribute, it should show device version string of the
> device of type <type-id>. If a device does not support live migration, it
> should return errno.
> When writing a string to this attribute, it returns errno for
> incompatibility or returns written string length in compatibility case.
> If a device does not support live migration, it always returns errno.
> 
> For user space software to use:
> 1.
> Before starting live migration, user space software first reads source side
> mdev device's version. e.g.
> "#cat \
> /sys/bus/pci/devices/0000\:00\:02.0/5ac1fb20-2bbf-4842-bb7e-36c58c3be9cd/mdev_type/version"
> 00028086-193b-i915-GVTg_V5_4
> 
> 2.
> Then, user space software writes the source side returned version string
> to device version attribute in target side, and checks the return value.
> If a negative errno is returned in the target side, then mdev devices in
> source and target sides are not compatible;
> If a positive number is returned and it equals to the length of written
> string, then the two mdev devices in source and target side are compatible.
> e.g.
> (a) compatibility case
> "# echo 00028086-193b-i915-GVTg_V5_4 >
> /sys/bus/pci/devices/0000\:00\:02.0/882cc4da-dede-11e7-9180-078a62063ab1/mdev_type/version"
> 
> (b) incompatibility case
> "#echo 00028086-193b-i915-GVTg_V5_1 >
> /sys/bus/pci/devices/0000\:00\:02.0/882cc4da-dede-11e7-9180-078a62063ab1/mdev_type/version"
> -bash: echo: write error: Invalid argument

What you have written here seems to imply that each mdev type is able to
support many different versions at the same time. Writing a version into
this sysfs file then chooses which of the many versions to actually use.

This is good as it allows for live migration across driver software upgrades.

A mgmt application may well want to know what versions are supported for an
mdev type *before* starting a migration. A mgmt app can query all the 100's
of hosts it knows and thus figure out which are valid to use as the target
of a migration.

IOW, we want to avoid the ever hitting the incompatibility case in the
first place, by only choosing to migrate to a host that we know is going
to be compatible.

This would need some kind of way to report the full list of supported
versions against the mdev supported types on the host.


> 3. if two mdev devices are compatible, user space software can start
> live migration, and vice versa.
> 
> Note: if a mdev device does not support live migration, it either does
> not provide a version attribute, or always returns errno when its version
> attribute is read/written.
> 
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Erik Skultety <eskultet@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: "Tian, Kevin" <kevin.tian@intel.com>
> Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
> Cc: "Wang, Zhi A" <zhi.a.wang@intel.com>
> Cc: Neo Jia <cjia@nvidia.com>
> Cc: Kirti Wankhede <kwankhede@nvidia.com>
> 
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> ---
>  Documentation/vfio-mediated-device.txt | 36 ++++++++++++++++++++++++++
>  samples/vfio-mdev/mbochs.c             | 17 ++++++++++++
>  samples/vfio-mdev/mdpy.c               | 16 ++++++++++++
>  samples/vfio-mdev/mtty.c               | 16 ++++++++++++
>  4 files changed, 85 insertions(+)
> 
> diff --git a/Documentation/vfio-mediated-device.txt b/Documentation/vfio-mediated-device.txt
> index c3f69bcaf96e..bc28471c0667 100644
> --- a/Documentation/vfio-mediated-device.txt
> +++ b/Documentation/vfio-mediated-device.txt
> @@ -202,6 +202,7 @@ Directories and files under the sysfs for Each Physical Device
>    |     |   |--- available_instances
>    |     |   |--- device_api
>    |     |   |--- description
> +  |     |   |--- version
>    |     |   |--- [devices]
>    |     |--- [<type-id>]
>    |     |   |--- create
> @@ -209,6 +210,7 @@ Directories and files under the sysfs for Each Physical Device
>    |     |   |--- available_instances
>    |     |   |--- device_api
>    |     |   |--- description
> +  |     |   |--- version
>    |     |   |--- [devices]
>    |     |--- [<type-id>]
>    |          |--- create
> @@ -216,6 +218,7 @@ Directories and files under the sysfs for Each Physical Device
>    |          |--- available_instances
>    |          |--- device_api
>    |          |--- description
> +  |          |--- version
>    |          |--- [devices]
>  
>  * [mdev_supported_types]
> @@ -225,6 +228,8 @@ Directories and files under the sysfs for Each Physical Device
>    [<type-id>], device_api, and available_instances are mandatory attributes
>    that should be provided by vendor driver.
>  
> +  version is a mandatory attribute if a mdev device supports live migration.
> +
>  * [<type-id>]
>  
>    The [<type-id>] name is created by adding the device driver string as a prefix
> @@ -246,6 +251,35 @@ Directories and files under the sysfs for Each Physical Device
>    This attribute should show the number of devices of type <type-id> that can be
>    created.
>  
> +* version
> +
> +  This attribute is rw. It is used to check whether two devices are compatible
> +  for live migration. If this attribute is missing, then the corresponding mdev
> +  device is regarded as not supporting live migration.
> +
> +  It consists of two parts: common part and vendor proprietary part.
> +  common part: 32 bit. lower 16 bits is vendor id and higher 16 bits identifies
> +               device type. e.g., for pci device, it is
> +               "pci vendor id" | (VFIO_DEVICE_FLAGS_PCI << 16).
> +  vendor proprietary part: this part is varied in length. vendor driver can
> +               specify any string to identify a device.
> +
> +  When reading this attribute, it should show device version string of the device
> +  of type <type-id>. If a device does not support live migration, it should
> +  return errno.
> +  When writing a string to this attribute, it returns errno for incompatibility
> +  or returns written string length in compatibility case. If a device does not
> +  support live migration, it always returns errno.
> +
> +  for example.
> +  # cat \
> + /sys/bus/pci/devices/0000\:00\:02.0/mdev_supported_types/i915-GVTg_V5_2/version
> +  00028086-193b-i915-GVTg_V5_2
> +
> +  #echo 00028086-193b-i915-GVTg_V5_2 > \
> + /sys/bus/pci/devices/0000\:00\:02.0/mdev_supported_types/i915-GVTg_V5_4/version
> + -bash: echo: write error: Invalid argument
> +

IIUC this path is against the physical device. IOW, the mgmt app would have
to first write to the "version" file to choose a version, and then write to
the "create" file to actually create an virtual device. This has the obvious
concurrency problem if multiple devices are being created at the same time
and distinct versions for each device are required. There would need to be
a locking scheme defined to ensure safety.

Wouldn't it be better if we can pass the desired version when we write to
the "create" file, so that we avoid any concurrent usage problems. "version"
could be just a read-only file with a *list* of supported versions.

eg

  $ cat /sys/bus/pci/devices/0000\:00\:02.0/mdev_supported_types/i915-GVTg_V5_4/version
  5.0
  5.1
  5.2

  $ echo "83b8f4f2-509f-382f-3c1e-e6bfe0fa1001;version=5.2" >
      /sys/devices/virtual/mtty/mtty/mdev_supported_types/mtty-2/create


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
