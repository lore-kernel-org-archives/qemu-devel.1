Received: from eggs.gnu.org ([209.51.188.92]:37305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kamalheib1@gmail.com>) id 1hAqJ9-0004tW-CW
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 02:20:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kamalheib1@gmail.com>) id 1hAqJ7-00025E-SM
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 02:20:35 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51575)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kamalheib1@gmail.com>)
	id 1hAqJ7-00023Y-BZ
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 02:20:33 -0400
Received: by mail-wm1-x343.google.com with SMTP id 4so8947399wmf.1
	for <qemu-devel@nongnu.org>; Sun, 31 Mar 2019 23:20:32 -0700 (PDT)
References: <20190326125433.475-1-kamalheib1@gmail.com>
	<20190326125433.475-2-kamalheib1@gmail.com>
	<20190327064431.GA3398@lap1>
From: Kamal Heib <kamalheib1@gmail.com>
Message-ID: <0622d7d6-be8a-6536-2687-920506c607c8@gmail.com>
Date: Mon, 1 Apr 2019 09:20:26 +0300
MIME-Version: 1.0
In-Reply-To: <20190327064431.GA3398@lap1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/4] hw/rdma: Add SRQ support to backend
 layer
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



On 3/27/19 8:44 AM, Yuval Shaia wrote:
> On Tue, Mar 26, 2019 at 02:54:30PM +0200, Kamal Heib wrote:
>> Add the required function and definitions for support shared receive
> 
> s/function/functions
> s/for/to (but not sure about that though)
>


OK, I'll fix it in v3.

>> queues (SRQs) in the backend layer.
>>
>> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
>> ---
>>  hw/rdma/rdma_backend.c      | 116 +++++++++++++++++++++++++++++++++++-
>>  hw/rdma/rdma_backend.h      |  12 ++++
>>  hw/rdma/rdma_backend_defs.h |   5 ++
>>  3 files changed, 131 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
>> index d1660b6474fa..54419c8c58dd 100644
>> --- a/hw/rdma/rdma_backend.c
>> +++ b/hw/rdma/rdma_backend.c
>> @@ -40,6 +40,7 @@ typedef struct BackendCtx {
>>      void *up_ctx;
>>      struct ibv_sge sge; /* Used to save MAD recv buffer */
>>      RdmaBackendQP *backend_qp; /* To maintain recv buffers */
>> +    RdmaBackendSRQ *backend_srq;
>>  } BackendCtx;
>>  
>>  struct backend_umad {
>> @@ -99,6 +100,7 @@ static int rdma_poll_cq(RdmaDeviceResources *rdma_dev_res, struct ibv_cq *ibcq)
>>      int i, ne, total_ne = 0;
>>      BackendCtx *bctx;
>>      struct ibv_wc wc[2];
>> +    RdmaProtectedGSList *cqe_ctx_list;
>>  
>>      qemu_mutex_lock(&rdma_dev_res->lock);
>>      do {
>> @@ -116,8 +118,13 @@ static int rdma_poll_cq(RdmaDeviceResources *rdma_dev_res, struct ibv_cq *ibcq)
>>  
>>              comp_handler(bctx->up_ctx, &wc[i]);
>>  
>> -            rdma_protected_gslist_remove_int32(&bctx->backend_qp->cqe_ctx_list,
>> -                                               wc[i].wr_id);
>> +            if (bctx->backend_qp) {
>> +                cqe_ctx_list = &bctx->backend_qp->cqe_ctx_list;
>> +            } else {
>> +                cqe_ctx_list = &bctx->backend_srq->cqe_ctx_list;
>> +            }
>> +
>> +            rdma_protected_gslist_remove_int32(cqe_ctx_list, wc[i].wr_id);
>>              rdma_rm_dealloc_cqe_ctx(rdma_dev_res, wc[i].wr_id);
>>              g_free(bctx);
>>          }
>> @@ -662,6 +669,60 @@ err_free_bctx:
>>      g_free(bctx);
>>  }
>>  
>> +void rdma_backend_post_srq_recv(RdmaBackendDev *backend_dev,
>> +                                RdmaBackendSRQ *srq, struct ibv_sge *sge,
>> +                                uint32_t num_sge, void *ctx)
>> +{
>> +    BackendCtx *bctx;
>> +    struct ibv_sge new_sge[MAX_SGE];
>> +    uint32_t bctx_id;
>> +    int rc;
>> +    struct ibv_recv_wr wr = {}, *bad_wr;
>> +
>> +    bctx = g_malloc0(sizeof(*bctx));
>> +    bctx->up_ctx = ctx;
>> +    bctx->backend_srq = srq;
>> +    bctx->backend_qp = NULL;
> 
> g_malloc0 takes care for this (otherwise expecting your touch in
> rdma_backend_post_recv and rdma_backend_post_send)

You are right, I'll fix it in v3.

> 
>> +
>> +    rc = rdma_rm_alloc_cqe_ctx(backend_dev->rdma_dev_res, &bctx_id, bctx);
>> +    if (unlikely(rc)) {
>> +        complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_NOMEM, ctx);
>> +        goto err_free_bctx;
>> +    }
>> +
>> +    rdma_protected_gslist_append_int32(&srq->cqe_ctx_list, bctx_id);
>> +
>> +    rc = build_host_sge_array(backend_dev->rdma_dev_res, new_sge, sge, num_sge,
>> +                              &backend_dev->rdma_dev_res->stats.rx_bufs_len);
>> +    if (rc) {
>> +        complete_work(IBV_WC_GENERAL_ERR, rc, ctx);
>> +        goto err_dealloc_cqe_ctx;
>> +    }
>> +
>> +    wr.num_sge = num_sge;
>> +    wr.sg_list = new_sge;
>> +    wr.wr_id = bctx_id;
>> +    rc = ibv_post_srq_recv(srq->ibsrq, &wr, &bad_wr);
>> +    if (rc) {
>> +        rdma_error_report("ibv_post_srq_recv fail, srqn=0x%x, rc=%d, errno=%d",
>> +                          srq->ibsrq->handle, rc, errno);
>> +        complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_FAIL_BACKEND, ctx);
>> +        goto err_dealloc_cqe_ctx;
>> +    }
>> +
>> +    atomic_inc(&backend_dev->rdma_dev_res->stats.missing_cqe);
>> +    backend_dev->rdma_dev_res->stats.rx_bufs++;
> 
> Suggesting to maintain a dedicated counter for srq_rx, what do you think?
> 

