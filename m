Received: from eggs.gnu.org ([209.51.188.92]:56905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gm2DM-000691-JV
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 15:00:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gm2DL-0007I5-1q
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 15:00:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gm2DK-0007CN-O1
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 15:00:02 -0500
Date: Tue, 22 Jan 2019 12:51:34 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190122125134.6726621d@w520.home>
In-Reply-To: <20190117210632.18567-2-eric.auger@redhat.com>
References: <20190117210632.18567-1-eric.auger@redhat.com>
	<20190117210632.18567-2-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] vfio-pci: Introduce
 vfio_set_event_handler helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, aik@ozlabs.ru, cohuck@redhat.com

On Thu, 17 Jan 2019 22:06:31 +0100
Eric Auger <eric.auger@redhat.com> wrote:

> The code used to attach the eventfd handler for the ERR and
> REQ irq indices can be factorized into a helper. In subsequent
> patches we will extend this helper to support other irq indices.
> 
> We test whether the notification is allowed outside of the helper:
> respectively check vdev->pci_aer and VFIO_FEATURE_ENABLE_REQ.
> Depending on the returned value we set vdev->pci_aer and
> vdev->req_enabled. An error handle is introduced for future usage
> although not strictly useful here.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v1 -> v2:
> - s/vfio_register_event_notifier/vfio_set_event_handler
> - turned into a void function
> - do the qemu_set_fd_handler(*pfd, NULL, NULL, vdev) and
>   event_notifier_cleanup on VFIO_DEVICE_SET_IRQS failure
>   as reported by Alexey
> - reset err in vfio_realize as reported by Cornelia
> - Text/comment fixes suggested by Cornelia
> ---
>  hw/vfio/pci.c | 296 ++++++++++++++++++++++----------------------------
>  1 file changed, 132 insertions(+), 164 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index c0cb1ec289..3cae4c99ef 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -105,6 +105,96 @@ static void vfio_intx_eoi(VFIODevice *vbasedev)
>      vfio_unmask_single_irqindex(vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
>  }
>  
> +/*
> + * vfio_set_event_handler - setup/tear down eventfd
> + * notification and handling for IRQ indices that span over
> + * a single IRQ
> + *
> + * @vdev: VFIO device handle
> + * @index: IRQ index the eventfd/handler is associated with
> + * @enable: true means notifier chain needs to be set up
> + * @handler: handler to attach if @enable is true

Therefore @enable is redundant.

> + * @errp: error handle
> + */
> +static void vfio_set_event_handler(VFIOPCIDevice *vdev,
> +                                   int index,
> +                                   bool enable,
> +                                   void (*handler)(void *opaque),
> +                                   Error **errp)
> +{
> +    struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info),
> +                                      .index = index };
> +    struct vfio_irq_set *irq_set;
> +    EventNotifier *notifier;
> +    int argsz, ret = 0;
> +    int32_t *pfd, fd;
> +
> +    switch (index) {
> +    case VFIO_PCI_REQ_IRQ_INDEX:
> +        notifier = &vdev->req_notifier;
> +        break;
> +    case VFIO_PCI_ERR_IRQ_INDEX:
> +        notifier = &vdev->err_notifier;
> +        break;

This blows the abstraction of a helper that this seems to be trying to
create, seems cleaner to pass @notifier.

> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    if (ioctl(vdev->vbasedev.fd,
> +              VFIO_DEVICE_GET_IRQ_INFO, &irq_info) < 0 || irq_info.count < 1) {
> +        error_setg_errno(errp, errno, "No irq index %d available", index);
> +        return;

The implicit count, aka sub-index, is also problematic for the
abstraction.  Can we tackle applying this to MSI/X to validate if this
needs to go another step to allow the caller to specify index and
sub-index?

> +    }
> +
> +    if (enable) {
> +        ret = event_notifier_init(notifier, 0);
> +        if (ret) {
> +            error_setg_errno(errp, -ret,
> +                             "Unable to init event notifier for irq index %d",
> +                             index);
> +            return;
> +        }
> +    }
> +
> +    argsz = sizeof(*irq_set) + sizeof(*pfd);
> +
> +    irq_set = g_malloc0(argsz);
> +    irq_set->argsz = argsz;
> +    irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD |
> +                     VFIO_IRQ_SET_ACTION_TRIGGER;
> +    irq_set->index = index;
> +    irq_set->start = 0;
> +    irq_set->count = 1;
> +    pfd = (int32_t *)&irq_set->data;
> +
> +    if (!notifier) {
> +        error_setg(errp, "Notifier not initialized for irq index %d", index);
> +        return;
> +    }

What is this supposed to check?  @notifier is not NULL initialized, the
case statement will assert if it doesn't get set, and this doesn't
actually test if it's properly initialized.

> +
> +    fd = event_notifier_get_fd(notifier);
> +
> +    if (enable) {
> +        qemu_set_fd_handler(fd, handler, NULL, vdev);
> +        *pfd = fd;
> +    } else {
> +        *pfd = -1;
> +    }
> +
> +    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
> +    g_free(irq_set);
> +
> +    if (ret) {
> +        error_setg_errno(errp, -ret,
> +                         "Failed to %s eventfd signalling for index %d",
> +                         enable ? "set up" : "tear down", index);
> +    }
> +    if (ret || !enable) {
> +        qemu_set_fd_handler(fd, NULL, NULL, vdev);
> +        event_notifier_cleanup(notifier);
> +    }
> +}

