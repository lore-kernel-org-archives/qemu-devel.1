Received: from eggs.gnu.org ([209.51.188.92]:49361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hAxqC-0000PD-RO
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:23:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hAxqB-00030O-1Q
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:23:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1hAxq9-0002y8-Dp
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:23:09 -0400
Date: Mon, 1 Apr 2019 08:15:26 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190401081526.5f50d160@x1.home>
In-Reply-To: <20190401084003.GA1530@joy-OptiPlex-7040>
References: <1550566254-3545-1-git-send-email-yan.y.zhao@intel.com>
	<20190219113212.GC2941@work-vm>
	<20190220052838.GC16456@joy-OptiPlex-7040>
	<20190220110142.GD2608@work-vm>
	<33183CC9F5247A488A2544077AF19020DB25D30F@dggeml511-mbx.china.huawei.com>
	<20190220124242.5a1685c5.cohuck@redhat.com>
	<20190327063509.GD14681@joy-OptiPlex-7040>
	<20190327201854.GG2636@work-vm> <20190327161020.1c013e65@x1.home>
	<20190401101430.72d2ef9e.cohuck@redhat.com>
	<20190401084003.GA1530@joy-OptiPlex-7040>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/5] QEMU VFIO live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Cornelia Huck <cohuck@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "cjia@nvidia.com" <cjia@nvidia.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "aik@ozlabs.ru" <aik@ozlabs.ru>, "Zhengxiao.zx@alibaba-inc.com" <Zhengxiao.zx@alibaba-inc.com>, "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "eauger@redhat.com" <eauger@redhat.com>, "Liu, Yi
	L" <yi.l.liu@intel.com>, "eskultet@redhat.com" <eskultet@redhat.com>, "Yang, Ziye" <ziye.yang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "felipe@nutanix.com" <felipe@nutanix.com>, "Wang, Zhi A" <zhi.a.wang@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, "intel-gvt-dev@lists.freedesktop.org" <intel-gvt-dev@lists.freedesktop.org>, "Liu, Changpeng" <changpeng.liu@intel.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>, "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>

On Mon, 1 Apr 2019 04:40:03 -0400
Yan Zhao <yan.y.zhao@intel.com> wrote:

> On Mon, Apr 01, 2019 at 04:14:30PM +0800, Cornelia Huck wrote:
> > On Wed, 27 Mar 2019 16:10:20 -0600
> > Alex Williamson <alex.williamson@redhat.com> wrote:
> >   
> > > On Wed, 27 Mar 2019 20:18:54 +0000
> > > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > >   
> > > > * Zhao Yan (yan.y.zhao@intel.com) wrote:    
> > > > > On Wed, Feb 20, 2019 at 07:42:42PM +0800, Cornelia Huck wrote:      
> > > > > > > > > >   b) How do we detect if we're migrating from/to the wrong device or
> > > > > > > > > > version of device?  Or say to a device with older firmware or perhaps
> > > > > > > > > > a device that has less device memory ?        
> > > > > > > > > Actually it's still an open for VFIO migration. Need to think about
> > > > > > > > > whether it's better to check that in libvirt or qemu (like a device magic
> > > > > > > > > along with verion ?).        
> > > > > > > 
> > > > > > > We must keep the hardware generation is the same with one POD of public cloud
> > > > > > > providers. But we still think about the live migration between from the the lower
> > > > > > > generation of hardware migrated to the higher generation.      
> > > > > > 
> > > > > > Agreed, lower->higher is the one direction that might make sense to
> > > > > > support.
> > > > > > 
> > > > > > But regardless of that, I think we need to make sure that incompatible
> > > > > > devices/versions fail directly instead of failing in a subtle, hard to
> > > > > > debug way. Might be useful to do some initial sanity checks in libvirt
> > > > > > as well.
> > > > > > 
> > > > > > How easy is it to obtain that information in a form that can be
> > > > > > consumed by higher layers? Can we find out the device type at least?
> > > > > > What about some kind of revision?      
> > > > > hi Alex and Cornelia
> > > > > for device compatibility, do you think it's a good idea to use "version"
> > > > > and "device version" fields?
> > > > > 
> > > > > version field: identify live migration interface's version. it can have a
> > > > > sort of backward compatibility, like target machine's version >= source
> > > > > machine's version. something like that.    
> > > 
> > > Don't we essentially already have this via the device specific region?
> > > The struct vfio_info_cap_header includes id and version fields, so we
> > > can declare a migration id and increment the version for any
> > > incompatible changes to the protocol.
> > >   
> > > > > 
> > > > > device_version field consists two parts:
> > > > > 1. vendor id : it takes 32 bits. e.g. 0x8086.    
> > > 
> > > Who allocates IDs?  If we're going to use PCI vendor IDs, then I'd
> > > suggest we use a bit to flag it as such so we can reserve that portion
> > > of the 32bit address space.  See for example:
> > > 
> > > #define VFIO_REGION_TYPE_PCI_VENDOR_TYPE        (1 << 31)
> > > #define VFIO_REGION_TYPE_PCI_VENDOR_MASK        (0xffff)
> > > 
> > > For vendor specific regions.  
> > 
> > Just browsing through the thread... if I don't misunderstand, we could
> > use a vfio-ccw region type id here for ccw, couldn't we? Just to make
> > sure that this is not pci-specific.  
> CCW could use another bit other than bit 31?
> e.g.
> #define VFIO_REGION_TYPE_CCW_VENDOR_TYPE        (1 << 30)
> then ccw device use (VFIO_REGION_TYPE_CCW_VENDOR_TYPE | vendor id) as its
> first 32 bit for device version string.
> 
> But as Alex said we'll not provide an extra region to get device version,
> and device version is only exported in sysfs, probably we should define them as
> below:
> #define VFIO_DEVICE_VERSION_TYPE_PCI (1<<31)
> #define VFIO_DEVICE_VERSION_TYPE_CCW (1<<30)
> 
> Do you think it's ok?

We already had this discussion for device specific regions and decided
that CCW doesn't have enough vendors to justify a full subset of the
available address space.  Also, this doesn't need to imply the device
interface, we're simply specifying a vendor registrar such that we can
give each vendor their own namespace, so I don't think it would be a
problem for a CCW to specify a namespace using a PCI vendor ID.
Finally, if we have such need for this in the future, because I'm not
sure where we stand with this in the current proposals, maybe we should
make use of an IEEE OUI rather than a PCI database to avoid this sort
of confusion and mis-association if we have further need.  Thanks,

Alex
