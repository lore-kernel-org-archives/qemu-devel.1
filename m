Received: from eggs.gnu.org ([209.51.188.92]:57470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gm2FA-0007be-G7
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 15:01:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gm2F8-0000JH-NP
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 15:01:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gm2F8-0008Rp-9t
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 15:01:54 -0500
Date: Tue, 22 Jan 2019 12:51:45 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190122125145.49ec1be4@w520.home>
In-Reply-To: <20190117210632.18567-3-eric.auger@redhat.com>
References: <20190117210632.18567-1-eric.auger@redhat.com>
	<20190117210632.18567-3-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] vfio-pci: Use
 vfio_set_event_handler in vfio_intx_enable
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

On Thu, 17 Jan 2019 22:06:32 +0100
Eric Auger <eric.auger@redhat.com> wrote:

> vfio_set_event_handler() can be used  in vfio_intx_enable()
> to set the signalling associated with VFIO_PCI_INTX_IRQ_INDEX.
> 
> We also turn vfio_intx_enable() into a void function.

Why?

> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> vfio_set_event_handler cannot be used in vfio_intx_disable. The reason
> is not a call sequence issue but the VFIO_DEVICE_SET_IRQS invoction.
> vfio_disable_irqindex uses ACTION_TRIGGER/DATA_NONE/count==0 whereas
> the new helper uses ACTION_TRIGGER/DATA_EVENTFD/fd==-1. Surprisingly
> to me, both are not resulting into the same kernel actions. The first
> one does a complete tear down of the INTx (vfio_intx_disable), while
> the second - just taking care of a single index, the only one by the
> way for INTx -, does an incomplete tear down (vfio_intx_set_signal).
> If the last one is used, a subsequent setup of MSIx vectors fails.

As we discussed offline, this is documented in the uapi and reflects
that the device can be in an interrupt mode without any signaling
vectors.  For instance the MSI or MSI-X capability on a PCI device can
be enabled, but no vectors are configured to signal.  It's a bit of an
after thought how we enter this mode (see vfio_msix_enable), but it has
proven useful.  If INTx is going to use the helper for setup but not
teardown there at least needs to be a comment in the code indicating
the limitation so that an unwitting contributor doesn't fall for the
seemingly obvious simplification.

> 
> v1 -> v2:
> - turn vfio_intx_enable into a void function
> - s/vfio_intx_enable_kvm/vfio_intx_enable in title and commit msg
> ---
>  hw/vfio/pci.c | 51 +++++++++++++--------------------------------------
>  1 file changed, 13 insertions(+), 38 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 3cae4c99ef..dcba7a1539 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -136,6 +136,9 @@ static void vfio_set_event_handler(VFIOPCIDevice *vdev,
>      case VFIO_PCI_ERR_IRQ_INDEX:
>          notifier = &vdev->err_notifier;
>          break;
> +    case VFIO_PCI_INTX_IRQ_INDEX:
> +        notifier = &vdev->intx.interrupt;
> +        break;


I'm still not a fan of a helper than needs to be updated for each new
caller.

>      default:
>          g_assert_not_reached();
>      }
> @@ -349,16 +352,13 @@ static void vfio_intx_update(PCIDevice *pdev)
>      vfio_intx_eoi(&vdev->vbasedev);
>  }
>  
> -static int vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
> +static void vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>  {
>      uint8_t pin = vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN, 1);
> -    int ret, argsz, retval = 0;
> -    struct vfio_irq_set *irq_set;
> -    int32_t *pfd;
>      Error *err = NULL;
>  
>      if (!pin) {
> -        return 0;
> +        return;
>      }
>  
>      vfio_disable_interrupts(vdev);
> @@ -377,32 +377,11 @@ static int vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>      }
>  #endif
>  
> -    ret = event_notifier_init(&vdev->intx.interrupt, 0);
> -    if (ret) {
> -        error_setg_errno(errp, -ret, "event_notifier_init failed");
> -        return ret;
> -    }
> -
> -    argsz = sizeof(*irq_set) + sizeof(*pfd);
> -
> -    irq_set = g_malloc0(argsz);
> -    irq_set->argsz = argsz;
> -    irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD | VFIO_IRQ_SET_ACTION_TRIGGER;
> -    irq_set->index = VFIO_PCI_INTX_IRQ_INDEX;
> -    irq_set->start = 0;
> -    irq_set->count = 1;
> -    pfd = (int32_t *)&irq_set->data;
> -
> -    *pfd = event_notifier_get_fd(&vdev->intx.interrupt);
> -    qemu_set_fd_handler(*pfd, vfio_intx_interrupt, NULL, vdev);
> -
> -    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
> -    if (ret) {
> -        error_setg_errno(errp, -ret, "failed to setup INTx fd");
> -        qemu_set_fd_handler(*pfd, NULL, NULL, vdev);
> -        event_notifier_cleanup(&vdev->intx.interrupt);
> -        retval = -errno;
> -        goto cleanup;
> +    vfio_set_event_handler(vdev, VFIO_PCI_INTX_IRQ_INDEX, true,
> +                                 vfio_intx_interrupt, &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
>      }
>  
>      vfio_intx_enable_kvm(vdev, &err);
> @@ -413,11 +392,6 @@ static int vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>      vdev->interrupt = VFIO_INT_INTx;
>  
>      trace_vfio_intx_enable(vdev->vbasedev.name);
> -
> -cleanup:
> -    g_free(irq_set);
> -
> -    return retval;
>  }
>  
>  static void vfio_intx_disable(VFIOPCIDevice *vdev)
> @@ -2982,8 +2956,9 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>          vdev->intx.mmap_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
>                                                    vfio_intx_mmap_enable, vdev);
>          pci_device_set_intx_routing_notifier(&vdev->pdev, vfio_intx_update);
> -        ret = vfio_intx_enable(vdev, errp);
> -        if (ret) {
> +        vfio_intx_enable(vdev, &err);
> +        if (err) {
> +            error_propagate(errp, err);

Wouldn't it still be easier to return -1/0 rather than test err?  I'm
not sure what was gained with the conversion to void.  Thanks,

Alex

>              goto out_teardown;
>          }
>      }
