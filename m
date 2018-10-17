Received: from eggs.gnu.org ([2001:4830:134:3::10]:50170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gCv1d-0001er-0S
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 19:14:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gCv1Z-0003DJ-Or
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 19:14:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gCv1Z-0003BZ-Dx
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 19:14:45 -0400
Date: Wed, 17 Oct 2018 17:14:42 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20181017171442.7747d4e0@w520.home>
In-Reply-To: <d5bab37a-ffde-7efc-eb22-70179de906d7@nvidia.com>
References: <1539713558-2453-1-git-send-email-kwankhede@nvidia.com>
	<1539713558-2453-2-git-send-email-kwankhede@nvidia.com>
	<20181016163433.40003f66@w520.home>
	<d5bab37a-ffde-7efc-eb22-70179de906d7@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: cjia@nvidia.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, "Dr.
	David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, "Wang, Zhi A" <zhi.a.wang@intel.com>

On Thu, 18 Oct 2018 02:17:19 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> On 10/17/2018 4:04 AM, Alex Williamson wrote:
> > On Tue, 16 Oct 2018 23:42:35 +0530
> > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >   
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
> > This is quite a bit more than an "INFO" ioctl.
> >   
> >> + * Flag VFIO_MIGRATION_PROBE:
> >> + *      To query if feature is supported
> >> + *
> >> + * Flag VFIO_MIGRATION_GET_REGION:
> >> + *      To get migration region info
> >> + *      region_index [output] : region index to be used for migration region
> >> + *      size [output]: size of migration region  
> > 
> > Of course the region migration region can describe itself as being used
> > for migration, so this is unnecessary.  The presence of that region
> > could also negate the need for a probe.
> >   
> 
> Yes, that can be done.
> 
> 
> >> + *
> >> + * Flag VFIO_MIGRATION_SET_STATE:
> >> + *      To set device state in vendor driver
> >> + *      device_state [input] : User space app sends device state to vendor
> >> + *           driver on state change  
> > 
> > Valid states are the enum defined below, correct?
> >   
> 
> Yes, that's correct.
> 
> > Does setting STOPNCOPY_ACTIVE stop any state change of the device or is
> > that expected to happen through other means?
> >   
> 
> _PRECOPY_ACTIVE means vCPUs are still running, so VFIO device should
> still remain active.
> _STOPNCOPY_ACTIVE means vCPUs are not running and device should also be
> stopped and copy device's state.

But does that mean _STOPNCOPY_ACTIVE implicitly stops the device?  If
not, how do we do that?

> > What are the allowable state transitions?
> >   
> 
> Normal VM running case:
> _NONE -> _RUNNING

What effect does this transition actually have on the device?
Userspace currently doesn't support migration, so to be compatible with
current userspace the device needs to start in a functional state.

> In case of live migration, at source:
> _RUNNING -> _SETUP -> _PRECOPY_ACTIVE -> _STOPNCOPY_ACTIVE ->
> _SAVE_COMPLETED
> 
> at destination:
> _NONE -> _SETUP -> _RESUME -> _RESUME_COMPLETE -> _RUNNING
> 
> In save VM case:
> _RUNNING -> _SETUP -> _STOPNCOPY_ACTIVE -> _SAVE_COMPLETED
> 
> In case of resuming VM from saved state:
> _NONE -> _SETUP -> _RESUME -> _RESUME_COMPLETE -> _RUNNING
> 
> _FAILED or _CANCELLED can happen in any state.

What are the valid transitions out of _FAILED or _CANCELLED?

As I note below and Dave noted in his reply, mirroring the internal API
of QEMU seems destined to cause us problems.  I think we need to look
at what we're asking of the device in terms of the device, not QEMU.
QEMU's definition of RESUME could change over time and we can't expect
vendor driver authors to not only be QEMU migration experts, but also
to know how the definition of a QEMU migration state has changed over
time.

> > How many bits in flags is a user allowed to set at once?
> >   
> 
> One bit at a time. Probably, I should use enum for flags rather than bits.
> 
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
> > 
> > What's the significance of the provided threshold, are the pending
> > bytes limited to threshold size?  It makes me nervous to define a
> > kernel API in terms of the internal API of a userspace program that can
> > change.  I wonder if it makes sense to define these in terms of the
> > state of the devices, pending initial data, runtime data, post-offline
> > data.
> >   
> 
> Threshold is required, because that will tell size in bytes that user
> space application buffer can accommodate. Driver can copy data less than
> threshold, but copying data more than threshold doesn't make sense
> because user space application won't be able to copy that extra data and
> that data might get overwritten or lost.

I still don't see why the kernel should care about the user's buffer
size, the user can fill multiple buffers from one get buffer request if
they need to.  The relation between this and _GET_BUFFER is awkward and
not intuitive.

> >> + *
> >> + * Flag VFIO_MIGRATION_GET_BUFFER:
> >> + *      On this flag, vendor driver should write data to migration
> >> region and
> >> + *      return number of bytes written in the region.
> >> + *      bytes_written [output] : number of bytes written in
> >> migration buffer by
> >> + *          vendor driver  
> > 
> > Does the data the user gets here depend on the device state set
> > earlier?  For example the user gets pending_precopy_only data while
> > PRECOPY_ACTIVE is the device state and pending_postcopy_only data
> > in STOPNCOPY_ACTIVE?  The user should continue to call GET_BUFFER
> > in a given state until the associated pending field reaches zero?
> > Jumping between the region and ioctl is rather awkward.
> >   
> 
> User gets pending_precopy_only data when device is in PRECOPY_ACTIVE
> state, but each time when user calls GET_BUFFER, pending bytes might
> change.
> VFIO device's driver is producer of data and user/QEMU is consumer of
> data. In pre-copy phase, when vCPUs are still running, driver will try
> to accumulate as much data as possible in this phase, but vCPUs are
> running and user of that device/application in guest is actively using
> that device, then there are chances that during next iteration of
> GET_BUFFER, driver might have more data.
> Even in case of STOPNCOPY_ACTIVE state of device, driver can start
> sending data in parts while a thread in vendor driver can still generate
> data after device has halted, producer and consumer can run in parallel.
> So User has to call GET_BUFFER until pending bytes are returned 0.

Zero bytes \pending\ or zero bytes \written\?  If the latter, what's
the use of the pending fields if they're always subject to change?  How
does getting zero bytes now guarantee that the device is done
producing data in the situation you describe where even a stopped
device can produce data?

> >> + *
> >> + * Flag VFIO_MIGRATION_SET_BUFFER
> >> + *      In migration resume path, user space app writes to migration
> >> region and
> >> + *      communicates it to vendor driver with this ioctl with this
> >> flag.
> >> + *      bytes_written [Input] : number of bytes written in migration
> >> buffer by
> >> + *          user space app.
> >> + *
> >> + * Flag VFIO_MIGRATION_GET_DIRTY_PFNS
> >> + *      Get bitmap of dirty pages from vendor driver from given
> >> start address.
> >> + *      start_addr [Input] : start address
> >> + *      pfn_count [Input] : Total pfn count from start_addr for
> >> which dirty
> >> + *          bitmap is requested
> >> + *      dirty_bitmap [Output] : bitmap memory allocated by user space
> >> + *           application, vendor driver should return the bitmap
> >> with bits set
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
> > 
> > We'd need to swap device_state and size for alignment or else this
> > struct could vary by compiler.
> >   
> 
> Ok. Thanks for pointing that out. I'll change that.
> 
> >> +        __u64 pending_precopy_only;
> >> +        __u64 pending_compatible;
> >> +        __u64 pending_postcopy_only;
> >> +        __u64 threshold_size;
> >> +        __u64 bytes_written;
> >> +        __u64 start_addr;
> >> +        __u64 pfn_count;
> >> +	__u8  dirty_bitmap[];
> >> +};
> >> +
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
> >> +
> >> +#define VFIO_DEVICE_MIGRATION_INFO _IO(VFIO_TYPE, VFIO_BASE + 17)
> >> +  
> > 
> > I'm not entirely sure what this ioctl buys us that we can't do with a
> > region alone.  For example we could define a migration region as:
> > 
> > struct vfio_region_migration {
> > 	__u32 device_state;
> > 	__u32 data_offset;
> > 	__u64 data_size;
> > 	__u64 pending_pre;
> > 	__u64 pending_runtime;
> > 	__u64 pending_post;
> > 	__u64 bytes_available;
> > 	__u64 bytes_written;
> > };
> > 
> > A sparse mmap capability in the region could define whether the data
> > area supports mmap, the above defined registers would only have
> > read/write access.  The user can write device_state the same as the
> > ioctl would set it.  The data_offset and size describe the offset in
> > the region where migration data is relayed and the size of that area.
> > Pending fields are as you have above, though I've omitted the threshold
> > because I don't understand it.  The user reading bytes_available is the
> > same as calling GET_BUFFER, bytes_written the same as SET_BUFFER.    
> 
> Yes, this could be done. Read/write on structure will be same as ioctl,
> i.e. block till expected operation is done.
> 
> > I've
> > left out the dirty bitmap here, as it's a little less obvious to me how
> > it would work.  It could be a stand-alone ioctl, it could be
> > implemented as another region, or it could simply be a different offset
> > within this region.  The dirty bitmap start address could simply be
> > calculated as the offset into that region where a pread begins and the
> > extent is the size of that pread.  With a bit per page, we're only
> > looking at a 32MB region per 1TB of guest physical address space, so it
> > doesn't seem too terrible even if guest memory is sparse.  Maybe the
> > extremes are still problematic though, but if it were part of the same
> > region above we could solve that with another register written by the
> > user to indicate the base offset of the dirty bitmap window.   
> 
> Generally guest memory is sparse and log_sync is called for each
> MemoryRegionSection. Same region can be used to get dirty page bitmap if
> we are going to move to using sparse region.
> I think here you are thinking of worst case where a VM with 1TB of
> memory have one MemoryRegionSection of 1TB.

