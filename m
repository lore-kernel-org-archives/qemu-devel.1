Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE21C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 15:54:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69F432051A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 15:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vafpjUZp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69F432051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDs4X-0007SO-QL
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 11:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53728)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1jDppe-0003MX-2X
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 09:31:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1jDppc-0004aG-LE
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 09:31:01 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43114)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1jDppc-0004Rj-CM
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 09:31:00 -0400
Received: by mail-wr1-x443.google.com with SMTP id b2so14995566wrj.10
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 06:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=UbbPerI1ViIZ/ZFKWkhwLiubBQVNFB7qXCfElKgnVe4=;
 b=vafpjUZpQMNKzS476VbBN1TOnUrBUi3KUmXLhM/FHFYTwIkduwSrfU/CvXmNy+1CYX
 cwYYC/grM6B8emmhRMIczE2D/ToxvsDMgtjxs5Nv2gkr8GOjlZF6pGodLWHWo6jXBz28
 fF9Eafa16QmxsimCFtf8ssxMU/US7WhvyLBAC3o4Y6/RkUoTRTHR8wkPmhsJollh1djT
 oZ+NTn6sj1w5P+kijKPPcay1bkT+2Qr8RLFSIQL8AAPA/roYH6IzodpKDSbI71f+cF5B
 cQ3lXw7GsItPSlTVtx2edRVXitmbgsQJUenx7nAt+UYb3c7roU2dq2eVO1qZ55L+vkr/
 Ydrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=UbbPerI1ViIZ/ZFKWkhwLiubBQVNFB7qXCfElKgnVe4=;
 b=c173ZhojWJaZkxn5jcbEuVTO+Mg8KDMNBlgpbjtOPhozwbu+2aQPLUvqbBUlYqwbZ2
 hUOW7F2dITrB93+I9p9RYPP/Y75bF/MtGOyNc0NSSaMzL3aehgic3CPLvHPelWZ+bl2V
 U88MweMxQUHCCMXDlFtryoNKSiK4v2/TFjgtmIOBjT9PbRhIAznTPfLUyhOTiF2SpwHJ
 3xjf0+VNMj9ZOcerzce3tdwPx69E9OnObYRj1+8rwkCYTuFm9Th/u1w+58iIP/PQdGPx
 b6dQZedFivrMOKpq9hJINjBtlAEZDPp5R1/jA1QszlePLZF9Zrm+z0MKMuB2bjafAi1j
 8iKQ==
X-Gm-Message-State: ANhLgQ0FL23ZsclC2wcIZVrp0q5lkDr651o/NBG431dsHW/rTaxHZCi7
 +5g6MM0HD8vlgp/uKOj8ZVa0ZBBH
X-Google-Smtp-Source: ADFU+vtNMHIwTRSzW+jP0Hyk7HJC6921p7iYU6p/F8aQa1RM9s4W1XZmOhJEoytA8GR0VN1kH7h7fA==
X-Received: by 2002:adf:ce8e:: with SMTP id r14mr5413080wrn.415.1584365458315; 
 Mon, 16 Mar 2020 06:30:58 -0700 (PDT)
Received: from [192.168.86.224] ([37.142.144.12])
 by smtp.gmail.com with ESMTPSA id l7sm22869966wrw.33.2020.03.16.06.30.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 06:30:57 -0700 (PDT)
Subject: Re: [PATCH 1/2] hw/rdma: Cosmetic change - no need for two sge arrays
To: Yuval Shaia <yuval.shaia.ml@gmail.com>, qemu-devel@nongnu.org
References: <20200307125608.2476-1-yuval.shaia.ml@gmail.com>
 <20200307125608.2476-2-yuval.shaia.ml@gmail.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <0f105874-c15f-406e-c4e9-fd752f95aa96@gmail.com>
Date: Mon, 16 Mar 2020 15:32:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200307125608.2476-2-yuval.shaia.ml@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Yuval,

