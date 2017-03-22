Received: from eggs.gnu.org ([2001:4830:134:3::10]:42359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cqgIp-0004bs-23
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:27:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cqgIk-0007vF-Dt
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:27:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cqgIk-0007uI-3n
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:27:46 -0400
Date: Wed, 22 Mar 2017 15:27:39 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170322151235-mutt-send-email-mst@kernel.org>
References: <1490179012-14990-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<1490179012-14990-4-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490179012-14990-4-git-send-email-caoj.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] vfio-pci: process non fatal error
 of AER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, izumi.taku@jp.fujitsu.com, alex.williamson@redhat.com, Dou Liyang <douly.fnst@cn.fujitsu.com>, peterx@redhat.com

On Wed, Mar 22, 2017 at 06:36:52PM +0800, Cao jin wrote:
> Make use of the non fatal error eventfd that the kernel module provide
> to process the AER non fatal error. Fatal error still goes into the
> legacy way which results in VM stop.
> 
> Register the handler, wait for notification. Construct aer message and
> pass it to root port on notification. Root port will trigger an interrupt
> to signal guest, then guest driver will do the recovery.
> 
> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> ---
>  hw/vfio/pci.c              | 247 +++++++++++++++++++++++++++++++++++++++++++++
>  hw/vfio/pci.h              |   4 +
>  linux-headers/linux/vfio.h |   2 +
>  3 files changed, 253 insertions(+)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 3d0d005..4912bc6 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2422,6 +2422,34 @@ static void vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
>                       "Could not enable error recovery for the device",
>                       vbasedev->name);
>      }
> +
> +    irq_info.index = VFIO_PCI_NON_FATAL_ERR_IRQ_INDEX;
> +    irq_info.count = 0; /* clear */
> +    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_info);
> +    if (ret) {
> +        /* This can fail for an old kernel or legacy PCI dev */
> +        trace_vfio_populate_device_get_irq_info_failure();
> +    } else if (irq_info.count == 1) {
> +        vdev->pci_aer_non_fatal = true;
> +    } else {
> +        error_report(WARN_PREFIX
> +                     "Couldn't enable non fatal error recovery for the device",
> +                     vbasedev->name);

when does this trigger?

> +    }
> +
> +    irq_info.index = VFIO_PCI_PASSIVE_RESET_IRQ_INDEX;
> +    irq_info.count = 0; /* clear */
> +    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_info);
> +    if (ret) {
> +        /* This can fail for an old kernel or legacy PCI dev */
> +        trace_vfio_populate_device_get_irq_info_failure();
> +    } else if (irq_info.count == 1) {
> +        vdev->passive_reset = true;
> +    } else {
> +        error_report(WARN_PREFIX
> +                     "Don't support passive reset notification",
> +                     vbasedev->name);

when does this happen?
what does this message mean?

> +    }
>  }
>  
>  static void vfio_put_device(VFIOPCIDevice *vdev)
> @@ -2432,6 +2460,221 @@ static void vfio_put_device(VFIOPCIDevice *vdev)
>      vfio_put_base_device(&vdev->vbasedev);
>  }
>  
> +static void vfio_non_fatal_err_notifier_handler(void *opaque)
> +{
> +    VFIOPCIDevice *vdev = opaque;
> +    PCIDevice *dev = &vdev->pdev;
> +    PCIEAERMsg msg = {
> +        .severity = PCI_ERR_ROOT_CMD_NONFATAL_EN,
> +        .source_id = (pci_bus_num(dev->bus) << 8) | dev->devfn,
> +    };
> +

Should this just use pci_requester_id?


At least Peter thought so.

> +    if (!event_notifier_test_and_clear(&vdev->non_fatal_err_notifier)) {
> +        return;
> +    }
> +
> +    /* Populate the aer msg and send it to root port */
> +    if (dev->exp.aer_cap) {
> +        uint8_t *aer_cap = dev->config + dev->exp.aer_cap;
> +        uint32_t uncor_status;
> +        bool isfatal;
> +
> +        uncor_status = vfio_pci_read_config(dev,
> +                            dev->exp.aer_cap + PCI_ERR_UNCOR_STATUS, 4);
> +        if (!uncor_status) {
> +            return;
> +        }
> +
> +        isfatal = uncor_status & pci_get_long(aer_cap + PCI_ERR_UNCOR_SEVER);
> +        if (isfatal) {
> +            goto stop;
> +        }
> +
> +        error_report("%s sending non fatal event to root port. uncor status = "
> +                     "0x%"PRIx32, vdev->vbasedev.name, uncor_status);
> +        pcie_aer_msg(dev, &msg);
> +        return;
> +    }
> +
> +stop:
> +    /* Terminate the guest in case of fatal error */
> +    error_report("%s(%s) fatal error detected. Please collect any data"
> +            " possible and then kill the guest", __func__, vdev->vbasedev.name);

"Device detected a fatal error. VM stopped".

would be better IMO.


> +    vm_stop(RUN_STATE_INTERNAL_ERROR);
> +}
> +
> +/*
> + * Register non fatal error notifier for devices supporting error recovery.
> + * If we encounter a failure in this function, we report an error
> + * and continue after disabling error recovery support for the device.
> + */
> +static void vfio_register_non_fatal_err_notifier(VFIOPCIDevice *vdev)
> +{
> +    int ret;
> +    int argsz;
> +    struct vfio_irq_set *irq_set;
> +    int32_t *pfd;
> +
> +    if (!vdev->pci_aer_non_fatal) {
> +        return;
> +    }
> +
> +    if (event_notifier_init(&vdev->non_fatal_err_notifier, 0)) {
> +        error_report("vfio: Unable to init event notifier for non-fatal error detection");
> +        vdev->pci_aer_non_fatal = false;
> +        return;
> +    }
> +
> +    argsz = sizeof(*irq_set) + sizeof(*pfd);
> +
> +    irq_set = g_malloc0(argsz);
> +    irq_set->argsz = argsz;
> +    irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD |
> +                     VFIO_IRQ_SET_ACTION_TRIGGER;
> +    irq_set->index = VFIO_PCI_NON_FATAL_ERR_IRQ_INDEX;
> +    irq_set->start = 0;
> +    irq_set->count = 1;
> +    pfd = (int32_t *)&irq_set->data;
> +
> +    *pfd = event_notifier_get_fd(&vdev->non_fatal_err_notifier);
> +    qemu_set_fd_handler(*pfd, vfio_non_fatal_err_notifier_handler, NULL, vdev);
> +
> +    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
> +    if (ret) {
> +        error_report("vfio: Failed to set up non-fatal error notification");
> +        qemu_set_fd_handler(*pfd, NULL, NULL, vdev);
> +        event_notifier_cleanup(&vdev->non_fatal_err_notifier);
> +        vdev->pci_aer_non_fatal = false;
> +    }
> +    g_free(irq_set);
> +}
> +
> +static void vfio_unregister_non_fatal_err_notifier(VFIOPCIDevice *vdev)
> +{
> +    int argsz;
> +    struct vfio_irq_set *irq_set;
> +    int32_t *pfd;
> +    int ret;
> +
> +    if (!vdev->pci_aer_non_fatal) {
> +        return;
> +    }
> +
> +    argsz = sizeof(*irq_set) + sizeof(*pfd);
> +
> +    irq_set = g_malloc0(argsz);
> +    irq_set->argsz = argsz;
> +    irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD |
> +                     VFIO_IRQ_SET_ACTION_TRIGGER;
> +    irq_set->index = VFIO_PCI_NON_FATAL_ERR_IRQ_INDEX;
> +    irq_set->start = 0;
> +    irq_set->count = 1;
> +    pfd = (int32_t *)&irq_set->data;
> +    *pfd = -1;
> +
> +    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
> +    if (ret) {
> +        error_report("vfio: Failed to de-assign error fd: %m");
> +    }
> +    g_free(irq_set);
> +    qemu_set_fd_handler(event_notifier_get_fd(&vdev->non_fatal_err_notifier),
> +                        NULL, NULL, vdev);
> +    event_notifier_cleanup(&vdev->non_fatal_err_notifier);
> +}
> +
> +static void vfio_passive_reset_notifier_handler(void *opaque)
> +{
> +    VFIOPCIDevice *vdev = opaque;
> +
> +    if (!event_notifier_test_and_clear(&vdev->passive_reset_notifier)) {
> +        return;
> +    }
> +
> +    error_report("device %s is forced to be reset. Please collect any data"
> +            " possible and then kill the guest", vdev->vbasedev.name);

I think we should just tell what happened in detail. Don't tell user what to do:

"Device lost state due to host device reset. VM stopped".


> +    vm_stop(RUN_STATE_INTERNAL_ERROR);
> +}
> +
> +/*
> + * Register passive reset notifier, in case of certain function of a
> + * multifunction device is passthroughed,  while other functions are still
> + * controlled by device driver.
> + */
> +static void vfio_register_passive_reset_notifier(VFIOPCIDevice *vdev)
> +{
> +    int ret;
> +    int argsz;
> +    struct vfio_irq_set *irq_set;
> +    int32_t *pfd;
> +
> +    error_report("Registering event notifier for passive reset");
> +    if (!vdev->passive_reset) {
> +        return;
> +    }
> +
> +    if (event_notifier_init(&vdev->passive_reset_notifier, 0)) {
> +        error_report("vfio: Unable to init event notifier for passive reset");
> +        vdev->passive_reset = false;
> +        return;
> +    }
> +
> +    argsz = sizeof(*irq_set) + sizeof(*pfd);
> +
> +    irq_set = g_malloc0(argsz);
> +    irq_set->argsz = argsz;
> +    irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD |
> +                     VFIO_IRQ_SET_ACTION_TRIGGER;
> +    irq_set->index = VFIO_PCI_PASSIVE_RESET_IRQ_INDEX;
> +    irq_set->start = 0;
> +    irq_set->count = 1;
> +    pfd = (int32_t *)&irq_set->data;
> +
> +    *pfd = event_notifier_get_fd(&vdev->passive_reset_notifier);
> +    qemu_set_fd_handler(*pfd, vfio_passive_reset_notifier_handler, NULL, vdev);
> +
> +    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
> +    if (ret) {
> +        error_report("vfio: Failed to set up passive reset notification");
> +        qemu_set_fd_handler(*pfd, NULL, NULL, vdev);
> +        event_notifier_cleanup(&vdev->passive_reset_notifier);
> +        vdev->passive_reset = false;
> +    }
> +    g_free(irq_set);
> +}
> +
> +static void vfio_unregister_passive_reset_notifier(VFIOPCIDevice *vdev)
> +{
> +    int argsz;
> +    struct vfio_irq_set *irq_set;
> +    int32_t *pfd;
> +    int ret;
> +
> +    if (!vdev->passive_reset) {
> +        return;
> +    }
> +
> +    argsz = sizeof(*irq_set) + sizeof(*pfd);
> +
> +    irq_set = g_malloc0(argsz);
> +    irq_set->argsz = argsz;
> +    irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD |
> +                     VFIO_IRQ_SET_ACTION_TRIGGER;
> +    irq_set->index = VFIO_PCI_PASSIVE_RESET_IRQ_INDEX;
> +    irq_set->start = 0;
> +    irq_set->count = 1;
> +    pfd = (int32_t *)&irq_set->data;
> +    *pfd = -1;
> +
> +    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
> +    if (ret) {
> +        error_report("vfio: Failed to de-assign error fd: %m");
> +    }
> +    g_free(irq_set);
> +    qemu_set_fd_handler(event_notifier_get_fd(&vdev->passive_reset_notifier),
> +                        NULL, NULL, vdev);
> +    event_notifier_cleanup(&vdev->passive_reset_notifier);
> +}
> +
>  static void vfio_err_notifier_handler(void *opaque)
>  {
>      VFIOPCIDevice *vdev = opaque;
> @@ -2860,6 +3103,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>          }
>      }
>  
> +    vfio_register_passive_reset_notifier(vdev);
> +    vfio_register_non_fatal_err_notifier(vdev);
>      vfio_register_err_notifier(vdev);
>      vfio_register_req_notifier(vdev);
>      vfio_setup_resetfn_quirk(vdev);
> @@ -2900,6 +3145,8 @@ static void vfio_exitfn(PCIDevice *pdev)
>  
>      vfio_unregister_req_notifier(vdev);
>      vfio_unregister_err_notifier(vdev);
> +    vfio_unregister_non_fatal_err_notifier(vdev);
> +    vfio_unregister_passive_reset_notifier(vdev);
>      pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
>      vfio_disable_interrupts(vdev);
>      if (vdev->intx.mmap_timer) {
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 34e8b04..dcb0e0a 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -119,6 +119,8 @@ typedef struct VFIOPCIDevice {
>      void *igd_opregion;
>      PCIHostDeviceAddress host;
>      EventNotifier err_notifier;
> +    EventNotifier non_fatal_err_notifier;
> +    EventNotifier passive_reset_notifier;
>      EventNotifier req_notifier;
>      int (*resetfn)(struct VFIOPCIDevice *);
>      uint32_t vendor_id;
> @@ -137,6 +139,8 @@ typedef struct VFIOPCIDevice {
>      uint32_t igd_gms;
>      uint8_t pm_cap;
>      bool pci_aer;
> +    bool pci_aer_non_fatal;
> +    bool passive_reset;
>      bool req_enabled;
>      bool has_flr;
>      bool has_pm_reset;

Why do you need these flags? Why isn't the notifier sufficient?

> diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
> index 759b850..726ddbe 100644
> --- a/linux-headers/linux/vfio.h
> +++ b/linux-headers/linux/vfio.h
> @@ -433,6 +433,8 @@ enum {
>  	VFIO_PCI_MSIX_IRQ_INDEX,
>  	VFIO_PCI_ERR_IRQ_INDEX,
>  	VFIO_PCI_REQ_IRQ_INDEX,
> +	VFIO_PCI_NON_FATAL_ERR_IRQ_INDEX,
> +	VFIO_PCI_PASSIVE_RESET_IRQ_INDEX,
>  	VFIO_PCI_NUM_IRQS
>  };
>  
> -- 
> 1.8.3.1
> 
> 
