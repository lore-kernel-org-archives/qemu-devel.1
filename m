Received: from eggs.gnu.org ([2001:4830:134:3::10]:40762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gX9rw-0002II-3x
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 14:08:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gX9rs-0005GM-Ie
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 14:08:28 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:43254)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gX9rr-0005As-Ve
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 14:08:24 -0500
Date: Wed, 12 Dec 2018 21:08:08 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20181212190807.GA7372@lap1>
References: <20181212175817.815-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212175817.815-1-ppandit@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] pvrdma: release device resources in case
 of an error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Li Qiang <liq3ea@163.com>, Prasad J Pandit <pjp@fedoraproject.org>, yuval.shaia@oracle.com

On Wed, Dec 12, 2018 at 11:28:17PM +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> If during pvrdma device initialisation an error occurs,
> pvrdma_realize() does not release memory resources, leading
> to memory leakage.
> 
> Reported-by: Li Qiang <liq3ea@163.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/rdma/vmw/pvrdma_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
> index 8a03ab4669..b65f8662df 100644
> --- a/hw/rdma/vmw/pvrdma_main.c
> +++ b/hw/rdma/vmw/pvrdma_main.c
> @@ -579,7 +579,7 @@ static void pvrdma_shutdown_notifier(Notifier *n, void *opaque)
>  
>  static void pvrdma_realize(PCIDevice *pdev, Error **errp)
>  {
> -    int rc;
> +    int rc = 0;
>      PVRDMADev *dev = PVRDMA_DEV(pdev);
>      Object *memdev_root;
>      bool ram_shared = false;
> @@ -655,6 +655,7 @@ static void pvrdma_realize(PCIDevice *pdev, Error **errp)
>  
>  out:
>      if (rc) {
> +        pvrdma_fini(pdev);
>          error_append_hint(errp, "Device fail to load\n");
>      }

Thanks.

Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>

>  }
> -- 
> 2.19.2
> 
