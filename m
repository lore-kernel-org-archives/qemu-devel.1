Received: from eggs.gnu.org ([2001:4830:134:3::10]:56219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1f8YHK-0004Xj-7k
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 17:36:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1f8YHG-0003ZQ-MH
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 17:36:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1f8YHG-0003OG-86
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 17:36:38 -0400
Date: Tue, 17 Apr 2018 15:36:29 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180417153629.56c0c59f@w520.home>
In-Reply-To: <7540c3bb-2cfa-6f1b-4e9c-a8e07d71226a@nvidia.com>
References: <1523340177-8975-1-git-send-email-yulei.zhang@intel.com>
	<d9da5967-e44f-d0a4-3f8a-375f640e56d2@nvidia.com>
	<20180416142328.18fbe5f6@w520.home>
	<01FDBDDE256B79498DC57789713132D46A18F6E9@SHSMSX101.ccr.corp.intel.com>
	<20180417084344.7a241a9e@w520.home>
	<e9039b4e-7f3d-7a82-ff38-14c57da6ea31@nvidia.com>
	<20180417140903.48947258@w520.home>
	<7540c3bb-2cfa-6f1b-4e9c-a8e07d71226a@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH V4 2/4] vfio: Add vm status change
 callback to stop/restart the mdev device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kirti Wankhede <kwankhede@nvidia.com>
Cc: "Zhang, Yulei" <yulei.zhang@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Tian, Kevin" <kevin.tian@intel.com>, "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>, "Wang, Zhi A" <zhi.a.wang@intel.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "quintela@redhat.com" <quintela@redhat.com>

