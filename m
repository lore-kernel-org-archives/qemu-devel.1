Return-Path: <SRS0=aRDT=W3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93433C3A5A6
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 19:34:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EB6D2187F
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 19:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o/7JqfNV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EB6D2187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i498L-0001aO-GQ
	for qemu-devel@archiver.kernel.org; Sat, 31 Aug 2019 15:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57368)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1i496E-0000bM-U2
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 15:31:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1i496D-0002y1-FG
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 15:31:50 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44156)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1i496D-0002xc-6G
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 15:31:49 -0400
Received: by mail-wr1-x444.google.com with SMTP id b6so7297831wrv.11
 for <qemu-devel@nongnu.org>; Sat, 31 Aug 2019 12:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=bf3BWYSl4moT1+Nu4evMsp+VgAgkXown28s15zHFH8s=;
 b=o/7JqfNVn34JNQ1ZKFhtwH1AeeM9WP09pG1ApVj+f05DY/YTvfyW277B3milwLjBuH
 sLtJIh5H8bLQ1Wzq0B9Y0S3OvgiWAy2Qg07Y8J+Xs9kZZdlQhHkdWSmmle+WtljeEOGB
 BNj0YA545lO1S7LfV37IkhYmL+5pIBI/OS3KT15/25MlNkpy043kdy7V5NByxP3UJqNY
 Km1hVlBEyDXe55jxSsrsE3k4RdV4YLpwzTVnrGbRKjS6gH5w7VpNHlwlaKZeizsDY5tX
 a5RnQ0a68omDNbCmcvwa/pttIs0kTXhW4XFUaIUxB5kxJNhN6MP6wmeiiaggnjkwJJYb
 mJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=bf3BWYSl4moT1+Nu4evMsp+VgAgkXown28s15zHFH8s=;
 b=K4wy/wp0JuDx///RyeNEnwZzF/Jnlo0NDwVrI1bjtQzOifsAubg8U3Q+UqCJ8b6ecN
 eNWXbmMtWBwvIRvEUuRsFIsA2+UkhgQUqjOHYPc6VYhXvMR5uxNMomUCcr0kjclyjQBW
 EnRvxArNtfxiyVz1eVrWIqhIfN1KpA1IToyvxHmQ1EBJy2tjoehoRvgdhsXakl4RnMP+
 l/xGQ3X8tGdZgKGuv58TsjLjrYneKT/94RKQQmeWEe0iEW6LrT6crmgYMkcszuZq6gSO
 IOgOSfCLZOgLjfvNpiO1eVIyE9pCv33gu/EQ+N7kx/J/Np16HOgYANvzUWm9wIkIVgkU
 7big==
X-Gm-Message-State: APjAAAU7ZZNg4hbqWgQuQ7VOXwooRqfTfLD/UupUrs2ZHPM/acWrdq0j
 RuPSI9ypu44Sge0qLIi/W3Ij2VzJy1U=
X-Google-Smtp-Source: APXvYqybPXo1mk5tWfhe93HnV2GL3scwgAWwDwCXomd47jlsGGOw++LjCA2SIDImGaKqLXoJruX40w==
X-Received: by 2002:a5d:45c3:: with SMTP id b3mr5243866wrs.207.1567279907489; 
 Sat, 31 Aug 2019 12:31:47 -0700 (PDT)
Received: from [192.168.86.99] ([37.142.144.12])
 by smtp.gmail.com with ESMTPSA id w8sm24057418wmc.1.2019.08.31.12.31.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 31 Aug 2019 12:31:46 -0700 (PDT)
To: Yuval Shaia <yuval.shaia@oracle.com>, berrange@redhat.com,
 thuth@redhat.com, philmd@redhat.com, pbonzini@redhat.com, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20190818132107.18181-1-yuval.shaia@oracle.com>
 <20190818132107.18181-3-yuval.shaia@oracle.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <9ede18f4-641c-aef4-cedf-830fd52a02ec@gmail.com>
Date: Sat, 31 Aug 2019 22:31:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190818132107.18181-3-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/rdma: Utilize ibv_reg_mr_iova for
 memory registration
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

On 8/18/19 4:21 PM, Yuval Shaia wrote:
> The virtual address that is provided by the guest in post_send and
> post_recv operations is related to the guest address space. This address
> space is unknown to the HCA resides on host so extra step in these
> operations is needed to adjust the address to host virtual address.
>
> This step, which is done in data-path affects performances.
>
> An enhanced verion of MR registration introduced here
> https://patchwork.kernel.org/patch/11044467/ can be used so that the
> guest virtual address space for this MR is known to the HCA in host.
>
> This will save the data-path adjustment.
>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>   hw/rdma/rdma_backend.c    | 13 +++++++++++++
>   hw/rdma/rdma_backend.h    |  5 +++++
>   hw/rdma/rdma_rm.c         |  5 +++++
>   hw/rdma/vmw/pvrdma_main.c |  6 ++++++
>   4 files changed, 29 insertions(+)
>
> diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
> index c39051068d..c346407cd3 100644
> --- a/hw/rdma/rdma_backend.c
> +++ b/hw/rdma/rdma_backend.c
> @@ -391,7 +391,11 @@ static int build_host_sge_array(RdmaDeviceResources *rdma_dev_res,
>               return VENDOR_ERR_INVLKEY | ssge[ssge_idx].lkey;
>           }
>   
> +#ifdef LEGACY_RDMA_REG_MR
>           dsge->addr = (uintptr_t)mr->virt + ssge[ssge_idx].addr - mr->start;

