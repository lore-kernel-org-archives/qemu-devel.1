Received: from eggs.gnu.org ([209.51.188.92]:44760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1h1xAk-0003KY-7d
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:51:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1h1xAg-00059r-Ft
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:51:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1h1xAg-00058Z-4G
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:51:06 -0500
Date: Thu, 7 Mar 2019 10:44:21 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190307104421.534ea56f@w520.home>
In-Reply-To: <20190225022255.GP16456@joy-OptiPlex-7040>
References: <1550566254-3545-1-git-send-email-yan.y.zhao@intel.com>
	<20190221134051.2c28893e@w520.home>
	<20190225022255.GP16456@joy-OptiPlex-7040>
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
To: Zhao Yan <yan.y.zhao@intel.com>
Cc: qemu-devel@nongnu.org, intel-gvt-dev@lists.freedesktop.org, Zhengxiao.zx@Alibaba-inc.com, yi.l.liu@intel.com, eskultet@redhat.com, ziye.yang@intel.com, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com, dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru, eauger@redhat.com, felipe@nutanix.com, jonathan.davies@nutanix.com, changpeng.liu@intel.com, Ken.Xue@amd.com, kwankhede@nvidia.com, kevin.tian@intel.com, cjia@nvidia.com, arei.gonglei@huawei.com, kvm@vger.kernel.org

Hi Yan,

Sorry for the delay, I've been on PTO...

On Sun, 24 Feb 2019 21:22:56 -0500
Zhao Yan <yan.y.zhao@intel.com> wrote:

> On Thu, Feb 21, 2019 at 01:40:51PM -0700, Alex Williamson wrote:
> > Hi Yan,
> > 
> > Thanks for working on this!
> > 
> > On Tue, 19 Feb 2019 16:50:54 +0800
> > Yan Zhao <yan.y.zhao@intel.com> wrote:
> >   
> > > This patchset enables VFIO devices to have live migration capability.
> > > Currently it does not support post-copy phase.
> > > 
> > > It follows Alex's comments on last version of VFIO live migration patches,
> > > including device states, VFIO device state region layout, dirty bitmap's
> > > query.
> > > 
> > > Device Data
> > > -----------
> > > Device data is divided into three types: device memory, device config,
> > > and system memory dirty pages produced by device.
> > > 
> > > Device config: data like MMIOs, page tables...
> > >         Every device is supposed to possess device config data.
> > >     	Usually device config's size is small (no big than 10M), and it  
> > 
> > I'm not sure how we can really impose a limit here, it is what it is
> > for a device.  A smaller state is obviously desirable to reduce
> > downtime, but some devices could have very large states.
> >   
> > >         needs to be loaded in certain strict order.
> > >         Therefore, device config only needs to be saved/loaded in
> > >         stop-and-copy phase.
> > >         The data of device config is held in device config region.
> > >         Size of device config data is smaller than or equal to that of
> > >         device config region.  
> > 
> > So the intention here is that this is the last data read from the
> > device and it's done in one pass, so the region needs to be large
> > enough to expose all config data at once.  On restore it's the last
> > data written before switching the device to the run state.
> >   
> > > 
> > > Device Memory: device's internal memory, standalone and outside system  
> > 
> > s/system/VM/
> >   
> > >         memory. It is usually very big.  
> > 
> > Or it doesn't exist.  Not sure we should be setting expectations since
> > it will vary per device.
> >   
> > >         This kind of data needs to be saved / loaded in pre-copy and
> > >         stop-and-copy phase.
> > >         The data of device memory is held in device memory region.
> > >         Size of devie memory is usually larger than that of device
> > >         memory region. qemu needs to save/load it in chunks of size of
> > >         device memory region.
> > >         Not all device has device memory. Like IGD only uses system memory.  
> > 
> > It seems a little gratuitous to me that this is a separate region or
> > that this data is handled separately.  All of this data is opaque to
> > QEMU, so why do we need to separate it?  
> hi Alex,
> as the device state interfaces are provided by kernel, it is expected to
> meet as general needs as possible. So, do you think there are such use
> cases from user space that user space knows well of the device, and
> it wants kernel to return desired data back to it.
> E.g. It just wants to get whole device config data including all mmios,
> page tables, pci config data...
> or, It just wants to get current device memory snapshot, not including any
> dirty data.
> Or, It just needs the dirty pages in device memory or system memory.
> With all this accurate query, quite a lot of useful features can be
> developped in user space.
> 
> If all of this data is opaque to user app, seems the only use case is
> for live migration.

I can certainly appreciate a more versatile interface, but I think
we're also trying to create the most simple interface we can, with the
primary target being live migration.  As soon as we start defining this
type of device memory and that type of device memory, we're going to
have another device come along that needs yet another because they have
a slightly different requirement.  Even without that, we're going to
have vendor drivers implement it differently, so what works for one
device for a more targeted approach may not work for all devices.  Can
you enumerate some specific examples of the use cases you imagine your
design to enable?

> From another aspect, if the final solution is to let the data opaque to
> user space, like what NV did, kernel side's implementation will be more
> complicated, and actually a little challenge to vendor driver.
> in that case, in pre-copy phase,
> 1. in not LOGGING state, vendor driver first returns full data including
> full device memory snapshot

When we're not LOGGING, does the vendor driver need to return
anything?  It seems that LOGGING could be considered an enable switch
for the interface.

> 2. user space reads some data (you can't expect it to finish reading all
> data)
> 3. then userspace set the device state to LOGGING to start dirty data
> logging
> 4. vendor driver starts dirty data logging, and appends the dirty data to
> the tail of remaining unread full data and increase the pending data size?

It seems a lot of overhead to expect the vendor driver to consider
state read by the user prior to LOGGING being enabled.  Does it log
those changes forever?  It seems like we should consider LOGGING
enabled to be a "session".

> 5. user space keeps reading data.
> 6. vendor driver keeps appending new dirty data to the tail of remaining
> unread full data/dirty data and increase the pending data size?

Until the device is stopped it can always generate new pending date and
the size of that pending data needs to be considered volatile by the
user, right?  What's different here?  This all seems to factor into
when the user decides whether the migration is converting and whether
to transition to stopped phase to force that convergence.

> in stop-and-copy phase
> 1. user space sets device state to exit LOGGING state,
> 2. vendor driver stops data logging. it has to append device config
>    data at the tail of remaining dirty data unread by userspace.
> 
> during this flow, when vendor driver should get dirty data? just keeps
> logging and appends to tail? how to ensure dirty data is refresh new before
> LOGGING state exit? how does vendor driver know whether certain dirty data
> is copied or not?

At stop-and-copy, I'd assume LOGGING remains enabled, only adding STOP,
such that the device does not generate new data, but perhaps I've
forgotten the details on vacation.  As above, I'd think we'd want to
bound any sort of dirty state tracking to a session bounded by the
LOGGING state.  The protocol defined with userspace needs to account
for determining what the user has and has not read, for instance to
support mmap'd data, a trapped interface needs to be used to setup the
data and acknowledge a read of that data.
 
> I've no idea how NVidia handle this problem, and they don't open their
> kernel side code. 
> just feel it's a bit hard for other vendor drivers to follow:)

Their interface proposal is available on the list, I don't have access
to their proprietary driver either, but I expect the best ideas from
each proposal to be combined into a unified solution.

> > > System memory dirty pages: If a device produces dirty pages in system
> > >         memory, it is able to get dirty bitmap for certain range of system
> > >         memory. This dirty bitmap is queried in pre-copy and stop-and-copy
> > >         phase in .log_sync callback. By setting dirty bitmap in .log_sync
> > >         callback, dirty pages in system memory will be save/loaded by ram's
> > >         live migration code.
> > >         The dirty bitmap of system memory is held in dirty bitmap region.
> > >         If system memory range is larger than that dirty bitmap region can
> > >         hold, qemu will cut it into several chunks and get dirty bitmap in
> > >         succession.
> > > 
> > > 
> > > Device State Regions
> > > --------------------
> > > Vendor driver is required to expose two mandatory regions and another two
> > > optional regions if it plans to support device state management.
> > > 
> > > So, there are up to four regions in total.
> > > One control region: mandatory.
> > >         Get access via read/write system call.
> > >         Its layout is defined in struct vfio_device_state_ctl
> > > Three data regions: mmaped into qemu.  
> > 
> > Is mmap mandatory?  I would think this would be defined by the mdev
> > device what access they want to support per region.  We don't want to
> > impose a more complicated interface if the device doesn't require it.  
> I think it's "mmap is preferred, but allowed to fail".
> just like a normal region with MMAP flag on (like bar regions), we also
> allow its mmap to fail, right?

Currently mmap support for any region is optional both from the vendor
driver and the user.  The vendor driver may or may not support mmap of
a region (or subset of region with sparse mmap) and the user may or may
not make use of mmap if it is available.  The question here was whether
this interface requires the vendor driver to support mmap of these
device specific regions.

> > >         device config region: mandatory, holding data of device config
> > >         device memory region: optional, holding data of device memory
> > >         dirty bitmap region: optional, holding bitmap of system memory
> > >                             dirty pages
> > > 
> > > (The reason why four seperate regions are defined is that the unit of mmap
> > > system call is PAGE_SIZE, i.e. 4k bytes. So one read/write region for
> > > control and three mmaped regions for data seems better than one big region
> > > padded and sparse mmaped).  
> > 
> > It's not obvious to me how this is better, a big region isn't padded,
> > there's simply a gap in the file descriptor.  Is having a sub-PAGE_SIZE
> > gap in a file really of any consequence?  Each region beyond the header
> > is more than likely larger than PAGE_SIZE, therefore they can be nicely
> > aligned together.  We still need fields to tell us how much data is
> > available in each area, so another to tell us the start of each area is
> > a minor detail.  And I think we still want to allow drivers to specify
> > which parts of which areas support mmap, so I don't think we're getting
> > away from sparse mmap support.  
> 
> with seperate regions and sub-region type defined, user space can explictly
> know which region is which region after vfio_get_dev_region_info(). along
> with it, user space knows region offset and size. mmap is allowed to fail
> and falls back to normal read/write to the region.
> 
> But with one big region and sparse mmapped subregions (1 data subregion or
> 3 data subregions, whatever), userspace can't tell which subregion is which
> one.

Of course they can, this is part of defining the header structure.  One
region could define a header including config_offset, config_size,
memory_offset, memory_size, dirty_offset, dirty_size.  Notice how Kirti
even uses the same area to support all of these (which leaves some
issues with vendor driver flexibility, but at least shows this is
possible).

> So, if using one big region, I think we need to explictly define
> subregions' sequence (like index 0 is dedicated to control subregion,
> index 1 is for device config data subregion ...). Vendor driver cannot
> freely change the sequence.
> Then keep data offset the same as region->mmaps[i].offset, and data size
> the same as region->mmaps[i].size. (i.e. let actual data starts immediatly
> from first byte of its data subregion)
> Also, mmaps for sparse mmaped subregions are not allowed to fail.

