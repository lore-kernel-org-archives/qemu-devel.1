Received: from eggs.gnu.org ([2001:4830:134:3::10]:52124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cqOoU-00039K-L1
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 14:47:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cqOoR-0000sF-Qz
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 14:47:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46182)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1cqOoR-0000qp-HZ
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 14:47:19 -0400
Date: Tue, 21 Mar 2017 12:47:16 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170321124716.19f90fd6@t450s.home>
In-Reply-To: <20170317031743.40128-15-bjsdjshi@linux.vnet.ibm.com>
References: <20170317031743.40128-1-bjsdjshi@linux.vnet.ibm.com>
	<20170317031743.40128-15-bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 14/16] docs: add documentation for
 vfio-ccw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com

On Fri, 17 Mar 2017 04:17:41 +0100
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> Add file Documentation/s390/vfio-ccw.txt that includes details
> of vfio-ccw.
> 
> Acked-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> ---
>  Documentation/s390/00-INDEX     |   2 +
>  Documentation/s390/vfio-ccw.txt | 303 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 305 insertions(+)
>  create mode 100644 Documentation/s390/vfio-ccw.txt
> 
> diff --git a/Documentation/s390/00-INDEX b/Documentation/s390/00-INDEX
> index 9189535..317f037 100644
> --- a/Documentation/s390/00-INDEX
> +++ b/Documentation/s390/00-INDEX
> @@ -22,5 +22,7 @@ qeth.txt
>  	- HiperSockets Bridge Port Support.
>  s390dbf.txt
>  	- information on using the s390 debug feature.
> +vfio-ccw.txt
> +	  information on the vfio-ccw I/O subchannel driver.
>  zfcpdump.txt
>  	- information on the s390 SCSI dump tool.
> diff --git a/Documentation/s390/vfio-ccw.txt b/Documentation/s390/vfio-ccw.txt
> new file mode 100644
> index 0000000..90b3dfe
> --- /dev/null
> +++ b/Documentation/s390/vfio-ccw.txt
> @@ -0,0 +1,303 @@
> +vfio-ccw: the basic infrastructure
> +==================================
> +
> +Introduction
> +------------
> +
> +Here we describe the vfio support for I/O subchannel devices for
> +Linux/s390. Motivation for vfio-ccw is to passthrough subchannels to a
> +virtual machine, while vfio is the means.
> +
> +Different than other hardware architectures, s390 has defined a unified
> +I/O access method, which is so called Channel I/O. It has its own access
> +patterns:
> +- Channel programs run asynchronously on a separate (co)processor.
> +- The channel subsystem will access any memory designated by the caller
> +  in the channel program directly, i.e. there is no iommu involved.
> +Thus when we introduce vfio support for these devices, we realize it
> +with a mediated device (mdev) implementation. The vfio mdev will be
> +added to an iommu group, so as to make itself able to be managed by the
> +vfio framework. And we add read/write callbacks for special vfio I/O
> +regions to pass the channel programs from the mdev to its parent device
> +(the real I/O subchannel device) to do further address translation and
> +to perform I/O instructions.
> +
> +This document does not intend to explain the s390 I/O architecture in
> +every detail. More information/reference could be found here:
> +- A good start to know Channel I/O in general:
> +  https://en.wikipedia.org/wiki/Channel_I/O
> +- s390 architecture:
> +  s390 Principles of Operation manual (IBM Form. No. SA22-7832)
> +- The existing Qemu code which implements a simple emulated channel
> +  subsystem could also be a good reference. It makes it easier to follow
> +  the flow.
> +  qemu/hw/s390x/css.c
> +
> +For vfio mediated device framework:
> +- Documentation/vfio-mediated-device.txt
> +
> +Motivation of vfio-ccw
> +----------------------
> +
> +Currently, a guest virtualized via qemu/kvm on s390 only sees
> +paravirtualized virtio devices via the "Virtio Over Channel I/O
> +(virtio-ccw)" transport. This makes virtio devices discoverable via
> +standard operating system algorithms for handling channel devices.
> +
> +However this is not enough. On s390 for the majority of devices, which
> +use the standard Channel I/O based mechanism, we also need to provide
> +the functionality of passing through them to a Qemu virtual machine.
> +This includes devices that don't have a virtio counterpart (e.g. tape
> +drives) or that have specific characteristics which guests want to
> +exploit.
> +
> +For passing a device to a guest, we want to use the same interface as
> +everybody else, namely vfio. Thus, we would like to introduce vfio
> +support for channel devices. And we would like to name this new vfio
> +device "vfio-ccw".
> +
> +Access patterns of CCW devices
> +------------------------------
> +
> +s390 architecture has implemented a so called channel subsystem, that
> +provides a unified view of the devices physically attached to the
> +systems. Though the s390 hardware platform knows about a huge variety of
> +different peripheral attachments like disk devices (aka. DASDs), tapes,
> +communication controllers, etc. They can all be accessed by a well
> +defined access method and they are presenting I/O completion a unified
> +way: I/O interruptions.
> +
> +All I/O requires the use of channel command words (CCWs). A CCW is an
> +instruction to a specialized I/O channel processor. A channel program is
> +a sequence of CCWs which are executed by the I/O channel subsystem.  To
> +issue a channel program to the channel subsystem, it is required to
> +build an operation request block (ORB), which can be used to point out
> +the format of the CCW and other control information to the system. The
> +operating system signals the I/O channel subsystem to begin executing
> +the channel program with a SSCH (start sub-channel) instruction. The
> +central processor is then free to proceed with non-I/O instructions
> +until interrupted. The I/O completion result is received by the
> +interrupt handler in the form of interrupt response block (IRB).
> +
> +Back to vfio-ccw, in short:
> +- ORBs and channel programs are built in guest kernel (with guest
> +  physical addresses).
> +- ORBs and channel programs are passed to the host kernel.
> +- Host kernel translates the guest physical addresses to real addresses
> +  and starts the I/O with issuing a privileged Channel I/O instruction
> +  (e.g SSCH).
> +- channel programs run asynchronously on a separate processor.
> +- I/O completion will be signaled to the host with I/O interruptions.
> +  And it will be copied as IRB to user space to pass it back to the
> +  guest.
> +
> +Physical vfio ccw device and its child mdev
> +-------------------------------------------
> +
> +As mentioned above, we realize vfio-ccw with a mdev implementation.
> +
> +Channel I/O does not have IOMMU hardware support, so the physical
> +vfio-ccw device does not have an IOMMU level translation or isolation.
> +
> +Sub-channel I/O instructions are all privileged instructions, When
> +handling the I/O instruction interception, vfio-ccw has the software
> +policing and translation how the channel program is programmed before
> +it gets sent to hardware.
> +
> +Within this implementation, we have two drivers for two types of
> +devices:
> +- The vfio_ccw driver for the physical subchannel device.
> +  This is an I/O subchannel driver for the real subchannel device.  It
> +  realizes a group of callbacks and registers to the mdev framework as a
> +  parent (physical) device. As a consequence, mdev provides vfio_ccw a
> +  generic interface (sysfs) to create mdev devices. A vfio mdev could be
> +  created by vfio_ccw then and added to the mediated bus. It is the vfio
> +  device that added to an IOMMU group and a vfio group.
> +  vfio_ccw also provides an I/O region to accept channel program
> +  request from user space and store I/O interrupt result for user
> +  space to retrieve. To notify user space an I/O completion, it offers
> +  an interface to setup an eventfd fd for asynchronous signaling.
> +
> +- The vfio_mdev driver for the mediated vfio ccw device.
> +  This is provided by the mdev framework. It is a vfio device driver for
> +  the mdev that created by vfio_ccw.
> +  It realize a group of vfio device driver callbacks, adds itself to a
> +  vfio group, and registers itself to the mdev framework as a mdev
> +  driver.
> +  It uses a vfio iommu backend that uses the existing map and unmap
> +  ioctls, but rather than programming them into an IOMMU for a device,
> +  it simply stores the translations for use by later requests. This
> +  means that a device programmed in a VM with guest physical addresses
> +  can have the vfio kernel convert that address to process virtual
> +  address, pin the page and program the hardware with the host physical
> +  address in one step.
> +  For a mdev, the vfio iommu backend will not pin the pages during the
> +  VFIO_IOMMU_MAP_DMA ioctl. Mdev framework will only maintain a database
> +  of the iova<->vaddr mappings in this operation. And they export a
> +  vfio_pin_pages and a vfio_unpin_pages interfaces from the vfio iommu
> +  backend for the physical devices to pin and unpin pages by demand.
> +
> +Below is a high Level block diagram.
> +
> + +-------------+
> + |             |
> + | +---------+ | mdev_register_driver() +--------------+
> + | |  Mdev   | +<-----------------------+              |
> + | |  bus    | |                        | vfio_mdev.ko |
> + | | driver  | +----------------------->+              |<-> VFIO user
> + | +---------+ |    probe()/remove()    +--------------+    APIs
> + |             |
> + |  MDEV CORE  |
> + |   MODULE    |
> + |   mdev.ko   |
> + | +---------+ | mdev_register_device() +--------------+
> + | |Physical | +<-----------------------+              |
> + | | device  | |                        |  vfio_ccw.ko |<-> subchannel
> + | |interface| +----------------------->+              |     device
> + | +---------+ |       callback         +--------------+
> + +-------------+
> +
> +The process of how these work together.
> +1. vfio_ccw.ko drives the physical I/O subchannel, and registers the
> +   physical device (with callbacks) to mdev framework.
> +   When vfio_ccw probing the subchannel device, it registers device
> +   pointer and callbacks to the mdev framework. Mdev related file nodes
> +   under the device node in sysfs would be created for the subchannel
> +   device, namely 'mdev_create', 'mdev_destroy' and
> +   'mdev_supported_types'.
> +2. Create a mediated vfio ccw device.
> +   Use the 'mdev_create' sysfs file, we need to manually create one (and
> +   only one for our case) mediated device.
> +3. vfio_mdev.ko drives the mediated ccw device.
> +   vfio_mdev is also the vfio device drvier. It will probe the mdev and
> +   add it to an iommu_group and a vfio_group. Then we could pass through
> +   the mdev to a guest.
> +
> +vfio-ccw I/O region
> +-------------------
> +
> +An I/O region is used to accept channel program request from user
> +space and store I/O interrupt result for user space to retrieve. The
> +defination of the region is:
> +
> +struct ccw_io_region {
> +#define ORB_AREA_SIZE 12
> +	__u8	orb_area[ORB_AREA_SIZE];
> +#define SCSW_AREA_SIZE 12
> +	__u8	scsw_area[SCSW_AREA_SIZE];
> +#define IRB_AREA_SIZE 96
> +	__u8	irb_area[IRB_AREA_SIZE];
> +	__u32	ret_code;
> +} __packed;
> +
> +While starting an I/O request, orb_area should be filled with the
> +guest ORB, and scsw_area should be filled with the SCSW of the Virtual
> +Subchannel.
> +
> +irb_area stores the I/O result.
> +
> +ret_code stores a return code for each access of the region.

Pardon if these questions expose my lack of familiarity with S390:

So I/O requests are asynchronous, the user is notified via interrupt
when completed, can more than one request be queued at a time?  The
communication format doesn't seem like it'd easily support that.  Is it
possible?  A future enhancement that we should design for now?

I'm also a little unclear what sort of I/O a user has access to via
this interface and how the kernel polices that access.  For instance,
are multiple tape or disk devices available through a single I/O
channel?  How does the user configure which devices a user has access
to when creating the vfio-ccw device?

Otherwise I think the interface looks great.  Thanks,

Alex
