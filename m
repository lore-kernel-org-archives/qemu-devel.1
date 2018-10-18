Received: from eggs.gnu.org ([2001:4830:134:3::10]:39063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gD4XD-00079J-Fa
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 05:24:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gD4X8-0001wE-NO
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 05:24:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gD4X8-0001tQ-Ca
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 05:23:58 -0400
Date: Thu, 18 Oct 2018 10:23:50 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181018092349.GA2632@work-vm>
References: <1539713558-2453-1-git-send-email-kwankhede@nvidia.com>
	<1539713558-2453-2-git-send-email-kwankhede@nvidia.com>
	<20181017100952.GA2531@work-vm>
	<2abff2cd-6bdc-69d9-28b3-72baab47bf81@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2abff2cd-6bdc-69d9-28b3-72baab47bf81@nvidia.com>
Subject: Re: [Qemu-devel] [RFC PATCH v1 1/4] VFIO KABI for migration
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kirti Wankhede <kwankhede@nvidia.com>
Cc: alex.williamson@redhat.com, cjia@nvidia.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, quintela@redhat.com

* Kirti Wankhede (kwankhede@nvidia.com) wrote:
> 
> 
> On 10/17/2018 3:39 PM, Dr. David Alan Gilbert wrote:
> > * Kirti Wankhede (kwankhede@nvidia.com) wrote:
> >> - Added vfio_device_migration_info structure to use interact with vendor
> >>   driver.
> >> - Different flags are used to get or set migration related information
> >>   from/to vendor driver.
> >> Flag VFIO_MIGRATION_PROBE: To query if feature is supported
> >> Flag VFIO_MIGRATION_GET_REGION: To get migration region info
> >> Flag VFIO_MIGRATION_SET_STATE: To convey device state in vendor driver
> >> Flag VFIO_MIGRATION_GET_PENDING: To get pending bytes yet to be migrated
> >>   from vendor driver
> >> Flag VFIO_MIGRATION_GET_BUFFER: On this flag, vendor driver should write
> >>   data to migration region and return number of bytes written in the region
> >> Flag VFIO_MIGRATION_SET_BUFFER: In migration resume path, user space app
> >>   writes to migration region and communicates it to vendor driver with
> >>   this ioctl with this flag.
> >> Flag VFIO_MIGRATION_GET_DIRTY_PFNS: Get bitmap of dirty pages from vendor
> >>   driver from given start address
> >>
> >> - Added enum for possible device states.
> >>
> >> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> >> Reviewed-by: Neo Jia <cjia@nvidia.com>
> >> ---
> >>  linux-headers/linux/vfio.h | 91 ++++++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 91 insertions(+)
> >>
> >> diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
> >> index 3615a269d378..8e9045ed9aa8 100644
> >> --- a/linux-headers/linux/vfio.h
> >> +++ b/linux-headers/linux/vfio.h
> >> @@ -602,6 +602,97 @@ struct vfio_device_ioeventfd {
> >>  
> >>  #define VFIO_DEVICE_IOEVENTFD		_IO(VFIO_TYPE, VFIO_BASE + 16)
> >>  
> >> +/**
> >> + * VFIO_DEVICE_MIGRATION_INFO - _IOW(VFIO_TYPE, VFIO_BASE + 17,
> >> + *                              struct vfio_device_migration_info)
> > 
> > This is a little odd; what you really have here is 7 different
> > operations that can be performed; they're independent operations all
> > relating to part of migration; so instead of a 'flag' it's more of an
> > operation type, and there's no reason to make them individual bit flags
> > - for edxample there's no reason you'd want to OR together
> > MIGRATION_GET_REGION and MIGRATION_GET_PENDING - they're just
> > independent.
> > (Similarly you could just make them 7 ioctls)
> > 
> 
> Right, all flags are independent commands. But I tried to use one ioctl
> number.
> 
> > I guess what you're trying to do here is a direct 1-1 mapping of qemu's
> > struct SaveVMHandlers interface to devices.
> > That's not necessarily a bad idea, but remember it's not a stable
> > interface, so QEMU will change it over time and you'll have to then
> > figure out how to shim these interfaces to it, so it's worth keeping
> > that in mind, just in case you can make these interfaces more general.
> > 
> 
> Alex suggested using sparse region instead of ioctl, I'm making note of
> your point to define structures when implementing this interface using
> sparse mmap region.
> 
> 
> >> + * Flag VFIO_MIGRATION_PROBE:
> >> + *      To query if feature is supported
> >> + *
> >> + * Flag VFIO_MIGRATION_GET_REGION:
> >> + *      To get migration region info
> >> + *      region_index [output] : region index to be used for migration region
> >> + *      size [output]: size of migration region
> >> + *
> >> + * Flag VFIO_MIGRATION_SET_STATE:
> >> + *      To set device state in vendor driver
> >> + *      device_state [input] : User space app sends device state to vendor
> >> + *           driver on state change
> >> + *
> >> + * Flag VFIO_MIGRATION_GET_PENDING:
> >> + *      To get pending bytes yet to be migrated from vendor driver
> >> + *      threshold_size [Input] : threshold of buffer in User space app.
> >> + *      pending_precopy_only [output] : pending data which must be migrated in
> >> + *          precopy phase or in stopped state, in other words - before target
> >> + *          vm start
> >> + *      pending_compatible [output] : pending data which may be migrated in any
> >> + *           phase
> >> + *      pending_postcopy_only [output] : pending data which must be migrated in
> >> + *           postcopy phase or in stopped state, in other words - after source
> >> + *           vm stop
> >> + *      Sum of pending_precopy_only, pending_compatible and
> >> + *      pending_postcopy_only is the whole amount of pending data.
> >> + *
> >> + * Flag VFIO_MIGRATION_GET_BUFFER:
> >> + *      On this flag, vendor driver should write data to migration region and
> >> + *      return number of bytes written in the region.
> >> + *      bytes_written [output] : number of bytes written in migration buffer by
> >> + *          vendor driver
> >> + *
> >> + * Flag VFIO_MIGRATION_SET_BUFFER
> >> + *      In migration resume path, user space app writes to migration region and
> >> + *      communicates it to vendor driver with this ioctl with this flag.
> >> + *      bytes_written [Input] : number of bytes written in migration buffer by
> >> + *          user space app.
> > 
> > I guess we call getbuffer/setbuffer multiple times.  Is there anything
> > that needs to be passed to get the data to line up (e.g. offset into the
> > data)
> > 
> 
> I think, vendor driver can keep track of offset as it knows what data
> copied and what is remaining.

OK.
I'm not sure if your 'threshold size' definition matches qemu's; QEMU's
idea is a threshold below which we should stop the precopy phase.

I'm also not too sure how your GET_BUFFER works;  if GET_BUFFER returns
a full buffer, I guess we have to call it again to get more data - how
do I know I need to call it again?

(Some of these things would be clearer if you posted an RFC for the QEMU
side as well).

> 
> >> + * Flag VFIO_MIGRATION_GET_DIRTY_PFNS
> >> + *      Get bitmap of dirty pages from vendor driver from given start address.
> >> + *      start_addr [Input] : start address
> >> + *      pfn_count [Input] : Total pfn count from start_addr for which dirty
> >> + *          bitmap is requested
> >> + *      dirty_bitmap [Output] : bitmap memory allocated by user space
> >> + *           application, vendor driver should return the bitmap with bits set
> >> + *           only for pages to be marked dirty.
> >> + * Return: 0 on success, -errno on failure.
> >> + */
> >> +
> >> +struct vfio_device_migration_info {
> >> +	__u32 argsz;
> >> +	__u32 flags;
> >> +#define VFIO_MIGRATION_PROBE            (1 << 0)
> >> +#define VFIO_MIGRATION_GET_REGION       (1 << 1)
> >> +#define VFIO_MIGRATION_SET_STATE        (1 << 2)
> >> +#define VFIO_MIGRATION_GET_PENDING      (1 << 3)
> >> +#define VFIO_MIGRATION_GET_BUFFER       (1 << 4)
> >> +#define VFIO_MIGRATION_SET_BUFFER       (1 << 5)
> >> +#define VFIO_MIGRATION_GET_DIRTY_PFNS   (1 << 6)
> >> +        __u32 region_index;	            /* region index */
> >> +        __u64 size;	                    /* size */
> >> +        __u32 device_state;                 /* VFIO device state */
> >> +        __u64 pending_precopy_only;
> >> +        __u64 pending_compatible;
> >> +        __u64 pending_postcopy_only;
> >> +        __u64 threshold_size;
> >> +        __u64 bytes_written;
> >> +        __u64 start_addr;
> >> +        __u64 pfn_count;
> >> +	__u8  dirty_bitmap[];
> >> +};
> > 
> > This feels like it should be separate types for the different calls.
> > 
> > Also, is there no state to tell the userspace what version of migration
> > data we have?  What happens if I try and load a migration state
> > from an older driver into a newer one, or the other way around,
> > or into a destination card that's not the same as the source.
> > 
> 
> As I mentioned in other reply, this RFC is mainly focused on core logic
> of live migration which include implementation for pre-copy, stop-n-copy
> and resume phases, defining device states.
> 
> >> +enum {
> >> +    VFIO_DEVICE_STATE_NONE,
> >> +    VFIO_DEVICE_STATE_RUNNING,
> >> +    VFIO_DEVICE_STATE_MIGRATION_SETUP,
> >> +    VFIO_DEVICE_STATE_MIGRATION_PRECOPY_ACTIVE,
> >> +    VFIO_DEVICE_STATE_MIGRATION_STOPNCOPY_ACTIVE,
> >> +    VFIO_DEVICE_STATE_MIGRATION_SAVE_COMPLETED,
> >> +    VFIO_DEVICE_STATE_MIGRATION_RESUME,
> >> +    VFIO_DEVICE_STATE_MIGRATION_RESUME_COMPLETED,
> >> +    VFIO_DEVICE_STATE_MIGRATION_FAILED,
> >> +    VFIO_DEVICE_STATE_MIGRATION_CANCELLED,
> >> +};
> > 
> > That's an interesting merge of QEMU's run-state and it's migration
> > state.
> > 
> > You probably need to define which transitions you take as legal.
> >
> 
> In reply to Alex, I had listed down allowable state transitions.

Yes; we regularly find that we have to add extra transitions we hadn't
thought of.

Can you think of anyway of making postcopy work with your devices?
It's tricky because we'd have to find a way to stop your devices
accessing memory that hasn't arrived yet.

Dave

> Thanks,
> Kirti
> 
> > Dave
> > 
> >> +
> >> +#define VFIO_DEVICE_MIGRATION_INFO _IO(VFIO_TYPE, VFIO_BASE + 17)
> >> +
> >>  /* -------- API for Type1 VFIO IOMMU -------- */
> >>  
> >>  /**
> >> -- 
> >> 2.7.0
> >>
> >>
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
