Received: from eggs.gnu.org ([2001:4830:134:3::10]:45022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gLkjr-00019i-RZ
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 03:05:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gLkjo-0000DP-KH
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 03:04:59 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:38110)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gLkjo-0000AZ-9w
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 03:04:56 -0500
Date: Sun, 11 Nov 2018 10:04:47 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20181111080446.GD2974@lap1>
References: <20181108160818.5485-1-yuval.shaia@oracle.com>
	<20181108160818.5485-10-yuval.shaia@oracle.com>
	<128a90af-156f-fb25-2616-1bc8c2096df8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <128a90af-156f-fb25-2616-1bc8c2096df8@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 09/22] hw/pvrdma: Set the correct opcode
 for send completion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com, yuval.shaia@oracle.com

On Sat, Nov 10, 2018 at 08:21:51PM +0200, Marcel Apfelbaum wrote:
> 
> 
> On 11/8/18 6:08 PM, Yuval Shaia wrote:
> > opcode for WC should be set by the device and not taken from work
> > element.
> > 
> > Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> > ---
> >   hw/rdma/vmw/pvrdma_qp_ops.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/hw/rdma/vmw/pvrdma_qp_ops.c b/hw/rdma/vmw/pvrdma_qp_ops.c
> > index 7b0f440fda..3388be1926 100644
> > --- a/hw/rdma/vmw/pvrdma_qp_ops.c
> > +++ b/hw/rdma/vmw/pvrdma_qp_ops.c
> > @@ -154,7 +154,7 @@ int pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_handle)
> >           comp_ctx->cq_handle = qp->send_cq_handle;
> >           comp_ctx->cqe.wr_id = wqe->hdr.wr_id;
> >           comp_ctx->cqe.qp = qp_handle;
> > -        comp_ctx->cqe.opcode = wqe->hdr.opcode;
> > +        comp_ctx->cqe.opcode = IBV_WC_SEND;
> 
> That is interesting, what should happen if the opcode in hdr is different?
> Maybe fail the operation?

openmpi builds its entire IB state machine on that, see here:

https://github.com/open-mpi/ompi/blob/3dc1629771177a883cd8f1be6e97ab152e0f4584/opal/mca/btl/openib/btl_openib_component.c#L3512

> 
> Thanks,
> Marcel
> 
> >           rdma_backend_post_send(&dev->backend_dev, &qp->backend_qp, qp->qp_type,
> >                                  (struct ibv_sge *)&wqe->sge[0], wqe->hdr.num_sge,
> 
