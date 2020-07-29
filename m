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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDFCC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 15:30:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88D7C20809
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 15:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwpukaBO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88D7C20809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0o2V-0003e4-PO
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 11:30:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1k0o1V-0002t4-FS; Wed, 29 Jul 2020 11:29:41 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:45073)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1k0o1S-0003m1-FQ; Wed, 29 Jul 2020 11:29:41 -0400
Received: by mail-pl1-x642.google.com with SMTP id k4so11930480pld.12;
 Wed, 29 Jul 2020 08:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=X3H61W4c2GYg8/EycKtMzbbYVaDg6M+QpdBrFYglIBQ=;
 b=RwpukaBO6f9jUlX0T8qAh9yUoPn4T8VJDMi6r+h7jYPJfLKIOUnfLTz8Xav8vY4j6k
 imTsxxcXaP+FdBIDWa7QJLeTxTfxu4S7vaA/ZdsjGQXs1PuQ6ylrrtib74TFPdWoCjdV
 HFxq7BeUhZdh2uXgAtgM7sqHbfRwcPAItFECR5G0ET90ieGjk2527tmU4K+g+5JloONe
 f6JNlEFHDZ+ncCwR2zlAzGE1N8hJ4LV31f9R6dw2o7axtBRYBlZR+AeG/brS+3vAUho3
 xsizAwilerfenWH0zL81ALDoz/er03ed9GXb8k3z0uxA/yaqf5uBSwIL2HZnXCXBiV5L
 hrRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=X3H61W4c2GYg8/EycKtMzbbYVaDg6M+QpdBrFYglIBQ=;
 b=ZR3RBhLRd45iH2QpbxkzHX2Sy+J/izbmt9jC1o849hv8ggS4jhS0XXj8F9r0iajWZW
 H2T8Ge/2wqg4AMqnBAK2+AekkkPsEl5QWjq3BsZ/4Rq87GqDmD1KoOPjk9J9k6/q8MgF
 gDfSsLyWLaS/o8yrpfpMGsZuACwbzAy462d8BnkY2Ypy/BNJneXzBxbxjiqkN3L9ZzDl
 pkr/v9tIF1lw3H05dY9NM03bOQoRyhddUNNtPZG8EpwLJnuEHcduKlogb834+zg8H/pK
 gNrcPUs1BX6LKCMlHIqTaq9gjMR5nFehsKmmiEd2sbW3hjIQEKDxjTl6/OM+Qt/T2BC9
 CZtg==
X-Gm-Message-State: AOAM532q32IpLu5fdV0lDrPdMp0MhEic8YW6yOQL4NR28OuCO6ScvgW5
 nbMqKLX2QVy0WOxHOZyT6AI=
X-Google-Smtp-Source: ABdhPJxA7IpLj1P1tBO6qVLERVXra8m2jODcCvo4zeCXP3udihLIDsR2PxtL/4as+mNMoISqCAhwCw==
X-Received: by 2002:a17:902:b282:: with SMTP id
 u2mr13772918plr.225.1596036576408; 
 Wed, 29 Jul 2020 08:29:36 -0700 (PDT)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id c207sm2784222pfb.159.2020.07.29.08.29.35
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 29 Jul 2020 08:29:36 -0700 (PDT)
Date: Thu, 30 Jul 2020 00:29:34 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH 04/16] hw/block/nvme: remove redundant has_sg member
Message-ID: <20200729152934.GC14876@localhost.localdomain>
References: <20200720113748.322965-1-its@irrelevant.dk>
 <20200720113748.322965-5-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200720113748.322965-5-its@irrelevant.dk>
User-Agent: Mutt/1.11.4 (2019-03-13)
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=minwoo.im.dev@gmail.com; helo=mail-pl1-x642.google.com
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

On 20-07-20 13:37:36, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Remove the has_sg member from NvmeRequest since it's redundant.
> 
> Also, make sure the request iov is destroyed at completion time.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  hw/block/nvme.c | 11 ++++++-----
>  hw/block/nvme.h |  1 -
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index cb236d1c8c46..6a1a1626b87b 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -548,16 +548,20 @@ static void nvme_rw_cb(void *opaque, int ret)
>          block_acct_failed(blk_get_stats(n->conf.blk), &req->acct);
>          req->status = NVME_INTERNAL_DEV_ERROR;
>      }
> -    if (req->has_sg) {
> +
> +    if (req->qsg.nalloc) {

Personally, I prefer has_xxx or is_xxx to check whether the request is
based on sg or iov as an inline function, but 'nalloc' is also fine to
figure out the meaning of purpose here.

>          qemu_sglist_destroy(&req->qsg);
>      }
> +    if (req->iov.nalloc) {
> +        qemu_iovec_destroy(&req->iov);
> +    }
> +

Maybe this can be in a separated commit?

Otherwise, It looks good to me.

Thanks,

