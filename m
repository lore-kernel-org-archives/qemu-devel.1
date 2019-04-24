Received: from eggs.gnu.org ([209.51.188.92]:43890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dinechin@redhat.com>) id 1hJDvX-0006Zw-56
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 05:10:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dinechin@redhat.com>) id 1hJDvV-0007pH-8r
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 05:10:51 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37858)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dinechin@redhat.com>) id 1hJDvU-0007fO-VI
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 05:10:49 -0400
Received: by mail-wm1-f68.google.com with SMTP id v14so3932606wmf.2
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 02:10:47 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
From: Christophe de Dinechin <dinechin@redhat.com>
In-Reply-To: <20190423103939.GF6022@redhat.com>
Date: Wed, 24 Apr 2019 11:10:43 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <3E673A9E-90B1-4A2F-AAAE-E76174AF1B6D@redhat.com>
References: <20190419083258.19580-1-yan.y.zhao@intel.com>
	<20190419083505.19654-1-yan.y.zhao@intel.com>
	<20190423103939.GF6022@redhat.com>
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
To: =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>, intel-gvt-dev@lists.freedesktop.org, cjia@nvidia.com, KVM list <kvm@vger.kernel.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Zhengxiao.zx@alibaba-inc.com, shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, Kirti Wankhede <kwankhede@nvidia.com>, eauger@redhat.com, yi.l.liu@intel.com, Erik Skultety <eskultet@redhat.com>, ziye.yang@intel.com, mlevitsk@redhat.com, Halil Pasic <pasic@linux.ibm.com>, libvir-list@redhat.com, "Gonglei (Arei)" <arei.gonglei@huawei.com>, felipe@nutanix.com, Ken.Xue@amd.com, "Tian, Kevin" <kevin.tian@intel.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, Alex Williamson <alex.williamson@redhat.com>, changpeng.liu@intel.com, Cornelia Huck <cohuck@redhat.com>, open list <linux-kernel@vger.kernel.org>, Zhi Wang <zhi.a.wang@intel.com>, jonathan.davies@nutanix.com, shaopeng.he@intel.com