I'm not thinking in terms of MemoryRegionSection, I'm thinking simply
of guest physical address.  The ioctl you proposed has a start
address (GPA) and number of pfns, so simply a range within the guest
physical address space.  Rather than the user providing a buffer for
the vendor driver to fill in a dirty bitmap, simply provide the
entire dirty bitmap as a section within the region and fill their
reads in on the fly from the offset an range of their pread.  But
then we need to adapt it a little for reality that the guest can have
quite a large physical address space, so perhaps we use more of a
windowed approach where a 1TB range is accessible at any given time
and the user can select which 1TB range via a "register" in the
region.  I don't see how sparse-ness factors in here, those are
simply indexes and offsets that the user never reads and if they do
read them the vendor driver returns that they're clean.  
 
> > For
> > example if the window is 32MB and page size 4k then it can index 1TB
> > and the user would write 0 (default) to the register for pfns from
> > 0 to (1TB - 1), 1 for pfns from 1TB to (2TB - 1), etc.
> >   
> 
> Sorry I didn't get this example. By window here, do you meant sparse
> region size?

No, hopefully the further explanation above makes sense.  Effectively
segmentation, a "register" in the region selects the base offset of the
window in units of the window size.  So the starting GPA of a pread in
the window would be (index_register * effective_window_size) +
offset_into_window.  Where the effective window size would be 1TB for
the case of a 32MB window with 4K page size, and offset into the window
is of course 1 bit per pfn.

> > I don't see that this interface does anything to address the
> > compatibility concerns that were discussed in the previous iterations
> > from Intel though, nor is it documented exactly where and how a vendor
> > driver would indicate a migration failure if it had its own internal
> > consistency or compatibility checks fail.  Thanks,
> >   
> 
> If vendor driver finds any inconsistency in data or if any operation is
> causing failure, vendor driver should return error to the corresponding
> ioctl. ioctl failure is treated as failure of the particular device. If
> one device returns failure during migration process, migration is
> terminated and VM at source resumes.

And as has been discussed in the previous threads, the user has no
visibility into predicting compatibility and blind faith in the vendor
driver for detecting compatibility.  I don't find that acceptable.
Thanks,

Alex
