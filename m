Received: from eggs.gnu.org ([209.51.188.92]:56558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gw59T-0002D3-0R
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 08:09:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gw59Q-0001Xg-Nx
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 08:09:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gw59O-0001Wf-QW
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 08:09:31 -0500
Date: Tue, 19 Feb 2019 14:09:18 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190219140918.476ac9d1.cohuck@redhat.com>
In-Reply-To: <1550566334-3602-1-git-send-email-yan.y.zhao@intel.com>
References: <1550566254-3545-1-git-send-email-yan.y.zhao@intel.com>
	<1550566334-3602-1-git-send-email-yan.y.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/5] vfio/migration: define kernel
 interfaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: alex.williamson@redhat.com, qemu-devel@nongnu.org, intel-gvt-dev@lists.freedesktop.org, Zhengxiao.zx@Alibaba-inc.com, yi.l.liu@intel.com, eskultet@redhat.com, ziye.yang@intel.com, shuangtai.tst@alibaba-inc.com, dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru, eauger@redhat.com, felipe@nutanix.com, jonathan.davies@nutanix.com, changpeng.liu@intel.com, Ken.Xue@amd.com, kwankhede@nvidia.com, kevin.tian@intel.com, cjia@nvidia.com, arei.gonglei@huawei.com, kvm@vger.kernel.org

On Tue, 19 Feb 2019 16:52:14 +0800
Yan Zhao <yan.y.zhao@intel.com> wrote:

> - defined 4 device states regions: one control region and 3 data regions
> - defined layout of control region in struct vfio_device_state_ctl
> - defined 4 device states: running, stop, running&logging, stop&logging
> - define 3 device data categories: device config, device memory, system
>   memory
> - defined 2 device data capabilities: device memory and system memory
> - defined device state interfaces' version and 12 device state interfaces
> 
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> Signed-off-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Yulei Zhang <yulei.zhang@intel.com>
> ---
>  linux-headers/linux/vfio.h | 260 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 260 insertions(+)

[commenting here for convenience; changes obviously need to be done in
the Linux patch]

