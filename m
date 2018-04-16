Received: from eggs.gnu.org ([2001:4830:134:3::10]:37214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1f85N5-0005Xx-Qv
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:44:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1f85N2-0007sh-NX
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:44:43 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:2601)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
	id 1f85N2-0007rq-FB
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:44:40 -0400
References: <1523340177-8975-1-git-send-email-yulei.zhang@intel.com>
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <d9da5967-e44f-d0a4-3f8a-375f640e56d2@nvidia.com>
Date: Mon, 16 Apr 2018 20:14:27 +0530
MIME-Version: 1.0
In-Reply-To: <1523340177-8975-1-git-send-email-yulei.zhang@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH V4 2/4] vfio: Add vm status change
 callback to stop/restart the mdev device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yulei Zhang <yulei.zhang@intel.com>, qemu-devel@nongnu.org
Cc: kevin.tian@intel.com, joonas.lahtinen@linux.intel.com, zhenyuw@linux.intel.com, zhi.a.wang@intel.com, alex.williamson@redhat.com, dgilbert@redhat.com, quintela@redhat.com



On 4/10/2018 11:32 AM, Yulei Zhang wrote:
> VM status change handler is added to change the vfio pci device
> status during the migration, write the demanded device status
> to the DEVICE STATUS subregion to stop the device on the source side
> before fetch its status and start the deivce on the target side
> after restore its status.
> 
> Signed-off-by: Yulei Zhang <yulei.zhang@intel.com>
> ---
>  hw/vfio/pci.c                 | 20 ++++++++++++++++++++
>  include/hw/vfio/vfio-common.h |  1 +
>  linux-headers/linux/vfio.h    |  6 ++++++
>  roms/seabios                  |  2 +-
>  4 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index f98a9dd..13d8c73 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -38,6 +38,7 @@
>  
>  static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
>  static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
> +static void vfio_vm_change_state_handler(void *pv, int running, RunState state);
>  
>  /*
>   * Disabling BAR mmaping can be slow, but toggling it around INTx can
> @@ -2896,6 +2897,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>      vfio_register_err_notifier(vdev);
>      vfio_register_req_notifier(vdev);
>      vfio_setup_resetfn_quirk(vdev);
> +    qemu_add_vm_change_state_handler(vfio_vm_change_state_handler, vdev);
>  
>      return;
>  
> @@ -2982,6 +2984,24 @@ post_reset:
>      vfio_pci_post_reset(vdev);
>  }
>  
> +static void vfio_vm_change_state_handler(void *pv, int running, RunState state)
> +{
> +    VFIOPCIDevice *vdev = pv;
> +    VFIODevice *vbasedev = &vdev->vbasedev;
> +    uint8_t dev_state;
> +    uint8_t sz = 1;
> +
> +    dev_state = running ? VFIO_DEVICE_START : VFIO_DEVICE_STOP;
> +
> +    if (pwrite(vdev->vbasedev.fd, &dev_state,
> +               sz, vdev->device_state.offset) != sz) {
> +        error_report("vfio: Failed to %s device", running ? "start" : "stop");
> +        return;
> +    }
> +
> +    vbasedev->device_state = dev_state;
> +}
> +

Is it expected to trap device_state region by vendor driver?
Can this information be communicated to vendor driver through an ioctl?

Here only device state is conveyed to vendor driver but knowing
'RunState' in vendor driver is very useful and vendor driver can take
necessary action accordingly like RUN_STATE_PAUSED indicating that VM is
in paused state, similarly RUN_STATE_SUSPENDED,
RUN_STATE_FINISH_MIGRATE, RUN_STATE_IO_ERROR. If these states are
handled properly, all the cases can be supported with same interface
like VM suspend-resume, VM pause-restore.

Thanks,
Kirti

>  static void vfio_instance_init(Object *obj)
>  {
>      PCIDevice *pci_dev = PCI_DEVICE(obj);
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index f3a2ac9..9c14a8f 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -125,6 +125,7 @@ typedef struct VFIODevice {
>      unsigned int num_irqs;
>      unsigned int num_regions;
>      unsigned int flags;
> +    bool device_state;
>  } VFIODevice;
>  
>  struct VFIODeviceOps {
> diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
> index e3380ad..8f02f2f 100644
> --- a/linux-headers/linux/vfio.h
> +++ b/linux-headers/linux/vfio.h
> @@ -304,6 +304,12 @@ struct vfio_region_info_cap_type {
>  /* Mdev sub-type for device state save and restore */
>  #define VFIO_REGION_SUBTYPE_DEVICE_STATE	(4)
>  
> +/* Offset in region to save device state */
> +#define VFIO_DEVICE_STATE_OFFSET	1
> +
> +#define VFIO_DEVICE_START	0
> +#define VFIO_DEVICE_STOP	1
> +
>  /**
>   * VFIO_DEVICE_GET_IRQ_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 9,
>   *				    struct vfio_irq_info)
> diff --git a/roms/seabios b/roms/seabios
> index 63451fc..5f4c7b1 160000
> --- a/roms/seabios
> +++ b/roms/seabios
> @@ -1 +1 @@
> -Subproject commit 63451fca13c75870e1703eb3e20584d91179aebc
> +Subproject commit 5f4c7b13cdf9c450eb55645f4362ea58fa61b79b
> 