Suggest passing @notifier as a parameter and using @handler in place of
@enable, more generic and more obvious calling convention.

> +
>  static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
>  {
>  #ifdef CONFIG_KVM
> @@ -2621,86 +2711,6 @@ static void vfio_err_notifier_handler(void *opaque)
>      vm_stop(RUN_STATE_INTERNAL_ERROR);
>  }
>  
> -/*
> - * Registers error notifier for devices supporting error recovery.
> - * If we encounter a failure in this function, we report an error
> - * and continue after disabling error recovery support for the
> - * device.
> - */
> -static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
> -{
> -    int ret;
> -    int argsz;
> -    struct vfio_irq_set *irq_set;
> -    int32_t *pfd;
> -
> -    if (!vdev->pci_aer) {
> -        return;
> -    }
> -
> -    if (event_notifier_init(&vdev->err_notifier, 0)) {
> -        error_report("vfio: Unable to init event notifier for error detection");
> -        vdev->pci_aer = false;
> -        return;
> -    }
> -
> -    argsz = sizeof(*irq_set) + sizeof(*pfd);
> -
> -    irq_set = g_malloc0(argsz);
> -    irq_set->argsz = argsz;
> -    irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD |
> -                     VFIO_IRQ_SET_ACTION_TRIGGER;
> -    irq_set->index = VFIO_PCI_ERR_IRQ_INDEX;
> -    irq_set->start = 0;
> -    irq_set->count = 1;
> -    pfd = (int32_t *)&irq_set->data;
> -
> -    *pfd = event_notifier_get_fd(&vdev->err_notifier);
> -    qemu_set_fd_handler(*pfd, vfio_err_notifier_handler, NULL, vdev);
> -
> -    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
> -    if (ret) {
> -        error_report("vfio: Failed to set up error notification");
> -        qemu_set_fd_handler(*pfd, NULL, NULL, vdev);
> -        event_notifier_cleanup(&vdev->err_notifier);
> -        vdev->pci_aer = false;
> -    }
> -    g_free(irq_set);
> -}
> -
> -static void vfio_unregister_err_notifier(VFIOPCIDevice *vdev)
> -{
> -    int argsz;
> -    struct vfio_irq_set *irq_set;
> -    int32_t *pfd;
> -    int ret;
> -
> -    if (!vdev->pci_aer) {
> -        return;
> -    }
> -
> -    argsz = sizeof(*irq_set) + sizeof(*pfd);
> -
> -    irq_set = g_malloc0(argsz);
> -    irq_set->argsz = argsz;
> -    irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD |
> -                     VFIO_IRQ_SET_ACTION_TRIGGER;
> -    irq_set->index = VFIO_PCI_ERR_IRQ_INDEX;
> -    irq_set->start = 0;
> -    irq_set->count = 1;
> -    pfd = (int32_t *)&irq_set->data;
> -    *pfd = -1;
> -
> -    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
> -    if (ret) {
> -        error_report("vfio: Failed to de-assign error fd: %m");
> -    }
> -    g_free(irq_set);
> -    qemu_set_fd_handler(event_notifier_get_fd(&vdev->err_notifier),
> -                        NULL, NULL, vdev);
> -    event_notifier_cleanup(&vdev->err_notifier);
> -}
> -
>  static void vfio_req_notifier_handler(void *opaque)
>  {
>      VFIOPCIDevice *vdev = opaque;
> @@ -2716,86 +2726,6 @@ static void vfio_req_notifier_handler(void *opaque)
>      }
>  }
>  
> -static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
> -{
> -    struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info),
> -                                      .index = VFIO_PCI_REQ_IRQ_INDEX };
> -    int argsz;
> -    struct vfio_irq_set *irq_set;
> -    int32_t *pfd;
> -
> -    if (!(vdev->features & VFIO_FEATURE_ENABLE_REQ)) {
> -        return;
> -    }
> -
> -    if (ioctl(vdev->vbasedev.fd,
> -              VFIO_DEVICE_GET_IRQ_INFO, &irq_info) < 0 || irq_info.count < 1) {
> -        return;
> -    }
> -
> -    if (event_notifier_init(&vdev->req_notifier, 0)) {
> -        error_report("vfio: Unable to init event notifier for device request");
> -        return;
> -    }
> -
> -    argsz = sizeof(*irq_set) + sizeof(*pfd);
> -
> -    irq_set = g_malloc0(argsz);
> -    irq_set->argsz = argsz;
> -    irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD |
> -                     VFIO_IRQ_SET_ACTION_TRIGGER;
> -    irq_set->index = VFIO_PCI_REQ_IRQ_INDEX;
> -    irq_set->start = 0;
> -    irq_set->count = 1;
> -    pfd = (int32_t *)&irq_set->data;
> -
> -    *pfd = event_notifier_get_fd(&vdev->req_notifier);
> -    qemu_set_fd_handler(*pfd, vfio_req_notifier_handler, NULL, vdev);
> -
> -    if (ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
> -        error_report("vfio: Failed to set up device request notification");
> -        qemu_set_fd_handler(*pfd, NULL, NULL, vdev);
> -        event_notifier_cleanup(&vdev->req_notifier);
> -    } else {
> -        vdev->req_enabled = true;
> -    }
> -
> -    g_free(irq_set);
> -}
> -
> -static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
> -{
> -    int argsz;
> -    struct vfio_irq_set *irq_set;
> -    int32_t *pfd;
> -
> -    if (!vdev->req_enabled) {
> -        return;
> -    }
> -
> -    argsz = sizeof(*irq_set) + sizeof(*pfd);
> -
> -    irq_set = g_malloc0(argsz);
> -    irq_set->argsz = argsz;
> -    irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD |
> -                     VFIO_IRQ_SET_ACTION_TRIGGER;
> -    irq_set->index = VFIO_PCI_REQ_IRQ_INDEX;
> -    irq_set->start = 0;
> -    irq_set->count = 1;
> -    pfd = (int32_t *)&irq_set->data;
> -    *pfd = -1;
> -
> -    if (ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
> -        error_report("vfio: Failed to de-assign device request fd: %m");
> -    }
> -    g_free(irq_set);
> -    qemu_set_fd_handler(event_notifier_get_fd(&vdev->req_notifier),
> -                        NULL, NULL, vdev);
> -    event_notifier_cleanup(&vdev->req_notifier);
> -
> -    vdev->req_enabled = false;
> -}
> -
>  static void vfio_realize(PCIDevice *pdev, Error **errp)
>  {
>      VFIOPCIDevice *vdev = PCI_VFIO(pdev);
> @@ -3069,8 +2999,33 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>          goto out_teardown;
>      }
>  
> -    vfio_register_err_notifier(vdev);
> -    vfio_register_req_notifier(vdev);
> +    if (vdev->pci_aer) {
> +        Error *err = NULL;
> +
> +        /*
> +         * Registers error notifier for devices supporting error recovery.
> +         * If we encounter a failure during registration, we report an error
> +         * and continue after disabling error recovery support for the
> +         * device.
> +         */
> +        vfio_set_event_handler(vdev, VFIO_PCI_ERR_IRQ_INDEX, true,
> +                               vfio_err_notifier_handler, &err);
> +        if (err) {
> +            warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
> +        }

Why not just return -1 on error and zero on success so we can call as:

    if (vfio_set_event_handler(...)) {
        warn_reportf_err()...
    }

> +        vdev->pci_aer = !err;

We could also avoid this weirdness of this negation to get a bool.

> +    }

