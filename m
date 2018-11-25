Received: from eggs.gnu.org ([2001:4830:134:3::10]:45062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gQot8-00088C-1C
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 02:31:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gQot7-0000aR-2D
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 02:31:30 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41793)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gQot6-0000Zr-S0
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 02:31:29 -0500
Received: by mail-wr1-x441.google.com with SMTP id x10so15783970wrs.8
	for <qemu-devel@nongnu.org>; Sat, 24 Nov 2018 23:31:28 -0800 (PST)
References: <20181122121402.13764-1-yuval.shaia@oracle.com>
	<20181122121402.13764-14-yuval.shaia@oracle.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <3ad49700-8b47-2f06-b9da-bebe4ee310d7@gmail.com>
Date: Sun, 25 Nov 2018 09:31:23 +0200
MIME-Version: 1.0
In-Reply-To: <20181122121402.13764-14-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v5 13/24] hw/pvrdma: Make sure PCI function
 0 is vmxnet3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com, cohuck@redhat.com



On 11/22/18 2:13 PM, Yuval Shaia wrote:
> Guest driver enforces it, we should also.
>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>   hw/rdma/vmw/pvrdma.h      |  2 ++
>   hw/rdma/vmw/pvrdma_main.c | 12 ++++++++++++
>   2 files changed, 14 insertions(+)
>
> diff --git a/hw/rdma/vmw/pvrdma.h b/hw/rdma/vmw/pvrdma.h
> index b019cb843a..10a3c4fb7c 100644
> --- a/hw/rdma/vmw/pvrdma.h
> +++ b/hw/rdma/vmw/pvrdma.h
> @@ -20,6 +20,7 @@
>   #include "hw/pci/pci.h"
>   #include "hw/pci/msix.h"
>   #include "chardev/char-fe.h"
> +#include "hw/net/vmxnet3_defs.h"
>   
>   #include "../rdma_backend_defs.h"
>   #include "../rdma_rm_defs.h"
> @@ -85,6 +86,7 @@ typedef struct PVRDMADev {
>       RdmaBackendDev backend_dev;
>       RdmaDeviceResources rdma_dev_res;
>       CharBackend mad_chr;
> +    VMXNET3State *func0;
>   } PVRDMADev;
>   #define PVRDMA_DEV(dev) OBJECT_CHECK(PVRDMADev, (dev), PVRDMA_HW_NAME)
>   
> diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
> index ac8c092db0..b35b5dc5f0 100644
> --- a/hw/rdma/vmw/pvrdma_main.c
> +++ b/hw/rdma/vmw/pvrdma_main.c
> @@ -565,6 +565,7 @@ static void pvrdma_realize(PCIDevice *pdev, Error **errp)
>       PVRDMADev *dev = PVRDMA_DEV(pdev);
>       Object *memdev_root;
>       bool ram_shared = false;
> +    PCIDevice *func0;
>   
>       init_pr_dbg();
>   
> @@ -576,6 +577,17 @@ static void pvrdma_realize(PCIDevice *pdev, Error **errp)
>           return;
>       }
>   
> +    func0 = pci_get_function_0(pdev);
> +    /* Break if not vmxnet3 device in slot 0 */
> +    if (strcmp(object_get_typename(&func0->qdev.parent_obj), TYPE_VMXNET3)) {
> +        pr_dbg("func0 type is %s\n",
> +               object_get_typename(&func0->qdev.parent_obj));
> +        error_setg(errp, "Device on %x.0 must be %s", PCI_SLOT(pdev->devfn),
> +                   TYPE_VMXNET3);
> +        return;
> +    }
> +    dev->func0 = VMXNET3(func0);
> +
>       memdev_root = object_resolve_path("/objects", NULL);
>       if (memdev_root) {
>           object_child_foreach(memdev_root, pvrdma_check_ram_shared, &ram_shared);

Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Thanks,
Marcel
