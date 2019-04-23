Received: from eggs.gnu.org ([209.51.188.92]:38781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hIsK0-0004cL-R8
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:06:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hIsDK-0007WZ-Vh
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 05:59:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1hIsDK-0007WI-NN
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 05:59:46 -0400
Date: Tue, 23 Apr 2019 11:59:32 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190423115932.42619422.cohuck@redhat.com>
In-Reply-To: <20190419083505.19654-1-yan.y.zhao@intel.com>
References: <20190419083258.19580-1-yan.y.zhao@intel.com>
	<20190419083505.19654-1-yan.y.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: intel-gvt-dev@lists.freedesktop.org, arei.gonglei@huawei.com, aik@ozlabs.ru, Zhengxiao.zx@alibaba-inc.com, shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, eauger@redhat.com, yi.l.liu@intel.com, ziye.yang@intel.com, mlevitsk@redhat.com, pasic@linux.ibm.com, felipe@nutanix.com, changpeng.liu@intel.com, Ken.Xue@amd.com, jonathan.davies@nutanix.com, shaopeng.he@intel.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, libvir-list@redhat.com, alex.williamson@redhat.com, eskultet@redhat.com, dgilbert@redhat.com, kevin.tian@intel.com, zhenyuw@linux.intel.com, zhi.a.wang@intel.com, cjia@nvidia.com, kwankhede@nvidia.com

On Fri, 19 Apr 2019 04:35:04 -0400
Yan Zhao <yan.y.zhao@intel.com> wrote:

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

It might make more sense if the driver does not register the attribute
for the device in that case at all.

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
> 
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

What about "An mdev device wishing to support live migration must
provide the version attribute."?

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

I'm not sure whether a device that does not support live migration
should expose this attribute in the first place. Or is that to cover
cases where a driver supports live migration only for some of the
devices it supports?

Also, I'm not sure if a string that has to be parsed is a good idea...
is this 'version' attribute supposed to convey some human-readable
information as well? The procedure you describe for compatibility
checking does the checking within the vendor driver which I would
expect to have a table/rules for that anyway.

I think you should also specify which errno writing an incompatible id
is supposed to return (probably best something different than if the
device does not support live migration at all, if we stick with
creating the attribute in that case.)

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
>  * [device]
>  
>    This directory contains links to the devices of type <type-id> that have been
