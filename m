Received: from eggs.gnu.org ([2001:4830:134:3::10]:43471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fr1Yr-000801-Gs
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 09:46:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fr1Yo-0006Am-DH
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 09:46:37 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:32999)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fr1Yo-0006AO-6p
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 09:46:34 -0400
Received: by mail-wr1-x443.google.com with SMTP id v90-v6so6160822wrc.0
	for <qemu-devel@nongnu.org>; Sat, 18 Aug 2018 06:46:34 -0700 (PDT)
References: <20180814100010.2546-1-yuval.shaia@oracle.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <e835cd66-9830-21c0-c3e2-08f6a1dc64eb@gmail.com>
Date: Sat, 18 Aug 2018 16:46:29 +0300
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

Hi Yuval,

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

comp_handler takes 3 arguments, but here you pass 4, so the compilation 
fails.

Thanks,
Marcel

> +            goto out_dealloc_cqe_ctx;
> +        }
>           wr.wr.ud.remote_qpn = dqpn;
>           wr.wr.ud.remote_qkey = dqkey;
>       }
