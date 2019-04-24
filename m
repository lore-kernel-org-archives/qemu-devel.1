Received: from eggs.gnu.org ([209.51.188.92]:56100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cjia@nvidia.com>) id 1hJ9My-0005Uf-T4
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 00:18:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cjia@nvidia.com>) id 1hJ9Mx-0005PI-Ml
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 00:18:52 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:15558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cjia@nvidia.com>) id 1hJ9Mx-0005K5-6o
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 00:18:51 -0400
Date: Tue, 23 Apr 2019 21:13:41 -0700
From: Neo Jia <cjia@nvidia.com>
Message-ID: <20190424041340.GA5498@nvidia.com>
References: <20190419083258.19580-1-yan.y.zhao@intel.com>
	<20190419083505.19654-1-yan.y.zhao@intel.com>
	<20190423103939.GF6022@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190423103939.GF6022@redhat.com>
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
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>, intel-gvt-dev@lists.freedesktop.org, kvm@vger.kernel.org, aik@ozlabs.ru, Zhengxiao.zx@alibaba-inc.com, shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, kwankhede@nvidia.com, eauger@redhat.com, yi.l.liu@intel.com, eskultet@redhat.com, ziye.yang@intel.com, mlevitsk@redhat.com, pasic@linux.ibm.com, libvir-list@redhat.com, arei.gonglei@huawei.com, felipe@nutanix.com, Ken.Xue@amd.com, kevin.tian@intel.com, dgilbert@redhat.com, zhenyuw@linux.intel.com, alex.williamson@redhat.com, changpeng.liu@intel.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, zhi.a.wang@intel.com, jonathan.davies@nutanix.com, shaopeng.he@intel.com

On Tue, Apr 23, 2019 at 11:39:39AM +0100, Daniel P. Berrang=E9 wrote:
> On Fri, Apr 19, 2019 at 04:35:04AM -0400, Yan Zhao wrote:
> > device version attribute in mdev sysfs is used by user space software
> > (e.g. libvirt) to query device compatibility for live migration of VFIO
> > mdev devices. This attribute is mandatory if a mdev device supports liv=
e
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
> > When reading this attribute, it should show device version string of th=
e
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
> > Then, user space software writes the source side returned version strin=
g
> > to device version attribute in target side, and checks the return value=
.
> > If a negative errno is returned in the target side, then mdev devices i=
n
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
> > -bash: echo: write error: Invalid argument
>=20
> What you have written here seems to imply that each mdev type is able to
> support many different versions at the same time. Writing a version into
> this sysfs file then chooses which of the many versions to actually use.
>=20
> This is good as it allows for live migration across driver software upgra=
des.
>=20
> A mgmt application may well want to know what versions are supported for =
an
> mdev type *before* starting a migration. A mgmt app can query all the 100=
's
> of hosts it knows and thus figure out which are valid to use as the targe=
t
> of a migration.
>=20
> IOW, we want to avoid the ever hitting the incompatibility case in the
> first place, by only choosing to migrate to a host that we know is going
> to be compatible.
>=20
> This would need some kind of way to report the full list of supported
> versions against the mdev supported types on the host.

What would be the typical scenario / use case for mgmt layer to query the v=
ersion
information? Do they expect this get done completely offline as long as the
vendor driver installed on each host?

Thanks,
Neo

>=20
>=20
