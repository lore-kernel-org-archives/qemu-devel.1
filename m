Received: from eggs.gnu.org ([209.51.188.92]:34198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1hHP4h-0004Go-Vr
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 04:40:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1hHP4g-00046T-3g
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 04:40:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:32085)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
	id 1hHP4e-00045W-FK
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 04:40:44 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
Date: Fri, 19 Apr 2019 04:35:04 -0400
Message-Id: <20190419083505.19654-1-yan.y.zhao@intel.com>
In-Reply-To: <20190419083258.19580-1-yan.y.zhao@intel.com>
References: <20190419083258.19580-1-yan.y.zhao@intel.com>
Subject: [Qemu-devel] [PATCH 1/2] vfio/mdev: add version field as mandatory
 attribute for mdev device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: intel-gvt-dev@lists.freedesktop.org
Cc: arei.gonglei@huawei.com, aik@ozlabs.ru, Zhengxiao.zx@alibaba-inc.com, shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, eauger@redhat.com, yi.l.liu@intel.com, ziye.yang@intel.com, mlevitsk@redhat.com, pasic@linux.ibm.com, felipe@nutanix.com, changpeng.liu@intel.com, Ken.Xue@amd.com, jonathan.davies@nutanix.com, shaopeng.he@intel.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, libvir-list@redhat.com, alex.williamson@redhat.com, eskultet@redhat.com, dgilbert@redhat.com, cohuck@redhat.com, kevin.tian@intel.com, zhenyuw@linux.intel.com, zhi.a.wang@intel.com, cjia@nvidia.com, kwankhede@nvidia.com, Yan Zhao <yan.y.zhao@intel.com>

device version attribute in mdev sysfs is used by user space software
(e.g. libvirt) to query device compatibility for live migration of VFIO
mdev devices. This attribute is mandatory if a mdev device supports live
migration.

It consists of two parts: common part and vendor proprietary part.
common part: 32 bit. lower 16 bits is vendor id and higher 16 bits
             identifies device type. e.g., for pci device, it is
             "pci vendor id" | (VFIO_DEVICE_FLAGS_PCI << 16).
vendor proprietary part: this part is varied in length. vendor driver can
             specify any string to identify a device.

When reading this attribute, it should show device version string of the
device of type <type-id>. If a device does not support live migration, it
should return errno.
When writing a string to this attribute, it returns errno for
incompatibility or returns written string length in compatibility case.
If a device does not support live migration, it always returns errno.

For user space software to use:
1.
Before starting live migration, user space software first reads source side
mdev device's version. e.g.
"#cat \
/sys/bus/pci/devices/0000\:00\:02.0/5ac1fb20-2bbf-4842-bb7e-36c58c3be9cd/mdev_type/version"
00028086-193b-i915-GVTg_V5_4

2.
Then, user space software writes the source side returned version string
to device version attribute in target side, and checks the return value.
If a negative errno is returned in the target side, then mdev devices in
source and target sides are not compatible;
If a positive number is returned and it equals to the length of written
string, then the two mdev devices in source and target side are compatible.
e.g.
(a) compatibility case
"# echo 00028086-193b-i915-GVTg_V5_4 >
/sys/bus/pci/devices/0000\:00\:02.0/882cc4da-dede-11e7-9180-078a62063ab1/mdev_type/version"

(b) incompatibility case
"#echo 00028086-193b-i915-GVTg_V5_1 >
/sys/bus/pci/devices/0000\:00\:02.0/882cc4da-dede-11e7-9180-078a62063ab1/mdev_type/version"
-bash: echo: write error: Invalid argument

3. if two mdev devices are compatible, user space software can start
live migration, and vice versa.

Note: if a mdev device does not support live migration, it either does
not provide a version attribute, or always returns errno when its version
attribute is read/written.

Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Erik Skultety <eskultet@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: "Wang, Zhi A" <zhi.a.wang@intel.com>
Cc: Neo Jia <cjia@nvidia.com>
Cc: Kirti Wankhede <kwankhede@nvidia.com>

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 Documentation/vfio-mediated-device.txt | 36 ++++++++++++++++++++++++++
 samples/vfio-mdev/mbochs.c             | 17 ++++++++++++
 samples/vfio-mdev/mdpy.c               | 16 ++++++++++++
 samples/vfio-mdev/mtty.c               | 16 ++++++++++++
 4 files changed, 85 insertions(+)

diff --git a/Documentation/vfio-mediated-device.txt b/Documentation/vfio-mediated-device.txt
index c3f69bcaf96e..bc28471c0667 100644
--- a/Documentation/vfio-mediated-device.txt
+++ b/Documentation/vfio-mediated-device.txt
@@ -202,6 +202,7 @@ Directories and files under the sysfs for Each Physical Device
   |     |   |--- available_instances
   |     |   |--- device_api
   |     |   |--- description
+  |     |   |--- version
   |     |   |--- [devices]
   |     |--- [<type-id>]
   |     |   |--- create
@@ -209,6 +210,7 @@ Directories and files under the sysfs for Each Physical Device
   |     |   |--- available_instances
   |     |   |--- device_api
   |     |   |--- description
+  |     |   |--- version
   |     |   |--- [devices]
   |     |--- [<type-id>]
   |          |--- create
@@ -216,6 +218,7 @@ Directories and files under the sysfs for Each Physical Device
   |          |--- available_instances
   |          |--- device_api
   |          |--- description
+  |          |--- version
   |          |--- [devices]
 
 * [mdev_supported_types]
@@ -225,6 +228,8 @@ Directories and files under the sysfs for Each Physical Device
   [<type-id>], device_api, and available_instances are mandatory attributes
   that should be provided by vendor driver.
 
