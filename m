Received: from eggs.gnu.org ([2001:4830:134:3::10]:38701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gXJTo-0006rL-QW
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:24:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gXJTk-0007KB-R5
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:24:12 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:59682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gXJTj-0007J5-Jg
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:24:07 -0500
Date: Thu, 13 Dec 2018 07:22:38 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20181213052237.GB2927@lap1>
References: <20181212193039.11445-1-ppandit@redhat.com>
	<20181212193039.11445-7-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212193039.11445-7-ppandit@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 6/6] pvrdma: check return value from
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

On Thu, Dec 13, 2018 at 01:00:39AM +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> pvrdma_idx_ring_has_[data/space] routines also return invalid
> index PVRDMA_INVALID_IDX[=-1], if ring has no data/space. Check
> return value from these routines to avoid plausible infinite loops.
> 
> Reported-by: Li Qiang <liq3ea@163.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/rdma/vmw/pvrdma_dev_ring.c | 29 +++++++++++------------------
>  1 file changed, 11 insertions(+), 18 deletions(-)
> 
> Update: revert use of idx variable in pvrdma_ring_next_elem_read()
>   -> https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg02814.html
> 
> diff --git a/hw/rdma/vmw/pvrdma_dev_ring.c b/hw/rdma/vmw/pvrdma_dev_ring.c
> index 01247fc041..e8e5b502f6 100644
> --- a/hw/rdma/vmw/pvrdma_dev_ring.c
> +++ b/hw/rdma/vmw/pvrdma_dev_ring.c
> @@ -73,23 +73,16 @@ out:
>  
>  void *pvrdma_ring_next_elem_read(PvrdmaRing *ring)
>  {
> +    int e;
>      unsigned int idx = 0, offset;
>  
> -    /*
> -    pr_dbg("%s: t=%d, h=%d\n", ring->name, ring->ring_state->prod_tail,
> -           ring->ring_state->cons_head);
> -    */
> -
> -    if (!pvrdma_idx_ring_has_data(ring->ring_state, ring->max_elems, &idx)) {
> +    e = pvrdma_idx_ring_has_data(ring->ring_state, ring->max_elems, &idx);
> +    if (e <= 0) {
>          pr_dbg("No more data in ring\n");
>          return NULL;
>      }
>  
>      offset = idx * ring->elem_sz;
> -    /*
> -    pr_dbg("idx=%d\n", idx);
> -    pr_dbg("offset=%d\n", offset);
> -    */
>      return ring->pages[offset / TARGET_PAGE_SIZE] + (offset % TARGET_PAGE_SIZE);
>  }
>  
> @@ -105,20 +98,20 @@ void pvrdma_ring_read_inc(PvrdmaRing *ring)
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

Thanks.

Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>

> -- 
> 2.19.2
> 
