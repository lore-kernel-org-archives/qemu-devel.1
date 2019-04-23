Received: from eggs.gnu.org ([209.51.188.92]:37211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hIvif-000263-R0
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 09:44:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hIvie-0006uX-Br
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 09:44:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43106)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hIvie-0006tb-2a
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 09:44:20 -0400
Date: Tue, 23 Apr 2019 14:44:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190423134400.GL6022@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190419083258.19580-1-yan.y.zhao@intel.com>
	<20190419083505.19654-1-yan.y.zhao@intel.com>
	<20190423103939.GF6022@redhat.com>
	<20190423063540.7ec83c31@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190423063540.7ec83c31@x1.home>
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
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>, intel-gvt-dev@lists.freedesktop.org, cjia@nvidia.com, kvm@vger.kernel.org, aik@ozlabs.ru, Zhengxiao.zx@alibaba-inc.com, shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, kwankhede@nvidia.com, eauger@redhat.com, yi.l.liu@intel.com, eskultet@redhat.com, ziye.yang@intel.com, mlevitsk@redhat.com, pasic@linux.ibm.com, libvir-list@redhat.com, arei.gonglei@huawei.com, felipe@nutanix.com, Ken.Xue@amd.com, kevin.tian@intel.com, dgilbert@redhat.com, zhenyuw@linux.intel.com, changpeng.liu@intel.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, zhi.a.wang@intel.com, jonathan.davies@nutanix.com, shaopeng.he@intel.com

On Tue, Apr 23, 2019 at 06:35:40AM -0600, Alex Williamson wrote:
> On Tue, 23 Apr 2019 11:39:39 +0100
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
>=20
> > On Fri, Apr 19, 2019 at 04:35:04AM -0400, Yan Zhao wrote:
> > > +* version
> > > +
> > > +  This attribute is rw. It is used to check whether two devices ar=
e compatible
> > > +  for live migration. If this attribute is missing, then the corre=
sponding mdev
> > > +  device is regarded as not supporting live migration.
> > > +
> > > +  It consists of two parts: common part and vendor proprietary par=
t.
> > > +  common part: 32 bit. lower 16 bits is vendor id and higher 16 bi=
ts identifies
> > > +               device type. e.g., for pci device, it is
> > > +               "pci vendor id" | (VFIO_DEVICE_FLAGS_PCI << 16).
> > > +  vendor proprietary part: this part is varied in length. vendor d=
river can
> > > +               specify any string to identify a device.
> > > +
> > > +  When reading this attribute, it should show device version strin=
g of the device
> > > +  of type <type-id>. If a device does not support live migration, =
it should
> > > +  return errno.
> > > +  When writing a string to this attribute, it returns errno for in=
compatibility
> > > +  or returns written string length in compatibility case. If a dev=
ice does not
> > > +  support live migration, it always returns errno.
> > > +
> > > +  for example.
> > > +  # cat \
> > > + /sys/bus/pci/devices/0000\:00\:02.0/mdev_supported_types/i915-GVT=
g_V5_2/version
> > > +  00028086-193b-i915-GVTg_V5_2
> > > +
> > > +  #echo 00028086-193b-i915-GVTg_V5_2 > \
> > > + /sys/bus/pci/devices/0000\:00\:02.0/mdev_supported_types/i915-GVT=
g_V5_4/version
> > > + -bash: echo: write error: Invalid argument
> > > + =20
> >=20
> > IIUC this path is against the physical device. IOW, the mgmt app woul=
d have
> > to first write to the "version" file to choose a version, and then wr=
ite to
> > the "create" file to actually create an virtual device. This has the =
obvious
> > concurrency problem if multiple devices are being created at the same=
 time
> > and distinct versions for each device are required. There would need =
to be
> > a locking scheme defined to ensure safety.
>=20
> "Create a device of a given version" is not an intended feature of this
> interface aiui.  Writing the version attribute only indicates
> migration compatibility with a binary result.
> =20
> > Wouldn't it be better if we can pass the desired version when we writ=
e to
> > the "create" file, so that we avoid any concurrent usage problems. "v=
ersion"
> > could be just a read-only file with a *list* of supported versions.
> >=20
> > eg
> >=20
> >   $ cat /sys/bus/pci/devices/0000\:00\:02.0/mdev_supported_types/i915=
-GVTg_V5_4/version
> >   5.0
> >   5.1
> >   5.2
> >=20
> >   $ echo "83b8f4f2-509f-382f-3c1e-e6bfe0fa1001;version=3D5.2" >
> >       /sys/devices/virtual/mtty/mtty/mdev_supported_types/mtty-2/crea=
te
>=20
> This is reminiscent of the proposed aggregation support, but again,
> this sort of feature is not intended here.  It's no expected that any
> vendor driver would support creating device types of different
> versions, but they may support migration from different versions.

Hmm, that's a subtle distinction I wasn't seeing the patch series.
IIUC from what you're saying, a device can be created with version
"C", but for an incoming migration it can (potentially) accept
serialized state matching any of versions "A", "B" or "C".

That is sufficient if migration is being used as a host upgrade
tool, to move from OS release N to N + 1.

It wouldn't cover the case where you need to support backwards
migration too. eg if you have a mixture of hosts with release
N and N + 1 and want to make sure that VMs can always move
betweeen any host.  That would require that you can create
mdevs with the lowest common denominator version, not solely
the most recent.

In QEMU this is done by mgmt applications picking a versioned
machine type for QEMU that is older than most recent.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
