Received: from eggs.gnu.org ([2001:4830:134:3::10]:44826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gWlCX-0006G6-Sy
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:48:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gWlCU-0000S0-8e
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:48:05 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:33224)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gWlCT-0000Ot-6V
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:48:01 -0500
Date: Tue, 11 Dec 2018 18:47:43 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20181211164742.GA2923@lap1>
References: <20181211132642.3027-1-ppandit@redhat.com>
	<20181211132642.3027-5-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211132642.3027-5-ppandit@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/5] pvrdma: release ring object in case of
 an error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Saar Amar <saaramar5@gmail.com>, Li Qiang <liq3ea@163.com>, Prasad J Pandit <pjp@fedoraproject.org>, yuval.shaia@oracle.com

On Tue, Dec 11, 2018 at 06:56:41PM +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> create_cq and create_qp routines allocate ring object, but it's
> not released in case of an error, leading to memory leakage.
> 
> Reported-by: Li Qiang <liq3ea@163.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/rdma/vmw/pvrdma_cmd.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
> index ee2888259c..e8d99f29fa 100644
> --- a/hw/rdma/vmw/pvrdma_cmd.c
> +++ b/hw/rdma/vmw/pvrdma_cmd.c
> @@ -337,7 +337,9 @@ static int create_cq(PVRDMADev *dev, union pvrdma_cmd_req *req,
>  
>      resp->hdr.err = rdma_rm_alloc_cq(&dev->rdma_dev_res, &dev->backend_dev,
>                                       cmd->cqe, &resp->cq_handle, ring);
> -    resp->cqe = cmd->cqe;
> +    if (resp->hdr.err) {
> +        g_free(ring);

This is not enough since all ring's resources (ring state and ring's pages)
left mapped.

The steps needed are the steps detailed in destroy_cq.

> +    }
>  
>  out:
>      pr_dbg("ret=%d\n", resp->hdr.err);
> @@ -490,6 +492,10 @@ static int create_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
>                                       cmd->max_send_sge, cmd->send_cq_handle,
>                                       cmd->max_recv_wr, cmd->max_recv_sge,
>                                       cmd->recv_cq_handle, rings, &resp->qpn);
> +    if (resp->hdr.err) {
> +        g_free(rings);

Ditto, here send rind and recv rings stays mapped.
Look at how QP's ring is destroyed in destroy_qp.

For both case suggesting to define a new static function that destroy rings
and call it from both error flow of create_* and from destroy_*

> +        goto out;
> +    }
>  
>      resp->max_send_wr = cmd->max_send_wr;
>      resp->max_recv_wr = cmd->max_recv_wr;
> -- 
> 2.19.2
> 