This doesn't make any sense to me, the vendor driver can define the
start and size of each area within the region with simple header
fields.  We don't need fixed sequence fields.  Likewise the sparse mmap
capability for the region can define which of those areas within the
region support mmap.  The mmap can be optional for both vendor driver
and user, just as it is elsewhere.  The header fields defining the
sub-areas can be read-only to the user, the sparse mmap only needs to
match what the vendor driver defines and supports.
 
> With one big region, we also need to consider the case when vendor driver
> does not want the data subregion to be mmaped.
> so, what is the data layout for that case?

Vendor driver defines data_offset and data_size, sparse mmap capability
does not list that area as mmap capable.

> data subregion immedately follows control subregion, or not?

The header needs to begin at offset zero, the layout of the rest is
defined by the vendor driver within this header.  I believe this is
(mostly) implemented in Kirti's version.

> Of couse, for this condition, we can specify the data filed's start offset
> and size through control region. And we must not expect the data start
> offset in source and target are equal.
> (because the big region's fd_offset
> may vary in source and target. consider the case when both source and
> target have one opregion and one device state region, but source has
> opregion in the first and target has device state region in the first.
> If we think this case is illegal, we must be able to detect it in the first
> place).
> Also, we must keep the start offset and size consistent with the above mmap
> case.

