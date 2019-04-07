Return-Path: <SRS0=0TSG=SJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E2CC10F0E
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2019 09:14:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EFDD20B1F
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2019 09:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="q/gomk+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EFDD20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36349 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hD3sk-0007XR-HC
	for qemu-devel@archiver.kernel.org; Sun, 07 Apr 2019 05:14:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hD3rq-0007E1-K7
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 05:13:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hD3rp-0006T0-4p
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 05:13:34 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:42098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1hD3ro-0006Rx-OL
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 05:13:33 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3797AEQ059946; Sun, 7 Apr 2019 09:13:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=date : from : to : cc
	: subject : message-id : references : mime-version : content-type :
	in-reply-to; s=corp-2018-07-02;
	bh=swJGVvguKj5cTD5lJ5ajSH4lsdW7ru1PqEcdgnSKS4Q=;
	b=q/gomk+OPkrv+u99CnivEFdBPSv9aWIP+nXo8NqnwcgIbK6V19lxvm0suR3MyAS99mLa
	u3ySx4x84H/okjI65ZyD2Kv7mtBp6mhbS5+CH12Fb6Sa+huThh1xMOUf8QlSEygs0Ogn
	eH03YIP0i/K1QtotzVTSrulMgiBrR/H0vpjbGuzGNSGIP7Clft4JrEpZl7TmsCmSftr6
	6oSdDwTTQllEresy8EckFh70wZkJT7DTu2gTZDSCqHuUIxzuQeptnILyR5AQa2vQDN1f
	V2sRAbvjYREe5K4/FZcLo+VsiXucaGfsEoGy+3y7wSdF7nIqTWXPkvWkzsd21p+nYl6r
	lg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by aserp2130.oracle.com with ESMTP id 2rphme2k2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 07 Apr 2019 09:13:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x379DRLv182652; Sun, 7 Apr 2019 09:13:27 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserp3030.oracle.com with ESMTP id 2rpj59km68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 07 Apr 2019 09:13:23 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x379DLip024652;
	Sun, 7 Apr 2019 09:13:22 GMT
Received: from lap1 (/10.175.45.87) by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Sun, 07 Apr 2019 09:13:21 +0000
Date: Sun, 7 Apr 2019 12:13:14 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
To: Kamal Heib <kamalheib1@gmail.com>
Message-ID: <20190407091313.GA6737@lap1>
References: <20190403113343.26384-1-kamalheib1@gmail.com>
	<20190403113343.26384-2-kamalheib1@gmail.com>
	<20190403180522.GA3446@lap1>
	<7acea8a2-36a1-c9aa-1467-2be7a2f5f3f0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <7acea8a2-36a1-c9aa-1467-2be7a2f5f3f0@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9219
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1904070086
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9219
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1904070086
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.79
Subject: Re: [Qemu-devel] [PATCH v3 1/4] hw/rdma: Add SRQ support to backend
 layer
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190407091314.9DKKwZ_lMS3qIzGCi5b_a0KaanWhU_XiH1B-mBVfyLo@z>

