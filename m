Received: from eggs.gnu.org ([2001:4830:134:3::10]:47149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gQp62-0006fb-G8
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 02:44:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gQp5z-00036k-CN
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 02:44:50 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38203)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gQp5z-00033u-6I
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 02:44:47 -0500
Received: by mail-wm1-x342.google.com with SMTP id k198so15319512wmd.3
	for <qemu-devel@nongnu.org>; Sat, 24 Nov 2018 23:44:47 -0800 (PST)
References: <20181122121402.13764-1-yuval.shaia@oracle.com>
	<20181122121402.13764-24-yuval.shaia@oracle.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <389cebdf-2caa-c428-83ce-47780ae2a7df@gmail.com>
Date: Sun, 25 Nov 2018 09:41:17 +0200
MIME-Version: 1.0
In-Reply-To: <20181122121402.13764-24-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v5 23/24] hw/pvrdma: Do not clean resources
 on shutdown
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com, cohuck@redhat.com



On 11/22/18 2:14 PM, Yuval Shaia wrote:
> All resources are already cleaned at rm_fini phase.
>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>   hw/rdma/rdma_backend.c | 21 +--------------------
>   1 file changed, 1 insertion(+), 20 deletions(-)
>
> diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
> index 6a1e39d4c0..8ab25e94b1 100644
> --- a/hw/rdma/rdma_backend.c
> +++ b/hw/rdma/rdma_backend.c
> @@ -1075,28 +1075,9 @@ static int mad_init(RdmaBackendDev *backend_dev, CharBackend *mad_chr_be)
>   
>   static void mad_stop(RdmaBackendDev *backend_dev)
>   {
> -    QObject *o_ctx_id;
> -    unsigned long cqe_ctx_id;
> -    BackendCtx *bctx;
> -
> -    pr_dbg("Closing MAD\n");
> +    pr_dbg("Stopping MAD\n");
>   
>       disable_rdmacm_mux_async(backend_dev);
> -
> -    /* Clear MAD buffers list */
> -    qemu_mutex_lock(&backend_dev->recv_mads_list.lock);
> -    do {
> -        o_ctx_id = qlist_pop(backend_dev->recv_mads_list.list);
> -        if (o_ctx_id) {
> -            cqe_ctx_id = qnum_get_uint(qobject_to(QNum, o_ctx_id));
> -            bctx = rdma_rm_get_cqe_ctx(backend_dev->rdma_dev_res, cqe_ctx_id);
> -            if (bctx) {
> -                rdma_rm_dealloc_cqe_ctx(backend_dev->rdma_dev_res, cqe_ctx_id);
> -                g_free(bctx);
> -            }
> -        }
> -    } while (o_ctx_id);
> -    qemu_mutex_unlock(&backend_dev->recv_mads_list.lock);
>   }
>   
>   static void mad_fini(RdmaBackendDev *backend_dev)
>

Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Thanks,
Marcel