AFAICT, these are all non-issues.  Please look at Kirti's proposal.
The (one) migration region can define a header at offset zero that
allows the vendor driver to define where within that region the data,
config, and dirty bitmap areas are and the sparse mmap capability
defines which of those are mmap capable.  Clearly this migration region
offset within the vfio device file descriptor is independent between
source and target, as are the offsets of the sub-areas within the
migration region.  These all need to be defined as part of the
migration protocol where the source and target implement the same
protocol but have no requirement to be absolutely identical.

> > > kernel device state interface [1]
> > > --------------------------------------
> > > #define VFIO_DEVICE_STATE_INTERFACE_VERSION 1
> > > #define VFIO_DEVICE_DATA_CAP_DEVICE_MEMORY 1
> > > #define VFIO_DEVICE_DATA_CAP_SYSTEM_MEMORY 2  
> > 
> > If we were to go with this multi-region solution, isn't it evident from
> > the regions exposed that device memory and a dirty bitmap are
> > provided?  Alternatively, I believe Kirti's proposal doesn't require  
> 
> > this distinction between device memory and device config, a device not
> > requiring runtime migration data would simply report no data until the
> > device moved to the stopped state, making it consistent path for
> > userspace.  Likewise, the dirty bitmap could report a zero page count
> > in the bitmap rather than branching based on device support.  
> If the path in userspace is consistent for device config and device
> memory, there will be many unnecessary call of getting data size into
> vendor driver.

