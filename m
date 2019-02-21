Received: from eggs.gnu.org ([209.51.188.92]:35418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gwkS3-00070d-4f
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:15:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gwkS0-0002AP-Og
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:15:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:7105)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gwkRy-0001zc-5l
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:15:26 -0500
Date: Thu, 21 Feb 2019 09:15:12 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190221091511.GA2605@work-vm>
References: <1550566254-3545-1-git-send-email-yan.y.zhao@intel.com>
	<20190219113212.GC2941@work-vm>
	<20190220052838.GC16456@joy-OptiPlex-7040>
	<20190220110142.GD2608@work-vm>
	<20190221003151.GI16456@joy-OptiPlex-7040>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221003151.GI16456@joy-OptiPlex-7040>
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
Cc: cjia@nvidia.com, kvm@vger.kernel.org, aik@ozlabs.ru, Zhengxiao.zx@alibaba-inc.com, shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, kwankhede@nvidia.com, eauger@redhat.com, yi.l.liu@intel.com, eskultet@redhat.com, ziye.yang@intel.com, mlevitsk@redhat.com, pasic@linux.ibm.com, arei.gonglei@huawei.com, felipe@nutanix.com, zhi.a.wang@intel.com, kevin.tian@intel.com, alex.williamson@redhat.com, intel-gvt-dev@lists.freedesktop.org, changpeng.liu@intel.com, cohuck@redhat.com, Ken.Xue@amd.com, jonathan.davies@nutanix.com

* Zhao Yan (yan.y.zhao@intel.com) wrote:
> On Wed, Feb 20, 2019 at 11:01:43AM +0000, Dr. David Alan Gilbert wrote:
> > * Zhao Yan (yan.y.zhao@intel.com) wrote:
> > > On Tue, Feb 19, 2019 at 11:32:13AM +0000, Dr. David Alan Gilbert wrote:
> > > > * Yan Zhao (yan.y.zhao@intel.com) wrote:
> > > > > This patchset enables VFIO devices to have live migration capability.
> > > > > Currently it does not support post-copy phase.
> > > > > 
> > > > > It follows Alex's comments on last version of VFIO live migration patches,
> > > > > including device states, VFIO device state region layout, dirty bitmap's
> > > > > query.
> > > > 
> > > > Hi,
> > > >   I've sent minor comments to later patches; but some minor general
> > > > comments:
> > > > 
> > > >   a) Never trust the incoming migrations stream - it might be corrupt,
> > > >     so check when you can.
> > > hi Dave
> > > Thanks for this suggestion. I'll add more checks for migration streams.
> > > 
> > > 
> > > >   b) How do we detect if we're migrating from/to the wrong device or
> > > > version of device?  Or say to a device with older firmware or perhaps
> > > > a device that has less device memory ?
> > > Actually it's still an open for VFIO migration. Need to think about
> > > whether it's better to check that in libvirt or qemu (like a device magic
> > > along with verion ?).
> > > This patchset is intended to settle down the main device state interfaces
> > > for VFIO migration. So that we can work on that and improve it.
> > > 
> > > 
> > > >   c) Consider using the trace_ mechanism - it's really useful to
> > > > add to loops writing/reading data so that you can see when it fails.
> > > > 
> > > > Dave
> > > >
> > > Got it. many thanks~~
> > > 
> > > 
> > > > (P.S. You have a few typo's grep your code for 'devcie', 'devie' and
> > > > 'migrtion'
> > > 
> > > sorry :)
> > 
> > No problem.
> > 
> > Given the mails, I'm guessing you've mostly tested this on graphics
> > devices?  Have you also checked with VFIO network cards?
> > 
> yes, I tested it on Intel's graphics devices which do not have device
> memory. so the cap of device-memory is off.
> I believe this patchset can work well on VFIO network cards as well,
> because Gonglei once said their NIC can work well on our previous code
> (i.e. device-memory cap off).

