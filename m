Received: from eggs.gnu.org ([2001:4830:134:3::10]:46463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gQp2P-0004Uf-2i
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 02:41:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gQp2L-0007dN-A9
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 02:41:05 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:52826)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gQp2J-0007aV-Fi
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 02:40:59 -0500
Date: Sun, 25 Nov 2018 09:30:30 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20181125073030.GB2770@lap1>
References: <20181122121402.13764-1-yuval.shaia@oracle.com>
	<20181122121402.13764-24-yuval.shaia@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122121402.13764-24-yuval.shaia@oracle.com>
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
To: marcel.apfelbaum@gmail.com, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com, cohuck@redhat.com, yuval.shaia@oracle.com

On Thu, Nov 22, 2018 at 02:14:01PM +0200, Yuval Shaia wrote:
> All resources are already cleaned at rm_fini phase.

Please ignore this patch, i will squash it to patch #5.

> 
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>  hw/rdma/rdma_backend.c | 21 +--------------------
>  1 file changed, 1 insertion(+), 20 deletions(-)
> 
> diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
> index 6a1e39d4c0..8ab25e94b1 100644
> --- a/hw/rdma/rdma_backend.c
> +++ b/hw/rdma/rdma_backend.c
> @@ -1075,28 +1075,9 @@ static int mad_init(RdmaBackendDev *backend_dev, CharBackend *mad_chr_be)
>  
>  static void mad_stop(RdmaBackendDev *backend_dev)
>  {
> -    QObject *o_ctx_id;
> -    unsigned long cqe_ctx_id;
> -    BackendCtx *bctx;
> -
> -    pr_dbg("Closing MAD\n");
> +    pr_dbg("Stopping MAD\n");
>  
>      disable_rdmacm_mux_async(backend_dev);
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
>  }
>  
>  static void mad_fini(RdmaBackendDev *backend_dev)
> -- 
> 2.17.2
> 
