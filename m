Received: from eggs.gnu.org ([209.51.188.92]:34854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1grKIN-0000P8-Qh
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 05:19:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1grKIM-0000ga-Uh
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 05:19:07 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42029)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1grKIM-0000ft-Nf
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 05:19:06 -0500
Received: by mail-wr1-x444.google.com with SMTP id q18so6849968wrx.9
	for <qemu-devel@nongnu.org>; Wed, 06 Feb 2019 02:19:06 -0800 (PST)
References: <20190131130850.6850-1-yuval.shaia@oracle.com>
	<20190131130850.6850-9-yuval.shaia@oracle.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <67b1643e-c48a-2d58-acdb-415558b9ccf7@gmail.com>
Date: Wed, 6 Feb 2019 12:19:31 +0200
MIME-Version: 1.0
In-Reply-To: <20190131130850.6850-9-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 08/10] hw/rdma: Free all MAD receive
 buffers when device is closed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>, dgilbert@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org



On 1/31/19 3:08 PM, Yuval Shaia wrote:
> When device is going down free all saved MAD buffers.
>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>   hw/rdma/rdma_backend.c | 32 ++++++++++++++++++++++++++++++++
>   hw/rdma/rdma_backend.h |  1 +
>   2 files changed, 33 insertions(+)
>
> diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
> index d43fb1e677..65b28aa5b2 100644
> --- a/hw/rdma/rdma_backend.c
> +++ b/hw/rdma/rdma_backend.c
> @@ -64,6 +64,32 @@ static inline void complete_work(enum ibv_wc_status status, uint32_t vendor_err,
>       comp_handler(ctx, &wc);
>   }
>   
> +static void free_cqe_ctx(gpointer data, gpointer user_data)
> +{
> +    BackendCtx *bctx;
> +    RdmaDeviceResources *rdma_dev_res = user_data;
> +    unsigned long cqe_ctx_id = GPOINTER_TO_INT(data);
> +
> +    bctx = rdma_rm_get_cqe_ctx(rdma_dev_res, cqe_ctx_id);
> +    if (bctx) {
> +        rdma_rm_dealloc_cqe_ctx(rdma_dev_res, cqe_ctx_id);
> +    }
> +    g_free(bctx);
> +}
> +
> +static void clean_recv_mads(RdmaBackendDev *backend_dev)
> +{
> +    unsigned long cqe_ctx_id;
> +
> +    do {
> +        cqe_ctx_id = rdma_locked_list_pop_int64(&backend_dev->recv_mads_list);
> +        if (cqe_ctx_id != -ENOENT) {
> +            free_cqe_ctx(GINT_TO_POINTER(cqe_ctx_id),
> +                         backend_dev->rdma_dev_res);
> +        }
> +    } while (cqe_ctx_id != -ENOENT);
> +}
> +
>   static int rdma_poll_cq(RdmaDeviceResources *rdma_dev_res, struct ibv_cq *ibcq)
>   {
>       int i, ne, total_ne = 0;
> @@ -1029,6 +1055,11 @@ static int mad_init(RdmaBackendDev *backend_dev, CharBackend *mad_chr_be)
>       return 0;
>   }
>   
> +static void mad_stop(RdmaBackendDev *backend_dev)
> +{
> +    clean_recv_mads(backend_dev);
> +}
> +
>   static void mad_fini(RdmaBackendDev *backend_dev)
>   {
>       disable_rdmacm_mux_async(backend_dev);
> @@ -1216,6 +1247,7 @@ void rdma_backend_start(RdmaBackendDev *backend_dev)
>   
>   void rdma_backend_stop(RdmaBackendDev *backend_dev)
>   {
> +    mad_stop(backend_dev);
>       stop_backend_thread(&backend_dev->comp_thread);
>   }
>   
> diff --git a/hw/rdma/rdma_backend.h b/hw/rdma/rdma_backend.h
> index 36305cd148..6abc367a52 100644
> --- a/hw/rdma/rdma_backend.h
> +++ b/hw/rdma/rdma_backend.h
> @@ -33,6 +33,7 @@
>   #define VENDOR_ERR_MR_SMALL         0x208
>   #define VENDOR_ERR_INV_MAD_BUFF     0x209
>   #define VENDOR_ERR_INV_GID_IDX      0x210
> +#define VENDOR_ERR_DEV_GOING_DOWN   0x211
>   
>   /* Add definition for QP0 and QP1 as there is no userspace enums for them */
>   enum ibv_special_qp_type {

Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Thanks,
Marcel
