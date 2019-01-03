Received: from eggs.gnu.org ([208.118.235.92]:54215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gf3Lb-0005jO-NX
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:47:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gf3LX-0004dU-Mr
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:47:43 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:40563)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gf3LX-0004aa-HG
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:47:39 -0500
Received: by mail-wm1-f52.google.com with SMTP id f188so30311109wmf.5
	for <qemu-devel@nongnu.org>; Thu, 03 Jan 2019 05:47:39 -0800 (PST)
References: <20190103130338.49081-1-liq3ea@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fad70169-0cff-ede5-c07d-bff01d113f88@redhat.com>
Date: Thu, 3 Jan 2019 14:47:37 +0100
MIME-Version: 1.0
In-Reply-To: <20190103130338.49081-1-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw: pvrdma: fix memory leak in error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>, yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org

On 1/3/19 2:03 PM, Li Qiang wrote:
> Spotted by Coverity: CID 1398595
> 

Fixes: 2b05705dc8

> Signed-off-by: Li Qiang <liq3ea@163.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/rdma/vmw/pvrdma_qp_ops.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/rdma/vmw/pvrdma_qp_ops.c b/hw/rdma/vmw/pvrdma_qp_ops.c
> index 300471a4c9..584be2043e 100644
> --- a/hw/rdma/vmw/pvrdma_qp_ops.c
> +++ b/hw/rdma/vmw/pvrdma_qp_ops.c
> @@ -168,6 +168,7 @@ int pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_handle)
>          sgid = rdma_rm_get_gid(&dev->rdma_dev_res, wqe->hdr.wr.ud.av.gid_index);
>          if (!sgid) {
>              pr_dbg("Fail to get gid for idx %d\n", wqe->hdr.wr.ud.av.gid_index);
> +            g_free(comp_ctx);
>              return -EIO;
>          }
>          pr_dbg("sgid_id=%d, sgid=0x%llx\n", wqe->hdr.wr.ud.av.gid_index,
> @@ -179,6 +180,7 @@ int pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_handle)
>          if (sgid_idx <= 0) {
>              pr_dbg("Fail to get bk sgid_idx for sgid_idx %d\n",
>                     wqe->hdr.wr.ud.av.gid_index);
> +            g_free(comp_ctx);
>              return -EIO;
>          }
>  
> 
