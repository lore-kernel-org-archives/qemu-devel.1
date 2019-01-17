Received: from eggs.gnu.org ([209.51.188.92]:50806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gjydr-00033U-Uw
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 22:46:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gjydq-0004nh-OP
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 22:46:55 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:35144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1gjydq-0004kh-GM
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 22:46:54 -0500
Received: by mail-pl1-x643.google.com with SMTP id p8so4066936plo.2
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 19:46:54 -0800 (PST)
References: <20190111165801.15181-1-eric.auger@redhat.com>
	<20190111165801.15181-3-eric.auger@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <176aa476-e788-7f53-3c11-6ee186643de6@ozlabs.ru>
Date: Thu, 17 Jan 2019 14:46:48 +1100
MIME-Version: 1.0
In-Reply-To: <20190111165801.15181-3-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] vfio-pci: Use
 vfio_register_event_notifier in vfio_intx_enable_kvm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, qemu-devel@nongnu.org, alex.williamson@redhat.com



On 12/01/2019 03:58, Eric Auger wrote:
> We can also use vfio_register_event_notifier() helper in
> vfio_intx_enable_kvm to set the signalling associated to
> VFIO_PCI_INTX_IRQ_INDEX.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/vfio/pci.c | 38 +++++++-------------------------------
>  1 file changed, 7 insertions(+), 31 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index c589a4e666..db0504ca10 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -136,6 +136,9 @@ static int vfio_register_event_notifier(VFIOPCIDevice *vdev,
>      case VFIO_PCI_ERR_IRQ_INDEX:
>          notifier = &vdev->err_notifier;
>          break;
> +    case VFIO_PCI_INTX_IRQ_INDEX:
> +        notifier = &vdev->intx.interrupt;
> +        break;
>      default:
>          return -EINVAL;
>      }
> @@ -351,10 +354,8 @@ static void vfio_intx_update(PCIDevice *pdev)
>  static int vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>  {
>      uint8_t pin = vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN, 1);
> -    int ret, argsz, retval = 0;
> -    struct vfio_irq_set *irq_set;
> -    int32_t *pfd;
>      Error *err = NULL;
> +    int ret;
>  
>      if (!pin) {
>          return 0;
> @@ -376,34 +377,12 @@ static int vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>      }
>  #endif
>  
> -    ret = event_notifier_init(&vdev->intx.interrupt, 0);
> +    ret = vfio_register_event_notifier(vdev, VFIO_PCI_INTX_IRQ_INDEX, true,
> +                                       vfio_intx_interrupt, errp);
>      if (ret) {
> -        error_setg_errno(errp, -ret, "event_notifier_init failed");
>          return ret;
>      }
>  
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


After this change if ioctl(VFIO_DEVICE_SET_IRQS) failed, there will be
no event_notifier_cleanup() called as this new
vfio_register_event_notifier() does not do this either.


> -        retval = -errno;
> -        goto cleanup;
> -    }
> -
>      vfio_intx_enable_kvm(vdev, &err);
>      if (err) {
>          warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
> @@ -413,10 +392,7 @@ static int vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>  
>      trace_vfio_intx_enable(vdev->vbasedev.name);
>  
> -cleanup:
> -    g_free(irq_set);
> -
> -    return retval;
> +    return 0;
>  }
>  
>  static void vfio_intx_disable(VFIOPCIDevice *vdev)
> 

-- 
Alexey
