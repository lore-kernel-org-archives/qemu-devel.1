Received: from eggs.gnu.org ([2001:4830:134:3::10]:54997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1fqE5L-0000Xl-LI
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:56:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1fqE5E-0000Cq-Cf
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:56:50 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56324)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1fqE5E-00009l-4B
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:56:44 -0400
Date: Thu, 16 Aug 2018 11:56:32 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20180816085631.GA4318@lap1>
References: <20180814100010.2546-1-yuval.shaia@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180814100010.2546-1-yuval.shaia@oracle.com>
Subject: Re: [Qemu-devel] [PATCH] hw/rdma: Abort send-op if fail to create
 addr handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, marcel.apfelbaum@gmail.com

On Tue, Aug 14, 2018 at 01:00:10PM +0300, Yuval Shaia wrote:
> Function create_ah might return NULL, let's exit with an error.
> 
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>  hw/rdma/rdma_backend.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
> index 35726bda2e..59d02eb567 100644
> --- a/hw/rdma/rdma_backend.c
> +++ b/hw/rdma/rdma_backend.c
> @@ -402,6 +402,10 @@ void rdma_backend_post_send(RdmaBackendDev *backend_dev,
>      if (qp_type == IBV_QPT_UD) {
>          wr.wr.ud.ah = create_ah(backend_dev, qp->ibpd,
>                                  backend_dev->backend_gid_idx, dgid);
> +        if (!wr.wr.ud.ah) {
> +            comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_FAIL_BACKEND, ctx, 0);

This change is based on a patch i sent at Aug 5, "Misc fixes for pvrdma
device", without it build fails.

I will re-post this patch as soon as the patch-set will be pulled.

> +            goto out_dealloc_cqe_ctx;
> +        }
>          wr.wr.ud.remote_qpn = dqpn;
>          wr.wr.ud.remote_qkey = dqkey;
>      }
> -- 
> 2.17.1
> 