On Wed, 18 Apr 2018 02:41:44 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> On 4/18/2018 1:39 AM, Alex Williamson wrote:
> > On Wed, 18 Apr 2018 00:44:35 +0530
> > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >   
> >> On 4/17/2018 8:13 PM, Alex Williamson wrote:  
> >>> On Tue, 17 Apr 2018 13:40:32 +0000
> >>> "Zhang, Yulei" <yulei.zhang@intel.com> wrote:
> >>>     
> >>>>> -----Original Message-----
> >>>>> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> >>>>> Sent: Tuesday, April 17, 2018 4:23 AM
> >>>>> To: Kirti Wankhede <kwankhede@nvidia.com>
> >>>>> Cc: Zhang, Yulei <yulei.zhang@intel.com>; qemu-devel@nongnu.org; Tian,
> >>>>> Kevin <kevin.tian@intel.com>; joonas.lahtinen@linux.intel.com;
> >>>>> zhenyuw@linux.intel.com; Wang, Zhi A <zhi.a.wang@intel.com>;
> >>>>> dgilbert@redhat.com; quintela@redhat.com
> >>>>> Subject: Re: [RFC PATCH V4 2/4] vfio: Add vm status change callback to
> >>>>> stop/restart the mdev device
> >>>>>
> >>>>> On Mon, 16 Apr 2018 20:14:27 +0530
> >>>>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >>>>>       
> >>>>>> On 4/10/2018 11:32 AM, Yulei Zhang wrote:      
> >>>>>>> VM status change handler is added to change the vfio pci device
> >>>>>>> status during the migration, write the demanded device status
> >>>>>>> to the DEVICE STATUS subregion to stop the device on the source side
> >>>>>>> before fetch its status and start the deivce on the target side
> >>>>>>> after restore its status.
> >>>>>>>
> >>>>>>> Signed-off-by: Yulei Zhang <yulei.zhang@intel.com>
> >>>>>>> ---
> >>>>>>>  hw/vfio/pci.c                 | 20 ++++++++++++++++++++
> >>>>>>>  include/hw/vfio/vfio-common.h |  1 +
> >>>>>>>  linux-headers/linux/vfio.h    |  6 ++++++
> >>>>>>>  roms/seabios                  |  2 +-
> >>>>>>>  4 files changed, 28 insertions(+), 1 deletion(-)
> >>>>>>>
> >>>>>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> >>>>>>> index f98a9dd..13d8c73 100644
> >>>>>>> --- a/hw/vfio/pci.c
> >>>>>>> +++ b/hw/vfio/pci.c
> >>>>>>> @@ -38,6 +38,7 @@
> >>>>>>>
> >>>>>>>  static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
> >>>>>>>  static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
> >>>>>>> +static void vfio_vm_change_state_handler(void *pv, int running,      
> >>>>> RunState state);      
> >>>>>>>
> >>>>>>>  /*
> >>>>>>>   * Disabling BAR mmaping can be slow, but toggling it around INTx can
> >>>>>>> @@ -2896,6 +2897,7 @@ static void vfio_realize(PCIDevice *pdev, Error      
> >>>>> **errp)      
> >>>>>>>      vfio_register_err_notifier(vdev);
> >>>>>>>      vfio_register_req_notifier(vdev);
> >>>>>>>      vfio_setup_resetfn_quirk(vdev);
> >>>>>>> +      
> >>>>> qemu_add_vm_change_state_handler(vfio_vm_change_state_handler,
> >>>>> vdev);      
> >>>>>>>
> >>>>>>>      return;
> >>>>>>>
> >>>>>>> @@ -2982,6 +2984,24 @@ post_reset:
> >>>>>>>      vfio_pci_post_reset(vdev);
> >>>>>>>  }
> >>>>>>>
> >>>>>>> +static void vfio_vm_change_state_handler(void *pv, int running,      
> >>>>> RunState state)      
> >>>>>>> +{
> >>>>>>> +    VFIOPCIDevice *vdev = pv;
> >>>>>>> +    VFIODevice *vbasedev = &vdev->vbasedev;
> >>>>>>> +    uint8_t dev_state;
> >>>>>>> +    uint8_t sz = 1;
> >>>>>>> +
> >>>>>>> +    dev_state = running ? VFIO_DEVICE_START : VFIO_DEVICE_STOP;
> >>>>>>> +
> >>>>>>> +    if (pwrite(vdev->vbasedev.fd, &dev_state,
> >>>>>>> +               sz, vdev->device_state.offset) != sz) {
> >>>>>>> +        error_report("vfio: Failed to %s device", running ? "start" : "stop");
> >>>>>>> +        return;
> >>>>>>> +    }
> >>>>>>> +
> >>>>>>> +    vbasedev->device_state = dev_state;
> >>>>>>> +}
> >>>>>>> +      
> >>>>>>
> >>>>>> Is it expected to trap device_state region by vendor driver?
> >>>>>> Can this information be communicated to vendor driver through an ioctl?      
> >>>>>
> >>>>> Either the mdev vendor driver or vfio bus driver (ie. vfio-pci) would
> >>>>> be providing REGION_INFO for this region, so the vendor driver is
> >>>>> already in full control here using existing ioctls.  I don't see that
> >>>>> we need new ioctls, we just need to fully define the API of the
> >>>>> proposed regions here.
> >>>>>       
> >>>> If the device state region is mmaped, we may not be able to use
> >>>> region device state offset to convey the running state. It may need
> >>>> a new ioctl to set the device state.    
> >>>
> >>> The vendor driver defines the mmap'ability of the region, the vendor
> >>> driver is still in control.  The API of the region and the
> >>> implementation by the vendor driver should account for handling
> >>> mmap'able sections within the region.  Thanks,
> >>>
> >>> Alex
> >>>
> >>>      
> >>
> >> If this same region should be used for communicating state or other
> >> parameters instead of ioctl, may be first page of this region need to be
> >> reserved. Mmappable region's start address should be page aligned. Is
> >> this API going to utilize 4K of the reserved part of this region?
> >> Instead of carving out part of section from the region, are there any
> >> disadvantages of adding an ioctl?
> >> May be defining a single ioctl and using different flags (GET_*/SET_*)
> >> would work?  
> > 
> > Yes, ioctls are something that should be feared and reviewed with great
> > scrutiny and we should feel bad if we do a poor job defining them and
> > burn ioctl numbers whereas we have 32bits worth of region sub-types
> > and 31 bits of region types to churn through within our own address
> > space and we can easily deprecate losing designs without much harm.  
> 
> Makes sense.
> 
> > Thus, I want to see that an ioctl is really the best way to perform the
> > task rather than just being the default answer to everything.  Is it
> > really a problem if data starts at some offset into the region?   
> 
> remap_pfn_range() or remap_vmalloc_range() expects target user address
> and physical address of kernel memory to be page aligned. Mappable
> region's start address should be page aligned.

