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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87653C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:25:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E4042051A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hm6qtesv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E4042051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDsYt-0005FE-E0
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 12:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59846)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1jDpuL-00053v-No
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 09:35:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1jDpuK-0002HD-Bb
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 09:35:53 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51069)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1jDpuK-00029Z-4J
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 09:35:52 -0400
Received: by mail-wm1-x343.google.com with SMTP id z13so1638819wml.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 06:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=9v/YZE8B93L63rDeOT39XFw3gBUTDfP+YPVFz1gdnk4=;
 b=Hm6qtesvXx2YPZKsjktWLqgZQb3keRWHoPTRSeUfZd8EhslIb7d0BwIZBKdosBMLxv
 VF/mn4Py37F3d/zEjlJtdKI2YFz99rq2+wLFN2MWFGqqAVdB3hO424WBqUFduwmPrr1Q
 oRKSPyRK+I1ghjtlg6IufUKTBTA3QzPLrFewFTjdYpVVanmBn7QiCJDVp5OaiBX9de3L
 K/SN1Qknr5SAfy2osbrTVm5ccMP4FkwsdqDSwYvErE1mbyjSF873pbBaU2LsT1tFWab7
 1BvYYntG5AXR9HXRvHRaNyJG1XmUON0YwRPBht7QIC2iKZeSJ0+OtfhM5KifRuEfN0kg
 voYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=9v/YZE8B93L63rDeOT39XFw3gBUTDfP+YPVFz1gdnk4=;
 b=XgcpRn+6Rq4ouKAJkIXbr3iaS38hhJ9IspN7slLiYvoHvV7V3QL1TfO+vHpPZ/qub4
 EubCwcwGdQzFKmbd4AxQVYL5XExHY+pBQaE1ZkUQ+T9h4m1CkMnzd1TKrUeACFHNCX1T
 AD3OBzvUqpZkZPpCqNl2cDtpErLu0fNj3KlTiUvB406xu9Fhps0u9r38i+mLdFkHtRfP
 VXIxQIJe1b6KsmRkrbV9Uo9ZvIPiRUezHjWEr+OchT0Qm0hoGfqE5CRdEjopOSJYYkjh
 /O74LfZS+K8VLBwLpwIRnBqyRU0SMmx4TRMf2XEFX067NY48yhd1Y8TisKMJagNzWR3E
 xlSQ==
X-Gm-Message-State: ANhLgQ0EWkE8jdg76WV5eWhOxOiF4UHeY6USyq7BSSgf5FB5soBYicz/
 umuEjsDgZjwKvDaROb+3jiQgBz5z
X-Google-Smtp-Source: ADFU+vvbxIkcpUCE8pKGXsSGDMECqrZkR8QTV9oxFe4QwM+31mh0PV6KD5p+/3b+bWRO0diB+gp0Vg==
X-Received: by 2002:a05:600c:2252:: with SMTP id
 a18mr29081693wmm.51.1584365750358; 
 Mon, 16 Mar 2020 06:35:50 -0700 (PDT)
Received: from [192.168.86.224] ([37.142.144.12])
 by smtp.gmail.com with ESMTPSA id c5sm26240291wma.3.2020.03.16.06.35.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 06:35:49 -0700 (PDT)
Subject: Re: [PATCH 2/2] hw/rdma: Skip data-path mr_id translation
To: Yuval Shaia <yuval.shaia.ml@gmail.com>, qemu-devel@nongnu.org
References: <20200307125608.2476-1-yuval.shaia.ml@gmail.com>
 <20200307125608.2476-3-yuval.shaia.ml@gmail.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <d24e9eda-7c7f-e605-5895-75dc75c99fcc@gmail.com>
