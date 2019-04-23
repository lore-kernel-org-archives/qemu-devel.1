Received: from eggs.gnu.org ([209.51.188.92]:38751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hItln-0007aa-Mm
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:39:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hItll-0007lw-NS
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:39:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1hItll-0007iv-F4
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:39:25 -0400
Date: Tue, 23 Apr 2019 13:39:11 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190423133911.5ee7bf38.cohuck@redhat.com>
In-Reply-To: <20190419083559.19725-1-yan.y.zhao@intel.com>
References: <20190419083258.19580-1-yan.y.zhao@intel.com>
	<20190419083559.19725-1-yan.y.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] drm/i915/gvt: export mdev device
 version to sysfs for Intel vGPU
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

On Fri, 19 Apr 2019 04:35:59 -0400
Yan Zhao <yan.y.zhao@intel.com> wrote:

> This feature implements the version attribute for Intel's vGPU mdev
> devices.
> 
> version attribute is rw. It is queried by userspace software like libvirt
> to check whether two vGPUs are compatible for live migration.
> 
> It consists of two parts: common part and vendor proprietary part.
> common part: 32 bit. lower 16 bits is vendor id and higher 16 bits
>              identifies device type. e.g., for pci device, it is
>              "pci vendor id" | (VFIO_DEVICE_FLAGS_PCI << 16).
> vendor proprietary part: this part is varied in length. vendor driver can
>              specify any string to identify a device.
> 
> For Intel vGPU of gen8 and gen9, the vendor proprietary part currently
> consists of 2 fields: "device id" + "mdev type".
> 
> Reading from a vGPU's version attribute, a string is returned in below
> format: 00028086-<device id>-<mdev type>. e.g.
> 00028086-193b-i915-GVTg_V5_2.
> 
> Writing a string to a vGPU's version attribute will trigger GVT to check
> whether a vGPU identified by the written string is compatible with
> current vGPU owning this version attribute. errno is returned if the two
> vGPUs are incompatible. The length of written string is returned in
> compatible case.
> 
> For other platforms, and for GVT not supporting vGPU live migration
> feature, errnos are returned when read/write of mdev devices' version
> attributes.
> 
> For old GVT versions where no version attributes exposed in sysfs, it is
> regarded as not supporting vGPU live migration.
> 
> For future platforms, besides the current 2 fields in vendor proprietary
> part, more fields may be added to identify Intel vGPU well for live
> migration purpose.
> 
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Erik Skultety <eskultet@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: "Tian, Kevin" <kevin.tian@intel.com>
> Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
> Cc: "Wang, Zhi A" <zhi.a.wang@intel.com>
> c: Neo Jia <cjia@nvidia.com>
> Cc: Kirti Wankhede <kwankhede@nvidia.com>
> 
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> ---
>  drivers/gpu/drm/i915/gvt/Makefile         |  2 +-
>  drivers/gpu/drm/i915/gvt/device_version.c | 94 +++++++++++++++++++++++
>  drivers/gpu/drm/i915/gvt/gvt.c            | 55 +++++++++++++
>  drivers/gpu/drm/i915/gvt/gvt.h            |  6 ++
>  4 files changed, 156 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/i915/gvt/device_version.c
> 

(...)

> +static bool is_compatible(const char *self, const char *remote)
> +{
> +	if (strlen(remote) != strlen(self))
> +		return false;
> +
> +	return (strncmp(self, remote, strlen(self))) ? false : true;
> +}
> +
> +ssize_t intel_gvt_get_vfio_device_version_len(struct drm_i915_private *dev_priv)
> +{
> +	if (!IS_GEN(dev_priv, 8) && !IS_GEN(dev_priv, 9))
> +		return -ENODEV;
> +
> +	return PAGE_SIZE;
> +}
> +
> +ssize_t intel_gvt_get_vfio_device_version(struct drm_i915_private *dev_priv,
> +		char *buf, const char *mdev_type)
> +{
> +	int cnt = 0, ret = 0;
> +	const char *str = NULL;
> +
> +	/* currently only gen8 & gen9 are supported */
> +	if (!IS_GEN(dev_priv, 8) && !IS_GEN(dev_priv, 9))
> +		return -ENODEV;
> +
> +	/* first 32 bit common part specifying vendor id and it's a pci
> +	 * device
> +	 */
> +	cnt = snprintf(buf, GVT_DEVICE_VERSION_COMMON_LEN + 1,
> +			"%08x", GVT_VFIO_DEVICE_VENDOR_ID);
> +	buf += cnt;
> +	ret += cnt;
> +
> +	/* vendor proprietary part: device id + mdev type */
> +	/* device id */
> +	cnt = snprintf(buf, GVT_DEVICE_VERSION_DEVICE_ID_LEN + 2,
> +			"-%04x", INTEL_DEVID(dev_priv));
> +	buf += cnt;
> +	ret += cnt;
> +
> +	/* mdev type */
> +	str = mdev_type;
> +	cnt = snprintf(buf, strlen(str) + 3, "-%s\n", mdev_type);
> +	buf += cnt;
> +	ret += cnt;
> +
> +	return ret;
> +}