Sure, but whether to support mmap of the save region is a property of
the vendor driver.

>  That
> > sounds like part of the region API that I want to see defined.  The
> > region can start with a header containing explicit save state version
> > and device information, writable registers for relaying state
> > information, an offset to the start of the vendor data field, etc.  If
> > we can make a GPU work via a definition of registers and doorbells and
> > framebuffers in an MMIO region then surely we can figure out a virtual
> > register and buffer definition to do save and restore of the device.  
> 
> All these regions mmapped are page aligned.
> 
> > Otherwise, why is an ioctl the best tool for this task?
> >   
> 
> I agree that maintaining ioctl is difficult and burning ioctl number
> problem.
> So lets reserve first page and start defining API, then we can know how
> much from 4K will be consumed for the APIs.

Or rather define the API to include a start offset in the header so the
vendor driver can choose whatever it wants/needs and we aren't tied to
x86 PAGE_SIZE.

> >>>>>> Here only device state is conveyed to vendor driver but knowing
> >>>>>> 'RunState' in vendor driver is very useful and vendor driver can take
> >>>>>> necessary action accordingly like RUN_STATE_PAUSED indicating that VM      
> >>>>> is      
> >>>>>> in paused state, similarly RUN_STATE_SUSPENDED,
> >>>>>> RUN_STATE_FINISH_MIGRATE, RUN_STATE_IO_ERROR. If these states are
> >>>>>> handled properly, all the cases can be supported with same interface
> >>>>>> like VM suspend-resume, VM pause-restore.      
> >>>>>
> >>>>> I agree, but let's remember that we're talking about device state, not
> >>>>> VM state.  vfio is a userspace device interface, not specifically a
> >>>>> virtual machine interface, so states should be in terms of the device.
> >>>>> The API of this region needs to be clearly defined and using only 1
> >>>>> byte at the start of the region is not very forward looking.  Thanks,
> >>>>>
> >>>>> Alex
> >>>>>       
> >>
> >> Sorry for using wrong term in my previous reply, 'RunState' is actually
> >> CPU state and not VM state. In terms of vfio device interface knowing
> >> CPU state would be helpful, right?  
> > 
> > Why?  CPU state is describing something disassociated with the device.
> > QEMU will interpret the CPU state into something it wants the device to
> > do.  The VFIO interface should be defined in terms of the state you
> > want to impose on the device.  What the CPU is doing is not the device's
> > problem.  Make sense?  Thanks,  
> 
> CPU state does help to take action in pre-copy phase in different cases.
> Like in save VM case and suspend VM case, during pre-copy phase CPU is
> in RUN_STATE_PAUSED / RUN_STATE_SUSPENDED state while in case of live
> migration during pre-copy phase CPU is RUN_STATE_RUNNING state. In
> pre-copy phase if CPU is already paused then this phase can be skipped
> by returning pending bytes as 0 because nothing is going to be dirtied
> after CPUs are paused and transfer all device state in stop-and-copy phase.

I don't understand what's so difficult about redefining these in terms
of the device.  You want some sort of live device state if the CPU is
running and a way to freeze the device and get differences or whatever
when it's frozen.  QEMU can map CPU state to device state.  I'm just
asking that we not define the vfio device state interface in terms of a
VM or CPU state, translate it what it means for the device state.
Thanks,

Alex