Probably need to maintain both, I mean add a dedicated counter for srq_rx and
and maintain the existing rx_bufs, because the rx_buf is very generic.

>> +
>> +    return;
>> +
>> +err_dealloc_cqe_ctx:
>> +    backend_dev->rdma_dev_res->stats.rx_bufs_err++;
>> +    rdma_rm_dealloc_cqe_ctx(backend_dev->rdma_dev_res, bctx_id);
>> +
>> +err_free_bctx:
>> +    g_free(bctx);
>> +}
>> +
>>  int rdma_backend_create_pd(RdmaBackendDev *backend_dev, RdmaBackendPD *pd)
>>  {
>>      pd->ibpd = ibv_alloc_pd(backend_dev->context);
>> @@ -938,6 +999,55 @@ void rdma_backend_destroy_qp(RdmaBackendQP *qp, RdmaDeviceResources *dev_res)
>>      rdma_protected_gslist_destroy(&qp->cqe_ctx_list);
>>  }
>>  
>> +int rdma_backend_create_srq(RdmaBackendSRQ *srq, RdmaBackendPD *pd,
>> +                            uint32_t max_wr, uint32_t max_sge,
>> +                            uint32_t srq_limit)
>> +{
>> +    struct ibv_srq_init_attr srq_init_attr = {};
>> +
>> +    srq_init_attr.attr.max_wr = max_wr;
>> +    srq_init_attr.attr.max_sge = max_sge;
>> +    srq_init_attr.attr.srq_limit = srq_limit;
>> +
>> +    srq->ibsrq = ibv_create_srq(pd->ibpd, &srq_init_attr);
>> +    if (!srq->ibsrq) {
>> +        rdma_error_report("ibv_create_srq failed, errno=%d", errno);
>> +        return -EIO;
>> +    }
>> +
>> +    rdma_protected_gslist_init(&srq->cqe_ctx_list);
>> +
>> +    return 0;
>> +}
>> +
>> +int rdma_backend_query_srq(RdmaBackendSRQ *srq, struct ibv_srq_attr *srq_attr)
>> +{
>> +    if (!srq->ibsrq) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    return ibv_query_srq(srq->ibsrq, srq_attr);
>> +}
>> +
>> +int rdma_backend_modify_srq(RdmaBackendSRQ *srq, struct ibv_srq_attr *srq_attr,
>> +                int srq_attr_mask)
>> +{
>> +    if (!srq->ibsrq) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    return ibv_modify_srq(srq->ibsrq, srq_attr, srq_attr_mask);
>> +}
>> +
>> +void rdma_backend_destroy_srq(RdmaBackendSRQ *srq, RdmaDeviceResources *dev_res)
>> +{
>> +    if (srq->ibsrq) {
>> +        ibv_destroy_srq(srq->ibsrq);
>> +    }
>> +    g_slist_foreach(srq->cqe_ctx_list.list, free_cqe_ctx, dev_res);
>> +    rdma_protected_gslist_destroy(&srq->cqe_ctx_list);
>> +}
>> +
>>  #define CHK_ATTR(req, dev, member, fmt) ({ \
>>      trace_rdma_check_dev_attr(#member, dev.member, req->member); \
>>      if (req->member > dev.member) { \
>> @@ -960,6 +1070,7 @@ static int init_device_caps(RdmaBackendDev *backend_dev,
>>      }
>>  
>>      dev_attr->max_sge = MAX_SGE;
>> +    dev_attr->max_srq_sge = MAX_SGE;
>>  
>>      CHK_ATTR(dev_attr, bk_dev_attr, max_mr_size, "%" PRId64);
>>      CHK_ATTR(dev_attr, bk_dev_attr, max_qp, "%d");
>> @@ -970,6 +1081,7 @@ static int init_device_caps(RdmaBackendDev *backend_dev,
>>      CHK_ATTR(dev_attr, bk_dev_attr, max_qp_rd_atom, "%d");
>>      CHK_ATTR(dev_attr, bk_dev_attr, max_qp_init_rd_atom, "%d");
>>      CHK_ATTR(dev_attr, bk_dev_attr, max_ah, "%d");
>> +    CHK_ATTR(dev_attr, bk_dev_attr, max_srq, "%d");
>>  
>>      return 0;
>>  }
>> diff --git a/hw/rdma/rdma_backend.h b/hw/rdma/rdma_backend.h
>> index 38056d97c7fc..cad7956d98e8 100644
>> --- a/hw/rdma/rdma_backend.h
>> +++ b/hw/rdma/rdma_backend.h
>> @@ -114,4 +114,16 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
>>                              RdmaBackendQP *qp, uint8_t qp_type,
>>                              struct ibv_sge *sge, uint32_t num_sge, void *ctx);
>>  
>> +int rdma_backend_create_srq(RdmaBackendSRQ *srq, RdmaBackendPD *pd,
>> +                            uint32_t max_wr, uint32_t max_sge,
>> +                            uint32_t srq_limit);
>> +int rdma_backend_query_srq(RdmaBackendSRQ *srq, struct ibv_srq_attr *srq_attr);
>> +int rdma_backend_modify_srq(RdmaBackendSRQ *srq, struct ibv_srq_attr *srq_attr,
>> +                            int srq_attr_mask);
>> +void rdma_backend_destroy_srq(RdmaBackendSRQ *srq,
>> +                              RdmaDeviceResources *dev_res);
>> +void rdma_backend_post_srq_recv(RdmaBackendDev *backend_dev,
>> +                                RdmaBackendSRQ *srq, struct ibv_sge *sge,
>> +                                uint32_t num_sge, void *ctx);
>> +
>>  #endif
>> diff --git a/hw/rdma/rdma_backend_defs.h b/hw/rdma/rdma_backend_defs.h
>> index 817153dc8cf4..0b55be35038d 100644
>> --- a/hw/rdma/rdma_backend_defs.h
>> +++ b/hw/rdma/rdma_backend_defs.h
>> @@ -68,4 +68,9 @@ typedef struct RdmaBackendQP {
>>      RdmaProtectedGSList cqe_ctx_list;
>>  } RdmaBackendQP;
>>  
>> +typedef struct RdmaBackendSRQ {
>> +    struct ibv_srq *ibsrq;
>> +    RdmaProtectedGSList cqe_ctx_list;
>> +} RdmaBackendSRQ;
>> +
>>  #endif
>> -- 
>> 2.20.1
>>
>>
