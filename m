Received: from eggs.gnu.org ([209.51.188.92]:37697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kamalheib1@gmail.com>) id 1hAqLP-0006FP-8B
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 02:22:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kamalheib1@gmail.com>) id 1hAqLO-0003Sx-1B
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 02:22:55 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37806)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kamalheib1@gmail.com>)
	id 1hAqLN-0003SZ-Lm
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 02:22:53 -0400
Received: by mail-wr1-x441.google.com with SMTP id w10so10275896wrm.4
	for <qemu-devel@nongnu.org>; Sun, 31 Mar 2019 23:22:53 -0700 (PDT)
References: <20190326125433.475-1-kamalheib1@gmail.com>
	<20190326125433.475-3-kamalheib1@gmail.com>
	<20190327160330.GC10207@lap1>
From: Kamal Heib <kamalheib1@gmail.com>
Message-ID: <86f0f2bd-a8a5-045e-da58-e694fd2f92a9@gmail.com>
Date: Mon, 1 Apr 2019 09:22:49 +0300
MIME-Version: 1.0
In-Reply-To: <20190327160330.GC10207@lap1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/4] hw/rdma: Add support for managing
 SRQ resource
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



On 3/27/19 6:03 PM, Yuval Shaia wrote:
> On Tue, Mar 26, 2019 at 02:54:31PM +0200, Kamal Heib wrote:
>> Adding the required functions and definitions for support managing the
>> shared receive queues (SRQs).
>>
>> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
>> ---
>>  hw/rdma/rdma_rm.c      | 83 ++++++++++++++++++++++++++++++++++++++++++
>>  hw/rdma/rdma_rm.h      | 10 +++++
>>  hw/rdma/rdma_rm_defs.h |  8 ++++
>>  3 files changed, 101 insertions(+)
>>
>> diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
>> index bac3b2f4a6c3..bc5873cb4c14 100644
>> --- a/hw/rdma/rdma_rm.c
>> +++ b/hw/rdma/rdma_rm.c
>> @@ -542,6 +542,86 @@ void rdma_rm_dealloc_qp(RdmaDeviceResources *dev_res, uint32_t qp_handle)
>>      rdma_res_tbl_dealloc(&dev_res->qp_tbl, qp->qpn);
>>  }
>>  
>> +RdmaRmSRQ *rdma_rm_get_srq(RdmaDeviceResources *dev_res, uint32_t srq_handle)
>> +{
>> +    return rdma_res_tbl_get(&dev_res->srq_tbl, srq_handle);
>> +}
>> +
>> +int rdma_rm_alloc_srq(RdmaDeviceResources *dev_res, uint32_t pd_handle,
>> +                      uint32_t max_wr, uint32_t max_sge, uint32_t srq_limit,
>> +                      uint32_t *srq_handle, void *opaque)
>> +{
>> +    RdmaRmSRQ *srq;
>> +    RdmaRmPD *pd;
>> +    int rc;
>> +
>> +    pd = rdma_rm_get_pd(dev_res, pd_handle);
>> +    if (!pd) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    srq = rdma_res_tbl_alloc(&dev_res->srq_tbl, srq_handle);
>> +    if (!srq) {
>> +        return -ENOMEM;
>> +    }
>> +
>> +    rc = rdma_backend_create_srq(&srq->backend_srq, &pd->backend_pd,
>> +                                 max_wr, max_sge, srq_limit);
>> +    if (rc) {
>> +        rc = -EIO;
>> +        goto out_dealloc_srq;
>> +    }
>> +
>> +    srq->opaque = opaque;
>> +
>> +    return 0;
>> +
>> +out_dealloc_srq:
>> +    rdma_res_tbl_dealloc(&dev_res->srq_tbl, *srq_handle);
>> +
>> +    return rc;
>> +}
>> +
>> +int rdma_rm_query_srq(RdmaDeviceResources *dev_res, uint32_t srq_handle,
>> +                      struct ibv_srq_attr *srq_attr)
>> +{
>> +    RdmaRmSRQ *srq;
>> +
>> +    srq = rdma_rm_get_srq(dev_res, srq_handle);
>> +    if (!srq) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    return rdma_backend_query_srq(&srq->backend_srq, srq_attr);
>> +}
>> +
>> +int rdma_rm_modify_srq(RdmaDeviceResources *dev_res, uint32_t srq_handle,
>> +                       struct ibv_srq_attr *srq_attr, int srq_attr_mask)
>> +{
>> +    RdmaRmSRQ *srq;
>> +
>> +    srq = rdma_rm_get_srq(dev_res, srq_handle);
>> +    if (!srq) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    return rdma_backend_modify_srq(&srq->backend_srq, srq_attr,
>> +                                   srq_attr_mask);
> 
> Such a blind pass-through?? don't you want to make sure that for example
> max_sge is valid? I mean just for the sake of being fair to caller?
> 

I agree, I'll fix it in v3.

>> +}
>> +
>> +void rdma_rm_dealloc_srq(RdmaDeviceResources *dev_res, uint32_t srq_handle)
>> +{
>> +    RdmaRmSRQ *srq;
>> +
>> +    srq = rdma_rm_get_srq(dev_res, srq_handle);
>> +    if (!srq) {
>> +        return;
>> +    }
>> +
>> +    rdma_backend_destroy_srq(&srq->backend_srq, dev_res);
>> +    rdma_res_tbl_dealloc(&dev_res->srq_tbl, srq_handle);
>> +}
>> +
>>  void *rdma_rm_get_cqe_ctx(RdmaDeviceResources *dev_res, uint32_t cqe_ctx_id)
>>  {
>>      void **cqe_ctx;
>> @@ -671,6 +751,8 @@ int rdma_rm_init(RdmaDeviceResources *dev_res, struct ibv_device_attr *dev_attr)
>>      res_tbl_init("CQE_CTX", &dev_res->cqe_ctx_tbl, dev_attr->max_qp *
>>                         dev_attr->max_qp_wr, sizeof(void *));
>>      res_tbl_init("UC", &dev_res->uc_tbl, MAX_UCS, sizeof(RdmaRmUC));
>> +    res_tbl_init("SRQ", &dev_res->srq_tbl, dev_attr->max_srq,
>> +                 sizeof(RdmaRmSRQ));
>>  
>>      init_ports(dev_res);
>>  
>> @@ -689,6 +771,7 @@ void rdma_rm_fini(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
>>  
>>      fini_ports(dev_res, backend_dev, ifname);
>>  
>> +    res_tbl_free(&dev_res->srq_tbl);
>>      res_tbl_free(&dev_res->uc_tbl);
>>      res_tbl_free(&dev_res->cqe_ctx_tbl);
>>      res_tbl_free(&dev_res->qp_tbl);
>> diff --git a/hw/rdma/rdma_rm.h b/hw/rdma/rdma_rm.h
>> index 4f03f9b8c5f1..e88ab95e264b 100644
>> --- a/hw/rdma/rdma_rm.h
>> +++ b/hw/rdma/rdma_rm.h
>> @@ -65,6 +65,16 @@ int rdma_rm_query_qp(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
>>                       int attr_mask, struct ibv_qp_init_attr *init_attr);
>>  void rdma_rm_dealloc_qp(RdmaDeviceResources *dev_res, uint32_t qp_handle);
>>  
>> +RdmaRmSRQ *rdma_rm_get_srq(RdmaDeviceResources *dev_res, uint32_t srq_handle);
>> +int rdma_rm_alloc_srq(RdmaDeviceResources *dev_res, uint32_t pd_handle,
>> +                      uint32_t max_wr, uint32_t max_sge, uint32_t srq_limit,
>> +                      uint32_t *srq_handle, void *opaque);
>> +int rdma_rm_query_srq(RdmaDeviceResources *dev_res, uint32_t srq_handle,
>> +                      struct ibv_srq_attr *srq_attr);
>> +int rdma_rm_modify_srq(RdmaDeviceResources *dev_res, uint32_t srq_handle,
>> +                       struct ibv_srq_attr *srq_attr, int srq_attr_mask);
>> +void rdma_rm_dealloc_srq(RdmaDeviceResources *dev_res, uint32_t srq_handle);
>> +
>>  int rdma_rm_alloc_cqe_ctx(RdmaDeviceResources *dev_res, uint32_t *cqe_ctx_id,
>>                            void *ctx);
>>  void *rdma_rm_get_cqe_ctx(RdmaDeviceResources *dev_res, uint32_t cqe_ctx_id);
>> diff --git a/hw/rdma/rdma_rm_defs.h b/hw/rdma/rdma_rm_defs.h
>> index c200d311de37..2a3a409d92a0 100644
>> --- a/hw/rdma/rdma_rm_defs.h
>> +++ b/hw/rdma/rdma_rm_defs.h
>> @@ -33,6 +33,7 @@
>>  #define MAX_QP_RD_ATOM        16
>>  #define MAX_QP_INIT_RD_ATOM   16
>>  #define MAX_AH                64
>> +#define MAX_SRQ               512
>>  
>>  #define MAX_RM_TBL_NAME             16
>>  #define MAX_CONSEQ_EMPTY_POLL_CQ    4096 /* considered as error above this */
>> @@ -89,6 +90,12 @@ typedef struct RdmaRmQP {
>>      enum ibv_qp_state qp_state;
>>  } RdmaRmQP;
>>  
>> +typedef struct RdmaRmSRQ {
>> +    RdmaBackendSRQ backend_srq;
>> +    uint32_t recv_cq_handle;
>> +    void *opaque;
>> +} RdmaRmSRQ;
>> +
>>  typedef struct RdmaRmGid {
>>      union ibv_gid gid;
>>      int backend_gid_index;
>> @@ -128,6 +135,7 @@ struct RdmaDeviceResources {
>>      RdmaRmResTbl qp_tbl;
>>      RdmaRmResTbl cq_tbl;
>>      RdmaRmResTbl cqe_ctx_tbl;
>> +    RdmaRmResTbl srq_tbl;
>>      GHashTable *qp_hash; /* Keeps mapping between real and emulated */
>>      QemuMutex lock;
>>      RdmaRmStats stats;
>> -- 
>> 2.20.1
>>
>>
