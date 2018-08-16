Received: from eggs.gnu.org ([2001:4830:134:3::10]:55152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fqE68-0001EU-Kt
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:57:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fqE63-0000XP-64
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:57:40 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33008)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fqE62-0000Wd-Qp
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:57:35 -0400
Received: by mail-wm0-x242.google.com with SMTP id i134-v6so7705803wmf.0
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 01:57:33 -0700 (PDT)
References: <20180814100010.2546-1-yuval.shaia@oracle.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <614bc071-9141-208c-8390-a747ae83fc76@gmail.com>
Date: Thu, 16 Aug 2018 11:57:30 +0300
MIME-Version: 1.0
In-Reply-To: <20180814100010.2546-1-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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
To: Yuval Shaia <yuval.shaia@oracle.com>, qemu-devel@nongnu.org



On 08/14/2018 01:00 PM, Yuval Shaia wrote:
> Function create_ah might return NULL, let's exit with an error.
>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>   hw/rdma/rdma_backend.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
> index 35726bda2e..59d02eb567 100644
> --- a/hw/rdma/rdma_backend.c
> +++ b/hw/rdma/rdma_backend.c
> @@ -402,6 +402,10 @@ void rdma_backend_post_send(RdmaBackendDev *backend_dev,
>       if (qp_type == IBV_QPT_UD) {
>           wr.wr.ud.ah = create_ah(backend_dev, qp->ibpd,
>                                   backend_dev->backend_gid_idx, dgid);
> +        if (!wr.wr.ud.ah) {
> +            comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_FAIL_BACKEND, ctx, 0);
> +            goto out_dealloc_cqe_ctx;
> +        }
>           wr.wr.ud.remote_qpn = dqpn;
>           wr.wr.ud.remote_qkey = dqkey;
>       }

The path did not compile because it depends on a series that was not
yet merged.

Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>

Thanks,
Marcel
