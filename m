Received: from eggs.gnu.org ([2001:4830:134:3::10]:37822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gX9ft-0005gl-CX
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 13:56:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gX9fq-0000yz-Lo
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 13:56:01 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43858)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gX9fq-0000yM-CB
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 13:55:58 -0500
Date: Wed, 12 Dec 2018 20:55:34 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20181212185533.GG5747@lap1>
References: <20181212114726.24060-1-ppandit@redhat.com>
	<20181212114726.24060-6-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212114726.24060-6-ppandit@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 5/6] pvrdma: check return value from
 pvrdma_idx_ring_has_ routines
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

On Wed, Dec 12, 2018 at 05:17:25PM +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> pvrdma_idx_ring_has_[data/space] routines also return invalid
> index PVRDMA_INVALID_IDX[=-1], if ring has no data/space. Check
> return value from these routines to avoid plausible infinite loops.
> 
> Reported-by: Li Qiang <liq3ea@163.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/rdma/vmw/pvrdma_dev_ring.c | 37 +++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 19 deletions(-)
> 
> Update v1: receive error code in idx variable, remove comments
>   -> https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg02342.html
> 
> diff --git a/hw/rdma/vmw/pvrdma_dev_ring.c b/hw/rdma/vmw/pvrdma_dev_ring.c
> index 01247fc041..2dccac8442 100644
> --- a/hw/rdma/vmw/pvrdma_dev_ring.c
> +++ b/hw/rdma/vmw/pvrdma_dev_ring.c
> @@ -73,23 +73,22 @@ out:
>  
>  void *pvrdma_ring_next_elem_read(PvrdmaRing *ring)
>  {
> -    unsigned int idx = 0, offset;
> +    int idx;
> +    unsigned int offset, head;
>  
> -    /*
> -    pr_dbg("%s: t=%d, h=%d\n", ring->name, ring->ring_state->prod_tail,
> -           ring->ring_state->cons_head);
> -    */
> -
> -    if (!pvrdma_idx_ring_has_data(ring->ring_state, ring->max_elems, &idx)) {
> +    idx = pvrdma_idx_ring_has_data(ring->ring_state, ring->max_elems, &head);
> +    if (idx <= 0) {
>          pr_dbg("No more data in ring\n");
>          return NULL;
>      }
>  
> +    idx = pvrdma_idx(&ring->ring_state->cons_head, ring->max_elems);
> +    if (idx < 0 || head != idx) {
> +        pr_dbg("invalid idx\n");
> +        return NULL;
> +    }
> +

Sorry, i mislead you here, idx was already populated by
pvrdma_idx_ring_has_data so call to pvrdma_idx just to retrieve the index
is waste. Please revert back to using another variable to check the return
value from pvrdma_idx_ring_has_data and drop this call to pvrdma_idx.

>      offset = idx * ring->elem_sz;
> -    /*
> -    pr_dbg("idx=%d\n", idx);
> -    pr_dbg("offset=%d\n", offset);
> -    */
>      return ring->pages[offset / TARGET_PAGE_SIZE] + (offset % TARGET_PAGE_SIZE);
>  }
>  
> @@ -105,20 +104,20 @@ void pvrdma_ring_read_inc(PvrdmaRing *ring)
>  
>  void *pvrdma_ring_next_elem_write(PvrdmaRing *ring)
>  {
> -    unsigned int idx, offset, tail;
> +    int idx;
> +    unsigned int offset, tail;
>  
> -    /*
> -    pr_dbg("%s: t=%d, h=%d\n", ring->name, ring->ring_state->prod_tail,
> -           ring->ring_state->cons_head);
> -    */
> -
> -    if (!pvrdma_idx_ring_has_space(ring->ring_state, ring->max_elems, &tail)) {
> +    idx = pvrdma_idx_ring_has_space(ring->ring_state, ring->max_elems, &tail);
> +    if (idx <= 0) {
>          pr_dbg("CQ is full\n");
>          return NULL;
>      }
>  
>      idx = pvrdma_idx(&ring->ring_state->prod_tail, ring->max_elems);
> -    /* TODO: tail == idx */
> +    if (idx < 0 || tail != idx) {
> +        pr_dbg("invalid idx\n");
> +        return NULL;
> +    }
>  
>      offset = idx * ring->elem_sz;
>      return ring->pages[offset / TARGET_PAGE_SIZE] + (offset % TARGET_PAGE_SIZE);
> -- 
> 2.19.2
> 
