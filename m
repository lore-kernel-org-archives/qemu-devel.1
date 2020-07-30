Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4136C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 10:32:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEF8B2075F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 10:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q4Xv9IkI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEF8B2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k15rM-0001Ej-1j
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 06:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1k15qO-0008VL-9p; Thu, 30 Jul 2020 06:31:24 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:38620)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1k15qM-0005uj-Ki; Thu, 30 Jul 2020 06:31:23 -0400
Received: by mail-pl1-x644.google.com with SMTP id m16so13678520pls.5;
 Thu, 30 Jul 2020 03:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=hgjMgG82sVyUT4YGIHYHAFhNLaYciUAE3+ZVPgxXKUE=;
 b=q4Xv9IkIMFBJrckOZhufhgpWxxIcpsZvrKU5T5biSGwIsHZA2qZBDH0mAmQ4kdQ9gc
 8lYRp/obZ3gTVsltO71Ozb0DHwZloFvCjk+lbL8Rqszo/8gIzMby7AyHCr61vGXKRgLc
 aE02SFQAZTK9OWPe3S2Jc4ondipHKqg6nft063jQMzbbI8k5ReZaaMTUj2+kEA50O9IC
 GcQ9R+JHdmmuCS3RYRGabQYrXNpKRkyuXHBp1MeOa/Rwo+GWoMOsGzUfB/3CqHZ/UKm/
 MaPfkg5ni4PQbIgoowLGyj2sQ/z1g3j/gp0TRDEmtcFZ3FUZIuKN4ZiNxcWx1sclsBY4
 Akhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=hgjMgG82sVyUT4YGIHYHAFhNLaYciUAE3+ZVPgxXKUE=;
 b=LxJzV4GGebJceAk8tcn983IB0z6rslC8psNcsKElX7XSaq/5NFiM6wzMRC5unGBfJg
 t5XrmvNUlFmR9aGWjYmp5fCMetzlMzD4Rz5HZOKMHBzMj67csKfAfiAXYeUJP+PByYo2
 y8KBGwcZO5DHsNotI4zzMjpUOl9tvGkFPHzP24RL/r8ezo88MFJvTYKWjrrBMjGWNL6h
 VS6+ToPW6B+xzdJb6hkby953VfezS5SXF9NzkLDd31vjNf32UT0S3l1ELET3rgjjCgEo
 BbISvplS1oElLVm8RKVP+Lr2rZZRW6f9rS6MYE01qTJIY1WRuJzfrHL7OP8pogcmpJ8X
 oiGQ==
X-Gm-Message-State: AOAM530Rck9VwSW5U5yfh44FwxkYIJi/10iy0Si5jeb+E0mohIzBZSHN
 lyfZYsO0q87ir2ZiVAktSxQ=
X-Google-Smtp-Source: ABdhPJwri/WOJfaTVWYhEhx7E33sHJ8AkSvIdr5Cfsuv6TVNKSvuqJsVAX+52UxzxdscGf75O5Ph7Q==
X-Received: by 2002:a17:90b:f09:: with SMTP id
 br9mr10411005pjb.11.1596105079767; 
 Thu, 30 Jul 2020 03:31:19 -0700 (PDT)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id k4sm2044029pjg.48.2020.07.30.03.31.18
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 30 Jul 2020 03:31:19 -0700 (PDT)
Date: Thu, 30 Jul 2020 19:31:17 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH v2 14/16] hw/block/nvme: consolidate qsg/iov clearing
Message-ID: <20200730103117.5f7pd6cv3vgqh2mx@localhost.localdomain>
References: <20200729220638.344477-1-its@irrelevant.dk>
 <20200729220638.344477-15-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200729220638.344477-15-its@irrelevant.dk>
User-Agent: NeoMutt/20171215
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=minwoo.im.dev@gmail.com; helo=mail-pl1-x644.google.com
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
 Keith Busch <kbusch@kernel.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20-07-30 00:06:36, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Always destroy the request qsg/iov at the end of request use.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/block/nvme.c | 52 ++++++++++++++++++++-----------------------------
>  1 file changed, 21 insertions(+), 31 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 3d7275eae369..045dd55376a5 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -217,6 +217,17 @@ static void nvme_req_clear(NvmeRequest *req)
>      memset(&req->cqe, 0x0, sizeof(req->cqe));
>  }
>  
> +static void nvme_req_exit(NvmeRequest *req)
> +{
> +    if (req->qsg.sg) {
> +        qemu_sglist_destroy(&req->qsg);
> +    }
> +
> +    if (req->iov.iov) {
> +        qemu_iovec_destroy(&req->iov);
> +    }
> +}
> +

Klaus,

What is differences between 'clear' and 'exit' from the request
perspective?

Thanks,

