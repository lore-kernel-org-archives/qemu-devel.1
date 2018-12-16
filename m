Received: from eggs.gnu.org ([2001:4830:134:3::10]:49527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gYd7v-0007CG-GS
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 15:35:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gYd4B-0003BH-1e
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 15:31:14 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36346)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gYd4A-00039o-Ez
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 15:31:10 -0500
Date: Sun, 16 Dec 2018 22:30:52 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20181216203052.GA5065@lap1>
References: <20181212193039.11445-1-ppandit@redhat.com>
	<20181212193039.11445-4-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212193039.11445-4-ppandit@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/6] pvrdma: check number of pages when
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

Hi Prasad,
Turned out that this patch cause a regression.

My test plan includes the following steps:
- Start two VMs.
- Run RC and UD traffic between the two.
- Run sanity local test on both which includes:
	- RC traffic on 3 gids with various message size.
	- UD traffic.
	- RDMA-CM connection with MAD.
	- MPI test.
- Power off the two VMs.

With this patch the last step fails, the guest OS hangs, trying to probably
unload pvrdma driver and finally gave up after 3 minutes.

On its face this patch does not seems to be related to the problem above
but fact is a fact, without this patch VM goes down with no issues. The
only thing i can think of is that somehow the guest driver does not capture
the error or does not handles the error correctly.

Anyways with debug turned on i have noticed that there is one case that
devices gets 129 nchunks (i think in MPI) while your patch limits it to
128.
>From pvrdma source code  we can see that first page is dedicated to ring
state, this means that it maybe correct that 128 is the limit but we
should check that nchunks does not exceed 129, not 128.

What do you think?

Ie. to replace this line from create_cq_ring
+    if (!nchunks || nchunks > PVRDMA_MAX_FAST_REG_PAGES) {
with this
+    if (!nchunks || nchunks > PVRDMA_MAX_FAST_REG_PAGES + 1) {

Let me know your opinion.
I can make a quick fix to your patch or send a new patch on top of yours
for a review.

Yuval

On Thu, Dec 13, 2018 at 01:00:36AM +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> When creating CQ/QP rings, an object can have up to
> PVRDMA_MAX_FAST_REG_PAGES=128 pages. Check 'npages' parameter
> to avoid excessive memory allocation or a null dereference.
> 
> Reported-by: Li Qiang <liq3ea@163.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/rdma/vmw/pvrdma_cmd.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> Update: No change, ack'd v1
>   -> https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg02786.html
> 
> diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
> index 4f616d4177..e37fb18280 100644
> --- a/hw/rdma/vmw/pvrdma_cmd.c
> +++ b/hw/rdma/vmw/pvrdma_cmd.c
> @@ -259,6 +259,11 @@ static int create_cq_ring(PCIDevice *pci_dev , PvrdmaRing **ring,
>      int rc = -EINVAL;
>      char ring_name[MAX_RING_NAME_SZ];
>  
> +    if (!nchunks || nchunks > PVRDMA_MAX_FAST_REG_PAGES) {
> +        pr_dbg("invalid nchunks: %d\n", nchunks);
> +        return rc;
> +    }
> +
>      pr_dbg("pdir_dma=0x%llx\n", (long long unsigned int)pdir_dma);
>      dir = rdma_pci_dma_map(pci_dev, pdir_dma, TARGET_PAGE_SIZE);
>      if (!dir) {
> @@ -371,6 +376,12 @@ static int create_qp_rings(PCIDevice *pci_dev, uint64_t pdir_dma,
>      char ring_name[MAX_RING_NAME_SZ];
>      uint32_t wqe_sz;
>  
> +    if (!spages || spages > PVRDMA_MAX_FAST_REG_PAGES
> +        || !rpages || rpages > PVRDMA_MAX_FAST_REG_PAGES) {
> +        pr_dbg("invalid pages: %d, %d\n", spages, rpages);
> +        return rc;
> +    }
> +
>      pr_dbg("pdir_dma=0x%llx\n", (long long unsigned int)pdir_dma);
>      dir = rdma_pci_dma_map(pci_dev, pdir_dma, TARGET_PAGE_SIZE);
>      if (!dir) {
> -- 
> 2.19.2
> 