Consistency seems like a good thing, it makes code more simple, we
don't behave differently in one case versus another.  If the vendor
reports no data, skip.  It also provides versatility.  Are the "many
unnecessary call[s]" quantifiable?

> > Note that it seems that cap VFIO_DEVICE_DATA_CAP_SYSTEM_MEMORY implies
> > VFIO_REGION_SUBTYPE_DEVICE_STATE_DATA_DIRTYBITMAP, but there's no
> > consistency in the naming.
> >   
> > > #define VFIO_DEVICE_STATE_RUNNING 0 
> > > #define VFIO_DEVICE_STATE_STOP 1
> > > #define VFIO_DEVICE_STATE_LOGGING 2  
> > 
> > It looks like these are being defined as bits, since patch 1 talks
> > about RUNNING & LOGGING and STOP & LOGGING.  I think Connie already
> > posted some comments about this.  I'm not sure anything prevents us
> > from defining RUNNING a 1 and STOPPED as 0 so we don't have the
> > polarity flip vs LOGGING though.
> > 
> > The state "STOP & LOGGING" also feels like a strange "device state", if
> > the device is stopped, it's not logging any new state, so I think this
> > is more that the device state is STOP, but the LOGGING feature is
> > active.  Maybe we should consider these independent bits.  LOGGING is
> > active as we stop a device so that we can fetch the last dirtied pages,
> > but disabled as we load the state of the device into the target.
> >   
> > > #define VFIO_DEVICE_DATA_ACTION_GET_BUFFER 1
> > > #define VFIO_DEVICE_DATA_ACTION_SET_BUFFER 2
> > > #define VFIO_DEVICE_DATA_ACTION_GET_BITMAP 3
> > > 
> > > struct vfio_device_state_ctl {
> > > 	__u32 version;		  /* ro */
> > > 	__u32 device_state;       /* VFIO device state, wo */
> > > 	__u32 caps;		 /* ro */
> > >         struct {
> > > 		__u32 action;  /* wo, GET_BUFFER or SET_BUFFER */ 
> > > 		__u64 size;    /*rw*/
> > > 	} device_config;  
> > 
> > Patch 1 indicates that to get the config buffer we write GET_BUFFER to
> > action and read from the config region.  The size is previously read
> > and apparently constant.  To set the config buffer, the config region
> > is written followed by writing SET_BUFFER to action.  Why is size
> > listed as read-write?  
> this is the size of config data.
> size of config data <= size of config data region.

Where in the usage protocol does the user WRITE the config data size?

> > Doesn't this protocol also require that the mdev driver consume each
> > full region's worth of host kernel memory for backing pages in
> > anticipation of a rare event like migration?  This might be a strike
> > against separate regions if the driver needs to provide backing pages
> > for 3 separate regions vs 1.  To avoid this runtime overhead, would it
> > be expected that the user only mmap the regions during migration and
> > the mdev driver allocate backing pages on mmap?  Should the mmap be
> > restricted to the LOGGING feature being enabled?  Maybe I'm mistaken in
> > how the mdev driver would back these mmap'd pages.
> >  
> yes, 3 seperate regions consume a little more memory than 1 region.
> but it's just a little overhead.
> As in intel's kernel implementation,
> device config region's size is 9M, dirty bitmap region's size is 16k.
> if there is device memory region, its size can be defined as 100M?
> so it's 109M vs 100M ?

But what if it's 100M config with no device memory?  This proposal
requires 100M in-kernel backing due to the definition of the config
region when it could be implemented with significantly less by allowing
a small data area to be read multiple times until a bytes remaining
counter becomes zero.

> > > 	struct {
> > > 		__u32 action;    /* wo, GET_BUFFER or SET_BUFFER */ 
> > > 		__u64 size;     /* rw */  
> > >                 __u64 pos; /*the offset in total buffer of device memory*/  
> > 
> > Patch 1 outlines the protocol here that getting device memory begins
> > with writing the position field, followed by reading from the device
> > memory region.  Setting device memory begins with writing the data to
> > the device memory region, followed by writing the position field.  Why
> > does the user need to have visibility of data position?  This is opaque
> > data to the user, the device should manage how the chunks fit together.
> > 
> > How does the user know when they reach the end?  
> sorry, maybe I didn't explain clearly here.
> 
> device  ________________________________________
> memory  |    |    |////|    |    |    |    |    |
> data:   |____|____|////|____|____|____|____|____|
>                   :pos :
>                   :    :
> device            :____:
> memory            |    |
> region:           |____|
> 
> the whole sequence is like this:
> 
> 1. user space reads device_memory.size
> 2. driver gets device memory's data(full snapshot or dirty data, depending
> on it's in LOGGING state or not), and return the total size of
> this data. 
> 3. user space finishes reading device_memory.size (>= device memory
> region's size)
> 
> 4. user space starts a loop like
>   
>    while (pos < total_len) {
>         uint64_t len = region_devmem->size;
> 
>         if (pos + len >= total_len) {
>             len = total_len - pos;
>         }
>         if (vfio_save_data_device_memory_chunk(vdev, f, pos, len)) {
>             return -1;
>         }
> 	pos += len;
>     }
> 
>  vfio_save_data_device_memory_chunk reads each chunk from device memory
>  region by writing GET_BUFFER  to device_memory.action, and pos to
>  device_memory.pos.
> 
> 
> so. each time, userspace will finish getting device memory data in one
> time.
> 
> specifying "pos" is just like the "lseek" before "write".

This could also be implemented as a remaining bytes counter in the
interface where the vendor driver wouldn't rely on the user to manage
the position.  What internal consistency checking is going to protect
the host kernel when the user writes data to the wrong position?  If we
consider the data to be opaque, the vendor driver can embed that sort
of meta data into the data blob the user reads and reassemble it
correctly or generate a consistency failure itself.

> > Bullets 8 and 9 in patch 1 also discuss setting and getting the device
> > memory size, but these aren't well integrated into the protocol for
> > getting and setting the memory buffer.  Is getting the device memory
> > really started by reading the size, which triggers the vendor driver to
> > snapshot the state in an internal buffer which the user then iterates
> > through using GET_BUFFER?  Therefore re-reading the size field could
> > corrupt the data stream?  Wouldn't it be easier to report bytes
> > available and countdown as the user marks them read?  What does
> > position mean when we switch from snapshot to dirty data?  
> when switching to device memory's dirty data, pos means the pos in whole
> dirty data.
> 
> .save_live_pending ==> driver gets dirty data in device memory and returns
> total size.
> 
> .save_live_iterate ==> userspace reads all dirty data from device memory
> region chunk by chunk
> 
> So, in an iteration, all dirty data are saved.
> then in next iteration, dirty data is recalculated.
> 
> > > 	} device_memory;
> > > 	struct {
> > > 		__u64 start_addr; /* wo */
> > > 		__u64 page_nr;   /* wo */
> > > 	} system_memory;
> > > };  
> > 
> > Why is one specified as an address and the other as pages?  Note that  
> Yes, start_addr ==> start pfn is better
> 
> > Kirti's implementation has an optimization to know how many pages are
> > set within a range to avoid unnecessary buffer reads.
> >   
> 
> Let's use start_pfn_all, page_nr_all to represent the start pfn and
> page_nr passed in from qemu .log_sync interface.
> 
> and use start_pfn_i, page_nr_i to the value passed to driver.
> 
> 
> start_pfn_all
>   |         start_pfn_i
>   |         |
>  \ /_______\_/_____________________________
>   |    |    |////|    |    |    |    |    |
>   |____|____|////|____|____|____|____|____|
>             :    :
>             :    :
>             :____:
> bitmap      |    |
> region:     |____|
>            
> 
> 1. Each time QEMU queries dirty bitmap from driver, it passes in
> start_pfn_i, and page_nr_i. (page_nr_i is the biggest page number the
> bitmap region can hold).
> 2. driver queries memory range from start_pfn_i with size page_nr_i.
> 3. driver return a bitmap (if no dirty data, the bitmap is all 0).
> 4. QEMU saves the pages according to the bitmap
> 
> If there's no dirty data found in step 2, step 4 can be skipped.
> (I'll add this check before step 4 in future, thanks)
> but if there's even 1 bit set in the bitmap, no step from 1-4 can be
> skipped.
> 
> Honestly, after reviewing Kirti's implementation, I don't think it's an
> optimization. As in below pseudo code for Kirti's code, I would think the
> copied_pfns corresponds to the page_nr_i in my case. so, the case of
> copied_pfns equaling to 0 is for the tail chunk? don't think it's working..
> 
> write start_pfn to driver
> write page_size  to driver
> write pfn_count to driver
> 
> do {
>     read copied_pfns from driver.
>     if (copied_pfns == 0) {
>        break;
>     }
>    bitmap_size = (BITS_TO_LONGS(copied_pfns) + 1) * sizeof(unsigned long);
>    buf = get bitmap from driver
>    cpu_physical_memory_set_dirty_lebitmap((unsigned long *)buf,
>                                            (start_pfn + count) * page_size,
>                                                 copied_pfns);
> 
>      count +=  copied_pfns;
> 
> } while (count < pfn_count);

The intent of Kirti's copied_pfns is clearly to avoid unnecessarily
reading pages from the kernel when nothing has changed.  Perhaps the
implementation still requires work, but I don't see from above how
that's not considered an optimization.

> > > 
> > > Devcie States
> > > ------------- 
> > > After migration is initialzed, it will set device state via writing to
> > > device_state field of control region.
> > > 
> > > Four states are defined for a VFIO device:
> > >         RUNNING, RUNNING & LOGGING, STOP & LOGGING, STOP 
> > > 
> > > RUNNING: In this state, a VFIO device is in active state ready to receive
> > >         commands from device driver.
> > >         It is the default state that a VFIO device enters initially.
> > > 
> > > STOP:  In this state, a VFIO device is deactivated to interact with
> > >        device driver.
> > > 
> > > LOGGING: a special state that it CANNOT exist independently. It must be
> > >        set alongside with state RUNNING or STOP (i.e. RUNNING & LOGGING,
> > >        STOP & LOGGING).
> > >        Qemu will set LOGGING state on in .save_setup callbacks, then vendor
> > >        driver can start dirty data logging for device memory and system
> > >        memory.
> > >        LOGGING only impacts device/system memory. They return whole
> > >        snapshot outside LOGGING and dirty data since last get operation
> > >        inside LOGGING.
> > >        Device config should be always accessible and return whole config
> > >        snapshot regardless of LOGGING state.
> > >        
> > > Note:
> > > The reason why RUNNING is the default state is that device's active state
> > > must not depend on device state interface.
> > > It is possible that region vfio_device_state_ctl fails to get registered.
> > > In that condition, a device needs be in active state by default. 
> > > 
> > > Get Version & Get Caps
> > > ----------------------
> > > On migration init phase, qemu will probe the existence of device state
> > > regions of vendor driver, then get version of the device state interface
> > > from the r/w control region.
> > > 
> > > Then it will probe VFIO device's data capability by reading caps field of
> > > control region.
> > >         #define VFIO_DEVICE_DATA_CAP_DEVICE_MEMORY 1
> > >         #define VFIO_DEVICE_DATA_CAP_SYSTEM_MEMORY 2
> > > If VFIO_DEVICE_DATA_CAP_DEVICE_MEMORY is on, it will save/load data of
> > >         device memory in pre-copy and stop-and-copy phase. The data of
> > >         device memory is held in device memory region.
> > > If VFIO_DEVICE_DATA_CAP_SYSTEM_MEMORY is on, it will query of dirty pages
> > >         produced by VFIO device during pre-copy and stop-and-copy phase.
> > >         The dirty bitmap of system memory is held in dirty bitmap region.  
> > 
> > As above, these capabilities seem redundant to the existence of the
> > device specific regions in this implementation.
> >  
> seems so :)
> 
> > > If failing to find two mandatory regions and optional data regions
> > > corresponding to data caps or version mismatching, it will setup a
> > > migration blocker and disable live migration for VFIO device.
> > > 
> > > 
> > > Flows to call device state interface for VFIO live migration
> > > ------------------------------------------------------------
> > > 
> > > Live migration save path:
> > > 
> > > (QEMU LIVE MIGRATION STATE --> DEVICE STATE INTERFACE --> DEVICE STATE)
> > > 
> > > MIGRATION_STATUS_NONE --> VFIO_DEVICE_STATE_RUNNING
> > >  |
> > > MIGRATION_STATUS_SAVE_SETUP
> > >  |
> > >  .save_setup callback -->
> > >  get device memory size (whole snapshot size)
> > >  get device memory buffer (whole snapshot data)
> > >  set device state --> VFIO_DEVICE_STATE_RUNNING & VFIO_DEVICE_STATE_LOGGING
> > >  |
> > > MIGRATION_STATUS_ACTIVE
> > >  |
> > >  .save_live_pending callback --> get device memory size (dirty data)
> > >  .save_live_iteration callback --> get device memory buffer (dirty data)
> > >  .log_sync callback --> get system memory dirty bitmap
> > >  |
> > > (vcpu stops) --> set device state -->
> > >  VFIO_DEVICE_STATE_STOP & VFIO_DEVICE_STATE_LOGGING
> > >  |
> > > .save_live_complete_precopy callback -->
> > >  get device memory size (dirty data)
> > >  get device memory buffer (dirty data)
> > >  get device config size (whole snapshot size)
> > >  get device config buffer (whole snapshot data)
> > >  |
> > > .save_cleanup callback -->  set device state --> VFIO_DEVICE_STATE_STOP
> > > MIGRATION_STATUS_COMPLETED
> > > 
> > > MIGRATION_STATUS_CANCELLED or
> > > MIGRATION_STATUS_FAILED
> > >  |
> > > (vcpu starts) --> set device state --> VFIO_DEVICE_STATE_RUNNING
> > > 
> > > 
> > > Live migration load path:
> > > 
> > > (QEMU LIVE MIGRATION STATE --> DEVICE STATE INTERFACE --> DEVICE STATE)
> > > 
> > > MIGRATION_STATUS_NONE --> VFIO_DEVICE_STATE_RUNNING
> > >  |
> > > (vcpu stops) --> set device state --> VFIO_DEVICE_STATE_STOP
> > >  |
> > > MIGRATION_STATUS_ACTIVE
> > >  |
> > > .load state callback -->
> > >  set device memory size, set device memory buffer, set device config size,
> > >  set device config buffer
> > >  |
> > > (vcpu starts) --> set device state --> VFIO_DEVICE_STATE_RUNNING
> > >  |
> > > MIGRATION_STATUS_COMPLETED
> > > 
> > > 
> > > 
> > > In source VM side,
> > > In precopy phase,
> > > if a device has VFIO_DEVICE_DATA_CAP_DEVICE_MEMORY on,
> > > qemu will first get whole snapshot of device memory in .save_setup
> > > callback, and then it will get total size of dirty data in device memory in
> > > .save_live_pending callback by reading device_memory.size field of control
> > > region.  
> > 
> > This requires iterative reads of device memory buffer but the protocol
> > is unclear (to me) how the user knows how to do this or interact with
> > the position field. 
> >   
> > > Then in .save_live_iteration callback, it will get buffer of device memory's
> > > dirty data chunk by chunk from device memory region by writing pos &
> > > action (GET_BUFFER) to device_memory.pos & device_memory.action fields of
> > > control region. (size of each chunk is the size of device memory data
> > > region).  
> > 
> > What if there's not enough dirty data to fill the region?  The data is
> > always padded to fill the region?
> >  
> I think dirty data in vendor driver is orgnaized in a format like:
> (addr0, len0, data0, addr1, len1, data1, addr2, len2, data2,....addrN,
> lenN, dataN).
> for full snapshot, it's like (addr0, len0, data0).
> so, to userspace and data region, it doesn't matter whether it's full
> snapshot or dirty data.
> 
> 
> > > .save_live_pending and .save_live_iteration may be called several times in
> > > precopy phase to get dirty data in device memory.
> > > 
> > > If VFIO_DEVICE_DATA_CAP_DEVICE_MEMORY is off, callbacks in precopy phase
> > > like .save_setup, .save_live_pending, .save_live_iteration will not call
> > > vendor driver's device state interface to get data from devcie memory.  
> > 
> > Therefore through the entire precopy phase we have no data from source
> > to target to begin a compatibility check :-\  I think both proposals
> > currently still lack any sort of device compatibility or data
> > versioning check between source and target.  Thanks,  
> I checked the compatibility, though not good enough:)
> 
> in migration_init, vfio_check_devstate_version() checked version from
> kernel with VFIO_DEVICE_STATE_INTERFACE_VERSION in both source and target,
> and in target side, vfio_load_state() checked source side version.
> 
> 
> int vfio_load_state(QEMUFile *f, void *opaque, int version_id)                          
> {       
>     ...
>     if (version_id != VFIO_DEVICE_STATE_INTERFACE_VERSION) {                                   
>         return -EINVAL;
>     } 
>     ...
> }

But this only checks that both source and target are using the same
migration interface, how do we know that they're compatible devices and
that the vendor data stream is compatible between source and target?
Whether both ends use the same migration interface is potentially not
relevant if the data stream is compatible.  Thanks,

Alex
