Received: from eggs.gnu.org ([209.51.188.92]:38956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kamalheib1@gmail.com>) id 1hAqTi-0000ZA-0f
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 02:31:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kamalheib1@gmail.com>) id 1hAqTg-0000XC-8F
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 02:31:29 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44773)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kamalheib1@gmail.com>)
	id 1hAqTf-0000Wg-Pd
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 02:31:28 -0400
Received: by mail-wr1-x443.google.com with SMTP id y7so10272487wrn.11
	for <qemu-devel@nongnu.org>; Sun, 31 Mar 2019 23:31:27 -0700 (PDT)
References: <20190326125433.475-1-kamalheib1@gmail.com>
	<20190326125433.475-4-kamalheib1@gmail.com>
	<20190327155414.GB10207@lap1>
From: Kamal Heib <kamalheib1@gmail.com>
Message-ID: <2fc57775-8e6f-6919-f402-8c140a7b14c9@gmail.com>
Date: Mon, 1 Apr 2019 09:31:22 +0300
MIME-Version: 1.0
In-Reply-To: <20190327155414.GB10207@lap1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Yuval Shaia <yuval.shaia@oracle.com>
Cc: qemu-devel@nongnu.org



On 3/27/19 5:54 PM, Yuval Shaia wrote:
> On Tue, Mar 26, 2019 at 02:54:32PM +0200, Kamal Heib wrote:
>> Modify create/destroy QP to support shared receive queue.
>>
>> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
>> ---
>>  hw/rdma/rdma_backend.c   |  9 ++++--
>>  hw/rdma/rdma_backend.h   |  6 ++--
>>  hw/rdma/rdma_rm.c        | 23 +++++++++++++--
>>  hw/rdma/rdma_rm.h        |  3 +-
>>  hw/rdma/rdma_rm_defs.h   |  1 +
>>  hw/rdma/vmw/pvrdma_cmd.c | 61 ++++++++++++++++++++++++++--------------
>>  6 files changed, 72 insertions(+), 31 deletions(-)
>>
>> diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
>> index 54419c8c58dd..8f1349c64dda 100644
>> --- a/hw/rdma/rdma_backend.c
>> +++ b/hw/rdma/rdma_backend.c
>> @@ -794,9 +794,9 @@ void rdma_backend_destroy_cq(RdmaBackendCQ *cq)
>>  
>>  int rdma_backend_create_qp(RdmaBackendQP *qp, uint8_t qp_type,
>>                             RdmaBackendPD *pd, RdmaBackendCQ *scq,
>> -                           RdmaBackendCQ *rcq, uint32_t max_send_wr,
>> -                           uint32_t max_recv_wr, uint32_t max_send_sge,
>> -                           uint32_t max_recv_sge)
>> +                           RdmaBackendCQ *rcq, RdmaBackendSRQ *srq,
>> +                           uint32_t max_send_wr, uint32_t max_recv_wr,
>> +                           uint32_t max_send_sge, uint32_t max_recv_sge)
>>  {
>>      struct ibv_qp_init_attr attr = {};
>>  
>> @@ -824,6 +824,9 @@ int rdma_backend_create_qp(RdmaBackendQP *qp, uint8_t qp_type,
>>      attr.cap.max_recv_wr = max_recv_wr;
>>      attr.cap.max_send_sge = max_send_sge;
>>      attr.cap.max_recv_sge = max_recv_sge;
>> +    if (srq) {
>> +        attr.srq = srq->ibsrq;
>> +    }
>>  
>>      qp->ibqp = ibv_create_qp(pd->ibpd, &attr);
>>      if (!qp->ibqp) {
>> diff --git a/hw/rdma/rdma_backend.h b/hw/rdma/rdma_backend.h
>> index cad7956d98e8..7c1a19a2b5ff 100644
>> --- a/hw/rdma/rdma_backend.h
>> +++ b/hw/rdma/rdma_backend.h
>> @@ -89,9 +89,9 @@ void rdma_backend_poll_cq(RdmaDeviceResources *rdma_dev_res, RdmaBackendCQ *cq);
>>  
>>  int rdma_backend_create_qp(RdmaBackendQP *qp, uint8_t qp_type,
>>                             RdmaBackendPD *pd, RdmaBackendCQ *scq,
>> -                           RdmaBackendCQ *rcq, uint32_t max_send_wr,
>> -                           uint32_t max_recv_wr, uint32_t max_send_sge,
>> -                           uint32_t max_recv_sge);
>> +                           RdmaBackendCQ *rcq, RdmaBackendSRQ *srq,
>> +                           uint32_t max_send_wr, uint32_t max_recv_wr,
>> +                           uint32_t max_send_sge, uint32_t max_recv_sge);
>>  int rdma_backend_qp_state_init(RdmaBackendDev *backend_dev, RdmaBackendQP *qp,
>>                                 uint8_t qp_type, uint32_t qkey);
>>  int rdma_backend_qp_state_rtr(RdmaBackendDev *backend_dev, RdmaBackendQP *qp,
>> diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
>> index bc5873cb4c14..90870ee0e15e 100644
>> --- a/hw/rdma/rdma_rm.c
>> +++ b/hw/rdma/rdma_rm.c
>> @@ -384,12 +384,14 @@ int rdma_rm_alloc_qp(RdmaDeviceResources *dev_res, uint32_t pd_handle,
>>                       uint8_t qp_type, uint32_t max_send_wr,
>>                       uint32_t max_send_sge, uint32_t send_cq_handle,
>>                       uint32_t max_recv_wr, uint32_t max_recv_sge,
>> -                     uint32_t recv_cq_handle, void *opaque, uint32_t *qpn)
>> +                     uint32_t recv_cq_handle, void *opaque, uint32_t *qpn,
>> +                     uint8_t is_srq, uint32_t srq_handle)
>>  {
>>      int rc;
>>      RdmaRmQP *qp;
>>      RdmaRmCQ *scq, *rcq;
>>      RdmaRmPD *pd;
>> +    RdmaRmSRQ *srq = NULL;
>>      uint32_t rm_qpn;
>>  
>>      pd = rdma_rm_get_pd(dev_res, pd_handle);
>> @@ -406,6 +408,14 @@ int rdma_rm_alloc_qp(RdmaDeviceResources *dev_res, uint32_t pd_handle,
>>          return -EINVAL;
>>      }
>>  
>> +    if (is_srq) {
>> +        srq = rdma_rm_get_srq(dev_res, srq_handle);
>> +        if (!srq) {
>> +            rdma_error_report("Invalid srqn %d", srq_handle);
>> +            return -EINVAL;
>> +        }
>> +    }
>> +
> 
> [1]
> 
>>      if (qp_type == IBV_QPT_GSI) {
>>          scq->notify = CNT_SET;
>>          rcq->notify = CNT_SET;
>> @@ -422,10 +432,17 @@ int rdma_rm_alloc_qp(RdmaDeviceResources *dev_res, uint32_t pd_handle,
>>      qp->send_cq_handle = send_cq_handle;
>>      qp->recv_cq_handle = recv_cq_handle;
>>      qp->opaque = opaque;
>> +    if (is_srq) {
>> +        qp->is_srq = is_srq;
>> +        srq->recv_cq_handle = recv_cq_handle;
>> +    }
> 
> Does it make sense to join this section with [1]?

I think that you are right, I'll fix it in v3.

> 
>>  
>>      rc = rdma_backend_create_qp(&qp->backend_qp, qp_type, &pd->backend_pd,
>> -                                &scq->backend_cq, &rcq->backend_cq, max_send_wr,
>> -                                max_recv_wr, max_send_sge, max_recv_sge);
>> +                                &scq->backend_cq, &rcq->backend_cq,
>> +                                is_srq ? &srq->backend_srq : NULL,
>> +                                max_send_wr, max_recv_wr, max_send_sge,
>> +                                max_recv_sge);
>> +
>>      if (rc) {
>>          rc = -EIO;
>>          goto out_dealloc_qp;
>> diff --git a/hw/rdma/rdma_rm.h b/hw/rdma/rdma_rm.h
>> index e88ab95e264b..e8639909cd34 100644
>> --- a/hw/rdma/rdma_rm.h
>> +++ b/hw/rdma/rdma_rm.h
>> @@ -53,7 +53,8 @@ int rdma_rm_alloc_qp(RdmaDeviceResources *dev_res, uint32_t pd_handle,
>>                       uint8_t qp_type, uint32_t max_send_wr,
>>                       uint32_t max_send_sge, uint32_t send_cq_handle,
>>                       uint32_t max_recv_wr, uint32_t max_recv_sge,
>> -                     uint32_t recv_cq_handle, void *opaque, uint32_t *qpn);
>> +                     uint32_t recv_cq_handle, void *opaque, uint32_t *qpn,
>> +                     uint8_t is_srq, uint32_t srq_handle);
>>  RdmaRmQP *rdma_rm_get_qp(RdmaDeviceResources *dev_res, uint32_t qpn);
>>  int rdma_rm_modify_qp(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
>>                        uint32_t qp_handle, uint32_t attr_mask, uint8_t sgid_idx,
>> diff --git a/hw/rdma/rdma_rm_defs.h b/hw/rdma/rdma_rm_defs.h
>> index 2a3a409d92a0..9e992f559a8f 100644
>> --- a/hw/rdma/rdma_rm_defs.h
>> +++ b/hw/rdma/rdma_rm_defs.h
>> @@ -88,6 +88,7 @@ typedef struct RdmaRmQP {
>>      uint32_t send_cq_handle;
>>      uint32_t recv_cq_handle;
>>      enum ibv_qp_state qp_state;
>> +    uint8_t is_srq;
>>  } RdmaRmQP;
>>  
>>  typedef struct RdmaRmSRQ {
>> diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
>> index 4afcd2037db2..510062f05476 100644
>> --- a/hw/rdma/vmw/pvrdma_cmd.c
>> +++ b/hw/rdma/vmw/pvrdma_cmd.c
>> @@ -357,7 +357,7 @@ static int destroy_cq(PVRDMADev *dev, union pvrdma_cmd_req *req,
>>  static int create_qp_rings(PCIDevice *pci_dev, uint64_t pdir_dma,
>>                             PvrdmaRing **rings, uint32_t scqe, uint32_t smax_sge,
>>                             uint32_t spages, uint32_t rcqe, uint32_t rmax_sge,
>> -                           uint32_t rpages)
>> +                           uint32_t rpages, uint8_t is_srq)
>>  {
>>      uint64_t *dir = NULL, *tbl = NULL;
>>      PvrdmaRing *sr, *rr;
>> @@ -365,9 +365,14 @@ static int create_qp_rings(PCIDevice *pci_dev, uint64_t pdir_dma,
>>      char ring_name[MAX_RING_NAME_SZ];
>>      uint32_t wqe_sz;
>>  
>> -    if (!spages || spages > PVRDMA_MAX_FAST_REG_PAGES
>> -        || !rpages || rpages > PVRDMA_MAX_FAST_REG_PAGES) {
>> -        rdma_error_report("Got invalid page count for QP ring: %d, %d", spages,
>> +    if (!spages || spages > PVRDMA_MAX_FAST_REG_PAGES) {
>> +        rdma_error_report("Got invalid send page count for QP ring: %d",
>> +                          spages);
>> +        return rc;
>> +    }
>> +
>> +    if (!is_srq && (!rpages || rpages > PVRDMA_MAX_FAST_REG_PAGES)) {
>> +        rdma_error_report("Got invalid recv page count for QP ring: %d",
>>                            rpages);
>>          return rc;
>>      }
>> @@ -384,8 +389,12 @@ static int create_qp_rings(PCIDevice *pci_dev, uint64_t pdir_dma,
>>          goto out;
>>      }
>>  
>> -    sr = g_malloc(2 * sizeof(*rr));
>> -    rr = &sr[1];
>> +    if (!is_srq) {
>> +        sr = g_malloc(2 * sizeof(*rr));
>> +        rr = &sr[1];
>> +    } else {
>> +        sr = g_malloc(sizeof(*sr));
>> +    }
>>  
>>      *rings = sr;
>>  
>> @@ -407,15 +416,18 @@ static int create_qp_rings(PCIDevice *pci_dev, uint64_t pdir_dma,
>>          goto out_unmap_ring_state;
>>      }
>>  
>> -    /* Create recv ring */
>> -    rr->ring_state = &sr->ring_state[1];
>> -    wqe_sz = pow2ceil(sizeof(struct pvrdma_rq_wqe_hdr) +
>> -                      sizeof(struct pvrdma_sge) * rmax_sge - 1);
>> -    sprintf(ring_name, "qp_rring_%" PRIx64, pdir_dma);
>> -    rc = pvrdma_ring_init(rr, ring_name, pci_dev, rr->ring_state,
>> -                          rcqe, wqe_sz, (dma_addr_t *)&tbl[1 + spages], rpages);
>> -    if (rc) {
>> -        goto out_free_sr;
>> +    if (!is_srq) {
>> +        /* Create recv ring */
>> +        rr->ring_state = &sr->ring_state[1];
>> +        wqe_sz = pow2ceil(sizeof(struct pvrdma_rq_wqe_hdr) +
>> +                          sizeof(struct pvrdma_sge) * rmax_sge - 1);
>> +        sprintf(ring_name, "qp_rring_%" PRIx64, pdir_dma);
>> +        rc = pvrdma_ring_init(rr, ring_name, pci_dev, rr->ring_state,
>> +                              rcqe, wqe_sz, (dma_addr_t *)&tbl[1 + spages],
>> +                              rpages);
>> +        if (rc) {
>> +            goto out_free_sr;
>> +        }
>>      }
>>  
>>      goto out;
>> @@ -436,10 +448,12 @@ out:
>>      return rc;
>>  }
>>  
>> -static void destroy_qp_rings(PvrdmaRing *ring)
>> +static void destroy_qp_rings(PvrdmaRing *ring, uint8_t is_srq)
>>  {
>>      pvrdma_ring_free(&ring[0]);
>> -    pvrdma_ring_free(&ring[1]);
>> +    if (!is_srq) {
>> +        pvrdma_ring_free(&ring[1]);
>> +    }
>>  
>>      rdma_pci_dma_unmap(ring->dev, ring->ring_state, TARGET_PAGE_SIZE);
>>      g_free(ring);
>> @@ -458,7 +472,7 @@ static int create_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
>>      rc = create_qp_rings(PCI_DEVICE(dev), cmd->pdir_dma, &rings,
>>                           cmd->max_send_wr, cmd->max_send_sge, cmd->send_chunks,
>>                           cmd->max_recv_wr, cmd->max_recv_sge,
>> -                         cmd->total_chunks - cmd->send_chunks - 1);
>> +                         cmd->total_chunks - cmd->send_chunks - 1, cmd->is_srq);
>>      if (rc) {
>>          return rc;
>>      }
>> @@ -467,9 +481,9 @@ static int create_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
>>                            cmd->max_send_wr, cmd->max_send_sge,
>>                            cmd->send_cq_handle, cmd->max_recv_wr,
>>                            cmd->max_recv_sge, cmd->recv_cq_handle, rings,
>> -                          &resp->qpn);
>> +                          &resp->qpn, cmd->is_srq, cmd->srq_handle);
>>      if (rc) {
>> -        destroy_qp_rings(rings);
>> +        destroy_qp_rings(rings, cmd->is_srq);
>>          return rc;
>>      }
>>  
>> @@ -525,16 +539,21 @@ static int destroy_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
>>      struct pvrdma_cmd_destroy_qp *cmd = &req->destroy_qp;
>>      RdmaRmQP *qp;
>>      PvrdmaRing *ring;
>> +    uint8_t is_srq = 0;
>>  
>>      qp = rdma_rm_get_qp(&dev->rdma_dev_res, cmd->qp_handle);
>>      if (!qp) {
>>          return -EINVAL;
>>      }
>>  
>> +    if (qp->is_srq) {
>> +        is_srq = 1;
>> +    }
>> +
> 
> [1]
> 
>>      rdma_rm_dealloc_qp(&dev->rdma_dev_res, cmd->qp_handle);
> 
> [2]
> 
>>  
>>      ring = (PvrdmaRing *)qp->opaque;
> 
> [3]
> 
>> -    destroy_qp_rings(ring);
>> +    destroy_qp_rings(ring, is_srq);
> 
> Better move the call to rdma_rm_dealloc_qp ([2]) to here and get rid of the
> block in [1].
> 
> In any case, the code in [3] looks like a bug to me (an existing bug), i.e.
> qp pointer cannot be trusted after call to rdma_rm_dealloc_qp (use after
> free).
> What do you think?

You are right, I'll rearrange the code in v3.

> 
>>  
>>      return 0;
>>  }
>> -- 
>> 2.20.1
>>
>>
