Received: from eggs.gnu.org ([2001:4830:134:3::10]:37945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fhwKi-0007S2-9i
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:22:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fhwKd-0008Qe-Da
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:22:28 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33981)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fhwKd-0008QL-54
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:22:23 -0400
Received: by mail-wr1-x441.google.com with SMTP id c13-v6so3956462wrt.1
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 05:22:23 -0700 (PDT)
References: <20180716074038.3364-1-yuval.shaia@oracle.com>
	<20180716074038.3364-13-yuval.shaia@oracle.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <7ec58359-daf7-0f5b-7cb8-0a4d7032fd29@gmail.com>
Date: Tue, 24 Jul 2018 15:22:19 +0300
MIME-Version: 1.0
In-Reply-To: <20180716074038.3364-13-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 12/13] hw/rdma: Bugfix: Support non-aligned
 buffers
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
> RDMA applications can provide non-aligned buffers to be registered. In
> such case the DMA address passed by driver is pointing to the beginning
> of the physical address of the mapped page so we can't distinguish
> between two addresses from the same page.
>
> Fix it by keeping the offset of the virtual address in mr->virt.
>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>   hw/rdma/rdma_rm.c        | 2 ++
>   hw/rdma/vmw/pvrdma_cmd.c | 1 +
>   2 files changed, 3 insertions(+)
>
> diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
> index 859c900003..8d59a42cd1 100644
> --- a/hw/rdma/rdma_rm.c
> +++ b/hw/rdma/rdma_rm.c
> @@ -166,6 +166,7 @@ int rdma_rm_alloc_mr(RdmaDeviceResources *dev_res, uint32_t pd_handle,
>           mr->virt = host_virt;
>           mr->start = guest_start;
>           mr->length = guest_length;
> +        mr->virt += (mr->start & (TARGET_PAGE_SIZE - 1));
>   
>           ret = rdma_backend_create_mr(&mr->backend_mr, &pd->backend_pd, mr->virt,
>                                        mr->length, access_flags);
> @@ -203,6 +204,7 @@ void rdma_rm_dealloc_mr(RdmaDeviceResources *dev_res, uint32_t mr_handle)
>           rdma_backend_destroy_mr(&mr->backend_mr);
>           pr_dbg("start=0x%" PRIx64 "\n", mr->start);
>           if (mr->start) {
> +            mr->virt -= (mr->start & (TARGET_PAGE_SIZE - 1));
>               munmap(mr->virt, mr->length);
>           }
>           res_tbl_dealloc(&dev_res->mr_tbl, mr_handle);
> diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
> index bb898265a3..4ff242e793 100644
> --- a/hw/rdma/vmw/pvrdma_cmd.c
> +++ b/hw/rdma/vmw/pvrdma_cmd.c
> @@ -59,6 +59,7 @@ static void *pvrdma_map_to_pdir(PCIDevice *pdev, uint64_t pdir_dma,
>       }
>   
>       host_virt = mremap(curr_page, 0, length, MREMAP_MAYMOVE);
> +    pr_dbg("mremap %p -> %p\n", curr_page, host_virt);
>       if (host_virt == MAP_FAILED) {
>           host_virt = NULL;
>           error_report("PVRDMA: Failed to remap memory for host_virt");

Nice catch!

Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>

Thanks,
Marcel