On 3/7/20 2:56 PM, Yuval Shaia wrote:
> The function build_host_sge_array uses two sge arrays, one for input and
> one for output.
> Since the size of the two arrays is the same, the function can write
> directly to the given source array (i.e. input/output argument).
>
> Signed-off-by: Yuval Shaia <yuval.shaia.ml@gmail.com>
> ---
>   hw/rdma/rdma_backend.c | 40 +++++++++++++++++-----------------------
>   1 file changed, 17 insertions(+), 23 deletions(-)
>
> diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
> index c346407cd3..79b9cfb487 100644
> --- a/hw/rdma/rdma_backend.c
> +++ b/hw/rdma/rdma_backend.c
> @@ -378,30 +378,27 @@ static void ah_cache_init(void)
>   }
>   
>   static int build_host_sge_array(RdmaDeviceResources *rdma_dev_res,
> -                                struct ibv_sge *dsge, struct ibv_sge *ssge,
> -                                uint8_t num_sge, uint64_t *total_length)
> +                                struct ibv_sge *sge, uint8_t num_sge,
> +                                uint64_t *total_length)
>   {
>       RdmaRmMR *mr;
> -    int ssge_idx;
> +    int idx;
>   
> -    for (ssge_idx = 0; ssge_idx < num_sge; ssge_idx++) {
> -        mr = rdma_rm_get_mr(rdma_dev_res, ssge[ssge_idx].lkey);
> +    for (idx = 0; idx < num_sge; idx++) {
> +        mr = rdma_rm_get_mr(rdma_dev_res, sge[idx].lkey);
>           if (unlikely(!mr)) {
> -            rdma_error_report("Invalid lkey 0x%x", ssge[ssge_idx].lkey);
> -            return VENDOR_ERR_INVLKEY | ssge[ssge_idx].lkey;
> +            rdma_error_report("Invalid lkey 0x%x", sge[idx].lkey);
> +            return VENDOR_ERR_INVLKEY | sge[idx].lkey;
>           }
>   
>   #ifdef LEGACY_RDMA_REG_MR
> -        dsge->addr = (uintptr_t)mr->virt + ssge[ssge_idx].addr - mr->start;
> +        sge[idx].addr = (uintptr_t)mr->virt + sge[idx].addr - mr->start;
>   #else
> -        dsge->addr = ssge[ssge_idx].addr;
> +        sge[idx].addr = sge[idx].addr;

It seems we don't need the above line.
Other than that it looks good to me.

Thanks,
Marcel

>   #endif
> -        dsge->length = ssge[ssge_idx].length;
> -        dsge->lkey = rdma_backend_mr_lkey(&mr->backend_mr);
> +        sge[idx].lkey = rdma_backend_mr_lkey(&mr->backend_mr);
>   
> -        *total_length += dsge->length;
> -
> -        dsge++;
> +        *total_length += sge[idx].length;
>       }
>   
>       return 0;
> @@ -484,7 +481,6 @@ void rdma_backend_post_send(RdmaBackendDev *backend_dev,
>                               void *ctx)
>   {
>       BackendCtx *bctx;
> -    struct ibv_sge new_sge[MAX_SGE];
>       uint32_t bctx_id;
>       int rc;
>       struct ibv_send_wr wr = {}, *bad_wr;
> @@ -518,7 +514,7 @@ void rdma_backend_post_send(RdmaBackendDev *backend_dev,
>   
>       rdma_protected_gslist_append_int32(&qp->cqe_ctx_list, bctx_id);
>   
> -    rc = build_host_sge_array(backend_dev->rdma_dev_res, new_sge, sge, num_sge,
> +    rc = build_host_sge_array(backend_dev->rdma_dev_res, sge, num_sge,
>                                 &backend_dev->rdma_dev_res->stats.tx_len);
>       if (rc) {
>           complete_work(IBV_WC_GENERAL_ERR, rc, ctx);
> @@ -538,7 +534,7 @@ void rdma_backend_post_send(RdmaBackendDev *backend_dev,
>       wr.num_sge = num_sge;
>       wr.opcode = IBV_WR_SEND;
>       wr.send_flags = IBV_SEND_SIGNALED;
> -    wr.sg_list = new_sge;
> +    wr.sg_list = sge;
>       wr.wr_id = bctx_id;
>   
>       rc = ibv_post_send(qp->ibqp, &wr, &bad_wr);
> @@ -601,7 +597,6 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
>                               struct ibv_sge *sge, uint32_t num_sge, void *ctx)
>   {
>       BackendCtx *bctx;
> -    struct ibv_sge new_sge[MAX_SGE];
>       uint32_t bctx_id;
>       int rc;
>       struct ibv_recv_wr wr = {}, *bad_wr;
> @@ -635,7 +630,7 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
>   
>       rdma_protected_gslist_append_int32(&qp->cqe_ctx_list, bctx_id);
>   
> -    rc = build_host_sge_array(backend_dev->rdma_dev_res, new_sge, sge, num_sge,
> +    rc = build_host_sge_array(backend_dev->rdma_dev_res, sge, num_sge,
>                                 &backend_dev->rdma_dev_res->stats.rx_bufs_len);
>       if (rc) {
>           complete_work(IBV_WC_GENERAL_ERR, rc, ctx);
> @@ -643,7 +638,7 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
>       }
>   
>       wr.num_sge = num_sge;
> -    wr.sg_list = new_sge;
> +    wr.sg_list = sge;
>       wr.wr_id = bctx_id;
>       rc = ibv_post_recv(qp->ibqp, &wr, &bad_wr);
>       if (rc) {
> @@ -671,7 +666,6 @@ void rdma_backend_post_srq_recv(RdmaBackendDev *backend_dev,
>                                   uint32_t num_sge, void *ctx)
>   {
>       BackendCtx *bctx;
> -    struct ibv_sge new_sge[MAX_SGE];
>       uint32_t bctx_id;
>       int rc;
>       struct ibv_recv_wr wr = {}, *bad_wr;
> @@ -688,7 +682,7 @@ void rdma_backend_post_srq_recv(RdmaBackendDev *backend_dev,
>   
>       rdma_protected_gslist_append_int32(&srq->cqe_ctx_list, bctx_id);
>   
> -    rc = build_host_sge_array(backend_dev->rdma_dev_res, new_sge, sge, num_sge,
> +    rc = build_host_sge_array(backend_dev->rdma_dev_res, sge, num_sge,
>                                 &backend_dev->rdma_dev_res->stats.rx_bufs_len);
>       if (rc) {
>           complete_work(IBV_WC_GENERAL_ERR, rc, ctx);
> @@ -696,7 +690,7 @@ void rdma_backend_post_srq_recv(RdmaBackendDev *backend_dev,
>       }
>   
>       wr.num_sge = num_sge;
> -    wr.sg_list = new_sge;
> +    wr.sg_list = sge;
>       wr.wr_id = bctx_id;
>       rc = ibv_post_srq_recv(srq->ibsrq, &wr, &bad_wr);
>       if (rc) {


