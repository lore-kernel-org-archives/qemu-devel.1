Received: from eggs.gnu.org ([2001:4830:134:3::10]:44197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1ff14K-0003Kp-Ag
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 06:49:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1ff14H-0001qs-6q
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 06:49:28 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:56276)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1ff14G-0001oL-Uw
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 06:49:25 -0400
Received: by mail-wm0-x244.google.com with SMTP id f21-v6so2512562wmc.5
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 03:49:24 -0700 (PDT)
References: <20180716074038.3364-1-yuval.shaia@oracle.com>
	<20180716074038.3364-14-yuval.shaia@oracle.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <fb4eb0e9-c896-41fc-0b3c-a2d7fcba4273@gmail.com>
Date: Mon, 16 Jul 2018 13:49:21 +0300
MIME-Version: 1.0
In-Reply-To: <20180716074038.3364-14-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 13/13] hw/rdma: Save pci dev in backend_dev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>, qemu-devel@nongnu.org



On 07/16/2018 10:40 AM, Yuval Shaia wrote:
> This field is not initialized - fix it.

^^^^^^^^ What field ? Please use a more readable message.

Regarding the subject, maybe you can use "cache pci_dev"
or "add a reference to pci_dev " instead of "save".

Thanks,
Marcel

>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>   hw/rdma/rdma_backend.c    | 6 +++++-
>   hw/rdma/rdma_backend.h    | 2 +-
>   hw/rdma/vmw/pvrdma_main.c | 2 +-
>   3 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
> index d29acc505b..d7a4bbd91f 100644
> --- a/hw/rdma/rdma_backend.c
> +++ b/hw/rdma/rdma_backend.c
> @@ -744,7 +744,7 @@ static int init_device_caps(RdmaBackendDev *backend_dev,
>       return 0;
>   }
>   
> -int rdma_backend_init(RdmaBackendDev *backend_dev,
> +int rdma_backend_init(RdmaBackendDev *backend_dev, PCIDevice *pdev,
>                         RdmaDeviceResources *rdma_dev_res,
>                         const char *backend_device_name, uint8_t port_num,
>                         uint8_t backend_gid_idx, struct ibv_device_attr *dev_attr,
> @@ -756,6 +756,10 @@ int rdma_backend_init(RdmaBackendDev *backend_dev,
>       struct ibv_device **dev_list;
>       struct ibv_port_attr port_attr;
>   
> +    memset(backend_dev, 0, sizeof(*backend_dev));
> +
> +    backend_dev->dev = pdev;
> +
>       backend_dev->backend_gid_idx = backend_gid_idx;
>       backend_dev->port_num = port_num;
>       backend_dev->rdma_dev_res = rdma_dev_res;
> diff --git a/hw/rdma/rdma_backend.h b/hw/rdma/rdma_backend.h
> index 3049a73962..86e8fe8ab6 100644
> --- a/hw/rdma/rdma_backend.h
> +++ b/hw/rdma/rdma_backend.h
> @@ -46,7 +46,7 @@ static inline uint32_t rdma_backend_mr_rkey(const RdmaBackendMR *mr)
>       return mr->ibmr ? mr->ibmr->rkey : 0;
>   }
>   
> -int rdma_backend_init(RdmaBackendDev *backend_dev,
> +int rdma_backend_init(RdmaBackendDev *backend_dev, PCIDevice *pdev,
>                         RdmaDeviceResources *rdma_dev_res,
>                         const char *backend_device_name, uint8_t port_num,
>                         uint8_t backend_gid_idx, struct ibv_device_attr *dev_attr,
> diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
> index 3d448bffc4..ca5fa8d981 100644
> --- a/hw/rdma/vmw/pvrdma_main.c
> +++ b/hw/rdma/vmw/pvrdma_main.c
> @@ -611,7 +611,7 @@ static void pvrdma_realize(PCIDevice *pdev, Error **errp)
>           goto out;
>       }
>   
> -    rc = rdma_backend_init(&dev->backend_dev, &dev->rdma_dev_res,
> +    rc = rdma_backend_init(&dev->backend_dev, pdev, &dev->rdma_dev_res,
>                              dev->backend_device_name, dev->backend_port_num,
>                              dev->backend_gid_idx, &dev->dev_attr, errp);
>       if (rc) {
