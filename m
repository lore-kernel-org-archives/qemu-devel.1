Received: from eggs.gnu.org ([209.51.188.92]:51738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1hIjTH-0005pw-6T
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 20:39:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1hIjTF-0007ql-6G
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 20:39:39 -0400
Received: from mga03.intel.com ([134.134.136.65]:37928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
	id 1hIjTE-0007lV-Os
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 20:39:37 -0400
Date: Mon, 22 Apr 2019 20:33:52 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
Message-ID: <20190423003351.GB32217@joy-OptiPlex-7040>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20190419083258.19580-1-yan.y.zhao@intel.com>
	<20190419083559.19725-1-yan.y.zhao@intel.com>
	<20190422083739.GZ17995@zhen-hp.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422083739.GZ17995@zhen-hp.sh.intel.com>
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
To: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: "cjia@nvidia.com" <cjia@nvidia.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "aik@ozlabs.ru" <aik@ozlabs.ru>, "Zhengxiao.zx@alibaba-inc.com" <Zhengxiao.zx@alibaba-inc.com>, "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "eauger@redhat.com" <eauger@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "eskultet@redhat.com" <eskultet@redhat.com>, "Yang, Ziye" <ziye.yang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "libvir-list@redhat.com" <libvir-list@redhat.com>, "arei.gonglei@huawei.com" <arei.gonglei@huawei.com>, "felipe@nutanix.com" <felipe@nutanix.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>, "Tian, Kevin" <kevin.tian@intel.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "intel-gvt-dev@lists.freedesktop.org" <intel-gvt-dev@lists.freedesktop.org>, "Liu, Changpeng" <changpeng.liu@intel.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Wang, Zhi A" <zhi.a.wang@intel.com>, "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "He, Shaopeng" <shaopeng.he@intel.com>

On Mon, Apr 22, 2019 at 04:37:39PM +0800, Zhenyu Wang wrote:
> On 2019.04.19 04:35:59 -0400, Yan Zhao wrote:
> > This feature implements the version attribute for Intel's vGPU mdev
> > devices.
> > 
> > version attribute is rw. It is queried by userspace software like libvirt
> > to check whether two vGPUs are compatible for live migration.
> > 
> > It consists of two parts: common part and vendor proprietary part.
> > common part: 32 bit. lower 16 bits is vendor id and higher 16 bits
> >              identifies device type. e.g., for pci device, it is
> >              "pci vendor id" | (VFIO_DEVICE_FLAGS_PCI << 16).
> > vendor proprietary part: this part is varied in length. vendor driver can
> >              specify any string to identify a device.
> > 
> > For Intel vGPU of gen8 and gen9, the vendor proprietary part currently
> > consists of 2 fields: "device id" + "mdev type".
> > 
> > Reading from a vGPU's version attribute, a string is returned in below
> > format: 00028086-<device id>-<mdev type>. e.g.
> > 00028086-193b-i915-GVTg_V5_2.
> > 
> > Writing a string to a vGPU's version attribute will trigger GVT to check
> > whether a vGPU identified by the written string is compatible with
> > current vGPU owning this version attribute. errno is returned if the two
> > vGPUs are incompatible. The length of written string is returned in
> > compatible case.
> > 
> > For other platforms, and for GVT not supporting vGPU live migration
> > feature, errnos are returned when read/write of mdev devices' version
> > attributes.
> > 
> > For old GVT versions where no version attributes exposed in sysfs, it is
> > regarded as not supporting vGPU live migration.
> > 
> > For future platforms, besides the current 2 fields in vendor proprietary
> > part, more fields may be added to identify Intel vGPU well for live
> > migration purpose.
> > 
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: Erik Skultety <eskultet@redhat.com>
> > Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > Cc: Cornelia Huck <cohuck@redhat.com>
> > Cc: "Tian, Kevin" <kevin.tian@intel.com>
> > Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
> > Cc: "Wang, Zhi A" <zhi.a.wang@intel.com>
> > c: Neo Jia <cjia@nvidia.com>
> > Cc: Kirti Wankhede <kwankhede@nvidia.com>
> > 
> > Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> > ---
> >  drivers/gpu/drm/i915/gvt/Makefile         |  2 +-
> >  drivers/gpu/drm/i915/gvt/device_version.c | 94 +++++++++++++++++++++++
> >  drivers/gpu/drm/i915/gvt/gvt.c            | 55 +++++++++++++
> >  drivers/gpu/drm/i915/gvt/gvt.h            |  6 ++
> >  4 files changed, 156 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/gpu/drm/i915/gvt/device_version.c
> > 
> > diff --git a/drivers/gpu/drm/i915/gvt/Makefile b/drivers/gpu/drm/i915/gvt/Makefile
> > index 271fb46d4dd0..54e209a23899 100644
> > --- a/drivers/gpu/drm/i915/gvt/Makefile
> > +++ b/drivers/gpu/drm/i915/gvt/Makefile
> > @@ -3,7 +3,7 @@ GVT_DIR := gvt
> >  GVT_SOURCE := gvt.o aperture_gm.o handlers.o vgpu.o trace_points.o firmware.o \
> >  	interrupt.o gtt.o cfg_space.o opregion.o mmio.o display.o edid.o \
> >  	execlist.o scheduler.o sched_policy.o mmio_context.o cmd_parser.o debugfs.o \
> > -	fb_decoder.o dmabuf.o page_track.o
> > +	fb_decoder.o dmabuf.o page_track.o device_version.o
> >  
> >  ccflags-y				+= -I$(src) -I$(src)/$(GVT_DIR)
> >  i915-y					+= $(addprefix $(GVT_DIR)/, $(GVT_SOURCE))
> > diff --git a/drivers/gpu/drm/i915/gvt/device_version.c b/drivers/gpu/drm/i915/gvt/device_version.c
> > new file mode 100644
> > index 000000000000..c64010d2bc54
> > --- /dev/null
> > +++ b/drivers/gpu/drm/i915/gvt/device_version.c
> > @@ -0,0 +1,94 @@
> > +/*
> > + * Copyright(c) 2011-2017 Intel Corporation. All rights reserved.
> > + *
> > + * Permission is hereby granted, free of charge, to any person obtaining a
> > + * copy of this software and associated documentation files (the "Software"),
> > + * to deal in the Software without restriction, including without limitation
> > + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> > + * and/or sell copies of the Software, and to permit persons to whom the
> > + * Software is furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice (including the next
> > + * paragraph) shall be included in all copies or substantial portions of the
> > + * Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> > + * SOFTWARE.
> > + */
> > +#include <linux/vfio.h>
> > +#include "i915_drv.h"
> > +
> > +#define GVT_VFIO_DEVICE_VENDOR_ID ((0x8086) |	\
> > +		((VFIO_DEVICE_FLAGS_PCI & 0xff) << 16))
> > +
> > +#define GVT_DEVICE_VERSION_COMMON_LEN 0x8
> > +#define GVT_DEVICE_VERSION_DEVICE_ID_LEN 0x4
> > +
> > +static bool is_compatible(const char *self, const char *remote)
> > +{
> > +	if (strlen(remote) != strlen(self))
> > +		return false;
> > +
> > +	return (strncmp(self, remote, strlen(self))) ? false : true;
> > +}
> > +
> > +ssize_t intel_gvt_get_vfio_device_version_len(struct drm_i915_private *dev_priv)
> > +{
> > +	if (!IS_GEN(dev_priv, 8) && !IS_GEN(dev_priv, 9))
> > +		return -ENODEV;
> > +
> > +	return PAGE_SIZE;
> > +}
> > +
> > +ssize_t intel_gvt_get_vfio_device_version(struct drm_i915_private *dev_priv,
> > +		char *buf, const char *mdev_type)
> > +{
> > +	int cnt = 0, ret = 0;
> > +	const char *str = NULL;
> > +
> > +	/* currently only gen8 & gen9 are supported */
> > +	if (!IS_GEN(dev_priv, 8) && !IS_GEN(dev_priv, 9))
> > +		return -ENODEV;
> > +
> > +	/* first 32 bit common part specifying vendor id and it's a pci
> > +	 * device
> > +	 */
> > +	cnt = snprintf(buf, GVT_DEVICE_VERSION_COMMON_LEN + 1,
> > +			"%08x", GVT_VFIO_DEVICE_VENDOR_ID);
> > +	buf += cnt;
> > +	ret += cnt;
> > +
> > +	/* vendor proprietary part: device id + mdev type */
> > +	/* device id */
> > +	cnt = snprintf(buf, GVT_DEVICE_VERSION_DEVICE_ID_LEN + 2,
> > +			"-%04x", INTEL_DEVID(dev_priv));
> > +	buf += cnt;
> > +	ret += cnt;
> > +
> > +	/* mdev type */
> > +	str = mdev_type;
> > +	cnt = snprintf(buf, strlen(str) + 3, "-%s\n", mdev_type);
> > +	buf += cnt;
> > +	ret += cnt;
> > +
> > +	return ret;
> > +}
> > +
> > +ssize_t intel_gvt_check_vfio_device_version(struct drm_i915_private *dev_priv,
> > +		const char *self, const char *remote)
> > +{
> > +
> > +	/* currently only gen8 & gen9 are supported */
> > +	if (!IS_GEN(dev_priv, 8) && !IS_GEN(dev_priv, 9))
> > +		return -ENODEV;
> > +
> > +	if (!is_compatible(self, remote))
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > diff --git a/drivers/gpu/drm/i915/gvt/gvt.c b/drivers/gpu/drm/i915/gvt/gvt.c
> > index 43f4242062dd..e720465b93d8 100644
> > --- a/drivers/gpu/drm/i915/gvt/gvt.c
> > +++ b/drivers/gpu/drm/i915/gvt/gvt.c
> > @@ -105,14 +105,69 @@ static ssize_t description_show(struct kobject *kobj, struct device *dev,
> >  		       type->weight);
> >  }
> >  
> > +static ssize_t version_show(struct kobject *kobj, struct device *dev,
> > +		char *buf)
> > +{
> > +#ifdef GVT_MIGRATION_VERSION
> > +	struct drm_i915_private *i915 = kdev_to_i915(dev);
> > +	const char *mdev_type = kobject_name(kobj);
> > +
> > +	return intel_gvt_get_vfio_device_version(i915, buf, mdev_type);
> > +#else
> > +	/* do not support live migration */
> > +	return -EINVAL;
> > +#endif
> > +}
> > +
> > +static ssize_t version_store(struct kobject *kobj, struct device *dev,
> > +		const char *buf, size_t count)
> > +{
> > +#ifdef GVT_MIGRATION_VERSION
> > +	char *remote = NULL, *self = NULL;
> > +	int len, ret = 0;
> > +	struct drm_i915_private *i915 = kdev_to_i915(dev);
> > +	const char *mdev_type = kobject_name(kobj);
> > +
> > +	len = intel_gvt_get_vfio_device_version_len(i915);
> > +	if (len < 0)
> > +		return len;
> > +
> > +	self = kmalloc(len, GFP_KERNEL);
> > +	if (!self)
> > +		return -ENOMEM;
> > +
> > +	ret = intel_gvt_get_vfio_device_version(i915, self, mdev_type);
> > +	if (ret < 0)
> > +		goto out;
> > +
> 
> device version string should be allocated and specified during device instance
> setup instead of version attribute r/w time.
> 
hi Zhenyu
thanks for this comment. But my consideration on not allocating at device
instance initialization time is that this version check is not frequent and
only for migration purpose. so we do not need to allocate and keep this memory all
the time for what may not happen at all.  Also this dynamic memory
allocation is at version check time, not in hot path.
So, I think it is better to keep version string memory allocation here.
Agree?

Thanks
Yan

> > +	remote = kstrndup(buf, count, GFP_KERNEL);
> > +	if (!remote) {
> > +		ret = -ENOMEM;
> > +		goto out;
> > +	}
> > +
> > +	ret = intel_gvt_check_vfio_device_version(i915, self, remote);
> > +
> > +out:
> > +	kfree(self);
> > +	kfree(remote);
> > +	return (ret < 0 ? ret : count);
> > +#else
> > +	/* do not support live migration */
> > +	return -EINVAL;
> > +#endif
> > +}
> > +
> >  static MDEV_TYPE_ATTR_RO(available_instances);
> >  static MDEV_TYPE_ATTR_RO(device_api);
> >  static MDEV_TYPE_ATTR_RO(description);
> > +static MDEV_TYPE_ATTR_RW(version);
> >  
> >  static struct attribute *gvt_type_attrs[] = {
> >  	&mdev_type_attr_available_instances.attr,
> >  	&mdev_type_attr_device_api.attr,
> >  	&mdev_type_attr_description.attr,
> > +	&mdev_type_attr_version.attr,
> >  	NULL,
> >  };
> >  
> > diff --git a/drivers/gpu/drm/i915/gvt/gvt.h b/drivers/gpu/drm/i915/gvt/gvt.h
> > index f5a328b5290a..4062f6b26acf 100644
> > --- a/drivers/gpu/drm/i915/gvt/gvt.h
> > +++ b/drivers/gpu/drm/i915/gvt/gvt.h
> > @@ -687,6 +687,12 @@ void intel_gvt_debugfs_remove_vgpu(struct intel_vgpu *vgpu);
> >  int intel_gvt_debugfs_init(struct intel_gvt *gvt);
> >  void intel_gvt_debugfs_clean(struct intel_gvt *gvt);
> >  
> > +ssize_t intel_gvt_get_vfio_device_version(struct drm_i915_private *i915,
> > +		char *buf, const char *mdev_type);
> > +ssize_t intel_gvt_check_vfio_device_version(struct drm_i915_private *dev_priv,
> > +		const char *self, const char *remote);
> > +ssize_t
> > +intel_gvt_get_vfio_device_version_len(struct drm_i915_private *dev_priv);
> >  
> >  #include "trace.h"
> >  #include "mpt.h"
> > -- 
> > 2.17.1
> > 
> > _______________________________________________
> > intel-gvt-dev mailing list
> > intel-gvt-dev@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/intel-gvt-dev
> 
> -- 
> Open Source Technology Center, Intel ltd.
> 
> $gpg --keyserver wwwkeys.pgp.net --recv-keys 4D781827


> _______________________________________________
> intel-gvt-dev mailing list
> intel-gvt-dev@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gvt-dev