> 
> diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
> index ceb6453..a124fc1 100644
> --- a/linux-headers/linux/vfio.h
> +++ b/linux-headers/linux/vfio.h
> @@ -303,6 +303,56 @@ struct vfio_region_info_cap_type {
>  #define VFIO_REGION_SUBTYPE_INTEL_IGD_HOST_CFG	(2)
>  #define VFIO_REGION_SUBTYPE_INTEL_IGD_LPC_CFG	(3)
>  
> +/* Device State region type and sub-type
> + *
> + * A VFIO device driver needs to register up to four device state regions in
> + * total: two mandatory and another two optional, if it plans to support device
> + * state management.

Suggest to rephrase:

"A VFIO device driver that plans to support device state management
needs to register..."

> + *
> + * 1. region CTL :
> + *          Mandatory.
> + *          This is a control region.
> + *          Its layout is defined in struct vfio_device_state_ctl.
> + *          Reading from this region can get version, capabilities and data
> + *          size of device state interfaces.
> + *          Writing to this region can set device state, data size and
> + *          choose which interface to use.
> + * 2. region DEVICE_CONFIG
> + *          Mandatory.
> + *          This is a data region that holds device config data.
> + *          Device config is such kind of data like MMIOs, page tables...

"Device config is data such as..."

> + *          Every device is supposed to possess device config data.
> + *          Usually the size of device config data is small (no big

s/no big/no bigger/

> + *          than 10M), and it needs to be loaded in certain strict
> + *          order.
> + *          Therefore no dirty data logging is enabled for device
> + *          config and it must be got/set as a whole.
> + *          Size of device config data is smaller than or equal to that of
> + *          device config region.

Not sure if I understand that sentence correctly... but what if a
device has more config state than fits into this region? Is that
supposed to be covered by the device memory region? Or is this assumed
to be something so exotic that we don't need to plan for it?

> + *          It is able to be mmaped into user space.
> + * 3. region DEVICE_MEMORY
> + *          Optional.
> + *          This is a data region that holds device memory data.
> + *          Device memory is device's internal memory, standalone and outside

s/outside/distinct from/ ?

> + *          system memory.  It is usually very big.
> + *          Not all device has device memory. Like IGD only uses system

s/all devices has/all devices have/

s/Like/E.g./

> + *          memory and has no device memory.
> + *          Size of devie memory is usually larger than that of device

s/devie/device/

> + *          memory region. qemu needs to save/load it in chunks of size of
> + *          device memory region.

I'd rather not explicitly mention QEMU in this header. Maybe
"Userspace"?

> + *          It is able to be mmaped into user space.
> + * 4. region DIRTY_BITMAP
> + *          Optional.
> + *          This is a data region that holds bitmap of dirty pages in system
> + *          memory that a VFIO devices produces.
> + *          It is able to be mmaped into user space.
> + */
> +#define VFIO_REGION_TYPE_DEVICE_STATE           (1 << 1)

Can you make this an explicit number instead?

(FWIW, I plan to add a CCW region as type 2, whatever comes first.)

> +#define VFIO_REGION_SUBTYPE_DEVICE_STATE_CTL       (1)
> +#define VFIO_REGION_SUBTYPE_DEVICE_STATE_DATA_CONFIG      (2)
> +#define VFIO_REGION_SUBTYPE_DEVICE_STATE_DATA_MEMORY      (3)
> +#define VFIO_REGION_SUBTYPE_DEVICE_STATE_DATA_DIRTYBITMAP (4)
> +
>  /*
>   * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped
>   * which allows direct access to non-MSIX registers which happened to be within
> @@ -816,6 +866,216 @@ struct vfio_iommu_spapr_tce_remove {
>  };
>  #define VFIO_IOMMU_SPAPR_TCE_REMOVE	_IO(VFIO_TYPE, VFIO_BASE + 20)
>  
> +/* version number of the device state interface */
> +#define VFIO_DEVICE_STATE_INTERFACE_VERSION 1

Hm. Is this supposed to be backwards-compatible, should we need to bump
this?

> +
> +/*
> + * For devices that have devcie memory, it is required to expose

s/devcie/device/

> + * DEVICE_MEMORY capability.
> + *
> + * For devices producing dirty pages in system memory, it is required to
> + * expose cap SYSTEM_MEMORY in order to get dirty bitmap in certain range
> + * of system memory.
> + */
> +#define VFIO_DEVICE_DATA_CAP_DEVICE_MEMORY 1
> +#define VFIO_DEVICE_DATA_CAP_SYSTEM_MEMORY 2
> +
> +/*
> + * DEVICE STATES
> + *
> + * Four states are defined for a VFIO device:
> + * RUNNING, RUNNING & LOGGING, STOP & LOGGING, STOP.
> + * They can be set by writing to device_state field of
> + * vfio_device_state_ctl region.

Who controls this? Userspace?

> + *
> + * RUNNING: In this state, a VFIO device is in active state ready to
> + * receive commands from device driver.
> + * It is the default state that a VFIO device enters initially.
> + *
> + * STOP: In this state, a VFIO device is deactivated to interact with
> + * device driver.

I think 'STOPPED' would read nicer.

> + *
> + * LOGGING state is a special state that it CANNOT exist
> + * independently.

So it's not a state, but rather a modifier?

> + * It must be set alongside with state RUNNING or STOP, i.e,
> + * RUNNING & LOGGING, STOP & LOGGING.
> + * It is used for dirty data logging both for device memory
> + * and system memory.
> + *
> + * LOGGING only impacts device/system memory. In LOGGING state, get buffer
> + * of device memory returns dirty pages since last call; outside LOGGING
> + * state, get buffer of device memory returns whole snapshot of device
> + * memory. system memory's dirty page is only available in LOGGING state.
> + *
> + * Device config should be always accessible and return whole config snapshot
> + * regardless of LOGGING state.
> + * */
> +#define VFIO_DEVICE_STATE_RUNNING 0
> +#define VFIO_DEVICE_STATE_STOP 1
> +#define VFIO_DEVICE_STATE_LOGGING 2
> +
> +/* action to get data from device memory or device config
> + * the action is write to device state's control region, and data is read
> + * from device memory region or device config region.
> + * Each time before read device memory region or device config region,
> + * action VFIO_DEVICE_DATA_ACTION_GET_BUFFER is required to write to action
> + * field in control region. That is because device memory and devie config
> + * region is mmaped into user space. vendor driver has to be notified of
> + * the the GET_BUFFER action in advance.
> + */
> +#define VFIO_DEVICE_DATA_ACTION_GET_BUFFER 1
> +
> +/* action to set data to device memory or device config
> + * the action is write to device state's control region, and data is
> + * written to device memory region or device config region.
> + * Each time after write to device memory region or device config region,
> + * action VFIO_DEVICE_DATA_ACTION_GET_BUFFER is required to write to action
> + * field in control region. That is because device memory and devie config
> + * region is mmaped into user space. vendor driver has to be notified of
> + * the the SET_BUFFER action after data written.
> + */
> +#define VFIO_DEVICE_DATA_ACTION_SET_BUFFER 2

Let me describe this in my own words to make sure that I understand
this correctly.

- The actions are set by userspace to notify the kernel that it is
  going to get data or that it has just written data.
- This is needed as a notification that the mmapped data should not be
  changed resp. just has changed.

So, how does the kernel know whether the read action has finished resp.
whether the write action has started? Even if userspace reads/writes it
as a whole.

> +
> +/* layout of device state interfaces' control region
> + * By reading to control region and reading/writing data from device config
> + * region, device memory region, system memory regions, below interface can
> + * be implemented:
> + *
> + * 1. get version
> + *   (1) user space calls read system call on "version" field of control
> + *   region.
> + *   (2) vendor driver writes version number of device state interfaces
> + *   to the "version" field of control region.
> + *
> + * 2. get caps
> + *   (1) user space calls read system call on "caps" field of control region.
> + *   (2) if a VFIO device has huge device memory, vendor driver reports
> + *      VFIO_DEVICE_DATA_CAP_DEVICE_MEMORY in "caps" field of control region.
> + *      if a VFIO device produces dirty pages in system memory, vendor driver
> + *      reports VFIO_DEVICE_DATA_CAP_SYSTEM_MEMORY in "caps" field of
> + *      control region.
> + *
> + * 3. set device state
> + *    (1) user space calls write system call on "device_state" field of
> + *    control region.
> + *    (2) device state transitions as:
> + *
> + *    RUNNING -- start dirty data logging --> RUNNING & LOGGING
> + *    RUNNING -- deactivate --> STOP
> + *    RUNNING -- deactivate & start dirty data longging --> STOP & LOGGING
> + *    RUNNING & LOGGING -- stop dirty data logging --> RUNNING
> + *    RUNNING & LOGGING -- deactivate --> STOP & LOGGING
> + *    RUNNING & LOGGING -- deactivate & stop dirty data logging --> STOP
> + *    STOP -- activate --> RUNNING
> + *    STOP -- start dirty data logging --> STOP & LOGGING
> + *    STOP -- activate & start dirty data logging --> RUNNING & LOGGING
> + *    STOP & LOGGING -- stop dirty data logging --> STOP
> + *    STOP & LOGGING -- activate --> RUNNING & LOGGING
> + *    STOP & LOGGING -- activate & stop dirty data logging --> RUNNING
> + *
> + * 4. get device config size
> + *   (1) user space calls read system call on "device_config.size" field of
> + *       control region for the total size of device config snapshot.
> + *   (2) vendor driver writes device config data's total size in
> + *       "device_config.size" field of control region.
> + *
> + * 5. set device config size
> + *   (1) user space calls write system call.
> + *       total size of device config snapshot --> "device_config.size" field
> + *       of control region.
> + *   (2) vendor driver reads device config data's total size from
> + *       "device_config.size" field of control region.
> + *
> + * 6 get device config buffer
> + *   (1) user space calls write system call.
> + *       "GET_BUFFER" --> "device_config.action" field of control region.
> + *   (2) vendor driver
> + *       a. gets whole snapshot for device config
> + *       b. writes whole device config snapshot to region
> + *       DEVICE_CONFIG.
> + *   (3) user space reads the whole of device config snapshot from region
> + *       DEVICE_CONFIG.
> + *
> + * 7. set device config buffer
> + *   (1) user space writes whole of device config data to region
> + *       DEVICE_CONFIG.
> + *   (2) user space calls write system call.
> + *       "SET_BUFFER" --> "device_config.action" field of control region.
> + *   (3) vendor driver loads whole of device config from region DEVICE_CONFIG.
> + *
> + * 8. get device memory size
> + *   (1) user space calls read system call on "device_memory.size" field of
> + *       control region for device memory size.
> + *   (2) vendor driver
> + *       a. gets device memory snapshot (in state RUNNING or STOP), or
> + *          gets device memory dirty data (in state RUNNING & LOGGING or
> + *          state STOP & LOGGING)
> + *       b. writes size in "device_memory.size" field of control region
> + *
> + * 9. set device memory size
> + *   (1) user space calls write system call on "device_memory.size" field of
> + *       control region to set total size of device memory snapshot.
> + *   (2) vendor driver reads device memory's size from "device_memory.size"
> + *       field of control region.
> + *
> + *
> + * 10. get device memory buffer
> + *   (1) user space calls write system.
> + *       pos --> "device_memory.pos" field of control region,
> + *       "GET_BUFFER" --> "device_memory.action" field of control region.
> + *       (pos must be 0 or multiples of length of region DEVICE_MEMORY).
> + *   (2) vendor driver writes N'th chunk of device memory snapshot/dirty data
> + *       to region DEVICE_MEMORY.
> + *       (N equals to pos/(region length of DEVICE_MEMORY))
> + *   (3) user space reads the N'th chunk of device memory snapshot/dirty data
> + *       from region DEVICE_MEMORY.
> + *
> + * 11. set device memory buffer
> + *   (1) user space writes N'th chunk of device memory snapshot/dirty data to
> + *       region DEVICE_MEMORY.
> + *       (N equals to pos/(region length of DEVICE_MEMORY))
> + *   (2) user space writes pos to "device_memory.pos" field and writes
> + *       "SET_BUFFER" to "device_memory.action" field of control region.
> + *   (3) vendor driver loads N'th chunk of device memory snapshot/dirty data
> + *       from region DEVICE_MEMORY.
> + *
> + * 12. get system memory dirty bitmap
> + *   (1) user space calls write system call to specify a range of system
> + *       memory that querying dirty pages.
> + *       system memory's start address --> "system_memory.start_addr" field
> + *       of control region,
> + *       system memory's page count --> "system_memory.page_nr" field of
> + *       control region.
> + *   (2) if device state is not in RUNNING or STOP & LOGGING,
> + *       vendor driver returns empty bitmap; otherwise,
> + *       vendor driver checks the page_nr,
> + *       if it's larger than the size that region DIRTY_BITMAP can support,
> + *       error returns; if not,
> + *       vendor driver returns as bitmap to specify dirty pages that
> + *       device produces since last query in this range of system memory .
> + *   (3) usespace reads back the dirty bitmap from region DIRTY_BITMAP.
> + *
> + */

It might make sense to extract the explanations above into a separate
design document in the kernel Documentation/ directory. You could also
add ASCII art there :)

> +
> +struct vfio_device_state_ctl {
> +	__u32 version;		  /* ro versio of devcie state interfaces*/

s/versio/version/
s/devcie/device/

> +	__u32 device_state;       /* VFIO device state, wo */
> +	__u32 caps;		 /* ro */
> +        struct {

Indentation looks a bit off.

> +		__u32 action;  /* wo, GET_BUFFER or SET_BUFFER */
> +		__u64 size;    /*rw, total size of device config*/
> +	} device_config;
> +	struct {
> +		__u32 action;    /* wo, GET_BUFFER or SET_BUFFER */
> +		__u64 size;     /* rw, total size of device memory*/
> +        __u64 pos;/*chunk offset in total buffer of device memory*/

Here as well.

> +	} device_memory;
> +	struct {
> +		__u64 start_addr; /* wo */
> +		__u64 page_nr;   /* wo */
> +	} system_memory;
> +}__attribute__((packed));

For an interface definition, it's probably better to avoid packed and
instead add padding if needed.

> +
>  /* ***************************************************************** */
>  
>  #endif /* VFIO_H */

On the whole, I think this is moving into the right direction.