> On 23 Apr 2019, at 12:39, Daniel P. Berrang=C3=A9 =
<berrange@redhat.com> wrote:
>=20
> On Fri, Apr 19, 2019 at 04:35:04AM -0400, Yan Zhao wrote:
>> device version attribute in mdev sysfs is used by user space software
>> (e.g. libvirt) to query device compatibility for live migration of =
VFIO
>> mdev devices. This attribute is mandatory if a mdev device supports =
live
>> migration.
>>=20
>> It consists of two parts: common part and vendor proprietary part.
>> common part: 32 bit. lower 16 bits is vendor id and higher 16 bits
>>             identifies device type. e.g., for pci device, it is
>>             "pci vendor id" | (VFIO_DEVICE_FLAGS_PCI << 16).
>> vendor proprietary part: this part is varied in length. vendor driver =
can
>>             specify any string to identify a device.
>>=20
>> When reading this attribute, it should show device version string of =
the
>> device of type <type-id>. If a device does not support live =
migration, it
>> should return errno.
>> When writing a string to this attribute, it returns errno for
>> incompatibility or returns written string length in compatibility =
case.
>> If a device does not support live migration, it always returns errno.
>>=20
>> For user space software to use:
>> 1.
>> Before starting live migration, user space software first reads =
source side
>> mdev device's version. e.g.
>> "#cat \
>> =
/sys/bus/pci/devices/0000\:00\:02.0/5ac1fb20-2bbf-4842-bb7e-36c58c3be9cd/m=
dev_type/version"
>> 00028086-193b-i915-GVTg_V5_4
>>=20
>> 2.
>> Then, user space software writes the source side returned version =
string
>> to device version attribute in target side, and checks the return =
value.
>> If a negative errno is returned in the target side, then mdev devices =
in
>> source and target sides are not compatible;
>> If a positive number is returned and it equals to the length of =
written
>> string, then the two mdev devices in source and target side are =
compatible.
>> e.g.
>> (a) compatibility case
>> "# echo 00028086-193b-i915-GVTg_V5_4 >
>> =
/sys/bus/pci/devices/0000\:00\:02.0/882cc4da-dede-11e7-9180-078a62063ab1/m=
dev_type/version"
>>=20
>> (b) incompatibility case
>> "#echo 00028086-193b-i915-GVTg_V5_1 >
>> =
/sys/bus/pci/devices/0000\:00\:02.0/882cc4da-dede-11e7-9180-078a62063ab1/m=
dev_type/version"
>> -bash: echo: write error: Invalid argument
>=20
> What you have written here seems to imply that each mdev type is able =
to
> support many different versions at the same time. Writing a version =
into
> this sysfs file then chooses which of the many versions to actually =
use.
>=20
> This is good as it allows for live migration across driver software =
upgrades.
>=20
> A mgmt application may well want to know what versions are supported =
for an
> mdev type *before* starting a migration. A mgmt app can query all the =
100's
> of hosts it knows and thus figure out which are valid to use as the =
target
> of a migration.
>=20
> IOW, we want to avoid the ever hitting the incompatibility case in the
> first place, by only choosing to migrate to a host that we know is =
going
> to be compatible.
>=20
> This would need some kind of way to report the full list of supported
> versions against the mdev supported types on the host.
>=20
>=20
>> 3. if two mdev devices are compatible, user space software can start
>> live migration, and vice versa.
>>=20
>> Note: if a mdev device does not support live migration, it either =
does
>> not provide a version attribute, or always returns errno when its =
version
>> attribute is read/written.
>>=20
>> Cc: Alex Williamson <alex.williamson@redhat.com>
>> Cc: Erik Skultety <eskultet@redhat.com>
>> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>> Cc: Cornelia Huck <cohuck@redhat.com>
>> Cc: "Tian, Kevin" <kevin.tian@intel.com>
>> Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
>> Cc: "Wang, Zhi A" <zhi.a.wang@intel.com>
>> Cc: Neo Jia <cjia@nvidia.com>
>> Cc: Kirti Wankhede <kwankhede@nvidia.com>
>>=20
>> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
>> ---
>> Documentation/vfio-mediated-device.txt | 36 =
++++++++++++++++++++++++++
>> samples/vfio-mdev/mbochs.c             | 17 ++++++++++++
>> samples/vfio-mdev/mdpy.c               | 16 ++++++++++++
>> samples/vfio-mdev/mtty.c               | 16 ++++++++++++
>> 4 files changed, 85 insertions(+)
>>=20
>> diff --git a/Documentation/vfio-mediated-device.txt =
b/Documentation/vfio-mediated-device.txt
>> index c3f69bcaf96e..bc28471c0667 100644
>> --- a/Documentation/vfio-mediated-device.txt
>> +++ b/Documentation/vfio-mediated-device.txt
>> @@ -202,6 +202,7 @@ Directories and files under the sysfs for Each =
Physical Device
>>   |     |   |--- available_instances
>>   |     |   |--- device_api
>>   |     |   |--- description
>> +  |     |   |--- version
>>   |     |   |--- [devices]
>>   |     |--- [<type-id>]
>>   |     |   |--- create
>> @@ -209,6 +210,7 @@ Directories and files under the sysfs for Each =
Physical Device
>>   |     |   |--- available_instances
>>   |     |   |--- device_api
>>   |     |   |--- description
>> +  |     |   |--- version
>>   |     |   |--- [devices]
>>   |     |--- [<type-id>]
>>   |          |--- create
>> @@ -216,6 +218,7 @@ Directories and files under the sysfs for Each =
Physical Device
>>   |          |--- available_instances
>>   |          |--- device_api
>>   |          |--- description
>> +  |          |--- version
>>   |          |--- [devices]
>>=20
>> * [mdev_supported_types]
>> @@ -225,6 +228,8 @@ Directories and files under the sysfs for Each =
Physical Device
>>   [<type-id>], device_api, and available_instances are mandatory =
attributes
>>   that should be provided by vendor driver.
>>=20
>> +  version is a mandatory attribute if a mdev device supports live =
migration.
>> +
>> * [<type-id>]
>>=20
>>   The [<type-id>] name is created by adding the device driver string =
as a prefix
>> @@ -246,6 +251,35 @@ Directories and files under the sysfs for Each =
Physical Device
>>   This attribute should show the number of devices of type <type-id> =
that can be
>>   created.
>>=20
>> +* version
>> +
>> +  This attribute is rw. It is used to check whether two devices are =
compatible
>> +  for live migration. If this attribute is missing, then the =
corresponding mdev
>> +  device is regarded as not supporting live migration.
>> +
>> +  It consists of two parts: common part and vendor proprietary part.
>> +  common part: 32 bit. lower 16 bits is vendor id and higher 16 bits =
identifies
>> +               device type. e.g., for pci device, it is
>> +               "pci vendor id" | (VFIO_DEVICE_FLAGS_PCI << 16).
>> +  vendor proprietary part: this part is varied in length. vendor =
driver can
>> +               specify any string to identify a device.
>> +
>> +  When reading this attribute, it should show device version string =
of the device
>> +  of type <type-id>. If a device does not support live migration, it =
should
>> +  return errno.
>> +  When writing a string to this attribute, it returns errno for =
incompatibility
>> +  or returns written string length in compatibility case. If a =
device does not
>> +  support live migration, it always returns errno.
>> +
>> +  for example.
>> +  # cat \
>> + =
/sys/bus/pci/devices/0000\:00\:02.0/mdev_supported_types/i915-GVTg_V5_2/ve=
rsion
>> +  00028086-193b-i915-GVTg_V5_2
>> +
>> +  #echo 00028086-193b-i915-GVTg_V5_2 > \
>> + =
/sys/bus/pci/devices/0000\:00\:02.0/mdev_supported_types/i915-GVTg_V5_4/ve=
rsion
>> + -bash: echo: write error: Invalid argument
>> +
>=20
> IIUC this path is against the physical device. IOW, the mgmt app would =
have
> to first write to the "version" file to choose a version, and then =
write to
> the "create" file to actually create an virtual device. This has the =
obvious
> concurrency problem if multiple devices are being created at the same =
time
> and distinct versions for each device are required. There would need =
to be
> a locking scheme defined to ensure safety.
>=20
> Wouldn't it be better if we can pass the desired version when we write =
to
> the "create" file, so that we avoid any concurrent usage problems. =
"version"
> could be just a read-only file with a *list* of supported versions.
>=20
> eg
>=20
>  $ cat =
/sys/bus/pci/devices/0000\:00\:02.0/mdev_supported_types/i915-GVTg_V5_4/ve=
rsion
>  5.0
>  5.1
>  5.2
>=20
>  $ echo "83b8f4f2-509f-382f-3c1e-e6bfe0fa1001;version=3D5.2" >
>      /sys/devices/virtual/mtty/mtty/mdev_supported_types/mtty-2/create
>=20

I read Alex=E2=80=99s comment that creating an mdev with a specific =
version is not the intent here. However=E2=80=A6

- If the goal is just to check compatibility with migration data, then I =
think the name should be more explicit, e.g. migration_version instead =
of version. Otherwise, I read the intent the way Daniel did.

- If we want to provide a list of versions and make it possible to =
create instances based on a version, I would rather use a directory =
structure for that, i.e. (replacing cat with ls):

$ ls =
/sys/bus/pci/devices/0000\:00\:02.0/mdev_supported_types/i915-GVTg_V5_4/ve=
rsion
 5.0
 5.1
 5.2

where each version is a directory that has its own available_instances, =
device_api, description, create, =E2=80=A6

$ echo 83b8f4f2-509f-382f-3c1e-e6bfe0fa1001 > =
/sys/bus/pci/devices/0000\:00\:02.0/mdev_supported_types/i915-GVTg_V5_4/ve=
rsion/5.1/create

In addition to not having the problem of two consecutive writes to =
distinct files, I can imagine contrived cases where available_instances =
might depend on the version=E2=80=A6


Thanks
Christophe

>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    =
https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            =
https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    =
https://www.instagram.com/dberrange :|
