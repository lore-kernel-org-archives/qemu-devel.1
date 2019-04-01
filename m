Received: from eggs.gnu.org ([209.51.188.92]:42014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hAqmP-0006zb-4g
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 02:50:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hAqmO-0001Sl-8E
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 02:50:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47920)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1hAqmN-0001Rm-SS
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 02:50:48 -0400
Date: Mon, 1 Apr 2019 09:50:36 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20190401065035.GA8342@lap1>
References: <20190326125433.475-1-kamalheib1@gmail.com>
	<20190326125433.475-4-kamalheib1@gmail.com>
	<20190327155414.GB10207@lap1>
	<2fc57775-8e6f-6919-f402-8c140a7b14c9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fc57775-8e6f-6919-f402-8c140a7b14c9@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/4] hw/rdma: Modify create/destroy QP
 to support SRQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamal Heib <kamalheib1@gmail.com>
Cc: qemu-devel@nongnu.org

> >>  
> >> @@ -525,16 +539,21 @@ static int destroy_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
> >>      struct pvrdma_cmd_destroy_qp *cmd = &req->destroy_qp;
> >>      RdmaRmQP *qp;
> >>      PvrdmaRing *ring;
> >> +    uint8_t is_srq = 0;
> >>  
> >>      qp = rdma_rm_get_qp(&dev->rdma_dev_res, cmd->qp_handle);
> >>      if (!qp) {
> >>          return -EINVAL;
> >>      }
> >>  
> >> +    if (qp->is_srq) {
> >> +        is_srq = 1;
> >> +    }
> >> +
> > 
> > [1]
> > 
> >>      rdma_rm_dealloc_qp(&dev->rdma_dev_res, cmd->qp_handle);
> > 
> > [2]
> > 
> >>  
> >>      ring = (PvrdmaRing *)qp->opaque;
> > 
> > [3]
> > 
> >> -    destroy_qp_rings(ring);
> >> +    destroy_qp_rings(ring, is_srq);
> > 
> > Better move the call to rdma_rm_dealloc_qp ([2]) to here and get rid of the
> > block in [1].
> > 
> > In any case, the code in [3] looks like a bug to me (an existing bug), i.e.
> > qp pointer cannot be trusted after call to rdma_rm_dealloc_qp (use after
> > free).
> > What do you think?
> 
> You are right, I'll rearrange the code in v3.

Thanks just please add note for that in the commit message as you are
fixing an issue not related to SRQ.

> 
> > 
> >>  
> >>      return 0;
> >>  }
> >> -- 
> >> 2.20.1
> >>
> >>
> 
