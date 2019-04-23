Received: from eggs.gnu.org ([209.51.188.92]:52901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hIwrZ-0003uY-O3
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:57:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hIwrX-000062-MY
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:57:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hIwrU-0008V7-C1
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:57:33 -0400
Date: Tue, 23 Apr 2019 15:57:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190423145708.GP6022@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190419083258.19580-1-yan.y.zhao@intel.com>
	<20190419083505.19654-1-yan.y.zhao@intel.com>
	<20190423103939.GF6022@redhat.com>
	<20190423063540.7ec83c31@x1.home>
	<20190423134400.GL6022@redhat.com>
	<20190423084852.62168bb2@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190423084852.62168bb2@x1.home>
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

On Tue, Apr 23, 2019 at 08:48:52AM -0600, Alex Williamson wrote:
> On Tue, 23 Apr 2019 14:44:00 +0100
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
>=20
> > On Tue, Apr 23, 2019 at 06:35:40AM -0600, Alex Williamson wrote:
> > > On Tue, 23 Apr 2019 11:39:39 +0100
> > > Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> > >  =20
> > > > On Fri, Apr 19, 2019 at 04:35:04AM -0400, Yan Zhao wrote: =20
> > > > > +* version
> > > > > +
> > > > > +  This attribute is rw. It is used to check whether two device=
s are compatible
> > > > > +  for live migration. If this attribute is missing, then the c=
orresponding mdev
> > > > > +  device is regarded as not supporting live migration.
> > > > > +
> > > > > +  It consists of two parts: common part and vendor proprietary=
 part.
> > > > > +  common part: 32 bit. lower 16 bits is vendor id and higher 1=
6 bits identifies
> > > > > +               device type. e.g., for pci device, it is
> > > > > +               "pci vendor id" | (VFIO_DEVICE_FLAGS_PCI << 16)=
.
> > > > > +  vendor proprietary part: this part is varied in length. vend=
or driver can
> > > > > +               specify any string to identify a device.
> > > > > +
> > > > > +  When reading this attribute, it should show device version s=
tring of the device
> > > > > +  of type <type-id>. If a device does not support live migrati=
on, it should
> > > > > +  return errno.
> > > > > +  When writing a string to this attribute, it returns errno fo=
r incompatibility
> > > > > +  or returns written string length in compatibility case. If a=
 device does not
> > > > > +  support live migration, it always returns errno.
> > > > > +
> > > > > +  for example.
> > > > > +  # cat \
> > > > > + /sys/bus/pci/devices/0000\:00\:02.0/mdev_supported_types/i915=
-GVTg_V5_2/version
> > > > > +  00028086-193b-i915-GVTg_V5_2
> > > > > +
> > > > > +  #echo 00028086-193b-i915-GVTg_V5_2 > \
> > > > > + /sys/bus/pci/devices/0000\:00\:02.0/mdev_supported_types/i915=
-GVTg_V5_4/version
> > > > > + -bash: echo: write error: Invalid argument
> > > > > +   =20
> > > >=20
> > > > IIUC this path is against the physical device. IOW, the mgmt app =
would have
> > > > to first write to the "version" file to choose a version, and the=
n write to
> > > > the "create" file to actually create an virtual device. This has =
the obvious
> > > > concurrency problem if multiple devices are being created at the =
same time
> > > > and distinct versions for each device are required. There would n=
eed to be
> > > > a locking scheme defined to ensure safety. =20
> > >=20
> > > "Create a device of a given version" is not an intended feature of =
this
> > > interface aiui.  Writing the version attribute only indicates
> > > migration compatibility with a binary result.
> > >   =20
> > > > Wouldn't it be better if we can pass the desired version when we =
write to
> > > > the "create" file, so that we avoid any concurrent usage problems=
. "version"
> > > > could be just a read-only file with a *list* of supported version=
s.
> > > >=20
> > > > eg
> > > >=20
> > > >   $ cat /sys/bus/pci/devices/0000\:00\:02.0/mdev_supported_types/=
i915-GVTg_V5_4/version
> > > >   5.0
> > > >   5.1
> > > >   5.2
> > > >=20
> > > >   $ echo "83b8f4f2-509f-382f-3c1e-e6bfe0fa1001;version=3D5.2" >
> > > >       /sys/devices/virtual/mtty/mtty/mdev_supported_types/mtty-2/=
create =20
> > >=20
> > > This is reminiscent of the proposed aggregation support, but again,
> > > this sort of feature is not intended here.  It's no expected that a=
ny
> > > vendor driver would support creating device types of different
> > > versions, but they may support migration from different versions. =20
> >=20
> > Hmm, that's a subtle distinction I wasn't seeing the patch series.
> > IIUC from what you're saying, a device can be created with version
> > "C", but for an incoming migration it can (potentially) accept
> > serialized state matching any of versions "A", "B" or "C".
> >=20
> > That is sufficient if migration is being used as a host upgrade
> > tool, to move from OS release N to N + 1.
> >=20
> > It wouldn't cover the case where you need to support backwards
> > migration too. eg if you have a mixture of hosts with release
> > N and N + 1 and want to make sure that VMs can always move
> > betweeen any host.  That would require that you can create
> > mdevs with the lowest common denominator version, not solely
> > the most recent.
> >=20
> > In QEMU this is done by mgmt applications picking a versioned
> > machine type for QEMU that is older than most recent.
>=20
> I suppose we'd need to determine how important that is, this is just a
> device after all, there are always fallback mechanisms via hotplug.
> There are a lot of pieces that need to line up for backwards migration
> including support for it at the individual vendor driver.  Nothing we
> design into the API is going to require vendor drivers to support
> backwards migration and we already have some vendors requiring host and
> guest driver alignment.  Specifying a version with a create syntax as
> you've provided is reasonable, but this also balloons into whole
> tangential interface providing information regarding what versions a
> vendor driver is able to create, because presumably management tools
> wouldn't prefer a try-and-see type interface.  I believe an intentional
> aspect of the proposal here is that we don't need to provide a list of
> compatible versions, that's handled internally to the vendor driver.

Worse is that multi-versions backwards migration also balloons the
testing matrix which is particularly time consuming.

To be clear I'm /not/ saying that multi-versions backwards migration
is a must-have. I just want to be sure we understand the limitations
of what's proposed and that we're happy with them.

Certainly forwards migration is the really big win here.

Backwards migration is more of a nice-to-have and only worth doing if
we expect people are willing to actually do enough testing to make
it reliable. Claiming to support backwards migration and then
never testing it works is even worse than not supporting it, because
it will be a rarely exercised code path comparatively speaking, so
easy to bit-rot if not well tested.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
