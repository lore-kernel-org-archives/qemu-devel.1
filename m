Received: from eggs.gnu.org ([2001:4830:134:3::10]:42415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1crXRh-0004Yj-3W
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 18:12:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1crXRd-0002tQ-Sd
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 18:12:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1crXRd-0002t8-J3
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 18:12:29 -0400
Date: Fri, 24 Mar 2017 16:12:24 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170324161224.270f334e@t450s.home>
In-Reply-To: <1490260163-6157-4-git-send-email-caoj.fnst@cn.fujitsu.com>
References: <1490260163-6157-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<1490260163-6157-4-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/3] vfio-pci: process non fatal error
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
Cc: qemu-devel@nongnu.org, izumi.taku@jp.fujitsu.com, mst@redhat.com, Dou Liyang <douly.fnst@cn.fujitsu.com>

On Thu, 23 Mar 2017 17:09:23 +0800
Cao jin <caoj.fnst@cn.fujitsu.com> wrote:

> Make use of the non fatal error eventfd that the kernel module provide
> to process the AER non fatal error. Fatal error still goes into the
> legacy way which results in VM stop.
> 
> Register the handler, wait for notification. Construct aer message and
> pass it to root port on notification. Root port will trigger an interrupt
> to signal guest, then guest driver will do the recovery.

Can we guarantee this is the better solution in all cases or could
there be guests without AER support where the VM stop is the better
solution?

> 
> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> ---
>  hw/vfio/pci.c              | 202 +++++++++++++++++++++++++++++++++++++++++++++
>  hw/vfio/pci.h              |   2 +
>  linux-headers/linux/vfio.h |   2 +
>  3 files changed, 206 insertions(+)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 3d0d005..c6786d5 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2432,6 +2432,200 @@ static void vfio_put_device(VFIOPCIDevice *vdev)
>      vfio_put_base_device(&vdev->vbasedev);
>  }
>  
> +static void vfio_non_fatal_err_notifier_handler(void *opaque)
> +{
> +    VFIOPCIDevice *vdev = opaque;
> +    PCIDevice *dev = &vdev->pdev;
> +    PCIEAERMsg msg = {
> +        .severity = PCI_ERR_ROOT_CMD_NONFATAL_EN,
> +        .source_id = pci_requester_id(dev),
> +    };
> +
> +    if (!event_notifier_test_and_clear(&vdev->non_fatal_err_notifier)) {
> +        return;
> +    }
> +
> +    /* Populate the aer msg and send it to root port */
> +    if (dev->exp.aer_cap) {

Why would we have registered this notifier otherwise?

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

Huh?  How can we get a non-fatal error notice for a fatal error?  (and
why are we saving this to a variable rather than testing it within the
'if' condition?

> +
> +        error_report("%s sending non fatal event to root port. uncor status = "
> +                     "0x%"PRIx32, vdev->vbasedev.name, uncor_status);
> +        pcie_aer_msg(dev, &msg);
> +        return;
> +    }
> +
> +stop:
> +    /* Terminate the guest in case of fatal error */
> +    error_report("%s: Device detected a fatal error. VM stopped",
> +	    vdev->vbasedev.name);
> +    vm_stop(RUN_STATE_INTERNAL_ERROR);

Shouldn't we use the existing error index if we can't make use of
correctable errors?

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
> +    if (event_notifier_init(&vdev->non_fatal_err_notifier, 0)) {
> +        error_report("vfio: Unable to init event notifier for non-fatal error detection");
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
> +        error_report("vfio: Failed to set up non-fatal error notification: %m");
> +        qemu_set_fd_handler(*pfd, NULL, NULL, vdev);
> +        event_notifier_cleanup(&vdev->non_fatal_err_notifier);
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
> +    error_report("%s: Device lost state due to host device reset. VM stopped",
> +	    vdev->vbasedev.name);
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
> +    if (event_notifier_init(&vdev->passive_reset_notifier, 0)) {
> +        error_report("vfio: Unable to init event notifier for passive reset");
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
> +        error_report("vfio: Failed to set up passive reset notification: %m");
> +        qemu_set_fd_handler(*pfd, NULL, NULL, vdev);
> +        event_notifier_cleanup(&vdev->passive_reset_notifier);
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
> @@ -2860,6 +3054,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>          }
>      }
>  
> +    vfio_register_passive_reset_notifier(vdev);
> +    vfio_register_non_fatal_err_notifier(vdev);

I think it's wrong that we configure these unconditionally.  Why do we
care about these unless we're configuring the guest to receive AER
events?

>      vfio_register_err_notifier(vdev);
>      vfio_register_req_notifier(vdev);
>      vfio_setup_resetfn_quirk(vdev);
> @@ -2900,6 +3096,12 @@ static void vfio_exitfn(PCIDevice *pdev)
>  
>      vfio_unregister_req_notifier(vdev);
>      vfio_unregister_err_notifier(vdev);
> +    if (event_notifier_get_fd(&vdev->non_fatal_err_notifier)) {
> +        vfio_unregister_non_fatal_err_notifier(vdev);
> +    }
> +    if (event_notifier_get_fd(&vdev->passive_reset_notifier)) {
> +        vfio_unregister_passive_reset_notifier(vdev);
> +    }

Do these tests in the cleanup function.

>      pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
>      vfio_disable_interrupts(vdev);
>      if (vdev->intx.mmap_timer) {
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 34e8b04..b35c617 100644
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