It would be great if you could find some Intel NIC people to help test
it out.

> 
> > Also see the mail I sent in reply to Kirti's series; we need to boil
> > these down to one solution.
> >
> Maybe Kirti can merge their implementaion into the code for device-memory
> cap (like in my patch 5 for device-memory).

It would be great to come up with one patchset between yourself and
Kirti that was tested for Intel and Nvidia GPUs and Intel NICs
(and anyone else who wants to jump on board!).

Dave

> > Dave
> > 
> > > > 
> > > > > Device Data
> > > > > -----------
> > > > > Device data is divided into three types: device memory, device config,
> > > > > and system memory dirty pages produced by device.
> > > > > 
> > > > > Device config: data like MMIOs, page tables...
> > > > >         Every device is supposed to possess device config data.
> > > > >     	Usually device config's size is small (no big than 10M), and it
> > > > >         needs to be loaded in certain strict order.
> > > > >         Therefore, device config only needs to be saved/loaded in
> > > > >         stop-and-copy phase.
> > > > >         The data of device config is held in device config region.
> > > > >         Size of device config data is smaller than or equal to that of
> > > > >         device config region.
> > > > > 
> > > > > Device Memory: device's internal memory, standalone and outside system
> > > > >         memory. It is usually very big.
> > > > >         This kind of data needs to be saved / loaded in pre-copy and
> > > > >         stop-and-copy phase.
> > > > >         The data of device memory is held in device memory region.
> > > > >         Size of devie memory is usually larger than that of device
> > > > >         memory region. qemu needs to save/load it in chunks of size of
> > > > >         device memory region.
> > > > >         Not all device has device memory. Like IGD only uses system memory.
> > > > > 
> > > > > System memory dirty pages: If a device produces dirty pages in system
> > > > >         memory, it is able to get dirty bitmap for certain range of system
> > > > >         memory. This dirty bitmap is queried in pre-copy and stop-and-copy
> > > > >         phase in .log_sync callback. By setting dirty bitmap in .log_sync
> > > > >         callback, dirty pages in system memory will be save/loaded by ram's
> > > > >         live migration code.
> > > > >         The dirty bitmap of system memory is held in dirty bitmap region.
> > > > >         If system memory range is larger than that dirty bitmap region can
> > > > >         hold, qemu will cut it into several chunks and get dirty bitmap in
> > > > >         succession.
> > > > > 
> > > > > 
> > > > > Device State Regions
> > > > > --------------------
> > > > > Vendor driver is required to expose two mandatory regions and another two
> > > > > optional regions if it plans to support device state management.
> > > > > 
> > > > > So, there are up to four regions in total.
> > > > > One control region: mandatory.
> > > > >         Get access via read/write system call.
> > > > >         Its layout is defined in struct vfio_device_state_ctl
> > > > > Three data regions: mmaped into qemu.
> > > > >         device config region: mandatory, holding data of device config
> > > > >         device memory region: optional, holding data of device memory
> > > > >         dirty bitmap region: optional, holding bitmap of system memory
> > > > >                             dirty pages
> > > > > 
> > > > > (The reason why four seperate regions are defined is that the unit of mmap
> > > > > system call is PAGE_SIZE, i.e. 4k bytes. So one read/write region for
> > > > > control and three mmaped regions for data seems better than one big region
> > > > > padded and sparse mmaped).
> > > > > 
> > > > > 
> > > > > kernel device state interface [1]
> > > > > --------------------------------------
> > > > > #define VFIO_DEVICE_STATE_INTERFACE_VERSION 1
> > > > > #define VFIO_DEVICE_DATA_CAP_DEVICE_MEMORY 1
> > > > > #define VFIO_DEVICE_DATA_CAP_SYSTEM_MEMORY 2
> > > > > 
> > > > > #define VFIO_DEVICE_STATE_RUNNING 0 
> > > > > #define VFIO_DEVICE_STATE_STOP 1
> > > > > #define VFIO_DEVICE_STATE_LOGGING 2
> > > > > 
> > > > > #define VFIO_DEVICE_DATA_ACTION_GET_BUFFER 1
> > > > > #define VFIO_DEVICE_DATA_ACTION_SET_BUFFER 2
> > > > > #define VFIO_DEVICE_DATA_ACTION_GET_BITMAP 3
> > > > > 
> > > > > struct vfio_device_state_ctl {
> > > > > 	__u32 version;		  /* ro */
> > > > > 	__u32 device_state;       /* VFIO device state, wo */
> > > > > 	__u32 caps;		 /* ro */
> > > > >         struct {
> > > > > 		__u32 action;  /* wo, GET_BUFFER or SET_BUFFER */ 
> > > > > 		__u64 size;    /*rw*/
> > > > > 	} device_config;
> > > > > 	struct {
> > > > > 		__u32 action;    /* wo, GET_BUFFER or SET_BUFFER */ 
> > > > > 		__u64 size;     /* rw */  
> > > > >                 __u64 pos; /*the offset in total buffer of device memory*/
> > > > > 	} device_memory;
> > > > > 	struct {
> > > > > 		__u64 start_addr; /* wo */
> > > > > 		__u64 page_nr;   /* wo */
> > > > > 	} system_memory;
> > > > > };
> > > > > 
> > > > > Devcie States
> > > > > ------------- 
> > > > > After migration is initialzed, it will set device state via writing to
> > > > > device_state field of control region.
> > > > > 
> > > > > Four states are defined for a VFIO device:
> > > > >         RUNNING, RUNNING & LOGGING, STOP & LOGGING, STOP 
> > > > > 
> > > > > RUNNING: In this state, a VFIO device is in active state ready to receive
> > > > >         commands from device driver.
> > > > >         It is the default state that a VFIO device enters initially.
> > > > > 
> > > > > STOP:  In this state, a VFIO device is deactivated to interact with
> > > > >        device driver.
> > > > > 
> > > > > LOGGING: a special state that it CANNOT exist independently. It must be
> > > > >        set alongside with state RUNNING or STOP (i.e. RUNNING & LOGGING,
> > > > >        STOP & LOGGING).
> > > > >        Qemu will set LOGGING state on in .save_setup callbacks, then vendor
> > > > >        driver can start dirty data logging for device memory and system
> > > > >        memory.
> > > > >        LOGGING only impacts device/system memory. They return whole
> > > > >        snapshot outside LOGGING and dirty data since last get operation
> > > > >        inside LOGGING.
> > > > >        Device config should be always accessible and return whole config
> > > > >        snapshot regardless of LOGGING state.
> > > > >        
> > > > > Note:
> > > > > The reason why RUNNING is the default state is that device's active state
> > > > > must not depend on device state interface.
> > > > > It is possible that region vfio_device_state_ctl fails to get registered.
> > > > > In that condition, a device needs be in active state by default. 
> > > > > 
> > > > > Get Version & Get Caps
> > > > > ----------------------
> > > > > On migration init phase, qemu will probe the existence of device state
> > > > > regions of vendor driver, then get version of the device state interface
> > > > > from the r/w control region.
> > > > > 
> > > > > Then it will probe VFIO device's data capability by reading caps field of
> > > > > control region.
> > > > >         #define VFIO_DEVICE_DATA_CAP_DEVICE_MEMORY 1
> > > > >         #define VFIO_DEVICE_DATA_CAP_SYSTEM_MEMORY 2
> > > > > If VFIO_DEVICE_DATA_CAP_DEVICE_MEMORY is on, it will save/load data of
> > > > >         device memory in pre-copy and stop-and-copy phase. The data of
> > > > >         device memory is held in device memory region.
> > > > > If VFIO_DEVICE_DATA_CAP_SYSTEM_MEMORY is on, it will query of dirty pages
> > > > >         produced by VFIO device during pre-copy and stop-and-copy phase.
> > > > >         The dirty bitmap of system memory is held in dirty bitmap region.
> > > > > 
> > > > > If failing to find two mandatory regions and optional data regions
> > > > > corresponding to data caps or version mismatching, it will setup a
> > > > > migration blocker and disable live migration for VFIO device.
> > > > > 
> > > > > 
> > > > > Flows to call device state interface for VFIO live migration
> > > > > ------------------------------------------------------------
> > > > > 
> > > > > Live migration save path:
> > > > > 
> > > > > (QEMU LIVE MIGRATION STATE --> DEVICE STATE INTERFACE --> DEVICE STATE)
> > > > > 
> > > > > MIGRATION_STATUS_NONE --> VFIO_DEVICE_STATE_RUNNING
> > > > >  |
> > > > > MIGRATION_STATUS_SAVE_SETUP
> > > > >  |
> > > > >  .save_setup callback -->
> > > > >  get device memory size (whole snapshot size)
> > > > >  get device memory buffer (whole snapshot data)
> > > > >  set device state --> VFIO_DEVICE_STATE_RUNNING & VFIO_DEVICE_STATE_LOGGING
> > > > >  |
> > > > > MIGRATION_STATUS_ACTIVE
> > > > >  |
> > > > >  .save_live_pending callback --> get device memory size (dirty data)
> > > > >  .save_live_iteration callback --> get device memory buffer (dirty data)
> > > > >  .log_sync callback --> get system memory dirty bitmap
> > > > >  |
> > > > > (vcpu stops) --> set device state -->
> > > > >  VFIO_DEVICE_STATE_STOP & VFIO_DEVICE_STATE_LOGGING
> > > > >  |
> > > > > .save_live_complete_precopy callback -->
> > > > >  get device memory size (dirty data)
> > > > >  get device memory buffer (dirty data)
> > > > >  get device config size (whole snapshot size)
> > > > >  get device config buffer (whole snapshot data)
> > > > >  |
> > > > > .save_cleanup callback -->  set device state --> VFIO_DEVICE_STATE_STOP
> > > > > MIGRATION_STATUS_COMPLETED
> > > > > 
> > > > > MIGRATION_STATUS_CANCELLED or
> > > > > MIGRATION_STATUS_FAILED
> > > > >  |
> > > > > (vcpu starts) --> set device state --> VFIO_DEVICE_STATE_RUNNING
> > > > > 
> > > > > 
> > > > > Live migration load path:
> > > > > 
> > > > > (QEMU LIVE MIGRATION STATE --> DEVICE STATE INTERFACE --> DEVICE STATE)
> > > > > 
> > > > > MIGRATION_STATUS_NONE --> VFIO_DEVICE_STATE_RUNNING
> > > > >  |
> > > > > (vcpu stops) --> set device state --> VFIO_DEVICE_STATE_STOP
> > > > >  |
> > > > > MIGRATION_STATUS_ACTIVE
> > > > >  |
> > > > > .load state callback -->
> > > > >  set device memory size, set device memory buffer, set device config size,
> > > > >  set device config buffer
> > > > >  |
> > > > > (vcpu starts) --> set device state --> VFIO_DEVICE_STATE_RUNNING
> > > > >  |
> > > > > MIGRATION_STATUS_COMPLETED
> > > > > 
> > > > > 
> > > > > 
> > > > > In source VM side,
> > > > > In precopy phase,
> > > > > if a device has VFIO_DEVICE_DATA_CAP_DEVICE_MEMORY on,
> > > > > qemu will first get whole snapshot of device memory in .save_setup
> > > > > callback, and then it will get total size of dirty data in device memory in
> > > > > .save_live_pending callback by reading device_memory.size field of control
> > > > > region.
> > > > > Then in .save_live_iteration callback, it will get buffer of device memory's
> > > > > dirty data chunk by chunk from device memory region by writing pos &
> > > > > action (GET_BUFFER) to device_memory.pos & device_memory.action fields of
> > > > > control region. (size of each chunk is the size of device memory data
> > > > > region).
> > > > > .save_live_pending and .save_live_iteration may be called several times in
> > > > > precopy phase to get dirty data in device memory.
> > > > > 
> > > > > If VFIO_DEVICE_DATA_CAP_DEVICE_MEMORY is off, callbacks in precopy phase
> > > > > like .save_setup, .save_live_pending, .save_live_iteration will not call
> > > > > vendor driver's device state interface to get data from devcie memory.
> > > > > 
> > > > > In precopy phase, if a device has VFIO_DEVICE_DATA_CAP_SYSTEM_MEMORY on,
> > > > > .log_sync callback will get system memory dirty bitmap from dirty bitmap
> > > > > region by writing system memory's start address, page count and action 
> > > > > (GET_BITMAP) to "system_memory.start_addr", "system_memory.page_nr", and
> > > > > "system_memory.action" fields of control region.
> > > > > If page count passed in .log_sync callback is larger than the bitmap size
> > > > > the dirty bitmap region supports, Qemu will cut it into chunks and call
> > > > > vendor driver's get system memory dirty bitmap interface.
> > > > > If VFIO_DEVICE_DATA_CAP_SYSTEM_MEMORY is off, .log_sync callback just
> > > > > returns without call to vendor driver.
> > > > > 
> > > > > In stop-and-copy phase, device state will be set to STOP & LOGGING first.
> > > > > in save_live_complete_precopy callback,
> > > > > If VFIO_DEVICE_DATA_CAP_SYSTEM_MEMORY is on,
> > > > > get device memory size and get device memory buffer will be called again.
> > > > > After that,
> > > > > device config data is get from device config region by reading
> > > > > devcie_config.size of control region and writing action (GET_BITMAP) to
> > > > > device_config.action of control region.
> > > > > Then after migration completes, in cleanup handler, LOGGING state will be
> > > > > cleared (i.e. deivce state is set to STOP).
> > > > > Clearing LOGGING state in cleanup handler is in consideration of the case
> > > > > of "migration failed" and "migration cancelled". They can also leverage
> > > > > the cleanup handler to unset LOGGING state.
> > > > > 
> > > > > 
> > > > > References
> > > > > ----------
> > > > > 1. kernel side implementation of Device state interfaces:
> > > > > https://patchwork.freedesktop.org/series/56876/
> > > > > 
> > > > > 
> > > > > Yan Zhao (5):
> > > > >   vfio/migration: define kernel interfaces
> > > > >   vfio/migration: support device of device config capability
> > > > >   vfio/migration: tracking of dirty page in system memory
> > > > >   vfio/migration: turn on migration
> > > > >   vfio/migration: support device memory capability
> > > > > 
> > > > >  hw/vfio/Makefile.objs         |   2 +-
> > > > >  hw/vfio/common.c              |  26 ++
> > > > >  hw/vfio/migration.c           | 858 ++++++++++++++++++++++++++++++++++++++++++
> > > > >  hw/vfio/pci.c                 |  10 +-
> > > > >  hw/vfio/pci.h                 |  26 +-
> > > > >  include/hw/vfio/vfio-common.h |   1 +
> > > > >  linux-headers/linux/vfio.h    | 260 +++++++++++++
> > > > >  7 files changed, 1174 insertions(+), 9 deletions(-)
> > > > >  create mode 100644 hw/vfio/migration.c
> > > > > 
> > > > > -- 
> > > > > 2.7.4
> > > > > 
> > > > --
> > > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > > > _______________________________________________
> > > > intel-gvt-dev mailing list
> > > > intel-gvt-dev@lists.freedesktop.org
> > > > https://lists.freedesktop.org/mailman/listinfo/intel-gvt-dev
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > _______________________________________________
> > intel-gvt-dev mailing list
> > intel-gvt-dev@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/intel-gvt-dev
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
