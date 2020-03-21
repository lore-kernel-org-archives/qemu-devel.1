Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66351C4332B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 16:49:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2849720732
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 16:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIGQlMBY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2849720732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFhJW-0002bk-97
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 12:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51528)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1jFhIV-0002Be-9r
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 12:48:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1jFhIT-0004Q2-Q4
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 12:48:31 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38652)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1jFhIT-0004PT-IY
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 12:48:29 -0400
Received: by mail-wr1-x444.google.com with SMTP id s1so11299901wrv.5
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2020 09:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=xcR5VTCptay92KLrmvcq6hIJhI8FEkzx6kcb5nLeoU0=;
 b=nIGQlMBYnq5fud11mSCq4h/ayzb1AlUWnpPvOIZkcGfj2vd8YS3dKZgRlT9IZF7nBc
 8dXebp7xn0aiwIhx5Su4sfF8X0HoeU77l/Hb3m7xK/RFTPRN2pRCkI3Qjt6l2P5JjYyp
 EtnnM95iSTcL0z511wk6/F9haQo7hc379JM5c6m2iZxiWnPJDJYKRiR/JzK86Pv90I/p
 /4zHRJDmv9BQ5xW3jdVpaBPqhoyzi9WlasQnSeRfDJAp70hchkW3PCWLP3Eex5BA76K4
 Rn0zoxsW91mLjqWM9vyONM/GNKg4l90I+gYqASFt+3BIfcfsQ13QuPIcJc+Hxwpj6rTb
 basA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=xcR5VTCptay92KLrmvcq6hIJhI8FEkzx6kcb5nLeoU0=;
 b=Au+izq+E8psyugSruwUL+yXdKsfQWNFXYGXrvA6JIq9obb5xRlFa55LJ4kAuT+8AhK
 SU/AN3Leyq8Njr9eYiXgRSeba7SVbWw2162DXK8tLJ2H+kgJmli6VOuPGqSYnrwlVh3f
 AIKL+MPbTI0OqwL/lXPet6gvwWgbUfGhfoWCya920KBcPfUNnIoKu56al4oWnUTTTZoI
 /6o1O0QMpf6yiqL0gBk+T3Ts1dFlocBMN6JfwfaCb/23P29owvTrsMMSfW8qTTBXX/DE
 cEHPMbQ6Ot37Hn0W5weJXsZnrL6Bj5SqoU+Aq8ZsgLwlyS2ZYpawwQC3g+qmLH3e7Gk/
 WkyA==
X-Gm-Message-State: ANhLgQ0+WZZsy11uLOqMAHnV6n7hx6WO6Q3de1g16a81w3LbZGQprYLB
 kKJ7Qzrxfs54dJM38IYn/h38rG42
X-Google-Smtp-Source: ADFU+vvG62H5zxWWB/iaNOYcyIxgB8C2MAbi0mKET8N25ILgpCPSoWsjSmX9veuADeddsWdm9uRwfA==
X-Received: by 2002:a5d:67cd:: with SMTP id n13mr17628162wrw.383.1584809307631; 
 Sat, 21 Mar 2020 09:48:27 -0700 (PDT)
Received: from [192.168.86.37] ([37.142.144.12])
 by smtp.gmail.com with ESMTPSA id u204sm12963903wmg.40.2020.03.21.09.48.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Mar 2020 09:48:26 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] hw/rdma: Cosmetic change - no need for two sge
 arrays
To: Yuval Shaia <yuval.shaia.ml@gmail.com>, qemu-devel@nongnu.org
References: <20200320143429.9490-1-yuval.shaia.ml@gmail.com>
 <20200320143429.9490-2-yuval.shaia.ml@gmail.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <ccacd0c9-b385-d2d8-8a55-0ab74f1a57eb@gmail.com>
Date: Sat, 21 Mar 2020 18:50:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200320143429.9490-2-yuval.shaia.ml@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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



