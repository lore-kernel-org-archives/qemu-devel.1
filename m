Received: from eggs.gnu.org ([209.51.188.92]:51529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gwv9b-0000lM-Jc
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 15:41:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gwv9Z-0007GP-6Z
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 15:41:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gwv9X-00078I-55
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 15:41:09 -0500
Date: Thu, 21 Feb 2019 13:40:51 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190221134051.2c28893e@w520.home>
In-Reply-To: <1550566254-3545-1-git-send-email-yan.y.zhao@intel.com>
References: <1550566254-3545-1-git-send-email-yan.y.zhao@intel.com>
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
Cc: qemu-devel@nongnu.org, intel-gvt-dev@lists.freedesktop.org, Zhengxiao.zx@Alibaba-inc.com, yi.l.liu@intel.com, eskultet@redhat.com, ziye.yang@intel.com, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com, dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru, eauger@redhat.com, felipe@nutanix.com, jonathan.davies@nutanix.com, changpeng.liu@intel.com, Ken.Xue@amd.com, kwankhede@nvidia.com, kevin.tian@intel.com, cjia@nvidia.com, arei.gonglei@huawei.com, kvm@vger.kernel.org

Hi Yan,

Thanks for working on this!

On Tue, 19 Feb 2019 16:50:54 +0800
Yan Zhao <yan.y.zhao@intel.com> wrote:

> This patchset enables VFIO devices to have live migration capability.
> Currently it does not support post-copy phase.
> 
> It follows Alex's comments on last version of VFIO live migration patches,
> including device states, VFIO device state region layout, dirty bitmap's
> query.
> 
> Device Data
> -----------
> Device data is divided into three types: device memory, device config,
> and system memory dirty pages produced by device.
> 
> Device config: data like MMIOs, page tables...
>         Every device is supposed to possess device config data.
>     	Usually device config's size is small (no big than 10M), and it

I'm not sure how we can really impose a limit here, it is what it is
for a device.  A smaller state is obviously desirable to reduce
downtime, but some devices could have very large states.

>         needs to be loaded in certain strict order.
>         Therefore, device config only needs to be saved/loaded in
>         stop-and-copy phase.
>         The data of device config is held in device config region.
>         Size of device config data is smaller than or equal to that of
>         device config region.

So the intention here is that this is the last data read from the
device and it's done in one pass, so the region needs to be large
enough to expose all config data at once.  On restore it's the last
data written before switching the device to the run state.

> 
> Device Memory: device's internal memory, standalone and outside system

s/system/VM/

>         memory. It is usually very big.

Or it doesn't exist.  Not sure we should be setting expectations since
it will vary per device.

>         This kind of data needs to be saved / loaded in pre-copy and
>         stop-and-copy phase.
>         The data of device memory is held in device memory region.
>         Size of devie memory is usually larger than that of device
>         memory region. qemu needs to save/load it in chunks of size of
>         device memory region.
>         Not all device has device memory. Like IGD only uses system memory.

It seems a little gratuitous to me that this is a separate region or
that this data is handled separately.  All of this data is opaque to
QEMU, so why do we need to separate it?

> System memory dirty pages: If a device produces dirty pages in system
>         memory, it is able to get dirty bitmap for certain range of system
>         memory. This dirty bitmap is queried in pre-copy and stop-and-copy
>         phase in .log_sync callback. By setting dirty bitmap in .log_sync
>         callback, dirty pages in system memory will be save/loaded by ram's
>         live migration code.
>         The dirty bitmap of system memory is held in dirty bitmap region.
>         If system memory range is larger than that dirty bitmap region can
>         hold, qemu will cut it into several chunks and get dirty bitmap in
>         succession.
> 
> 
> Device State Regions
> --------------------
> Vendor driver is required to expose two mandatory regions and another two
> optional regions if it plans to support device state management.
> 
> So, there are up to four regions in total.
> One control region: mandatory.
>         Get access via read/write system call.
>         Its layout is defined in struct vfio_device_state_ctl
> Three data regions: mmaped into qemu.

Is mmap mandatory?  I would think this would be defined by the mdev
device what access they want to support per region.  We don't want to
impose a more complicated interface if the device doesn't require it.

>         device config region: mandatory, holding data of device config
>         device memory region: optional, holding data of device memory
>         dirty bitmap region: optional, holding bitmap of system memory
>                             dirty pages
> 
> (The reason why four seperate regions are defined is that the unit of mmap
> system call is PAGE_SIZE, i.e. 4k bytes. So one read/write region for
> control and three mmaped regions for data seems better than one big region
> padded and sparse mmaped).

It's not obvious to me how this is better, a big region isn't padded,
there's simply a gap in the file descriptor.  Is having a sub-PAGE_SIZE
gap in a file really of any consequence?  Each region beyond the header
is more than likely larger than PAGE_SIZE, therefore they can be nicely
aligned together.  We still need fields to tell us how much data is
available in each area, so another to tell us the start of each area is
a minor detail.  And I think we still want to allow drivers to specify
which parts of which areas support mmap, so I don't think we're getting
away from sparse mmap support.

> kernel device state interface [1]
> --------------------------------------
> #define VFIO_DEVICE_STATE_INTERFACE_VERSION 1
> #define VFIO_DEVICE_DATA_CAP_DEVICE_MEMORY 1
> #define VFIO_DEVICE_DATA_CAP_SYSTEM_MEMORY 2

If we were to go with this multi-region solution, isn't it evident from
the regions exposed that device memory and a dirty bitmap are
provided?  Alternatively, I believe Kirti's proposal doesn't require
this distinction between device memory and device config, a device not
requiring runtime migration data would simply report no data until the
device moved to the stopped state, making it consistent path for
userspace.  Likewise, the dirty bitmap could report a zero page count
in the bitmap rather than branching based on device support.

Note that it seems that cap VFIO_DEVICE_DATA_CAP_SYSTEM_MEMORY implies
VFIO_REGION_SUBTYPE_DEVICE_STATE_DATA_DIRTYBITMAP, but there's no
consistency in the naming.

> #define VFIO_DEVICE_STATE_RUNNING 0 
> #define VFIO_DEVICE_STATE_STOP 1
> #define VFIO_DEVICE_STATE_LOGGING 2

It looks like these are being defined as bits, since patch 1 talks
about RUNNING & LOGGING and STOP & LOGGING.  I think Connie already
posted some comments about this.  I'm not sure anything prevents us
from defining RUNNING a 1 and STOPPED as 0 so we don't have the
polarity flip vs LOGGING though.

The state "STOP & LOGGING" also feels like a strange "device state", if
the device is stopped, it's not logging any new state, so I think this
is more that the device state is STOP, but the LOGGING feature is
active.  Maybe we should consider these independent bits.  LOGGING is
active as we stop a device so that we can fetch the last dirtied pages,
but disabled as we load the state of the device into the target.

> #define VFIO_DEVICE_DATA_ACTION_GET_BUFFER 1
> #define VFIO_DEVICE_DATA_ACTION_SET_BUFFER 2
> #define VFIO_DEVICE_DATA_ACTION_GET_BITMAP 3
> 
> struct vfio_device_state_ctl {
> 	__u32 version;		  /* ro */
> 	__u32 device_state;       /* VFIO device state, wo */
> 	__u32 caps;		 /* ro */
>         struct {
> 		__u32 action;  /* wo, GET_BUFFER or SET_BUFFER */ 
> 		__u64 size;    /*rw*/
> 	} device_config;

Patch 1 indicates that to get the config buffer we write GET_BUFFER to
action and read from the config region.  The size is previously read
and apparently constant.  To set the config buffer, the config region
is written followed by writing SET_BUFFER to action.  Why is size
listed as read-write?

Doesn't this protocol also require that the mdev driver consume each
full region's worth of host kernel memory for backing pages in
anticipation of a rare event like migration?  This might be a strike
against separate regions if the driver needs to provide backing pages
for 3 separate regions vs 1.  To avoid this runtime overhead, would it
be expected that the user only mmap the regions during migration and
the mdev driver allocate backing pages on mmap?  Should the mmap be
restricted to the LOGGING feature being enabled?  Maybe I'm mistaken in
how the mdev driver would back these mmap'd pages.

> 	struct {
> 		__u32 action;    /* wo, GET_BUFFER or SET_BUFFER */ 
> 		__u64 size;     /* rw */  
>                 __u64 pos; /*the offset in total buffer of device memory*/

Patch 1 outlines the protocol here that getting device memory begins
with writing the position field, followed by reading from the device
memory region.  Setting device memory begins with writing the data to
the device memory region, followed by writing the position field.  Why
does the user need to have visibility of data position?  This is opaque
data to the user, the device should manage how the chunks fit together.

How does the user know when they reach the end?

Bullets 8 and 9 in patch 1 also discuss setting and getting the device
memory size, but these aren't well integrated into the protocol for
getting and setting the memory buffer.  Is getting the device memory
really started by reading the size, which triggers the vendor driver to
snapshot the state in an internal buffer which the user then iterates
through using GET_BUFFER?  Therefore re-reading the size field could
corrupt the data stream?  Wouldn't it be easier to report bytes
available and countdown as the user marks them read?  What does
position mean when we switch from snapshot to dirty data?

> 	} device_memory;
> 	struct {
> 		__u64 start_addr; /* wo */
> 		__u64 page_nr;   /* wo */
> 	} system_memory;
> };

Why is one specified as an address and the other as pages?  Note that
Kirti's implementation has an optimization to know how many pages are
set within a range to avoid unnecessary buffer reads.

> 
> Devcie States
> ------------- 
> After migration is initialzed, it will set device state via writing to
> device_state field of control region.
> 
> Four states are defined for a VFIO device:
>         RUNNING, RUNNING & LOGGING, STOP & LOGGING, STOP 
> 
> RUNNING: In this state, a VFIO device is in active state ready to receive
>         commands from device driver.
>         It is the default state that a VFIO device enters initially.
> 
> STOP:  In this state, a VFIO device is deactivated to interact with
>        device driver.
> 
> LOGGING: a special state that it CANNOT exist independently. It must be
>        set alongside with state RUNNING or STOP (i.e. RUNNING & LOGGING,
>        STOP & LOGGING).
>        Qemu will set LOGGING state on in .save_setup callbacks, then vendor
>        driver can start dirty data logging for device memory and system
>        memory.
>        LOGGING only impacts device/system memory. They return whole
>        snapshot outside LOGGING and dirty data since last get operation
>        inside LOGGING.
>        Device config should be always accessible and return whole config
>        snapshot regardless of LOGGING state.
>        
> Note:
> The reason why RUNNING is the default state is that device's active state
> must not depend on device state interface.
> It is possible that region vfio_device_state_ctl fails to get registered.
> In that condition, a device needs be in active state by default. 
> 
> Get Version & Get Caps
> ----------------------
> On migration init phase, qemu will probe the existence of device state
> regions of vendor driver, then get version of the device state interface
> from the r/w control region.
> 
> Then it will probe VFIO device's data capability by reading caps field of
> control region.
>         #define VFIO_DEVICE_DATA_CAP_DEVICE_MEMORY 1
>         #define VFIO_DEVICE_DATA_CAP_SYSTEM_MEMORY 2
> If VFIO_DEVICE_DATA_CAP_DEVICE_MEMORY is on, it will save/load data of
>         device memory in pre-copy and stop-and-copy phase. The data of
>         device memory is held in device memory region.
> If VFIO_DEVICE_DATA_CAP_SYSTEM_MEMORY is on, it will query of dirty pages
>         produced by VFIO device during pre-copy and stop-and-copy phase.
>         The dirty bitmap of system memory is held in dirty bitmap region.

As above, these capabilities seem redundant to the existence of the
device specific regions in this implementation.

> If failing to find two mandatory regions and optional data regions
> corresponding to data caps or version mismatching, it will setup a
> migration blocker and disable live migration for VFIO device.
> 
> 
> Flows to call device state interface for VFIO live migration
> ------------------------------------------------------------
> 
> Live migration save path:
> 
> (QEMU LIVE MIGRATION STATE --> DEVICE STATE INTERFACE --> DEVICE STATE)
> 
> MIGRATION_STATUS_NONE --> VFIO_DEVICE_STATE_RUNNING
>  |
> MIGRATION_STATUS_SAVE_SETUP
>  |
>  .save_setup callback -->
>  get device memory size (whole snapshot size)
>  get device memory buffer (whole snapshot data)
>  set device state --> VFIO_DEVICE_STATE_RUNNING & VFIO_DEVICE_STATE_LOGGING
>  |
> MIGRATION_STATUS_ACTIVE
>  |
>  .save_live_pending callback --> get device memory size (dirty data)
>  .save_live_iteration callback --> get device memory buffer (dirty data)
>  .log_sync callback --> get system memory dirty bitmap
>  |
> (vcpu stops) --> set device state -->
>  VFIO_DEVICE_STATE_STOP & VFIO_DEVICE_STATE_LOGGING
>  |
> .save_live_complete_precopy callback -->
>  get device memory size (dirty data)
>  get device memory buffer (dirty data)
>  get device config size (whole snapshot size)
>  get device config buffer (whole snapshot data)
>  |
> .save_cleanup callback -->  set device state --> VFIO_DEVICE_STATE_STOP
> MIGRATION_STATUS_COMPLETED
> 
> MIGRATION_STATUS_CANCELLED or
> MIGRATION_STATUS_FAILED
>  |
> (vcpu starts) --> set device state --> VFIO_DEVICE_STATE_RUNNING
> 
> 
> Live migration load path:
> 
> (QEMU LIVE MIGRATION STATE --> DEVICE STATE INTERFACE --> DEVICE STATE)
> 
> MIGRATION_STATUS_NONE --> VFIO_DEVICE_STATE_RUNNING
>  |
> (vcpu stops) --> set device state --> VFIO_DEVICE_STATE_STOP
>  |
> MIGRATION_STATUS_ACTIVE
>  |
> .load state callback -->
>  set device memory size, set device memory buffer, set device config size,
>  set device config buffer
>  |
> (vcpu starts) --> set device state --> VFIO_DEVICE_STATE_RUNNING
>  |
> MIGRATION_STATUS_COMPLETED
> 
> 
> 
> In source VM side,
> In precopy phase,
> if a device has VFIO_DEVICE_DATA_CAP_DEVICE_MEMORY on,
> qemu will first get whole snapshot of device memory in .save_setup
> callback, and then it will get total size of dirty data in device memory in
> .save_live_pending callback by reading device_memory.size field of control
> region.

This requires iterative reads of device memory buffer but the protocol
is unclear (to me) how the user knows how to do this or interact with
the position field. 

> Then in .save_live_iteration callback, it will get buffer of device memory's
> dirty data chunk by chunk from device memory region by writing pos &
> action (GET_BUFFER) to device_memory.pos & device_memory.action fields of
> control region. (size of each chunk is the size of device memory data
> region).

What if there's not enough dirty data to fill the region?  The data is
always padded to fill the region?

> .save_live_pending and .save_live_iteration may be called several times in
> precopy phase to get dirty data in device memory.
> 
> If VFIO_DEVICE_DATA_CAP_DEVICE_MEMORY is off, callbacks in precopy phase
> like .save_setup, .save_live_pending, .save_live_iteration will not call
> vendor driver's device state interface to get data from devcie memory.

Therefore through the entire precopy phase we have no data from source
to target to begin a compatibility check :-\  I think both proposals
currently still lack any sort of device compatibility or data
versioning check between source and target.  Thanks,

Alex

> In precopy phase, if a device has VFIO_DEVICE_DATA_CAP_SYSTEM_MEMORY on,
> .log_sync callback will get system memory dirty bitmap from dirty bitmap
> region by writing system memory's start address, page count and action 
> (GET_BITMAP) to "system_memory.start_addr", "system_memory.page_nr", and
> "system_memory.action" fields of control region.
> If page count passed in .log_sync callback is larger than the bitmap size
> the dirty bitmap region supports, Qemu will cut it into chunks and call
> vendor driver's get system memory dirty bitmap interface.
> If VFIO_DEVICE_DATA_CAP_SYSTEM_MEMORY is off, .log_sync callback just
> returns without call to vendor driver.
> 
> In stop-and-copy phase, device state will be set to STOP & LOGGING first.
> in save_live_complete_precopy callback,
> If VFIO_DEVICE_DATA_CAP_SYSTEM_MEMORY is on,
> get device memory size and get device memory buffer will be called again.
> After that,
> device config data is get from device config region by reading
> devcie_config.size of control region and writing action (GET_BITMAP) to
> device_config.action of control region.
> Then after migration completes, in cleanup handler, LOGGING state will be
> cleared (i.e. deivce state is set to STOP).
> Clearing LOGGING state in cleanup handler is in consideration of the case
> of "migration failed" and "migration cancelled". They can also leverage
> the cleanup handler to unset LOGGING state.
> 
> 
> References
> ----------
> 1. kernel side implementation of Device state interfaces:
> https://patchwork.freedesktop.org/series/56876/
> 
> 
> Yan Zhao (5):
>   vfio/migration: define kernel interfaces
>   vfio/migration: support device of device config capability
>   vfio/migration: tracking of dirty page in system memory
>   vfio/migration: turn on migration
>   vfio/migration: support device memory capability
> 
>  hw/vfio/Makefile.objs         |   2 +-
>  hw/vfio/common.c              |  26 ++
>  hw/vfio/migration.c           | 858 ++++++++++++++++++++++++++++++++++++++++++
>  hw/vfio/pci.c                 |  10 +-
>  hw/vfio/pci.h                 |  26 +-
>  include/hw/vfio/vfio-common.h |   1 +
>  linux-headers/linux/vfio.h    | 260 +++++++++++++
>  7 files changed, 1174 insertions(+), 9 deletions(-)
>  create mode 100644 hw/vfio/migration.c
> 
