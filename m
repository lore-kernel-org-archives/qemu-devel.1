Received: from eggs.gnu.org ([209.51.188.92]:50872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1h1yxM-0007ZN-Bl
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 14:45:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1h1yxK-0005jA-6f
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 14:45:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1h1yxJ-0005hH-Ry
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 14:45:26 -0500
Date: Thu, 7 Mar 2019 12:45:18 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190307124518.37a0908a@w520.home>
In-Reply-To: <f15fecfe-26c0-05fa-da3b-20156145d287@nvidia.com>
References: <1550611400-13703-1-git-send-email-kwankhede@nvidia.com>
	<1550611400-13703-2-git-send-email-kwankhede@nvidia.com>
	<20190221152344.431ced05@w520.home>
	<f15fecfe-26c0-05fa-da3b-20156145d287@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/5] VFIO KABI for migration interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kirti Wankhede <kwankhede@nvidia.com>
Cc: cjia@nvidia.com, kevin.tian@intel.com, ziye.yang@intel.com, changpeng.liu@intel.com, yi.l.liu@intel.com, mlevitsk@redhat.com, eskultet@redhat.com, cohuck@redhat.com, dgilbert@redhat.com, jonathan.davies@nutanix.com, eauger@redhat.com, aik@ozlabs.ru, pasic@linux.ibm.com, felipe@nutanix.com, Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com, Ken.Xue@amd.com, zhi.a.wang@intel.com, yan.y.zhao@intel.com, yulei.zhang@intel.com, qemu-devel@nongnu.org

On Wed, 27 Feb 2019 01:35:01 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> Alex,
> 
> On 2/22/2019 3:53 AM, Alex Williamson wrote:
> > On Wed, 20 Feb 2019 02:53:16 +0530
> > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >   
> >> - Defined MIGRATION region type and sub-type.
> >> - Used 2 bits to define VFIO device states.
> >>     Bit 0 => 0/1 => _STOPPED/_RUNNING
> >>     Bit 1 => 0/1 => _RESUMING/_SAVING
> >>     Combination of these bits defines VFIO device's state during migration
> >>     _RUNNING => Normal VFIO device running state.
> >>     _STOPPED => VFIO device stopped.
> >>     _SAVING | _RUNNING => vCPUs are running, VFIO device is running but start
> >>                           saving state of device i.e. pre-copy state
> >>     _SAVING | _STOPPED => vCPUs are stoppped, VFIO device should be stopped, and
> >>                           save device state,i.e. stop-n-copy state
> >>     _RESUMING => VFIO device resuming state.  
> > 
> > Shouldn't we have a non-_RESUMING/_SAVING run state?  If these are
> > indicating directly flow, maybe we need two bits:
> > 
> >   00b - None, normal runtime
> >   01b - Saving
> >   10b - Resuming
> >   11b - Invalid/reserved (maybe a Failed state indicator)
> >   
> 
> There has to be 2 more states:
> _SAVING | _RUNNING => SAVING while device is RUNNING - pre-copy phase
> _SAVING | _STOPPED => SAVING while device is STOPPED - stop-and-copy phase

Sorry, this was unclear, a separate third bit would need to be the stop
bit, the above was only focusing on the data direction, because...

> So the 2 bits used in this patch are:
> 00b - _RESUMING

This is actually:

_RESUMING | _STOPPED

> 01b - _RUNNING - Normal Running

And this is really:

_RESUMING | _RUNNING

We're just selectively ignoring _RESUMING when we choose to.  So my
question is really more like:

|0|00|
 ^ ^^
 | ||
 | |+-- Saving
 | +--- Resuming
 +----- Stopped

Where Saving|Resuming both set is either invalid or a failure indicator.

