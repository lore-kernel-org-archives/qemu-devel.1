Received: from eggs.gnu.org ([209.51.188.92]:48772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hIsbb-0005zu-3e
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:24:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hIsbT-00086J-NY
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:24:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hIsbT-00085E-0K
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:24:43 -0400
Date: Tue, 23 Apr 2019 11:24:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190423102419.GE6022@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190419083258.19580-1-yan.y.zhao@intel.com>
	<20190419083505.19654-1-yan.y.zhao@intel.com>
	<20190422083950.25eb9e7c@x1.home>
	<20190423010152.GC32217@joy-OptiPlex-7040>
	<20190422192100.4d577e4b@x1.home>
	<20190423054157.GA26190@joy-OptiPlex-7040>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190423054157.GA26190@joy-OptiPlex-7040>
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
Cc: Alex Williamson <alex.williamson@redhat.com>, "cjia@nvidia.com" <cjia@nvidia.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "aik@ozlabs.ru" <aik@ozlabs.ru>, "Zhengxiao.zx@alibaba-inc.com" <Zhengxiao.zx@alibaba-inc.com>, "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "eauger@redhat.com" <eauger@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "eskultet@redhat.com" <eskultet@redhat.com>, "Yang, Ziye" <ziye.yang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "libvir-list@redhat.com" <libvir-list@redhat.com>, "arei.gonglei@huawei.com" <arei.gonglei@huawei.com>, "felipe@nutanix.com" <felipe@nutanix.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>, "Tian, Kevin" <kevin.tian@intel.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>, "intel-gvt-dev@lists.freedesktop.org" <intel-gvt-dev@lists.freedesktop.org>, "Liu, Changpeng" <changpeng.liu@intel.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Wang, Zhi A" <zhi.a.wang@intel.com>, "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "He, Shaopeng" <shaopeng.he@intel.com>

On Tue, Apr 23, 2019 at 01:41:57AM -0400, Yan Zhao wrote:
> On Tue, Apr 23, 2019 at 09:21:00AM +0800, Alex Williamson wrote:
> > On Mon, 22 Apr 2019 21:01:52 -0400
> > Yan Zhao <yan.y.zhao@intel.com> wrote:
> > 
> > > On Mon, Apr 22, 2019 at 10:39:50PM +0800, Alex Williamson wrote:
> > > > On Fri, 19 Apr 2019 04:35:04 -0400
> > > > Yan Zhao <yan.y.zhao@intel.com> wrote:
> > > >   
> > > > > device version attribute in mdev sysfs is used by user space software
> > > > > (e.g. libvirt) to query device compatibility for live migration of VFIO
> > > > > mdev devices. This attribute is mandatory if a mdev device supports live
> > > > > migration.  
> > > > 
> > > > The Subject: doesn't quite match what's being proposed here.
> > > >    
> > > > > It consists of two parts: common part and vendor proprietary part.
> > > > > common part: 32 bit. lower 16 bits is vendor id and higher 16 bits
> > > > >              identifies device type. e.g., for pci device, it is
> > > > >              "pci vendor id" | (VFIO_DEVICE_FLAGS_PCI << 16).  
> > > > 
> > > > What purpose does this serve?  If it's intended as some sort of
> > > > namespace feature, shouldn't we first assume that we can only support
> > > > migration to devices of the same type?  Therefore each type would
> > > > already have its own namespace.  Also that would make the trailing bit
> > > > of the version string listed below in the example redundant.  A vendor
> > > > is still welcome to include this in their version string if they wish,
> > > > but I think the string should be entirely vendor defined.
> > > >  
> > > hi Alex,
> > > This common part is a kind of namespace.
> > > Because if version string is entirely defined by vendors, I'm worried about
> > > if there is a case that one vendor's version string happens to deceive and
> > > interfere with another vendor's version checking?
> > > e.g.
> > > vendor A has a version string like: vendor id + device id + mdev type
> > > vendor B has a version string like: device id + vendor id + mdev type
> > > but vendor A's vendor id is 0x8086, device id is 0x1217
> > > vendor B's vendor id is 0x1217, device id is 0x8086.
> > > 
> > > In this corner case, the two vendors may regard the two device is
> > > migratable but actually they are not.
> > > 
> > > That's the reason for this common part that serve as a kind of namespace
> > > that all vendors will comply with to avoid overlap.
> > 
> > If we assume that migration can only occur between matching mdev types,
> > this is redundant, each type already has their own namespace.
> >
> hi Alex,
> do you mean user space software like libvirt needs to first check whether
> mdev type is matching and then check whether version is matching?

I would expect that libvirt (or other mgmt apps) will always first
check that the vendor id, device id, mdev type all match. So for the
version string it should suffice to be a "normal" numeric value.

Essentially version string just needs to be there to distinguish
revisions of the same mdev type over time.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
