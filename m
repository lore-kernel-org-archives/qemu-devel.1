Received: from eggs.gnu.org ([209.51.188.92]:36944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1gwQU7-0006sU-U4
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:56:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1gwQU1-0007Cv-MG
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:56:19 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2483 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arei.gonglei@huawei.com>)
	id 1gwQU0-0006b9-Tj
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:56:13 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Wed, 20 Feb 2019 11:56:01 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DB25D374@dggeml511-mbx.china.huawei.com>
References: <1550566254-3545-1-git-send-email-yan.y.zhao@intel.com>
In-Reply-To: <1550566254-3545-1-git-send-email-yan.y.zhao@intel.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 0/5] QEMU VFIO live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yan Zhao <yan.y.zhao@intel.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "intel-gvt-dev@lists.freedesktop.org" <intel-gvt-dev@lists.freedesktop.org>, "Zhengxiao.zx@Alibaba-inc.com" <Zhengxiao.zx@Alibaba-inc.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "eskultet@redhat.com" <eskultet@redhat.com>, "ziye.yang@intel.com" <ziye.yang@intel.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "zhi.a.wang@intel.com" <zhi.a.wang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>, "eauger@redhat.com" <eauger@redhat.com>, "felipe@nutanix.com" <felipe@nutanix.com>, "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "changpeng.liu@intel.com" <changpeng.liu@intel.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>, "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, "cjia@nvidia.com" <cjia@nvidia.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>

Hi yan,

Thanks for your work.

I have some suggestions or questions:

1) Would you add msix mode support,? if not, pls add a check in vfio_pci_sa=
ve_config(), likes Nvidia's solution.
2) We should start vfio devices before vcpu resumes, so we can't rely on vm=
 start change handler completely.
3) We'd better support live migration rollback since have many failure scen=
arios,
 register a migration notifier is a good choice.
4) Four memory region for live migration is too complicated IMHO.=20
5) About log sync, why not register log_global_start/stop in vfio_memory_li=
stener?


Regards,
-Gonglei


