Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D9CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 16:03:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61894208A9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 16:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAjlk1pL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61894208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0oXn-00088s-HY
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 12:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1k0oVL-0005Kj-ND; Wed, 29 Jul 2020 12:00:32 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:33544)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1k0oVJ-0000Yx-9g; Wed, 29 Jul 2020 12:00:31 -0400
Received: by mail-pg1-x544.google.com with SMTP id o13so14489581pgf.0;
 Wed, 29 Jul 2020 09:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=zm+QUKHk7VOjueDio0Cn0Fh1ie6WJIbJejq0zGGrBuE=;
 b=RAjlk1pLxWF6nwp8Fu1edcr5jBp3HJeXPKwJTfD0gchuAyIGtaJp3s0d83rZjsWOQH
 FvuxbQ6rO8NX6qvZXK89EY0WRge8UaIZhplJCMLsWhi8M9KorEQITJI9HUtm65kMYThm
 07dEnHXWUaE/sZV5En7hC5I/IMayvzxTD0AJMIFUvMLB8AunJAdgOdobSm+6DFUbYfZm
 EbAZeRJlcSqnfbP/PGLpgnINvNaRawgYYFaJ2FTdDyKxLJ6eFGUBUmw0FHNGgBwilYp/
 /GbQN4qfPZTop7cEAiDt2Q9RNtLUsZGlunW8juYZE+mXcS53pWxgasy/TH2hEwhmtTHC
 UBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=zm+QUKHk7VOjueDio0Cn0Fh1ie6WJIbJejq0zGGrBuE=;
 b=rZZs2rl8q756AhzVmc+aeTUSz4JO52ZK7eyMyWl6SG7ooaNmToM7/iGuLNwrPnXe8J
 DgVx5rcDnDYGtbkyMDgR5d13SX8FzuDmRpeCpsS3DUgz+rRi6wWi6b71wd5b1hlv79xD
 QwE39dtpnfU/wtz3d2TfiJ+1raKwE0C2MzqIEPv6rx8VhbnW/BYPOIcPNjTfK4I0upFf
 eDH2WOlnSG38cwRX/vuhbM9mLgW3WCHFfCzvsyzgsuPn/07tFh6mBpEK04w4OnQ+VEUQ
 qX/TE0jrL1VY5JKeRxCKCbkyM9L/6DdggV8kWyNOCbvDVdZUusgN9TWOtEn4RDAmIk82
 abag==
X-Gm-Message-State: AOAM530PD190woqZhb4C2tW5ggWhN81ct4WpmcP1aOuaHQx7sOlYVetj
 8MHd/wI2QbeEdSm4pDFqDZA=
X-Google-Smtp-Source: ABdhPJzrYjBlARMrNDvHhyLrvKIq6ko4aBO90S4U9gRgidyp6uhbxtN0QGFHc3lzah/2wgEW31PzGg==
X-Received: by 2002:a63:bf04:: with SMTP id v4mr30569225pgf.212.1596038427473; 
 Wed, 29 Jul 2020 09:00:27 -0700 (PDT)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id w18sm2830901pgj.31.2020.07.29.09.00.26
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 29 Jul 2020 09:00:27 -0700 (PDT)
Date: Thu, 30 Jul 2020 01:00:24 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH 10/16] hw/block/nvme: add check for mdts
Message-ID: <20200729160024.GI14876@localhost.localdomain>
References: <20200720113748.322965-1-its@irrelevant.dk>
 <20200720113748.322965-11-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200720113748.322965-11-its@irrelevant.dk>
User-Agent: Mutt/1.11.4 (2019-03-13)
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=minwoo.im.dev@gmail.com; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20-07-20 13:37:42, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Add 'mdts' device parameter to control the Maximum Data Transfer Size of
> the controller and check that it is respected.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  hw/block/nvme.c       | 32 ++++++++++++++++++++++++++++++--
>  hw/block/nvme.h       |  1 +
>  hw/block/trace-events |  1 +
>  3 files changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 35bc1a7b7e21..10fe53873ae9 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -18,9 +18,10 @@
>   * Usage: add options:
>   *      -drive file=<file>,if=none,id=<drive_id>
>   *      -device nvme,drive=<drive_id>,serial=<serial>,id=<id[optional]>, \
> - *              cmb_size_mb=<cmb_size_mb[optional]>, \
> + *              [cmb_size_mb=<cmb_size_mb>,] \
>   *              [pmrdev=<mem_backend_file_id>,] \
> - *              max_ioqpairs=<N[optional]>
> + *              [max_ioqpairs=<N>,] \
> + *              [mdts=<N>]

