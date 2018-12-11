Received: from eggs.gnu.org ([2001:4830:134:3::10]:37204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gWk7f-00031i-53
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:39:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gWk7b-0001vx-2k
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:38:59 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:53710)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gWk7a-0001v6-LC
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:38:54 -0500
Date: Tue, 11 Dec 2018 17:38:31 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20181211153830.GC28105@lap1>
References: <20181211132642.3027-1-ppandit@redhat.com>
	<20181211132642.3027-4-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211132642.3027-4-ppandit@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/5] pvrdma: check number of pages when
 creating rings
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

On Tue, Dec 11, 2018 at 06:56:40PM +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> When creating CQ/QP rings, an object can have up to
> PVRDMA_MAX_FAST_REG_PAGES=128 pages. Check 'npages' parameter
> to avoid excessive memory allocation or a null dereference.
> 
> Reported-by: Li Qiang <liq3ea@163.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/rdma/vmw/pvrdma_cmd.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
> index 4faeb21631..ee2888259c 100644
> --- a/hw/rdma/vmw/pvrdma_cmd.c
> +++ b/hw/rdma/vmw/pvrdma_cmd.c
> @@ -273,6 +273,10 @@ static int create_cq_ring(PCIDevice *pci_dev , PvrdmaRing **ring,
>          pr_dbg("Failed to map to CQ page table\n");
>          goto out;
>      }
> +    if (!nchunks || nchunks > PVRDMA_MAX_FAST_REG_PAGES) {
> +        pr_dbg("invalid nchunks: %d\n", nchunks);
> +        goto out;
> +    }
>  
>      r = g_malloc(sizeof(*r));
>      *ring = r;
> @@ -389,6 +393,11 @@ static int create_qp_rings(PCIDevice *pci_dev, uint64_t pdir_dma,
>          pr_dbg("Failed to map to CQ page table\n");
>          goto out;
>      }
> +    if (!spages || spages > PVRDMA_MAX_FAST_REG_PAGES
> +        || !rpages || rpages > PVRDMA_MAX_FAST_REG_PAGES) {
> +        pr_dbg("invalid pages: %d, %d\n", spages, rpages);
> +        goto out;
> +    }
>  

This check (along with the one in create_cq_ring) better be placed before
mapping to page table.

With or without accepting the suggestion fix LGTM.

Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>

>      sr = g_malloc(2 * sizeof(*rr));
>      rr = &sr[1];
> -- 
> 2.19.2
> 