> -----Original Message-----
> From: Yan Zhao [mailto:yan.y.zhao@intel.com]
> Sent: Tuesday, February 19, 2019 4:51 PM
> To: alex.williamson@redhat.com; qemu-devel@nongnu.org
> Cc: intel-gvt-dev@lists.freedesktop.org; Zhengxiao.zx@Alibaba-inc.com;
> yi.l.liu@intel.com; eskultet@redhat.com; ziye.yang@intel.com;
> cohuck@redhat.com; shuangtai.tst@alibaba-inc.com; dgilbert@redhat.com;
> zhi.a.wang@intel.com; mlevitsk@redhat.com; pasic@linux.ibm.com;
> aik@ozlabs.ru; eauger@redhat.com; felipe@nutanix.com;
> jonathan.davies@nutanix.com; changpeng.liu@intel.com; Ken.Xue@amd.com;
> kwankhede@nvidia.com; kevin.tian@intel.com; cjia@nvidia.com; Gonglei (Are=
i)
> <arei.gonglei@huawei.com>; kvm@vger.kernel.org; Yan Zhao
> <yan.y.zhao@intel.com>
> Subject: [PATCH 0/5] QEMU VFIO live migration
>=20
> This patchset enables VFIO devices to have live migration capability.
> Currently it does not support post-copy phase.
>=20
> It follows Alex's comments on last version of VFIO live migration patches=
,
> including device states, VFIO device state region layout, dirty bitmap's
> query.
>=20
> Device Data
> -----------
> Device data is divided into three types: device memory, device config,
> and system memory dirty pages produced by device.
>=20
> Device config: data like MMIOs, page tables...
>         Every device is supposed to possess device config data.
>     	Usually device config's size is small (no big than 10M), and it
>         needs to be loaded in certain strict order.
>         Therefore, device config only needs to be saved/loaded in
>         stop-and-copy phase.
>         The data of device config is held in device config region.
>         Size of device config data is smaller than or equal to that of
>         device config region.
>=20
> Device Memory: device's internal memory, standalone and outside system
>         memory. It is usually very big.
>         This kind of data needs to be saved / loaded in pre-copy and
>         stop-and-copy phase.
>         The data of device memory is held in device memory region.
>         Size of devie memory is usually larger than that of device
>         memory region. qemu needs to save/load it in chunks of size of
>         device memory region.
>         Not all device has device memory. Like IGD only uses system memor=
y.
>=20
> System memory dirty pages: If a device produces dirty pages in system
>         memory, it is able to get dirty bitmap for certain range of syste=
m
>         memory. This dirty bitmap is queried in pre-copy and stop-and-cop=
y
>         phase in .log_sync callback. By setting dirty bitmap in .log_sync
>         callback, dirty pages in system memory will be save/loaded by ram=
's
>         live migration code.
>         The dirty bitmap of system memory is held in dirty bitmap region.
>         If system memory range is larger than that dirty bitmap region ca=
n
>         hold, qemu will cut it into several chunks and get dirty bitmap i=
n
>         succession.
>=20
>=20
> Device State Regions
> --------------------
> Vendor driver is required to expose two mandatory regions and another two
> optional regions if it plans to support device state management.
>=20
> So, there are up to four regions in total.
> One control region: mandatory.
>         Get access via read/write system call.
>         Its layout is defined in struct vfio_device_state_ctl
> Three data regions: mmaped into qemu.
>         device config region: mandatory, holding data of device config
>         device memory region: optional, holding data of device memory
>         dirty bitmap region: optional, holding bitmap of system memory
>                             dirty pages
>=20
> (The reason why four seperate regions are defined is that the unit of mma=
p
> system call is PAGE_SIZE, i.e. 4k bytes. So one read/write region for
> control and three mmaped regions for data seems better than one big regio=
n
> padded and sparse mmaped).
>=20
>=20
> kernel device state interface [1]
> --------------------------------------
> #define VFIO_DEVICE_STATE_INTERFACE_VERSION 1
> #define VFIO_DEVICE_DATA_CAP_DEVICE_MEMORY 1
> #define VFIO_DEVICE_DATA_CAP_SYSTEM_MEMORY 2
>=20
> #define VFIO_DEVICE_STATE_RUNNING 0
> #define VFIO_DEVICE_STATE_STOP 1
> #define VFIO_DEVICE_STATE_LOGGING 2
>=20
> #define VFIO_DEVICE_DATA_ACTION_GET_BUFFER 1
> #define VFIO_DEVICE_DATA_ACTION_SET_BUFFER 2
> #define VFIO_DEVICE_DATA_ACTION_GET_BITMAP 3
>=20
> struct vfio_device_state_ctl {
> 	__u32 version;		  /* ro */
> 	__u32 device_state;       /* VFIO device state, wo */
> 	__u32 caps;		 /* ro */
>         struct {
> 		__u32 action;  /* wo, GET_BUFFER or SET_BUFFER */
> 		__u64 size;    /*rw*/
> 	} device_config;
> 	struct {
> 		__u32 action;    /* wo, GET_BUFFER or SET_BUFFER */
> 		__u64 size;     /* rw */
>                 __u64 pos; /*the offset in total buffer of device memory*=
/
> 	} device_memory;
> 	struct {
> 		__u64 start_addr; /* wo */
> 		__u64 page_nr;   /* wo */
> 	} system_memory;
> };
>=20
> Devcie States
> -------------
> After migration is initialzed, it will set device state via writing to
> device_state field of control region.
>=20
> Four states are defined for a VFIO device:
>         RUNNING, RUNNING & LOGGING, STOP & LOGGING, STOP
>=20
> RUNNING: In this state, a VFIO device is in active state ready to receive
>         commands from device driver.
>         It is the default state that a VFIO device enters initially.
>=20
> STOP:  In this state, a VFIO device is deactivated to interact with
>        device driver.
>=20
> LOGGING: a special state that it CANNOT exist independently. It must be
>        set alongside with state RUNNING or STOP (i.e. RUNNING &
> LOGGING,
>        STOP & LOGGING).
>        Qemu will set LOGGING state on in .save_setup callbacks, then vend=
or
>        driver can start dirty data logging for device memory and system
>        memory.
>        LOGGING only impacts device/system memory. They return whole
>        snapshot outside LOGGING and dirty data since last get operation
>        inside LOGGING.
>        Device config should be always accessible and return whole config
>        snapshot regardless of LOGGING state.
>=20
> Note:
> The reason why RUNNING is the default state is that device's active state
> must not depend on device state interface.
> It is possible that region vfio_device_state_ctl fails to get registered.
> In that condition, a device needs be in active state by default.
>=20
> Get Version & Get Caps
> ----------------------
> On migration init phase, qemu will probe the existence of device state
> regions of vendor driver, then get version of the device state interface
> from the r/w control region.
>=20
> Then it will probe VFIO device's data capability by reading caps field of
> control region.
>         #define VFIO_DEVICE_DATA_CAP_DEVICE_MEMORY 1
>         #define VFIO_DEVICE_DATA_CAP_SYSTEM_MEMORY 2
> If VFIO_DEVICE_DATA_CAP_DEVICE_MEMORY is on, it will save/load data of
>         device memory in pre-copy and stop-and-copy phase. The data of
>         device memory is held in device memory region.
> If VFIO_DEVICE_DATA_CAP_SYSTEM_MEMORY is on, it will query of dirty
> pages
>         produced by VFIO device during pre-copy and stop-and-copy phase.
>         The dirty bitmap of system memory is held in dirty bitmap region.
>=20
> If failing to find two mandatory regions and optional data regions
> corresponding to data caps or version mismatching, it will setup a
> migration blocker and disable live migration for VFIO device.
>=20
>=20
> Flows to call device state interface for VFIO live migration
> ------------------------------------------------------------
>=20
> Live migration save path:
>=20
> (QEMU LIVE MIGRATION STATE --> DEVICE STATE INTERFACE --> DEVICE STATE)
>=20
> MIGRATION_STATUS_NONE --> VFIO_DEVICE_STATE_RUNNING
>  |
> MIGRATION_STATUS_SAVE_SETUP
>  |
>  .save_setup callback -->
>  get device memory size (whole snapshot size)
>  get device memory buffer (whole snapshot data)
>  set device state --> VFIO_DEVICE_STATE_RUNNING &
> VFIO_DEVICE_STATE_LOGGING
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
>=20
> MIGRATION_STATUS_CANCELLED or
> MIGRATION_STATUS_FAILED
>  |
> (vcpu starts) --> set device state --> VFIO_DEVICE_STATE_RUNNING
>=20
>=20
> Live migration load path:
>=20
> (QEMU LIVE MIGRATION STATE --> DEVICE STATE INTERFACE --> DEVICE STATE)
>=20
> MIGRATION_STATUS_NONE --> VFIO_DEVICE_STATE_RUNNING
>  |
> (vcpu stops) --> set device state --> VFIO_DEVICE_STATE_STOP
>  |
> MIGRATION_STATUS_ACTIVE
>  |
> .load state callback -->
>  set device memory size, set device memory buffer, set device config size=
,
>  set device config buffer
>  |
> (vcpu starts) --> set device state --> VFIO_DEVICE_STATE_RUNNING
>  |
> MIGRATION_STATUS_COMPLETED
>=20
>=20
>=20
> In source VM side,
> In precopy phase,
> if a device has VFIO_DEVICE_DATA_CAP_DEVICE_MEMORY on,
> qemu will first get whole snapshot of device memory in .save_setup
> callback, and then it will get total size of dirty data in device memory =
in
> .save_live_pending callback by reading device_memory.size field of contro=
l
> region.
> Then in .save_live_iteration callback, it will get buffer of device memor=
y's
> dirty data chunk by chunk from device memory region by writing pos &
> action (GET_BUFFER) to device_memory.pos & device_memory.action fields of
> control region. (size of each chunk is the size of device memory data
> region).
> .save_live_pending and .save_live_iteration may be called several times i=
n
> precopy phase to get dirty data in device memory.
>=20
> If VFIO_DEVICE_DATA_CAP_DEVICE_MEMORY is off, callbacks in precopy
> phase
> like .save_setup, .save_live_pending, .save_live_iteration will not call
> vendor driver's device state interface to get data from devcie memory.
>=20
> In precopy phase, if a device has VFIO_DEVICE_DATA_CAP_SYSTEM_MEMORY
> on,
> .log_sync callback will get system memory dirty bitmap from dirty bitmap
> region by writing system memory's start address, page count and action
> (GET_BITMAP) to "system_memory.start_addr", "system_memory.page_nr",
> and
> "system_memory.action" fields of control region.
> If page count passed in .log_sync callback is larger than the bitmap size
> the dirty bitmap region supports, Qemu will cut it into chunks and call
> vendor driver's get system memory dirty bitmap interface.
> If VFIO_DEVICE_DATA_CAP_SYSTEM_MEMORY is off, .log_sync callback just
> returns without call to vendor driver.
>=20
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
>=20
>=20
> References
> ----------
> 1. kernel side implementation of Device state interfaces:
> https://patchwork.freedesktop.org/series/56876/
>=20
>=20
> Yan Zhao (5):
>   vfio/migration: define kernel interfaces
>   vfio/migration: support device of device config capability
>   vfio/migration: tracking of dirty page in system memory
>   vfio/migration: turn on migration
>   vfio/migration: support device memory capability
>=20
>  hw/vfio/Makefile.objs         |   2 +-
>  hw/vfio/common.c              |  26 ++
>  hw/vfio/migration.c           | 858
> ++++++++++++++++++++++++++++++++++++++++++
>  hw/vfio/pci.c                 |  10 +-
>  hw/vfio/pci.h                 |  26 +-
>  include/hw/vfio/vfio-common.h |   1 +
>  linux-headers/linux/vfio.h    | 260 +++++++++++++
>  7 files changed, 1174 insertions(+), 9 deletions(-)
>  create mode 100644 hw/vfio/migration.c
>=20
> --
> 2.7.4