Nitpick:
  cmb and ioqpairs-things could be in another thread. :)

>   *
>   * Note cmb_size_mb denotes size of CMB in MB. CMB is assumed to be at
>   * offset 0 in BAR2 and supports only WDS, RDS and SQS for now.
> @@ -553,6 +554,17 @@ static void nvme_clear_events(NvmeCtrl *n, uint8_t event_type)
>      }
>  }
>  
> +static inline uint16_t nvme_check_mdts(NvmeCtrl *n, size_t len)
> +{
> +    uint8_t mdts = n->params.mdts;
> +
> +    if (mdts && len > n->page_size << mdts) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    return NVME_SUCCESS;
> +}
> +
>  static inline uint16_t nvme_check_bounds(NvmeCtrl *n, NvmeNamespace *ns,
>                                           uint64_t slba, uint32_t nlb)
>  {
> @@ -646,6 +658,13 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
>  
>      trace_pci_nvme_rw(is_write ? "write" : "read", nlb, data_size, slba);
>  
> +    status = nvme_check_mdts(n, data_size);
> +    if (status) {
> +        trace_pci_nvme_err_mdts(nvme_cid(req), data_size);
> +        block_acct_invalid(blk_get_stats(n->conf.blk), acct);
> +        return status;
> +    }
> +
>      status = nvme_check_bounds(n, ns, slba, nlb);
>      if (status) {
>          trace_pci_nvme_err_invalid_lba_range(slba, nlb, ns->id_ns.nsze);
> @@ -938,6 +957,7 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>      uint32_t numdl, numdu;
>      uint64_t off, lpol, lpou;
>      size_t   len;
> +    uint16_t status;
>  
>      numdl = (dw10 >> 16);
>      numdu = (dw11 & 0xffff);
> @@ -953,6 +973,12 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>  
>      trace_pci_nvme_get_log(nvme_cid(req), lid, lsp, rae, len, off);
>  
> +    status = nvme_check_mdts(n, len);
> +    if (status) {
> +        trace_pci_nvme_err_mdts(nvme_cid(req), len);
> +        return status;
> +    }
> +
>      switch (lid) {
>      case NVME_LOG_ERROR_INFO:
>          return nvme_error_info(n, cmd, rae, len, off, req);
> @@ -2275,6 +2301,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
>      id->ieee[0] = 0x00;
>      id->ieee[1] = 0x02;
>      id->ieee[2] = 0xb3;
> +    id->mdts = n->params.mdts;
>      id->ver = cpu_to_le32(NVME_SPEC_VER);
>      id->oacs = cpu_to_le16(0);
>  
> @@ -2394,6 +2421,7 @@ static Property nvme_props[] = {
>      DEFINE_PROP_UINT16("msix_qsize", NvmeCtrl, params.msix_qsize, 65),
>      DEFINE_PROP_UINT8("aerl", NvmeCtrl, params.aerl, 3),
>      DEFINE_PROP_UINT32("aer_max_queued", NvmeCtrl, params.aer_max_queued, 64),
> +    DEFINE_PROP_UINT8("mdts", NvmeCtrl, params.mdts, 7),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index 5519b5cc7686..137cd8c2bf20 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -11,6 +11,7 @@ typedef struct NvmeParams {
>      uint32_t cmb_size_mb;
>      uint8_t  aerl;
>      uint32_t aer_max_queued;
> +    uint8_t  mdts;
>  } NvmeParams;
>  
>  typedef struct NvmeAsyncEvent {
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index 6d0cd588c786..5d7d4679650b 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -85,6 +85,7 @@ pci_nvme_mmio_shutdown_set(void) "shutdown bit set"
>  pci_nvme_mmio_shutdown_cleared(void) "shutdown bit cleared"
>  
>  # nvme traces for error conditions
> +pci_nvme_err_mdts(uint16_t cid, size_t len) "cid %"PRIu16" len %"PRIu64""
>  pci_nvme_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
>  pci_nvme_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry is null or not page aligned: 0x%"PRIx64""
>  pci_nvme_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned: 0x%"PRIx64""
> -- 
> 2.27.0
> 
> 

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>

Thanks,