On Sun, Apr 07, 2019 at 11:13:15AM +0300, Kamal Heib wrote:
> 
> 
> On 4/3/19 9:05 PM, Yuval Shaia wrote:
> > On Wed, Apr 03, 2019 at 02:33:40PM +0300, Kamal Heib wrote:
> >> Add the required functions and definitions to support shared receive
> >> queues (SRQs) in the backend layer.
> >>
> >> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> >> ---
> >>  hw/rdma/rdma_backend.c      | 116 +++++++++++++++++++++++++++++++++++-
> >>  hw/rdma/rdma_backend.h      |  12 ++++
> >>  hw/rdma/rdma_backend_defs.h |   5 ++
> >>  hw/rdma/rdma_rm.c           |   2 +
> >>  hw/rdma/rdma_rm_defs.h      |   1 +
> >>  5 files changed, 134 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
> >> index d1660b6474fa..04dfd63a573b 100644
> >> --- a/hw/rdma/rdma_backend.c
> >> +++ b/hw/rdma/rdma_backend.c
> >> @@ -40,6 +40,7 @@ typedef struct BackendCtx {
> >>      void *up_ctx;
> >>      struct ibv_sge sge; /* Used to save MAD recv buffer */
> >>      RdmaBackendQP *backend_qp; /* To maintain recv buffers */
> >> +    RdmaBackendSRQ *backend_srq;
> >>  } BackendCtx;
> >>  
> >>  struct backend_umad {
> >> @@ -99,6 +100,7 @@ static int rdma_poll_cq(RdmaDeviceResources *rdma_dev_res, struct ibv_cq *ibcq)
> >>      int i, ne, total_ne = 0;
> >>      BackendCtx *bctx;
> >>      struct ibv_wc wc[2];
> >> +    RdmaProtectedGSList *cqe_ctx_list;
> >>  
> >>      qemu_mutex_lock(&rdma_dev_res->lock);
> >>      do {
> >> @@ -116,8 +118,13 @@ static int rdma_poll_cq(RdmaDeviceResources *rdma_dev_res, struct ibv_cq *ibcq)
> >>  
> >>              comp_handler(bctx->up_ctx, &wc[i]);
> >>  
> >> -            rdma_protected_gslist_remove_int32(&bctx->backend_qp->cqe_ctx_list,
> >> -                                               wc[i].wr_id);
> >> +            if (bctx->backend_qp) {
> >> +                cqe_ctx_list = &bctx->backend_qp->cqe_ctx_list;
> >> +            } else {
> >> +                cqe_ctx_list = &bctx->backend_srq->cqe_ctx_list;
> >> +            }
> >> +
> >> +            rdma_protected_gslist_remove_int32(cqe_ctx_list, wc[i].wr_id);
> >>              rdma_rm_dealloc_cqe_ctx(rdma_dev_res, wc[i].wr_id);
> >>              g_free(bctx);
> >>          }
> >> @@ -662,6 +669,60 @@ err_free_bctx:
> >>      g_free(bctx);
> >>  }
> >>  
> >> +void rdma_backend_post_srq_recv(RdmaBackendDev *backend_dev,
> >> +                                RdmaBackendSRQ *srq, struct ibv_sge *sge,
> >> +                                uint32_t num_sge, void *ctx)
> >> +{
> >> +    BackendCtx *bctx;
> >> +    struct ibv_sge new_sge[MAX_SGE];
> >> +    uint32_t bctx_id;
> >> +    int rc;
> >> +    struct ibv_recv_wr wr = {}, *bad_wr;
> >> +
> >> +    bctx = g_malloc0(sizeof(*bctx));
> >> +    bctx->up_ctx = ctx;
> >> +    bctx->backend_srq = srq;
> >> +
> >> +    rc = rdma_rm_alloc_cqe_ctx(backend_dev->rdma_dev_res, &bctx_id, bctx);
> >> +    if (unlikely(rc)) {
> >> +        complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_NOMEM, ctx);
> >> +        goto err_free_bctx;
> >> +    }
> >> +
> >> +    rdma_protected_gslist_append_int32(&srq->cqe_ctx_list, bctx_id);
> >> +
> >> +    rc = build_host_sge_array(backend_dev->rdma_dev_res, new_sge, sge, num_sge,
> >> +                              &backend_dev->rdma_dev_res->stats.rx_bufs_len);
> >> +    if (rc) {
> >> +        complete_work(IBV_WC_GENERAL_ERR, rc, ctx);
> >> +        goto err_dealloc_cqe_ctx;
> >> +    }
> >> +
> >> +    wr.num_sge = num_sge;
> >> +    wr.sg_list = new_sge;
> >> +    wr.wr_id = bctx_id;
> >> +    rc = ibv_post_srq_recv(srq->ibsrq, &wr, &bad_wr);
> >> +    if (rc) {
> >> +        rdma_error_report("ibv_post_srq_recv fail, srqn=0x%x, rc=%d, errno=%d",
> >> +                          srq->ibsrq->handle, rc, errno);
> >> +        complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_FAIL_BACKEND, ctx);
> >> +        goto err_dealloc_cqe_ctx;
> >> +    }
> >> +
> >> +    atomic_inc(&backend_dev->rdma_dev_res->stats.missing_cqe);
> >> +    backend_dev->rdma_dev_res->stats.rx_bufs++;
> >> +    backend_dev->rdma_dev_res->stats.rx_srq++;
> > 
> > You should update function rdma_dump_device_counters with this new
> > counter.
> > 
> >> +
> >> +    return;
> >> +
> >> +err_dealloc_cqe_ctx:
> >> +    backend_dev->rdma_dev_res->stats.rx_bufs_err++;
> >> +    rdma_rm_dealloc_cqe_ctx(backend_dev->rdma_dev_res, bctx_id);
> >> +
> >> +err_free_bctx:
> >> +    g_free(bctx);
> >> +}
> >> +
> >>  int rdma_backend_create_pd(RdmaBackendDev *backend_dev, RdmaBackendPD *pd)
> >>  {
> >>      pd->ibpd = ibv_alloc_pd(backend_dev->context);
> >> @@ -938,6 +999,55 @@ void rdma_backend_destroy_qp(RdmaBackendQP *qp, RdmaDeviceResources *dev_res)
> >>      rdma_protected_gslist_destroy(&qp->cqe_ctx_list);
> >>  }
> >>  
> >> +int rdma_backend_create_srq(RdmaBackendSRQ *srq, RdmaBackendPD *pd,
> >> +                            uint32_t max_wr, uint32_t max_sge,
> >> +                            uint32_t srq_limit)
> >> +{
> >> +    struct ibv_srq_init_attr srq_init_attr = {};
> >> +
> >> +    srq_init_attr.attr.max_wr = max_wr;
> >> +    srq_init_attr.attr.max_sge = max_sge;
> >> +    srq_init_attr.attr.srq_limit = srq_limit;
> >> +
> >> +    srq->ibsrq = ibv_create_srq(pd->ibpd, &srq_init_attr);
> >> +    if (!srq->ibsrq) {
> >> +        rdma_error_report("ibv_create_srq failed, errno=%d", errno);
> >> +        return -EIO;
> >> +    }
> >> +
> >> +    rdma_protected_gslist_init(&srq->cqe_ctx_list);
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +int rdma_backend_query_srq(RdmaBackendSRQ *srq, struct ibv_srq_attr *srq_attr)
> >> +{
> >> +    if (!srq->ibsrq) {
> >> +        return -EINVAL;
> >> +    }
> >> +
> >> +    return ibv_query_srq(srq->ibsrq, srq_attr);
> >> +}
> >> +
> >> +int rdma_backend_modify_srq(RdmaBackendSRQ *srq, struct ibv_srq_attr *srq_attr,
> >> +                int srq_attr_mask)
> >> +{
> >> +    if (!srq->ibsrq) {
> >> +        return -EINVAL;
> >> +    }
> >> +
> >> +    return ibv_modify_srq(srq->ibsrq, srq_attr, srq_attr_mask);
> >> +}
> >> +
> >> +void rdma_backend_destroy_srq(RdmaBackendSRQ *srq, RdmaDeviceResources *dev_res)
> >> +{
> >> +    if (srq->ibsrq) {
> >> +        ibv_destroy_srq(srq->ibsrq);
> >> +    }
> >> +    g_slist_foreach(srq->cqe_ctx_list.list, free_cqe_ctx, dev_res);
> >> +    rdma_protected_gslist_destroy(&srq->cqe_ctx_list);
> >> +}
> >> +
> >>  #define CHK_ATTR(req, dev, member, fmt) ({ \
> >>      trace_rdma_check_dev_attr(#member, dev.member, req->member); \
> >>      if (req->member > dev.member) { \
> >> @@ -960,6 +1070,7 @@ static int init_device_caps(RdmaBackendDev *backend_dev,
> >>      }
> >>  
> >>      dev_attr->max_sge = MAX_SGE;
> >> +    dev_attr->max_srq_sge = MAX_SGE;
> >>  
> >>      CHK_ATTR(dev_attr, bk_dev_attr, max_mr_size, "%" PRId64);
> >>      CHK_ATTR(dev_attr, bk_dev_attr, max_qp, "%d");
> >> @@ -970,6 +1081,7 @@ static int init_device_caps(RdmaBackendDev *backend_dev,
> >>      CHK_ATTR(dev_attr, bk_dev_attr, max_qp_rd_atom, "%d");
> >>      CHK_ATTR(dev_attr, bk_dev_attr, max_qp_init_rd_atom, "%d");
> >>      CHK_ATTR(dev_attr, bk_dev_attr, max_ah, "%d");
> >> +    CHK_ATTR(dev_attr, bk_dev_attr, max_srq, "%d");
> >>  
> >>      return 0;
> >>  }
> >> diff --git a/hw/rdma/rdma_backend.h b/hw/rdma/rdma_backend.h
> >> index 38056d97c7fc..cad7956d98e8 100644
> >> --- a/hw/rdma/rdma_backend.h
> >> +++ b/hw/rdma/rdma_backend.h
> >> @@ -114,4 +114,16 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
> >>                              RdmaBackendQP *qp, uint8_t qp_type,
> >>                              struct ibv_sge *sge, uint32_t num_sge, void *ctx);
> >>  
> >> +int rdma_backend_create_srq(RdmaBackendSRQ *srq, RdmaBackendPD *pd,
> >> +                            uint32_t max_wr, uint32_t max_sge,
> >> +                            uint32_t srq_limit);
> >> +int rdma_backend_query_srq(RdmaBackendSRQ *srq, struct ibv_srq_attr *srq_attr);
> >> +int rdma_backend_modify_srq(RdmaBackendSRQ *srq, struct ibv_srq_attr *srq_attr,
> >> +                            int srq_attr_mask);
> >> +void rdma_backend_destroy_srq(RdmaBackendSRQ *srq,
> >> +                              RdmaDeviceResources *dev_res);
> >> +void rdma_backend_post_srq_recv(RdmaBackendDev *backend_dev,
> >> +                                RdmaBackendSRQ *srq, struct ibv_sge *sge,
> >> +                                uint32_t num_sge, void *ctx);
> >> +
> >>  #endif
> >> diff --git a/hw/rdma/rdma_backend_defs.h b/hw/rdma/rdma_backend_defs.h
> >> index 817153dc8cf4..0b55be35038d 100644
> >> --- a/hw/rdma/rdma_backend_defs.h
> >> +++ b/hw/rdma/rdma_backend_defs.h
> >> @@ -68,4 +68,9 @@ typedef struct RdmaBackendQP {
> >>      RdmaProtectedGSList cqe_ctx_list;
> >>  } RdmaBackendQP;
> >>  
> >> +typedef struct RdmaBackendSRQ {
> >> +    struct ibv_srq *ibsrq;
> >> +    RdmaProtectedGSList cqe_ctx_list;
> >> +} RdmaBackendSRQ;
> >> +
> >>  #endif
> >> diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
> >> index bac3b2f4a6c3..b683506b8616 100644
> >> --- a/hw/rdma/rdma_rm.c
> >> +++ b/hw/rdma/rdma_rm.c
> >> @@ -37,6 +37,8 @@ void rdma_dump_device_counters(Monitor *mon, RdmaDeviceResources *dev_res)
> >>                     dev_res->stats.tx_err);
> >>      monitor_printf(mon, "\trx_bufs          : %" PRId64 "\n",
> >>                     dev_res->stats.rx_bufs);
> >> +    monitor_printf(mon, "\trx_srq           : %" PRId64 "\n",
> >> +                   dev_res->stats.rx_srq);

[1]

> >>      monitor_printf(mon, "\trx_bufs_len      : %" PRId64 "\n",
> >>                     dev_res->stats.rx_bufs_len);
> >>      monitor_printf(mon, "\trx_bufs_err      : %" PRId64 "\n",
> >> diff --git a/hw/rdma/rdma_rm_defs.h b/hw/rdma/rdma_rm_defs.h
> >> index c200d311de37..e774af528022 100644
> >> --- a/hw/rdma/rdma_rm_defs.h
> >> +++ b/hw/rdma/rdma_rm_defs.h
> >> @@ -106,6 +106,7 @@ typedef struct RdmaRmStats {
> >>      uint64_t rx_bufs;
> >>      uint64_t rx_bufs_len;
> >>      uint64_t rx_bufs_err;
> >> +    uint64_t rx_srq;
> >>      uint64_t completions;
> >>      uint64_t mad_tx;
> >>      uint64_t mad_tx_err;
> > 
> > Please make a separate patch to update the function
> > rdma_dump_device_counters.
> > 
> 
> You mean a separate patch for introducing the "rx_srq" counter & update the
> function rdma_dump_device_counters()?

My bad, missed that ([1]).
No need for a separate patch.

> 
> > Besides that patch lgtm.
> > 
> > Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
> > 
> >> -- 
> >> 2.20.1
> >>
> >>
> 