It's not obvious how doing away with the register/unregister helpers
and doing everything inline is an improvement.  Simple helpers calling
common helpers seems better than inline sprawl calling common helpers.
Thanks,

Alex

> +
> +    if (vdev->features & VFIO_FEATURE_ENABLE_REQ) {
> +        Error *err = NULL;
> +
> +        vfio_set_event_handler(vdev, VFIO_PCI_REQ_IRQ_INDEX, true,
> +                               vfio_req_notifier_handler, &err);
> +        if (err) {
> +            warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
> +        }
> +        vdev->req_enabled = !err;
> +    }
>      vfio_setup_resetfn_quirk(vdev);
>  
>      return;
> @@ -3106,9 +3061,22 @@ static void vfio_instance_finalize(Object *obj)
>  static void vfio_exitfn(PCIDevice *pdev)
>  {
>      VFIOPCIDevice *vdev = PCI_VFIO(pdev);
> +    Error *err = NULL;
>  
> -    vfio_unregister_req_notifier(vdev);
> -    vfio_unregister_err_notifier(vdev);
> +    if (vdev->req_enabled) {
> +        vfio_set_event_handler(vdev, VFIO_PCI_REQ_IRQ_INDEX,
> +                               false, NULL, &err);
> +        if (err) {
> +            warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
> +        }
> +    }
> +    if (vdev->pci_aer) {
> +        vfio_set_event_handler(vdev, VFIO_PCI_ERR_IRQ_INDEX,
> +                                     false, NULL, &err);
> +        if (err) {
> +            warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
> +        }
> +    }
>      pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
>      vfio_disable_interrupts(vdev);
>      if (vdev->intx.mmap_timer) {
