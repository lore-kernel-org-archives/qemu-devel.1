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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBA0C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 15:53:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EA71207E8
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 15:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7Dc35RJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EA71207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0oOh-0008LM-Qx
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 11:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1k0oNv-0007hw-Lg; Wed, 29 Jul 2020 11:52:51 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:42714)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1k0oNu-00080J-0P; Wed, 29 Jul 2020 11:52:51 -0400
Received: by mail-pl1-x641.google.com with SMTP id q17so11954040pls.9;
 Wed, 29 Jul 2020 08:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=d8s9jWiFQHq+BlQbWewHk6DqjX3SBKIUvmppsVF2oh0=;
 b=e7Dc35RJu8z6JFPnAmN5AwsTgwbyqB5xuh+ybrRFkxMIKqvmVUotpbLSs+3EQhsehD
 fpS2KMfFBhUDko3/qM6Xw2yRLFCFDWfepp+AF54gxoyWgN7fmtXjwTV5vLIlVSo6PcR3
 DtBAxY8rhpxI979HJPTSXVHL08RJ78/mchznHP05jJsMJrT/xaaFA65FE23PWcH/qCuo
 rjpIZhx+76LnS+p8GX04JcgiP0eN5ydjbVBHHkX41DmuMe0dqgjqf3/c4JXn24vj4yb0
 8ZKCQ9X94SSd9C8Y+ReIyKW74Jtr4DN/O5VCYbAtxd8z+bFGDgvvoTdqKvQTFxg/VHh6
 mWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=d8s9jWiFQHq+BlQbWewHk6DqjX3SBKIUvmppsVF2oh0=;
 b=Ih79VUSjllZ1l2VZ3IgS2OO8IEAIpXj2EYbFJ9KBcWYQC+gs+hOxzy1P7gCHl4Vpqd
 cZyBiceSgSW1s/yMQhhTIBlaav+lZ4CNvTfTTbcKYIPV79L7uV7PTnhaYHl6lodTfzfC
 eSF2U309hIQPhtw+V7U+qfIClY5y24N1kJ/iA0PYFTv9xuKB7C4OQMShyJMI3y+qD7Sf
 W4f3OnymVXrE8FYkEzn1ndeaV6I2Jp4CDkl+2V9HFRIi1YXX/yYfRrHUNHbHe3qP7kRf
 k3pZqNlo9aKwSkHYLtTxQAB7QX0GqH5oE+7Y5rTCcLbayossN+dLb0TZ4WDIg/+TThWW
 E3aQ==
X-Gm-Message-State: AOAM530tbMUtlPexrVGyfpTJd6tGjvOu+nh6FJn2YIeCX1XQGk6w9ett
 2ykFMnWKZKbq0gMRr2wXuS0=
X-Google-Smtp-Source: ABdhPJw7FTGefH6j2LGmMwYtkV9NtpOciwhUD3Y0woBIvL21D//JlMGLZBWuxkku3601OWt8sm+9KQ==
X-Received: by 2002:a17:90b:1b11:: with SMTP id
 nu17mr9932258pjb.182.1596037967509; 
 Wed, 29 Jul 2020 08:52:47 -0700 (PDT)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id y11sm3115241pfp.73.2020.07.29.08.52.46
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 29 Jul 2020 08:52:47 -0700 (PDT)
Date: Thu, 30 Jul 2020 00:52:45 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH 07/16] hw/block/nvme: add request mapping helper
Message-ID: <20200729155245.GF14876@localhost.localdomain>
References: <20200720113748.322965-1-its@irrelevant.dk>
 <20200720113748.322965-8-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200720113748.322965-8-its@irrelevant.dk>
User-Agent: Mutt/1.11.4 (2019-03-13)
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=minwoo.im.dev@gmail.com; helo=mail-pl1-x641.google.com
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

Klaus,

On 20-07-20 13:37:39, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Introduce the nvme_map helper to remove some noise in the main nvme_rw
> function.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  hw/block/nvme.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index f1e04608804b..68c33a11c144 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -413,6 +413,15 @@ static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
>      return status;
>  }
>  
> +static uint16_t nvme_map(NvmeCtrl *n, NvmeCmd *cmd, size_t len,
> +                         NvmeRequest *req)

Can we specify what is going to be mapped in this function? like
nvme_map_dptr?

Thanks,

