Received: from eggs.gnu.org ([2001:4830:134:3::10]:54129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1da1uf-0003eW-W0
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:38:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1da1ub-0001kG-VV
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:38:22 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35648)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1da1ub-0001jU-Pb
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:38:17 -0400
Received: by mail-wm0-f53.google.com with SMTP id c184so55644773wmd.0
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 08:38:17 -0700 (PDT)
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-14-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ac0e97ce-c5bf-260a-aea7-1332bda33073@redhat.com>
Date: Tue, 25 Jul 2017 17:38:14 +0200
MIME-Version: 1.0
In-Reply-To: <20170724182751.18261-14-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 2.10 13/35] vfio/pci: fix use of freed
 memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 24/07/2017 20:27, Philippe Mathieu-Daudé wrote:
> hw/vfio/pci.c:308:29: warning: Use of memory after it is freed
>         qemu_set_fd_handler(*pfd, NULL, NULL, vdev);
>                             ^~~~
> 
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/vfio/pci.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index d4051cb951..31e1edf447 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -257,7 +257,7 @@ static void vfio_intx_update(PCIDevice *pdev)
>  static int vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>  {
>      uint8_t pin = vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN, 1);
> -    int ret, argsz;
> +    int ret, argsz, retval = 0;
>      struct vfio_irq_set *irq_set;
>      int32_t *pfd;
>      Error *err = NULL;
> @@ -302,12 +302,12 @@ static int vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>      qemu_set_fd_handler(*pfd, vfio_intx_interrupt, NULL, vdev);
>  
>      ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
> -    g_free(irq_set);
>      if (ret) {
>          error_setg_errno(errp, -ret, "failed to setup INTx fd");
>          qemu_set_fd_handler(*pfd, NULL, NULL, vdev);
>          event_notifier_cleanup(&vdev->intx.interrupt);
> -        return -errno;
> +        retval = -errno;
> +        goto cleanup;
>      }
>  
>      vfio_intx_enable_kvm(vdev, &err);
> @@ -319,7 +319,10 @@ static int vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>  
>      trace_vfio_intx_enable(vdev->vbasedev.name);
>  
> -    return 0;
> +cleanup:
> +    g_free(irq_set);
> +
> +    return retval;
>  }
>  
>  static void vfio_intx_disable(VFIOPCIDevice *vdev)
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
