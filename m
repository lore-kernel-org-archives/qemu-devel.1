Received: from eggs.gnu.org ([2001:4830:134:3::10]:43086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1ff0zQ-00086x-6E
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 06:44:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1ff0zP-0007sw-8p
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 06:44:24 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:35083)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1ff0zP-0007sX-0W
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 06:44:23 -0400
Received: by mail-wm0-x231.google.com with SMTP id y22-v6so831198wma.0
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 03:44:22 -0700 (PDT)
References: <20180716074038.3364-1-yuval.shaia@oracle.com>
	<20180716074038.3364-7-yuval.shaia@oracle.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <b97d7262-0167-3088-932e-0da5d52c9089@gmail.com>
Date: Mon, 16 Jul 2018 13:44:19 +0300
MIME-Version: 1.0
In-Reply-To: <20180716074038.3364-7-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 06/13] hw/rdma: Get rid of unneeded
 structure
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
> This structure make no sense - removing it.
    ^^^^ ^^^^ What structure? I would explicitly name it in both subject 
and message.

Thanks,
Marcel

>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>   hw/rdma/rdma_backend.c |  3 +--
>   hw/rdma/rdma_rm.c      | 16 ++++++++--------
>   hw/rdma/rdma_rm_defs.h | 10 +++-------
>   3 files changed, 12 insertions(+), 17 deletions(-)
>
> diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
> index 647e16399f..52981d652d 100644
> --- a/hw/rdma/rdma_backend.c
> +++ b/hw/rdma/rdma_backend.c
> @@ -271,8 +271,7 @@ static int build_host_sge_array(RdmaDeviceResources *rdma_dev_res,
>               return VENDOR_ERR_INVLKEY | ssge[ssge_idx].lkey;
>           }
>   
> -        dsge->addr = (uintptr_t)mr->user_mr.host_virt + ssge[ssge_idx].addr -
> -                     mr->user_mr.guest_start;
> +        dsge->addr = (uintptr_t)mr->virt + ssge[ssge_idx].addr - mr->start;
>           dsge->length = ssge[ssge_idx].length;
>           dsge->lkey = rdma_backend_mr_lkey(&mr->backend_mr);
>   
> diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
> index 415da15efe..7403d24674 100644
> --- a/hw/rdma/rdma_rm.c
> +++ b/hw/rdma/rdma_rm.c
> @@ -165,15 +165,15 @@ int rdma_rm_alloc_mr(RdmaDeviceResources *dev_res, uint32_t pd_handle,
>           length = TARGET_PAGE_SIZE;
>           addr = g_malloc(length);
>       } else {
> -        mr->user_mr.host_virt = host_virt;
> -        pr_dbg("host_virt=0x%p\n", mr->user_mr.host_virt);
> -        mr->user_mr.length = guest_length;
> +        mr->virt = host_virt;
> +        pr_dbg("host_virt=0x%p\n", mr->virt);
> +        mr->length = guest_length;
>           pr_dbg("length=%zu\n", guest_length);
> -        mr->user_mr.guest_start = guest_start;
> -        pr_dbg("guest_start=0x%" PRIx64 "\n", mr->user_mr.guest_start);
> +        mr->start = guest_start;
> +        pr_dbg("guest_start=0x%" PRIx64 "\n", mr->start);
>   
> -        length = mr->user_mr.length;
> -        addr = mr->user_mr.host_virt;
> +        length = mr->length;
> +        addr = mr->virt;
>       }
>   
>       ret = rdma_backend_create_mr(&mr->backend_mr, &pd->backend_pd, addr, length,
> @@ -214,7 +214,7 @@ void rdma_rm_dealloc_mr(RdmaDeviceResources *dev_res, uint32_t mr_handle)
>   
>       if (mr) {
>           rdma_backend_destroy_mr(&mr->backend_mr);
> -        munmap(mr->user_mr.host_virt, mr->user_mr.length);
> +        munmap(mr->virt, mr->length);
>           res_tbl_dealloc(&dev_res->mr_tbl, mr_handle);
>       }
>   }
> diff --git a/hw/rdma/rdma_rm_defs.h b/hw/rdma/rdma_rm_defs.h
> index 226011176d..7228151239 100644
> --- a/hw/rdma/rdma_rm_defs.h
> +++ b/hw/rdma/rdma_rm_defs.h
> @@ -55,16 +55,12 @@ typedef struct RdmaRmCQ {
>       bool notify;
>   } RdmaRmCQ;
>   
> -typedef struct RdmaRmUserMR {
> -    void *host_virt;
> -    uint64_t guest_start;
> -    size_t length;
> -} RdmaRmUserMR;
> -
>   /* MR (DMA region) */
>   typedef struct RdmaRmMR {
>       RdmaBackendMR backend_mr;
> -    RdmaRmUserMR user_mr;
> +    void *virt;
> +    uint64_t start;
> +    size_t length;
>       uint32_t pd_handle;
>       uint32_t lkey;
>       uint32_t rkey;
