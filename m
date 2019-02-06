Received: from eggs.gnu.org ([209.51.188.92]:50559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1grOgI-0008Vr-E9
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:00:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1grOgG-0000wn-Fn
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:00:06 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:47324)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1grOgE-0000sy-MN
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:00:04 -0500
Date: Wed, 6 Feb 2019 16:59:50 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20190206145949.GB4282@lap1>
References: <20190131130850.6850-1-yuval.shaia@oracle.com>
	<20190131130850.6850-4-yuval.shaia@oracle.com>
	<3dc624dc-7940-f3cc-6d22-bfe0b9d6bc14@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dc624dc-7940-f3cc-6d22-bfe0b9d6bc14@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 03/10] hw/rdma: Warn when too many
 consecutive poll CQ triggered on an empty CQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: dgilbert@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

On Wed, Feb 06, 2019 at 12:14:24PM +0200, Marcel Apfelbaum wrote:
> Hi Yuval,
> 
> On 1/31/19 3:08 PM, Yuval Shaia wrote:
> > To protect against CPU over utilization when guest performs unneeded
> > busy waiting loop on an empty CQ.
> > 
> > Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> > ---
> >   hw/rdma/rdma_backend.c      | 11 +++++++----
> >   hw/rdma/rdma_backend.h      |  2 +-
> >   hw/rdma/rdma_rm.c           |  1 +
> >   hw/rdma/rdma_rm_defs.h      |  6 +++++-
> >   hw/rdma/vmw/pvrdma_qp_ops.c | 24 +++++++++++++++++++++++-
> >   5 files changed, 37 insertions(+), 7 deletions(-)
> > 
> > diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
> > index 2f6372f8f0..b7d6afb5da 100644
> > --- a/hw/rdma/rdma_backend.c
> > +++ b/hw/rdma/rdma_backend.c
> > @@ -64,9 +64,9 @@ static inline void complete_work(enum ibv_wc_status status, uint32_t vendor_err,
> >       comp_handler(ctx, &wc);
> >   }
> > -static void rdma_poll_cq(RdmaDeviceResources *rdma_dev_res, struct ibv_cq *ibcq)
> > +static int rdma_poll_cq(RdmaDeviceResources *rdma_dev_res, struct ibv_cq *ibcq)
> >   {
> > -    int i, ne;
> > +    int i, ne, total_ne = 0;
> >       BackendCtx *bctx;
> >       struct ibv_wc wc[2];
> > @@ -76,6 +76,7 @@ static void rdma_poll_cq(RdmaDeviceResources *rdma_dev_res, struct ibv_cq *ibcq)
> >           trace_rdma_poll_cq(ne, ibcq);
> >           for (i = 0; i < ne; i++) {
> > +            total_ne++;
> 
> It seems 'i' and 'total_ne' hold the same value, do you need them both?

Scope is different, while the scope of 'i' is limited to one ibv_poll_cq
call, the total_ne counts until ibv_poll_cq loop is done.

> 
> >               bctx = rdma_rm_get_cqe_ctx(rdma_dev_res, wc[i].wr_id);
> >               if (unlikely(!bctx)) {
> >                   rdma_error_report("No matching ctx for req %"PRId64,
> > @@ -93,6 +94,8 @@ static void rdma_poll_cq(RdmaDeviceResources *rdma_dev_res, struct ibv_cq *ibcq)
> >       if (ne < 0) {
> >           rdma_error_report("ibv_poll_cq fail, rc=%d, errno=%d", ne, errno);
> >       }
> > +
> > +    return total_ne;
> >   }
> >   static void *comp_handler_thread(void *arg)
> > @@ -267,9 +270,9 @@ int rdma_backend_query_port(RdmaBackendDev *backend_dev,
> >       return 0;
> >   }
> > -void rdma_backend_poll_cq(RdmaDeviceResources *rdma_dev_res, RdmaBackendCQ *cq)
> > +int rdma_backend_poll_cq(RdmaDeviceResources *rdma_dev_res, RdmaBackendCQ *cq)
> >   {
> > -    rdma_poll_cq(rdma_dev_res, cq->ibcq);
> > +    return rdma_poll_cq(rdma_dev_res, cq->ibcq);
> >   }
> >   static GHashTable *ah_hash;
> > diff --git a/hw/rdma/rdma_backend.h b/hw/rdma/rdma_backend.h
> > index 5114c90e67..36305cd148 100644
> > --- a/hw/rdma/rdma_backend.h
> > +++ b/hw/rdma/rdma_backend.h
> > @@ -85,7 +85,7 @@ void rdma_backend_destroy_mr(RdmaBackendMR *mr);
> >   int rdma_backend_create_cq(RdmaBackendDev *backend_dev, RdmaBackendCQ *cq,
> >                              int cqe);
> >   void rdma_backend_destroy_cq(RdmaBackendCQ *cq);
> > -void rdma_backend_poll_cq(RdmaDeviceResources *rdma_dev_res, RdmaBackendCQ *cq);
> > +int rdma_backend_poll_cq(RdmaDeviceResources *rdma_dev_res, RdmaBackendCQ *cq);
> >   int rdma_backend_create_qp(RdmaBackendQP *qp, uint8_t qp_type,
> >                              RdmaBackendPD *pd, RdmaBackendCQ *scq,
> > diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
> > index 64c6ea1a4e..1ba77ac42c 100644
> > --- a/hw/rdma/rdma_rm.c
> > +++ b/hw/rdma/rdma_rm.c
> > @@ -261,6 +261,7 @@ int rdma_rm_alloc_cq(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
> >       if (!cq) {
> >           return -ENOMEM;
> >       }
> > +    atomic_set(&cq->missing_cqe, 0);
> >       cq->opaque = opaque;
> >       cq->notify = CNT_CLEAR;
> > diff --git a/hw/rdma/rdma_rm_defs.h b/hw/rdma/rdma_rm_defs.h
> > index 0ba61d1838..08692e87d4 100644
> > --- a/hw/rdma/rdma_rm_defs.h
> > +++ b/hw/rdma/rdma_rm_defs.h
> > @@ -34,7 +34,9 @@
> >   #define MAX_QP_INIT_RD_ATOM   16
> >   #define MAX_AH                64
> > -#define MAX_RM_TBL_NAME 16
> > +#define MAX_RM_TBL_NAME             16
> > +#define MAX_CONSEQ_EMPTY_POLL_CQ    2048 /* considered as error above this */
> > +
> >   typedef struct RdmaRmResTbl {
> >       char name[MAX_RM_TBL_NAME];
> >       QemuMutex lock;
> > @@ -59,6 +61,8 @@ typedef struct RdmaRmCQ {
> >       RdmaBackendCQ backend_cq;
> >       void *opaque;
> >       CQNotificationType notify;
> > +    int missing_cqe;
> 
> Maybe cq_empty_hit_cnt ? We don't really have a missing cqe.

Idea here is to count the CQEs we expect to have and still missing so name
is fine.

> 
> > +    int conseq_empty_poll;
> >   } RdmaRmCQ;
> >   /* MR (DMA region) */
> > diff --git a/hw/rdma/vmw/pvrdma_qp_ops.c b/hw/rdma/vmw/pvrdma_qp_ops.c
> > index 16db726dac..5d650a4943 100644
> > --- a/hw/rdma/vmw/pvrdma_qp_ops.c
> > +++ b/hw/rdma/vmw/pvrdma_qp_ops.c
> > @@ -60,6 +60,8 @@ static int pvrdma_post_cqe(PVRDMADev *dev, uint32_t cq_handle,
> >           return -EINVAL;
> >       }
> > +    atomic_dec(&cq->missing_cqe);
> > +
> 
> We should set it to 0 here? (If we are counting cq-empty hits)
> 
> >       ring = (PvrdmaRing *)cq->opaque;
> >       /* Step #1: Put CQE on CQ ring */
> > @@ -141,12 +143,15 @@ void pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_handle)
> >       PvrdmaRing *ring;
> >       int sgid_idx;
> >       union ibv_gid *sgid;
> > +    RdmaRmCQ *cq;
> >       qp = rdma_rm_get_qp(&dev->rdma_dev_res, qp_handle);
> >       if (unlikely(!qp)) {
> >           return;
> >       }
> > +    cq = rdma_rm_get_cq(&dev->rdma_dev_res, qp->send_cq_handle);
> > +
> >       ring = (PvrdmaRing *)qp->opaque;
> >       wqe = (struct PvrdmaSqWqe *)pvrdma_ring_next_elem_read(ring);
> > @@ -186,6 +191,7 @@ void pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_handle)
> >               continue;
> >           }
> > +        atomic_inc(&cq->missing_cqe);
> >           rdma_backend_post_send(&dev->backend_dev, &qp->backend_qp, qp->qp_type,
> >                                  (struct ibv_sge *)&wqe->sge[0], wqe->hdr.num_sge,
> >                                  sgid_idx, sgid,
> > @@ -204,12 +210,15 @@ void pvrdma_qp_recv(PVRDMADev *dev, uint32_t qp_handle)
> >       RdmaRmQP *qp;
> >       PvrdmaRqWqe *wqe;
> >       PvrdmaRing *ring;
> > +    RdmaRmCQ *cq;
> >       qp = rdma_rm_get_qp(&dev->rdma_dev_res, qp_handle);
> >       if (unlikely(!qp)) {
> >           return;
> >       }
> > +    cq = rdma_rm_get_cq(&dev->rdma_dev_res, qp->recv_cq_handle);
> > +
> >       ring = &((PvrdmaRing *)qp->opaque)[1];
> >       wqe = (struct PvrdmaRqWqe *)pvrdma_ring_next_elem_read(ring);
> > @@ -231,6 +240,7 @@ void pvrdma_qp_recv(PVRDMADev *dev, uint32_t qp_handle)
> >               continue;
> >           }
> > +        atomic_inc(&cq->missing_cqe);
> >           rdma_backend_post_recv(&dev->backend_dev, &dev->rdma_dev_res,
> >                                  &qp->backend_qp, qp->qp_type,
> >                                  (struct ibv_sge *)&wqe->sge[0], wqe->hdr.num_sge,
> > @@ -245,11 +255,23 @@ void pvrdma_qp_recv(PVRDMADev *dev, uint32_t qp_handle)
> >   void pvrdma_cq_poll(RdmaDeviceResources *dev_res, uint32_t cq_handle)
> >   {
> >       RdmaRmCQ *cq;
> > +    int polled;
> >       cq = rdma_rm_get_cq(dev_res, cq_handle);
> >       if (!cq) {
> >           return;
> >       }
> > -    rdma_backend_poll_cq(dev_res, &cq->backend_cq);
> > +    polled = rdma_backend_poll_cq(dev_res, &cq->backend_cq);
> > +    if (!polled) {
> > +        if (cq->conseq_empty_poll == MAX_CONSEQ_EMPTY_POLL_CQ) {
> > +            rdma_warn_report("%d consequtive empty polls from CQ %d, missing cqe %d",
> > +                             cq->conseq_empty_poll, cq_handle,
> > +                             atomic_read(&cq->missing_cqe));
> > +            cq->conseq_empty_poll = 0;
> > +        }
> > +        cq->conseq_empty_poll++;
> > +    } else {
> > +        cq->conseq_empty_poll = 0;
> > +    }
> >   }
> 
> So we don't really protect against high CPU usage, we only warn.

Correct, just a warning.
But accepting your suggestion of adding this as another counter and get rid
of this warning.

> Are the both counters interesting?

Both? the 'conseq' and 'missing'?
Idea here is that 'missing' counts the total missing CQEs while conseq
(short name for consecutive) counts the number of times the guest issues
consecutive 'polls' to empty CQ (please note how it is zeroed when poll_cq
returns something).

> 
> Thanks,
> Marcel
> 
> 
