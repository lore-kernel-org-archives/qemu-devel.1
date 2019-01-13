Received: from eggs.gnu.org ([209.51.188.92]:36117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gilHv-0002DH-9K
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 14:19:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gilHu-0003MX-FI
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 14:19:15 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:50746)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gilHu-0003L1-2Q
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 14:19:14 -0500
Date: Sun, 13 Jan 2019 21:19:02 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20190113191901.GA10017@lap1>
References: <20190109201559.3906-1-yuval.shaia@oracle.com>
	<7b754432-7c1e-8f22-3410-d95c426c2d0b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b754432-7c1e-8f22-3410-d95c426c2d0b@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] hw/pvrdma: Post CQE when receive invalid
 gid index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org

On Sat, Jan 12, 2019 at 05:11:39PM +0200, Marcel Apfelbaum wrote:
> 
> 
> On 1/9/19 10:15 PM, Yuval Shaia wrote:
> > This error should propagate back to guest.
> > 
> > Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> > ---
> >   hw/rdma/rdma_backend.h      | 1 +
> >   hw/rdma/vmw/pvrdma_qp_ops.c | 6 ++++--
> >   2 files changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/rdma/rdma_backend.h b/hw/rdma/rdma_backend.h
> > index a9ba40ae48..5114c90e67 100644
> > --- a/hw/rdma/rdma_backend.h
> > +++ b/hw/rdma/rdma_backend.h
> > @@ -32,6 +32,7 @@
> >   #define VENDOR_ERR_INVLKEY          0x207
> >   #define VENDOR_ERR_MR_SMALL         0x208
> >   #define VENDOR_ERR_INV_MAD_BUFF     0x209
> > +#define VENDOR_ERR_INV_GID_IDX      0x210
> >   /* Add definition for QP0 and QP1 as there is no userspace enums for them */
> >   enum ibv_special_qp_type {
> > diff --git a/hw/rdma/vmw/pvrdma_qp_ops.c b/hw/rdma/vmw/pvrdma_qp_ops.c
> > index 465bee8641..0565eba981 100644
> > --- a/hw/rdma/vmw/pvrdma_qp_ops.c
> > +++ b/hw/rdma/vmw/pvrdma_qp_ops.c
> > @@ -178,7 +178,8 @@ int pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_handle)
> >           sgid = rdma_rm_get_gid(&dev->rdma_dev_res, wqe->hdr.wr.ud.av.gid_index);
> >           if (!sgid) {
> >               pr_dbg("Fail to get gid for idx %d\n", wqe->hdr.wr.ud.av.gid_index);
> > -            return -EIO;
> > +            complete_with_error(VENDOR_ERR_INV_GID_IDX, comp_ctx);
> 
> Informing the guest is OK, but are you sure it makes sense
> to continue sending the other work requests?

Yes, it is exactly what is expected. RDMA application (or driver) would
usually push several work requests to ring (optimally populating the entire
ring) and then ring the doorbell.
An error in a specific WR does not means all WRs in ring should not be
processed.

> Is maybe safer to return with error as before?

And what about the remaining WR in the ring? any way the device would have
to process them on next doorbell.

> 
> > +            continue;
> >           }
> >           pr_dbg("sgid_id=%d, sgid=0x%llx\n", wqe->hdr.wr.ud.av.gid_index,
> >                  sgid->global.interface_id);
> > @@ -189,7 +190,8 @@ int pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_handle)
> >           if (sgid_idx <= 0) {
> >               pr_dbg("Fail to get bk sgid_idx for sgid_idx %d\n",
> >                      wqe->hdr.wr.ud.av.gid_index);
> > -            return -EIO;
> > +            complete_with_error(VENDOR_ERR_INV_GID_IDX, comp_ctx);
> > +            continue;
> 
> Same question here.
> 
> Thanks,
> Marcel
> >           }
> >           if (wqe->hdr.num_sge > dev->dev_attr.max_sge) {
> 
