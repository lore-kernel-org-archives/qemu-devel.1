Received: from eggs.gnu.org ([2001:4830:134:3::10]:44087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gRjPm-0002Tb-UL
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 14:53:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gRjPi-0004ni-5o
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 14:52:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gRjPh-0004nZ-UI
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 14:52:54 -0500
Date: Tue, 27 Nov 2018 12:52:48 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20181127125248.01ef3e86@x1.home>
In-Reply-To: <1542746383-18288-2-git-send-email-kwankhede@nvidia.com>
References: <1542746383-18288-1-git-send-email-kwankhede@nvidia.com>
	<1542746383-18288-2-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/5] VFIO KABI for migration interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kirti Wankhede <kwankhede@nvidia.com>
Cc: cjia@nvidia.com, kevin.tian@intel.com, ziye.yang@intel.com, changpeng.liu@intel.com, yi.l.liu@intel.com, mlevitsk@redhat.com, eskultet@redhat.com, cohuck@redhat.com, dgilbert@redhat.com, jonathan.davies@nutanix.com, eauger@redhat.com, aik@ozlabs.ru, pasic@linux.ibm.com, felipe@nutanix.com, Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com, Ken.Xue@amd.com, zhi.a.wang@intel.com, qemu-devel@nongnu.org

On Wed, 21 Nov 2018 02:09:39 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> - Defined MIGRATION region type and sub-type.
> - Defined VFIO device states during migration process.
> - Defined vfio_device_migration_info structure which will be placed at 0th
>   offset of migration region to get/set VFIO device related information.
>   Defined actions and members of structure usage for each action:
>     * To convey VFIO device state to be transitioned to.
>     * To get pending bytes yet to be migrated for VFIO device
>     * To ask driver to write data to migration region and return number of bytes
>       written in the region
>     * In migration resume path, user space app writes to migration region and
>       communicates it to vendor driver.
>     * Get bitmap of dirty pages from vendor driver from given start address
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  linux-headers/linux/vfio.h | 130 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 130 insertions(+)
> 
> diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
> index 3615a269d378..a6e45cb2cae2 100644
> --- a/linux-headers/linux/vfio.h
> +++ b/linux-headers/linux/vfio.h
> @@ -301,6 +301,10 @@ struct vfio_region_info_cap_type {
>  #define VFIO_REGION_SUBTYPE_INTEL_IGD_HOST_CFG	(2)
>  #define VFIO_REGION_SUBTYPE_INTEL_IGD_LPC_CFG	(3)
>  
> +/* Migration region type and sub-type */
> +#define VFIO_REGION_TYPE_MIGRATION	        (1 << 30)
> +#define VFIO_REGION_SUBTYPE_MIGRATION	        (1)
> +

I think this is copied from the vendor type, but I don't think it makes
sense here.  We reserve the top bit of the type to indicate a PCI
vendor type where the lower 16 bits are then the PCI vendor ID.  This
gives each vendor their own sub-type address space.  With the graphics
type we began our first type with (1).  I would expect migration to
then be type (2), not (1 << 30).

>  /*
>   * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped
>   * which allows direct access to non-MSIX registers which happened to be within
> @@ -602,6 +606,132 @@ struct vfio_device_ioeventfd {
>  
>  #define VFIO_DEVICE_IOEVENTFD		_IO(VFIO_TYPE, VFIO_BASE + 16)

Reading ahead in the thread, I'm going to mention a lot of what Kevin
has already said here...
 
> +/**
> + * VFIO device states :
> + * VFIO User space application should set the device state to indicate vendor
> + * driver in which state the VFIO device should transitioned.
> + * - VFIO_DEVICE_STATE_NONE:
> + *   State when VFIO device is initialized but not yet running.
> + * - VFIO_DEVICE_STATE_RUNNING:
> + *   Transition VFIO device in running state, that is, user space application or
> + *   VM is active.

Is this backwards compatible?  A new device that supports migration
must be backwards compatible with old userspace that doesn't interact
with the migration region.  What happens if userspace never moves the
state to running?

> + * - VFIO_DEVICE_STATE_MIGRATION_SETUP:
> + *   Transition VFIO device in migration setup state. This is used to prepare
> + *   VFIO device for migration while application or VM and vCPUs are still in
> + *   running state.

What does this imply to the device?  I thought we were going to
redefine these states in terms of what we expect the device to do.
These still seem like just a copy of the QEMU states which we discussed
are an internal reference that can change at any time.

> + * - VFIO_DEVICE_STATE_MIGRATION_PRECOPY:
> + *   When VFIO user space application or VM is active and vCPUs are running,
> + *   transition VFIO device in pre-copy state.

Which means what?

> + * - VFIO_DEVICE_STATE_MIGRATION_STOPNCOPY:
> + *   When VFIO user space application or VM is stopped and vCPUs are halted,
> + *   transition VFIO device in stop-and-copy state.

Is the device still running?  What happens to in-flight DMA?  Does it
wait?  We need a clear definition in terms of the device, not the VM.

> + * - VFIO_DEVICE_STATE_MIGRATION_SAVE_COMPLETED:
> + *   When VFIO user space application has copied data provided by vendor driver.
> + *   This state is used by vendor driver to clean up all software state that was
> + *   setup during MIGRATION_SETUP state.

When was the MIGRATION_SAVE_STARTED?

> + * - VFIO_DEVICE_STATE_MIGRATION_RESUME:
> + *   Transition VFIO device to resume state, that is, start resuming VFIO device
> + *   when user space application or VM is not running and vCPUs are halted.

Are we simply restoring the we copied from the device after it was
stopped?

> + * - VFIO_DEVICE_STATE_MIGRATION_RESUME_COMPLETED:
> + *   When user space application completes iterations of providing device state
> + *   data, transition device in resume completed state.

So the device should start running here?

> + * - VFIO_DEVICE_STATE_MIGRATION_FAILED:
> + *   Migration process failed due to some reason, transition device to failed
> + *   state. If migration process fails while saving at source, resume device at
> + *   source. If migration process fails while resuming application or VM at
> + *   destination, stop restoration at destination and resume at source.

What does a failed device do?  Can't we simply not move to the
completed state?

> + * - VFIO_DEVICE_STATE_MIGRATION_CANCELLED:
> + *   User space application has cancelled migration process either for some
> + *   known reason or due to user's intervention. Transition device to Cancelled
> + *   state, that is, resume device state as it was during running state at
> + *   source.

Why do we need to tell the device this, can't we simply go back to
normal running state?

It seems to me that the default state needs to be RUNNING in order to
be backwards compatible.

I also agree with Kevin that it seems that dirty tracking is just an
augmented running state that we can turn on and off.  Shouldn't we also
define that dirty tracking can be optional?  For instance if a device
doesn't support dirty tracking, couldn't we stop the device first, then
save all memory, then retrieve the device state?  This is the other
problem with mirroring QEMU migration states, we don't account for
things that QEMU currently doesn't do.

Actually I'm wondering if we can distill everything down to two bits,
STOPPED and LOGGING.

We start at RUNNING, the user can optionally enable LOGGING when
supported by the device to cover the SETUP and PRECOPY states
proposed.  The device stays running, but activates any sort of
dirtly page tracking that's necessary to activate those interfaces.
LOGGING can also be cleared to handle the CANCELLED state.  The user
would set STOPPED which should quiesce the device and make the full
device state available through the device data section.  Clearing
STOPPED and LOGGING would handle the FAILED state below.  Likewise on
the migration target, QEMU would set the device top STOPPED in order to
write the incoming data via the data section and clear STOPPED to
indicate the device returns to RUNNING (aka RESUME/RESUME_COMPLETED).

> + */
> +
> +enum {
> +    VFIO_DEVICE_STATE_NONE,
> +    VFIO_DEVICE_STATE_RUNNING,
> +    VFIO_DEVICE_STATE_MIGRATION_SETUP,
> +    VFIO_DEVICE_STATE_MIGRATION_PRECOPY,
> +    VFIO_DEVICE_STATE_MIGRATION_STOPNCOPY,
> +    VFIO_DEVICE_STATE_MIGRATION_SAVE_COMPLETED,
> +    VFIO_DEVICE_STATE_MIGRATION_RESUME,
> +    VFIO_DEVICE_STATE_MIGRATION_RESUME_COMPLETED,
> +    VFIO_DEVICE_STATE_MIGRATION_FAILED,
> +    VFIO_DEVICE_STATE_MIGRATION_CANCELLED,
> +};
> +
> +/**
> + * Structure vfio_device_migration_info is placed at 0th offset of
> + * VFIO_REGION_SUBTYPE_MIGRATION region to get/set VFIO device related migration
> + * information.

Should include a note that field accesses are only supported at their
native width and alignment, anything else is unsupported and should
generate an error.  I don't see a good reason to bloat the supporting
code to handle anything else.

> + *
> + * Action Set state:
> + *      To tell vendor driver the state VFIO device should be transitioned to.
> + *      device_state [input] : User space app sends device state to vendor
> + *           driver on state change, the state to which VFIO device should be
> + *           transitioned to.

It should be noted that the write will return error on a transition
failure.  The write is also synchronous, ie. when the device is asked
to stop, any in-flight DMA will be completed before the write returns.

> + *
> + * Action Get pending bytes:
> + *      To get pending bytes yet to be migrated from vendor driver
> + *      pending.threshold_size [Input] : threshold of buffer in User space app.

I still don't see why the kernel needs to be concerned with the size of
the user buffer.  The vendor driver will already know the size of the
user read, won't the user try to fill their buffer in a single read?
Infer the size.  Maybe you really want a minimum read size if you want
to package your vendor data in some way?  ie. what minimum size must the
user use to avoid getting -ENOSPC return.

> + *      pending.precopy_only [output] : pending data which must be migrated in
> + *          precopy phase or in stopped state, in other words - before target
> + *          user space application or VM start. In case of migration, this
> + *          indicates pending bytes to be transfered while application or VM or
> + *          vCPUs are active and running.

What sort of data is included here?  Is this mostly a compatibility
check?  I think that needs to be an explicit part of the interface, not
something we simply assume the vendor driver handles (though it's
welcome to do additional checking).  What other device state is valid
to be saved prior to stopping the device?

> + *      pending.compatible [output] : pending data which may be migrated any
> + *          time , either when application or VM is active and vCPUs are active
> + *          or when application or VM is halted and vCPUs are halted.

Again, what sort of data is included here?  If it's live device data,
like a framebuffer, shouldn't it be handled by the dirty page tracking
interface?  Is this meant to do dirty tracking within device memory?
Should we formalize that?

> + *      pending.postcopy_only [output] : pending data which must be migrated in
> + *           postcopy phase or in stopped state, in other words - after source
> + *           application or VM stopped and vCPUs are halted.
> + *      Sum of pending.precopy_only, pending.compatible and
> + *      pending.postcopy_only is the whole amount of pending data.

It seems the user is able to stop the device at any point in time, what
do these values indicate then?  Shouldn't there be just one value then?

Can't we do all of this with just a save_bytes_available value?  When
the device is RUNNING this value could be dynamic (if the vendor driver
supports data in that phase... and we understand how to consume it),
when the device is stopped, it could update with each read.

> + *
> + * Action Get buffer:
> + *      On this action, vendor driver should write data to migration region and
> + *      return number of bytes written in the region.
> + *      data.offset [output] : offset in the region from where data is written.
> + *      data.size [output] : number of bytes written in migration buffer by
> + *          vendor driver.

If we know the pending bytes, why do we need this?  Isn't the read
itself the indication to prepare the data to be read?  Does the user
really ever need to start a read from anywhere other than the starting
offset of the data section?

> + *
> + * Action Set buffer:
> + *      In migration resume path, user space app writes to migration region and
> + *      communicates it to vendor driver with this action.
> + *      data.offset [Input] : offset in the region from where data is written.
> + *      data.size [Input] : number of bytes written in migration buffer by
> + *          user space app.

Again, isn't all the information contained in the write itself?
Shouldn't the packet of data the user writes include information that
makes the offset unnecessary?  Are all of these trying to support an
mmap capable data area and do we really need that?

> + *
> + * Action Get dirty pages bitmap:
> + *      Get bitmap of dirty pages from vendor driver from given start address.
> + *      dirty_pfns.start_addr [Input] : start address
> + *      dirty_pfns.total [Input] : Total pfn count from start_addr for which
> + *          dirty bitmap is requested
> + *      dirty_pfns.copied [Output] : pfn count for which dirty bitmap is copied
> + *          to migration region.
> + *      Vendor driver should copy the bitmap with bits set only for pages to be
> + *      marked dirty in migration region.
> + */

The protocol is not very clear here, the vendor driver never copies the
bitmap, from the user perspective the vendor driver handles the read(2)
from the region.  But is the data data.offset being used for this?
It's not clear where the user reads the bitmap.  Is the start_addr here
meant to address the segmentation that we discussed previously?  As
above, I don't see why the user needs all these input fields, they can
almost all be determined by the read itself.

The format I proposed was that much like the data section, the device
could expose a dirty pfn section with offset and size.  For example:

struct {
	__u64 offset;		// read-only (in bytes)
	__u64 size;		// read-only (in bytes)
	__u64 page_size;	// read-only (ex. 4k)
	__u64 segment;		// read-write
} dirty_pages;

So for example, the vendor driver would expose an offset within the
region much like for the data area.  The size might be something like
32MB and the page_size could be 4096.  The user can calculate from this
that the area exposes 1TB worth of pfns.  When segment is 0x0 the user
can directly read pfns for address 0x0 to 1TB - 1.  Setting segment to
0x1 allows access to 1TB to 2TB - 1, etc.  Therefore the user sets the
segment register and simply performs a read.

The thing we discussed that this interface lacks is an efficient
interface for handling reading from a range where no dirty bits are
set, which I think you're trying to handle with the additional 'copied'
field, but couldn't read(2) simply return zero to optimize that case?
We only need to ensure that the user won't continue to retry for that
return value.

> +
> +struct vfio_device_migration_info {
> +        __u32 device_state;         /* VFIO device state */
> +        struct {
> +            __u64 precopy_only;
> +            __u64 compatible;
> +            __u64 postcopy_only;
> +            __u64 threshold_size;
> +        } pending;
> +        struct {
> +            __u64 offset;           /* offset */
> +            __u64 size;             /* size */
> +        } data;
> +        struct {
> +            __u64 start_addr;
> +            __u64 total;
> +            __u64 copied;
> +        } dirty_pfns;
> +} __attribute__((packed));
> +

We're still missing explicit versioning and compatibility information.
Thanks,

Alex
