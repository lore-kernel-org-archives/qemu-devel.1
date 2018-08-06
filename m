Received: from eggs.gnu.org ([2001:4830:134:3::10]:56675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fmduU-000303-Se
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 07:42:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fmduR-0001tr-Jr
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 07:42:50 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:33930)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fmduR-0001tS-AT
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 07:42:47 -0400
Received: by mail-wr1-x436.google.com with SMTP id c13-v6so12068618wrt.1
	for <qemu-devel@nongnu.org>; Mon, 06 Aug 2018 04:42:47 -0700 (PDT)
References: <20180805153518.2983-1-yuval.shaia@oracle.com>
	<20180805153518.2983-8-yuval.shaia@oracle.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <b0a16458-6f4c-8e5a-4839-207784e4f513@gmail.com>
Date: Mon, 6 Aug 2018 14:42:43 +0300
MIME-Version: 1.0
In-Reply-To: <20180805153518.2983-8-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 07/13] hw/rdma: Do not allocate memory
 for non-dma MR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>, qemu-devel@nongnu.org



On 08/05/2018 06:35 PM, Yuval Shaia wrote:
> There is no use in the memory allocated for non-dma MR.
> Delete the code that allocates it.
>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>   hw/rdma/rdma_rm.c | 52 +++++++++++++++++++----------------------------
>   1 file changed, 21 insertions(+), 31 deletions(-)
>
> diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
> index 7403d24674..bf4a5c71b4 100644
> --- a/hw/rdma/rdma_rm.c
> +++ b/hw/rdma/rdma_rm.c
> @@ -144,8 +144,6 @@ int rdma_rm_alloc_mr(RdmaDeviceResources *dev_res, uint32_t pd_handle,
>       RdmaRmMR *mr;
>       int ret = 0;
>       RdmaRmPD *pd;
> -    void *addr;
> -    size_t length;
>   
>       pd = rdma_rm_get_pd(dev_res, pd_handle);
>       if (!pd) {
> @@ -158,40 +156,29 @@ int rdma_rm_alloc_mr(RdmaDeviceResources *dev_res, uint32_t pd_handle,
>           pr_dbg("Failed to allocate obj in table\n");
>           return -ENOMEM;
>       }
> +    pr_dbg("mr_handle=%d\n", *mr_handle);
>   
> -    if (!host_virt) {
> -        /* TODO: This is my guess but not so sure that this needs to be
> -         * done */
> -        length = TARGET_PAGE_SIZE;
> -        addr = g_malloc(length);
> -    } else {
> +    pr_dbg("host_virt=0x%p\n", host_virt);
> +    pr_dbg("guest_start=0x%" PRIx64 "\n", guest_start);
> +    pr_dbg("length=%zu\n", guest_length);
> +
> +    if (host_virt) {
>           mr->virt = host_virt;
> -        pr_dbg("host_virt=0x%p\n", mr->virt);
> -        mr->length = guest_length;
> -        pr_dbg("length=%zu\n", guest_length);
>           mr->start = guest_start;
> -        pr_dbg("guest_start=0x%" PRIx64 "\n", mr->start);
> -
> -        length = mr->length;
> -        addr = mr->virt;
> -    }
> +        mr->length = guest_length;
>   
> -    ret = rdma_backend_create_mr(&mr->backend_mr, &pd->backend_pd, addr, length,
> -                                 access_flags);
> -    if (ret) {
> -        pr_dbg("Fail in rdma_backend_create_mr, err=%d\n", ret);
> -        ret = -EIO;
> -        goto out_dealloc_mr;
> +        ret = rdma_backend_create_mr(&mr->backend_mr, &pd->backend_pd, mr->virt,
> +                                     mr->length, access_flags);
> +        if (ret) {
> +            pr_dbg("Fail in rdma_backend_create_mr, err=%d\n", ret);
> +            ret = -EIO;
> +            goto out_dealloc_mr;
> +        }
>       }
>   
> -    if (!host_virt) {
> -        *lkey = mr->lkey = rdma_backend_mr_lkey(&mr->backend_mr);
> -        *rkey = mr->rkey = rdma_backend_mr_rkey(&mr->backend_mr);
> -    } else {
> -        /* We keep mr_handle in lkey so send and recv get get mr ptr */
> -        *lkey = *mr_handle;
> -        *rkey = -1;
> -    }
> +    /* We keep mr_handle in lkey so send and recv get get mr ptr */
> +    *lkey = *mr_handle;
> +    *rkey = -1;
>   
>       mr->pd_handle = pd_handle;
>   
> @@ -214,7 +201,10 @@ void rdma_rm_dealloc_mr(RdmaDeviceResources *dev_res, uint32_t mr_handle)
>   
>       if (mr) {
>           rdma_backend_destroy_mr(&mr->backend_mr);
> -        munmap(mr->virt, mr->length);
> +        pr_dbg("start=0x%" PRIx64 "\n", mr->start);
> +        if (mr->start) {
> +            munmap(mr->virt, mr->length);
> +        }
>           res_tbl_dealloc(&dev_res->mr_tbl, mr_handle);
>       }
>   }

Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>

Thanks,
Marcel