Date: Mon, 16 Mar 2020 15:37:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200307125608.2476-3-yuval.shaia.ml@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
> With the change made in commit 68b89aee71 ("Utilize ibv_reg_mr_iova for
> memory registration") the MR emulation is no longer needed in order to
> translate the guest addresses into host addresses.
> With that, the next obvious step is to skip entirely the processing in
> data-path.
> To accomplish this, return the backend's lkey to driver so we will not
> need to do the emulated mr_id to backend mr_id translation in data-path.
>
> The function build_host_sge_array is still called in data-path but only
> for backward computability with statistics collection.
>
> While there, as a cosmetic change to make the code cleaner - make one
> copy of the function rdma_backend_create_mr and leave the redundant
> guest_start argument in the legacy code.
>
> Signed-off-by: Yuval Shaia <yuval.shaia.ml@gmail.com>
> ---
>   hw/rdma/rdma_backend.c | 23 ++++++++++++++---------
>   hw/rdma/rdma_backend.h |  5 -----
>   hw/rdma/rdma_rm.c      | 13 ++++++-------
>   3 files changed, 20 insertions(+), 21 deletions(-)
>
> diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
> index 79b9cfb487..3dd39fe1a7 100644
> --- a/hw/rdma/rdma_backend.c
> +++ b/hw/rdma/rdma_backend.c
> @@ -377,6 +377,7 @@ static void ah_cache_init(void)
>                                       destroy_ah_hash_key, destroy_ah_hast_data);
>   }
>   
> +#ifdef LEGACY_RDMA_REG_MR
>   static int build_host_sge_array(RdmaDeviceResources *rdma_dev_res,
>                                   struct ibv_sge *sge, uint8_t num_sge,
>                                   uint64_t *total_length)
> @@ -391,11 +392,7 @@ static int build_host_sge_array(RdmaDeviceResources *rdma_dev_res,
>               return VENDOR_ERR_INVLKEY | sge[idx].lkey;
>           }
>   
> -#ifdef LEGACY_RDMA_REG_MR
>           sge[idx].addr = (uintptr_t)mr->virt + sge[idx].addr - mr->start;
> -#else
> -        sge[idx].addr = sge[idx].addr;
> -#endif
>           sge[idx].lkey = rdma_backend_mr_lkey(&mr->backend_mr);
>   
>           *total_length += sge[idx].length;
> @@ -403,6 +400,19 @@ static int build_host_sge_array(RdmaDeviceResources *rdma_dev_res,
>   
>       return 0;
>   }
> +#else
> +static inline int build_host_sge_array(RdmaDeviceResources *rdma_dev_res,
> +                                       struct ibv_sge *sge, uint8_t num_sge,
> +                                       uint64_t *total_length)
> +{
> +    int idx;
> +
> +    for (idx = 0; idx < num_sge; idx++) {
> +        *total_length += sge[idx].length;
> +    }
> +    return 0;
> +}
> +#endif
>   
>   static void trace_mad_message(const char *title, char *buf, int len)
>   {
> @@ -733,13 +743,8 @@ void rdma_backend_destroy_pd(RdmaBackendPD *pd)
>       }
>   }
>   
> -#ifdef LEGACY_RDMA_REG_MR
> -int rdma_backend_create_mr(RdmaBackendMR *mr, RdmaBackendPD *pd, void *addr,
> -                           size_t length, int access)
> -#else
>   int rdma_backend_create_mr(RdmaBackendMR *mr, RdmaBackendPD *pd, void *addr,
>                              size_t length, uint64_t guest_start, int access)
> -#endif
>   {
>   #ifdef LEGACY_RDMA_REG_MR
>       mr->ibmr = ibv_reg_mr(pd->ibpd, addr, length, access);
> diff --git a/hw/rdma/rdma_backend.h b/hw/rdma/rdma_backend.h
> index 127f96e2d5..225af481e0 100644
> --- a/hw/rdma/rdma_backend.h
> +++ b/hw/rdma/rdma_backend.h
> @@ -78,13 +78,8 @@ int rdma_backend_query_port(RdmaBackendDev *backend_dev,
>   int rdma_backend_create_pd(RdmaBackendDev *backend_dev, RdmaBackendPD *pd);
>   void rdma_backend_destroy_pd(RdmaBackendPD *pd);
>   
> -#ifdef LEGACY_RDMA_REG_MR
> -int rdma_backend_create_mr(RdmaBackendMR *mr, RdmaBackendPD *pd, void *addr,
> -                           size_t length, int access);
> -#else
>   int rdma_backend_create_mr(RdmaBackendMR *mr, RdmaBackendPD *pd, void *addr,
>                              size_t length, uint64_t guest_start, int access);
> -#endif
>   void rdma_backend_destroy_mr(RdmaBackendMR *mr);
>   
>   int rdma_backend_create_cq(RdmaBackendDev *backend_dev, RdmaBackendCQ *cq,
> diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
> index 1524dfaeaa..7e9ea283c9 100644
> --- a/hw/rdma/rdma_rm.c
> +++ b/hw/rdma/rdma_rm.c
> @@ -227,21 +227,20 @@ int rdma_rm_alloc_mr(RdmaDeviceResources *dev_res, uint32_t pd_handle,
>           mr->length = guest_length;
>           mr->virt += (mr->start & (TARGET_PAGE_SIZE - 1));
>   
> -#ifdef LEGACY_RDMA_REG_MR
> -        ret = rdma_backend_create_mr(&mr->backend_mr, &pd->backend_pd, mr->virt,
> -                                     mr->length, access_flags);
> -#else
>           ret = rdma_backend_create_mr(&mr->backend_mr, &pd->backend_pd, mr->virt,
>                                        mr->length, guest_start, access_flags);
> -#endif
>           if (ret) {
>               ret = -EIO;
>               goto out_dealloc_mr;
>           }
> +#ifdef LEGACY_RDMA_REG_MR
> +        /* We keep mr_handle in lkey so send and recv get get mr ptr */
> +        *lkey = *mr_handle;
> +#else
> +        *lkey = rdma_backend_mr_lkey(&mr->backend_mr);
> +#endif
>       }
>   
> -    /* We keep mr_handle in lkey so send and recv get get mr ptr */
> -    *lkey = *mr_handle;
>       *rkey = -1;
>   
>       mr->pd_handle = pd_handle;

Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>

Thanks,
Marcel