Looking at this handling, it seems much easier to me to simply use a
numeric value instead of a string: You don't have to build it via
sprintf, there are generic functions for parsing a string input into a
simple number, and you have more options for compatibility (e.g.
"version must be between m and n" instead of an exact match).

If you still need to encode the device id here, you should be able to
easily do something like (device_id << 16) | migration_version -- do
you think that could work?

> +
> +ssize_t intel_gvt_check_vfio_device_version(struct drm_i915_private *dev_priv,
> +		const char *self, const char *remote)
> +{
> +
> +	/* currently only gen8 & gen9 are supported */
> +	if (!IS_GEN(dev_priv, 8) && !IS_GEN(dev_priv, 9))
> +		return -ENODEV;
> +
> +	if (!is_compatible(self, remote))
> +		return -EINVAL;

I think the meaning of the error codes should really be standardized
across vendor drivers, if we need a value for "this device does not
support migration at all". (Your choices look reasonable for that.)

> +
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/i915/gvt/gvt.c b/drivers/gpu/drm/i915/gvt/gvt.c
> index 43f4242062dd..e720465b93d8 100644
> --- a/drivers/gpu/drm/i915/gvt/gvt.c
> +++ b/drivers/gpu/drm/i915/gvt/gvt.c
> @@ -105,14 +105,69 @@ static ssize_t description_show(struct kobject *kobj, struct device *dev,
>  		       type->weight);
>  }
>  
> +static ssize_t version_show(struct kobject *kobj, struct device *dev,
> +		char *buf)
> +{
> +#ifdef GVT_MIGRATION_VERSION
> +	struct drm_i915_private *i915 = kdev_to_i915(dev);
> +	const char *mdev_type = kobject_name(kobj);
> +
> +	return intel_gvt_get_vfio_device_version(i915, buf, mdev_type);
> +#else
> +	/* do not support live migration */
> +	return -EINVAL;

...but this looks inconsistent. I would expect -ENODEV here, same as
for non-gen{8,9}.

Or simply do not create the attribute at all in that case?

> +#endif
> +}
> +
> +static ssize_t version_store(struct kobject *kobj, struct device *dev,
> +		const char *buf, size_t count)
> +{
> +#ifdef GVT_MIGRATION_VERSION
> +	char *remote = NULL, *self = NULL;
> +	int len, ret = 0;
> +	struct drm_i915_private *i915 = kdev_to_i915(dev);
> +	const char *mdev_type = kobject_name(kobj);
> +
> +	len = intel_gvt_get_vfio_device_version_len(i915);
> +	if (len < 0)
> +		return len;
> +
> +	self = kmalloc(len, GFP_KERNEL);
> +	if (!self)
> +		return -ENOMEM;
> +
> +	ret = intel_gvt_get_vfio_device_version(i915, self, mdev_type);
> +	if (ret < 0)
> +		goto out;
> +
> +	remote = kstrndup(buf, count, GFP_KERNEL);
> +	if (!remote) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	ret = intel_gvt_check_vfio_device_version(i915, self, remote);
> +
> +out:
> +	kfree(self);
> +	kfree(remote);
> +	return (ret < 0 ? ret : count);
> +#else
> +	/* do not support live migration */
> +	return -EINVAL;
> +#endif
> +}
> +
>  static MDEV_TYPE_ATTR_RO(available_instances);
>  static MDEV_TYPE_ATTR_RO(device_api);
>  static MDEV_TYPE_ATTR_RO(description);
> +static MDEV_TYPE_ATTR_RW(version);
>  
>  static struct attribute *gvt_type_attrs[] = {
>  	&mdev_type_attr_available_instances.attr,
>  	&mdev_type_attr_device_api.attr,
>  	&mdev_type_attr_description.attr,
> +	&mdev_type_attr_version.attr,
>  	NULL,
>  };
>  
(...)
