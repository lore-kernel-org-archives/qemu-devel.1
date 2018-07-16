Received: from eggs.gnu.org ([2001:4830:134:3::10]:41609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1ff0tn-0005ry-1p
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 06:38:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1ff0tj-0004L2-4s
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 06:38:35 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1ff0ti-0004Kj-Tl
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 06:38:31 -0400
Received: by mail-wr1-x441.google.com with SMTP id h10-v6so31360568wre.6
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 03:38:30 -0700 (PDT)
References: <20180716074038.3364-1-yuval.shaia@oracle.com>
	<20180716074038.3364-3-yuval.shaia@oracle.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <69f199bc-fd5f-fe4d-ca1e-ddc00b62b9ab@gmail.com>
Date: Mon, 16 Jul 2018 13:38:27 +0300
MIME-Version: 1.0
In-Reply-To: <20180716074038.3364-3-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 02/13] hw/pvrdma: Bugfix - provide the
 correct attr_mask to query_qp
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
> index 14255d609f..e7d6589cdc 100644
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
