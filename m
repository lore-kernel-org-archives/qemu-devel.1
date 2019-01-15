Received: from eggs.gnu.org ([209.51.188.92]:39018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gjNRh-0003rD-JG
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 07:03:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gjNRf-0001py-7k
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 07:03:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gjNRe-0001ku-LW
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 07:03:50 -0500
Date: Tue, 15 Jan 2019 13:03:33 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190115130333.1ef1d461.cohuck@redhat.com>
In-Reply-To: <20190111165801.15181-2-eric.auger@redhat.com>
References: <20190111165801.15181-1-eric.auger@redhat.com>
	<20190111165801.15181-2-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] vfio-pci: Introduce
 vfio_register_event_notifier helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, alex.williamson@redhat.com

On Fri, 11 Jan 2019 17:58:00 +0100
Eric Auger <eric.auger@redhat.com> wrote:

> The code used to attach the eventfd handler for the ERR and
> REQ irq indices can be factorized into a helper. In subsequent
> patches we will extend this helper to support other irq indices.

Looks like a nice refactoring to me.

> 
> We test the notification is allowed outside of the helper:

s/We test/We test whether/

> respectively check vdev->pci_aer and VFIO_FEATURE_ENABLE_REQ.
> Depending on the returned value we set vdev->pci_aer and
> vdev->req_enabled. An error handle is introduced for future usage
> although not strictly useful here.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/vfio/pci.c | 291 ++++++++++++++++++++++----------------------------
>  1 file changed, 127 insertions(+), 164 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index c0cb1ec289..c589a4e666 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -105,6 +105,95 @@ static void vfio_intx_eoi(VFIODevice *vbasedev)
>      vfio_unmask_single_irqindex(vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
>  }
>  
> +/*
> + * vfio_register_event_notifier - setup/tear down eventfd
> + * notification and handling for IRQ indices that span over
> + * a single IRQ
> + *
> + * @vdev: VFIO device handle
> + * @index: IRQ index the eventfd/handler is associated to

s/to/with/ ?

> + * @target_state: true means notifier needs to be set up
> + * @handler to attach if @target_state is true
> + * @errp error handle
> + */
> +static int vfio_register_event_notifier(VFIOPCIDevice *vdev,
> +                                        int index,
> +                                        bool target_state,
> +                                        void (*handler)(void *opaque),
> +                                        Error **errp)

(...)

> @@ -3069,8 +2998,29 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>          goto out_teardown;
>      }
>  
> -    vfio_register_err_notifier(vdev);
> -    vfio_register_req_notifier(vdev);
> +    if (vdev->pci_aer) {
> +        /*
> +         * Registers error notifier for devices supporting error recovery.
> +         * If we encounter a failure in this function, we report an error

s/in this function/while registering it/ ?

> +         * and continue after disabling error recovery support for the
> +         * device.
> +         */
> +        vdev->pci_aer =
> +            !vfio_register_event_notifier(vdev, VFIO_PCI_ERR_IRQ_INDEX, true,
> +                                          vfio_err_notifier_handler, &err);
> +        if (err) {
> +            warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
> +        }

I think you need to reset err to NULL if you want to reuse the variable.

Alternatively, you could keep the wrappers and define a local error
variable there.

> +    }
> +
> +    if (vdev->features & VFIO_FEATURE_ENABLE_REQ) {
> +        vdev->req_enabled =
> +            !vfio_register_event_notifier(vdev, VFIO_PCI_REQ_IRQ_INDEX, true,
> +                                          vfio_req_notifier_handler, &err);
> +        if (err) {
> +            warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
> +        }
> +    }
>      vfio_setup_resetfn_quirk(vdev);
>  
>      return;
> @@ -3106,9 +3056,22 @@ static void vfio_instance_finalize(Object *obj)
>  static void vfio_exitfn(PCIDevice *pdev)
>  {
>      VFIOPCIDevice *vdev = PCI_VFIO(pdev);
> +    Error *err = NULL;
>  
> -    vfio_unregister_req_notifier(vdev);
> -    vfio_unregister_err_notifier(vdev);
> +    if (vdev->req_enabled) {
> +        vfio_register_event_notifier(vdev, VFIO_PCI_REQ_IRQ_INDEX,
> +                                     false, NULL, &err);
> +        if (err) {
> +            warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
> +        }

Likewise.

> +    }
> +    if (vdev->pci_aer) {
> +        vfio_register_event_notifier(vdev, VFIO_PCI_ERR_IRQ_INDEX,
> +                                     false, NULL, &err);
> +        if (err) {
> +            warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
> +        }
> +    }
>      pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
>      vfio_disable_interrupts(vdev);
>      if (vdev->intx.mmap_timer) {
