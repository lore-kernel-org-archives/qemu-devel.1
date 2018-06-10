Received: from eggs.gnu.org ([2001:4830:134:3::10]:48607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fRzP3-000153-Lc
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 08:25:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fRzP0-00074V-Ih
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 08:25:01 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:55949)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fRzP0-00074B-AS
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 08:24:58 -0400
Received: by mail-wm0-x243.google.com with SMTP id v16-v6so10130704wmh.5
	for <qemu-devel@nongnu.org>; Sun, 10 Jun 2018 05:24:58 -0700 (PDT)
References: <20180608143752.22718-1-yuval.shaia@oracle.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <448a9455-631a-1d5a-2452-b9c262d3262c@gmail.com>
Date: Sun, 10 Jun 2018 15:24:54 +0300
MIME-Version: 1.0
In-Reply-To: <20180608143752.22718-1-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] hw/pvrdma: Bugfix - provide the correct
 attr_mask to query_qp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>, qemu-devel@nongnu.org



On 06/08/2018 05:37 PM, Yuval Shaia wrote:
> Calling rdma_rm_query_qp with attr_mask equals to -1 leads to error
> where backend query_qp fails to retrieve the needed QP attributes.
> Fix it by providing the attr_mask we got from driver.
>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>   hw/rdma/vmw/pvrdma_cmd.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
> index 9d9dfc6b81..76df60a540 100644
> --- a/hw/rdma/vmw/pvrdma_cmd.c
> +++ b/hw/rdma/vmw/pvrdma_cmd.c
> @@ -524,6 +524,7 @@ static int query_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
>       struct ibv_qp_init_attr init_attr;
>   
>       pr_dbg("qp_handle=%d\n", cmd->qp_handle);
> +    pr_dbg("attr_mask=0x%x\n", cmd->attr_mask);
>   
>       memset(rsp, 0, sizeof(*rsp));
>       rsp->hdr.response = cmd->hdr.response;
> @@ -531,8 +532,8 @@ static int query_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
>   
>       rsp->hdr.err = rdma_rm_query_qp(&dev->rdma_dev_res, &dev->backend_dev,
>                                       cmd->qp_handle,
> -                                    (struct ibv_qp_attr *)&resp->attrs, -1,
> -                                    &init_attr);
> +                                    (struct ibv_qp_attr *)&resp->attrs,
> +                                    cmd->attr_mask, &init_attr);
>   
>       pr_dbg("ret=%d\n", rsp->hdr.err);
>       return rsp->hdr.err;


Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>

Thanks,
Marcel
