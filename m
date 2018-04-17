Received: from eggs.gnu.org ([2001:4830:134:3::10]:49146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1f8Rh1-0000Di-FB
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 10:34:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1f8Rgy-0001l3-9l
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 10:34:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1f8Rgy-0001kj-2v
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 10:34:44 -0400
Date: Tue, 17 Apr 2018 08:34:34 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180417083434.7a0ec81c@w520.home>
In-Reply-To: <01FDBDDE256B79498DC57789713132D46A18E8D0@SHSMSX101.ccr.corp.intel.com>
References: <1523340193-9024-1-git-send-email-yulei.zhang@intel.com>
	<20180416143745.3cb868d9@w520.home>
	<01FDBDDE256B79498DC57789713132D46A18E8D0@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH V4 3/4] vfio: Add SaveVMHanlders for
 VFIO device to support live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Zhang, Yulei" <yulei.zhang@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Tian, Kevin" <kevin.tian@intel.com>, "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>, "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "Wang, Zhi A" <zhi.a.wang@intel.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "quintela@redhat.com" <quintela@redhat.com>

On Tue, 17 Apr 2018 08:11:12 +0000
"Zhang, Yulei" <yulei.zhang@intel.com> wrote:

> > -----Original Message-----
> > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > Sent: Tuesday, April 17, 2018 4:38 AM
> > To: Zhang, Yulei <yulei.zhang@intel.com>
> > Cc: qemu-devel@nongnu.org; Tian, Kevin <kevin.tian@intel.com>;
> > joonas.lahtinen@linux.intel.com; zhenyuw@linux.intel.com;
> > kwankhede@nvidia.com; Wang, Zhi A <zhi.a.wang@intel.com>;
> > dgilbert@redhat.com; quintela@redhat.com
> > Subject: Re: [RFC PATCH V4 3/4] vfio: Add SaveVMHanlders for VFIO device
> > to support live migration
> > 
> > On Tue, 10 Apr 2018 14:03:13 +0800
> > Yulei Zhang <yulei.zhang@intel.com> wrote:
> >   
> > > Instead of using vm state description, add SaveVMHandlers for VFIO
> > > device to support live migration.
> > >
> > > Introduce new Ioctl VFIO_DEVICE_GET_DIRTY_BITMAP to fetch the  
> > memory  
> > > bitmap that dirtied by vfio device during the iterative precopy stage
> > > to shorten the system downtime afterward.
> > >
> > > For vfio pci device status migrate, during the system downtime, it
> > > will save the following states 1. pci configuration space addr0~addr5
> > > 2. pci configuration space msi_addr msi_data 3. pci device status
> > > fetch from device driver
> > >
> > > And on the target side the vfio_load will restore the same states 1.
> > > re-setup the pci bar configuration 2. re-setup the pci device msi
> > > configuration 3. restore the pci device status  
> > 
> > Interrupts are configured via ioctl, but I don't see any code here to configure
> > the device into the correct interrupt state.  How do we know the target
> > device is compatible with the source device?  Do we rely on the vendor
> > driver to implicitly include some kind of device and version information and
> > fail at the very end of the migration?  It seems like we need to somehow
> > front-load that sort of device compatibility checking since a vfio-pci device
> > can be anything (ex. what happens if a user tries to migrate a GVT-g vGPU to
> > an NVIDIA vGPU?).  Thanks,
> > 
> > Alex  
> 
> We emulate the write to the pci configure space in vfio_load() which will help
> setup the interrupt state. 

But you're only doing that for MSI, not MSI-X, we cannot simply say
that we don't have an MSI-X devices right now and add it later or we'll
end up with incompatible vmstate, we need to plan for how we'll support
it within the save state stream now.

> For compatibility I think currently the vendor driver would put version number 
> or device specific info in the device state region, so during the pre-copy stage
> the target side will discover the difference and call off the migration.

Those sorts of things should be built into the device state region, we
shouldn't rely on vendor drivers to make these kinds of considerations,
we should build it into the API, which also allows QEMU to check state
compatibility before attempting a migration.  Thanks,

Alex