> 10b - _SAVING | _STOPPED - stop-and-copy phase
> 11b - _SAVING | _RUNNING - pre-copy phase
> 
> 
> >> - Defined vfio_device_migration_info structure which will be placed at 0th
> >>   offset of migration region to get/set VFIO device related information.
> >>   Defined members of structure and usage on read/write access:
> >>     * device_state: (write only)
> >>         To convey VFIO device state to be transitioned to.  
> > 
> > Seems trivial and potentially useful to support read here, we have 30
> > (or maybe 29) bits yet to define.
> >   
> 
> Ok, those bits can be used later.
> 
> >>     * pending bytes: (read only)
> >>         To get pending bytes yet to be migrated for VFIO device
> >>     * data_offset: (read/write)
> >>         To get or set data offset in migration from where data exist
> >>         during _SAVING and _RESUMING state  
> > 
> > What's the use case for writing this?
> >   
> 
> During resuming, user space application (QEMU) writes data to migration
> region. At that time QEMU writes data_offset from where data is written,
> so that vendor driver can read data from that offset. If data section is
> mmapped, data_offset is start of mmapped region where as if data section
> is trapped, data_offset is sizeof(struct vfio_device_migration_info) +
> 1, just after vfio_device_migration_info structure.

It doesn't make sense to me that this proposal allows the user to write
wherever they want, the vendor driver defines whether they support mmap
for a given operation and the user can choose to make use of mmap or
not.  Therefore I'd suggest that the vendor driver expose a read-only
data_offset that matches a sparse mmap capability entry should the
driver support mmap.  The use should always read or write data from the
vendor defined data_offset.  Otherwise we have scenarios like the other
patch I commented on where the user implicitly decides that the first
mmap region large enough is the one to be used for a given operation,
removing the vendor driver's ability to decide whether it wants to
support mmap for that operation.

> >>     * data_size: (write only)
> >>         To convey size of data copied in migration region during _RESUMING
> >>         state  
> > 
> > How to know how much is available for read?  
> 
> pending_bytes tells how much is still to be read.

But pending_bytes can be bigger than the region, right?  Does the data
area necessarily extend to the end of the region?
 
> >>     * start_pfn, page_size, total_pfns: (write only)
> >>         To get bitmap of dirty pages from vendor driver from given
> >>         start address for total_pfns.  
> > 
> > What would happen if a user wrote in 1MB for page size?  Is the vendor
> > driver expected to support arbitrary page sizes?  Are we only trying to
> > convey the page size and would that page size ever be other than
> > getpagesize()?
> >   
> >>     * copied_pfns: (read only)
> >>         To get number of pfns bitmap copied in migration region.
> >>         Vendor driver should copy the bitmap with bits set only for
> >>         pages to be marked dirty in migration region. Vendor driver
> >>         should return 0 if there are 0 pages dirty in requested
> >>         range.  
> > 
> > This is useful, but I wonder if it's really a required feature for the
> > vendor driver.  For instance, with mdev IOMMU support we could wrap an
> > arbitrary PCI device as mdev, but we don't necessarily have dirty page
> > tracking.  Would a device need to report -1 here if it wanted to
> > indicate any page could be dirty if we only know how to collect the
> > state of the device itself for migration (ie. force the device to be
> > stopped first).
> >    
> 
> Does that mean if returned -1 here, mark all pages in the section as dirty?

Yes
 
> >> Migration region looks like:
> >>  ------------------------------------------------------------------
> >> |vfio_device_migration_info|    data section                      |
> >> |                          |     ///////////////////////////////  |
> >>  ------------------------------------------------------------------  
> >                              ^ what's this?
> >   
> >>  ^                              ^                              ^
> >>  offset 0-trapped part        data.offset                 data.size  
> > 
> > Isn't data.size above really (data.offset + data.size)?  '.' vs '_'
> > inconsistency vs above.
> >    
> 
> Yes, it should be '_'. I'll correct that.
> 
> 
> >> Data section is always followed by vfio_device_migration_info
> >> structure in the region, so data.offset will always be none-0.  
> > 
> > This seems exactly backwards from the diagram, data section follows
> > vfio_device_migration_info.  Also, "non-zero".
> >   
> >> Offset from where data is copied is decided by kernel driver, data  
> > 
> > But data_offset is listed as read-write.
> >   
> 
> data_offset is read during _SAVING state so QEMU knows from where to
> read data
> data_offset is written during _RESUMING state so that QEMU can convey
> offset in migration region to vendor driver from where data should be
> considered as input data.

Please let's drop the idea that the user can write data to an arbitrary
offset within the region.  Does it serve any value?
 
