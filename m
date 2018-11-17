Received: from eggs.gnu.org ([2001:4830:134:3::10]:34564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gNzeg-0004xT-Up
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 07:24:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gNzeg-0006Fw-5l
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 07:24:54 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38233)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gNzef-0006Cv-VS
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 07:24:54 -0500
Received: by mail-wr1-x442.google.com with SMTP id e3-v6so27478034wrs.5
	for <qemu-devel@nongnu.org>; Sat, 17 Nov 2018 04:24:53 -0800 (PST)
References: <20181113071336.6242-1-yuval.shaia@oracle.com>
	<20181113071336.6242-21-yuval.shaia@oracle.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <d5359d57-46af-31d4-a6ae-8b692962f93f@gmail.com>
Date: Sat, 17 Nov 2018 14:24:50 +0200
MIME-Version: 1.0
In-Reply-To: <20181113071336.6242-21-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v3 20/23] hw/pvrdma: Clean device's
 resource when system is shutdown
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com, cohuck@redhat.com



On 11/13/18 9:13 AM, Yuval Shaia wrote:
> In order to clean some external resources such as GIDs, QPs etc,
> register to receive notification when VM is shutdown.
>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>   hw/rdma/vmw/pvrdma.h      |  2 ++
>   hw/rdma/vmw/pvrdma_main.c | 12 ++++++++++++
>   2 files changed, 14 insertions(+)
>
> diff --git a/hw/rdma/vmw/pvrdma.h b/hw/rdma/vmw/pvrdma.h
> index 10a3c4fb7c..ffae36986e 100644
> --- a/hw/rdma/vmw/pvrdma.h
> +++ b/hw/rdma/vmw/pvrdma.h
> @@ -17,6 +17,7 @@
>   #define PVRDMA_PVRDMA_H
>   
>   #include "qemu/units.h"
> +#include "qemu/notify.h"
>   #include "hw/pci/pci.h"
>   #include "hw/pci/msix.h"
>   #include "chardev/char-fe.h"
> @@ -87,6 +88,7 @@ typedef struct PVRDMADev {
>       RdmaDeviceResources rdma_dev_res;
>       CharBackend mad_chr;
>       VMXNET3State *func0;
> +    Notifier shutdown_notifier;
>   } PVRDMADev;
>   #define PVRDMA_DEV(dev) OBJECT_CHECK(PVRDMADev, (dev), PVRDMA_HW_NAME)
>   
> diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
> index 95e9322b7c..45a59cddf9 100644
> --- a/hw/rdma/vmw/pvrdma_main.c
> +++ b/hw/rdma/vmw/pvrdma_main.c
> @@ -24,6 +24,7 @@
>   #include "hw/qdev-properties.h"
>   #include "cpu.h"
>   #include "trace.h"
> +#include "sysemu/sysemu.h"
>   
>   #include "../rdma_rm.h"
>   #include "../rdma_backend.h"
> @@ -559,6 +560,14 @@ static int pvrdma_check_ram_shared(Object *obj, void *opaque)
>       return 0;
>   }
>   
> +static void pvrdma_shutdown_notifier(Notifier *n, void *opaque)
> +{
> +    PVRDMADev *dev = container_of(n, PVRDMADev, shutdown_notifier);
> +    PCIDevice *pci_dev = PCI_DEVICE(dev);
> +
> +    pvrdma_fini(pci_dev);
> +}
> +
>   static void pvrdma_realize(PCIDevice *pdev, Error **errp)
>   {
>       int rc;
> @@ -623,6 +632,9 @@ static void pvrdma_realize(PCIDevice *pdev, Error **errp)
>           goto out;
>       }
>   
> +    dev->shutdown_notifier.notify = pvrdma_shutdown_notifier;
> +    qemu_register_shutdown_notifier(&dev->shutdown_notifier);
> +
>   out:
>       if (rc) {
>           error_append_hint(errp, "Device fail to load\n");

Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>

Thanks,
Marcel