On 3/20/20 4:34 PM, Yuval Shaia wrote:
> The function build_host_sge_array uses two sge arrays, one for input and
> one for output.
> Since the size of the two arrays is the same, the function can write
> directly to the given source array (i.e. input/output argument).
>
> Signed-off-by: Yuval Shaia <yuval.shaia.ml@gmail.com>
> ---
>   hw/rdma/rdma_backend.c | 40 ++++++++++++++++------------------------
>   1 file changed, 16 insertions(+), 24 deletions(-)
>
> diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
> index c346407cd3..b7ffbef9c0 100644
> --- a/hw/rdma/rdma_backend.c
> +++ b/hw/rdma/rdma_backend.c
> @@ -378,30 +378,25 @@ static void ah_cache_init(void)
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
> -#else
> -        dsge->addr = ssge[ssge_idx].addr;
> +        sge[idx].addr = (uintptr_t)mr->virt + sge[idx].addr - mr->start;
>   #endif
> -        dsge->length = ssge[ssge_idx].length;
> -        dsge->lkey = rdma_backend_mr_lkey(&mr->backend_mr);
> -
> -        *total_length += dsge->length;
> +        sge[idx].lkey = rdma_backend_mr_lkey(&mr->backend_mr);
>   
> -        dsge++;
> +        *total_length += sge[idx].length;
>       }
>   
>       return 0;
> @@ -484,7 +479,6 @@ void rdma_backend_post_send(RdmaBackendDev *backend_dev,
>                               void *ctx)
>   {
>       BackendCtx *bctx;
> -    struct ibv_sge new_sge[MAX_SGE];
>       uint32_t bctx_id;
>       int rc;
>       struct ibv_send_wr wr = {}, *bad_wr;
> @@ -518,7 +512,7 @@ void rdma_backend_post_send(RdmaBackendDev *backend_dev,
>   
>       rdma_protected_gslist_append_int32(&qp->cqe_ctx_list, bctx_id);
>   
> -    rc = build_host_sge_array(backend_dev->rdma_dev_res, new_sge, sge, num_sge,
> +    rc = build_host_sge_array(backend_dev->rdma_dev_res, sge, num_sge,
>                                 &backend_dev->rdma_dev_res->stats.tx_len);
>       if (rc) {
>           complete_work(IBV_WC_GENERAL_ERR, rc, ctx);
> @@ -538,7 +532,7 @@ void rdma_backend_post_send(RdmaBackendDev *backend_dev,
>       wr.num_sge = num_sge;
>       wr.opcode = IBV_WR_SEND;
>       wr.send_flags = IBV_SEND_SIGNALED;
> -    wr.sg_list = new_sge;
> +    wr.sg_list = sge;
>       wr.wr_id = bctx_id;
>   
>       rc = ibv_post_send(qp->ibqp, &wr, &bad_wr);
> @@ -601,7 +595,6 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
>                               struct ibv_sge *sge, uint32_t num_sge, void *ctx)
>   {
>       BackendCtx *bctx;
> -    struct ibv_sge new_sge[MAX_SGE];
>       uint32_t bctx_id;
>       int rc;
>       struct ibv_recv_wr wr = {}, *bad_wr;
> @@ -635,7 +628,7 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
>   
>       rdma_protected_gslist_append_int32(&qp->cqe_ctx_list, bctx_id);
>   
> -    rc = build_host_sge_array(backend_dev->rdma_dev_res, new_sge, sge, num_sge,
> +    rc = build_host_sge_array(backend_dev->rdma_dev_res, sge, num_sge,
>                                 &backend_dev->rdma_dev_res->stats.rx_bufs_len);
>       if (rc) {
>           complete_work(IBV_WC_GENERAL_ERR, rc, ctx);
> @@ -643,7 +636,7 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
>       }
>   
>       wr.num_sge = num_sge;
> -    wr.sg_list = new_sge;
> +    wr.sg_list = sge;
>       wr.wr_id = bctx_id;
>       rc = ibv_post_recv(qp->ibqp, &wr, &bad_wr);
>       if (rc) {
> @@ -671,7 +664,6 @@ void rdma_backend_post_srq_recv(RdmaBackendDev *backend_dev,
>                                   uint32_t num_sge, void *ctx)
>   {
>       BackendCtx *bctx;
> -    struct ibv_sge new_sge[MAX_SGE];
>       uint32_t bctx_id;
>       int rc;
>       struct ibv_recv_wr wr = {}, *bad_wr;
> @@ -688,7 +680,7 @@ void rdma_backend_post_srq_recv(RdmaBackendDev *backend_dev,
>   
>       rdma_protected_gslist_append_int32(&srq->cqe_ctx_list, bctx_id);
>   
> -    rc = build_host_sge_array(backend_dev->rdma_dev_res, new_sge, sge, num_sge,
> +    rc = build_host_sge_array(backend_dev->rdma_dev_res, sge, num_sge,
>                                 &backend_dev->rdma_dev_res->stats.rx_bufs_len);
>       if (rc) {
>           complete_work(IBV_WC_GENERAL_ERR, rc, ctx);
> @@ -696,7 +688,7 @@ void rdma_backend_post_srq_recv(RdmaBackendDev *backend_dev,
>       }
>   
>       wr.num_sge = num_sge;
> -    wr.sg_list = new_sge;
> +    wr.sg_list = sge;
>       wr.wr_id = bctx_id;
>       rc = ibv_post_srq_recv(srq->ibsrq, &wr, &bad_wr);
>       if (rc) {


Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Thanks,
Marcel