> >> section can be trapped or mapped depending on how kernel driver
> >> defines data section. If mmapped, then data.offset should be page
> >> aligned, where as initial section which contain
> >> vfio_device_migration_info structure might not end at offset which
> >> is page aligned.
> >>
> >> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> >> Reviewed-by: Neo Jia <cjia@nvidia.com>
> >> ---
> >>  linux-headers/linux/vfio.h | 65 ++++++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 65 insertions(+)
> >>
> >> diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
> >> index 12a7b1dc53c8..1b12a9b95e00 100644
> >> --- a/linux-headers/linux/vfio.h
> >> +++ b/linux-headers/linux/vfio.h
> >> @@ -368,6 +368,71 @@ struct vfio_region_gfx_edid {
> >>   */
> >>  #define VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD	(1)
> >>  
> >> +/* Migration region type and sub-type */
> >> +#define VFIO_REGION_TYPE_MIGRATION	        (2)
> >> +#define VFIO_REGION_SUBTYPE_MIGRATION	        (1)
> >> +
> >> +/**
> >> + * Structure vfio_device_migration_info is placed at 0th offset of
> >> + * VFIO_REGION_SUBTYPE_MIGRATION region to get/set VFIO device related migration
> >> + * information. Field accesses from this structure are only supported at their
> >> + * native width and alignment, otherwise should return error.
> >> + *
> >> + * device_state: (write only)
> >> + *      To indicate vendor driver the state VFIO device should be transitioned
> >> + *      to. If device state transition fails, write to this field return error.
> >> + *      It consists of 2 bits.
> >> + *      - If bit 0 set, indicates _RUNNING state. When its reset, that indicates
> >> + *        _STOPPED state. When device is changed to _STOPPED, driver should stop
> >> + *        device before write returns.
> >> + *      - If bit 1 set, indicates _SAVING state. When its reset, that indicates
> >> + *        _RESUMING state.
> >> + *
> >> + * pending bytes: (read only)
> >> + *      Read pending bytes yet to be migrated from vendor driver  
> > 
> > Is this essentially a volatile value, changing based on data previously
> > copied and device activity?  
> 
> Yes.
> 
> >   
> >> + *
> >> + * data_offset: (read/write)
> >> + *      User application should read data_offset in migration region from where
> >> + *      user application should read data during _SAVING state.
> >> + *      User application would write data_offset in migration region from where
> >> + *      user application is had written data during _RESUMING state.  
> > 
> > Why wouldn't data_offset simply be fixed?  Do we really want to support
> > the user writing a arbitrary offsets in the migration region?  Each
> > chunk can simply start at the kernel provided data_offset.
> >  
> 
> data_offset differs based on region is trapped on mapped. In case when
> region is mmaped, QEMU writes data to mapped region and then write
> data_offset field, indicating data is present in mmaped buffer. Read
> below for more detailed steps.
> 
> >> + *
> >> + * data_size: (write only)
> >> + *      User application should write size of data copied in migration region
> >> + *      during _RESUMING state.  
> > 
> > How much does the user read on _SAVING then?
> >   
> 
> pending_bytes tells bytes that should be read on _SAVING.

So pending_bytes is always less than or equal to the size of the
region, thus pending_bytes cannot be used to gauge the _total_ pending
device state?

> >> + *
> >> + * start_pfn: (write only)
> >> + *      Start address pfn to get bitmap of dirty pages from vendor driver duing
> >> + *      _SAVING state.
> >> + *
> >> + * page_size: (write only)
> >> + *      User application should write the page_size of pfn.
> >> + *
> >> + * total_pfns: (write only)
> >> + *      Total pfn count from start_pfn for which dirty bitmap is requested.  
> > 
> > So effectively the area that begins at data_offset is dual purpose
> > (triple purpose vs Yan's, config, memory, and dirty bitmap) but the
> > protocol isn't entirely evident to me. I think we need to write it out
> > as Yan provided.  If I'm in the _SAVING state, do I simply read from
> > data_offset to min(data_size, region.size - data_offset)?  If that area
> > is mmap'd, how does the user indicate to the kernel to prepare the data
> > or that X bytes were acquired?  In the _RESUMING state, do I write from
> > data_offset to min(data_size, region.size - data_offset) and indicate
> > the write using data_size?
> >   
> 
> Let me list down the steps for each state, hope that helps to answer all
> above questions.
> 
> In _SAVING|_RUNNING device state:
> - read pending_bytes
> - read data_offset - indicates kernel driver to write data to staging
> buffer which is mmapped.
> - if data section is trapped, pread() from data_offset to
> min(pending_bytes, remaining_region)
> - if data section is mmaped, read mmaped buffer of size
> min(pending_bytes, remaining_region)

Ok, pending_bytes can describe more than the region currently holds.
It still seems worthwhile to have a data_size so that we can extend
this interface.  For instance what if a driver wanted to trap data
accesses but mmap a dirty bitmap.  This interface doesn't allow for
that since they're both necessarily covered by the same sparse mmap
offset.

> - Write data packet to file stream as below:
> {VFIO_MIG_FLAG_DEV_DATA_STATE, data_size, actual data,
> VFIO_MIG_FLAG_END_OF_STATE }
> 
> 
> In _SAVING|_STOPPED device state:
> a. read config space of device and save to migration file stream. This
> doesn't need to be from vendor driver. Any other special config state
> from driver can be saved as data in following iteration.
> b. read pending_bytes - indicates kernel driver to write data to staging
> buffer which is mmapped.
> c. if data section is trapped, pread() from data_offset to
> min(pending_bytes, remaining_region)
> d. if data section is mmaped, read mmaped buffer of size
> min(pending_bytes, remaining_region)
> e. Write data packet as below:
> {VFIO_MIG_FLAG_DEV_DATA_STATE, data_size, actual data}
> f. iterate through steps b to e until (pending_bytes > 0)

What indicates to the vendor driver to deduct from pending_bytes and
advance the data?  It seems like it's assumed that a read of
pending_bytes indicates this, but I don't like that implicit
interaction, a user could be interrupted and read pending_bytes again
to see if there's still data and introduce data loss.  IMO, there
should be an explicit "Ok, I read # bytes, advance the data stream"
type operation.

> g. Write {VFIO_MIG_FLAG_END_OF_STATE}
> 
> 
> Dirty page tracking (.log_sync) is part of RAM copying state, where
> vendor driver provides the bitmap of pages which are dirtied by vendor
> driver through migration region and as part of RAM copy, those pages
> gets copied to file stream.
> 
> 
> In _RESUMING device state:
> - load config state.
> - For data packet, till VFIO_MIG_FLAG_END_OF_STATE is not reached
>     - read data_size from packet, read buffer of data_size
>         if region is mmaped, write data of data_size to mmaped region.
>     - write data_offset and data_size.
>         In case of mmapped region, write to data_size indicates kernel
> driver that data is written in staging buffer.
>     - if region is trapped, pwrite() data of data_size from data_offset.

I still think data_offset should be read_only and this should use the
same operation above to indicate how many bytes were written rather
than read.  Thanks,

Alex

> >> + *
> >> + * copied_pfns: (read only)
> >> + *      pfn count for which dirty bitmap is copied to migration region.
> >> + *      Vendor driver should copy the bitmap with bits set only for pages to be
> >> + *      marked dirty in migration region.
> >> + *      Vendor driver should return 0 if there are 0 pages dirty in requested
> >> + *      range.
> >> + */
> >> +
> >> +struct vfio_device_migration_info {
> >> +        __u32 device_state;         /* VFIO device state */
> >> +#define VFIO_DEVICE_STATE_RUNNING   (1 << 0)
> >> +#define VFIO_DEVICE_STATE_SAVING    (1 << 1)
> >> +        __u32 reserved;
> >> +        __u64 pending_bytes;
> >> +        __u64 data_offset;
> >> +        __u64 data_size;
> >> +        __u64 start_pfn;
> >> +        __u64 page_size;
> >> +        __u64 total_pfns;
> >> +        __u64 copied_pfns;
> >> +} __attribute__((packed));
> >> +  
> > 
> > As you mentioned, and with Yan's version, we still need to figure out
> > something with compatibility and versioning.  Thanks,
> >   
> 
> Yes, we still need to figure out compatibility and versioning.
> 
> Thanks,
> Kirti
> 
> > Alex
> >   
> >>  /*
> >>   * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped
> >>   * which allows direct access to non-MSIX registers which happened to be within  
> >   