This is the performance hit you are addressing? The address computation?

Thanks,
Marcel


> +#else
> +        dsge->addr = ssge[ssge_idx].addr;
> +#endif
>           dsge->length = ssge[ssge_idx].length;
>           dsge->lkey = rdma_backend_mr_lkey(&mr->backend_mr);
>   
> @@ -735,10 +739,19 @@ void rdma_backend_destroy_pd(RdmaBackendPD *pd)
>       }
>   }
>   
> +#ifdef LEGACY_RDMA_REG_MR
>   int rdma_backend_create_mr(RdmaBackendMR *mr, RdmaBackendPD *pd, void *addr,
>                              size_t length, int access)
> +#else
> +int rdma_backend_create_mr(RdmaBackendMR *mr, RdmaBackendPD *pd, void *addr,
> +                           size_t length, uint64_t guest_start, int access)
> +#endif
>   {
> +#ifdef LEGACY_RDMA_REG_MR
>       mr->ibmr = ibv_reg_mr(pd->ibpd, addr, length, access);
> +#else
> +    mr->ibmr = ibv_reg_mr_iova(pd->ibpd, addr, length, guest_start, access);
> +#endif
>       if (!mr->ibmr) {
>           rdma_error_report("ibv_reg_mr fail, errno=%d", errno);
>           return -EIO;
> diff --git a/hw/rdma/rdma_backend.h b/hw/rdma/rdma_backend.h
> index 7c1a19a2b5..127f96e2d5 100644
> --- a/hw/rdma/rdma_backend.h
> +++ b/hw/rdma/rdma_backend.h
> @@ -78,8 +78,13 @@ int rdma_backend_query_port(RdmaBackendDev *backend_dev,
>   int rdma_backend_create_pd(RdmaBackendDev *backend_dev, RdmaBackendPD *pd);
>   void rdma_backend_destroy_pd(RdmaBackendPD *pd);
>   
> +#ifdef LEGACY_RDMA_REG_MR
>   int rdma_backend_create_mr(RdmaBackendMR *mr, RdmaBackendPD *pd, void *addr,
>                              size_t length, int access);
> +#else
> +int rdma_backend_create_mr(RdmaBackendMR *mr, RdmaBackendPD *pd, void *addr,
> +                           size_t length, uint64_t guest_start, int access);
> +#endif
>   void rdma_backend_destroy_mr(RdmaBackendMR *mr);
>   
>   int rdma_backend_create_cq(RdmaBackendDev *backend_dev, RdmaBackendCQ *cq,
> diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
> index 1927f85472..1524dfaeaa 100644
> --- a/hw/rdma/rdma_rm.c
> +++ b/hw/rdma/rdma_rm.c
> @@ -227,8 +227,13 @@ int rdma_rm_alloc_mr(RdmaDeviceResources *dev_res, uint32_t pd_handle,
>           mr->length = guest_length;
>           mr->virt += (mr->start & (TARGET_PAGE_SIZE - 1));
>   
> +#ifdef LEGACY_RDMA_REG_MR
>           ret = rdma_backend_create_mr(&mr->backend_mr, &pd->backend_pd, mr->virt,
>                                        mr->length, access_flags);
> +#else
> +        ret = rdma_backend_create_mr(&mr->backend_mr, &pd->backend_pd, mr->virt,
> +                                     mr->length, guest_start, access_flags);
> +#endif
>           if (ret) {
>               ret = -EIO;
>               goto out_dealloc_mr;
> diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
> index 3e36e13013..18075285f6 100644
> --- a/hw/rdma/vmw/pvrdma_main.c
> +++ b/hw/rdma/vmw/pvrdma_main.c
> @@ -664,6 +664,12 @@ static void pvrdma_realize(PCIDevice *pdev, Error **errp)
>       dev->shutdown_notifier.notify = pvrdma_shutdown_notifier;
>       qemu_register_shutdown_notifier(&dev->shutdown_notifier);
>   
> +#ifdef LEGACY_RDMA_REG_MR
> +    rdma_info_report("Using legacy reg_mr");
> +#else
> +    rdma_info_report("Using iova reg_mr");
> +#endif
> +
>   out:
>       if (rc) {
>           pvrdma_fini(pdev);


