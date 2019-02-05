Received: from eggs.gnu.org ([209.51.188.92]:46195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gr76P-00078f-1e
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 15:13:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gr76N-0001HZ-MF
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 15:13:52 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37810)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gr76L-0001EU-L0
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 15:13:50 -0500
Received: by mail-wr1-x443.google.com with SMTP id s12so5113486wrt.4
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 12:13:47 -0800 (PST)
References: <20190131130850.6850-1-yuval.shaia@oracle.com>
	<20190131130850.6850-5-yuval.shaia@oracle.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <82002ec0-70ce-08c8-c8a5-48251008d94e@gmail.com>
Date: Tue, 5 Feb 2019 22:14:09 +0200
MIME-Version: 1.0
In-Reply-To: <20190131130850.6850-5-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 04/10] hw/rdma: Protect against concurrent
 execution of poll_cq
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
> The function rdma_poll_cq is called from two contexts - completion
> handler thread which sense new completion on backend channel and
> explicitly as result of guest issuing poll_cq command.
>
> Add lock to protect against concurrent executions.
>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>   hw/rdma/rdma_backend.c | 2 ++
>   hw/rdma/rdma_rm.c      | 4 ++++
>   hw/rdma/rdma_rm_defs.h | 1 +
>   3 files changed, 7 insertions(+)
>
> diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
> index b7d6afb5da..bf8e889144 100644
> --- a/hw/rdma/rdma_backend.c
> +++ b/hw/rdma/rdma_backend.c
> @@ -70,6 +70,7 @@ static int rdma_poll_cq(RdmaDeviceResources *rdma_dev_res, struct ibv_cq *ibcq)
>       BackendCtx *bctx;
>       struct ibv_wc wc[2];
>   
> +    qemu_mutex_lock(&rdma_dev_res->lock);
>       do {
>           ne = ibv_poll_cq(ibcq, ARRAY_SIZE(wc), wc);
>   
> @@ -90,6 +91,7 @@ static int rdma_poll_cq(RdmaDeviceResources *rdma_dev_res, struct ibv_cq *ibcq)
>               g_free(bctx);
>           }
>       } while (ne > 0);
> +    qemu_mutex_unlock(&rdma_dev_res->lock);
>   
>       if (ne < 0) {
>           rdma_error_report("ibv_poll_cq fail, rc=%d, errno=%d", ne, errno);
> diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
> index 1ba77ac42c..9408bfb751 100644
> --- a/hw/rdma/rdma_rm.c
> +++ b/hw/rdma/rdma_rm.c
> @@ -619,12 +619,16 @@ int rdma_rm_init(RdmaDeviceResources *dev_res, struct ibv_device_attr *dev_attr,
>   
>       init_ports(dev_res);
>   
> +    qemu_mutex_init(&dev_res->lock);
> +
>       return 0;
>   }
>   
>   void rdma_rm_fini(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
>                     const char *ifname)
>   {
> +    qemu_mutex_destroy(&dev_res->lock);
> +
>       fini_ports(dev_res, backend_dev, ifname);
>   
>       res_tbl_free(&dev_res->uc_tbl);
> diff --git a/hw/rdma/rdma_rm_defs.h b/hw/rdma/rdma_rm_defs.h
> index 08692e87d4..9e98565a28 100644
> --- a/hw/rdma/rdma_rm_defs.h
> +++ b/hw/rdma/rdma_rm_defs.h
> @@ -109,6 +109,7 @@ typedef struct RdmaDeviceResources {
>       RdmaRmResTbl cq_tbl;
>       RdmaRmResTbl cqe_ctx_tbl;
>       GHashTable *qp_hash; /* Keeps mapping between real and emulated */
> +    QemuMutex lock;
>   } RdmaDeviceResources;
>   
>   #endif

Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>

Thanks,
Marcel