+  version is a mandatory attribute if a mdev device supports live migration.
+
 * [<type-id>]
 
   The [<type-id>] name is created by adding the device driver string as a prefix
@@ -246,6 +251,35 @@ Directories and files under the sysfs for Each Physical Device
   This attribute should show the number of devices of type <type-id> that can be
   created.
 
+* version
+
+  This attribute is rw. It is used to check whether two devices are compatible
+  for live migration. If this attribute is missing, then the corresponding mdev
+  device is regarded as not supporting live migration.
+
+  It consists of two parts: common part and vendor proprietary part.
+  common part: 32 bit. lower 16 bits is vendor id and higher 16 bits identifies
+               device type. e.g., for pci device, it is
+               "pci vendor id" | (VFIO_DEVICE_FLAGS_PCI << 16).
+  vendor proprietary part: this part is varied in length. vendor driver can
+               specify any string to identify a device.
+
+  When reading this attribute, it should show device version string of the device
+  of type <type-id>. If a device does not support live migration, it should
+  return errno.
+  When writing a string to this attribute, it returns errno for incompatibility
+  or returns written string length in compatibility case. If a device does not
+  support live migration, it always returns errno.
+
+  for example.
+  # cat \
+ /sys/bus/pci/devices/0000\:00\:02.0/mdev_supported_types/i915-GVTg_V5_2/version
+  00028086-193b-i915-GVTg_V5_2
+
+  #echo 00028086-193b-i915-GVTg_V5_2 > \
+ /sys/bus/pci/devices/0000\:00\:02.0/mdev_supported_types/i915-GVTg_V5_4/version
+ -bash: echo: write error: Invalid argument
+
 * [device]
 
   This directory contains links to the devices of type <type-id> that have been
@@ -327,12 +361,14 @@ card.
         |   |   |-- available_instances
         |   |   |-- create
         |   |   |-- device_api
+        |   |   |-- version
         |   |   |-- devices
         |   |   `-- name
         |   `-- mtty-2
         |       |-- available_instances
         |       |-- create
         |       |-- device_api
+        |       |-- version
         |       |-- devices
         |       `-- name
         |-- mtty_dev
diff --git a/samples/vfio-mdev/mbochs.c b/samples/vfio-mdev/mbochs.c
index b038aa9f5a70..2f5ba96b91a2 100644
--- a/samples/vfio-mdev/mbochs.c
+++ b/samples/vfio-mdev/mbochs.c
@@ -1391,11 +1391,28 @@ static ssize_t device_api_show(struct kobject *kobj, struct device *dev,
 }
 MDEV_TYPE_ATTR_RO(device_api);
 
+static ssize_t version_show(struct kobject *kobj, struct device *dev,
+		char *buf)
+{
+	/* do not support live migration */
+	return -EINVAL;
+}
+
+static ssize_t version_store(struct kobject *kobj, struct device *dev,
+		const char *buf, size_t count)
+{
+	/* do not support live migration */
+	return -EINVAL;
+}
+
+static MDEV_TYPE_ATTR_RW(version);
+
 static struct attribute *mdev_types_attrs[] = {
 	&mdev_type_attr_name.attr,
 	&mdev_type_attr_description.attr,
 	&mdev_type_attr_device_api.attr,
 	&mdev_type_attr_available_instances.attr,
+	&mdev_type_attr_version.attr,
 	NULL,
 };
 
diff --git a/samples/vfio-mdev/mdpy.c b/samples/vfio-mdev/mdpy.c
index cc86bf6566e4..ff15fdfc7d46 100644
--- a/samples/vfio-mdev/mdpy.c
+++ b/samples/vfio-mdev/mdpy.c
@@ -695,11 +695,27 @@ static ssize_t device_api_show(struct kobject *kobj, struct device *dev,
 }
 MDEV_TYPE_ATTR_RO(device_api);
 
+static ssize_t version_show(struct kobject *kobj, struct device *dev,
+		char *buf)
+{
+	/* do not support live migration */
+	return -EINVAL;
+}
+
+static ssize_t version_store(struct kobject *kobj, struct device *dev,
+		const char *buf, size_t count)
+{
+	/* do not support live migration */
+	return -EINVAL;
+}
+static MDEV_TYPE_ATTR_RW(version);
+
 static struct attribute *mdev_types_attrs[] = {
 	&mdev_type_attr_name.attr,
 	&mdev_type_attr_description.attr,
 	&mdev_type_attr_device_api.attr,
 	&mdev_type_attr_available_instances.attr,
+	&mdev_type_attr_version.attr,
 	NULL,
 };
 
diff --git a/samples/vfio-mdev/mtty.c b/samples/vfio-mdev/mtty.c
index 1c77c370c92f..4ae3aad3474d 100644
--- a/samples/vfio-mdev/mtty.c
+++ b/samples/vfio-mdev/mtty.c
@@ -1390,10 +1390,26 @@ static ssize_t device_api_show(struct kobject *kobj, struct device *dev,
 
 MDEV_TYPE_ATTR_RO(device_api);
 
+static ssize_t version_show(struct kobject *kobj, struct device *dev,
+		char *buf)
+{
+	/* do not support live migration */
+	return -EINVAL;
+}
+
+static ssize_t version_store(struct kobject *kobj, struct device *dev,
+		const char *buf, size_t count)
+{
+	/* do not support live migration */
+	return -EINVAL;
+}
+
+static MDEV_TYPE_ATTR_RW(version);
 static struct attribute *mdev_types_attrs[] = {
 	&mdev_type_attr_name.attr,
 	&mdev_type_attr_device_api.attr,
 	&mdev_type_attr_available_instances.attr,
+	&mdev_type_attr_version.attr,
 	NULL,
 };
 
-- 
2.17.1
