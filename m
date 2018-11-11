Received: from eggs.gnu.org ([2001:4830:134:3::10]:50525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gLlLG-0004v7-Gl
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 03:43:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gLlLC-0004np-RT
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 03:43:38 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:34318)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gLlLA-0003qY-UX
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 03:43:34 -0500
Date: Sun, 11 Nov 2018 10:43:07 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20181111084306.GE2974@lap1>
References: <20181108160818.5485-1-yuval.shaia@oracle.com>
	<20181108160818.5485-9-yuval.shaia@oracle.com>
	<58b12b20-39ae-233b-0a23-10ceed0e8c79@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58b12b20-39ae-233b-0a23-10ceed0e8c79@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 08/22] hw/pvrdma: Set the correct opcode
 for recv completion
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

On Sat, Nov 10, 2018 at 08:18:58PM +0200, Marcel Apfelbaum wrote:
> 
> 
> On 11/8/18 6:08 PM, Yuval Shaia wrote:
> > The function pvrdma_post_cqe populates CQE entry with opcode from the
> > given completion element. For receive operation value was not set. Fix
> > it by setting it to IBV_WC_RECV.
> > 
> > Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> > ---
> >   hw/rdma/vmw/pvrdma_qp_ops.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/rdma/vmw/pvrdma_qp_ops.c b/hw/rdma/vmw/pvrdma_qp_ops.c
> > index 762700a205..7b0f440fda 100644
> > --- a/hw/rdma/vmw/pvrdma_qp_ops.c
> > +++ b/hw/rdma/vmw/pvrdma_qp_ops.c
> > @@ -196,8 +196,9 @@ int pvrdma_qp_recv(PVRDMADev *dev, uint32_t qp_handle)
> >           comp_ctx = g_malloc(sizeof(CompHandlerCtx));
> >           comp_ctx->dev = dev;
> >           comp_ctx->cq_handle = qp->recv_cq_handle;
> > -        comp_ctx->cqe.qp = qp_handle;
> >           comp_ctx->cqe.wr_id = wqe->hdr.wr_id;
> > +        comp_ctx->cqe.qp = qp_handle;
> 
> Not sure the above chunk is needed.

Right, it is not related to the change but did it "while there" to be
consisted with settings order in pvrdma_qp_send :)

> 
> > +        comp_ctx->cqe.opcode = IBV_WC_RECV;
> 
> Anyway
> 
> Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>

Thanks.

> 
> Thanks,
> Marcel
> 
> >           rdma_backend_post_recv(&dev->backend_dev, &dev->rdma_dev_res,
> >                                  &qp->backend_qp, qp->qp_type,
> 
