Received: from eggs.gnu.org ([209.51.188.92]:55834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gizns-00027R-R5
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:49:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1giznr-0005KY-3j
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:49:12 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1giznq-0005HY-NE
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:49:11 -0500
Received: by mail-wm1-f66.google.com with SMTP id p6so8319691wmc.1
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 02:49:10 -0800 (PST)
References: <20190109202140.4051-1-yuval.shaia@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <926800b7-5d96-ee25-9d62-107d546115b1@redhat.com>
Date: Mon, 14 Jan 2019 11:49:08 +0100
MIME-Version: 1.0
In-Reply-To: <20190109202140.4051-1-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/pvrdma: Make function
 pvrdma_qp_send/recv return void.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>, marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org

On 1/9/19 9:21 PM, Yuval Shaia wrote:
> The functions handles errors internaly, callers have nothing to do with
> the return value.
> 
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/rdma/vmw/pvrdma_qp_ops.c | 14 ++++++--------
>  hw/rdma/vmw/pvrdma_qp_ops.h |  4 ++--
>  2 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/rdma/vmw/pvrdma_qp_ops.c b/hw/rdma/vmw/pvrdma_qp_ops.c
> index 0565eba981..ce5a60e184 100644
> --- a/hw/rdma/vmw/pvrdma_qp_ops.c
> +++ b/hw/rdma/vmw/pvrdma_qp_ops.c
> @@ -143,7 +143,7 @@ int pvrdma_qp_ops_init(void)
>      return 0;
>  }
>  
> -int pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_handle)
> +void pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_handle)
>  {
>      RdmaRmQP *qp;
>      PvrdmaSqWqe *wqe;
> @@ -155,7 +155,8 @@ int pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_handle)
>  
>      qp = rdma_rm_get_qp(&dev->rdma_dev_res, qp_handle);
>      if (unlikely(!qp)) {
> -        return -EINVAL;
> +        pr_dbg("Invalid qpn\n");
> +        return;
>      }
>  
>      ring = (PvrdmaRing *)qp->opaque;
> @@ -212,11 +213,9 @@ int pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_handle)
>  
>          wqe = pvrdma_ring_next_elem_read(ring);
>      }
> -
> -    return 0;
>  }
>  
> -int pvrdma_qp_recv(PVRDMADev *dev, uint32_t qp_handle)
> +void pvrdma_qp_recv(PVRDMADev *dev, uint32_t qp_handle)
>  {
>      RdmaRmQP *qp;
>      PvrdmaRqWqe *wqe;
> @@ -226,7 +225,8 @@ int pvrdma_qp_recv(PVRDMADev *dev, uint32_t qp_handle)
>  
>      qp = rdma_rm_get_qp(&dev->rdma_dev_res, qp_handle);
>      if (unlikely(!qp)) {
> -        return -EINVAL;
> +        pr_dbg("Invalid qpn\n");
> +        return;
>      }
>  
>      ring = &((PvrdmaRing *)qp->opaque)[1];
> @@ -262,8 +262,6 @@ int pvrdma_qp_recv(PVRDMADev *dev, uint32_t qp_handle)
>  
>          wqe = pvrdma_ring_next_elem_read(ring);
>      }
> -
> -    return 0;
>  }
>  
>  void pvrdma_cq_poll(RdmaDeviceResources *dev_res, uint32_t cq_handle)
> diff --git a/hw/rdma/vmw/pvrdma_qp_ops.h b/hw/rdma/vmw/pvrdma_qp_ops.h
> index ac46bf7fdf..31cb48ba29 100644
> --- a/hw/rdma/vmw/pvrdma_qp_ops.h
> +++ b/hw/rdma/vmw/pvrdma_qp_ops.h
> @@ -20,8 +20,8 @@
>  
>  int pvrdma_qp_ops_init(void);
>  void pvrdma_qp_ops_fini(void);
> -int pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_handle);
> -int pvrdma_qp_recv(PVRDMADev *dev, uint32_t qp_handle);
> +void pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_handle);
> +void pvrdma_qp_recv(PVRDMADev *dev, uint32_t qp_handle);
>  void pvrdma_cq_poll(RdmaDeviceResources *dev_res, uint32_t cq_handle);
>  
>  #endif
> 
