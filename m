Received: from eggs.gnu.org ([2001:4830:134:3::10]:37906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f8l6X-0004Wf-2p
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 07:18:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f8l6S-0005Uq-Vj
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 07:18:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55994 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1f8l6S-0005UT-Pd
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 07:18:20 -0400
Date: Wed, 18 Apr 2018 12:18:08 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180418111807.GE2710@work-vm>
References: <1523340193-9024-1-git-send-email-yulei.zhang@intel.com>
	<20180416143745.3cb868d9@w520.home>
	<01FDBDDE256B79498DC57789713132D46A18E8D0@SHSMSX101.ccr.corp.intel.com>
	<20180417083434.7a0ec81c@w520.home>
	<01FDBDDE256B79498DC57789713132D46A193FFB@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01FDBDDE256B79498DC57789713132D46A193FFB@SHSMSX101.ccr.corp.intel.com>
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
Cc: Alex Williamson <alex.williamson@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Tian, Kevin" <kevin.tian@intel.com>, "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>, "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "Wang, Zhi A" <zhi.a.wang@intel.com>, "quintela@redhat.com" <quintela@redhat.com>

* Zhang, Yulei (yulei.zhang@intel.com) wrote:
> 
> 
> > -----Original Message-----
> > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > Sent: Tuesday, April 17, 2018 10:35 PM
> > To: Zhang, Yulei <yulei.zhang@intel.com>
> > Cc: qemu-devel@nongnu.org; Tian, Kevin <kevin.tian@intel.com>;
> > joonas.lahtinen@linux.intel.com; zhenyuw@linux.intel.com;
> > kwankhede@nvidia.com; Wang, Zhi A <zhi.a.wang@intel.com>;
> > dgilbert@redhat.com; quintela@redhat.com
> > Subject: Re: [RFC PATCH V4 3/4] vfio: Add SaveVMHanlders for VFIO device
> > to support live migration
> > 
> > On Tue, 17 Apr 2018 08:11:12 +0000
> > "Zhang, Yulei" <yulei.zhang@intel.com> wrote:
> > 
> > > > -----Original Message-----
> > > > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > > > Sent: Tuesday, April 17, 2018 4:38 AM
> > > > To: Zhang, Yulei <yulei.zhang@intel.com>
> > > > Cc: qemu-devel@nongnu.org; Tian, Kevin <kevin.tian@intel.com>;
> > > > joonas.lahtinen@linux.intel.com; zhenyuw@linux.intel.com;
> > > > kwankhede@nvidia.com; Wang, Zhi A <zhi.a.wang@intel.com>;
> > > > dgilbert@redhat.com; quintela@redhat.com
> > > > Subject: Re: [RFC PATCH V4 3/4] vfio: Add SaveVMHanlders for VFIO
> > device
> > > > to support live migration
> > > >
> > > > On Tue, 10 Apr 2018 14:03:13 +0800
> > > > Yulei Zhang <yulei.zhang@intel.com> wrote:
> > > >
> > > > > Instead of using vm state description, add SaveVMHandlers for VFIO
> > > > > device to support live migration.
> > > > >
> > > > > Introduce new Ioctl VFIO_DEVICE_GET_DIRTY_BITMAP to fetch the
> > > > memory
> > > > > bitmap that dirtied by vfio device during the iterative precopy stage
> > > > > to shorten the system downtime afterward.
> > > > >
> > > > > For vfio pci device status migrate, during the system downtime, it
> > > > > will save the following states 1. pci configuration space addr0~addr5
> > > > > 2. pci configuration space msi_addr msi_data 3. pci device status
> > > > > fetch from device driver
> > > > >
> > > > > And on the target side the vfio_load will restore the same states 1.
> > > > > re-setup the pci bar configuration 2. re-setup the pci device msi
> > > > > configuration 3. restore the pci device status
> > > >
> > > > Interrupts are configured via ioctl, but I don't see any code here to
> > configure
> > > > the device into the correct interrupt state.  How do we know the target
> > > > device is compatible with the source device?  Do we rely on the vendor
> > > > driver to implicitly include some kind of device and version information
> > and
> > > > fail at the very end of the migration?  It seems like we need to somehow
> > > > front-load that sort of device compatibility checking since a vfio-pci
> > device
> > > > can be anything (ex. what happens if a user tries to migrate a GVT-g
> > vGPU to
> > > > an NVIDIA vGPU?).  Thanks,
> > > >
> > > > Alex
> > >
> > > We emulate the write to the pci configure space in vfio_load() which will
> > help
> > > setup the interrupt state.
> > 
> > But you're only doing that for MSI, not MSI-X, we cannot simply say
> > that we don't have an MSI-X devices right now and add it later or we'll
> > end up with incompatible vmstate, we need to plan for how we'll support
> > it within the save state stream now.
> > 
> Agree with u. 
> 
> > > For compatibility I think currently the vendor driver would put version
> > number
> > > or device specific info in the device state region, so during the pre-copy
> > stage
> > > the target side will discover the difference and call off the migration.
> > 
> > Those sorts of things should be built into the device state region, we
> > shouldn't rely on vendor drivers to make these kinds of considerations,
> > we should build it into the API, which also allows QEMU to check state
> > compatibility before attempting a migration.  Thanks,
> > 
> > Alex
> 
> Not sure about how to check the compatibility before attempting a migration,
> to my understanding, qemu doesn't know the configuration on target side,
> target may call off the migration when it finds the input device state isn't compatible,
> and source vm will resume.

There are a few parts to this:
   a) Tools, like libvirt etc need to be able to detect that the two
configurations are actually compatible before they try - so there should
be some way of exposing enough detail about the host/drivers for
something somewhere to be able to say 'yes it should work' before even
starting the migration.

   b) The migration stream should contain enough information to be able
to *cleanly* detect an incompatibility so that the failure is obvious;
so make sure you have enough information in there (preferably in the
'setup' part if it really is iterative).  Then when loading check that
data and print a clear reason why it's incompatible.

   c) We've got to try and keep that compatibility across versions - so
migrations to a newer QEMU, or newer drivers (or depending on the
hardware) to newer hardware should be able to work if possible.  So the
stream might need to have version identifiers in to help with that.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
