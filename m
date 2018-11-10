Received: from eggs.gnu.org ([2001:4830:134:3::10]:54134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gLY69-0004AK-DF
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 13:35:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gLY64-0005yX-G5
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 13:35:09 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38136)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gLXXw-00031r-32
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 12:59:48 -0500
Received: by mail-wr1-x442.google.com with SMTP id e3-v6so5103955wrs.5
	for <qemu-devel@nongnu.org>; Sat, 10 Nov 2018 09:59:47 -0800 (PST)
References: <20181108160818.5485-1-yuval.shaia@oracle.com>
	<20181108160818.5485-5-yuval.shaia@oracle.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <8fdf3fd4-a11e-b1fc-bb86-fd47e3d7df20@gmail.com>
Date: Sat, 10 Nov 2018 19:59:44 +0200
MIME-Version: 1.0
In-Reply-To: <20181108160818.5485-5-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 04/22] hw/rdma: Abort send-op if fail to
 create addr handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com



On 11/8/18 6:08 PM, Yuval Shaia wrote:
> Function create_ah might return NULL, let's exit with an error.
>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>   hw/rdma/rdma_backend.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
> index d7a4bbd91f..1e148398a2 100644
> --- a/hw/rdma/rdma_backend.c
> +++ b/hw/rdma/rdma_backend.c
> @@ -338,6 +338,10 @@ void rdma_backend_post_send(RdmaBackendDev *backend_dev,
>       if (qp_type == IBV_QPT_UD) {
>           wr.wr.ud.ah = create_ah(backend_dev, qp->ibpd,
>                                   backend_dev->backend_gid_idx, dgid);
> +        if (!wr.wr.ud.ah) {
> +            comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_FAIL_BACKEND, ctx);
> +            goto out_dealloc_cqe_ctx;
> +        }
>           wr.wr.ud.remote_qpn = dqpn;
>           wr.wr.ud.remote_qkey = dqkey;
>       }

Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>

Thanks,
Marcel
